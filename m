Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1E0675FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjATVwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjATVwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:52:11 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD6280BB0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:52:09 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id q130-20020a632a88000000b004a03cfb3ac6so3134095pgq.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vZLGH6GKpprsZryglGGsmlbnC99kz7Hmw/lP8KSRAIA=;
        b=H4S6MZ3Pu39FsRTnCqJAOdecUr98F5KodOtdYhzSnskQsZxaVRchBP/S8QXaAyCyeF
         pzl8QHq3Cognwhb+VTsm0Pw8X7dRVoRHokVU6LlRnsUPaOvRwyr597df0RFYLSkM2ly+
         MedNBuHyilOTTmDHZhqHeeH8hlSY9NvEH/zY2aPHkup/8sYOY53czXUT34wRZ/HRcCJC
         oYV4ecWyZejeGKtPvnJOmbgeWf/JyvZu+5qRDPkb4ayJyYiHwgdLKuCAPoSv7Uxit5sJ
         NoUYagoBzw2wc4y3EeEPrJlYVV13qRKbX/SeUDZwqdbDnzS5HetwWWSJznTvh3/XokSY
         fKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZLGH6GKpprsZryglGGsmlbnC99kz7Hmw/lP8KSRAIA=;
        b=o+B4/KlkzcrqUjrad3hBRhYckySDmstTwbuHvyNMImU0+jnUCqGbxUkHbXUAeCUoeN
         494lGnCsF7SlJqnr/3XUMazfQIhDcGSJ8tR2qpQdWJCokfiyHIjPtRFr99jGpx/vuCDs
         vWh136En+Cm2jUGhEXsYquExE1UqSvMQNPC9c1aIjYqSEvWgMzxBmIhd3eLOKWTkSNRS
         T7Zv4HNlw45ukWj3BJu1jWjoC7tP3/adNDi1HBRFMRIA1BXL2Z6dmkA1WhnN0R47JLh9
         kRWOwNGMmlgCOuYvvoJBwkMT2nVUI0J23IerBU7QTGY88Q0pdXJaYjB9DQtl7COk8/qQ
         RkFQ==
X-Gm-Message-State: AFqh2krKaPoOXhhrui8PSzEBqW7mIc6zrMUNdaV/p5b1BtRf1ZpLv+FY
        sQiqSvXFfLIv8YeYe2yZIGBAq6xvt0bh/kZF8A==
X-Google-Smtp-Source: AMrXdXvgnhUOxHnbYYU2gTk3XLNC4wEojLvl5cRHswvnKmIzlXmAibhm7cHfTYwECk4VrKSdyiTFkWrg5f4UKbDgpw==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a63:455a:0:b0:49f:5dc6:caf8 with SMTP
 id u26-20020a63455a000000b0049f5dc6caf8mr1692899pgk.41.1674251528854; Fri, 20
 Jan 2023 13:52:08 -0800 (PST)
Date:   Fri, 20 Jan 2023 21:48:55 +0000
In-Reply-To: <20230120214857.835931-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20230120214857.835931-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230120214857.835931-3-dionnaglaze@google.com>
Subject: [PATCH v12 2/3] x86/sev: Change snp_guest_issue_request's fw_err
From:   Dionna Glaze <dionnaglaze@google.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <Borislav.Petkov@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Sterritt <sterritt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GHCB specification declares that the firmware error value for a
guest request will be stored in the lower 32 bits of EXIT_INFO_2.
The upper 32 bits are for the VMM's own error code. The fw_err argument
is thus a misnomer, and callers will need access to all 64 bits.

The type of unsigned long also causes problems, since sw_exit_info2 is
u64 (unsigned long long) vs the argument's unsigned long*. This type
is changed for issuing the guest request. The ioctl command struct's
error field is passed directly instead of a local variable, since an
incomplete guest request may not set the error code, and uninitialized
stack memory would be written back to user space.

The firmware might not even be called, so the call is bookended with
the no firmware call error and clearing the error.

Since the "fw_err" field is really exitinfo2 split into the upper bits'
vmm error code and lower bits' firmware error code, sev-guest.h is
updated to represent the 64 bit value as a union.

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <Borislav.Petkov@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Michael Sterritt <sterritt@google.com>

Fixes: d5af44dde546 ("x86/sev: Provide support for SNP guest request NAEs")
Reviewed-by: Tom Lendacky <Thomas.Lendacky@amd.com>
Reviewed-by: Borislav Petkov <Borislav.Petkov@amd.com>
Reviewed-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/include/asm/sev-common.h       |  3 --
 arch/x86/include/asm/sev.h              |  4 +--
 arch/x86/kernel/sev.c                   | 13 ++++---
 drivers/virt/coco/sev-guest/sev-guest.c | 46 ++++++++++++-------------
 include/uapi/linux/sev-guest.h          | 18 ++++++++--
 5 files changed, 48 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index b8357d6ecd47..0759af9b1acf 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -128,9 +128,6 @@ struct snp_psc_desc {
 	struct psc_entry entries[VMGEXIT_PSC_MAX_ENTRY];
 } __packed;
 
-/* Guest message request error code */
-#define SNP_GUEST_REQ_INVALID_LEN	BIT_ULL(32)
-
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ebc271bb6d8e..05de34d10d89 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -196,7 +196,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
-int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err);
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, u64 *exitinfo2);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -217,7 +217,7 @@ static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
 static inline void snp_abort(void) { }
 static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input,
-					  unsigned long *fw_err)
+					  u64 *exitinfo2)
 {
 	return -ENOTTY;
 }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 679026a640ef..82aa81fafb71 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -22,6 +22,8 @@
 #include <linux/efi.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/psp-sev.h>
+#include <uapi/linux/sev-guest.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -2175,7 +2177,7 @@ static int __init init_sev_config(char *str)
 }
 __setup("sev=", init_sev_config);
 
-int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err)
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, u64 *exitinfo2)
 {
 	struct ghcb_state state;
 	struct es_em_ctxt ctxt;
@@ -2186,9 +2188,11 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return -ENODEV;
 
-	if (!fw_err)
+	if (!exitinfo2)
 		return -EINVAL;
 
+	*exitinfo2 = SEV_RET_NO_FW_CALL;
+
 	/*
 	 * __sev_get_ghcb() needs to run with IRQs disabled because it is using
 	 * a per-CPU GHCB.
@@ -2212,14 +2216,13 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
 	if (ret)
 		goto e_put;
 
+	*exitinfo2 = ghcb->save.sw_exit_info_2;
 	if (ghcb->save.sw_exit_info_2) {
 		/* Number of expected pages are returned in RBX */
 		if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
-		    ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_INVALID_LEN)
+			ghcb->save.sw_exit_info_2 == SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN))
 			input->data_npages = ghcb_get_rbx(ghcb);
 
-		*fw_err = ghcb->save.sw_exit_info_2;
-
 		ret = -EIO;
 	}
 
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 4ec4174e05a3..ed6fc14f6b00 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -318,11 +318,11 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 	return __enc_payload(snp_dev, req, payload, sz);
 }
 
-static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
-				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
-				u32 resp_sz, __u64 *fw_err)
+static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
+				struct snp_guest_request_ioctl *arg,
+				u8 type, void *req_buf, size_t req_sz,
+				void *resp_buf, u32 resp_sz)
 {
-	unsigned long err;
 	u64 seqno;
 	int rc;
 
@@ -334,7 +334,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
 
 	/* Encrypt the userspace provided payload */
-	rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
+	rc = enc_payload(snp_dev, seqno, arg->msg_version, type, req_buf, req_sz);
 	if (rc)
 		return rc;
 
@@ -344,7 +344,8 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	 * sequence number must be incremented or the VMPCK must be deleted to
 	 * prevent reuse of the IV.
 	 */
-	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
+	rc = snp_issue_guest_request(exit_code, &snp_dev->input,
+				     &arg->exitinfo2);
 
 	/*
 	 * If the extended guest request fails due to having too small of a
@@ -353,7 +354,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	 * and thus avoid IV reuse.
 	 */
 	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
-	    err == SNP_GUEST_REQ_INVALID_LEN) {
+	    arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
 		const unsigned int certs_npages = snp_dev->input.data_npages;
 
 		exit_code = SVM_VMGEXIT_GUEST_REQUEST;
@@ -366,24 +367,22 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 		 * of the VMPCK and the error code being propagated back to the
 		 * user as an ioctl() return code.
 		 */
-		rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
+		rc = snp_issue_guest_request(exit_code, &snp_dev->input,
+					     &arg->exitinfo2);
 
 		/*
 		 * Override the error to inform callers the given extended
 		 * request buffer size was too small and give the caller the
 		 * required buffer size.
 		 */
-		err = SNP_GUEST_REQ_INVALID_LEN;
+		arg->vmm_error = SNP_GUEST_VMM_ERR_INVALID_LEN;
 		snp_dev->input.data_npages = certs_npages;
 	}
 
-	if (fw_err)
-		*fw_err = err;
-
 	if (rc) {
 		dev_alert(snp_dev->dev,
-			  "Detected error from ASP request. rc: %d, fw_err: %llu\n",
-			  rc, *fw_err);
+			  "Detected error from ASP request. rc: %d, exitinfo2: %llu\n",
+			  rc, arg->exitinfo2);
 		goto disable_vmpck;
 	}
 
@@ -430,9 +429,9 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	if (!resp)
 		return -ENOMEM;
 
-	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
+	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
 				  SNP_MSG_REPORT_REQ, &req, sizeof(req), resp->data,
-				  resp_len, &arg->fw_err);
+				  resp_len);
 	if (rc)
 		goto e_free;
 
@@ -470,9 +469,8 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
 		return -EFAULT;
 
-	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
-				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
-				  &arg->fw_err);
+	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
+				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len);
 	if (rc)
 		return rc;
 
@@ -532,12 +530,12 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 		return -ENOMEM;
 
 	snp_dev->input.data_npages = npages;
-	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg->msg_version,
+	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg,
 				   SNP_MSG_REPORT_REQ, &req.data,
-				   sizeof(req.data), resp->data, resp_len, &arg->fw_err);
+				   sizeof(req.data), resp->data, resp_len);
 
 	/* If certs length is invalid then copy the returned length */
-	if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
+	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
 		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
 
 		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
@@ -572,7 +570,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	if (copy_from_user(&input, argp, sizeof(input)))
 		return -EFAULT;
 
-	input.fw_err = 0xff;
+	input.exitinfo2 = 0xff;
 
 	/* Message version must be non-zero */
 	if (!input.msg_version)
@@ -603,7 +601,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 
 	mutex_unlock(&snp_cmd_mutex);
 
-	if (input.fw_err && copy_to_user(argp, &input, sizeof(input)))
+	if (input.exitinfo2 && copy_to_user(argp, &input, sizeof(input)))
 		return -EFAULT;
 
 	return ret;
diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
index 256aaeff7e65..2aa39112cf8d 100644
--- a/include/uapi/linux/sev-guest.h
+++ b/include/uapi/linux/sev-guest.h
@@ -52,8 +52,14 @@ struct snp_guest_request_ioctl {
 	__u64 req_data;
 	__u64 resp_data;
 
-	/* firmware error code on failure (see psp-sev.h) */
-	__u64 fw_err;
+	/* bits[63:32]: VMM error code, bits[31:0] firmware error code (see psp-sev.h) */
+	union {
+		__u64 exitinfo2;
+		struct {
+			__u32 fw_error;
+			__u32 vmm_error;
+		};
+	};
 };
 
 struct snp_ext_report_req {
@@ -77,4 +83,12 @@ struct snp_ext_report_req {
 /* Get SNP extended report as defined in the GHCB specification version 2. */
 #define SNP_GET_EXT_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x2, struct snp_guest_request_ioctl)
 
+/* Guest message request EXIT_INFO_2 constants */
+#define SNP_GUEST_FW_ERR_MASK		GENMASK_ULL(31, 0)
+#define SNP_GUEST_VMM_ERR_SHIFT		32
+#define SNP_GUEST_VMM_ERR(x)		(((u64)x) << SNP_GUEST_VMM_ERR_SHIFT)
+
+#define SNP_GUEST_VMM_ERR_INVALID_LEN	1
+#define SNP_GUEST_VMM_ERR_BUSY		2
+
 #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
-- 
2.39.0.246.g2a6d74b583-goog

