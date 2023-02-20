Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B2769C911
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjBTKzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjBTKzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:55:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9FE125A3;
        Mon, 20 Feb 2023 02:55:18 -0800 (PST)
Date:   Mon, 20 Feb 2023 11:53:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676890386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VMlRuwwKFaDOFozsW5/lA/ovZxkXQyrOmh+1N+NT1cE=;
        b=iJ7m8gNXuG7lNaXKbDx14Z5NdckmihepCLDJGqWqMsaPTYMfBI3NNYJG5Tpz+TlglRR3b2
        b7FQgJDkeu3wZ5eg0wJxSHSnlDKmlDffattQLHu/jpj91NXbRLQJN1E2NlkXvNIqpwWhP6
        arlfl3sOqI6W4X1HRGZdqsXsndscYaIBx+q5EeEtC4OaNzDjpBz2KoFf/a6tYiQMCOpVR/
        F6EgkDoZBdcd5j5Fgh82wT0QV6ikCEDkAlhz3qkp8HSDx/TwMtGAw7akrPXWLsVnmZOOEl
        AzCVP2yMvpy0N5Uz8isNRIpyD6YNpU0EqkEszrNcQRNU7Y/Kzj0RxXjzGUSWqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676890386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VMlRuwwKFaDOFozsW5/lA/ovZxkXQyrOmh+1N+NT1cE=;
        b=DhFTEr9qmhccMw6VWW0wTkcRtS2jP2bWTGy6tEdpFXAksSsZpCYyoIDZ6Bme8uthwRLRKz
        20DSvDyOEBnkVGAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Chang, Junxiao" <junxiao.chang@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Peh, Hock Zhang" <hock.zhang.peh@intel.com>
Subject: Re: RE: [PATCH] softirq: wake up ktimer thread in softirq context
Message-ID: <Y/NREeAuML26ddUf@linutronix.de>
References: <20221208075604.811710-1-junxiao.chang@intel.com>
 <Y++5ry75hEI2NWrK@linutronix.de>
 <BN9PR11MB5370CFD46CA0A2E245AFBE04ECA49@BN9PR11MB5370.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5370CFD46CA0A2E245AFBE04ECA49@BN9PR11MB5370.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------->8------

From: Junxiao Chang <junxiao.chang@intel.com>
Date: Mon, 20 Feb 2023 09:12:20 +0100
Subject: [PATCH] softirq: Wake ktimers thread also in softirq.

If the hrtimer is raised while a softirq is processed then it does not
wake the corresponding ktimers thread. This is due to the optimisation in the
irq-exit path which is also used to wake the ktimers thread. For the other
softirqs, this is okay because the additional softirq bits will be handled by
the currently running softirq handler.
The timer related softirq bits are added to a different variable and rely on
the ktimers thread.
As a consuequence the wake up of ktimersd is delayed until the next timer tick.

Always wake the ktimers thread if a timer related softirq is pending.

Reported-by: Peh, Hock Zhang <hock.zhang.peh@intel.com>
Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/softirq.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -664,13 +664,12 @@ static inline void __irq_exit_rcu(void)
 #endif
 	account_hardirq_exit(current);
 	preempt_count_sub(HARDIRQ_OFFSET);
-	if (!in_interrupt()) {
-		if (local_softirq_pending())
-			invoke_softirq();
+	if (!in_interrupt() && local_softirq_pending())
+		invoke_softirq();
 
-		if (IS_ENABLED(CONFIG_PREEMPT_RT) && local_pending_timers())
-			wake_timersd();
-	}
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && local_pending_timers() &&
+	    !(in_nmi() | in_hardirq()))
+		wake_timersd();
 
 	tick_irq_exit();
 }
