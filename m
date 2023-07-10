Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCD574D434
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGJLFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjGJLFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:05:21 -0400
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 905F2184;
        Mon, 10 Jul 2023 04:04:45 -0700 (PDT)
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
        by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 36AANNQR019759;
        Mon, 10 Jul 2023 05:23:23 -0500
Received: (from greg@localhost)
        by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 36AANMT7019757;
        Mon, 10 Jul 2023 05:23:22 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From:   "Dr. Greg" <greg@enjellic.com>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: [PATCH 04/13] Add TSEM master header file.
Date:   Mon, 10 Jul 2023 05:23:10 -0500
Message-Id: <20230710102319.19716-5-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230710102319.19716-1-greg@enjellic.com>
References: <20230710102319.19716-1-greg@enjellic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TSEM is designed, from a functional perspective, to be contained
entirely in its own directory.

The tsem.h header file defines the enumeration types, structure
definitions and externally visiable functions that are referenced
by all of the compilation units of the TSEM LSM implementation in
that directory.

The structure and enumeration types are extensively documented
and are the recommended starting point for understanding TSEM
implementation and functionality.

Signed-off-by: Greg Wettstein <greg@enjellic.com>
---
 security/tsem/tsem.h | 1516 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1516 insertions(+)
 create mode 100644 security/tsem/tsem.h

diff --git a/security/tsem/tsem.h b/security/tsem/tsem.h
new file mode 100644
index 000000000000..03915f47529b
--- /dev/null
+++ b/security/tsem/tsem.h
@@ -0,0 +1,1516 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * Copyright (C) 2023 Enjellic Systems Development, LLC
+ * Author: Dr. Greg Wettstein <greg@enjellic.com>
+ *
+ * This is the single include file that documents all of the externally
+ * visible types and functions that are used by TSEM.  This file is
+ * currently organized into four major sections in the following order;
+ *
+ * includes used by all compilation units
+ * CPP definitions
+ * enumeration types
+ * structure definitions
+ * function declarations
+ * inline encapsulation functions.
+ *
+ * Include files that are referenced by more than a single compilation
+ * should be included in this file.  Includes that are needed to
+ * satisfy compilation requirements for only a single file should be
+ * included in the file needing that include.
+ *
+ * Understanding the overall implementation and architecture of TSEM
+ * will be facilitated by reviewing the documentation in this file.
+ */
+
+#include <uapi/linux/in.h>
+#include <uapi/linux/in6.h>
+#include <linux/wait.h>
+#include <linux/kref.h>
+#include <linux/lsm_hooks.h>
+#include <linux/capability.h>
+#include <crypto/hash.h>
+#include <crypto/hash_info.h>
+#include <net/af_unix.h>
+
+/* The capability needed to manage TSEM. */
+#define TSEM_CONTROL_CAPABILITY CAP_ML
+
+/*
+ * The number of 'slots' in the structure magazines that are used to
+ * satisfy modeling of security events that are called in atomic context.
+ */
+#define TSEM_ROOT_MAGAZINE_SIZE	96
+#define TSEM_MAGAZINE_SIZE_INTERNAL 16
+#define TSEM_MAGAZINE_SIZE_EXTERNAL 96
+
+/**
+ * enum tsem_event_type - Ordinal value for a security event.
+ * @TSEM_BPRM_SET_CREDS: Ordinal value for bprm_creds_for_exec.
+ * @TSEM_GENERIC_EVENT: Ordinal value for a generically modeled event.
+ * @TSEM_TASK_KILL: Ordinal value for task kill.
+ * @....: Remainder follows with a similar naming format that has
+ *        TSEM_ prep ended to the raw LSM security hook name.
+ * @TSEM_EVENT_CNT: The final ordinal value is used to define the
+ *		    length of the following arrays that are indexed
+ *		    by the ordinal value of the hook:
+ *
+ * This enumeration is used to designate an ordinal value for each
+ * security event, ie. LSM hook, that TSEM is implementing modeling
+ * for.  This value is used to identify the hook that is either having
+ * its event description being exported to an external Trusted Modeling
+ * Agent (TMA) or modeled by the internal TMA implementation.
+ *
+ * The primary use of this enumeration is to conditionalize code paths
+ * based on the security hook being processed and to index the
+ * tsem_names array and the array that defines the action that is to
+ * be taken in response to an event that generates a permissions
+ * violation.
+ */
+enum tsem_event_type {
+	TSEM_BPRM_SET_CREDS = 1,
+	TSEM_GENERIC_EVENT,
+	TSEM_TASK_KILL,
+	TSEM_TASK_SETPGID,
+	TSEM_TASK_GETPGID,
+	TSEM_TASK_GETSID,
+	TSEM_TASK_SETNICE,
+	TSEM_TASK_SETIOPRIO,
+	TSEM_TASK_GETIOPRIO,
+	TSEM_TASK_PRLIMIT,
+	TSEM_TASK_SETRLIMIT,
+	TSEM_TASK_SETSCHEDULER,
+	TSEM_TASK_GETSCHEDULER,
+	TSEM_TASK_PRCTL,
+	TSEM_FILE_OPEN,
+	TSEM_MMAP_FILE,
+	TSEM_FILE_IOCTL,
+	TSEM_FILE_LOCK,
+	TSEM_FILE_FCNTL,
+	TSEM_FILE_RECEIVE,
+	TSEM_UNIX_STREAM_CONNECT,
+	TSEM_UNIX_MAY_SEND,
+	TSEM_SOCKET_CREATE,
+	TSEM_SOCKET_CONNECT,
+	TSEM_SOCKET_BIND,
+	TSEM_SOCKET_ACCEPT,
+	TSEM_SOCKET_LISTEN,
+	TSEM_SOCKET_SOCKETPAIR,
+	TSEM_SOCKET_SENDMSG,
+	TSEM_SOCKET_RECVMSG,
+	TSEM_SOCKET_GETSOCKNAME,
+	TSEM_SOCKET_GETPEERNAME,
+	TSEM_SOCKET_SETSOCKOPT,
+	TSEM_SOCKET_SHUTDOWN,
+	TSEM_PTRACE_TRACEME,
+	TSEM_KERNEL_MODULE_REQUEST,
+	TSEM_KERNEL_LOAD_DATA,
+	TSEM_KERNEL_READ_FILE,
+	TSEM_SB_MOUNT,
+	TSEM_SB_UMOUNT,
+	TSEM_SB_REMOUNT,
+	TSEM_SB_PIVOTROOT,
+	TSEM_SB_STATFS,
+	TSEM_MOVE_MOUNT,
+	TSEM_SHM_ASSOCIATE,
+	TSEM_SHM_SHMCTL,
+	TSEM_SHM_SHMAT,
+	TSEM_SEM_ASSOCIATE,
+	TSEM_SEM_SEMCTL,
+	TSEM_SEM_SEMOP,
+	TSEM_SYSLOG,
+	TSEM_SETTIME,
+	TSEM_QUOTACTL,
+	TSEM_QUOTA_ON,
+	TSEM_MSG_QUEUE_ASSOCIATE,
+	TSEM_MSG_QUEUE_MSGCTL,
+	TSEM_MSG_QUEUE_MSGSND,
+	TSEM_MSG_QUEUE_MSGRCV,
+	TSEM_IPC_PERMISSION,
+	TSEM_KEY_ALLOC,
+	TSEM_KEY_PERMISSION,
+	TSEM_NETLINK_SEND,
+	TSEM_INODE_CREATE,
+	TSEM_INODE_LINK,
+	TSEM_INODE_UNLINK,
+	TSEM_INODE_SYMLINK,
+	TSEM_INODE_MKDIR,
+	TSEM_INODE_RMDIR,
+	TSEM_INODE_MKNOD,
+	TSEM_INODE_RENAME,
+	TSEM_INODE_SETATTR,
+	TSEM_INODE_GETATTR,
+	TSEM_INODE_SETXATTR,
+	TSEM_INODE_GETXATTR,
+	TSEM_INODE_LISTXATTR,
+	TSEM_INODE_REMOVEXATTR,
+	TSEM_INODE_KILLPRIV,
+	TSEM_TUN_DEV_CREATE,
+	TSEM_TUN_DEV_ATTACH_QUEUE,
+	TSEM_TUN_DEV_ATTACH,
+	TSEM_TUN_DEV_OPEN,
+	TSEM_BPF,
+	TSEM_BPF_MAP,
+	TSEM_BPF_PROG,
+	TSEM_EVENT_CNT
+};
+
+/**
+ * enum tsem_action_type - Ordinal value for security responses.
+ * @TSEM_ACTION_LOG: Ordinal value to indicate that a security event
+ *		     that results in a model permissions violation
+ *		     should be logged.
+ * @TSEM_ACTION_EPERM: Ordinal value to indicate that a security event
+ *		       generating a model permissions violation should
+ *		       return -EPERM to the caller.
+ *
+ * This enumeration type is used to designate what type of action is
+ * to be taken when the processing of a security event hook results in
+ * a model violation.  The TSEM_ACTION_LOG and TSEM_ACTION_EPERM
+ * translate into the classical concepts of logging or enforcing
+ * actions used by other mandatory access control architectures.
+ */
+enum tsem_action_type {
+	TSEM_ACTION_LOG = 0,
+	TSEM_ACTION_EPERM,
+	TSEM_ACTION_CNT
+};
+
+/**
+ * enum tsem_control_type - Ordinal values for TSEM control actions.
+ * @TSEM_CONTROL_INTERNAL: This ordinal value is set when the first
+ *			   word of an argument string written to the
+ *			   control file is the word 'internal'.  This
+ *			   designates that the security namespace will
+ *			   be modeled by the internal TMA.
+ * @TSEM_CONTROL_EXTERNAL: This ordinal value is set when the first
+ *			   word of an argument string written to the
+ *			   control file is the word 'external'.  This
+ *			   designates that the security namespace will
+ *			   be model by an external TMA.
+ * @TSEM_CONTROL_ENFORCE: This ordinal value is set when the word
+ *			  'enforce' is written to the control file.
+ *			  This indicates that model is to be placed
+ *			  in 'enforcing' mode and security events that
+ *			  result in model violations will return EPERM.
+ * @TSEM_CONTROL_SEAL: This ordinal value is set when the word 'seal'
+ *		       is written to the control file.  This indicates
+ *		       that the model for security domain will treat
+ *		       all security events that do not conform to the
+ *		       model as 'forensics' events.
+ * @TSEM_CONTROL_TRUSTED: This ordinal value is used when the first
+ *			  word of an argument string written to the
+ *			  control file is the word 'trusted'.  This
+ *			  is interpreted as a directive to set the
+ *			  trust status of the task that executed the
+ *			  security event to be trusted.
+ * @TSEM_CONTROL_UNTRUSTED: This ordinal value is used when the first
+ *			    word of an argument string written to the
+ *			    control file is the word 'untrusted'.
+ *			    This is interpreted as a directive to set
+ *			    the trust status of the task that executed
+ *			    the security event to be untrusted.
+ * @TSEM_CONTROL_MAP_STATE: This ordinal value is used when the first
+ *			    word of an argument string written to the
+ *			    control file is the word 'state'.  The
+ *			    argument to this directive will be an
+ *			    ASCII hexadecimally encoded string of the
+ *			    current model's digest size that will be
+ *			    treated as a security state point for
+ *			    inclusion in the security model for the
+ *			    security domain/namespace.
+ * @TSEM_CONTROL_MAP_PSEUDONYM: This ordinal value is used when the
+ *				first word of an argument string
+ *				written to the control file is the
+ *				word 'pseudonym'.  The argument to
+ *				this directive will be an ASCII
+ *				hexadecimally encoded string of the
+ *				current model's digest size that will
+ *				be treated as a pseudonym directive
+ *				for the security domain/namespace.
+ * TSEM_CONTROL_MAP_BASE: This ordinal value is used when the first
+ *			  word of an argument string written to the
+ *			  control file is the word 'base'.  The
+ *			  argument to this directive will be an ASCII
+ *			  hexadecimally encoded string of the current
+ *			  model's digest size that will be treated as
+ *			  the base value for the computation of the
+ *			  functional values (measurement and state) of
+ *			  the security domain/namespace.
+
+ * This enumeration type is used to designate what type of control
+ * action is to be implemented when arguments are written to the TSEM
+ * control file (/sys/kernel/security/tsem/control).  The ordinal
+ * values govern the processing of the command and the interpretation
+ * of the rest of the command argument string.
+ */
+enum tsem_control_type {
+	TSEM_CONTROL_INTERNAL = 0,
+	TSEM_CONTROL_EXTERNAL,
+	TSEM_CONTROL_ENFORCE,
+	TSEM_CONTROL_SEAL,
+	TSEM_CONTROL_TRUSTED,
+	TSEM_CONTROL_UNTRUSTED,
+	TSEM_CONTROL_MAP_STATE,
+	TSEM_CONTROL_MAP_PSEUDONYM,
+	TSEM_CONTROL_MAP_BASE
+};
+
+/**
+ * enum tsem_ns_reference - Ordinal value for DAC namespace reference.
+ * @TSEM_NS_INITIAL: This ordinal value indicates that the uid/gid
+ *		     values should be interpreted against the initial
+ *		     user namespace.
+ * @TSEM_NS_CURRENT: This ordinal value indicates that the uid/gid
+ *		     values should be interpreted against the user
+ *		     namespace that is in effect for the process being
+ *		     modeled.
+ *
+ * This enumeration type is used to indicate what user namespace
+ * should be referenced when the uid/gid values are interpreted for
+ * the creation of either the COE or CELL identities.  The enumeration
+ * ordinal passed to the tsem_ns_create() function, to configure the
+ * security domain/namespace, is set by the nsref argument to either
+ * the 'internal' or 'external' control commands.
+ */
+enum tsem_ns_reference {
+	TSEM_NS_INITIAL = 1,
+	TSEM_NS_CURRENT
+};
+
+/**
+ * enum tsem_task_trust - Ordinal value describing task trust status.
+ * @TSEM_TASK_TRUSTED: This ordinal value indicates that the task has
+ *		       not executed a security event that has resulted
+ *		       in a security behavior not described by the
+ *		       security model the task is being governed by.
+ * @TSEM_TASK_UNTRUSTED: This ordinal value indicates that the task
+ *		          has requested the execution of a security event
+ *		          that resulted in a security behavior not
+ *		          permitted by the security model the task is
+ *		          being governed by.
+ * @TSEM_TASK_TRUST_PENDING: This ordinal value indicates that the setting
+ *			     of the task trust status is pending a response
+ *		             from an external TMA.
+ *
+ * This enumeration type is used to specify the three different trust
+ * states that a task can be in.  The trust status of a task is
+ * regulated by the trust_status member of struct tsem_task.  A task
+ * carrying the status of TSEM_TASK_TRUSTED means that it has
+ * not requested the execution of any security events that are
+ * inconsistent with the security model that the task is running in.
+ *
+ * If a task requests execution of a security event that is
+ * inconsistent with the security model it is operating in, and the
+ * domain is running in 'sealed' mode, the task trust status is set to
+ * TSEM_TASK_UNTRUSTED.  This value is 'sticky' in that it will be
+ * propagated to any child tasks that are spawned from an untrusted
+ * task.
+ *
+ * In the case of an externally modeled security domain/namespace, the
+ * task trust status cannot be determined until the modeling of the
+ * security event has been completed.  The tsem_export_event()
+ * function sets the trust status TSEM_TASK_TRUST_PENDING and then
+ * places the task into an interruptible sleep state.
+ *
+ * Only two events will cause the task to be removed from sleep state.
+ * Either the task is killed or a control message is written to the
+ * TSEM control file that specifies the trust status of the task.  See
+ * the description of the TSEM_CONTROL_TRUSTED and
+ * TSEM_CONTROL_UNTRUSTED enumeration types.
+ */
+enum tsem_task_trust {
+	TSEM_TASK_TRUSTED = 1,
+	TSEM_TASK_UNTRUSTED = 2,
+	TSEM_TASK_TRUST_PENDING = 4
+};
+
+/**
+ * enum tsem_inode_state - Ordinal value for inode reference state.
+ * @TSEM_INODE_COLLECTING: This ordinal value indicates that the uid/gid
+ *			   values should be interpreted against the initial
+ *			   user namespace.
+ * @TSEM_INODE_COLLECTED: This ordinal value indicates that the uid/gid
+ *			  values should be interpreted against the user
+ *			  namespace that is in effect for the process being
+ *		          modeled.
+ *
+ * This enumeration type is used to specify the status of the inode
+ * that is having a digest value computed on the file that it is
+ * referencing.  The purpose of this enumeration is so that the
+ * recursive call to the TSEM_FILE_OPEN hook, caused by the kernel
+ * opening the file to compute the checksum, can be bypassed.
+ *
+ * The state value of the inode is carried in struct tsem_inode and is
+ * set and interrogated by the add_file_digest() function.  If the
+ * status of the inode is TSEM_INODE_COLLECTED and the iversion of the
+ * inode is the same as the collection time, the cached value for
+ * currently active model digest is returned.
+
+ * If the test for the relevancy of the cached digest value fails the
+ * status of the inode is set to TSEM_INODE_COLLECTING.  The
+ * tsem_file_open() function will check the inode status when it is
+ * invoked by the integrity_kernel_read() function and if it is
+ * set to 'collecting', a successful permissions check is returned so
+ * that the kernel can open the file and compute its digest.
+ */
+enum tsem_inode_state {
+	TSEM_INODE_COLLECTING = 1,
+	TSEM_INODE_COLLECTED
+};
+
+/**
+ * struct tsem_task - TSEM task control structure.
+ * @tma_for_ns: The context identity number of the namespace that
+ *		the task has control over if any.
+ * @trust_status: The enumeration type that specifies the trust state of
+ *		  the process.
+ * @task_id: The hash specific digest that identifies the process.
+ * @task_key: A hash specific digest value that is used to
+ *	      authenticate a task that is running as a trust
+ *	      orchestrator to a task that is under the control of the
+ *	      orchestrator.
+ * @context: A pointer to the tsem_context structure that defines the
+ *	     modeling context that the task is running under.
+ *
+ * This structure is one of the two primary control structures that
+ * are implemented through the LSM blob functionality.  It is
+ * automatically created when the task control structure is allocated
+ * for a new task that is being created.  It's role is to control the
+ * status of the task with respect to its security model.
+ *
+ * The trust_status member of structure determines whether or not the
+ * task is in a condition to be trusted.  It represents whether or not
+ * the task has requested execution of a security event that is
+ * inconsistent with the model that the task is running under.
+ * Reference the tsem_trust_status enumeration type for more
+ * information on this member.  The trust status value is propagated
+ * to any child tasks that are spawned from a task.
+ *
+ * The digest value that the task_id member contains is generated by
+ * the tsem_tsem_bprm_creds_for_exec() function that computes the
+ * task identity based on the COE identity and the CELL identity of
+ * the executable that is being started.  This task_id value is used
+ * in the computation of the security state point values in
+ * combination with the COE and CELL identities for this event.  The
+ * task_id digest creates security state points that are specific to
+ * the executable file that was used to start the task.
+ *
+ * The task_key member holds the authentication key that will be used
+ * to authenticate a process that is requesting the ability to set the
+ * trust status of a process.  This value is generated for the task
+ * structure of the trust orchestrator when a security modeling
+ * namespace is created by the orchestrator.
+ *
+ * As an additional protection, the creation of a namespace causes the
+ * context id of the created namespace to be placed in the task that
+ * will serve as the trust orchestrator for the namespace.  This
+ * context id must match the context id of a process that a trust
+ * control request is being sent to.  Like the authentication key
+ * this value is not propagated on task allocation so only the task
+ * that has nominated the security modeling namespace will have
+ * possession of the necessary credentials to control it.
+ *
+ * The context member of the structure contains a pointer to the
+ * tsem_context structure allocated when a security modeling namespace
+ * is created by the tsem_ns_create() function.  This structure will
+ * contain all of the information needed to define how the task is to
+ * have its security behavior modeled.
+ */
+struct tsem_task {
+	u64 tma_for_ns;
+	enum tsem_task_trust trust_status;
+	u8 task_id[HASH_MAX_DIGESTSIZE];
+	u8 task_key[HASH_MAX_DIGESTSIZE];
+	struct tsem_context *context;
+};
+
+/**
+ * struct tsem_context - TSEM modeling context description.
+ * @kref: Reference count for the context.
+ * @work: Work structure for delayed release of the context.
+ * @id: The index number of the context.
+ * @sealed: Status variable indicating whether or not the
+ *	    modeling context can be modified.
+ * @use_current_ns: Status variable indicating which user namespace
+ *		    should be used for resolution of uid/gid values.
+ * @actions: An array of enum tsem_action_type variables indicating
+ *	     the type of response that should be returned in
+ *	     response to the modeling of a security event that
+ *	     is inconsistent with the model being used for the
+ *	     security context.
+ * @digestname: A pointer to a null-terminated buffer containing the
+ *		name of the digest function that is to be used for
+ *		this security context.
+ * @zero_digest: The digest value for a 'zero-length' digest value.
+ * @tfm: A pointer to the digest transformation structure that is to
+ *	 be used for this context.
+ * @magazine_size: The number of struct tsem_event structures that
+ *		   are held in reserve for security event hooks that
+ *		   are called in atomic context.
+ * @magazine_lock: The spinlock that protects access to the event
+ *		   magazine for the security context.
+ * @magazine_index: The bitmap that is used to track the magazine slots
+ *		    that have been allocated.
+ * @ws: An array of work structures that are used to refill the magazine
+ *	slots.
+ * @magazine: An array of pointers to struct tsem_event structures that
+ *	      are pre-allocated for security hooks called in atomic
+ *	      context.
+ * @model: If the modeling context is implemented with a kernel based
+ *	   trusted model agent this pointer will point to the struct
+ *	   tsem_model structure that maintains the state of the
+ *	   security model.
+ * @external: If the modeling context is implemented with an external
+ *	      modeling agent this pointer will point to the struct
+ *	      tsem_external structure that implements the interface to
+ *	      the external trusted modeling agent.
+
+ * This structure is used to represent the state of a TSEM security
+ * modeling namespace.  A pointer to this structure is stored in the
+ * struct tsem_task structure.
+ *
+ * This structure is allocated by the tsem_ns_create() function in
+ * response to a TSEM control request.  This structure maintains all
+ * of the information that describes the security modeling namespace
+ * that is not specific to the type of namespace, ie. external or
+ * internal that is being implemented.
+
+ * The id member is a 64-bit counter that cannot feasibly be
+ * overflowed and that is incremented for each namespace creation that
+ * is created.  The root modeling namespace has a value of zero so the
+ * TSEM code uses a pattern of testing this value for non-zero status
+ * as an indication of whether or not the task is running in a
+ * subordinate modeling namespace.
+
+ * Each security modeling namespace can have an independent
+ * cryptographic digest function that is used as the compression
+ * function for generating the digest values that are used to model
+ * the security events that occur in a namespace.  A single struct tfm
+ * is allocated for this digest function at the time that the
+ * tsem_context structure is created and is maintained in this
+ * structure for subsequent use during event processing.
+
+ * Each cryptographic digest function has a 'zero message' value that
+ * is the result of the initialization and closure of a hash function
+ * that has no other input.  This zero digest value is computed at the
+ * time of the creation of the array.  This digest value is returned
+ * for files with zero sizes or that have pseudonyms declared for
+ * them.
+ *
+ * The actions array contains a specification of how each security
+ * event should be handled in the event that the model detects a
+ * security event consistent with the model designated for the
+ * namespace.  This array allows the specification of whether the
+ * model should be enforcing or logging.  Currently the specification
+ * is all or nothing for all of the events, with plans to make the
+ * actions individually configurable.
+
+ * Each security event that is processed requires a struct tsem_event
+ * structure that drives either the internal modeling of an event or
+ * its export to an external modeling agent.  Some security event
+ * hooks are called while a task is running in atomic context. Since
+ * memory cannot be allocated while a process is in atomic context, a
+ * magazine of these structures is maintained by this structure for
+ * security events that run in atomic context.  The size of this
+ * magazine is dynamic and is configurable for each security modeling
+ * namespace that is created.
+ *
+ * When a tsem_event structure is allocated for an atomic event a
+ * request for the refill of the slot that is vacated is dispatched to
+ * an asynchronous workqueue.  The ws member of this structure points
+ * to an array of work structures for this refill capability, one for
+ * each slot in the magazine.
+ *
+ * All of this infrastructure is generic for each security modeling
+ * namespace.  How the security modeling is done is governed by the
+ * model and external members of this structure.  These members point
+ * to data structures that either maintain the security model state
+ * for an in kernel trusted modeling agent or handle the export of the
+ * event to an external trusted modeling agent.
+ *
+ * Each task that is created in a non-root security modeling namespace
+ * increments the reference count maintained in the kref member of
+ * this structure in the tsem_task_alloc() function.  The
+ * tsem_task_free() function decrements this reference count.  When
+ * the reference count expires, ie. when the last task using the
+ * modeling namespace exits, an asynchronous workqueue request is
+ * dispatched to dispose of the context.  The work member of this
+ * structure is used to reference that workqueue request.
+ */
+struct tsem_context {
+	struct kref kref;
+	struct work_struct work;
+
+	u64 id;
+	bool sealed;
+	bool use_current_ns;
+
+	enum tsem_action_type actions[TSEM_EVENT_CNT];
+
+	char *digestname;
+	u8 zero_digest[HASH_MAX_DIGESTSIZE];
+	struct crypto_shash *tfm;
+
+	unsigned int magazine_size;
+	spinlock_t magazine_lock;
+	unsigned long *magazine_index;
+	struct tsem_work *ws;
+	struct tsem_event **magazine;
+
+	struct tsem_model *model;
+	struct tsem_external *external;
+};
+
+/**
+ * struct tsem_model - TSEM internal TMA description.
+ * @have_aggregate: Flag variable to indicate whether or not the
+ *		    hardware aggregate value has been injected into
+ *		    the mode.
+ * @base: The base value that is to be used in computing the
+ *	  measurement and state values of the model.
+ * @measurement: The time dependent linear extension state of the
+ *		 model.
+ * @state: The time independent linear extension state of the model.
+ * @point_lock: The spinlock that protects access to the list of
+ *		security state coefficients in the model.
+ * @point_list: A pointer to the list of security state coefficients
+ *		in the model.
+ * @point_end_mutex: The mutex that is used to protect the end of the
+ *		     list of security state coefficients for the
+ *		     model.
+ * @point_end: A pointer to the end of the list of security state
+ *	       coefficients that will be traversed by a call to the
+ *	       control plane.
+ * @trajectory_lock: The spinlock used to protect the list of security
+ *		     event descriptions in the model.
+ * @trajectory_list: A pointer to the list of descriptions of the
+ *		     security events that have been recorded in this
+ *		     model.
+ * @trajectory_end_mutex: The mutex that protects the end of the list
+ *			  of security event descriptions.
+ * @trajectory_end: A pointer to the end of the list of security event
+ *		    descriptions that will be traversed by a call to
+ *		    the control plane.
+ * @forensics_lock: The spinlock used to protect the list of security
+ *		    event descriptions that are considered invalid by
+ *		    the model being enforced.
+ * @forensics_list: A pointer to the list of descriptions of security
+ *		    events that are considered invalid by the security
+ *		    model being enforced.
+ * @forensics_end_mutex: The mutex that protects the end of the list
+ *			 of security event descriptions that are
+ *			 considered invalid by the current model.
+ * @forensics_end: A pointer to the end of the list of security event
+ *		   descriptions, that are considered invalid, that are
+ *		   to be traversed by a call to the control plane.
+ * @pseudonym_mutex: The mutex lock that protects the list of file
+ *		     digest pseudonyms for the current model.
+ * @pseudonum_list: A pointer to the list of file digest pseudonyms
+ *		    that have been declared for the current model.
+ * @magazine_size: The number of struct tsem_event_point structures that
+ *		   are held in reserve for security event hooks that
+ *		   are called in atomic context.
+ * @magazine_lock: The spinlock that protects access to the event
+ *		   magazine for the security context.
+ * @magazine_index: The bitmap that is used to track the magazine slots
+ *		    that have been allocated.
+ * @ws: An array of work structures that are used to refill the magazine
+ *	slots.
+ * @magazine: An array of pointers to struct tsem_event_point structures that
+ *	      are pre-allocated for security hooks called in atomic
+ *	      context.
+ *
+ * If a call to the tsem_ns_create() function specifies that a kernel
+ * based trusted modeling agent is to be used to implement the
+ * security namespace model, a pointer to this structure is placed in
+ * the struct tsem_context structure.  This structure is used to
+ * maintain the state of the kernel based model.
+ *
+ * There are two primary functional values that are maintained by the
+ * model.  The measurement member of this structure represents the
+ * time dependent linear extension sum of the security state
+ * coefficients that have been assigned to security events that have
+ * occurred in the context of the model.
+ *
+ * This classic integrity measurement is subject to scheduling
+ * dependencies and may be invariant from run to run of the model.  It
+ * is of primary use in verifying the order of security events that
+ * have occurred in the model.
+ *
+ * The state member of this structure represents a time independent
+ * linear extension sum of the security state coefficients that have
+ * been generated in the model.  It represents the linear extension
+ * sum of the security state coefficients that have been sorted in
+ * natural (big-endian) form.
+ *
+ * Both of these measurements are dependent on the platform hardware
+ * aggregate value and the base point that has been defined for the
+ * define.
+ *
+ * A non-zero hardware aggregate value is only available if the
+ * platform has a TPM.  The have_aggregate member of this structure is
+ * a flag variable that indicates whether or not the aggregate value
+ * has been injected into the model.
+ *
+ * The base member of this structure contains a model specific
+ * coefficient that is used to perturb each security state coefficient
+ * generated in the model.  This value is designed to serve as a
+ * 'freshness' value for a verifying party to the model.
+ *
+ * There are three primary model lists maintain by this structure:
+ *
+ * * security state points
+ * * security trajectory events
+ * * security forensics events
+ *
+ * Similar members are maintained in this structure to support each of
+ * these lists.
+ *
+ * All three lists are extension only and are protected by a spinlock
+ * that can be held in atomic context.  This spinlock is only held for
+ * the period of time required to extend the list.
+ *
+ * Calls by the control plane to interrogate the lists require the
+ * traversal of the list that is ill-suited for a spinlock.  As a
+ * result each list type has a mutex associated with it that protects
+ * a pointer to the end of the list, an endpoint that is determined at
+ * the start of a call to the control plane.
+ *
+ * The list spinlock is used at the start of the control plane call to
+ * capture the end of the list that is then protected by the mutex.
+ * In essence this is used to transition protection of the list from
+ * the spinlock to the mutex.
+ *
+ * The kernel based modeling agent has support for maintaining a
+ * constant digest value for files, that by function, do not have a
+ * fixed digest value, such as log files.  The pseudonym_list member
+ * of this structure points to the list of these designations.  The
+ * pseudonym_mutex structure protects this list.
+ *
+ * Like the struct tsem_context structure the tsem_model structure
+ * maintains a magazine of structures that are used to service
+ * security events that are called in atomic context.  The magazine
+ * maintained by this structure is a list of struct tsem_event_point
+ * structures that are used to describe the security state
+ * coefficients held by the model.
+ *
+ * The description of struct tsem_context details the implementation
+ * of the magazine which is identical to the implementation for this
+ * structure, with the exception of the type of structures that are
+ * held in reserve.
+ */
+struct tsem_model {
+	bool have_aggregate;
+
+	u8 base[HASH_MAX_DIGESTSIZE];
+	u8 measurement[HASH_MAX_DIGESTSIZE];
+	u8 state[HASH_MAX_DIGESTSIZE];
+
+	spinlock_t point_lock;
+	struct list_head point_list;
+	struct mutex point_end_mutex;
+	unsigned int point_count;
+	struct list_head *point_end;
+
+	spinlock_t trajectory_lock;
+	struct list_head trajectory_list;
+	struct mutex trajectory_end_mutex;
+	struct list_head *trajectory_end;
+
+	spinlock_t forensics_lock;
+	struct list_head forensics_list;
+	struct mutex forensics_end_mutex;
+	struct list_head *forensics_end;
+
+	struct mutex pseudonym_mutex;
+	struct list_head pseudonym_list;
+
+	unsigned int magazine_size;
+	spinlock_t magazine_lock;
+	unsigned long *magazine_index;
+	struct tsem_work *ws;
+	struct tsem_event_point **magazine;
+};
+
+/**
+ * struct tsem_external - TSEM external TMA description.
+ * @export_lock: The spinlock that protects access to the export_list
+ *		 member of this structure.
+ * @export_list: A pointer to the list of events waiting to be
+ *		 exported to the trust orchestrator for the security
+ *		 modeling namespace.  The structure type that is
+ *		 linked by this list is the struct export_event
+ *		 structure that is private to the export.c compilation
+ *		 unit.
+ * @dentry: A pointer to the dentry describing the pseudo-file in the
+ *	    /sys/kernel/security/tsem/ExternalTMA directory that is
+ *	    being used to export security event descriptions to the
+ *	    external trust orchestrator for the security modeling
+ *	    domain described by this structure.
+ * @have_event: A flag variable to indicate that there is work queued
+ *		on the export pseudo-file for the security modeling
+ *		namespace.
+ * @wq: The work queue used to implement polling for the security
+ *	event export file for the security modeling namespace.
+ * @magazine_size: The number of struct export_event structures that
+ *		   are held in reserve for security event hooks that
+ *		   are called in atomic context.
+ * @magazine_lock: The spinlock that protects access to the event
+ *		   magazine for the security modeling domain.
+ * @magazine_index: The bitmap that is used to track the magazine slots
+ *		    that have been allocated.
+ * @ws: An array of work structures that are used to refill the magazine
+ *	slots.
+ * @magazine: An array of pointers to struct export_event structures that
+ *	      are pre-allocated for security hooks called in atomic
+ *	      context.
+ *
+ * If an externally modeled security modeling namespace is created
+ * a structure of this type is allocated for the namespace and placed
+ * in the struct tsem_context structure.
+ *
+ * The primary purpose of this structure is to manage event
+ * descriptions that are being transmitted to the trust orchestrator
+ * associated with the security modeling namespace.  The pseudo-file
+ * will be as follows:
+ *
+ * /sys/kernel/security/tsem/ExternalTMA/N
+ *
+ * Where N is the context id number of the modeling namespace.
+ *
+ * The dentry member of this structure is used to represent the
+ * pseudo-file that is created when the external modeled namespace is
+ * created.
+ *
+ * This list of events waiting to be received by the trust
+ * orchestrator is maintained in the export_list member of this
+ * structure.  Additions or removals from the list hold the spinlock
+ * described by the export_lock member of this structure.
+ *
+ * The wq member of this structure is used to implement a workqueue
+ * to support polling for events on the export control file.  The
+ * have_event flag is set to indicate to the polling call that
+ * security events are available for export.
+ *
+ * When a security event description is exported the calling task is
+ * scheduled away to allow the trust orchestrator to process the
+ * event.  This obviously creates issues for security events that are
+ * called in atomic context.
+ *
+ * Security events in atomic context are exported as an async_event
+ * rather than a simple event.  The trust orchestrator has the option
+ * of killing the workload that deviated from the security model or
+ * signaling a violation of the model.
+ *
+ * To support the export of asynchronous events a magazine, similar to
+ * the event and model structure magazines, is maintained by this
+ * structure for the external modeling namespace.
+ */
+struct tsem_external {
+	spinlock_t export_lock;
+	struct list_head export_list;
+	struct dentry *dentry;
+	bool have_event;
+	wait_queue_head_t wq;
+
+	unsigned int magazine_size;
+	spinlock_t magazine_lock;
+	unsigned long *magazine_index;
+	struct tsem_work *ws;
+	struct export_event **magazine;
+};
+
+/**
+ * struct tsem_work - TSEM magazine refill work structure.
+ * @index: The index number of the slot in the structure magazine that
+ *	   is being refilled.
+ * @u: A union that holds pointers to the structure whose magazine is
+ *     being refilled.
+ * @work: The work structure that manages the workqueue being used to
+ *	  refill the magazine entry.
+ *
+ * As has been previously documented for the struct tsem_context,
+ * struct tsem_model and struct tsem_external structures, there is a
+ * need to maintain a magazine of these structures in order to allow
+ * the processing of security events that are called in atomic
+ * context.  An array of this structure type is embedded in each of
+ * these structures to manage the asynchronous refill of the slot in
+ * the magazine that was used to handle an atomic security event.
+ *
+ * The index member of this structure points to the slot in the
+ * magazine that this work item is referencing.
+ *
+ * The structure that the refill work is being done for is maintained
+ * in the respective structure pointer in the u member of this
+ * structure.
+ *
+ * The work member of this structure is used to reference the
+ * asynchronous work request that is being submitted for the refill.
+ */
+struct tsem_work {
+	unsigned int index;
+	union {
+		struct tsem_context *ctx;
+		struct tsem_model *model;
+		struct tsem_external *ext;
+	} u;
+	struct work_struct work;
+};
+
+/**
+ * struct tsem_COE - TSEM context of execution definition structure.
+ * @uid: The numeric user identity that the COE is running with.
+ * @euid: The effective user identity that the COE is running with.
+ * @suid: The saved user identity possessed by the COE.
+ * @gid: The group identity that the COE is running with.
+ * @egid: The effective group identity that the COE possesses.
+ * @sgid: The saved group identity of the COE.
+ * @fsuid: The filesystem user identity that the COE is running with.
+ * @fsgid: The filesystem group identity that the COE is running with.
+ * @capeff: This union is used to implement access to the effective
+ *	    capability set the COE is running with.  The mask value
+ *	    is used to assign to the structure with the value member
+ *	    used to extract the 64 bit value for export and
+ *	    computation.
+ *
+ * A security state coefficient is computed from two primary entities:
+ * the COE and the CELL identities.  This structure is used to carry
+ * and encapsulate the characteristics of the context of execution
+ * (COE) that will be used to generate the COE identity.
+ *
+ * The numeric values for discretionary access controls, ie. uid, gid,
+ * are determined by which user namespace the security modeling
+ * namespace is configured to reference.  The reference will be either
+ * the initial user namespace or the user namespace that the context
+ * of execution is running in.
+ */
+struct tsem_COE {
+	uid_t uid;
+	uid_t euid;
+	uid_t suid;
+
+	gid_t gid;
+	gid_t egid;
+	gid_t sgid;
+
+	uid_t fsuid;
+	gid_t fsgid;
+
+	union {
+		kernel_cap_t mask;
+		u64 value;
+	} capeff;
+};
+
+/**
+ * struct tsem_COE - TSEM file description.
+ * @uid: The numeric user identity of the file.
+ * @gid: The numeric group identity of the file.
+ * @mode: The discretionary access mode for the file.
+ * @flags: The file control flags.
+ * @name_length: The length of the pathname of the file.
+ * @name: The digest value of the pathname of the file using the
+ *	  hash function defined for the security modeling namespace.
+ * @s_magic: The magic number of the filesystem that the file resides
+ *	     in.
+ * @s_id: The name of the block device supporting the filesystem.
+ * @s_uuid: The uuid of the filesystem that the file resides in.
+ * @digest: The digest value of the contents of the file using the
+ *	    hash function defined for the security modeling namespace.
+ *
+ * This structure and the structures that follow up to the struct
+ * tsem_event structure are used to identify the various entities that
+ * are involved in the definition of the CELL identity for a security
+ * event.
+ *
+ * The tsem_file structure is used to encapsulate the characteristics
+ * of a file that is used as an entity in the CELL definition of an
+ * event.
+ *
+ * Since a pathname can be up to PATH_MAX (4096 bytes) in length the
+ * cryptographic digest value is used rather than the pathname of the
+ * file itself.
+ */
+struct tsem_file {
+	uid_t uid;
+	gid_t gid;
+	umode_t mode;
+	u32 flags;
+
+	u32 name_length;
+	u8 name[HASH_MAX_DIGESTSIZE];
+
+	u32 s_magic;
+	u8 s_id[32];
+	u8 s_uuid[16];
+
+	u8 digest[HASH_MAX_DIGESTSIZE];
+};
+
+/**
+ * struct tsem_COE - TSEM memory mapped file characteristics.
+ * @file: The struct file definition for the file that is being
+ *	  mapped.  This pointer will be null in the case of an
+ *	  anonymous mapping.
+ * @anonymous: A flag variable to indicate whether or not the mapping
+ *	       is file backed or anonymous.
+ * @reqprot: The memory protection flags that are requested by the
+ *	     memory mapping system call.
+ * @prot: The protections that will be applied to the mapping.
+ * @flags: The control flags of the memory mapping call.
+ *
+ * This structure is used to encapsulate the arguments provided to the
+ * tsem_mmap_file security event handler.
+ */
+struct tsem_mmap_file_args {
+	struct file *file;
+	u32 anonymous;
+	u32 reqprot;
+	u32 prot;
+	u32 flags;
+};
+
+/**
+ * struct tsem_socket_create_args - TSEM socket creation arguments.
+ * @family: The family name of the socket whose creation is being
+ *	    requested.
+ * @type: The type of the socket being created.
+ * @protocol: The protocol family of the socket being created.
+ * @kern: A flag variable to indicate whether or not the socket being
+ *	  created is kernel or userspace based.
+ *
+ * This structure is used to encapsulate the arguments provided to the
+ * tsem_socket_create security event handler.
+ */
+struct tsem_socket_create_args {
+	int family;
+	int type;
+	int protocol;
+	int kern;
+};
+
+/**
+ * struct tsem_socket_connection_args - TSEM socket connection arguments.
+ * @tsip: A pointer to the struct tsem_inode structure that describes
+ *	  the TSEM inode characteristics of the inode representing
+ *	  the socket.
+ * @addr: A pointer to the structure describing the socket address
+ *	  that is being connected.
+ * @addr_len: The length of the socket address description structure.
+ * @family: The family number of the socket.
+ *
+ * @protocol: The protocol family of the socket being created.
+ * @kern: A flag variable to indicate whether or not the socket being
+ *	  created is kernel or userspace based.
+ * @u: A union that is used to hold the family specific address
+ *     characteristics of the socket connection.
+ * @u.ipv4: If the connection is IPV4 based this structure will be
+ *	    populated with the IPV4 address information.
+ * @u.ipv6: If the connection is IPV6 based this structure will be
+ *	    populated with the IPV6 address information.
+ * @u.path: If the socket connection is an AF_UNIX based socket
+ *	    address this buffer will contain the pathname of the
+ *	    socket address.
+ * @u.mapping: If the socket represents an address protocol other
+ *	       than IPV4, IPV6 or UNIX domain this buffer will contain
+ *	       the cryptographic value of the socket address
+ *	       information using the hash function that has been
+ *	       specified for the security modeling namespace.
+ *
+ * This structure is used to encapsulate the arguments provided to the
+ * tsem_socket_create security event handler.
+ */
+struct tsem_socket_connect_args {
+	struct tsem_inode *tsip;
+	struct sockaddr *addr;
+	int addr_len;
+	u16 family;
+	union {
+		struct sockaddr_in ipv4;
+		struct sockaddr_in6 ipv6;
+		char path[UNIX_PATH_MAX + 1];
+		u8 mapping[HASH_MAX_DIGESTSIZE];
+	} u;
+};
+
+/**
+ * struct tsem_socket_accept_args - TSEM socket accept parameters.
+ * @family: The socket family identifier for the connection being
+ *	    accepted.
+ * @type: The type of socket connection being accepted.
+ * @port: The port number of the connection being accepted.
+ * @ipv4: The IPV4 address of the connection being accepted if the
+ *	  socket is representing an IPV4 connection
+ * @ipv6: The IPV6 address of the connection being accepted if the
+ *	  socket is representing an IPV6 connection.
+ * @af_unix: The UNIX domain socket address if the socket is
+ *	     representing a UNIX domain connection.
+ * @path: The pathname of the UNIX domain socket.
+ * @mapping: A cryptographic hash of description of the socket
+ *	     connection being accepted if the socket is representing
+ *	     a connection other than an IPV4, IPV6 or UNIX domain
+ *	     socket.
+ *
+ * This structure is used to encapsulate the arguments provided to the
+ * tsem_socket_accept security event handler.
+ */
+struct tsem_socket_accept_args {
+	u16 family;
+	u16 type;
+	__be16 port;
+	union {
+		__be32 ipv4;
+		struct in6_addr ipv6;
+		struct unix_sock *af_unix;
+		char path[UNIX_PATH_MAX + 1];
+		u8 mapping[HASH_MAX_DIGESTSIZE];
+	} u;
+};
+
+/**
+ * struct tsem_task_kill_args - TSEM task kill arguments.
+ * @cross_model: A flag variable used to indicate whether or not the
+ *		 signal is originating from a security modeling
+ *		 namespace other than the namespace of the target process.
+ * @signal: The number of the signal being sent.
+ * @source: The task identifier of the process sending the signal
+ * @target: The task identifier of the target process.
+ *
+ * This structure is used to encapsulate the arguments provided to the
+ * tsem_task_kill security event handler.
+ */
+struct tsem_task_kill_args {
+	u32 cross_model;
+	u32 signal;
+	u8 source[HASH_MAX_DIGESTSIZE];
+	u8 target[HASH_MAX_DIGESTSIZE];
+};
+
+/**
+ * struct tsem_event - TSEM security event description.
+ * @index: The index number of the slot in the structure magazine that
+ *	   is being refilled.
+ * @u: A union that holds pointers to the structure whose magazine is
+ *     being refilled.
+ * @work: The work structure that manages the workqueue being used to
+ *	  refill the magazine entry.
+ * @event: The enumeration type describing the security event that the
+ *	   structure is defining.
+ * @locked: A boolean flag used to indicate whether or not the
+ *	    security event is running in atomic context.
+ * @pid: The process id number, in the global pid namespace, of the
+ *	 task that is requesting approval for a security event.
+ * @pathname: If the event is referencing a file this pointer will
+ *	      point to a null-terminated buffer containing the
+ *	      pathname to the file in the mount namespace that the
+ *	      process is running in.
+ * @comm: A pointer to a null terminated buffer containing the name of
+ *	  the process that is requesting the security event.
+ * @digestsize: The size in bytes of the cryptographic hash function
+ *		that is being used in the namespace in which the event
+ *		is being recorded.
+ * @task_id: The TSEM task identifier of the process that generated the
+ *	     security event described by an instance of this
+ *	     structure.
+ * @mapping: The security state coefficient that the event described
+ *	     by this structure generates.
+ * @COE: The struct tsem_COE structure that describes the Context Of
+ *	 Execution that generated the event described by this
+ *	 structure.
+ * @file: If the security event references a file this structure will
+ *	  contain the struct tsem_file structure that describes the
+ *	  characteristics of the file.
+ * @CELL: The CELL union is used to hold the data structures that
+ *	  characterize the CELL identity of the event.
+ * @CELL.event_type: In the case of a generically modeled event this
+ *		     member will contain the enumeration value
+ *		     identifying the event.
+ * @CELL.mmap_file: The structure describing the characteristics of
+ *		    a mmap_file security event.
+ * @CELL.socket_create: The structure describing the characteristics
+ *			of a socket_create security event.
+ * @CELL.socket_connect: The structure describing the characteristics
+ *			 of a socket_connect security event.
+ * @CELL.socket_accept: The structure describing the characteristics
+ *			of a socket accept security event.
+ * @CELL.task_kill: The structure describing the characteristics of a
+ *		    task_kill security event.
+ *
+ * This structure is the primary data structure for describing
+ * security events that are registered in a security modeling
+ * namespace.  Each unique security coefficient in the namespace will
+ * have one of these structures attached to it.
+ *
+ * This structure encapsulates the following three major sources of
+ * information about the event:
+ *
+ * * A description of the process initiating the event.
+ * * The characteristics that form the COE identity of the event.
+ * * The characteristics that form the CELL identity of the event.
+ *
+ * Since one event description has to ultimately characterize any
+ * security event that can occur the strategy is to use a union that
+ * contains security event specific structures that describe the
+ * characteristics of the event.
+ *
+ * The kref member of this structure is used to signal when the
+ * structure is to be deleted.  For example, in the case of an
+ * externally modeled event, when the export of the event description
+ * is complete.  In the case of an internally modeled namespace the
+ * structure will be released if it represents a security state
+ * coefficient that is already present in the model.
+ *
+ * The work member of this structure is used to support asynchronous
+ * updates to a TPM for the root modeling domain.  Asynchronous
+ * updates are used to improve the performance of modeling and to
+ * handle security events that are running in atomic context and
+ * cannot be scheduled away while the TPM transaction completes.
+ *
+ * The tsem_event_allocate() function is called by a TSEM security
+ * event handler to allocate and populate this structure.  The struct
+ * tsem_event_parameters structure is used to encapsulate all of the
+ * different structure types that are needed to characterize all of
+ * the different security events that occur.
+ *
+ * The tsem_event_allocate() function is called by either the
+ * tsem_map_event() or tsem_map_event_locked() functions.  After
+ * allocating and populating an event description structure the
+ * mapping functions generate a security state coefficient from the
+ * information in this structure.
+ *
+ * The two separate function call points for mapping are to allow the
+ * security event handlers to indicate the context in which the
+ * security event is occurring, ie. sleeping or atomic context.  After
+ * this point the context of the security event is represented by the
+ * locked member of this structure.
+ *
+ * After the event is mapped this structure is either passed to the
+ * internal trusted modeling agent or the contents of this structure
+ * is exported to the trust orchestrator attached to the namespace for
+ * modeling by an external trust modeling agent.
+ */
+struct tsem_event {
+	struct kref kref;
+	struct list_head list;
+	struct work_struct work;
+
+	enum tsem_event_type event;
+	bool locked;
+	pid_t pid;
+	char *pathname;
+	char comm[TASK_COMM_LEN];
+
+	unsigned int digestsize;
+	u8 task_id[HASH_MAX_DIGESTSIZE];
+	u8 mapping[HASH_MAX_DIGESTSIZE];
+
+	struct tsem_COE COE;
+	struct tsem_file file;
+
+	union {
+		u32 event_type;
+		struct tsem_mmap_file_args mmap_file;
+		struct tsem_socket_create_args socket_create;
+		struct tsem_socket_connect_args socket_connect;
+		struct tsem_socket_accept_args socket_accept;
+		struct tsem_task_kill_args task_kill;
+	} CELL;
+};
+
+/**
+ * struct tsem_event_parameters - Security event argument descriptions
+ * @u: A union that encapsulates all of the different structures that
+ *     are used to characterize the argument so the TSEM security
+ *     event handlers.
+ * @u.event_type: This structure member holds the enum tsem_event_type
+ *		  enumeration value of the event whose characteristics
+ *		  are encapsulated in the function.
+ * @u.file: If the security event references a VFS file this member
+ *	    hold a pointer to the description of the file.
+ _file event.
+ * @u.socket_create: This member will point to a structure that
+ *		     describes the characteristics of a socket_create
+ *		     event.
+ * @u.socket_connect: This member will point to a structure that
+ *		      describes the characteristics of a socket_connect
+ *		      event.
+ * @u.socket_accept: This member will point to a structure that
+ *		     describes the characteristics of a socket_accept
+ *		     event.
+ * @u.task_kill: This member will point to a structure that describes
+ *		     the characteristics of a task_kill function.
+ *
+ * The purpose of this structure is to provide a common encapsulation
+ * method for passing the CELL characteristics of a security event
+ * into the tsem_event_init() function.  The characteristics passed in
+ * this event will be used to create and populate the struct
+ * tsem_event structure that will go on to be used to characterize
+ * the event either an internal or external modeling agent.
+ *
+ * The strategy followed is to allocate one of these structures on the
+ * stack for a security event call along with a call specific
+ * characteristics description structure, both of which will no longer
+ * be needed after completion of the call since the requisite
+ * information has been transferred to a struct tsem_event structure.
+ */
+struct tsem_event_parameters {
+	union {
+		u32 event_type;
+		struct file *file;
+		struct tsem_mmap_file_args *mmap_file;
+		struct tsem_socket_create_args *socket_create;
+		struct tsem_socket_connect_args *socket_connect;
+		struct tsem_socket_accept_args *socket_accept;
+		struct tsem_task_kill_args *task_kill;
+	} u;
+};
+
+/**
+ * struct tsem_event_point - TSEM security coefficient characteristics.
+ * @list: The list structure used to link together all of the security
+ *	  state coefficients for a modeling namespace.
+ * @valid: A boolean value use to indicate whether or not the security
+ *	   state point is a valid coefficient in the model.
+ * @count: The number of times this coefficient has been expressed by
+ *	   security model for the namespace.
+ * @point: The security state coefficient for the point created by
+ *	   the cryptographic hash function being used for the modeling
+ *	   namespace.
+ *
+ * This structure is used by internal trusted modeling agents to
+ * represent each unique state point in a security model.  Security
+ * state coefficients are unique within a model so only one struct
+ * tsem_event_point structure will be generated regardless of how many
+ * times the security event that generates the point occurs.  The
+ * count member of this structure represents the total number of
+ * security events that have occurred that have generated the point.
+ *
+ * The valid member of this structure is used to flag whether this
+ * is consistent with the model for the namespace or was generated by
+ * a 'forensic', ie. out of model, event.
+ *
+ * Within each security namespace these structures are linked together
+ * in a list that describes the functional value of the security model
+ * assigned to the namespace.  Entries are only added to this list and
+ * never removed.
+ *
+ * The desired state of a security model is created by using the TSEM
+ * control plane to inject a list of acceptable security state
+ * coefficients into the model.  Sealing a model causes any security
+ * events that produce a coefficient different from those already in
+ * the model to be rejected as an invalid security event and logged as
+ * a forensic event for the model.
+ */
+struct tsem_event_point {
+	struct list_head list;
+	bool valid;
+	u64 count;
+	u8 point[HASH_MAX_DIGESTSIZE];
+};
+
+/**
+ * struct tsem_inode - TSEM inode status structure.
+ * @mutex: The mutex that will protect the list of struct
+ *	   tsem_inode_digest structures that have been created for the
+ *	   inode containing a struct tsem_inode structure.
+ * @list: The list structure that points to the list of struct
+ *	  tsem_inode_structures.
+ * @status: The digest collection state of the inode.  See the
+ *	    discussion of enum tsem_inode_state for what information
+ *	    is conveyed by the value of this structure member.
+
+ * This structure is the second of the two primary control structures
+ * that are implemented through the LSM blob functionality.  It is
+ * automatically created when the inode structure is created for
+ * system resources that are referenced by a struct inode structure.
+ *
+ * This structure has two primary purposes.  The status member is used
+ * to signal that the tsem_file_open() function should return that
+ * permission to access the file is returned when the security hook is
+ * invoked by the integrity_kernel_read() function.  See the
+ * discussion on enum tsem_inode_state to more details.
+ *
+ * The second purpose of this structure is to maintain a list of
+ * digest values that have been computed by the inode that this
+ * structure references.  Maintenance of multiple digest values is
+ * required since there is no concept of a fixed digest function for
+ * TSEM as each modeling namespace can have its own digest function.
+ *
+ * Each digest value in use has a struct tsem_inode_digest structure
+ * allocated for it.  The digest_list member of this structure points
+ * to a list of these structures.
+ *
+ * The mutex implemented in this structure should be held by any
+ * process that is accessing the list.
+ */
+struct tsem_inode {
+	struct mutex mutex;
+	struct list_head digest_list;
+	enum tsem_inode_state status;
+};
+
+/**
+ * struct tsem_inode_digest - Digest specific file checksum.
+ * @list:	The list structure used to link multiple digest values
+ *		for an inode.
+ * @version:	The version number of the inode that generated the digest
+ *		value that is currently represented.
+ * @name:	A pointer to a null-terminated character buffer containing
+ *		the name of the hash function that generated the current
+ *		digest value.
+ * @value:	The digest value of the file.
+ *
+ * A linked list of these structures is maintained for each inode that
+ * is modeled by TSEM and is used to support multiple hash specific
+ * digest values for a file represented by the inode.  The tsem_inode
+ * structure that represents the TSEM security status of the inode
+ * contains the pointer to this list of structures.
+ *
+ * The version member of the structure contains the inode version number
+ * that was in effect when the last digest value of this type was computed.
+ * This version number value is used to detect changes and to trigger an
+ * update of the digest value.
+ *
+ * The name member of structure contains the name of the hash function
+ * that generated the checksum value.  This name is used to locate the
+ * correct structure by comparing its value against the hash function
+ * that is being used for the modeling domain that is accessing the
+ * inode.
+ */
+struct tsem_inode_digest {
+	struct list_head list;
+	char *name;
+	u64 version;
+	u8 value[HASH_MAX_DIGESTSIZE];
+};
+
+/*
+ * The following three variables are the only globally visible
+ * variables used in the TSEM implementation.
+ *
+ * The tsem_blob_sizes variable is used by the LSM infrastructure to
+ * describe the amount of space that will be needed by the struct
+ * tsem_task and struct tsem_inode structures.
+ *
+ * The tsem_names array is defined in the tsem.c file and contains an
+ * array of pointers to the strings that define the names for each of
+ * the TSEM security event handles.  The enum tsem_event_type
+ * enumeration indexes this array.
+ *
+ * The tsem_root_actions array is also indexed by the enum
+ * tsem_event_type enumeration and is used to determine the type of
+ * response that a TSEM security event handler is to return to the
+ * caller, ie. either logging or enforcing.  The contents of this
+ * array is inherited by copying the array into the struct
+ * tsem_context structure for modeling namespaces that are subordinate
+ * to the root model.
+ */
+extern struct lsm_blob_sizes tsem_blob_sizes;
+extern const char * const tsem_names[TSEM_EVENT_CNT];
+extern enum tsem_action_type tsem_root_actions[TSEM_EVENT_CNT];
+
+/*
+ * The following section of the file contains the definitions for the
+ * externally visible functions in each of the TSEM compilation units.
+ */
+extern struct dentry *tsem_fs_create_external(const char *name);
+extern void tsem_fs_show_trajectory(struct seq_file *c, struct tsem_event *ep);
+extern void tsem_fs_show_field(struct seq_file *c, const char *field);
+extern void tsem_fs_show_key(struct seq_file *c, char *term, char *key,
+			     char *fmt, ...);
+extern int tsem_fs_init(void);
+
+extern struct tsem_model *tsem_model_allocate(size_t size);
+extern void tsem_model_free(struct tsem_context *ctx);
+extern int tsem_model_event(struct tsem_event *ep);
+extern int tsem_model_load_point(u8 *point);
+extern int tsem_model_load_pseudonym(u8 *mapping);
+extern int tsem_model_has_pseudonym(struct tsem_inode *tsip,
+				    struct tsem_file *ep);
+extern void tsem_model_load_base(u8 *mapping);
+extern int tsem_model_add_aggregate(void);
+extern void tsem_model_compute_state(void);
+extern void tsem_model_magazine_free(struct tsem_model *model);
+extern int tsem_model_cache_init(struct tsem_model *model, size_t size);
+
+extern void tsem_ns_put(struct tsem_context *ctx);
+extern int tsem_ns_event_key(u8 *task_key, const char *keystr, u8 *key);
+extern int tsem_ns_create(const enum tsem_control_type type,
+			  const char *digest, const enum tsem_ns_reference ns,
+			  const char *key, const unsigned int cache_size);
+
+extern int tsem_export_show(struct seq_file *m, void *v);
+extern int tsem_export_event(struct tsem_event *ep);
+extern int tsem_export_action(enum tsem_event_type event, bool locked);
+extern int tsem_export_aggregate(void);
+extern int tsem_export_magazine_allocate(struct tsem_external *ext,
+					 size_t size);
+extern void tsem_export_magazine_free(struct tsem_external *ext);
+extern int tsem_export_cache_init(void);
+
+extern int tsem_map_task(struct file *file, u8 *mapping);
+struct tsem_event *tsem_map_event(enum tsem_event_type event,
+				  struct tsem_event_parameters *param);
+struct tsem_event *tsem_map_event_locked(enum tsem_event_type event,
+					 struct tsem_event_parameters *param);
+
+extern struct tsem_event *tsem_event_allocate(bool locked);
+extern struct tsem_event *tsem_event_init(enum tsem_event_type event,
+					  struct tsem_event_parameters *params,
+					  bool locked);
+extern void tsem_event_put(struct tsem_event *ep);
+extern void tsem_event_get(struct tsem_event *ep);
+extern int tsem_event_magazine_allocate(struct tsem_context *ctx, size_t size);
+extern void tsem_event_magazine_free(struct tsem_context *ctx);
+extern int tsem_event_cache_init(void);
+
+extern u8 *tsem_trust_aggregate(void);
+extern int tsem_trust_add_event(struct tsem_event *ep);
+
+/*
+ * The remaining inline function declarations follow the design
+ * pattern of the other LSM's and implement functions that return
+ * various TSEM characteristics of tasks, modeling contexts and
+ * inodes.
+ */
+static inline struct tsem_task *tsem_task(struct task_struct *task)
+{
+	return task->security + tsem_blob_sizes.lbs_task;
+}
+
+static inline bool tsem_task_trusted(struct task_struct *task)
+{
+	return tsem_task(task)->trust_status & TSEM_TASK_TRUSTED;
+}
+
+static inline bool tsem_task_untrusted(struct task_struct *task)
+{
+	return tsem_task(task)->trust_status & ~TSEM_TASK_TRUSTED;
+}
+
+static inline struct tsem_context *tsem_context(struct task_struct *task)
+{
+	return tsem_task(task)->context;
+}
+
+static inline struct tsem_model *tsem_model(struct task_struct *task)
+{
+	return tsem_task(task)->context->model;
+}
+
+static inline struct tsem_inode *tsem_inode(struct inode *inode)
+{
+	return inode->i_security + tsem_blob_sizes.lbs_inode;
+}
+
+static inline struct crypto_shash *tsem_digest(void)
+{
+	return tsem_context(current)->tfm;
+}
+
+static inline unsigned int tsem_digestsize(void)
+{
+	return crypto_shash_digestsize(tsem_digest());
+}
-- 
2.39.1

