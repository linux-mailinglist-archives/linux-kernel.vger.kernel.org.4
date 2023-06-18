Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78CD734838
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjFRUt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 16:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRUt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:49:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F19E49;
        Sun, 18 Jun 2023 13:49:55 -0700 (PDT)
Date:   Sun, 18 Jun 2023 20:49:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687121393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u/f+hWamHpjajhGjJmO7YTLvaGN9UYfbUAWU7sxj7+s=;
        b=rqF+RsLThFze7QvxH62il9CDBY5bIplY7mPWvtwTxa4NNRz8ECxPn17ZWL+9IKt4Ji5ag1
        LIp+3/+mn7XjyH8oj6WJ8vOp2lu/wX9e6PC2+G7E7F116i4WP//rcAv/C2bw+BDmFVF6w4
        +VUFNbKIRyx97jaMwd6gFsr2tf9S7x3nDj2uyPx9Hlib0096LdoFY8FUoAbIIjWjOKacPg
        FmYhB3V6aeHIvbsUAK45Own07yzosuAorggQKhBaz6RgWQcGZd+x20bZlFNA3x1l7muwUZ
        1ldyorLkCZ3Rp0az+TCbEP59oedAKx6XUBOfuZjFB1xad3rhM1MAvKa2qzYfpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687121393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u/f+hWamHpjajhGjJmO7YTLvaGN9UYfbUAWU7sxj7+s=;
        b=0MwQ43S4fk8tuYgho0bU9fkhvj0Z3Tuuu/tnohAKgP/Ohsxx1cLX4qBLxNvFdvkVifGooN
        6xGhvzlqtxZXtACQ==
From:   "tip-bot2 for Wen Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/rcu: Fix bogus ratelimit condition
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <tencent_5AAA3EEAB42095C9B7740BE62FBF9A67E007@qq.com>
References: <tencent_5AAA3EEAB42095C9B7740BE62FBF9A67E007@qq.com>
MIME-Version: 1.0
Message-ID: <168712139326.404.5365806373072450136.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a7e282c77785c7eabf98836431b1f029481085ad
Gitweb:        https://git.kernel.org/tip/a7e282c77785c7eabf98836431b1f029481085ad
Author:        Wen Yang <wenyang.linux@foxmail.com>
AuthorDate:    Fri, 05 May 2023 00:12:53 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 18 Jun 2023 22:41:53 +02:00

tick/rcu: Fix bogus ratelimit condition

The ratelimit logic in report_idle_softirq() is broken because the
exit condition is always true:

	static int ratelimit;

	if (ratelimit < 10)
		return false;  ---> always returns here

	ratelimit++;           ---> no chance to run

Make it check for >= 10 instead.

Fixes: 0345691b24c0 ("tick/rcu: Stop allowing RCU_SOFTIRQ in idle")
Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/tencent_5AAA3EEAB42095C9B7740BE62FBF9A67E007@qq.com

---
 kernel/time/tick-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 5225467..8905505 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1030,7 +1030,7 @@ static bool report_idle_softirq(void)
 			return false;
 	}
 
-	if (ratelimit < 10)
+	if (ratelimit >= 10)
 		return false;
 
 	/* On RT, softirqs handling may be waiting on some lock */
