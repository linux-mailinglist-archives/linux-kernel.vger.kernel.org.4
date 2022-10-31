Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9574613E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiJaT1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiJaT1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:27:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BE512A91;
        Mon, 31 Oct 2022 12:27:02 -0700 (PDT)
Date:   Mon, 31 Oct 2022 19:26:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667244420;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3D7hSGn0CvbQ9zOj43AcDS1HiRH7N6eiQqKa+886cCw=;
        b=zDC9L7UeNyWewuULyQaGuaA0gFbmzXEJzcbYwiyKAgzMMr6BDwGvlSa+zzqWuE6NKEkzJ6
        KxCodjeQnYmXiWJ0uTGPLRbzFKCKJrpLnjdJqKT5B9OA7uk7gUp/XLCPibPHhZJtd+bV1w
        QYV09UIR+4Q3Y0oy5aTmUGFkGeAsROsUEywFuvWIjLyFcVpDItoaasl85N7hKEdaoRXLiq
        KotKnRdDvhDRNSUfIZ+xnkmQIT+iyPFHPTcZCyyxcR0yCV7yVaUOe+xcaUIqTID3Kj4t+l
        6ijZmhRaKfCCnVpeKJyVxuETsLB4ur+9nXdky75YTiCw0RVVrw08nPhBc/sJug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667244420;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3D7hSGn0CvbQ9zOj43AcDS1HiRH7N6eiQqKa+886cCw=;
        b=N7AzqcQ7o/OQlnFQ8OpabKi+FoKbRq93z+E4O/HwbydJmmz0hxYT4/yO4KOlfaY7zjhHZG
        2itkhCBNqi/7WUDA==
From:   "tip-bot2 for Jason A. Donenfeld" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/espfix: Use get_random_long() rather than archrandom
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221029002613.143153-1-Jason@zx2c4.com>
References: <20221029002613.143153-1-Jason@zx2c4.com>
MIME-Version: 1.0
Message-ID: <166724441903.7716.9086577777719332166.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     00ed1eabcc3b785aecf6f6cbb41d7b436bb54d28
Gitweb:        https://git.kernel.org/tip/00ed1eabcc3b785aecf6f6cbb41d7b436bb54d28
Author:        Jason A. Donenfeld <Jason@zx2c4.com>
AuthorDate:    Sat, 29 Oct 2022 02:26:13 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 31 Oct 2022 20:12:50 +01:00

x86/espfix: Use get_random_long() rather than archrandom

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

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221029002613.143153-1-Jason@zx2c4.com
---
 arch/x86/kernel/espfix_64.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/x86/kernel/espfix_64.c b/arch/x86/kernel/espfix_64.c
index 9417d5a..16f9814 100644
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
