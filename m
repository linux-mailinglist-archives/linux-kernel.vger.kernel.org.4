Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD1367A4BC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 22:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbjAXVPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 16:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbjAXVP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:15:27 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6F4518C1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 13:15:19 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id i16-20020a17090332d000b00194a7b146b2so9692869plr.20
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 13:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qdpYTJi6DrEaArTeHPrwK423y1IyzC0SEKOtBYqJqyA=;
        b=O1Znx44one+S9tJCsVeqZG//Oy3Z7HiLbbNBfLhe6leUWQJn3PlKWZSGEYrC3B0b3F
         LszMM8V42gGpWxFUZdIY3wy0EVJb5wUQtdtXd1PgO54dpOq0cg4M4r0BJ+867iywOHOe
         jXyLCVER6VkvmEg6OMf2scfzbp6NjBYfjSfnRK32JzFKSmqhFywFdu5kklgaLO70TU68
         oOthsxyqYem+l4Ofc0Wd32iNnTKHGI3P49d+eLhYRCczKyIQ5hnoa6MdvzTBYWZucFdV
         xcHXJzsM8E14arwQbS711ccDB/p4ZlzywtyCbRHEDTsKYftipEmpqzrFtBrzXxPDAha1
         A/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdpYTJi6DrEaArTeHPrwK423y1IyzC0SEKOtBYqJqyA=;
        b=QyVPKzt3i1PAnKmwBlsXj1feY59d4J5ALkfN/8MUStI7KXNsgulvUk/EC2UklgYoo/
         RKETxfQAQe98wcuLG7gAXUg8XrJ06Y13U/rMdAfEoZMrf8a9/fYEpIfilWCAehkJphgJ
         bqupyzALZGuTN4rPih/V7fTR44jikEmh7o8oTfrbnrMq3BIl2Iem5p1FFiW3m1FZ4Orx
         gD39dhsCUpJi0VUHBHwaE3N9WUKJao8C7e+Ay5WcBLijkbJ6X3GTKYPfmuVTd+zDJBtE
         OnFAODvb/vQBcGW2evwrQWFZlQaa/Pu1xOkrs0MDbhZQivrcya9oOdKsrfL3cfVvhIeE
         hBDg==
X-Gm-Message-State: AO0yUKUrpgVVSPAxr2o90IiWXIlFl2Q26nDlEhzca2v1yi5VrCfwboRU
        hcbXdYCV4VoQ2ZcdtSPd0pY1Nvggo/qxWuPnsrGkrN1pwQT8iznqNhA+75SEGZqZJrtL1OZV6pC
        1pZz/YRtASDTWJ5NwQ7MX9UP6i0DV4c6C0EkZymEkLEFL4YT6Nl+LJ/2PQUKZ/Tb4deBUkHR15O
        T4P3DCFtc=
X-Google-Smtp-Source: AK7set/UybPnVRpB/0RbOsG8/I8hrXyhSIq90L9hS3r0XIRTcNgVIlT5CvcsCFzlPEELqiNxorn9Pbggci7ho9pY3w==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:903:485:b0:196:10e1:bd69 with SMTP
 id jj5-20020a170903048500b0019610e1bd69mr616333plb.8.1674594919163; Tue, 24
 Jan 2023 13:15:19 -0800 (PST)
Date:   Tue, 24 Jan 2023 21:14:52 +0000
In-Reply-To: <20230124211455.2563674-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20230124211455.2563674-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
Message-ID: <20230124211455.2563674-2-dionnaglaze@google.com>
Subject: [PATCH v13 1/4] virt/coco/sev-guest: Add throttling awareness
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
attest itself. Since throttling is expected to be a common occurrence, a
cooperative host can return a VMM error code that the request was
throttled.

The driver interprets the upper 32 bits of exitinfo2 as a VMM error code.
For safety, since the encryption algorithm in GHCBv2 is AES_GCM, control
must remain in the kernel to complete the request with the current
sequence number. Returning without finishing the request allows the the
guest to make another request but with different message contents. This
is IV reuse, and breaks cryptographic protections.

A guest request may not make it to the AMD-SP before the host returns to
the guest, so the err local variable in handle_guest_request must be
initialized the same way fw_err is. snp_issue_guest_request similarly
should set fw_err whether or not the value is non-zero, in order to
appropriately clear the error value when zero.

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

Fixes: d5af44dde546 ("x86/sev: Provide support for SNP guest request
NAEs")

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/include/asm/sev-common.h       |  3 ++-
 arch/x86/kernel/sev.c                   |  3 +--
 drivers/virt/coco/sev-guest/sev-guest.c | 11 ++++++++++-
 3 files changed, 13 insertions(+), 4 deletions(-)

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
index 4ec4174e05a3..3d6551fdf06f 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -322,7 +322,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
 				u32 resp_sz, __u64 *fw_err)
 {
-	unsigned long err;
+	unsigned long err = 0xff;
 	u64 seqno;
 	int rc;
 
@@ -338,6 +338,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	if (rc)
 		return rc;
 
+retry:
 	/*
 	 * Call firmware to process the request. In this function the encrypted
 	 * message enters shared memory with the host. So after this call the
@@ -346,6 +347,14 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	 */
 	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
 
+	/*
+	 * The host may return SNP_GUEST_REQ_ERR_EBUSY if the request has been
+	 * throttled. Retry in the driver to avoid returning and reusing the
+	 * message sequence number on a different message.
+	 */
+	if (err == SNP_GUEST_REQ_ERR_BUSY)
+		goto retry;
+
 	/*
 	 * If the extended guest request fails due to having too small of a
 	 * certificate data buffer, retry the same guest request without the
-- 
2.39.1.405.gd4c25cc71f-goog

