Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B946283A3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbiKNPQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237186AbiKNPQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:16:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C949010071;
        Mon, 14 Nov 2022 07:16:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 314F6B81031;
        Mon, 14 Nov 2022 15:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753C5C433C1;
        Mon, 14 Nov 2022 15:16:13 +0000 (UTC)
Subject: [PATCH v2] trace: Relocate event helper files
From:   Chuck Lever <chuck.lever@oracle.com>
To:     rostedt@goodmis.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 14 Nov 2022 10:16:12 -0500
Message-ID: <166843895843.170837.8663873976042560070.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev3+g9561319
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt says:
> The include/trace/events/ directory should only hold files that
> are to create events, not headers that hold helper functions.
>
> Can you please move them out of include/trace/events/ as that
> directory is "special" in the creation of events.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/cm_trace.h  |    2 
 drivers/infiniband/core/cma_trace.h |    2 
 fs/nfs/nfs4trace.h                  |    6 -
 fs/nfs/nfstrace.h                   |    6 -
 include/trace/events/fs.h           |  122 -----------
 include/trace/events/nfs.h          |  375 -----------------------------------
 include/trace/events/rdma.h         |  168 ----------------
 include/trace/events/rpcgss.h       |    2 
 include/trace/events/rpcrdma.h      |    4 
 include/trace/events/sunrpc.h       |    2 
 include/trace/events/sunrpc_base.h  |   18 --
 include/trace/misc/fs.h             |  122 +++++++++++
 include/trace/misc/nfs.h            |  375 +++++++++++++++++++++++++++++++++++
 include/trace/misc/rdma.h           |  168 ++++++++++++++++
 include/trace/misc/sunrpc.h         |   18 ++
 15 files changed, 695 insertions(+), 695 deletions(-)
 delete mode 100644 include/trace/events/fs.h
 delete mode 100644 include/trace/events/nfs.h
 delete mode 100644 include/trace/events/rdma.h
 delete mode 100644 include/trace/events/sunrpc_base.h
 create mode 100644 include/trace/misc/fs.h
 create mode 100644 include/trace/misc/nfs.h
 create mode 100644 include/trace/misc/rdma.h
 create mode 100644 include/trace/misc/sunrpc.h

Note: with an Acked-by from both the NFS client and RDMA core
maintainers I can take this through the nfsd for-next tree, unless
someone has another suggestion.

diff --git a/drivers/infiniband/core/cm_trace.h b/drivers/infiniband/core/cm_trace.h
index e9d282679ef1..944d9071245d 100644
--- a/drivers/infiniband/core/cm_trace.h
+++ b/drivers/infiniband/core/cm_trace.h
@@ -16,7 +16,7 @@
 
 #include <linux/tracepoint.h>
 #include <rdma/ib_cm.h>
-#include <trace/events/rdma.h>
+#include <trace/misc/rdma.h>
 
 /*
  * enum ib_cm_state, from include/rdma/ib_cm.h
diff --git a/drivers/infiniband/core/cma_trace.h b/drivers/infiniband/core/cma_trace.h
index e45264267bcc..47f3c6e4be89 100644
--- a/drivers/infiniband/core/cma_trace.h
+++ b/drivers/infiniband/core/cma_trace.h
@@ -15,7 +15,7 @@
 #define _TRACE_RDMA_CMA_H
 
 #include <linux/tracepoint.h>
-#include <trace/events/rdma.h>
+#include <trace/misc/rdma.h>
 
 
 DECLARE_EVENT_CLASS(cma_fsm_class,
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 2cff5901c689..633cc64a04da 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -9,10 +9,10 @@
 #define _TRACE_NFS4_H
 
 #include <linux/tracepoint.h>
-#include <trace/events/sunrpc_base.h>
+#include <trace/misc/sunrpc.h>
 
-#include <trace/events/fs.h>
-#include <trace/events/nfs.h>
+#include <trace/misc/fs.h>
+#include <trace/misc/nfs.h>
 
 #define show_nfs_fattr_flags(valid) \
 	__print_flags((unsigned long)valid, "|", \
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 8c6cc58679ff..642f6921852f 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -11,9 +11,9 @@
 #include <linux/tracepoint.h>
 #include <linux/iversion.h>
 
-#include <trace/events/fs.h>
-#include <trace/events/nfs.h>
-#include <trace/events/sunrpc_base.h>
+#include <trace/misc/fs.h>
+#include <trace/misc/nfs.h>
+#include <trace/misc/sunrpc.h>
 
 #define nfs_show_cache_validity(v) \
 	__print_flags(v, "|", \
diff --git a/include/trace/events/fs.h b/include/trace/events/fs.h
deleted file mode 100644
index 738b97f22f36..000000000000
--- a/include/trace/events/fs.h
+++ /dev/null
@@ -1,122 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Display helpers for generic filesystem items
- *
- * Author: Chuck Lever <chuck.lever@oracle.com>
- *
- * Copyright (c) 2020, Oracle and/or its affiliates.
- */
-
-#include <linux/fs.h>
-
-#define show_fs_dirent_type(x) \
-	__print_symbolic(x, \
-		{ DT_UNKNOWN,		"UNKNOWN" }, \
-		{ DT_FIFO,		"FIFO" }, \
-		{ DT_CHR,		"CHR" }, \
-		{ DT_DIR,		"DIR" }, \
-		{ DT_BLK,		"BLK" }, \
-		{ DT_REG,		"REG" }, \
-		{ DT_LNK,		"LNK" }, \
-		{ DT_SOCK,		"SOCK" }, \
-		{ DT_WHT,		"WHT" })
-
-#define show_fs_fcntl_open_flags(x) \
-	__print_flags(x, "|", \
-		{ O_WRONLY,		"O_WRONLY" }, \
-		{ O_RDWR,		"O_RDWR" }, \
-		{ O_CREAT,		"O_CREAT" }, \
-		{ O_EXCL,		"O_EXCL" }, \
-		{ O_NOCTTY,		"O_NOCTTY" }, \
-		{ O_TRUNC,		"O_TRUNC" }, \
-		{ O_APPEND,		"O_APPEND" }, \
-		{ O_NONBLOCK,		"O_NONBLOCK" }, \
-		{ O_DSYNC,		"O_DSYNC" }, \
-		{ O_DIRECT,		"O_DIRECT" }, \
-		{ O_LARGEFILE,		"O_LARGEFILE" }, \
-		{ O_DIRECTORY,		"O_DIRECTORY" }, \
-		{ O_NOFOLLOW,		"O_NOFOLLOW" }, \
-		{ O_NOATIME,		"O_NOATIME" }, \
-		{ O_CLOEXEC,		"O_CLOEXEC" })
-
-#define __fmode_flag(x)	{ (__force unsigned long)FMODE_##x, #x }
-#define show_fs_fmode_flags(x) \
-	__print_flags(x, "|", \
-		__fmode_flag(READ), \
-		__fmode_flag(WRITE), \
-		__fmode_flag(EXEC))
-
-#ifdef CONFIG_64BIT
-#define show_fs_fcntl_cmd(x) \
-	__print_symbolic(x, \
-		{ F_DUPFD,		"DUPFD" }, \
-		{ F_GETFD,		"GETFD" }, \
-		{ F_SETFD,		"SETFD" }, \
-		{ F_GETFL,		"GETFL" }, \
-		{ F_SETFL,		"SETFL" }, \
-		{ F_GETLK,		"GETLK" }, \
-		{ F_SETLK,		"SETLK" }, \
-		{ F_SETLKW,		"SETLKW" }, \
-		{ F_SETOWN,		"SETOWN" }, \
-		{ F_GETOWN,		"GETOWN" }, \
-		{ F_SETSIG,		"SETSIG" }, \
-		{ F_GETSIG,		"GETSIG" }, \
-		{ F_SETOWN_EX,		"SETOWN_EX" }, \
-		{ F_GETOWN_EX,		"GETOWN_EX" }, \
-		{ F_GETOWNER_UIDS,	"GETOWNER_UIDS" }, \
-		{ F_OFD_GETLK,		"OFD_GETLK" }, \
-		{ F_OFD_SETLK,		"OFD_SETLK" }, \
-		{ F_OFD_SETLKW,		"OFD_SETLKW" })
-#else /* CONFIG_64BIT */
-#define show_fs_fcntl_cmd(x) \
-	__print_symbolic(x, \
-		{ F_DUPFD,		"DUPFD" }, \
-		{ F_GETFD,		"GETFD" }, \
-		{ F_SETFD,		"SETFD" }, \
-		{ F_GETFL,		"GETFL" }, \
-		{ F_SETFL,		"SETFL" }, \
-		{ F_GETLK,		"GETLK" }, \
-		{ F_SETLK,		"SETLK" }, \
-		{ F_SETLKW,		"SETLKW" }, \
-		{ F_SETOWN,		"SETOWN" }, \
-		{ F_GETOWN,		"GETOWN" }, \
-		{ F_SETSIG,		"SETSIG" }, \
-		{ F_GETSIG,		"GETSIG" }, \
-		{ F_GETLK64,		"GETLK64" }, \
-		{ F_SETLK64,		"SETLK64" }, \
-		{ F_SETLKW64,		"SETLKW64" }, \
-		{ F_SETOWN_EX,		"SETOWN_EX" }, \
-		{ F_GETOWN_EX,		"GETOWN_EX" }, \
-		{ F_GETOWNER_UIDS,	"GETOWNER_UIDS" }, \
-		{ F_OFD_GETLK,		"OFD_GETLK" }, \
-		{ F_OFD_SETLK,		"OFD_SETLK" }, \
-		{ F_OFD_SETLKW,		"OFD_SETLKW" })
-#endif /* CONFIG_64BIT */
-
-#define show_fs_fcntl_lock_type(x) \
-	__print_symbolic(x, \
-		{ F_RDLCK,		"RDLCK" }, \
-		{ F_WRLCK,		"WRLCK" }, \
-		{ F_UNLCK,		"UNLCK" })
-
-#define show_fs_lookup_flags(flags) \
-	__print_flags(flags, "|", \
-		{ LOOKUP_FOLLOW,	"FOLLOW" }, \
-		{ LOOKUP_DIRECTORY,	"DIRECTORY" }, \
-		{ LOOKUP_AUTOMOUNT,	"AUTOMOUNT" }, \
-		{ LOOKUP_EMPTY,		"EMPTY" }, \
-		{ LOOKUP_DOWN,		"DOWN" }, \
-		{ LOOKUP_MOUNTPOINT,	"MOUNTPOINT" }, \
-		{ LOOKUP_REVAL,		"REVAL" }, \
-		{ LOOKUP_RCU,		"RCU" }, \
-		{ LOOKUP_OPEN,		"OPEN" }, \
-		{ LOOKUP_CREATE,	"CREATE" }, \
-		{ LOOKUP_EXCL,		"EXCL" }, \
-		{ LOOKUP_RENAME_TARGET,	"RENAME_TARGET" }, \
-		{ LOOKUP_PARENT,	"PARENT" }, \
-		{ LOOKUP_NO_SYMLINKS,	"NO_SYMLINKS" }, \
-		{ LOOKUP_NO_MAGICLINKS,	"NO_MAGICLINKS" }, \
-		{ LOOKUP_NO_XDEV,	"NO_XDEV" }, \
-		{ LOOKUP_BENEATH,	"BENEATH" }, \
-		{ LOOKUP_IN_ROOT,	"IN_ROOT" }, \
-		{ LOOKUP_CACHED,	"CACHED" })
diff --git a/include/trace/events/nfs.h b/include/trace/events/nfs.h
deleted file mode 100644
index 09ffdbb04134..000000000000
--- a/include/trace/events/nfs.h
+++ /dev/null
@@ -1,375 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Display helpers for NFS protocol elements
- *
- * Author: Chuck Lever <chuck.lever@oracle.com>
- *
- * Copyright (c) 2020, Oracle and/or its affiliates.
- */
-
-#include <linux/nfs.h>
-#include <linux/nfs4.h>
-#include <uapi/linux/nfs.h>
-
-TRACE_DEFINE_ENUM(NFS_OK);
-TRACE_DEFINE_ENUM(NFSERR_PERM);
-TRACE_DEFINE_ENUM(NFSERR_NOENT);
-TRACE_DEFINE_ENUM(NFSERR_IO);
-TRACE_DEFINE_ENUM(NFSERR_NXIO);
-TRACE_DEFINE_ENUM(NFSERR_EAGAIN);
-TRACE_DEFINE_ENUM(NFSERR_ACCES);
-TRACE_DEFINE_ENUM(NFSERR_EXIST);
-TRACE_DEFINE_ENUM(NFSERR_XDEV);
-TRACE_DEFINE_ENUM(NFSERR_NODEV);
-TRACE_DEFINE_ENUM(NFSERR_NOTDIR);
-TRACE_DEFINE_ENUM(NFSERR_ISDIR);
-TRACE_DEFINE_ENUM(NFSERR_INVAL);
-TRACE_DEFINE_ENUM(NFSERR_FBIG);
-TRACE_DEFINE_ENUM(NFSERR_NOSPC);
-TRACE_DEFINE_ENUM(NFSERR_ROFS);
-TRACE_DEFINE_ENUM(NFSERR_MLINK);
-TRACE_DEFINE_ENUM(NFSERR_OPNOTSUPP);
-TRACE_DEFINE_ENUM(NFSERR_NAMETOOLONG);
-TRACE_DEFINE_ENUM(NFSERR_NOTEMPTY);
-TRACE_DEFINE_ENUM(NFSERR_DQUOT);
-TRACE_DEFINE_ENUM(NFSERR_STALE);
-TRACE_DEFINE_ENUM(NFSERR_REMOTE);
-TRACE_DEFINE_ENUM(NFSERR_WFLUSH);
-TRACE_DEFINE_ENUM(NFSERR_BADHANDLE);
-TRACE_DEFINE_ENUM(NFSERR_NOT_SYNC);
-TRACE_DEFINE_ENUM(NFSERR_BAD_COOKIE);
-TRACE_DEFINE_ENUM(NFSERR_NOTSUPP);
-TRACE_DEFINE_ENUM(NFSERR_TOOSMALL);
-TRACE_DEFINE_ENUM(NFSERR_SERVERFAULT);
-TRACE_DEFINE_ENUM(NFSERR_BADTYPE);
-TRACE_DEFINE_ENUM(NFSERR_JUKEBOX);
-
-#define show_nfs_status(x) \
-	__print_symbolic(x, \
-		{ NFS_OK,			"OK" }, \
-		{ NFSERR_PERM,			"PERM" }, \
-		{ NFSERR_NOENT,			"NOENT" }, \
-		{ NFSERR_IO,			"IO" }, \
-		{ NFSERR_NXIO,			"NXIO" }, \
-		{ ECHILD,			"CHILD" }, \
-		{ NFSERR_EAGAIN,		"AGAIN" }, \
-		{ NFSERR_ACCES,			"ACCES" }, \
-		{ NFSERR_EXIST,			"EXIST" }, \
-		{ NFSERR_XDEV,			"XDEV" }, \
-		{ NFSERR_NODEV,			"NODEV" }, \
-		{ NFSERR_NOTDIR,		"NOTDIR" }, \
-		{ NFSERR_ISDIR,			"ISDIR" }, \
-		{ NFSERR_INVAL,			"INVAL" }, \
-		{ NFSERR_FBIG,			"FBIG" }, \
-		{ NFSERR_NOSPC,			"NOSPC" }, \
-		{ NFSERR_ROFS,			"ROFS" }, \
-		{ NFSERR_MLINK,			"MLINK" }, \
-		{ NFSERR_OPNOTSUPP,		"OPNOTSUPP" }, \
-		{ NFSERR_NAMETOOLONG,		"NAMETOOLONG" }, \
-		{ NFSERR_NOTEMPTY,		"NOTEMPTY" }, \
-		{ NFSERR_DQUOT,			"DQUOT" }, \
-		{ NFSERR_STALE,			"STALE" }, \
-		{ NFSERR_REMOTE,		"REMOTE" }, \
-		{ NFSERR_WFLUSH,		"WFLUSH" }, \
-		{ NFSERR_BADHANDLE,		"BADHANDLE" }, \
-		{ NFSERR_NOT_SYNC,		"NOTSYNC" }, \
-		{ NFSERR_BAD_COOKIE,		"BADCOOKIE" }, \
-		{ NFSERR_NOTSUPP,		"NOTSUPP" }, \
-		{ NFSERR_TOOSMALL,		"TOOSMALL" }, \
-		{ NFSERR_SERVERFAULT,		"REMOTEIO" }, \
-		{ NFSERR_BADTYPE,		"BADTYPE" }, \
-		{ NFSERR_JUKEBOX,		"JUKEBOX" })
-
-TRACE_DEFINE_ENUM(NFS_UNSTABLE);
-TRACE_DEFINE_ENUM(NFS_DATA_SYNC);
-TRACE_DEFINE_ENUM(NFS_FILE_SYNC);
-
-#define show_nfs_stable_how(x) \
-	__print_symbolic(x, \
-		{ NFS_UNSTABLE,			"UNSTABLE" }, \
-		{ NFS_DATA_SYNC,		"DATA_SYNC" }, \
-		{ NFS_FILE_SYNC,		"FILE_SYNC" })
-
-TRACE_DEFINE_ENUM(NFS4_OK);
-TRACE_DEFINE_ENUM(NFS4ERR_ACCESS);
-TRACE_DEFINE_ENUM(NFS4ERR_ATTRNOTSUPP);
-TRACE_DEFINE_ENUM(NFS4ERR_ADMIN_REVOKED);
-TRACE_DEFINE_ENUM(NFS4ERR_BACK_CHAN_BUSY);
-TRACE_DEFINE_ENUM(NFS4ERR_BADCHAR);
-TRACE_DEFINE_ENUM(NFS4ERR_BADHANDLE);
-TRACE_DEFINE_ENUM(NFS4ERR_BADIOMODE);
-TRACE_DEFINE_ENUM(NFS4ERR_BADLAYOUT);
-TRACE_DEFINE_ENUM(NFS4ERR_BADLABEL);
-TRACE_DEFINE_ENUM(NFS4ERR_BADNAME);
-TRACE_DEFINE_ENUM(NFS4ERR_BADOWNER);
-TRACE_DEFINE_ENUM(NFS4ERR_BADSESSION);
-TRACE_DEFINE_ENUM(NFS4ERR_BADSLOT);
-TRACE_DEFINE_ENUM(NFS4ERR_BADTYPE);
-TRACE_DEFINE_ENUM(NFS4ERR_BADXDR);
-TRACE_DEFINE_ENUM(NFS4ERR_BAD_COOKIE);
-TRACE_DEFINE_ENUM(NFS4ERR_BAD_HIGH_SLOT);
-TRACE_DEFINE_ENUM(NFS4ERR_BAD_RANGE);
-TRACE_DEFINE_ENUM(NFS4ERR_BAD_SEQID);
-TRACE_DEFINE_ENUM(NFS4ERR_BAD_SESSION_DIGEST);
-TRACE_DEFINE_ENUM(NFS4ERR_BAD_STATEID);
-TRACE_DEFINE_ENUM(NFS4ERR_CB_PATH_DOWN);
-TRACE_DEFINE_ENUM(NFS4ERR_CLID_INUSE);
-TRACE_DEFINE_ENUM(NFS4ERR_CLIENTID_BUSY);
-TRACE_DEFINE_ENUM(NFS4ERR_COMPLETE_ALREADY);
-TRACE_DEFINE_ENUM(NFS4ERR_CONN_NOT_BOUND_TO_SESSION);
-TRACE_DEFINE_ENUM(NFS4ERR_DEADLOCK);
-TRACE_DEFINE_ENUM(NFS4ERR_DEADSESSION);
-TRACE_DEFINE_ENUM(NFS4ERR_DELAY);
-TRACE_DEFINE_ENUM(NFS4ERR_DELEG_ALREADY_WANTED);
-TRACE_DEFINE_ENUM(NFS4ERR_DELEG_REVOKED);
-TRACE_DEFINE_ENUM(NFS4ERR_DENIED);
-TRACE_DEFINE_ENUM(NFS4ERR_DIRDELEG_UNAVAIL);
-TRACE_DEFINE_ENUM(NFS4ERR_DQUOT);
-TRACE_DEFINE_ENUM(NFS4ERR_ENCR_ALG_UNSUPP);
-TRACE_DEFINE_ENUM(NFS4ERR_EXIST);
-TRACE_DEFINE_ENUM(NFS4ERR_EXPIRED);
-TRACE_DEFINE_ENUM(NFS4ERR_FBIG);
-TRACE_DEFINE_ENUM(NFS4ERR_FHEXPIRED);
-TRACE_DEFINE_ENUM(NFS4ERR_FILE_OPEN);
-TRACE_DEFINE_ENUM(NFS4ERR_GRACE);
-TRACE_DEFINE_ENUM(NFS4ERR_HASH_ALG_UNSUPP);
-TRACE_DEFINE_ENUM(NFS4ERR_INVAL);
-TRACE_DEFINE_ENUM(NFS4ERR_IO);
-TRACE_DEFINE_ENUM(NFS4ERR_ISDIR);
-TRACE_DEFINE_ENUM(NFS4ERR_LAYOUTTRYLATER);
-TRACE_DEFINE_ENUM(NFS4ERR_LAYOUTUNAVAILABLE);
-TRACE_DEFINE_ENUM(NFS4ERR_LEASE_MOVED);
-TRACE_DEFINE_ENUM(NFS4ERR_LOCKED);
-TRACE_DEFINE_ENUM(NFS4ERR_LOCKS_HELD);
-TRACE_DEFINE_ENUM(NFS4ERR_LOCK_RANGE);
-TRACE_DEFINE_ENUM(NFS4ERR_MINOR_VERS_MISMATCH);
-TRACE_DEFINE_ENUM(NFS4ERR_MLINK);
-TRACE_DEFINE_ENUM(NFS4ERR_MOVED);
-TRACE_DEFINE_ENUM(NFS4ERR_NAMETOOLONG);
-TRACE_DEFINE_ENUM(NFS4ERR_NOENT);
-TRACE_DEFINE_ENUM(NFS4ERR_NOFILEHANDLE);
-TRACE_DEFINE_ENUM(NFS4ERR_NOMATCHING_LAYOUT);
-TRACE_DEFINE_ENUM(NFS4ERR_NOSPC);
-TRACE_DEFINE_ENUM(NFS4ERR_NOTDIR);
-TRACE_DEFINE_ENUM(NFS4ERR_NOTEMPTY);
-TRACE_DEFINE_ENUM(NFS4ERR_NOTSUPP);
-TRACE_DEFINE_ENUM(NFS4ERR_NOT_ONLY_OP);
-TRACE_DEFINE_ENUM(NFS4ERR_NOT_SAME);
-TRACE_DEFINE_ENUM(NFS4ERR_NO_GRACE);
-TRACE_DEFINE_ENUM(NFS4ERR_NXIO);
-TRACE_DEFINE_ENUM(NFS4ERR_OLD_STATEID);
-TRACE_DEFINE_ENUM(NFS4ERR_OPENMODE);
-TRACE_DEFINE_ENUM(NFS4ERR_OP_ILLEGAL);
-TRACE_DEFINE_ENUM(NFS4ERR_OP_NOT_IN_SESSION);
-TRACE_DEFINE_ENUM(NFS4ERR_PERM);
-TRACE_DEFINE_ENUM(NFS4ERR_PNFS_IO_HOLE);
-TRACE_DEFINE_ENUM(NFS4ERR_PNFS_NO_LAYOUT);
-TRACE_DEFINE_ENUM(NFS4ERR_RECALLCONFLICT);
-TRACE_DEFINE_ENUM(NFS4ERR_RECLAIM_BAD);
-TRACE_DEFINE_ENUM(NFS4ERR_RECLAIM_CONFLICT);
-TRACE_DEFINE_ENUM(NFS4ERR_REJECT_DELEG);
-TRACE_DEFINE_ENUM(NFS4ERR_REP_TOO_BIG);
-TRACE_DEFINE_ENUM(NFS4ERR_REP_TOO_BIG_TO_CACHE);
-TRACE_DEFINE_ENUM(NFS4ERR_REQ_TOO_BIG);
-TRACE_DEFINE_ENUM(NFS4ERR_RESOURCE);
-TRACE_DEFINE_ENUM(NFS4ERR_RESTOREFH);
-TRACE_DEFINE_ENUM(NFS4ERR_RETRY_UNCACHED_REP);
-TRACE_DEFINE_ENUM(NFS4ERR_RETURNCONFLICT);
-TRACE_DEFINE_ENUM(NFS4ERR_ROFS);
-TRACE_DEFINE_ENUM(NFS4ERR_SAME);
-TRACE_DEFINE_ENUM(NFS4ERR_SHARE_DENIED);
-TRACE_DEFINE_ENUM(NFS4ERR_SEQUENCE_POS);
-TRACE_DEFINE_ENUM(NFS4ERR_SEQ_FALSE_RETRY);
-TRACE_DEFINE_ENUM(NFS4ERR_SEQ_MISORDERED);
-TRACE_DEFINE_ENUM(NFS4ERR_SERVERFAULT);
-TRACE_DEFINE_ENUM(NFS4ERR_STALE);
-TRACE_DEFINE_ENUM(NFS4ERR_STALE_CLIENTID);
-TRACE_DEFINE_ENUM(NFS4ERR_STALE_STATEID);
-TRACE_DEFINE_ENUM(NFS4ERR_SYMLINK);
-TRACE_DEFINE_ENUM(NFS4ERR_TOOSMALL);
-TRACE_DEFINE_ENUM(NFS4ERR_TOO_MANY_OPS);
-TRACE_DEFINE_ENUM(NFS4ERR_UNKNOWN_LAYOUTTYPE);
-TRACE_DEFINE_ENUM(NFS4ERR_UNSAFE_COMPOUND);
-TRACE_DEFINE_ENUM(NFS4ERR_WRONGSEC);
-TRACE_DEFINE_ENUM(NFS4ERR_WRONG_CRED);
-TRACE_DEFINE_ENUM(NFS4ERR_WRONG_TYPE);
-TRACE_DEFINE_ENUM(NFS4ERR_XDEV);
-
-TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_MDS);
-TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_PNFS);
-
-#define show_nfs4_status(x) \
-	__print_symbolic(x, \
-		{ NFS4_OK,			"OK" }, \
-		{ EPERM,			"EPERM" }, \
-		{ ENOENT,			"ENOENT" }, \
-		{ EIO,				"EIO" }, \
-		{ ENXIO,			"ENXIO" }, \
-		{ EACCES,			"EACCES" }, \
-		{ EEXIST,			"EEXIST" }, \
-		{ EXDEV,			"EXDEV" }, \
-		{ ENOTDIR,			"ENOTDIR" }, \
-		{ EISDIR,			"EISDIR" }, \
-		{ EFBIG,			"EFBIG" }, \
-		{ ENOSPC,			"ENOSPC" }, \
-		{ EROFS,			"EROFS" }, \
-		{ EMLINK,			"EMLINK" }, \
-		{ ENAMETOOLONG,			"ENAMETOOLONG" }, \
-		{ ENOTEMPTY,			"ENOTEMPTY" }, \
-		{ EDQUOT,			"EDQUOT" }, \
-		{ ESTALE,			"ESTALE" }, \
-		{ EBADHANDLE,			"EBADHANDLE" }, \
-		{ EBADCOOKIE,			"EBADCOOKIE" }, \
-		{ ENOTSUPP,			"ENOTSUPP" }, \
-		{ ETOOSMALL,			"ETOOSMALL" }, \
-		{ EREMOTEIO,			"EREMOTEIO" }, \
-		{ EBADTYPE,			"EBADTYPE" }, \
-		{ EAGAIN,			"EAGAIN" }, \
-		{ ELOOP,			"ELOOP" }, \
-		{ EOPNOTSUPP,			"EOPNOTSUPP" }, \
-		{ EDEADLK,			"EDEADLK" }, \
-		{ ENOMEM,			"ENOMEM" }, \
-		{ EKEYEXPIRED,			"EKEYEXPIRED" }, \
-		{ ETIMEDOUT,			"ETIMEDOUT" }, \
-		{ ERESTARTSYS,			"ERESTARTSYS" }, \
-		{ ECONNREFUSED,			"ECONNREFUSED" }, \
-		{ ECONNRESET,			"ECONNRESET" }, \
-		{ ENETUNREACH,			"ENETUNREACH" }, \
-		{ EHOSTUNREACH,			"EHOSTUNREACH" }, \
-		{ EHOSTDOWN,			"EHOSTDOWN" }, \
-		{ EPIPE,			"EPIPE" }, \
-		{ EPFNOSUPPORT,			"EPFNOSUPPORT" }, \
-		{ EPROTONOSUPPORT,		"EPROTONOSUPPORT" }, \
-		{ NFS4ERR_ACCESS,		"ACCESS" }, \
-		{ NFS4ERR_ATTRNOTSUPP,		"ATTRNOTSUPP" }, \
-		{ NFS4ERR_ADMIN_REVOKED,	"ADMIN_REVOKED" }, \
-		{ NFS4ERR_BACK_CHAN_BUSY,	"BACK_CHAN_BUSY" }, \
-		{ NFS4ERR_BADCHAR,		"BADCHAR" }, \
-		{ NFS4ERR_BADHANDLE,		"BADHANDLE" }, \
-		{ NFS4ERR_BADIOMODE,		"BADIOMODE" }, \
-		{ NFS4ERR_BADLAYOUT,		"BADLAYOUT" }, \
-		{ NFS4ERR_BADLABEL,		"BADLABEL" }, \
-		{ NFS4ERR_BADNAME,		"BADNAME" }, \
-		{ NFS4ERR_BADOWNER,		"BADOWNER" }, \
-		{ NFS4ERR_BADSESSION,		"BADSESSION" }, \
-		{ NFS4ERR_BADSLOT,		"BADSLOT" }, \
-		{ NFS4ERR_BADTYPE,		"BADTYPE" }, \
-		{ NFS4ERR_BADXDR,		"BADXDR" }, \
-		{ NFS4ERR_BAD_COOKIE,		"BAD_COOKIE" }, \
-		{ NFS4ERR_BAD_HIGH_SLOT,	"BAD_HIGH_SLOT" }, \
-		{ NFS4ERR_BAD_RANGE,		"BAD_RANGE" }, \
-		{ NFS4ERR_BAD_SEQID,		"BAD_SEQID" }, \
-		{ NFS4ERR_BAD_SESSION_DIGEST,	"BAD_SESSION_DIGEST" }, \
-		{ NFS4ERR_BAD_STATEID,		"BAD_STATEID" }, \
-		{ NFS4ERR_CB_PATH_DOWN,		"CB_PATH_DOWN" }, \
-		{ NFS4ERR_CLID_INUSE,		"CLID_INUSE" }, \
-		{ NFS4ERR_CLIENTID_BUSY,	"CLIENTID_BUSY" }, \
-		{ NFS4ERR_COMPLETE_ALREADY,	"COMPLETE_ALREADY" }, \
-		{ NFS4ERR_CONN_NOT_BOUND_TO_SESSION, "CONN_NOT_BOUND_TO_SESSION" }, \
-		{ NFS4ERR_DEADLOCK,		"DEADLOCK" }, \
-		{ NFS4ERR_DEADSESSION,		"DEAD_SESSION" }, \
-		{ NFS4ERR_DELAY,		"DELAY" }, \
-		{ NFS4ERR_DELEG_ALREADY_WANTED,	"DELEG_ALREADY_WANTED" }, \
-		{ NFS4ERR_DELEG_REVOKED,	"DELEG_REVOKED" }, \
-		{ NFS4ERR_DENIED,		"DENIED" }, \
-		{ NFS4ERR_DIRDELEG_UNAVAIL,	"DIRDELEG_UNAVAIL" }, \
-		{ NFS4ERR_DQUOT,		"DQUOT" }, \
-		{ NFS4ERR_ENCR_ALG_UNSUPP,	"ENCR_ALG_UNSUPP" }, \
-		{ NFS4ERR_EXIST,		"EXIST" }, \
-		{ NFS4ERR_EXPIRED,		"EXPIRED" }, \
-		{ NFS4ERR_FBIG,			"FBIG" }, \
-		{ NFS4ERR_FHEXPIRED,		"FHEXPIRED" }, \
-		{ NFS4ERR_FILE_OPEN,		"FILE_OPEN" }, \
-		{ NFS4ERR_GRACE,		"GRACE" }, \
-		{ NFS4ERR_HASH_ALG_UNSUPP,	"HASH_ALG_UNSUPP" }, \
-		{ NFS4ERR_INVAL,		"INVAL" }, \
-		{ NFS4ERR_IO,			"IO" }, \
-		{ NFS4ERR_ISDIR,		"ISDIR" }, \
-		{ NFS4ERR_LAYOUTTRYLATER,	"LAYOUTTRYLATER" }, \
-		{ NFS4ERR_LAYOUTUNAVAILABLE,	"LAYOUTUNAVAILABLE" }, \
-		{ NFS4ERR_LEASE_MOVED,		"LEASE_MOVED" }, \
-		{ NFS4ERR_LOCKED,		"LOCKED" }, \
-		{ NFS4ERR_LOCKS_HELD,		"LOCKS_HELD" }, \
-		{ NFS4ERR_LOCK_RANGE,		"LOCK_RANGE" }, \
-		{ NFS4ERR_MINOR_VERS_MISMATCH,	"MINOR_VERS_MISMATCH" }, \
-		{ NFS4ERR_MLINK,		"MLINK" }, \
-		{ NFS4ERR_MOVED,		"MOVED" }, \
-		{ NFS4ERR_NAMETOOLONG,		"NAMETOOLONG" }, \
-		{ NFS4ERR_NOENT,		"NOENT" }, \
-		{ NFS4ERR_NOFILEHANDLE,		"NOFILEHANDLE" }, \
-		{ NFS4ERR_NOMATCHING_LAYOUT,	"NOMATCHING_LAYOUT" }, \
-		{ NFS4ERR_NOSPC,		"NOSPC" }, \
-		{ NFS4ERR_NOTDIR,		"NOTDIR" }, \
-		{ NFS4ERR_NOTEMPTY,		"NOTEMPTY" }, \
-		{ NFS4ERR_NOTSUPP,		"NOTSUPP" }, \
-		{ NFS4ERR_NOT_ONLY_OP,		"NOT_ONLY_OP" }, \
-		{ NFS4ERR_NOT_SAME,		"NOT_SAME" }, \
-		{ NFS4ERR_NO_GRACE,		"NO_GRACE" }, \
-		{ NFS4ERR_NXIO,			"NXIO" }, \
-		{ NFS4ERR_OLD_STATEID,		"OLD_STATEID" }, \
-		{ NFS4ERR_OPENMODE,		"OPENMODE" }, \
-		{ NFS4ERR_OP_ILLEGAL,		"OP_ILLEGAL" }, \
-		{ NFS4ERR_OP_NOT_IN_SESSION,	"OP_NOT_IN_SESSION" }, \
-		{ NFS4ERR_PERM,			"PERM" }, \
-		{ NFS4ERR_PNFS_IO_HOLE,		"PNFS_IO_HOLE" }, \
-		{ NFS4ERR_PNFS_NO_LAYOUT,	"PNFS_NO_LAYOUT" }, \
-		{ NFS4ERR_RECALLCONFLICT,	"RECALLCONFLICT" }, \
-		{ NFS4ERR_RECLAIM_BAD,		"RECLAIM_BAD" }, \
-		{ NFS4ERR_RECLAIM_CONFLICT,	"RECLAIM_CONFLICT" }, \
-		{ NFS4ERR_REJECT_DELEG,		"REJECT_DELEG" }, \
-		{ NFS4ERR_REP_TOO_BIG,		"REP_TOO_BIG" }, \
-		{ NFS4ERR_REP_TOO_BIG_TO_CACHE,	"REP_TOO_BIG_TO_CACHE" }, \
-		{ NFS4ERR_REQ_TOO_BIG,		"REQ_TOO_BIG" }, \
-		{ NFS4ERR_RESOURCE,		"RESOURCE" }, \
-		{ NFS4ERR_RESTOREFH,		"RESTOREFH" }, \
-		{ NFS4ERR_RETRY_UNCACHED_REP,	"RETRY_UNCACHED_REP" }, \
-		{ NFS4ERR_RETURNCONFLICT,	"RETURNCONFLICT" }, \
-		{ NFS4ERR_ROFS,			"ROFS" }, \
-		{ NFS4ERR_SAME,			"SAME" }, \
-		{ NFS4ERR_SHARE_DENIED,		"SHARE_DENIED" }, \
-		{ NFS4ERR_SEQUENCE_POS,		"SEQUENCE_POS" }, \
-		{ NFS4ERR_SEQ_FALSE_RETRY,	"SEQ_FALSE_RETRY" }, \
-		{ NFS4ERR_SEQ_MISORDERED,	"SEQ_MISORDERED" }, \
-		{ NFS4ERR_SERVERFAULT,		"SERVERFAULT" }, \
-		{ NFS4ERR_STALE,		"STALE" }, \
-		{ NFS4ERR_STALE_CLIENTID,	"STALE_CLIENTID" }, \
-		{ NFS4ERR_STALE_STATEID,	"STALE_STATEID" }, \
-		{ NFS4ERR_SYMLINK,		"SYMLINK" }, \
-		{ NFS4ERR_TOOSMALL,		"TOOSMALL" }, \
-		{ NFS4ERR_TOO_MANY_OPS,		"TOO_MANY_OPS" }, \
-		{ NFS4ERR_UNKNOWN_LAYOUTTYPE,	"UNKNOWN_LAYOUTTYPE" }, \
-		{ NFS4ERR_UNSAFE_COMPOUND,	"UNSAFE_COMPOUND" }, \
-		{ NFS4ERR_WRONGSEC,		"WRONGSEC" }, \
-		{ NFS4ERR_WRONG_CRED,		"WRONG_CRED" }, \
-		{ NFS4ERR_WRONG_TYPE,		"WRONG_TYPE" }, \
-		{ NFS4ERR_XDEV,			"XDEV" }, \
-		/* ***** Internal to Linux NFS client ***** */ \
-		{ NFS4ERR_RESET_TO_MDS,		"RESET_TO_MDS" }, \
-		{ NFS4ERR_RESET_TO_PNFS,	"RESET_TO_PNFS" })
-
-#define show_nfs4_verifier(x) \
-	__print_hex_str(x, NFS4_VERIFIER_SIZE)
-
-TRACE_DEFINE_ENUM(IOMODE_READ);
-TRACE_DEFINE_ENUM(IOMODE_RW);
-TRACE_DEFINE_ENUM(IOMODE_ANY);
-
-#define show_pnfs_layout_iomode(x) \
-	__print_symbolic(x, \
-		{ IOMODE_READ,			"READ" }, \
-		{ IOMODE_RW,			"RW" }, \
-		{ IOMODE_ANY,			"ANY" })
-
-#define show_nfs4_seq4_status(x) \
-	__print_flags(x, "|", \
-		{ SEQ4_STATUS_CB_PATH_DOWN,		"CB_PATH_DOWN" }, \
-		{ SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRING,	"CB_GSS_CONTEXTS_EXPIRING" }, \
-		{ SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRED,	"CB_GSS_CONTEXTS_EXPIRED" }, \
-		{ SEQ4_STATUS_EXPIRED_ALL_STATE_REVOKED, "EXPIRED_ALL_STATE_REVOKED" }, \
-		{ SEQ4_STATUS_EXPIRED_SOME_STATE_REVOKED, "EXPIRED_SOME_STATE_REVOKED" }, \
-		{ SEQ4_STATUS_ADMIN_STATE_REVOKED,	"ADMIN_STATE_REVOKED" }, \
-		{ SEQ4_STATUS_RECALLABLE_STATE_REVOKED,	"RECALLABLE_STATE_REVOKED" }, \
-		{ SEQ4_STATUS_LEASE_MOVED,		"LEASE_MOVED" }, \
-		{ SEQ4_STATUS_RESTART_RECLAIM_NEEDED,	"RESTART_RECLAIM_NEEDED" }, \
-		{ SEQ4_STATUS_CB_PATH_DOWN_SESSION,	"CB_PATH_DOWN_SESSION" }, \
-		{ SEQ4_STATUS_BACKCHANNEL_FAULT,	"BACKCHANNEL_FAULT" })
diff --git a/include/trace/events/rdma.h b/include/trace/events/rdma.h
deleted file mode 100644
index 81bb454fc288..000000000000
--- a/include/trace/events/rdma.h
+++ /dev/null
@@ -1,168 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2017 Oracle.  All rights reserved.
- */
-
-/*
- * enum ib_event_type, from include/rdma/ib_verbs.h
- */
-#define IB_EVENT_LIST				\
-	ib_event(CQ_ERR)			\
-	ib_event(QP_FATAL)			\
-	ib_event(QP_REQ_ERR)			\
-	ib_event(QP_ACCESS_ERR)			\
-	ib_event(COMM_EST)			\
-	ib_event(SQ_DRAINED)			\
-	ib_event(PATH_MIG)			\
-	ib_event(PATH_MIG_ERR)			\
-	ib_event(DEVICE_FATAL)			\
-	ib_event(PORT_ACTIVE)			\
-	ib_event(PORT_ERR)			\
-	ib_event(LID_CHANGE)			\
-	ib_event(PKEY_CHANGE)			\
-	ib_event(SM_CHANGE)			\
-	ib_event(SRQ_ERR)			\
-	ib_event(SRQ_LIMIT_REACHED)		\
-	ib_event(QP_LAST_WQE_REACHED)		\
-	ib_event(CLIENT_REREGISTER)		\
-	ib_event(GID_CHANGE)			\
-	ib_event_end(WQ_FATAL)
-
-#undef ib_event
-#undef ib_event_end
-
-#define ib_event(x)		TRACE_DEFINE_ENUM(IB_EVENT_##x);
-#define ib_event_end(x)		TRACE_DEFINE_ENUM(IB_EVENT_##x);
-
-IB_EVENT_LIST
-
-#undef ib_event
-#undef ib_event_end
-
-#define ib_event(x)		{ IB_EVENT_##x, #x },
-#define ib_event_end(x)		{ IB_EVENT_##x, #x }
-
-#define rdma_show_ib_event(x) \
-		__print_symbolic(x, IB_EVENT_LIST)
-
-/*
- * enum ib_wc_status type, from include/rdma/ib_verbs.h
- */
-#define IB_WC_STATUS_LIST			\
-	ib_wc_status(SUCCESS)			\
-	ib_wc_status(LOC_LEN_ERR)		\
-	ib_wc_status(LOC_QP_OP_ERR)		\
-	ib_wc_status(LOC_EEC_OP_ERR)		\
-	ib_wc_status(LOC_PROT_ERR)		\
-	ib_wc_status(WR_FLUSH_ERR)		\
-	ib_wc_status(MW_BIND_ERR)		\
-	ib_wc_status(BAD_RESP_ERR)		\
-	ib_wc_status(LOC_ACCESS_ERR)		\
-	ib_wc_status(REM_INV_REQ_ERR)		\
-	ib_wc_status(REM_ACCESS_ERR)		\
-	ib_wc_status(REM_OP_ERR)		\
-	ib_wc_status(RETRY_EXC_ERR)		\
-	ib_wc_status(RNR_RETRY_EXC_ERR)		\
-	ib_wc_status(LOC_RDD_VIOL_ERR)		\
-	ib_wc_status(REM_INV_RD_REQ_ERR)	\
-	ib_wc_status(REM_ABORT_ERR)		\
-	ib_wc_status(INV_EECN_ERR)		\
-	ib_wc_status(INV_EEC_STATE_ERR)		\
-	ib_wc_status(FATAL_ERR)			\
-	ib_wc_status(RESP_TIMEOUT_ERR)		\
-	ib_wc_status_end(GENERAL_ERR)
-
-#undef ib_wc_status
-#undef ib_wc_status_end
-
-#define ib_wc_status(x)		TRACE_DEFINE_ENUM(IB_WC_##x);
-#define ib_wc_status_end(x)	TRACE_DEFINE_ENUM(IB_WC_##x);
-
-IB_WC_STATUS_LIST
-
-#undef ib_wc_status
-#undef ib_wc_status_end
-
-#define ib_wc_status(x)		{ IB_WC_##x, #x },
-#define ib_wc_status_end(x)	{ IB_WC_##x, #x }
-
-#define rdma_show_wc_status(x) \
-		__print_symbolic(x, IB_WC_STATUS_LIST)
-
-/*
- * enum ib_cm_event_type, from include/rdma/ib_cm.h
- */
-#define IB_CM_EVENT_LIST			\
-	ib_cm_event(REQ_ERROR)			\
-	ib_cm_event(REQ_RECEIVED)		\
-	ib_cm_event(REP_ERROR)			\
-	ib_cm_event(REP_RECEIVED)		\
-	ib_cm_event(RTU_RECEIVED)		\
-	ib_cm_event(USER_ESTABLISHED)		\
-	ib_cm_event(DREQ_ERROR)			\
-	ib_cm_event(DREQ_RECEIVED)		\
-	ib_cm_event(DREP_RECEIVED)		\
-	ib_cm_event(TIMEWAIT_EXIT)		\
-	ib_cm_event(MRA_RECEIVED)		\
-	ib_cm_event(REJ_RECEIVED)		\
-	ib_cm_event(LAP_ERROR)			\
-	ib_cm_event(LAP_RECEIVED)		\
-	ib_cm_event(APR_RECEIVED)		\
-	ib_cm_event(SIDR_REQ_ERROR)		\
-	ib_cm_event(SIDR_REQ_RECEIVED)		\
-	ib_cm_event_end(SIDR_REP_RECEIVED)
-
-#undef ib_cm_event
-#undef ib_cm_event_end
-
-#define ib_cm_event(x)		TRACE_DEFINE_ENUM(IB_CM_##x);
-#define ib_cm_event_end(x)	TRACE_DEFINE_ENUM(IB_CM_##x);
-
-IB_CM_EVENT_LIST
-
-#undef ib_cm_event
-#undef ib_cm_event_end
-
-#define ib_cm_event(x)		{ IB_CM_##x, #x },
-#define ib_cm_event_end(x)	{ IB_CM_##x, #x }
-
-#define rdma_show_ib_cm_event(x) \
-		__print_symbolic(x, IB_CM_EVENT_LIST)
-
-/*
- * enum rdma_cm_event_type, from include/rdma/rdma_cm.h
- */
-#define RDMA_CM_EVENT_LIST			\
-	rdma_cm_event(ADDR_RESOLVED)		\
-	rdma_cm_event(ADDR_ERROR)		\
-	rdma_cm_event(ROUTE_RESOLVED)		\
-	rdma_cm_event(ROUTE_ERROR)		\
-	rdma_cm_event(CONNECT_REQUEST)		\
-	rdma_cm_event(CONNECT_RESPONSE)		\
-	rdma_cm_event(CONNECT_ERROR)		\
-	rdma_cm_event(UNREACHABLE)		\
-	rdma_cm_event(REJECTED)			\
-	rdma_cm_event(ESTABLISHED)		\
-	rdma_cm_event(DISCONNECTED)		\
-	rdma_cm_event(DEVICE_REMOVAL)		\
-	rdma_cm_event(MULTICAST_JOIN)		\
-	rdma_cm_event(MULTICAST_ERROR)		\
-	rdma_cm_event(ADDR_CHANGE)		\
-	rdma_cm_event_end(TIMEWAIT_EXIT)
-
-#undef rdma_cm_event
-#undef rdma_cm_event_end
-
-#define rdma_cm_event(x)	TRACE_DEFINE_ENUM(RDMA_CM_EVENT_##x);
-#define rdma_cm_event_end(x)	TRACE_DEFINE_ENUM(RDMA_CM_EVENT_##x);
-
-RDMA_CM_EVENT_LIST
-
-#undef rdma_cm_event
-#undef rdma_cm_event_end
-
-#define rdma_cm_event(x)	{ RDMA_CM_EVENT_##x, #x },
-#define rdma_cm_event_end(x)	{ RDMA_CM_EVENT_##x, #x }
-
-#define rdma_show_cm_event(x) \
-		__print_symbolic(x, RDMA_CM_EVENT_LIST)
diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index c9048f3e471b..3f121eed369e 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -13,7 +13,7 @@
 
 #include <linux/tracepoint.h>
 
-#include <trace/events/sunrpc_base.h>
+#include <trace/misc/sunrpc.h>
 
 /**
  ** GSS-API related trace events
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index fcd3b3f1020a..8f461e04e5f0 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -15,8 +15,8 @@
 #include <linux/tracepoint.h>
 #include <rdma/ib_cm.h>
 
-#include <trace/events/rdma.h>
-#include <trace/events/sunrpc_base.h>
+#include <trace/misc/rdma.h>
+#include <trace/misc/sunrpc.h>
 
 /**
  ** Event classes
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index f48f2ab9d238..ffe2679a13ce 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -14,7 +14,7 @@
 #include <linux/net.h>
 #include <linux/tracepoint.h>
 
-#include <trace/events/sunrpc_base.h>
+#include <trace/misc/sunrpc.h>
 
 TRACE_DEFINE_ENUM(SOCK_STREAM);
 TRACE_DEFINE_ENUM(SOCK_DGRAM);
diff --git a/include/trace/events/sunrpc_base.h b/include/trace/events/sunrpc_base.h
deleted file mode 100644
index 588557d07ea8..000000000000
--- a/include/trace/events/sunrpc_base.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2021 Oracle and/or its affiliates.
- *
- * Common types and format specifiers for sunrpc.
- */
-
-#if !defined(_TRACE_SUNRPC_BASE_H)
-#define _TRACE_SUNRPC_BASE_H
-
-#include <linux/tracepoint.h>
-
-#define SUNRPC_TRACE_PID_SPECIFIER	"%08x"
-#define SUNRPC_TRACE_CLID_SPECIFIER	"%08x"
-#define SUNRPC_TRACE_TASK_SPECIFIER \
-	"task:" SUNRPC_TRACE_PID_SPECIFIER "@" SUNRPC_TRACE_CLID_SPECIFIER
-
-#endif /* _TRACE_SUNRPC_BASE_H */
diff --git a/include/trace/misc/fs.h b/include/trace/misc/fs.h
new file mode 100644
index 000000000000..738b97f22f36
--- /dev/null
+++ b/include/trace/misc/fs.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Display helpers for generic filesystem items
+ *
+ * Author: Chuck Lever <chuck.lever@oracle.com>
+ *
+ * Copyright (c) 2020, Oracle and/or its affiliates.
+ */
+
+#include <linux/fs.h>
+
+#define show_fs_dirent_type(x) \
+	__print_symbolic(x, \
+		{ DT_UNKNOWN,		"UNKNOWN" }, \
+		{ DT_FIFO,		"FIFO" }, \
+		{ DT_CHR,		"CHR" }, \
+		{ DT_DIR,		"DIR" }, \
+		{ DT_BLK,		"BLK" }, \
+		{ DT_REG,		"REG" }, \
+		{ DT_LNK,		"LNK" }, \
+		{ DT_SOCK,		"SOCK" }, \
+		{ DT_WHT,		"WHT" })
+
+#define show_fs_fcntl_open_flags(x) \
+	__print_flags(x, "|", \
+		{ O_WRONLY,		"O_WRONLY" }, \
+		{ O_RDWR,		"O_RDWR" }, \
+		{ O_CREAT,		"O_CREAT" }, \
+		{ O_EXCL,		"O_EXCL" }, \
+		{ O_NOCTTY,		"O_NOCTTY" }, \
+		{ O_TRUNC,		"O_TRUNC" }, \
+		{ O_APPEND,		"O_APPEND" }, \
+		{ O_NONBLOCK,		"O_NONBLOCK" }, \
+		{ O_DSYNC,		"O_DSYNC" }, \
+		{ O_DIRECT,		"O_DIRECT" }, \
+		{ O_LARGEFILE,		"O_LARGEFILE" }, \
+		{ O_DIRECTORY,		"O_DIRECTORY" }, \
+		{ O_NOFOLLOW,		"O_NOFOLLOW" }, \
+		{ O_NOATIME,		"O_NOATIME" }, \
+		{ O_CLOEXEC,		"O_CLOEXEC" })
+
+#define __fmode_flag(x)	{ (__force unsigned long)FMODE_##x, #x }
+#define show_fs_fmode_flags(x) \
+	__print_flags(x, "|", \
+		__fmode_flag(READ), \
+		__fmode_flag(WRITE), \
+		__fmode_flag(EXEC))
+
+#ifdef CONFIG_64BIT
+#define show_fs_fcntl_cmd(x) \
+	__print_symbolic(x, \
+		{ F_DUPFD,		"DUPFD" }, \
+		{ F_GETFD,		"GETFD" }, \
+		{ F_SETFD,		"SETFD" }, \
+		{ F_GETFL,		"GETFL" }, \
+		{ F_SETFL,		"SETFL" }, \
+		{ F_GETLK,		"GETLK" }, \
+		{ F_SETLK,		"SETLK" }, \
+		{ F_SETLKW,		"SETLKW" }, \
+		{ F_SETOWN,		"SETOWN" }, \
+		{ F_GETOWN,		"GETOWN" }, \
+		{ F_SETSIG,		"SETSIG" }, \
+		{ F_GETSIG,		"GETSIG" }, \
+		{ F_SETOWN_EX,		"SETOWN_EX" }, \
+		{ F_GETOWN_EX,		"GETOWN_EX" }, \
+		{ F_GETOWNER_UIDS,	"GETOWNER_UIDS" }, \
+		{ F_OFD_GETLK,		"OFD_GETLK" }, \
+		{ F_OFD_SETLK,		"OFD_SETLK" }, \
+		{ F_OFD_SETLKW,		"OFD_SETLKW" })
+#else /* CONFIG_64BIT */
+#define show_fs_fcntl_cmd(x) \
+	__print_symbolic(x, \
+		{ F_DUPFD,		"DUPFD" }, \
+		{ F_GETFD,		"GETFD" }, \
+		{ F_SETFD,		"SETFD" }, \
+		{ F_GETFL,		"GETFL" }, \
+		{ F_SETFL,		"SETFL" }, \
+		{ F_GETLK,		"GETLK" }, \
+		{ F_SETLK,		"SETLK" }, \
+		{ F_SETLKW,		"SETLKW" }, \
+		{ F_SETOWN,		"SETOWN" }, \
+		{ F_GETOWN,		"GETOWN" }, \
+		{ F_SETSIG,		"SETSIG" }, \
+		{ F_GETSIG,		"GETSIG" }, \
+		{ F_GETLK64,		"GETLK64" }, \
+		{ F_SETLK64,		"SETLK64" }, \
+		{ F_SETLKW64,		"SETLKW64" }, \
+		{ F_SETOWN_EX,		"SETOWN_EX" }, \
+		{ F_GETOWN_EX,		"GETOWN_EX" }, \
+		{ F_GETOWNER_UIDS,	"GETOWNER_UIDS" }, \
+		{ F_OFD_GETLK,		"OFD_GETLK" }, \
+		{ F_OFD_SETLK,		"OFD_SETLK" }, \
+		{ F_OFD_SETLKW,		"OFD_SETLKW" })
+#endif /* CONFIG_64BIT */
+
+#define show_fs_fcntl_lock_type(x) \
+	__print_symbolic(x, \
+		{ F_RDLCK,		"RDLCK" }, \
+		{ F_WRLCK,		"WRLCK" }, \
+		{ F_UNLCK,		"UNLCK" })
+
+#define show_fs_lookup_flags(flags) \
+	__print_flags(flags, "|", \
+		{ LOOKUP_FOLLOW,	"FOLLOW" }, \
+		{ LOOKUP_DIRECTORY,	"DIRECTORY" }, \
+		{ LOOKUP_AUTOMOUNT,	"AUTOMOUNT" }, \
+		{ LOOKUP_EMPTY,		"EMPTY" }, \
+		{ LOOKUP_DOWN,		"DOWN" }, \
+		{ LOOKUP_MOUNTPOINT,	"MOUNTPOINT" }, \
+		{ LOOKUP_REVAL,		"REVAL" }, \
+		{ LOOKUP_RCU,		"RCU" }, \
+		{ LOOKUP_OPEN,		"OPEN" }, \
+		{ LOOKUP_CREATE,	"CREATE" }, \
+		{ LOOKUP_EXCL,		"EXCL" }, \
+		{ LOOKUP_RENAME_TARGET,	"RENAME_TARGET" }, \
+		{ LOOKUP_PARENT,	"PARENT" }, \
+		{ LOOKUP_NO_SYMLINKS,	"NO_SYMLINKS" }, \
+		{ LOOKUP_NO_MAGICLINKS,	"NO_MAGICLINKS" }, \
+		{ LOOKUP_NO_XDEV,	"NO_XDEV" }, \
+		{ LOOKUP_BENEATH,	"BENEATH" }, \
+		{ LOOKUP_IN_ROOT,	"IN_ROOT" }, \
+		{ LOOKUP_CACHED,	"CACHED" })
diff --git a/include/trace/misc/nfs.h b/include/trace/misc/nfs.h
new file mode 100644
index 000000000000..09ffdbb04134
--- /dev/null
+++ b/include/trace/misc/nfs.h
@@ -0,0 +1,375 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Display helpers for NFS protocol elements
+ *
+ * Author: Chuck Lever <chuck.lever@oracle.com>
+ *
+ * Copyright (c) 2020, Oracle and/or its affiliates.
+ */
+
+#include <linux/nfs.h>
+#include <linux/nfs4.h>
+#include <uapi/linux/nfs.h>
+
+TRACE_DEFINE_ENUM(NFS_OK);
+TRACE_DEFINE_ENUM(NFSERR_PERM);
+TRACE_DEFINE_ENUM(NFSERR_NOENT);
+TRACE_DEFINE_ENUM(NFSERR_IO);
+TRACE_DEFINE_ENUM(NFSERR_NXIO);
+TRACE_DEFINE_ENUM(NFSERR_EAGAIN);
+TRACE_DEFINE_ENUM(NFSERR_ACCES);
+TRACE_DEFINE_ENUM(NFSERR_EXIST);
+TRACE_DEFINE_ENUM(NFSERR_XDEV);
+TRACE_DEFINE_ENUM(NFSERR_NODEV);
+TRACE_DEFINE_ENUM(NFSERR_NOTDIR);
+TRACE_DEFINE_ENUM(NFSERR_ISDIR);
+TRACE_DEFINE_ENUM(NFSERR_INVAL);
+TRACE_DEFINE_ENUM(NFSERR_FBIG);
+TRACE_DEFINE_ENUM(NFSERR_NOSPC);
+TRACE_DEFINE_ENUM(NFSERR_ROFS);
+TRACE_DEFINE_ENUM(NFSERR_MLINK);
+TRACE_DEFINE_ENUM(NFSERR_OPNOTSUPP);
+TRACE_DEFINE_ENUM(NFSERR_NAMETOOLONG);
+TRACE_DEFINE_ENUM(NFSERR_NOTEMPTY);
+TRACE_DEFINE_ENUM(NFSERR_DQUOT);
+TRACE_DEFINE_ENUM(NFSERR_STALE);
+TRACE_DEFINE_ENUM(NFSERR_REMOTE);
+TRACE_DEFINE_ENUM(NFSERR_WFLUSH);
+TRACE_DEFINE_ENUM(NFSERR_BADHANDLE);
+TRACE_DEFINE_ENUM(NFSERR_NOT_SYNC);
+TRACE_DEFINE_ENUM(NFSERR_BAD_COOKIE);
+TRACE_DEFINE_ENUM(NFSERR_NOTSUPP);
+TRACE_DEFINE_ENUM(NFSERR_TOOSMALL);
+TRACE_DEFINE_ENUM(NFSERR_SERVERFAULT);
+TRACE_DEFINE_ENUM(NFSERR_BADTYPE);
+TRACE_DEFINE_ENUM(NFSERR_JUKEBOX);
+
+#define show_nfs_status(x) \
+	__print_symbolic(x, \
+		{ NFS_OK,			"OK" }, \
+		{ NFSERR_PERM,			"PERM" }, \
+		{ NFSERR_NOENT,			"NOENT" }, \
+		{ NFSERR_IO,			"IO" }, \
+		{ NFSERR_NXIO,			"NXIO" }, \
+		{ ECHILD,			"CHILD" }, \
+		{ NFSERR_EAGAIN,		"AGAIN" }, \
+		{ NFSERR_ACCES,			"ACCES" }, \
+		{ NFSERR_EXIST,			"EXIST" }, \
+		{ NFSERR_XDEV,			"XDEV" }, \
+		{ NFSERR_NODEV,			"NODEV" }, \
+		{ NFSERR_NOTDIR,		"NOTDIR" }, \
+		{ NFSERR_ISDIR,			"ISDIR" }, \
+		{ NFSERR_INVAL,			"INVAL" }, \
+		{ NFSERR_FBIG,			"FBIG" }, \
+		{ NFSERR_NOSPC,			"NOSPC" }, \
+		{ NFSERR_ROFS,			"ROFS" }, \
+		{ NFSERR_MLINK,			"MLINK" }, \
+		{ NFSERR_OPNOTSUPP,		"OPNOTSUPP" }, \
+		{ NFSERR_NAMETOOLONG,		"NAMETOOLONG" }, \
+		{ NFSERR_NOTEMPTY,		"NOTEMPTY" }, \
+		{ NFSERR_DQUOT,			"DQUOT" }, \
+		{ NFSERR_STALE,			"STALE" }, \
+		{ NFSERR_REMOTE,		"REMOTE" }, \
+		{ NFSERR_WFLUSH,		"WFLUSH" }, \
+		{ NFSERR_BADHANDLE,		"BADHANDLE" }, \
+		{ NFSERR_NOT_SYNC,		"NOTSYNC" }, \
+		{ NFSERR_BAD_COOKIE,		"BADCOOKIE" }, \
+		{ NFSERR_NOTSUPP,		"NOTSUPP" }, \
+		{ NFSERR_TOOSMALL,		"TOOSMALL" }, \
+		{ NFSERR_SERVERFAULT,		"REMOTEIO" }, \
+		{ NFSERR_BADTYPE,		"BADTYPE" }, \
+		{ NFSERR_JUKEBOX,		"JUKEBOX" })
+
+TRACE_DEFINE_ENUM(NFS_UNSTABLE);
+TRACE_DEFINE_ENUM(NFS_DATA_SYNC);
+TRACE_DEFINE_ENUM(NFS_FILE_SYNC);
+
+#define show_nfs_stable_how(x) \
+	__print_symbolic(x, \
+		{ NFS_UNSTABLE,			"UNSTABLE" }, \
+		{ NFS_DATA_SYNC,		"DATA_SYNC" }, \
+		{ NFS_FILE_SYNC,		"FILE_SYNC" })
+
+TRACE_DEFINE_ENUM(NFS4_OK);
+TRACE_DEFINE_ENUM(NFS4ERR_ACCESS);
+TRACE_DEFINE_ENUM(NFS4ERR_ATTRNOTSUPP);
+TRACE_DEFINE_ENUM(NFS4ERR_ADMIN_REVOKED);
+TRACE_DEFINE_ENUM(NFS4ERR_BACK_CHAN_BUSY);
+TRACE_DEFINE_ENUM(NFS4ERR_BADCHAR);
+TRACE_DEFINE_ENUM(NFS4ERR_BADHANDLE);
+TRACE_DEFINE_ENUM(NFS4ERR_BADIOMODE);
+TRACE_DEFINE_ENUM(NFS4ERR_BADLAYOUT);
+TRACE_DEFINE_ENUM(NFS4ERR_BADLABEL);
+TRACE_DEFINE_ENUM(NFS4ERR_BADNAME);
+TRACE_DEFINE_ENUM(NFS4ERR_BADOWNER);
+TRACE_DEFINE_ENUM(NFS4ERR_BADSESSION);
+TRACE_DEFINE_ENUM(NFS4ERR_BADSLOT);
+TRACE_DEFINE_ENUM(NFS4ERR_BADTYPE);
+TRACE_DEFINE_ENUM(NFS4ERR_BADXDR);
+TRACE_DEFINE_ENUM(NFS4ERR_BAD_COOKIE);
+TRACE_DEFINE_ENUM(NFS4ERR_BAD_HIGH_SLOT);
+TRACE_DEFINE_ENUM(NFS4ERR_BAD_RANGE);
+TRACE_DEFINE_ENUM(NFS4ERR_BAD_SEQID);
+TRACE_DEFINE_ENUM(NFS4ERR_BAD_SESSION_DIGEST);
+TRACE_DEFINE_ENUM(NFS4ERR_BAD_STATEID);
+TRACE_DEFINE_ENUM(NFS4ERR_CB_PATH_DOWN);
+TRACE_DEFINE_ENUM(NFS4ERR_CLID_INUSE);
+TRACE_DEFINE_ENUM(NFS4ERR_CLIENTID_BUSY);
+TRACE_DEFINE_ENUM(NFS4ERR_COMPLETE_ALREADY);
+TRACE_DEFINE_ENUM(NFS4ERR_CONN_NOT_BOUND_TO_SESSION);
+TRACE_DEFINE_ENUM(NFS4ERR_DEADLOCK);
+TRACE_DEFINE_ENUM(NFS4ERR_DEADSESSION);
+TRACE_DEFINE_ENUM(NFS4ERR_DELAY);
+TRACE_DEFINE_ENUM(NFS4ERR_DELEG_ALREADY_WANTED);
+TRACE_DEFINE_ENUM(NFS4ERR_DELEG_REVOKED);
+TRACE_DEFINE_ENUM(NFS4ERR_DENIED);
+TRACE_DEFINE_ENUM(NFS4ERR_DIRDELEG_UNAVAIL);
+TRACE_DEFINE_ENUM(NFS4ERR_DQUOT);
+TRACE_DEFINE_ENUM(NFS4ERR_ENCR_ALG_UNSUPP);
+TRACE_DEFINE_ENUM(NFS4ERR_EXIST);
+TRACE_DEFINE_ENUM(NFS4ERR_EXPIRED);
+TRACE_DEFINE_ENUM(NFS4ERR_FBIG);
+TRACE_DEFINE_ENUM(NFS4ERR_FHEXPIRED);
+TRACE_DEFINE_ENUM(NFS4ERR_FILE_OPEN);
+TRACE_DEFINE_ENUM(NFS4ERR_GRACE);
+TRACE_DEFINE_ENUM(NFS4ERR_HASH_ALG_UNSUPP);
+TRACE_DEFINE_ENUM(NFS4ERR_INVAL);
+TRACE_DEFINE_ENUM(NFS4ERR_IO);
+TRACE_DEFINE_ENUM(NFS4ERR_ISDIR);
+TRACE_DEFINE_ENUM(NFS4ERR_LAYOUTTRYLATER);
+TRACE_DEFINE_ENUM(NFS4ERR_LAYOUTUNAVAILABLE);
+TRACE_DEFINE_ENUM(NFS4ERR_LEASE_MOVED);
+TRACE_DEFINE_ENUM(NFS4ERR_LOCKED);
+TRACE_DEFINE_ENUM(NFS4ERR_LOCKS_HELD);
+TRACE_DEFINE_ENUM(NFS4ERR_LOCK_RANGE);
+TRACE_DEFINE_ENUM(NFS4ERR_MINOR_VERS_MISMATCH);
+TRACE_DEFINE_ENUM(NFS4ERR_MLINK);
+TRACE_DEFINE_ENUM(NFS4ERR_MOVED);
+TRACE_DEFINE_ENUM(NFS4ERR_NAMETOOLONG);
+TRACE_DEFINE_ENUM(NFS4ERR_NOENT);
+TRACE_DEFINE_ENUM(NFS4ERR_NOFILEHANDLE);
+TRACE_DEFINE_ENUM(NFS4ERR_NOMATCHING_LAYOUT);
+TRACE_DEFINE_ENUM(NFS4ERR_NOSPC);
+TRACE_DEFINE_ENUM(NFS4ERR_NOTDIR);
+TRACE_DEFINE_ENUM(NFS4ERR_NOTEMPTY);
+TRACE_DEFINE_ENUM(NFS4ERR_NOTSUPP);
+TRACE_DEFINE_ENUM(NFS4ERR_NOT_ONLY_OP);
+TRACE_DEFINE_ENUM(NFS4ERR_NOT_SAME);
+TRACE_DEFINE_ENUM(NFS4ERR_NO_GRACE);
+TRACE_DEFINE_ENUM(NFS4ERR_NXIO);
+TRACE_DEFINE_ENUM(NFS4ERR_OLD_STATEID);
+TRACE_DEFINE_ENUM(NFS4ERR_OPENMODE);
+TRACE_DEFINE_ENUM(NFS4ERR_OP_ILLEGAL);
+TRACE_DEFINE_ENUM(NFS4ERR_OP_NOT_IN_SESSION);
+TRACE_DEFINE_ENUM(NFS4ERR_PERM);
+TRACE_DEFINE_ENUM(NFS4ERR_PNFS_IO_HOLE);
+TRACE_DEFINE_ENUM(NFS4ERR_PNFS_NO_LAYOUT);
+TRACE_DEFINE_ENUM(NFS4ERR_RECALLCONFLICT);
+TRACE_DEFINE_ENUM(NFS4ERR_RECLAIM_BAD);
+TRACE_DEFINE_ENUM(NFS4ERR_RECLAIM_CONFLICT);
+TRACE_DEFINE_ENUM(NFS4ERR_REJECT_DELEG);
+TRACE_DEFINE_ENUM(NFS4ERR_REP_TOO_BIG);
+TRACE_DEFINE_ENUM(NFS4ERR_REP_TOO_BIG_TO_CACHE);
+TRACE_DEFINE_ENUM(NFS4ERR_REQ_TOO_BIG);
+TRACE_DEFINE_ENUM(NFS4ERR_RESOURCE);
+TRACE_DEFINE_ENUM(NFS4ERR_RESTOREFH);
+TRACE_DEFINE_ENUM(NFS4ERR_RETRY_UNCACHED_REP);
+TRACE_DEFINE_ENUM(NFS4ERR_RETURNCONFLICT);
+TRACE_DEFINE_ENUM(NFS4ERR_ROFS);
+TRACE_DEFINE_ENUM(NFS4ERR_SAME);
+TRACE_DEFINE_ENUM(NFS4ERR_SHARE_DENIED);
+TRACE_DEFINE_ENUM(NFS4ERR_SEQUENCE_POS);
+TRACE_DEFINE_ENUM(NFS4ERR_SEQ_FALSE_RETRY);
+TRACE_DEFINE_ENUM(NFS4ERR_SEQ_MISORDERED);
+TRACE_DEFINE_ENUM(NFS4ERR_SERVERFAULT);
+TRACE_DEFINE_ENUM(NFS4ERR_STALE);
+TRACE_DEFINE_ENUM(NFS4ERR_STALE_CLIENTID);
+TRACE_DEFINE_ENUM(NFS4ERR_STALE_STATEID);
+TRACE_DEFINE_ENUM(NFS4ERR_SYMLINK);
+TRACE_DEFINE_ENUM(NFS4ERR_TOOSMALL);
+TRACE_DEFINE_ENUM(NFS4ERR_TOO_MANY_OPS);
+TRACE_DEFINE_ENUM(NFS4ERR_UNKNOWN_LAYOUTTYPE);
+TRACE_DEFINE_ENUM(NFS4ERR_UNSAFE_COMPOUND);
+TRACE_DEFINE_ENUM(NFS4ERR_WRONGSEC);
+TRACE_DEFINE_ENUM(NFS4ERR_WRONG_CRED);
+TRACE_DEFINE_ENUM(NFS4ERR_WRONG_TYPE);
+TRACE_DEFINE_ENUM(NFS4ERR_XDEV);
+
+TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_MDS);
+TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_PNFS);
+
+#define show_nfs4_status(x) \
+	__print_symbolic(x, \
+		{ NFS4_OK,			"OK" }, \
+		{ EPERM,			"EPERM" }, \
+		{ ENOENT,			"ENOENT" }, \
+		{ EIO,				"EIO" }, \
+		{ ENXIO,			"ENXIO" }, \
+		{ EACCES,			"EACCES" }, \
+		{ EEXIST,			"EEXIST" }, \
+		{ EXDEV,			"EXDEV" }, \
+		{ ENOTDIR,			"ENOTDIR" }, \
+		{ EISDIR,			"EISDIR" }, \
+		{ EFBIG,			"EFBIG" }, \
+		{ ENOSPC,			"ENOSPC" }, \
+		{ EROFS,			"EROFS" }, \
+		{ EMLINK,			"EMLINK" }, \
+		{ ENAMETOOLONG,			"ENAMETOOLONG" }, \
+		{ ENOTEMPTY,			"ENOTEMPTY" }, \
+		{ EDQUOT,			"EDQUOT" }, \
+		{ ESTALE,			"ESTALE" }, \
+		{ EBADHANDLE,			"EBADHANDLE" }, \
+		{ EBADCOOKIE,			"EBADCOOKIE" }, \
+		{ ENOTSUPP,			"ENOTSUPP" }, \
+		{ ETOOSMALL,			"ETOOSMALL" }, \
+		{ EREMOTEIO,			"EREMOTEIO" }, \
+		{ EBADTYPE,			"EBADTYPE" }, \
+		{ EAGAIN,			"EAGAIN" }, \
+		{ ELOOP,			"ELOOP" }, \
+		{ EOPNOTSUPP,			"EOPNOTSUPP" }, \
+		{ EDEADLK,			"EDEADLK" }, \
+		{ ENOMEM,			"ENOMEM" }, \
+		{ EKEYEXPIRED,			"EKEYEXPIRED" }, \
+		{ ETIMEDOUT,			"ETIMEDOUT" }, \
+		{ ERESTARTSYS,			"ERESTARTSYS" }, \
+		{ ECONNREFUSED,			"ECONNREFUSED" }, \
+		{ ECONNRESET,			"ECONNRESET" }, \
+		{ ENETUNREACH,			"ENETUNREACH" }, \
+		{ EHOSTUNREACH,			"EHOSTUNREACH" }, \
+		{ EHOSTDOWN,			"EHOSTDOWN" }, \
+		{ EPIPE,			"EPIPE" }, \
+		{ EPFNOSUPPORT,			"EPFNOSUPPORT" }, \
+		{ EPROTONOSUPPORT,		"EPROTONOSUPPORT" }, \
+		{ NFS4ERR_ACCESS,		"ACCESS" }, \
+		{ NFS4ERR_ATTRNOTSUPP,		"ATTRNOTSUPP" }, \
+		{ NFS4ERR_ADMIN_REVOKED,	"ADMIN_REVOKED" }, \
+		{ NFS4ERR_BACK_CHAN_BUSY,	"BACK_CHAN_BUSY" }, \
+		{ NFS4ERR_BADCHAR,		"BADCHAR" }, \
+		{ NFS4ERR_BADHANDLE,		"BADHANDLE" }, \
+		{ NFS4ERR_BADIOMODE,		"BADIOMODE" }, \
+		{ NFS4ERR_BADLAYOUT,		"BADLAYOUT" }, \
+		{ NFS4ERR_BADLABEL,		"BADLABEL" }, \
+		{ NFS4ERR_BADNAME,		"BADNAME" }, \
+		{ NFS4ERR_BADOWNER,		"BADOWNER" }, \
+		{ NFS4ERR_BADSESSION,		"BADSESSION" }, \
+		{ NFS4ERR_BADSLOT,		"BADSLOT" }, \
+		{ NFS4ERR_BADTYPE,		"BADTYPE" }, \
+		{ NFS4ERR_BADXDR,		"BADXDR" }, \
+		{ NFS4ERR_BAD_COOKIE,		"BAD_COOKIE" }, \
+		{ NFS4ERR_BAD_HIGH_SLOT,	"BAD_HIGH_SLOT" }, \
+		{ NFS4ERR_BAD_RANGE,		"BAD_RANGE" }, \
+		{ NFS4ERR_BAD_SEQID,		"BAD_SEQID" }, \
+		{ NFS4ERR_BAD_SESSION_DIGEST,	"BAD_SESSION_DIGEST" }, \
+		{ NFS4ERR_BAD_STATEID,		"BAD_STATEID" }, \
+		{ NFS4ERR_CB_PATH_DOWN,		"CB_PATH_DOWN" }, \
+		{ NFS4ERR_CLID_INUSE,		"CLID_INUSE" }, \
+		{ NFS4ERR_CLIENTID_BUSY,	"CLIENTID_BUSY" }, \
+		{ NFS4ERR_COMPLETE_ALREADY,	"COMPLETE_ALREADY" }, \
+		{ NFS4ERR_CONN_NOT_BOUND_TO_SESSION, "CONN_NOT_BOUND_TO_SESSION" }, \
+		{ NFS4ERR_DEADLOCK,		"DEADLOCK" }, \
+		{ NFS4ERR_DEADSESSION,		"DEAD_SESSION" }, \
+		{ NFS4ERR_DELAY,		"DELAY" }, \
+		{ NFS4ERR_DELEG_ALREADY_WANTED,	"DELEG_ALREADY_WANTED" }, \
+		{ NFS4ERR_DELEG_REVOKED,	"DELEG_REVOKED" }, \
+		{ NFS4ERR_DENIED,		"DENIED" }, \
+		{ NFS4ERR_DIRDELEG_UNAVAIL,	"DIRDELEG_UNAVAIL" }, \
+		{ NFS4ERR_DQUOT,		"DQUOT" }, \
+		{ NFS4ERR_ENCR_ALG_UNSUPP,	"ENCR_ALG_UNSUPP" }, \
+		{ NFS4ERR_EXIST,		"EXIST" }, \
+		{ NFS4ERR_EXPIRED,		"EXPIRED" }, \
+		{ NFS4ERR_FBIG,			"FBIG" }, \
+		{ NFS4ERR_FHEXPIRED,		"FHEXPIRED" }, \
+		{ NFS4ERR_FILE_OPEN,		"FILE_OPEN" }, \
+		{ NFS4ERR_GRACE,		"GRACE" }, \
+		{ NFS4ERR_HASH_ALG_UNSUPP,	"HASH_ALG_UNSUPP" }, \
+		{ NFS4ERR_INVAL,		"INVAL" }, \
+		{ NFS4ERR_IO,			"IO" }, \
+		{ NFS4ERR_ISDIR,		"ISDIR" }, \
+		{ NFS4ERR_LAYOUTTRYLATER,	"LAYOUTTRYLATER" }, \
+		{ NFS4ERR_LAYOUTUNAVAILABLE,	"LAYOUTUNAVAILABLE" }, \
+		{ NFS4ERR_LEASE_MOVED,		"LEASE_MOVED" }, \
+		{ NFS4ERR_LOCKED,		"LOCKED" }, \
+		{ NFS4ERR_LOCKS_HELD,		"LOCKS_HELD" }, \
+		{ NFS4ERR_LOCK_RANGE,		"LOCK_RANGE" }, \
+		{ NFS4ERR_MINOR_VERS_MISMATCH,	"MINOR_VERS_MISMATCH" }, \
+		{ NFS4ERR_MLINK,		"MLINK" }, \
+		{ NFS4ERR_MOVED,		"MOVED" }, \
+		{ NFS4ERR_NAMETOOLONG,		"NAMETOOLONG" }, \
+		{ NFS4ERR_NOENT,		"NOENT" }, \
+		{ NFS4ERR_NOFILEHANDLE,		"NOFILEHANDLE" }, \
+		{ NFS4ERR_NOMATCHING_LAYOUT,	"NOMATCHING_LAYOUT" }, \
+		{ NFS4ERR_NOSPC,		"NOSPC" }, \
+		{ NFS4ERR_NOTDIR,		"NOTDIR" }, \
+		{ NFS4ERR_NOTEMPTY,		"NOTEMPTY" }, \
+		{ NFS4ERR_NOTSUPP,		"NOTSUPP" }, \
+		{ NFS4ERR_NOT_ONLY_OP,		"NOT_ONLY_OP" }, \
+		{ NFS4ERR_NOT_SAME,		"NOT_SAME" }, \
+		{ NFS4ERR_NO_GRACE,		"NO_GRACE" }, \
+		{ NFS4ERR_NXIO,			"NXIO" }, \
+		{ NFS4ERR_OLD_STATEID,		"OLD_STATEID" }, \
+		{ NFS4ERR_OPENMODE,		"OPENMODE" }, \
+		{ NFS4ERR_OP_ILLEGAL,		"OP_ILLEGAL" }, \
+		{ NFS4ERR_OP_NOT_IN_SESSION,	"OP_NOT_IN_SESSION" }, \
+		{ NFS4ERR_PERM,			"PERM" }, \
+		{ NFS4ERR_PNFS_IO_HOLE,		"PNFS_IO_HOLE" }, \
+		{ NFS4ERR_PNFS_NO_LAYOUT,	"PNFS_NO_LAYOUT" }, \
+		{ NFS4ERR_RECALLCONFLICT,	"RECALLCONFLICT" }, \
+		{ NFS4ERR_RECLAIM_BAD,		"RECLAIM_BAD" }, \
+		{ NFS4ERR_RECLAIM_CONFLICT,	"RECLAIM_CONFLICT" }, \
+		{ NFS4ERR_REJECT_DELEG,		"REJECT_DELEG" }, \
+		{ NFS4ERR_REP_TOO_BIG,		"REP_TOO_BIG" }, \
+		{ NFS4ERR_REP_TOO_BIG_TO_CACHE,	"REP_TOO_BIG_TO_CACHE" }, \
+		{ NFS4ERR_REQ_TOO_BIG,		"REQ_TOO_BIG" }, \
+		{ NFS4ERR_RESOURCE,		"RESOURCE" }, \
+		{ NFS4ERR_RESTOREFH,		"RESTOREFH" }, \
+		{ NFS4ERR_RETRY_UNCACHED_REP,	"RETRY_UNCACHED_REP" }, \
+		{ NFS4ERR_RETURNCONFLICT,	"RETURNCONFLICT" }, \
+		{ NFS4ERR_ROFS,			"ROFS" }, \
+		{ NFS4ERR_SAME,			"SAME" }, \
+		{ NFS4ERR_SHARE_DENIED,		"SHARE_DENIED" }, \
+		{ NFS4ERR_SEQUENCE_POS,		"SEQUENCE_POS" }, \
+		{ NFS4ERR_SEQ_FALSE_RETRY,	"SEQ_FALSE_RETRY" }, \
+		{ NFS4ERR_SEQ_MISORDERED,	"SEQ_MISORDERED" }, \
+		{ NFS4ERR_SERVERFAULT,		"SERVERFAULT" }, \
+		{ NFS4ERR_STALE,		"STALE" }, \
+		{ NFS4ERR_STALE_CLIENTID,	"STALE_CLIENTID" }, \
+		{ NFS4ERR_STALE_STATEID,	"STALE_STATEID" }, \
+		{ NFS4ERR_SYMLINK,		"SYMLINK" }, \
+		{ NFS4ERR_TOOSMALL,		"TOOSMALL" }, \
+		{ NFS4ERR_TOO_MANY_OPS,		"TOO_MANY_OPS" }, \
+		{ NFS4ERR_UNKNOWN_LAYOUTTYPE,	"UNKNOWN_LAYOUTTYPE" }, \
+		{ NFS4ERR_UNSAFE_COMPOUND,	"UNSAFE_COMPOUND" }, \
+		{ NFS4ERR_WRONGSEC,		"WRONGSEC" }, \
+		{ NFS4ERR_WRONG_CRED,		"WRONG_CRED" }, \
+		{ NFS4ERR_WRONG_TYPE,		"WRONG_TYPE" }, \
+		{ NFS4ERR_XDEV,			"XDEV" }, \
+		/* ***** Internal to Linux NFS client ***** */ \
+		{ NFS4ERR_RESET_TO_MDS,		"RESET_TO_MDS" }, \
+		{ NFS4ERR_RESET_TO_PNFS,	"RESET_TO_PNFS" })
+
+#define show_nfs4_verifier(x) \
+	__print_hex_str(x, NFS4_VERIFIER_SIZE)
+
+TRACE_DEFINE_ENUM(IOMODE_READ);
+TRACE_DEFINE_ENUM(IOMODE_RW);
+TRACE_DEFINE_ENUM(IOMODE_ANY);
+
+#define show_pnfs_layout_iomode(x) \
+	__print_symbolic(x, \
+		{ IOMODE_READ,			"READ" }, \
+		{ IOMODE_RW,			"RW" }, \
+		{ IOMODE_ANY,			"ANY" })
+
+#define show_nfs4_seq4_status(x) \
+	__print_flags(x, "|", \
+		{ SEQ4_STATUS_CB_PATH_DOWN,		"CB_PATH_DOWN" }, \
+		{ SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRING,	"CB_GSS_CONTEXTS_EXPIRING" }, \
+		{ SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRED,	"CB_GSS_CONTEXTS_EXPIRED" }, \
+		{ SEQ4_STATUS_EXPIRED_ALL_STATE_REVOKED, "EXPIRED_ALL_STATE_REVOKED" }, \
+		{ SEQ4_STATUS_EXPIRED_SOME_STATE_REVOKED, "EXPIRED_SOME_STATE_REVOKED" }, \
+		{ SEQ4_STATUS_ADMIN_STATE_REVOKED,	"ADMIN_STATE_REVOKED" }, \
+		{ SEQ4_STATUS_RECALLABLE_STATE_REVOKED,	"RECALLABLE_STATE_REVOKED" }, \
+		{ SEQ4_STATUS_LEASE_MOVED,		"LEASE_MOVED" }, \
+		{ SEQ4_STATUS_RESTART_RECLAIM_NEEDED,	"RESTART_RECLAIM_NEEDED" }, \
+		{ SEQ4_STATUS_CB_PATH_DOWN_SESSION,	"CB_PATH_DOWN_SESSION" }, \
+		{ SEQ4_STATUS_BACKCHANNEL_FAULT,	"BACKCHANNEL_FAULT" })
diff --git a/include/trace/misc/rdma.h b/include/trace/misc/rdma.h
new file mode 100644
index 000000000000..81bb454fc288
--- /dev/null
+++ b/include/trace/misc/rdma.h
@@ -0,0 +1,168 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017 Oracle.  All rights reserved.
+ */
+
+/*
+ * enum ib_event_type, from include/rdma/ib_verbs.h
+ */
+#define IB_EVENT_LIST				\
+	ib_event(CQ_ERR)			\
+	ib_event(QP_FATAL)			\
+	ib_event(QP_REQ_ERR)			\
+	ib_event(QP_ACCESS_ERR)			\
+	ib_event(COMM_EST)			\
+	ib_event(SQ_DRAINED)			\
+	ib_event(PATH_MIG)			\
+	ib_event(PATH_MIG_ERR)			\
+	ib_event(DEVICE_FATAL)			\
+	ib_event(PORT_ACTIVE)			\
+	ib_event(PORT_ERR)			\
+	ib_event(LID_CHANGE)			\
+	ib_event(PKEY_CHANGE)			\
+	ib_event(SM_CHANGE)			\
+	ib_event(SRQ_ERR)			\
+	ib_event(SRQ_LIMIT_REACHED)		\
+	ib_event(QP_LAST_WQE_REACHED)		\
+	ib_event(CLIENT_REREGISTER)		\
+	ib_event(GID_CHANGE)			\
+	ib_event_end(WQ_FATAL)
+
+#undef ib_event
+#undef ib_event_end
+
+#define ib_event(x)		TRACE_DEFINE_ENUM(IB_EVENT_##x);
+#define ib_event_end(x)		TRACE_DEFINE_ENUM(IB_EVENT_##x);
+
+IB_EVENT_LIST
+
+#undef ib_event
+#undef ib_event_end
+
+#define ib_event(x)		{ IB_EVENT_##x, #x },
+#define ib_event_end(x)		{ IB_EVENT_##x, #x }
+
+#define rdma_show_ib_event(x) \
+		__print_symbolic(x, IB_EVENT_LIST)
+
+/*
+ * enum ib_wc_status type, from include/rdma/ib_verbs.h
+ */
+#define IB_WC_STATUS_LIST			\
+	ib_wc_status(SUCCESS)			\
+	ib_wc_status(LOC_LEN_ERR)		\
+	ib_wc_status(LOC_QP_OP_ERR)		\
+	ib_wc_status(LOC_EEC_OP_ERR)		\
+	ib_wc_status(LOC_PROT_ERR)		\
+	ib_wc_status(WR_FLUSH_ERR)		\
+	ib_wc_status(MW_BIND_ERR)		\
+	ib_wc_status(BAD_RESP_ERR)		\
+	ib_wc_status(LOC_ACCESS_ERR)		\
+	ib_wc_status(REM_INV_REQ_ERR)		\
+	ib_wc_status(REM_ACCESS_ERR)		\
+	ib_wc_status(REM_OP_ERR)		\
+	ib_wc_status(RETRY_EXC_ERR)		\
+	ib_wc_status(RNR_RETRY_EXC_ERR)		\
+	ib_wc_status(LOC_RDD_VIOL_ERR)		\
+	ib_wc_status(REM_INV_RD_REQ_ERR)	\
+	ib_wc_status(REM_ABORT_ERR)		\
+	ib_wc_status(INV_EECN_ERR)		\
+	ib_wc_status(INV_EEC_STATE_ERR)		\
+	ib_wc_status(FATAL_ERR)			\
+	ib_wc_status(RESP_TIMEOUT_ERR)		\
+	ib_wc_status_end(GENERAL_ERR)
+
+#undef ib_wc_status
+#undef ib_wc_status_end
+
+#define ib_wc_status(x)		TRACE_DEFINE_ENUM(IB_WC_##x);
+#define ib_wc_status_end(x)	TRACE_DEFINE_ENUM(IB_WC_##x);
+
+IB_WC_STATUS_LIST
+
+#undef ib_wc_status
+#undef ib_wc_status_end
+
+#define ib_wc_status(x)		{ IB_WC_##x, #x },
+#define ib_wc_status_end(x)	{ IB_WC_##x, #x }
+
+#define rdma_show_wc_status(x) \
+		__print_symbolic(x, IB_WC_STATUS_LIST)
+
+/*
+ * enum ib_cm_event_type, from include/rdma/ib_cm.h
+ */
+#define IB_CM_EVENT_LIST			\
+	ib_cm_event(REQ_ERROR)			\
+	ib_cm_event(REQ_RECEIVED)		\
+	ib_cm_event(REP_ERROR)			\
+	ib_cm_event(REP_RECEIVED)		\
+	ib_cm_event(RTU_RECEIVED)		\
+	ib_cm_event(USER_ESTABLISHED)		\
+	ib_cm_event(DREQ_ERROR)			\
+	ib_cm_event(DREQ_RECEIVED)		\
+	ib_cm_event(DREP_RECEIVED)		\
+	ib_cm_event(TIMEWAIT_EXIT)		\
+	ib_cm_event(MRA_RECEIVED)		\
+	ib_cm_event(REJ_RECEIVED)		\
+	ib_cm_event(LAP_ERROR)			\
+	ib_cm_event(LAP_RECEIVED)		\
+	ib_cm_event(APR_RECEIVED)		\
+	ib_cm_event(SIDR_REQ_ERROR)		\
+	ib_cm_event(SIDR_REQ_RECEIVED)		\
+	ib_cm_event_end(SIDR_REP_RECEIVED)
+
+#undef ib_cm_event
+#undef ib_cm_event_end
+
+#define ib_cm_event(x)		TRACE_DEFINE_ENUM(IB_CM_##x);
+#define ib_cm_event_end(x)	TRACE_DEFINE_ENUM(IB_CM_##x);
+
+IB_CM_EVENT_LIST
+
+#undef ib_cm_event
+#undef ib_cm_event_end
+
+#define ib_cm_event(x)		{ IB_CM_##x, #x },
+#define ib_cm_event_end(x)	{ IB_CM_##x, #x }
+
+#define rdma_show_ib_cm_event(x) \
+		__print_symbolic(x, IB_CM_EVENT_LIST)
+
+/*
+ * enum rdma_cm_event_type, from include/rdma/rdma_cm.h
+ */
+#define RDMA_CM_EVENT_LIST			\
+	rdma_cm_event(ADDR_RESOLVED)		\
+	rdma_cm_event(ADDR_ERROR)		\
+	rdma_cm_event(ROUTE_RESOLVED)		\
+	rdma_cm_event(ROUTE_ERROR)		\
+	rdma_cm_event(CONNECT_REQUEST)		\
+	rdma_cm_event(CONNECT_RESPONSE)		\
+	rdma_cm_event(CONNECT_ERROR)		\
+	rdma_cm_event(UNREACHABLE)		\
+	rdma_cm_event(REJECTED)			\
+	rdma_cm_event(ESTABLISHED)		\
+	rdma_cm_event(DISCONNECTED)		\
+	rdma_cm_event(DEVICE_REMOVAL)		\
+	rdma_cm_event(MULTICAST_JOIN)		\
+	rdma_cm_event(MULTICAST_ERROR)		\
+	rdma_cm_event(ADDR_CHANGE)		\
+	rdma_cm_event_end(TIMEWAIT_EXIT)
+
+#undef rdma_cm_event
+#undef rdma_cm_event_end
+
+#define rdma_cm_event(x)	TRACE_DEFINE_ENUM(RDMA_CM_EVENT_##x);
+#define rdma_cm_event_end(x)	TRACE_DEFINE_ENUM(RDMA_CM_EVENT_##x);
+
+RDMA_CM_EVENT_LIST
+
+#undef rdma_cm_event
+#undef rdma_cm_event_end
+
+#define rdma_cm_event(x)	{ RDMA_CM_EVENT_##x, #x },
+#define rdma_cm_event_end(x)	{ RDMA_CM_EVENT_##x, #x }
+
+#define rdma_show_cm_event(x) \
+		__print_symbolic(x, RDMA_CM_EVENT_LIST)
diff --git a/include/trace/misc/sunrpc.h b/include/trace/misc/sunrpc.h
new file mode 100644
index 000000000000..588557d07ea8
--- /dev/null
+++ b/include/trace/misc/sunrpc.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Oracle and/or its affiliates.
+ *
+ * Common types and format specifiers for sunrpc.
+ */
+
+#if !defined(_TRACE_SUNRPC_BASE_H)
+#define _TRACE_SUNRPC_BASE_H
+
+#include <linux/tracepoint.h>
+
+#define SUNRPC_TRACE_PID_SPECIFIER	"%08x"
+#define SUNRPC_TRACE_CLID_SPECIFIER	"%08x"
+#define SUNRPC_TRACE_TASK_SPECIFIER \
+	"task:" SUNRPC_TRACE_PID_SPECIFIER "@" SUNRPC_TRACE_CLID_SPECIFIER
+
+#endif /* _TRACE_SUNRPC_BASE_H */


