Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A0B739A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjFVIi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjFVIi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:38:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B71D1BD4;
        Thu, 22 Jun 2023 01:38:24 -0700 (PDT)
Date:   Thu, 22 Jun 2023 08:38:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687423101;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HXkUx2ZrteCgNj07PnMHGRTq+c/3p2glX386TX0nMhE=;
        b=ijA1pG6RhWz5+KlyVVDlNf8MHyJuw+yFdlBdljNpZrHucJIxmDBZsK/6mapXk6OllqU1xy
        p7B8famjJ0C6tTCZnEeUfrOPYsrUMHXx6mvOKZRh+k43e1F1TE25HTTwcyiutFbO9VaA7Y
        pgwES93MK+N67N2WYz8no3S5LJEInKmKVZtkStmzpxYa7+Jy9bq0sbPXzdKfhGIj1OLvl0
        8O7upgEIzkfmP6vs2vxrTts4EUJ9+GM7Pl4HwTV+l8LbRCuLJ8KVe+rOhMOZIZCLyatBUE
        yqQDQu9NmqgoPXCvekyusWq6e8ox9fdTxPreuEzeCtMQi9QLR6PT0z44mqIyTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687423101;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HXkUx2ZrteCgNj07PnMHGRTq+c/3p2glX386TX0nMhE=;
        b=u1LCnIzRoM02IH4N2x2w2sBCdCUUiHrrLhJT4Ej/kED4PR1TAyb5uZO41iYQp0kkt88JAi
        G71fv2Ey0+vuIEDg==
From:   "tip-bot2 for Ben Dooks" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Add missing sparse annotations to hrtimer locking
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230621075928.394481-1-ben.dooks@codethink.co.uk>
References: <20230621075928.394481-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Message-ID: <168742310100.404.5830952013545972340.tip-bot2@tip-bot2>
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

Commit-ID:     ccaa4926c2264ca2a2fcad4b3511fe435d7d4d15
Gitweb:        https://git.kernel.org/tip/ccaa4926c2264ca2a2fcad4b3511fe435d7d4d15
Author:        Ben Dooks <ben.dooks@codethink.co.uk>
AuthorDate:    Wed, 21 Jun 2023 08:59:28 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Jun 2023 10:32:37 +02:00

hrtimer: Add missing sparse annotations to hrtimer locking

Sparse warns about lock imbalance vs. the hrtimer_base lock due to missing
sparse annotations:

kernel/time/hrtimer.c:175:33: warning: context imbalance in 'lock_hrtimer_base' - wrong count at exit
kernel/time/hrtimer.c:1301:28: warning: context imbalance in 'hrtimer_start_range_ns' - unexpected unlock
kernel/time/hrtimer.c:1336:28: warning: context imbalance in 'hrtimer_try_to_cancel' - unexpected unlock
kernel/time/hrtimer.c:1457:9: warning: context imbalance in '__hrtimer_get_remaining' - unexpected unlock

Add the annotations to the relevant functions.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230621075928.394481-1-ben.dooks@codethink.co.uk

---
 kernel/time/hrtimer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e8c0829..238262e 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -164,6 +164,7 @@ static inline bool is_migration_base(struct hrtimer_clock_base *base)
 static
 struct hrtimer_clock_base *lock_hrtimer_base(const struct hrtimer *timer,
 					     unsigned long *flags)
+	__acquires(&timer->base->lock)
 {
 	struct hrtimer_clock_base *base;
 
@@ -280,6 +281,7 @@ static inline bool is_migration_base(struct hrtimer_clock_base *base)
 
 static inline struct hrtimer_clock_base *
 lock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
+	__acquires(&timer->base->cpu_base->lock)
 {
 	struct hrtimer_clock_base *base = timer->base;
 
@@ -1013,6 +1015,7 @@ void hrtimers_resume_local(void)
  */
 static inline
 void unlock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
+	__releases(&timer->base->cpu_base->lock)
 {
 	raw_spin_unlock_irqrestore(&timer->base->cpu_base->lock, *flags);
 }
