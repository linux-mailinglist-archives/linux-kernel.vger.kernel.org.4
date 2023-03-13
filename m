Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980366B7834
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCMM60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjCMM6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:58:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD8011140;
        Mon, 13 Mar 2023 05:58:12 -0700 (PDT)
Date:   Mon, 13 Mar 2023 12:58:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678712290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ezAgmmWZUX9qfEA4FY9WaiK/oZ2j4GAaTy3tsHaDIYU=;
        b=3oxTCoK6+Nfj77n/bBQc0TbTDYgoDDS/HTJHq9YlLDLvALjhP3qwdAm4IfP4wNbP9ojy0Q
        4qHiXZv5+cGKCKx0tEei8Zwpwh01HshRPinecAY45MLxDv+5YIm64eg0FzEBP3WT5dcxLi
        SNOttLik4R7IbKPHjYQTRJ+0cMs3UaGCFkyu3t5zrZOGbMJmH0geYPCtQscARI0nMxj8+A
        JGSZP3UTqH5/0g8X2rDsEddiapVI5f3jMPBAD/6Xv5jtQ4d9tfB7rc6oLscBh+J/Oq6Czl
        bDIb/rJciKMSRaDYODDofjyexMDxmHrdzRgXbOGKH6bJcELKypjhcktWmmd2tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678712290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ezAgmmWZUX9qfEA4FY9WaiK/oZ2j4GAaTy3tsHaDIYU=;
        b=SZUz8pcgF1u3DCDE48U+Wanovq7MZm26kOCOlLA/dZC0s0pQhQ0FUl27pqjmQKKD3wt6j6
        ReWUS3JYHHvo7iAg==
From:   "tip-bot2 for Dionna Glaze" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] virt/coco/sev-guest: Add throttling awareness
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, <stable@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230214164638.1189804-2-dionnaglaze@google.com>
References: <20230214164638.1189804-2-dionnaglaze@google.com>
MIME-Version: 1.0
Message-ID: <167871228947.5837.4976586787776962885.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     72f7754dcf31c87c92c0c353dcf747814cc5ce10
Gitweb:        https://git.kernel.org/tip/72f7754dcf31c87c92c0c353dcf747814cc5ce10
Author:        Dionna Glaze <dionnaglaze@google.com>
AuthorDate:    Thu, 16 Feb 2023 11:08:02 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 13 Mar 2023 13:29:27 +01:00

virt/coco/sev-guest: Add throttling awareness

A potentially malicious SEV guest can constantly hammer the hypervisor
using this driver to send down requests and thus prevent or at least
considerably hinder other guests from issuing requests to the secure
processor which is a shared platform resource.

Therefore, the host is permitted and encouraged to throttle such guest
requests.

Add the capability to handle the case when the hypervisor throttles
excessive numbers of requests issued by the guest. Otherwise, the VM
platform communication key will be disabled, preventing the guest from
attesting itself.

Realistically speaking, a well-behaved guest should not even care about
throttling. During its lifetime, it would end up issuing a handful of
requests which the hardware can easily handle.

This is more to address the case of a malicious guest. Such guest should
get throttled and if its VMPCK gets disabled, then that's its own
wrongdoing and perhaps that guest even deserves it.

To the implementation: the hypervisor signals with SNP_GUEST_REQ_ERR_BUSY
that the guest requests should be throttled. That error code is returned
in the upper 32-bit half of exitinfo2 and this is part of the GHCB spec
v2.

So the guest is given a throttling period of 1 minute in which it
retries the request every 2 seconds. This is a good default but if it
turns out to not pan out in practice, it can be tweaked later.

For safety, since the encryption algorithm in GHCBv2 is AES_GCM, control
must remain in the kernel to complete the request with the current
sequence number. Returning without finishing the request allows the
guest to make another request but with different message contents. This
is IV reuse, and breaks cryptographic protections.

  [ bp:
    - Rewrite commit message and do a simplified version.
    - The stable tags are supposed to denote that a cleanup should go
      upfront before backporting this so that any future fixes to this
      can preserve the sanity of the backporter(s). ]

Fixes: d5af44dde546 ("x86/sev: Provide support for SNP guest request NAEs")
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: <stable@kernel.org> # d6fd48eff750 ("virt/coco/sev-guest: Check SEV_SNP attribute at probe time")
Cc: <stable@kernel.org> # 970ab823743f (" virt/coco/sev-guest: Simplify extended guest request handling")
Cc: <stable@kernel.org> # c5a338274bdb ("virt/coco/sev-guest: Remove the disable_vmpck label in handle_guest_request()")
Cc: <stable@kernel.org> # 0fdb6cc7c89c ("virt/coco/sev-guest: Carve out the request issuing logic into a helper")
Cc: <stable@kernel.org> # d25bae7dc7b0 ("virt/coco/sev-guest: Do some code style cleanups")
Cc: <stable@kernel.org> # fa4ae42cc60a ("virt/coco/sev-guest: Convert the sw_exit_info_2 checking to a switch-case")
Link: https://lore.kernel.org/r/20230214164638.1189804-2-dionnaglaze@google.com
---
 arch/x86/include/asm/sev-common.h       |  3 ++-
 arch/x86/kernel/sev.c                   |  4 ++++
 drivers/virt/coco/sev-guest/sev-guest.c | 19 ++++++++++++++++++-
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index b8357d6..b63be69 100644
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
index d67884f..3f664ab 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2214,6 +2214,10 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned 
 	case 0:
 		break;
 
+	case SNP_GUEST_REQ_ERR_BUSY:
+		ret = -EAGAIN;
+		break;
+
 	case SNP_GUEST_REQ_INVALID_LEN:
 		/* Number of expected pages are returned in RBX */
 		if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST) {
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 81a53c3..46f1a8d 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -31,6 +31,9 @@
 #define AAD_LEN		48
 #define MSG_HDR_VER	1
 
+#define SNP_REQ_MAX_RETRY_DURATION	(60*HZ)
+#define SNP_REQ_RETRY_DELAY		(2*HZ)
+
 struct snp_guest_crypto {
 	struct crypto_aead *tfm;
 	u8 *iv, *authtag;
@@ -320,7 +323,8 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 
 static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, __u64 *fw_err)
 {
-	unsigned long err, override_err = 0;
+	unsigned long err = 0xff, override_err = 0;
+	unsigned long req_start = jiffies;
 	unsigned int override_npages = 0;
 	int rc;
 
@@ -360,6 +364,19 @@ retry_request:
 		 * user as an ioctl() return code.
 		 */
 		goto retry_request;
+
+	/*
+	 * The host may return SNP_GUEST_REQ_ERR_EBUSY if the request has been
+	 * throttled. Retry in the driver to avoid returning and reusing the
+	 * message sequence number on a different message.
+	 */
+	case -EAGAIN:
+		if (jiffies - req_start > SNP_REQ_MAX_RETRY_DURATION) {
+			rc = -ETIMEDOUT;
+			break;
+		}
+		schedule_timeout_killable(SNP_REQ_RETRY_DELAY);
+		goto retry_request;
 	}
 
 	/*
