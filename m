Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC3C6A04E3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjBWJdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbjBWJdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:33:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBFC28228
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:32:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 362F95BCDC;
        Thu, 23 Feb 2023 09:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677144778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0JsZ/VnHkJzmuDE7gMbHKVhyFu+vf+6Nmu9WRKJMi3s=;
        b=liRrtO9rVSKWXBrdlEBclFvctgfIPN7i6RfwaaJ/K9zNUblmvRJG/tRClRe9MlLTyrgeT3
        /SWIZ+EHzS+bYmhBrDdltNyakI+u4/ptpLYRA4M3HbHvt722ITW4yA/wru032KC/EBA6xu
        5pSuqzZJRzLhJ5Xl+bRa7u+OvWOGj3k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE92213928;
        Thu, 23 Feb 2023 09:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mNfMOMky92N5bAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 23 Feb 2023 09:32:57 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 02/12] x86/mtrr: optimize mtrr_calc_physbits()
Date:   Thu, 23 Feb 2023 10:32:33 +0100
Message-Id: <20230223093243.1180-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230223093243.1180-1-jgross@suse.com>
References: <20230223093243.1180-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimize mtrr_calc_physbits() for better readability.

Drop a stale comment, as reality has made it obsolete.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- new patch, split off from previous patch (Boris Petkov)
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 8310bdb111d0..7596ebeab929 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -619,8 +619,6 @@ static struct syscore_ops mtrr_syscore_ops = {
 
 int __initdata changed_by_mtrr_cleanup;
 
-#define SIZE_OR_MASK_BITS(n)  (~((1ULL << ((n) - PAGE_SHIFT)) - 1))
-
 static unsigned int __init mtrr_calc_physbits(bool generic)
 {
 	unsigned int phys_addr;
@@ -628,15 +626,8 @@ static unsigned int __init mtrr_calc_physbits(bool generic)
 	phys_addr = 32;
 
 	if (generic) {
-		size_or_mask = SIZE_OR_MASK_BITS(36);
-		size_and_mask = 0x00f00000;
 		phys_addr = 36;
 
-		/*
-		 * This is an AMD specific MSR, but we assume(hope?) that
-		 * Intel will implement it too when they extend the address
-		 * bus of the Xeon.
-		 */
 		if (cpuid_eax(0x80000000) >= 0x80000008) {
 			phys_addr = cpuid_eax(0x80000008) & 0xff;
 			/* CPUID workaround for Intel 0F33/0F34 CPU */
@@ -647,23 +638,19 @@ static unsigned int __init mtrr_calc_physbits(bool generic)
 			     boot_cpu_data.x86_stepping == 0x4))
 				phys_addr = 36;
 
-			size_or_mask = SIZE_OR_MASK_BITS(phys_addr);
-			size_and_mask = ~size_or_mask & 0xfffff00000ULL;
 		} else if (boot_cpu_data.x86_vendor == X86_VENDOR_CENTAUR &&
 			   boot_cpu_data.x86 == 6) {
 			/*
 			 * VIA C* family have Intel style MTRRs,
 			 * but don't support PAE
 			 */
-			size_or_mask = SIZE_OR_MASK_BITS(32);
-			size_and_mask = 0;
 			phys_addr = 32;
 		}
-	} else {
-		size_or_mask = SIZE_OR_MASK_BITS(32);
-		size_and_mask = 0;
 	}
 
+	size_or_mask = ~((1ULL << (phys_addr - PAGE_SHIFT)) - 1);
+	size_and_mask = ~size_or_mask & 0xfffff00000ULL;
+
 	return phys_addr;
 }
 
-- 
2.35.3

