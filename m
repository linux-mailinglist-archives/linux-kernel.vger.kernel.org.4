Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F6C6AF5E3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjCGTij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjCGThl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:37:41 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18020B8F29
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 11:25:02 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D32E1EC06BA;
        Tue,  7 Mar 2023 20:25:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678217100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hrnqg02hbwlPWfzHVKt8aCTMzmIQepyCvzKZ2v/oxvw=;
        b=n6uNy4YXZ+PdiY8sz9J9491QnE/Yx8ujmGt9T81Vf9yEqooB3L7y2dHkXNyNVe9XPVpu/r
        pevN1lgIc7QyEacGB2xWZ8yKPorAu/8hol2OBotwQt16n3U8uJz1DecraP77Qf5uy/WmY5
        pkUH5LI2XdnxS/Vj+G1+Ra4HYOr+GhQ=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Michael Roth <michael.roth@amd.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        linux-coco@lists.linux.dev, x86@kernel.org
Subject: [PATCH -v3 09/11] virt/coco/sev-guest: Add throttling awareness
Date:   Tue,  7 Mar 2023 20:24:47 +0100
Message-Id: <20230307192449.24732-10-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230307192449.24732-1-bp@alien8.de>
References: <20230307192449.24732-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dionna Glaze <dionnaglaze@google.com>

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

  [ bp: Rewrite commit message and do a simplified version. ]

Fixes: d5af44dde546 ("x86/sev: Provide support for SNP guest request NAEs")
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230214164638.1189804-2-dionnaglaze@google.com
---
 arch/x86/include/asm/sev-common.h       |  3 ++-
 arch/x86/kernel/sev.c                   |  4 ++++
 drivers/virt/coco/sev-guest/sev-guest.c | 19 ++++++++++++++++++-
 3 files changed, 24 insertions(+), 2 deletions(-)

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
index d67884fb38c1..3f664ab277c4 100644
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
index 81a53c31ff46..46f1a8d558b0 100644
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
 
@@ -360,6 +364,19 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
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
-- 
2.35.1

