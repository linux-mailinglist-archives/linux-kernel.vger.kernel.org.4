Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5839A73485E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjFRUuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 16:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjFRUuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:50:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4BEE5A;
        Sun, 18 Jun 2023 13:50:06 -0700 (PDT)
Date:   Sun, 18 Jun 2023 20:50:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687121404;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+A7Bi/X2n8XHhjnVYrS8ebBzftUu/YIL7YEonpKXCY=;
        b=L1Uw9LA8kg+l3i0VbY1Psw+zipWiLXEZcUPuE0qvrCysLyPdjlk9ZFNNnXscICsZ1HcDKY
        ojfjKsdNFUjlZYRYvjSxBdWs+LRvBBXdp/kPX5baL7BJDFIdrkH7iYhyE4p7011YAfzqFA
        T3oPyioT2qATp2DgLB+ZFndO5xcx7/Scsvy9yMs0GGe3hhboywQSoVcLTJA4Aq7RnmO/Fl
        hKEVH0RWEsqPVzVelV4J54Ine20xtiGS+78W/1KkoS797Mgomdz3wVeFlB0cbOfOSoWz30
        SEohsn2NLm3LScj2DwPPJBQoSW0pvOCPxbTHwXXZlh+wLIkeDN8hAtAhQDsT1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687121404;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+A7Bi/X2n8XHhjnVYrS8ebBzftUu/YIL7YEonpKXCY=;
        b=mrPnrVPAqHepILe+NjTTk1iQKQzlRR0FKbytVtA2nSUQF2kSbTsOhrnf46tbgMDwtYEswe
        Vyjy/W8GenOyw+Cw==
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
Message-ID: <168712140425.404.12496348784303071442.tip-bot2@tip-bot2>
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

Commit-ID:     11fbe6cd41210c7b5173257158a22e11e225622d
Gitweb:        https://git.kernel.org/tip/11fbe6cd41210c7b5173257158a22e11e225622d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 18 Jun 2023 22:41:49 +02:00

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
index c1b77c5..ed7d260 100644
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
