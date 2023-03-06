Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593356AC82B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjCFQgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjCFQf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:35:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632093B202
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 08:35:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1778F1FDE4;
        Mon,  6 Mar 2023 16:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678120479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0JsZ/VnHkJzmuDE7gMbHKVhyFu+vf+6Nmu9WRKJMi3s=;
        b=FDrOH3OoQ6bIZecckFCAR+JTM5Ks/ekJZv6L41zO46FDqLHp32JNrBzlEuoz5EiibkZ3jQ
        NB8VXAbRlIRVaz/Go6GkYh2eMc5emfg3/a0/PnMKxdFR86myCbVYjKLbnNsU/gCMM/Zqbd
        xUW8WXTqZWk3lSUYNqL7DGsBJZakcl8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF25613A66;
        Mon,  6 Mar 2023 16:34:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TJhGMR4WBmQpUwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 06 Mar 2023 16:34:38 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 02/12] x86/mtrr: optimize mtrr_calc_physbits()
Date:   Mon,  6 Mar 2023 17:34:15 +0100
Message-Id: <20230306163425.8324-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230306163425.8324-1-jgross@suse.com>
References: <20230306163425.8324-1-jgross@suse.com>
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

