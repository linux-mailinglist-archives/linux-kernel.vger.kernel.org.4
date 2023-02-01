Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C79C681F30
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjA3W74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjA3W6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:58:45 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C89A61EFFE;
        Mon, 30 Jan 2023 14:58:43 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1052)
        id 3F61120EA1F0; Mon, 30 Jan 2023 14:58:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F61120EA1F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675119522;
        bh=0c0+AaCGGBDGeKFGA+85oI5UMusd99Vy2wjZaBp/JcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MYfUyc5caOURmq49LUTd7XT6B3dgpKpozAsen+YIpLXv3iHzbK96ywti2/7vyJVLY
         hCNF8JXnES8hK17SiOY/B6dLWuuqWdVWW2qlRAo1brTtT5IbqwNrxxQLdUgoXxyk/E
         sAyia8eRBCNLaRWoOtw0f/H/xbJNFqmGMlNstoJg=
From:   Fan Wu <wufan@linux.microsoft.com>
To:     corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org,
        axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        eparis@redhat.com, paul@paul-moore.com
Cc:     linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, linux-audit@redhat.com,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Fan Wu <wufan@linux.microsoft.com>
Subject: [RFC PATCH v9 06/16] ipe: add LSM hooks on execution and kernel read
Date:   Mon, 30 Jan 2023 14:57:21 -0800
Message-Id: <1675119451-23180-7-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675119451-23180-1-git-send-email-wufan@linux.microsoft.com>
References: <1675119451-23180-1-git-send-email-wufan@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Deven Bowers <deven.desai@linux.microsoft.com>

IPE's initial goal is to control both execution and the loading of
kernel modules based on the system's definition of trust. It
accomplishes this by plugging into the security hooks for
bprm_check_security, file_mprotect, mmap_file, kernel_load_data,
and kernel_read_data.

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
---
v2:
  + Split evaluation loop, access control hooks,
    and evaluation loop from policy parser and userspace
    interface to pass mailing list character limit

v3:
  + Move ipe_load_properties to patch 04.
  + Remove useless 0-initializations
  + Prefix extern variables with ipe_
  + Remove kernel module parameters, as these are
    exposed through sysctls.
  + Add more prose to the IPE base config option
    help text.
  + Use GFP_KERNEL for audit_log_start.
  + Remove unnecessary caching system.
  + Remove comments from headers
  + Use rcu_access_pointer for rcu-pointer null check
  + Remove usage of reqprot; use prot only.
  + Move policy load and activation audit event to 03/12

v4:
  + Remove sysctls in favor of securityfs nodes
  + Re-add kernel module parameters, as these are now
    exposed through securityfs.
  + Refactor property audit loop to a separate function.

v5:
  + fix minor grammatical errors
  + do not group rule by curly-brace in audit record,
    reconstruct the exact rule.

v6:
  + No changes

v7:
  + Further split lsm creation, the audit system, the evaluation loop
    and access control hooks into separate commits.

v8:
  + Rename hook functions to follow the lsmname_hook_name convention
  + Remove ipe_hook enumeration, can be derived from correlation with
    syscall audit record.

v9:
  + Minor changes for adapting to the new parser
---
 security/ipe/hooks.c | 169 +++++++++++++++++++++++++++++++++++++++++++
 security/ipe/hooks.h |  13 ++++
 security/ipe/ipe.c   |   6 ++
 3 files changed, 188 insertions(+)

diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
index 335b773c7ae1..fd5109e29c76 100644
--- a/security/ipe/hooks.c
+++ b/security/ipe/hooks.c
@@ -23,3 +23,172 @@ void ipe_sb_free_security(struct super_block *mnt_sb)
 {
 	ipe_invalidate_pinned_sb(mnt_sb);
 }
+
+/**
+ * ipe_bprm_check_security - ipe security hook function for bprm check.
+ * @bprm: Supplies a pointer to a linux_binprm structure to source the file
+ *	  being evaluated.
+ *
+ * This LSM hook is called when a binary is loaded through the exec
+ * family of system calls.
+ * Return:
+ * *0	- OK
+ * *!0	- Error
+ */
+int ipe_bprm_check_security(struct linux_binprm *bprm)
+{
+	struct ipe_eval_ctx ctx = { 0 };
+
+	build_eval_ctx(&ctx, bprm->file, ipe_op_exec);
+	return ipe_evaluate_event(&ctx);
+}
+
+/**
+ * ipe_mmap_file - ipe security hook function for mmap check.
+ * @f: File being mmap'd. Can be NULL in the case of anonymous memory.
+ * @reqprot: The requested protection on the mmap, passed from usermode.
+ * @prot: The effective protection on the mmap, resolved from reqprot and
+ *	  system configuration.
+ * @flags: Unused.
+ *
+ * This hook is called when a file is loaded through the mmap
+ * family of system calls.
+ *
+ * Return:
+ * * 0	- OK
+ * * !0	- Error
+ */
+int ipe_mmap_file(struct file *f, unsigned long reqprot, unsigned long prot,
+		  unsigned long flags)
+{
+	struct ipe_eval_ctx ctx = { 0 };
+
+	if (prot & PROT_EXEC || reqprot & PROT_EXEC) {
+		build_eval_ctx(&ctx, f, ipe_op_exec);
+		return ipe_evaluate_event(&ctx);
+	}
+
+	return 0;
+}
+
+/**
+ * ipe_file_mprotect - ipe security hook function for mprotect check.
+ * @vma: Existing virtual memory area created by mmap or similar.
+ * @reqprot: The requested protection on the mmap, passed from usermode.
+ * @prot: The effective protection on the mmap, resolved from reqprot and
+ *	  system configuration.
+ *
+ * This LSM hook is called when a mmap'd region of memory is changing
+ * its protections via mprotect.
+ *
+ * Return:
+ * * 0	- OK
+ * * !0	- Error
+ */
+int ipe_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
+		      unsigned long prot)
+{
+	struct ipe_eval_ctx ctx = { 0 };
+
+	/* Already Executable */
+	if (vma->vm_flags & VM_EXEC)
+		return 0;
+
+	if (prot & PROT_EXEC) {
+		build_eval_ctx(&ctx, vma->vm_file, ipe_op_exec);
+		return ipe_evaluate_event(&ctx);
+	}
+
+	return 0;
+}
+
+/**
+ * ipe_kernel_read_file - ipe security hook function for kernel read.
+ * @file: Supplies a pointer to the file structure being read in from disk.
+ * @id: Supplies the enumeration identifying the purpose of the read.
+ * @contents: Unused.
+ *
+ * This LSM hook is called when a file is being read in from disk from
+ * the kernel.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - Error
+ */
+int ipe_kernel_read_file(struct file *file, enum kernel_read_file_id id,
+			 bool contents)
+{
+	enum ipe_op_type op;
+	struct ipe_eval_ctx ctx;
+
+	switch (id) {
+	case READING_FIRMWARE:
+		op = ipe_op_firmware;
+		break;
+	case READING_MODULE:
+		op = ipe_op_kernel_module;
+		break;
+	case READING_KEXEC_INITRAMFS:
+		op = ipe_op_kexec_initramfs;
+		break;
+	case READING_KEXEC_IMAGE:
+		op = ipe_op_kexec_image;
+		break;
+	case READING_POLICY:
+		op = ipe_op_ima_policy;
+		break;
+	case READING_X509_CERTIFICATE:
+		op = ipe_op_ima_x509;
+		break;
+	default:
+		op = ipe_op_max;
+		WARN(op == ipe_op_max, "no rule setup for enum %d", id);
+	}
+
+	build_eval_ctx(&ctx, file, op);
+	return ipe_evaluate_event(&ctx);
+}
+
+/**
+ * ipe_kernel_load_data - ipe security hook function for kernel load data.
+ * @id: Supplies the enumeration identifying the purpose of the read.
+ * @contents: Unused.
+ *
+ * This LSM hook is called when a buffer is being read in from disk.
+ *
+ * Return:
+ * * 0	- OK
+ * * !0	- Error
+ */
+int ipe_kernel_load_data(enum kernel_load_data_id id, bool contents)
+{
+	enum ipe_op_type op;
+	struct ipe_eval_ctx ctx = { 0 };
+
+	switch (id) {
+	case LOADING_FIRMWARE:
+		op = ipe_op_firmware;
+		break;
+	case LOADING_MODULE:
+		op = ipe_op_kernel_module;
+		break;
+	case LOADING_KEXEC_INITRAMFS:
+		op = ipe_op_kexec_initramfs;
+		break;
+	case LOADING_KEXEC_IMAGE:
+		op = ipe_op_kexec_image;
+		break;
+	case LOADING_POLICY:
+		op = ipe_op_ima_policy;
+		break;
+	case LOADING_X509_CERTIFICATE:
+		op = ipe_op_ima_x509;
+		break;
+	default:
+		op = ipe_op_max;
+		WARN(op == ipe_op_max, "no rule setup for enum %d", id);
+	}
+
+	build_eval_ctx(&ctx, NULL, op);
+	return ipe_evaluate_event(&ctx);
+}
diff --git a/security/ipe/hooks.h b/security/ipe/hooks.h
index 30fe455389bf..857cae69678c 100644
--- a/security/ipe/hooks.h
+++ b/security/ipe/hooks.h
@@ -11,4 +11,17 @@
 
 void ipe_sb_free_security(struct super_block *mnt_sb);
 
+int ipe_bprm_check_security(struct linux_binprm *bprm);
+
+int ipe_mmap_file(struct file *f, unsigned long reqprot, unsigned long prot,
+		  unsigned long flags);
+
+int ipe_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
+		      unsigned long prot);
+
+int ipe_kernel_read_file(struct file *file, enum kernel_read_file_id id,
+			 bool contents);
+
+int ipe_kernel_load_data(enum kernel_load_data_id id, bool contents);
+
 #endif /* IPE_HOOKS_H */
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index bef923026b50..7af2f942decd 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -4,6 +4,7 @@
  */
 
 #include "ipe.h"
+#include "hooks.h"
 
 bool ipe_enabled;
 
@@ -12,6 +13,11 @@ static struct lsm_blob_sizes ipe_blobs __lsm_ro_after_init = {
 
 static struct security_hook_list ipe_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_free_security, ipe_sb_free_security),
+	LSM_HOOK_INIT(bprm_check_security, ipe_bprm_check_security),
+	LSM_HOOK_INIT(mmap_file, ipe_mmap_file),
+	LSM_HOOK_INIT(file_mprotect, ipe_file_mprotect),
+	LSM_HOOK_INIT(kernel_read_file, ipe_kernel_read_file),
+	LSM_HOOK_INIT(kernel_load_data, ipe_kernel_load_data),
 };
 
 /**
-- 
2.39.0

