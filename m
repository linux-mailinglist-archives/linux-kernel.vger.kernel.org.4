Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664D872465C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238159AbjFFOiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbjFFOhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:37:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8952A171A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:38 -0700 (PDT)
Message-ID: <20230606142031.648340279@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=8wmGhqPNf6kLMrAqxn6joNLQMcupbwgXa/J0H7C+wQY=;
        b=GwMdq1JohYipn8STMGUW7ZcBa0yY0aE3Ne8q2Y9kWG6zabuktu+VI67AjX4eDD+0a+nfDQ
        Y5y91IEr8HN2mxJVrGL5+RPQvuivR8M9KTlm9W21IBPkuEff8Ga4g1o5Bt0mYvUcmII07A
        3rahALeLN57kl6Xfo9m1eVR3o9mND58LTV+fiR/lwgnq89D337yFIktgK83Wh/Lq++f+bW
        k6SXurPQDJPLB+GXX4Zi7UhydCCH35CP3tSuwcEOZTrkHs4vKmHbI2hPwi6bsbaWpNZy4W
        y+NZUY2n1XOUpcTQ2vxyZGs5aEkTjT2CiCdAR1FOy2Syh6s9Z464xbdAXQiUaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=8wmGhqPNf6kLMrAqxn6joNLQMcupbwgXa/J0H7C+wQY=;
        b=AFQgyOFQtWxkhRmhQZ8dSxldXlmaT+Lhpj3c5Vt0pTIv0bC1H3JDQa2jlaj3E8vb34iPS+
        p88qJF0IKGlbLFBg==
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
Subject: [patch 11/45] posix-cpu-timers: Remove incorrect comment in
 posix_cpu_timer_set()
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:37:36 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A leftover from historical code which describes fiction.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -704,13 +704,8 @@ static int posix_cpu_timer_set(struct k_
 		}
 	}
 
+	/* Retry if the timer expiry is running concurrently */
 	if (unlikely(ret)) {
-		/*
-		 * We are colliding with the timer actually firing.
-		 * Punt after filling in the timer's old value, and
-		 * disable this firing since we are already reporting
-		 * it as an overrun (thanks to bump_cpu_timer above).
-		 */
 		unlock_task_sighand(p, &flags);
 		goto out;
 	}

