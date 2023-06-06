Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C87F724684
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238370AbjFFOlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238322AbjFFOjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:39:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE90C1996
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:38:35 -0700 (PDT)
Message-ID: <20230606142033.497103352@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QX5B1K8+RZfszOFPTG8OurkUDJXHJzL25+Bw2kwFOks=;
        b=vOQ16cEyHNDbLUGFYruJwYjN4q7pIkx1YIMSNjLezUFntAY4NfLKrNSAzGYShK+1bxxWsj
        JdTJO0LI62p7/tTNapErdK+exa61vb0ceeby4gZNozm6CemlpY0qk0sD2sT7M+FiQU2Mgm
        NbHtaH8AZaVsAQkk0f2bWrwKKme4v0bmelpc59kik23/kxjpHC1p+NgFHzWTUiH6xCoKRj
        sTr9suQXRMCs1SfNb1Bc6nL3DFVt2lxu4oA/+8uGYxnOxiSrHpvnGEGVvgEpb/QB8QW0kb
        fOTF+6Avu2+90TgxQBnR0zlbNgBF2TU00pkceF9D6xOU5bS7og20jyHSdMQKVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QX5B1K8+RZfszOFPTG8OurkUDJXHJzL25+Bw2kwFOks=;
        b=20weg5fGBIvVECqLe85GEUt4JCXeb060IkO4yfxADrXdfn7vxTPULxdLKN53UFqd5AC16g
        BcxX0Gy8w4gmKuCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [patch 44/45] alarmtimers: Remove the throttle mechanism from
 alarm_forward_now()
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:38:28 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that ignored posix timer signals are requeued and the timers are
rearmed on signal delivery the workaround to keep such timers alive and
self rearm them is not longer required.

Remove the unused alarm timer parts.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/alarmtimer.c |   28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -458,35 +458,11 @@ u64 alarm_forward(struct alarm *alarm, k
 }
 EXPORT_SYMBOL_GPL(alarm_forward);
 
-static u64 __alarm_forward_now(struct alarm *alarm, ktime_t interval, bool throttle)
+u64 alarm_forward_now(struct alarm *alarm, ktime_t interval)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
-	ktime_t now = base->get_ktime();
-
-	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && throttle) {
-		/*
-		 * Same issue as with posix_timer_fn(). Timers which are
-		 * periodic but the signal is ignored can starve the system
-		 * with a very small interval. The real fix which was
-		 * promised in the context of posix_timer_fn() never
-		 * materialized, but someone should really work on it.
-		 *
-		 * To prevent DOS fake @now to be 1 jiffie out which keeps
-		 * the overrun accounting correct but creates an
-		 * inconsistency vs. timer_gettime(2).
-		 */
-		ktime_t kj = NSEC_PER_SEC / HZ;
 
-		if (interval < kj)
-			now = ktime_add(now, kj);
-	}
-
-	return alarm_forward(alarm, now, interval);
-}
-
-u64 alarm_forward_now(struct alarm *alarm, ktime_t interval)
-{
-	return __alarm_forward_now(alarm, interval, false);
+	return alarm_forward(alarm, base->get_ktime(), interval);
 }
 EXPORT_SYMBOL_GPL(alarm_forward_now);
 

