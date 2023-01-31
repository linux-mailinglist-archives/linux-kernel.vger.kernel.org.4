Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E3A682A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjAaK34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjAaK3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:29:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FD52E809;
        Tue, 31 Jan 2023 02:29:49 -0800 (PST)
Date:   Tue, 31 Jan 2023 10:29:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675160988;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZSFLu5PcmayMzopI1PFzP7fFHTORSpbtQIe8QyeRbQ0=;
        b=sDPU5+8rbUNbk1oIr7DZHYma+m1uQXzpqODf1mYB/NmffCakDpx2zyAQDctV2tGD8CF5dC
        X2JF7wSyf7gcqfZu0tbMfmM3PNHwEDrcW5ePZNtLXVJt0zjy8V6kLW++/b6XBvdMGOZQHh
        arBXTmCk0tIpqLIkyCTxt77HfFegSYUsTBLTviQzH/y6EeqjIrxB+VIuEC1r8vzooiDr8Z
        NlfXmcPCwrYobcQgdoKnR05wXCQmAdCIYSNt4uUmaVV1fX/4SHDRieykI2RT/FSTeGtP4x
        E0H1wMVau6WGPLrubnBnVN4klvyHtbHRUQl3/kpqG4inFny6ti7BVlLbaF2xhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675160988;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZSFLu5PcmayMzopI1PFzP7fFHTORSpbtQIe8QyeRbQ0=;
        b=M+loRO7BRXvfuBV79is4+0PvsASBl6EhoHgZ7L+ivCo4vCvS3Q+XV+XgdEm1DoI8Qkjgru
        cITXtM7wk3soi/CA==
From:   "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Rely on rt_task() for DL tasks too
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230123173206.6764-2-dave@stgolabs.net>
References: <20230123173206.6764-2-dave@stgolabs.net>
MIME-Version: 1.0
Message-ID: <167516098801.4906.2814079392382418239.tip-bot2@tip-bot2>
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

Commit-ID:     c14fd3dcacaa480394d3ac0b4a91a7d17a4b5516
Gitweb:        https://git.kernel.org/tip/c14fd3dcacaa480394d3ac0b4a91a7d17a4b5516
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Mon, 23 Jan 2023 09:32:05 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 31 Jan 2023 11:23:07 +01:00

hrtimer: Rely on rt_task() for DL tasks too

Checking dl_task() is redundant as rt_task() returns true for deadline
tasks too.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230123173206.6764-2-dave@stgolabs.net

---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e4f0e3b..667b713 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2089,7 +2089,7 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode,
 	u64 slack;
 
 	slack = current->timer_slack_ns;
-	if (dl_task(current) || rt_task(current))
+	if (rt_task(current))
 		slack = 0;
 
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
