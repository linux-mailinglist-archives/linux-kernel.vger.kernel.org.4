Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E84D6994B2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjBPMq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjBPMqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:46:16 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961242D67
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:46:12 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8EE611EC0943;
        Thu, 16 Feb 2023 13:46:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676551565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g3JIFlnaJQRDgNkGvcx8YEAWZPMhNS41V9JKJbQrAyA=;
        b=MI2GxdKUCdYFf/4QR3REXNoSfTUt7EVZMSHhcPshKbKSxYacwRxS5+VE17vt2nKRXiM0eE
        UViGCOb/aR5ig3QkbQ8i3pD5nl6CiqtHF4Aq18/IKhpWWY5mqYUBtiHafmzClim52dE+bE
        H5Ui1NNRqVL4qdB57cxgMKGqUsbG2ho=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Michael Roth <michael.roth@amd.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        linux-coco@lists.linux.dev, x86@kernel.org
Subject: [PATCH 11/11] x86/sev: Change snp_guest_issue_request()'s fw_err argument
Date:   Thu, 16 Feb 2023 13:46:02 +0100
Message-Id: <20230216124602.26849-6-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230216124602.26849-1-bp@alien8.de>
References: <20230216124120.26578-1-bp@alien8.de>
 <20230216124602.26849-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dionna Glaze <dionnaglaze@google.com>

The GHCB specification declares that the firmware error value for
a guest request will be stored in the lower 32 bits of EXIT_INFO_2.  The
upper 32 bits are for the VMM's own error code. The fw_err argument to
snp_guest_issue_request() is thus a misnomer, and callers will need
access to all 64 bits.

The type of unsigned long also causes problems, since sw_exit_info2 is
u64 (unsigned long long) vs the argument's unsigned long*. Change this
type for issuing the guest request. Pass the ioctl command struct's error
field directly instead of in a local variable, since an incomplete guest
request may not set the error code, and uninitialized stack memory would
be written back to user space.

The firmware might not even be called, so bookend the call with the no
firmware call error and clear the error.

Since the "fw_err" field is really exitinfo2 split into the upper bits'
vmm error code and lower bits' firmware error code, convert the 64 bit
value to a union.

  [ bp: Massage commit message, adjust code. ]

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230214164638.1189804-5-dionnaglaze@google.com
---
 Documentation/virt/coco/sev-guest.rst   | 20 ++++++----
 arch/x86/include/asm/sev-common.h       |  4 --
 arch/x86/include/asm/sev.h              |  4 +-
 arch/x86/kernel/sev.c                   | 16 +++++---
 drivers/virt/coco/sev-guest/sev-guest.c | 51 ++++++++++++-------------
 include/uapi/linux/sev-guest.h          | 18 ++++++++-
 6 files changed, 66 insertions(+), 47 deletions(-)

diff --git a/Documentation/virt/coco/sev-guest.rst b/Documentation/virt/coco/sev-guest.rst
index aa3e4c6a1f90..68b0d2363af8 100644
--- a/Documentation/virt/coco/sev-guest.rst
+++ b/Documentation/virt/coco/sev-guest.rst
@@ -37,11 +37,11 @@ along with a description:
       the return value.  General error numbers (-ENOMEM, -EINVAL)
       are not detailed, but errors with specific meanings are.
 
-The guest ioctl should be issued on a file descriptor of the /dev/sev-guest device.
-The ioctl accepts struct snp_user_guest_request. The input and output structure is
-specified through the req_data and resp_data field respectively. If the ioctl fails
-to execute due to a firmware error, then fw_err code will be set. Otherwise, fw_err
-will be set to 0x00000000ffffffff, i.e., the lower 32-bits are -1.
+The guest ioctl should be issued on a file descriptor of the /dev/sev-guest
+device.  The ioctl accepts struct snp_user_guest_request. The input and
+output structure is specified through the req_data and resp_data field
+respectively. If the ioctl fails to execute due to a firmware error, then
+the fw_error code will be set, otherwise fw_error will be set to -1.
 
 The firmware checks that the message sequence counter is one greater than
 the guests message sequence counter. If guest driver fails to increment message
@@ -57,8 +57,14 @@ counter (e.g. counter overflow), then -EIO will be returned.
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
index 612453eb7ab3..1035d3eed77e 100644
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
@@ -2183,9 +2185,11 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
 	struct ghcb *ghcb;
 	int ret;
 
-	if (!fw_err)
+	if (!exitinfo2)
 		return -EINVAL;
 
+	*exitinfo2 = SEV_RET_NO_FW_CALL;
+
 	/*
 	 * __sev_get_ghcb() needs to run with IRQs disabled because it is using
 	 * a per-CPU GHCB.
@@ -2209,16 +2213,16 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
 	if (ret)
 		goto e_put;
 
-	*fw_err = ghcb->save.sw_exit_info_2;
-	switch (*fw_err) {
+	*exitinfo2 = ghcb->save.sw_exit_info_2;
+	switch (*exitinfo2) {
 	case 0:
 		break;
 
-	case SNP_GUEST_REQ_ERR_BUSY:
+	case SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_BUSY):
 		ret = -EAGAIN;
 		break;
 
-	case SNP_GUEST_REQ_INVALID_LEN:
+	case SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN):
 		/* Number of expected pages are returned in RBX */
 		if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST) {
 			input->data_npages = ghcb_get_rbx(ghcb);
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 070c6f414bfd..a5b68e43fa27 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -332,11 +332,11 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 	return __enc_payload(snp_dev, req, payload, sz);
 }
 
-static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, __u64 *fw_err)
+static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
+				  struct snp_guest_request_ioctl *req_ioctl)
 {
-	unsigned long err = 0xff, override_err = 0;
-	unsigned int override_npages = 0;
 	unsigned long req_start = jiffies;
+	unsigned int override_npages = 0;
 	int rc;
 
 retry_request:
@@ -346,7 +346,7 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	 * sequence number must be incremented or the VMPCK must be deleted to
 	 * prevent reuse of the IV.
 	 */
-	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
+	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &req_ioctl->exitinfo2);
 	switch (rc) {
 	case -ENOSPC:
 		/*
@@ -357,14 +357,14 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 		 * IV reuse.
 		 */
 		override_npages = snp_dev->input.data_npages;
-		exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
+		exit_code = SVM_VMGEXIT_GUEST_REQUEST;
 
 		/*
 		 * Override the error to inform callers the given extended
 		 * request buffer size was too small and give the caller the
 		 * required buffer size.
 		 */
-		override_err	= SNP_GUEST_REQ_INVALID_LEN;
+		req_ioctl->vmm_error = SNP_GUEST_VMM_ERR_INVALID_LEN;
 
 		/*
 		 * If this call to the firmware succeeds, the sequence number can
@@ -377,7 +377,7 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 		goto retry_request;
 
 	/*
-	 * The host may return SNP_GUEST_REQ_ERR_EBUSY if the request has been
+	 * The host may return SNP_GUEST_VMM_ERR_BUSY if the request has been
 	 * throttled. Retry in the driver to avoid returning and reusing the
 	 * message sequence number on a different message.
 	 */
@@ -390,18 +390,16 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 		goto retry_request;
 	}
 
-	if (fw_err)
-		*fw_err = override_err ?: err;
-
 	if (override_npages)
 		snp_dev->input.data_npages = override_npages;
 
 	return rc;
 }
 
-static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
-				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
-				u32 resp_sz, __u64 *fw_err)
+static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
+				struct snp_guest_request_ioctl *req_ioctl, u8 type,
+				void *req_buf, size_t req_sz, void *resp_buf,
+				u32 resp_sz)
 {
 	u64 seqno;
 	int rc;
@@ -415,7 +413,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
 
 	/* Encrypt the userspace provided payload in snp_dev->secret_request. */
-	rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
+	rc = enc_payload(snp_dev, seqno, req_ioctl->msg_version, type, req_buf, req_sz);
 	if (rc)
 		return rc;
 
@@ -426,9 +424,11 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	memcpy(snp_dev->request, &snp_dev->secret_request,
 	       sizeof(snp_dev->secret_request));
 
-	rc = __handle_guest_request(snp_dev, exit_code, fw_err);
+	rc = __handle_guest_request(snp_dev, exit_code, req_ioctl);
 	if (rc) {
-		dev_alert(snp_dev->dev, "Detected error from ASP request. rc: %d, fw_err: %llu\n", rc, *fw_err);
+		dev_alert(snp_dev->dev,
+			  "Detected error from ASP request. rc: %d, exitinfo2: %llu\n",
+			  rc, req_ioctl->exitinfo2);
 		snp_disable_vmpck(snp_dev);
 		return rc;
 	}
@@ -471,9 +471,9 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	if (!resp)
 		return -ENOMEM;
 
-	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
+	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
 				  SNP_MSG_REPORT_REQ, &req, sizeof(req), resp->data,
-				  resp_len, &arg->fw_err);
+				  resp_len);
 	if (rc)
 		goto e_free;
 
@@ -511,9 +511,8 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
 		return -EFAULT;
 
-	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
-				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
-				  &arg->fw_err);
+	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
+				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len);
 	if (rc)
 		return rc;
 
@@ -573,12 +572,12 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
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
@@ -613,7 +612,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	if (copy_from_user(&input, argp, sizeof(input)))
 		return -EFAULT;
 
-	input.fw_err = 0xff;
+	input.exitinfo2 = 0xff;
 
 	/* Message version must be non-zero */
 	if (!input.msg_version)
@@ -644,7 +643,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 
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
2.35.1

