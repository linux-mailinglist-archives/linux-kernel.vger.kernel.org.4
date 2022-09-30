Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5B15F168F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 01:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiI3XP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 19:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiI3XPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 19:15:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C45CEEB2;
        Fri, 30 Sep 2022 16:15:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED162B82986;
        Fri, 30 Sep 2022 23:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D20C433D6;
        Fri, 30 Sep 2022 23:15:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lfnFBZfy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664579740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tNSsweT9TTVejKwOARbU5QKMnoD9GUfRqiMtcILsJxo=;
        b=lfnFBZfytp82YCa4ht9ykeqc+yqNznvUWpO5CqL/0yr81o7fBldgTBvBuK0pJ7VeDv5Bhr
        I1CXTGthH5oXLSvIArTN4NOdy4dqoH6BiC5yvuUE7kyhSo1VUM6Nf6FRTzkFsjxyjcyfNh
        SzGaugAUL0nHwggvMYkSBCifY/5VajM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d1e3b0ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 30 Sep 2022 23:15:40 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: [PATCH 1/2] random: schedule jitter credit for next jiffy, not in two jiffies
Date:   Sat,  1 Oct 2022 01:10:49 +0200
Message-Id: <20220930231050.749824-1-Jason@zx2c4.com>
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

Counterintuitively, mod_timer(..., jiffies + 1) will cause the timer to
fire not in the next jiffy, but in two jiffies. The way to cause
the timer to fire in the next jiffy is with mod_timer(..., jiffies).
Doing so then lets us bump the upper bound back up again.

Fixes: 50ee7529ec45 ("random: try to actively add entropy rather than passively wait for it")
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 64ee16ffb8b7..fdf15f5c87dd 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1205,7 +1205,7 @@ static void __cold entropy_timer(struct timer_list *timer)
  */
 static void __cold try_to_generate_entropy(void)
 {
-	enum { NUM_TRIAL_SAMPLES = 8192, MAX_SAMPLES_PER_BIT = HZ / 30 };
+	enum { NUM_TRIAL_SAMPLES = 8192, MAX_SAMPLES_PER_BIT = HZ / 15 };
 	struct entropy_timer_state stack;
 	unsigned int i, num_different = 0;
 	unsigned long last = random_get_entropy();
@@ -1224,7 +1224,7 @@ static void __cold try_to_generate_entropy(void)
 	timer_setup_on_stack(&stack.timer, entropy_timer, 0);
 	while (!crng_ready() && !signal_pending(current)) {
 		if (!timer_pending(&stack.timer))
-			mod_timer(&stack.timer, jiffies + 1);
+			mod_timer(&stack.timer, jiffies);
 		mix_pool_bytes(&stack.entropy, sizeof(stack.entropy));
 		schedule();
 		stack.entropy = random_get_entropy();
-- 
2.37.3

