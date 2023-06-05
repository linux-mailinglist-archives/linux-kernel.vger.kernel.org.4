Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C77722A75
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjFEPJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbjFEPIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:08:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7B5F2;
        Mon,  5 Jun 2023 08:08:31 -0700 (PDT)
Date:   Mon, 05 Jun 2023 15:08:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685977710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1e6Yds5W7rP7fF0+wFeNJOpuoQxhcru5LRYemFpOo6U=;
        b=0gliyGVpuO8Df+2CTjcRQhQMFXG8wnUdDsTKC7O2HedbcXYSIQbnjVz/Ula5cVb301ynEl
        cgXBCeqCpZ0vzPlGYucyrG19/weJc1TlOeHfxigGl57kkmHD/HP9HMnEmBeZzEzU7VuJJX
        TtdEEBK8kDn2yvPrfu04NrzDegtNYTs5a8KYDp4lZ9lxUGV9EKd3mk8n7ptXSCnqfC5+O7
        2hK56ol9xtnRauuHHtMCVWlZjnh8gjUMGzi39pi0nBid2LU1firdxuH2684FTqnF0cdk6d
        aNDWhRLFsVfbm6POzB+AgGvvdsgkMvnGbeo/Vl06gJU8B8wK3+ejaPPSMhKT4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685977710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1e6Yds5W7rP7fF0+wFeNJOpuoQxhcru5LRYemFpOo6U=;
        b=n+C/23niQpWWx9cSIt48Mfu/f5e6AH6q+/JWv/Zt2jo1i6op3oVq5ygP9qrcyB1ABSKQE3
        90zaV2UvewzfkhAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Remove pointless irqsafe from hash_lock
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230425183313.249063953@linutronix.de>
References: <20230425183313.249063953@linutronix.de>
MIME-Version: 1.0
Message-ID: <168597770991.404.1945996479338799259.tip-bot2@tip-bot2>
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

Commit-ID:     032c960ac9f3d64487423e0e01a0fb7327509595
Gitweb:        https://git.kernel.org/tip/032c960ac9f3d64487423e0e01a0fb7327509595
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Jun 2023 17:03:37 +02:00

posix-timers: Remove pointless irqsafe from hash_lock

All usage of hash_lock is in thread context. No point in using
spin_lock_irqsave()/irqrestore() for a single usage site.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183313.249063953@linutronix.de

---
 kernel/time/posix-timers.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index e8d877f..d8d4cdf 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -471,10 +471,9 @@ static void k_itimer_rcu_free(struct rcu_head *head)
 static void release_posix_timer(struct k_itimer *tmr, int it_id_set)
 {
 	if (it_id_set) {
-		unsigned long flags;
-		spin_lock_irqsave(&hash_lock, flags);
+		spin_lock(&hash_lock, flags);
 		hlist_del_rcu(&tmr->t_hash);
-		spin_unlock_irqrestore(&hash_lock, flags);
+		spin_unlock(&hash_lock, flags);
 	}
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
