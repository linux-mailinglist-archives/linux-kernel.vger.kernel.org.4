Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731E56C5998
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 23:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjCVWs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 18:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCVWsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:48:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9FB40FC;
        Wed, 22 Mar 2023 15:48:53 -0700 (PDT)
Date:   Wed, 22 Mar 2023 22:48:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679525331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SDhT9TCsh0+kGa2j9Qd4A7H8TlQT3/KNsLPRBXRfuuI=;
        b=YG7Wzowa3aD/5R4c7J2Eo/Mt+bNUqpoaMiQHZG6NbLj5dQSzySr/X+uP8or/R8PcrCFT4d
        R7Xi3GXVkx9GIvg2d8GdmovMbf2CSyxOhl0c12YYYIMx66duozIJqpVKPSh8XL5krlX6Y2
        OmjTmT64lcjhc9jDtWENixhPh0iW0siy7MMVr4LNM70C8e1BMzSIkzz81cDmhyDFQluBx6
        a9xd3eC5wkoDmstisF0biTGFVVXtLx1x9tn5bVOL7/1+p2rOeufat+gRpcrIj4KP+GrmRU
        EO+gM9hmxnFZ74xGVb6tTzqXsMGgghHA5xMX7dAR59mK2HM8adWBmSONb5g3cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679525331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SDhT9TCsh0+kGa2j9Qd4A7H8TlQT3/KNsLPRBXRfuuI=;
        b=jCTTiZkOgCochuKJ1LCQsIrhv/sEJIZla733ujD8RCOG3u0NJFZP2HN2idOMej03l2iMbd
        2E8ySdl6te3JJlAw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] livepatch: Skip task_call_func() for current task
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <4b92e793462d532a05f03767151fa29db3e68e13.1677257135.git.jpoimboe@kernel.org>
References: <4b92e793462d532a05f03767151fa29db3e68e13.1677257135.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167952533112.5837.7165959544411828393.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     383439d3d400d4c5a7ffb4495124adc6be6a05e2
Gitweb:        https://git.kernel.org/tip/383439d3d400d4c5a7ffb4495124adc6be6a05e2
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 24 Feb 2023 08:49:59 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Mar 2023 17:09:28 +01:00

livepatch: Skip task_call_func() for current task

The current task doesn't need the scheduler's protection to unwind its
own stack.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
Link: https://lore.kernel.org/r/4b92e793462d532a05f03767151fa29db3e68e13.1677257135.git.jpoimboe@kernel.org
---
 kernel/livepatch/transition.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 135fc73..824e2e3 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -312,7 +312,11 @@ static bool klp_try_switch_task(struct task_struct *task)
 	 * functions.  If all goes well, switch the task to the target patch
 	 * state.
 	 */
-	ret = task_call_func(task, klp_check_and_switch_task, &old_name);
+	if (task == current)
+		ret = klp_check_and_switch_task(current, &old_name);
+	else
+		ret = task_call_func(task, klp_check_and_switch_task, &old_name);
+
 	switch (ret) {
 	case 0:		/* success */
 		break;
