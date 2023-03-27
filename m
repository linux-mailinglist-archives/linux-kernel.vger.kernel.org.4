Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69BD6CAF72
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjC0UKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjC0UJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:09:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDFE198D;
        Mon, 27 Mar 2023 13:09:55 -0700 (PDT)
Date:   Mon, 27 Mar 2023 20:09:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679947793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B+c5GdlWj1yBxvFb1qVwQW6Ns/qLp2fdd2CY1LbeZ3w=;
        b=UPB4pYqJK32LmtsStt47YBM5CDrySrZmFa05YJxi6WH/xF2894Fr1R47DJbeNiubHoplfk
        FYvcP+iyC7OH01QT/pk9xoIT/9xEzYA1VOl/mu7uLsOa0jtKqaOEtWDJgDEkF3xrxqnyO2
        RacJxgU1cnOeOb5gJ3eJmniHZTbfEjhTgP/9SNDz+5PJlUkdbiHyaeECnXzRn8iOkdteoA
        ke+qTQe3rQP10Hg53nheUj3FSTxE+awlmuH2g6EmgXI2Ej9nM1eh9qelpX4fxNW1Vb7Fku
        EmXdBHv4k3N/jDymuswibbBjMXZZWUgDaHmkFx6PZ1Xq3/hwl+tsSzbbLu74xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679947793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B+c5GdlWj1yBxvFb1qVwQW6Ns/qLp2fdd2CY1LbeZ3w=;
        b=V2bvNWBNqq6K5bMlp+hxHd+GH0OokcOZLZxr4rQZQ0S7l4+QlQg1xbnqXtD0ICARWAyeLN
        fOavEpzc43CGUpAw==
From:   "tip-bot2 for Michael Kelley" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] init: Call mem_encrypt_init() after Hyper-V hypercall
 init is done
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1678329614-3482-6-git-send-email-mikelley@microsoft.com>
References: <1678329614-3482-6-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Message-ID: <167994779275.5837.4752888881557420711.tip-bot2@tip-bot2>
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

Commit-ID:     e45e761b77bc0739e7e23258c4394013bbb919c7
Gitweb:        https://git.kernel.org/tip/e45e761b77bc0739e7e23258c4394013bbb919c7
Author:        Michael Kelley <mikelley@microsoft.com>
AuthorDate:    Wed, 08 Mar 2023 18:40:06 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 27 Mar 2023 09:24:01 +02:00

init: Call mem_encrypt_init() after Hyper-V hypercall init is done

Full Hyper-V initialization, including support for hypercalls, is done
as an apic_post_init callback via late_time_init().  mem_encrypt_init()
needs to make hypercalls when it marks swiotlb memory as decrypted.
But mem_encrypt_init() is currently called a few lines before
late_time_init(), so the hypercalls don't work.

Fix this by moving mem_encrypt_init() after late_time_init() and
related clock initializations. The intervening initializations don't
do any I/O that requires the swiotlb, so moving mem_encrypt_init()
slightly later has no impact.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/1678329614-3482-6-git-send-email-mikelley@microsoft.com
---
 init/main.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/init/main.c b/init/main.c
index 4425d17..7e9c0ca 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1088,14 +1088,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	 */
 	locking_selftest();
 
-	/*
-	 * This needs to be called before any devices perform DMA
-	 * operations that might use the SWIOTLB bounce buffers. It will
-	 * mark the bounce buffers as decrypted so that their usage will
-	 * not cause "plain-text" data to be decrypted when accessed.
-	 */
-	mem_encrypt_init();
-
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start && !initrd_below_start_ok &&
 	    page_to_pfn(virt_to_page((void *)initrd_start)) < min_low_pfn) {
@@ -1112,6 +1104,17 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 		late_time_init();
 	sched_clock_init();
 	calibrate_delay();
+
+	/*
+	 * This needs to be called before any devices perform DMA
+	 * operations that might use the SWIOTLB bounce buffers. It will
+	 * mark the bounce buffers as decrypted so that their usage will
+	 * not cause "plain-text" data to be decrypted when accessed. It
+	 * must be called after late_time_init() so that Hyper-V x86/x64
+	 * hypercalls work when the SWIOTLB bounce buffers are decrypted.
+	 */
+	mem_encrypt_init();
+
 	pid_idr_init();
 	anon_vma_init();
 #ifdef CONFIG_X86
