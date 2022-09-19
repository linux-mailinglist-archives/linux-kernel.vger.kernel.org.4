Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7989D5BCBF1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiISMh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiISMh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:37:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35910BC88;
        Mon, 19 Sep 2022 05:37:55 -0700 (PDT)
Date:   Mon, 19 Sep 2022 12:37:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663591073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=phDbT/vi7cOQ2up7UDK1cOyMQCmux49oAEGff+zDm8c=;
        b=r9PB5rYPWeSVikpkdm63X4Tu69/uATYl4AauJC6CWPy58pzlpt2O/Fte0ng5pRpG1kYhOi
        69odC1SAepr7amlZW+RemZhWVrrG7f+UbEyu5r6U//xkpdKd6emLLM/3WqnrEQXiFU5inf
        D3qPnc9cG0xFYhl2gqGl0HNpnaN6j3QTiRM5+nMBOD+PnxVG+37MrJMsRQ0cPwgbfPlMK7
        47aR8UerZVXdteqhcf6OvKxtpeWa3iL+wWYCC0WH0b2OHS12Ve1MusNzFuGBQltrHItQwt
        mvIBytaAAFuqQ70e+8542vyBzl90BTfN1lcWLWB08W1CNKxtcJo04u25dZxN7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663591073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=phDbT/vi7cOQ2up7UDK1cOyMQCmux49oAEGff+zDm8c=;
        b=FdsDlUlbAbf72OsWpe21+sX0s9DcUDi7daTjGbPF/RaubueLW59jKnCsv/rT383Xw+auP5
        H1/zTHkLOxBjDmCg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] flex_proportions: Disable preemption entering the
 write section.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220825164131.402717-8-bigeasy@linutronix.de>
References: <20220825164131.402717-8-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <166359107270.401.9573947543193846514.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     9458e0a78c45bc6537ce11eb9f03489eab92f9c2
Gitweb:        https://git.kernel.org/tip/9458e0a78c45bc6537ce11eb9f03489eab92f9c2
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 25 Aug 2022 18:41:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Sep 2022 14:35:08 +02:00

flex_proportions: Disable preemption entering the write section.

The seqcount fprop_global::sequence is not associated with a lock. The
write section (fprop_new_period()) is invoked from a timer and since the
softirq is preemptible on PREEMPT_RT it is possible to preempt the write
section which is not desited.

Disable preemption around the write section on PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220825164131.402717-8-bigeasy@linutronix.de

---
 lib/flex_proportions.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
index 05cccbc..83332fe 100644
--- a/lib/flex_proportions.c
+++ b/lib/flex_proportions.c
@@ -70,6 +70,7 @@ bool fprop_new_period(struct fprop_global *p, int periods)
 	 */
 	if (events <= 1)
 		return false;
+	preempt_disable_nested();
 	write_seqcount_begin(&p->sequence);
 	if (periods < 64)
 		events -= events >> periods;
@@ -77,6 +78,7 @@ bool fprop_new_period(struct fprop_global *p, int periods)
 	percpu_counter_add(&p->events, -events);
 	p->period += periods;
 	write_seqcount_end(&p->sequence);
+	preempt_enable_nested();
 
 	return true;
 }
