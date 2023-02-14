Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FC0696A3F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjBNQtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjBNQsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:48:52 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD8B2BED4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:48:48 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id ip9-20020a17090b314900b0023445cc3e08so410947pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t23AMd5aqhUaIAzpimbSpgnbzTEYRxbMZhOXOMJqf1M=;
        b=Av62xu801emyTC/zrSTG4it6ti4mHUPuqVwvq8NXIy8HMdaqX6kctA2lkwYbkKfcQE
         3RLGX+mSz8wqr3nSnPpP2DupddyPx8d28c/Zx4rDz9I37lRSe76FLb9lLm/Oq4yzN+v4
         dkV6vpZLv51pG4xXMl0nu0WyEIRmO/taaaqHs0JS9ZIAJyG8PBJiXJLZfy9VXQZD9Qnn
         wvX4EN9BkqEilZ+glI4XNoN7wA02tLkjLMUZ394ccE3cOZOvqjNIBrMGO7M81u7sg67r
         014pP69MiBRug5pyDB1tf4Kjge519iDILcWtNOPXOzgV/V2u8vJogGq1cmKaNUNE4/zA
         EUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t23AMd5aqhUaIAzpimbSpgnbzTEYRxbMZhOXOMJqf1M=;
        b=OWEqfTn7g2u9yDboSklXsGBxjcwwKmmigslmSL5mFYyqXO2Mtz0/ARs5zVu69gPezv
         Vep9uI8mhVE3OemQpwfyowP73Snp7J0ufw8Rd3GV1kxfT9zyfk0uPgMRFJzaYXNCSwRy
         CQZqoUUCYmkCvI+JUbWnIzpGHTl5yVkgA2Rj9vcDoCn5972yeiceMWLsKgkQVRMTMoAW
         LS9CjI+/cCdhRU65D2CI7z0iD4xbH3Ej4J9uyX0v+b1N3QfteZ8aZdmP5p+dbWgRScsp
         WrISmoGMzWqJWtKKQPmwsYEL6shGP57LAIQTTT2Unk28cj3mXeSCFf6lWtt7XrdnrRN+
         IU+A==
X-Gm-Message-State: AO0yUKXH2+F0HiCbPElXzXS+/TZL+2374lpi1U5vppdKFWqs+2y4b56x
        4nCFy2/Qx71QH+wOBrF5L1LuGVEGO8hFf+ETCZhcRHSByropIGl1VWG9qVPAPyDVhNd1HdFzk6J
        DL3PjHbpAX9Xfj78EHokqtiGxD7r74upj2W9JDMxs2iDel8asKB4zDoZghpx2XdX9btjSATTy4P
        x0q6bV8zs=
X-Google-Smtp-Source: AK7set9TMtTubIo/r5gUBCy+Bqjv//+yICE90pVRl5n3U3MscUN8a0zmLwyTTeH3VPEUH4YmGGlXNLjkzsINH+uLQQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:90a:4e48:b0:233:aed3:b20 with SMTP
 id t8-20020a17090a4e4800b00233aed30b20mr42249pjl.12.1676393327892; Tue, 14
 Feb 2023 08:48:47 -0800 (PST)
Date:   Tue, 14 Feb 2023 16:46:35 +0000
In-Reply-To: <20230214164638.1189804-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20230214164638.1189804-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.39.1.637.g21b0678d19-goog
Message-ID: <20230214164638.1189804-2-dionnaglaze@google.com>
Subject: [PATCH v15 1/4] virt/coco/sev-guest: Add throttling awareness
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

The host is permitted and encouraged to throttle guest requests to the
AMD-SP since it is a shared resource across all VMs. Without
throttling-awareness, the host returning an error will immediately lock
out access to the VMPCK, which makes the VM less useful as it can't
attest itself. Since throttling is expected for a host to protect itself
from an uncooperative guest, a cooperative host can return a VMM error
code that the request was throttled.

The driver interprets the upper 32 bits of exitinfo2 as a VMM error code.
For safety, since the encryption algorithm in GHCBv2 is AES_GCM, control
must remain in the kernel to complete the request with the current
sequence number. Returning without finishing the request allows the
guest to make another request but with different message contents. This
is IV reuse, and breaks cryptographic protections.

A quick fix is to retry for a while and then disable the VMPCK and
return to user space.

A guest request may not make it to the AMD-SP before the host returns to
the guest, so the err local variable in handle_guest_request must be
initialized the same way fw_err is. snp_issue_guest_request similarly
should set fw_err whether or not the value is non-zero, in order to
appropriately clear the error value when zero.

The IV reuse fix for invalid certs_len needs modification to work with
throttling, since a single retry with a modified exit_code may be
throttled without retry and result in a locked-out VMPCK. Instead,
change the exit_code as before and jump to the same retry label, and
deal with the error code fixup by checking if the exit_code had to be
changed.

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

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/include/asm/sev-common.h       |  3 ++-
 arch/x86/kernel/sev.c                   |  3 +--
 drivers/virt/coco/sev-guest/sev-guest.c | 34 ++++++++++++++++++++++---
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index b8357d6ecd47..b63be696b776 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -128,8 +128,9 @@ struct snp_psc_desc {
 	struct psc_entry entries[VMGEXIT_PSC_MAX_ENTRY];
 } __packed;
 
-/* Guest message request error code */
+/* Guest message request error codes */
 #define SNP_GUEST_REQ_INVALID_LEN	BIT_ULL(32)
+#define SNP_GUEST_REQ_ERR_BUSY		BIT_ULL(33)
 
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 679026a640ef..a908ffc2dfba 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2212,14 +2212,13 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
 	if (ret)
 		goto e_put;
 
+	*fw_err = ghcb->save.sw_exit_info_2;
 	if (ghcb->save.sw_exit_info_2) {
 		/* Number of expected pages are returned in RBX */
 		if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
 		    ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_INVALID_LEN)
 			input->data_npages = ghcb_get_rbx(ghcb);
 
-		*fw_err = ghcb->save.sw_exit_info_2;
-
 		ret = -EIO;
 	}
 
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 4ec4174e05a3..dc75f11c086e 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -30,6 +30,8 @@
 #define DEVICE_NAME	"sev-guest"
 #define AAD_LEN		48
 #define MSG_HDR_VER	1
+#define ACCEPTABLE_REQUEST_RETRY_DURATION	(60*HZ)
+#define REQUEST_RETRY_DELAY			(2*HZ)
 
 struct snp_guest_crypto {
 	struct crypto_aead *tfm;
@@ -322,9 +324,12 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
 				u32 resp_sz, __u64 *fw_err)
 {
-	unsigned long err;
+	unsigned long err = 0xff;
+	unsigned long start_time = jiffies;
+	u64 orig_exit_code = exit_code;
 	u64 seqno;
 	int rc;
+	unsigned int certs_npages = 0;
 
 	/* Get message sequence and verify that its a non-zero */
 	seqno = snp_get_msg_seqno(snp_dev);
@@ -338,6 +343,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	if (rc)
 		return rc;
 
+retry:
 	/*
 	 * Call firmware to process the request. In this function the encrypted
 	 * message enters shared memory with the host. So after this call the
@@ -346,6 +352,24 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	 */
 	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
 
+	/*
+	 * The host may return SNP_GUEST_REQ_ERR_EBUSY if the request has been
+	 * throttled. Retry in the driver to avoid returning and reusing the
+	 * message sequence number on a different message.
+	 */
+	if (err == SNP_GUEST_REQ_ERR_BUSY) {
+		if (jiffies - start_time > ACCEPTABLE_REQUEST_RETRY_DURATION) {
+			rc = -ETIMEDOUT;
+			/*
+			 * Must disable VMPCK since it's not the user's
+			 * responsibility to avoid IV reuse.
+			 */
+			goto disable_vmpck;
+		}
+		schedule_timeout_killable(REQUEST_RETRY_DELAY);
+		goto retry;
+	}
+
 	/*
 	 * If the extended guest request fails due to having too small of a
 	 * certificate data buffer, retry the same guest request without the
@@ -354,7 +378,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	 */
 	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
 	    err == SNP_GUEST_REQ_INVALID_LEN) {
-		const unsigned int certs_npages = snp_dev->input.data_npages;
+		certs_npages = snp_dev->input.data_npages;
 
 		exit_code = SVM_VMGEXIT_GUEST_REQUEST;
 
@@ -366,8 +390,12 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 		 * of the VMPCK and the error code being propagated back to the
 		 * user as an ioctl() return code.
 		 */
-		rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
+		schedule_timeout_killable(REQUEST_RETRY_DELAY);
+		goto retry;
+	}
 
+	if (orig_exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
+	    exit_code != orig_exit_code) {
 		/*
 		 * Override the error to inform callers the given extended
 		 * request buffer size was too small and give the caller the
-- 
2.39.1.637.g21b0678d19-goog

