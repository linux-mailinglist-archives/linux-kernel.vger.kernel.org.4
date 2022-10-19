Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4129604EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiJSRh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiJSRhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:37:09 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0F5B3B34
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:36:04 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id mq15-20020a17090b380f00b0020ad26fa5edso347639pjb.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tLaLNkKmG/1utgb0WiIE0QyU+j9hCmDIJ227bpIhia4=;
        b=Ub6rQCcbus1BbzkgOJX0EnV7UHoQYyZMJdgk2/L1vp7vX7h755ujNOeYxMN68bGkDi
         y1NVtx5x4CtEj5THLSpLcHalFRD/G7Iq3t82eqxCTGLJDVOKnvGuCkuzX7Eqmxpafu/H
         gxS3n42agtbrjiwKHROTFIEMYBuTNPSE6OAMFH7179SqkEMiwLG5CehFkjL9QunjIwng
         rOjYdW4tyGbbOLXSym6g8XX7GeWnb2g72rG7b/9hGb1SB1tO5RGwXrj74gBEqSQHpeG9
         xzLrICMwr6lLX02OOe0ANJCDTVxQeMGdvXuP16a2oPKr2lXN/Jlc19CpQ8vxJUu1nb6e
         jJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLaLNkKmG/1utgb0WiIE0QyU+j9hCmDIJ227bpIhia4=;
        b=3nr1ZDRhGszqi+ggfAKNGFlg0QDn6YoWsB/+kTD7PNRAWSyt+gGcT/XEdK14QEotDw
         3fJemQOUd7VSS0h0hEEM3Giz9xTW8e1yU08NpnTI0SiYAGqWBy5MjgPqQG++CJGlZJm6
         0Q2ZTr4SaHV/77DnzFp9ELTYPOF5bIme43tp5vHiDGslsYS8PqrrF8EE0nseQVMuwvlR
         DvB77zNCCfK8l6Kox/iVKNEW88rLMvlUvOrygfr+QsrsuQDuJ3Puj6wSyDmW4i0r+TPL
         njN4tW3r76wSEpkEeim1MLun0+tS9zQ4MesH4JK4122KKdTXinodJO8ZSGg7r5WlTkcC
         BNng==
X-Gm-Message-State: ACrzQf1zdikSyG70D8w84lnjRBKzk+viRenk1Fss9aJrob9wqBCRthMs
        HzV98fZ4kFKLiAJDq4079FawhOMtEF2T56Vfeg==
X-Google-Smtp-Source: AMsMyM57ZuquUWX+iH5t+4VHiO/s6XJ2E4bUtt5Wai0OHqKoQxcxl0s+S+AbDvuo+OPCAcbukfG46Cr2dvQU4Jn+Wg==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:902:edc3:b0:172:8ae3:9778 with
 SMTP id q3-20020a170902edc300b001728ae39778mr9683806plk.72.1666200953483;
 Wed, 19 Oct 2022 10:35:53 -0700 (PDT)
Date:   Wed, 19 Oct 2022 17:35:37 +0000
In-Reply-To: <20221019173537.1238121-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221019173537.1238121-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221019173537.1238121-3-dionnaglaze@google.com>
Subject: [PATCH v2 2/2] virt/coco/sev-guest: interpret VMM errors from guest request
From:   Dionna Glaze <dionnaglaze@google.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
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

The GHCB specification states that the upper 32 bits of exitinfo2 are
for the VMM's error codes. The sev-guest ABI has already locked in
that the fw_err status of the input will be 64 bits, and that
BIT_ULL(32) means that the extended guest request's data buffer was too
small, so we have to keep that ABI. This patch deprecates the fw_err
field name in the request to exitinfo2.

We can still interpret the upper 32 bits of exitinfo2 for the user
anyway in case the request gets throttled. That makes the interface more
user-friendly.

The error code 2 is the next available for VMM errors (upper 32 bits)
in the GHCB specification, so we claim it for throttling.

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 34 +++++++++++++++++--------
 include/uapi/linux/sev-guest.h          | 16 ++++++++++--
 2 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index f422f9c58ba7..8bc435cbd7e3 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -303,9 +303,10 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 
 static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
 				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
-				u32 resp_sz, __u64 *fw_err)
+				u32 resp_sz, __u64 *exitinfo2)
 {
-	unsigned long err;
+	unsigned long _exitinfo2 = 0;
+	unsigned int vmm_err;
 	u64 seqno;
 	int rc;
 
@@ -322,9 +323,20 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 		return rc;
 
 	/* Call firmware to process the request */
-	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
-	if (fw_err)
-		*fw_err = err;
+	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &_exitinfo2);
+	if (exitinfo2)
+		*exitinfo2 = _exitinfo2;
+
+	vmm_err = _exitinfo2 >> SNP_GUEST_VMM_ERR_SHIFT;
+	/* The host may return EBUSY if the request has been throttled. */
+	if (vmm_err == SNP_GUEST_VMM_ERR_BUSY)
+		return -EAGAIN;
+
+	if (vmm_err && vmm_err != SNP_GUEST_VMM_ERR_INVALID_LEN) {
+		pr_err("sev-guest: host returned unknown error code: %d\n",
+		       vmm_err);
+		return -EINVAL;
+	}
 
 	if (rc)
 		return rc;
@@ -378,7 +390,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 
 	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
 				  SNP_MSG_REPORT_REQ, &req, sizeof(req), resp->data,
-				  resp_len, &arg->fw_err);
+				  resp_len, &arg->exitinfo2);
 	if (rc)
 		goto e_free;
 
@@ -418,7 +430,7 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 
 	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
 				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
-				  &arg->fw_err);
+				  &arg->exitinfo2);
 	if (rc)
 		return rc;
 
@@ -480,10 +492,10 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	snp_dev->input.data_npages = npages;
 	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg->msg_version,
 				   SNP_MSG_REPORT_REQ, &req.data,
-				   sizeof(req.data), resp->data, resp_len, &arg->fw_err);
+				   sizeof(req.data), resp->data, resp_len, &arg->exitinfo2);
 
 	/* If certs length is invalid then copy the returned length */
-	if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
+	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
 		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
 
 		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
@@ -518,7 +530,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	if (copy_from_user(&input, argp, sizeof(input)))
 		return -EFAULT;
 
-	input.fw_err = 0xff;
+	input.exitinfo2 = 0xff;
 
 	/* Message version must be non-zero */
 	if (!input.msg_version)
@@ -549,7 +561,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 
 	mutex_unlock(&snp_cmd_mutex);
 
-	if (input.fw_err && copy_to_user(argp, &input, sizeof(input)))
+	if (input.exitinfo2 && copy_to_user(argp, &input, sizeof(input)))
 		return -EFAULT;
 
 	return ret;
diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
index 256aaeff7e65..974fcff29c6a 100644
--- a/include/uapi/linux/sev-guest.h
+++ b/include/uapi/linux/sev-guest.h
@@ -52,8 +52,15 @@ struct snp_guest_request_ioctl {
 	__u64 req_data;
 	__u64 resp_data;
 
-	/* firmware error code on failure (see psp-sev.h) */
-	__u64 fw_err;
+	/* bits[63:32]: VMM error code, bits[31:0] firmware error code (see psp-sev.h) */
+	union {
+		__u64 exitinfo2;
+		__u64 fw_err; /* Name deprecated in favor of others */
+		struct {
+			__u32 fw_error;
+			__u32 vmm_error;
+		};
+	};
 };
 
 struct snp_ext_report_req {
@@ -77,4 +84,9 @@ struct snp_ext_report_req {
 /* Get SNP extended report as defined in the GHCB specification version 2. */
 #define SNP_GET_EXT_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x2, struct snp_guest_request_ioctl)
 
+
+#define SNP_GUEST_VMM_ERR_SHIFT		32
+#define SNP_GUEST_VMM_ERR_INVALID_LEN	1
+#define SNP_GUEST_VMM_ERR_BUSY		2
+
 #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
-- 
2.38.0.413.g74048e4d9e-goog

