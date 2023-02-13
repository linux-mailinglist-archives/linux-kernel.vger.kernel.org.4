Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8441F694DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjBMRZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjBMRZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:25:46 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3213D1CAF4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:25:41 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-52f1641b79aso41756437b3.16
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PhcAbl7QdzfYI0ms9XS2J/h4B916eIBy8PELkBSNwas=;
        b=pRL4IqF7WHtg+38Xdv7P5H0RrO4NpGStwNRnwKIbS8VnHTHpdcvBeHk0Eyh1iBWktD
         Ecu8F6YylAomytKCO9iyKiwi33maVZmgj772Uvlhordr3+tnNEm1dX58mVlPY0mwJPYr
         KfoNn0UNFgHEsZ5it1aHDV1cncbgypKu6AmQI2pf5+o6uJw6gK1D32WaNcux0H+qOoLP
         kO4vSY1j8IkyuqS6RxB3eL7AbHFXMLbnrMmgiBfA2b3raltcc1/QjgDdKKyuYkG5pEWB
         5aV2DxtVcq0VcuI5DT4A6cFeeg82yPBl2IxuCC7HcSGnhLk+fCi/nlTUOW9O4x3IDJ6c
         KCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PhcAbl7QdzfYI0ms9XS2J/h4B916eIBy8PELkBSNwas=;
        b=WByYNJVbIdoBAl6bVA+e10UjKU3uSBWTIhN0QfBKABzjRdmQWBYwTfXqtYdbnAynv/
         /YigLt8oR3X4XR5ArP1ZctQVjaASdt9U/GRoELE5YbEtlkEg0Tl5PhE7fWdn3z2I7hVv
         o8aKeufJi3kxssE+sz/Yb8SQCIt0zbKTQ3z10xQidMpCRIylRWbvU05IrWvFBJdCN45w
         ASQ6LIwAB6DbEGDZLlSOSjxlYOkUaxXpYO6OaKXCZUlcB7Z6TIKUUEraeVzEqITuRfdl
         exqlgYGBOF8HRzhHTQs1LomJ/FtciAyHDEQoTR6zMJpPsFTBxeRNooIgcN89AkVbpnOn
         ZvFA==
X-Gm-Message-State: AO0yUKUQRhDylXpIidYfK8FlTCCXrR5funcR5RXDbP/Hl1ITG7Efohbr
        AZwyPEXKlZ50rosdCLYsiUNOnJY+TChzxhLT8VJn7eYkfK3O/9FJii7zm9m/qSgmxMNjtYvJdyG
        TCzgsgFHC77sSDGpC8rXRZPh4ssDv1S1Kn5bk/Pg0+6Bhfm55pw5xemcBJATsUtioRYlhEzJA5X
        C/35Ksf28=
X-Google-Smtp-Source: AK7set8ChynBWDGwraTdFJfxi7ma+ZsQGLODVh0hYExFyN/MND2d+YU0WBXwgeA77pa7byamm4HzYeZDkicUojRHTg==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a25:6582:0:b0:8b6:9f30:1f7a with SMTP
 id z124-20020a256582000000b008b69f301f7amr18ybb.11.1676309139444; Mon, 13 Feb
 2023 09:25:39 -0800 (PST)
Date:   Mon, 13 Feb 2023 17:25:24 +0000
In-Reply-To: <20230213172525.575766-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20230213172525.575766-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213172525.575766-4-dionnaglaze@google.com>
Subject: [PATCH v14 3/3] x86/sev: Change snp_guest_issue_request's fw_err
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
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

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 Documentation/virt/coco/sev-guest.rst   | 21 +++++++----
 arch/x86/include/asm/sev-common.h       |  4 ---
 arch/x86/include/asm/sev.h              |  4 +--
 arch/x86/kernel/sev.c                   | 12 ++++---
 drivers/virt/coco/sev-guest/sev-guest.c | 47 ++++++++++++-------------
 include/uapi/linux/sev-guest.h          | 18 ++++++++--
 6 files changed, 62 insertions(+), 44 deletions(-)

diff --git a/Documentation/virt/coco/sev-guest.rst b/Documentation/virt/coco/sev-guest.rst
index e76393e389eb..48e89ea2a618 100644
--- a/Documentation/virt/coco/sev-guest.rst
+++ b/Documentation/virt/coco/sev-guest.rst
@@ -37,11 +37,12 @@ along with a description:
       the return value.  General error numbers (-ENOMEM, -EINVAL)
       are not detailed, but errors with specific meanings are.
 
-The guest ioctl should be issued on a file descriptor of the /dev/sev-guest device.
-The ioctl accepts struct snp_user_guest_request. The input and output structure is
-specified through the req_data and resp_data field respectively. If the ioctl fails
-to execute due to a firmware error, then fw_err code will be set otherwise the
-fw_err will be set to 0x00000000ffffffff, i.e., the lower 32-bits are -1.
+The guest ioctl should be issued on a file descriptor of the
+/dev/sev-guest device.  The ioctl accepts struct
+snp_user_guest_request. The input and output structure is specified
+through the req_data and resp_data field respectively. If the ioctl
+fails to execute due to a firmware error, then the fw_error code will
+be set, otherwise fw_error will be set to -1.
 
 The firmware checks that the message sequence counter is one greater than
 the guests message sequence counter. If guest driver fails to increment message
@@ -57,8 +58,14 @@ counter (e.g. counter overflow), then -EIO will be returned.
                 __u64 req_data;
                 __u64 resp_data;
 
-                /* firmware error code on failure (see psp-sev.h) */
-                __u64 fw_err;
+                /* bits[63:32]: VMM error code, bits[31:0] firmware error code (see psp-sev.h) */
+                union {
+                        __u64 exitinfo2;
+                        struct {
+                                __u32 fw_error;
+                                __u32 vmm_error;
+                        };
+                };
         };
 
 2.1 SNP_GET_REPORT
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index b63be696b776..0759af9b1acf 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -128,10 +128,6 @@ struct snp_psc_desc {
 	struct psc_entry entries[VMGEXIT_PSC_MAX_ENTRY];
 } __packed;
 
-/* Guest message request error codes */
-#define SNP_GUEST_REQ_INVALID_LEN	BIT_ULL(32)
-#define SNP_GUEST_REQ_ERR_BUSY		BIT_ULL(33)
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
index a908ffc2dfba..82aa81fafb71 100644
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
@@ -2212,11 +2216,11 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
 	if (ret)
 		goto e_put;
 
-	*fw_err = ghcb->save.sw_exit_info_2;
+	*exitinfo2 = ghcb->save.sw_exit_info_2;
 	if (ghcb->save.sw_exit_info_2) {
 		/* Number of expected pages are returned in RBX */
 		if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
-		    ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_INVALID_LEN)
+			ghcb->save.sw_exit_info_2 == SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN))
 			input->data_npages = ghcb_get_rbx(ghcb);
 
 		ret = -EIO;
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 4945f2dd97a2..fdc3bc9df8d9 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -328,11 +328,11 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
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
-	unsigned long err = 0xff;
 	unsigned long start_time = jiffies;
 	u64 orig_exit_code = exit_code;
 	u64 seqno;
@@ -348,7 +348,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
 
 	/* Encrypt the userspace provided payload in snp_dev->secret_request. */
-	rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
+	rc = enc_payload(snp_dev, seqno, arg->msg_version, type, req_buf, req_sz);
 	if (rc)
 		return rc;
 
@@ -366,14 +366,15 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	 * sequence number must be incremented or the VMPCK must be deleted to
 	 * prevent reuse of the IV.
 	 */
-	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
+	rc = snp_issue_guest_request(exit_code, &snp_dev->input,
+				     &arg->exitinfo2);
 
 	/*
-	 * The host may return SNP_GUEST_REQ_ERR_EBUSY if the request has been
+	 * The host may return SNP_GUEST_VMM_ERR_BUSY if the request has been
 	 * throttled. Retry in the driver to avoid returning and reusing the
 	 * message sequence number on a different message.
 	 */
-	if (err == SNP_GUEST_REQ_ERR_BUSY) {
+	if (arg->vmm_error == SNP_GUEST_VMM_ERR_BUSY) {
 		if (jiffies - start_time > ACCEPTABLE_REQUEST_RETRY_DURATION) {
 			rc = -ETIMEDOUT;
 			goto disable_vmpck;
@@ -389,7 +390,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	 * and thus avoid IV reuse.
 	 */
 	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
-	    err == SNP_GUEST_REQ_INVALID_LEN) {
+	    arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
 		certs_npages = snp_dev->input.data_npages;
 
 		exit_code = SVM_VMGEXIT_GUEST_REQUEST;
@@ -413,17 +414,14 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
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
+			  "Detected error from ASP request. rc: %d, exitinfo2: %llx\n",
+			  rc, arg->exitinfo2);
 		goto disable_vmpck;
 	}
 
@@ -470,9 +468,9 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	if (!resp)
 		return -ENOMEM;
 
-	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
+	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
 				  SNP_MSG_REPORT_REQ, &req, sizeof(req), resp->data,
-				  resp_len, &arg->fw_err);
+				  resp_len);
 	if (rc)
 		goto e_free;
 
@@ -510,9 +508,8 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
 		return -EFAULT;
 
-	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
-				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
-				  &arg->fw_err);
+	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
+				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len);
 	if (rc)
 		return rc;
 
@@ -572,12 +569,12 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
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
@@ -612,7 +609,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	if (copy_from_user(&input, argp, sizeof(input)))
 		return -EFAULT;
 
-	input.fw_err = 0xff;
+	input.exitinfo2 = 0xff;
 
 	/* Message version must be non-zero */
 	if (!input.msg_version)
@@ -643,7 +640,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 
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
2.39.1.581.gbfd45094c4-goog

