Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F369E6CAF73
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjC0UKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjC0UJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:09:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2F619A7;
        Mon, 27 Mar 2023 13:09:55 -0700 (PDT)
Date:   Mon, 27 Mar 2023 20:09:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679947793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ws/cONdphCMGN2kVG9ytVBFiCX4w0E0yXRd1E6lu6dQ=;
        b=Bu1TOWzujWz6c1PNVFAUVhXmcmRD57MNgqxWo/RyTCJXAiot94zjbEMgs4iA7jkHD4KVwq
        d4wkj7YJ1KILLM/EOv4az2m0qzhdn4Gp2FdCAV+jOmSXgMx7hDZpBpBYRcQLc9ZPvVeNRo
        R6dkCCyk3y7PJFq3CicppgGWV2rG+KlzIh3AWcSNIllrKqHBtVckoEXiZIFW6fWSz6ttbS
        b2xViN3f4t2OoJdAfKgBwMY9NkM66OibN2OQjP1Ts1LxpZFo5E/ojkrV9W59qlLUNVQlmp
        BseISOS/BCUgpkGsWBfeFx7NFwq/gJLSd+h3w/sCV1w9kewVempOY1pgtSRKMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679947793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ws/cONdphCMGN2kVG9ytVBFiCX4w0E0yXRd1E6lu6dQ=;
        b=NMgVRnN1pjaJRJzALKJT1ZINvQopw1p1b0BiZAvCpYyheVd09TRo/xH2c+Xl1TkGIFosY2
        yDHeoQwGATgYp+BQ==
From:   "tip-bot2 for Michael Kelley" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/mm: Handle decryption/re-encryption of
 bss_decrypted consistently
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1678329614-3482-5-git-send-email-mikelley@microsoft.com>
References: <1678329614-3482-5-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Message-ID: <167994779300.5837.15408896550338511854.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     c7b5254bd802ee3868f1c59333545272dc700d6d
Gitweb:        https://git.kernel.org/tip/c7b5254bd802ee3868f1c59333545272dc700d6d
Author:        Michael Kelley <mikelley@microsoft.com>
AuthorDate:    Wed, 08 Mar 2023 18:40:05 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 27 Mar 2023 09:23:21 +02:00

x86/mm: Handle decryption/re-encryption of bss_decrypted consistently

sme_postprocess_startup() decrypts the bss_decrypted section when
sme_me_mask is non-zero.

mem_encrypt_free_decrypted_mem() re-encrypts the unused portion based
on CC_ATTR_MEM_ENCRYPT.

In a Hyper-V guest VM using vTOM, these conditions are not equivalent
as sme_me_mask is always zero when using vTOM. Consequently,
mem_encrypt_free_decrypted_mem() attempts to re-encrypt memory that was
never decrypted.

So check sme_me_mask in mem_encrypt_free_decrypted_mem() too.

Hyper-V guests using vTOM don't need the bss_decrypted section to be
decrypted, so skipping the decryption/re-encryption doesn't cause a
problem.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/1678329614-3482-5-git-send-email-mikelley@microsoft.com
---
 arch/x86/mm/mem_encrypt_amd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 9c4d8db..e0b51c0 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -513,10 +513,14 @@ void __init mem_encrypt_free_decrypted_mem(void)
 	npages = (vaddr_end - vaddr) >> PAGE_SHIFT;
 
 	/*
-	 * The unused memory range was mapped decrypted, change the encryption
-	 * attribute from decrypted to encrypted before freeing it.
+	 * If the unused memory range was mapped decrypted, change the encryption
+	 * attribute from decrypted to encrypted before freeing it. Base the
+	 * re-encryption on the same condition used for the decryption in
+	 * sme_postprocess_startup(). Higher level abstractions, such as
+	 * CC_ATTR_MEM_ENCRYPT, aren't necessarily equivalent in a Hyper-V VM
+	 * using vTOM, where sme_me_mask is always zero.
 	 */
-	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
+	if (sme_me_mask) {
 		r = set_memory_encrypted(vaddr, npages);
 		if (r) {
 			pr_warn("failed to free unused decrypted pages\n");
