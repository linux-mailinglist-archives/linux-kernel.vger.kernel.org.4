Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5196010C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiJQOJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiJQOJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:09:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D33665249;
        Mon, 17 Oct 2022 07:09:10 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:09:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666015749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RCx8kEGVPlTMh63B682V/Mb9Zb7eNpGcPYD2Rcy41og=;
        b=Xmv1DjyPgcCHsMfy+Ked89Yb/bQs7HpXwXwZLeDHB0TFPV+YAc/0E2ThLsriKhtP+qGUrn
        l9p4E3/bvO+tM7Gai7Bc/a+kMXf8zlARDr1ZoOYGhq7x63UqVfCNdKTOtuReShrHvE4g8O
        vdKT1xpUmS8wjQ6Cf0bthZAMPPkiQAZwjw4otxSY9hxBzLENHRyH1aPF/Mq2TmVP62RFtJ
        k/iMLDQ0F5fKRwsQvJmKXX5hJZqr2YYbYNUYWskxYph4+nUJ8TuaYYREPd0v6VKiQIxdP0
        eo0AMITShn1J80oc7W8xNBwEMF6Ds5o+SWx+6JZJUZZFyTFH4yD3rggU3ld8pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666015749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RCx8kEGVPlTMh63B682V/Mb9Zb7eNpGcPYD2Rcy41og=;
        b=cYzGgM/iFbfTBotS5N8mck5H6/yvq2MwOp87Lsx7VxwX+UMJ9LLZwKa4hI6yByEG1EYOrv
        gfOm6Rh+8hnh7pAQ==
From:   "tip-bot2 for ye xingchen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Replace in_irq() with in_hardirq()
Cc:     ye xingchen <ye.xingchen@zte.com.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221012012629.334966-1-ye.xingchen@zte.com.cn>
References: <20221012012629.334966-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Message-ID: <166601574750.401.8980983182110986351.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8be3f96ceddb911539a53d87a66da84a04502366
Gitweb:        https://git.kernel.org/tip/8be3f96ceddb911539a53d87a66da84a04502366
Author:        ye xingchen <ye.xingchen@zte.com.cn>
AuthorDate:    Wed, 12 Oct 2022 01:26:29 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Oct 2022 16:00:04 +02:00

timers: Replace in_irq() with in_hardirq()

Replace the obsolete and ambiguous macro in_irq() with new
macro in_hardirq().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/r/20221012012629.334966-1-ye.xingchen@zte.com.cn

---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 717fcb9..f40c88c 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1422,7 +1422,7 @@ int del_timer_sync(struct timer_list *timer)
 	 * don't use it in hardirq context, because it
 	 * could lead to deadlock.
 	 */
-	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
+	WARN_ON(in_hardirq() && !(timer->flags & TIMER_IRQSAFE));
 
 	/*
 	 * Must be able to sleep on PREEMPT_RT because of the slowpath in
