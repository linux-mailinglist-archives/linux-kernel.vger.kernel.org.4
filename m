Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4352611EB5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 02:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJ2A0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 20:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ2A0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 20:26:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83906BCC6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 17:26:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68DC0B82AD4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 00:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F11C433D7;
        Sat, 29 Oct 2022 00:26:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RoZ/x/iR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667003184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oSzt/28SVInbI24zhK/HAss+TrNhWxqpt3Qf3wZ1sxE=;
        b=RoZ/x/iRlhjG4O9TAaL8ucsa48MB2Ugx503M4bo8Iba6iTElylWw/tIM+iNqxK6TMWOPsh
        tKqM3L2B9Ab72H+4/2pve0xjIFwP4C91pbn2LlYgSn+N6KAmb8HIZmav5INT+pY8N0yLVy
        B5zOsTEKc4izynuZ5Igvip762PubpiQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a7c336f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 29 Oct 2022 00:26:24 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/espfix: Use get_random_long() rather than archrandom
Date:   Sat, 29 Oct 2022 02:26:13 +0200
Message-Id: <20221029002613.143153-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A call is made to arch_get_random_longs() and rdtsc(), rather than just
using get_random_long(), because this was written during a time when
very early boot would give abysmal entropy. These days, a call to
get_random_long() at early boot will incorporate RDRAND, RDTSC, and
more, without having to do anything bespoke.

In fact, the situation is now such that on the majority of x86 systems,
the pool actually is initialized at this point, even though it doesn't
need to be for get_random_long() to still return something better than
what this function currently does.

So simplify this to just call get_random_long() instead.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/kernel/espfix_64.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/x86/kernel/espfix_64.c b/arch/x86/kernel/espfix_64.c
index 9417d5aa7305..16f9814c9be0 100644
--- a/arch/x86/kernel/espfix_64.c
+++ b/arch/x86/kernel/espfix_64.c
@@ -94,17 +94,7 @@ static inline unsigned long espfix_base_addr(unsigned int cpu)
 
 static void init_espfix_random(void)
 {
-	unsigned long rand;
-
-	/*
-	 * This is run before the entropy pools are initialized,
-	 * but this is hopefully better than nothing.
-	 */
-	if (!arch_get_random_longs(&rand, 1)) {
-		/* The constant is an arbitrary large prime */
-		rand = rdtsc();
-		rand *= 0xc345c6b72fd16123UL;
-	}
+	unsigned long rand = get_random_long();
 
 	slot_random = rand % ESPFIX_STACKS_PER_PAGE;
 	page_random = (rand / ESPFIX_STACKS_PER_PAGE)
-- 
2.38.1

