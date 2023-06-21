Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94085737CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjFUH7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjFUH7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:59:33 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F249170D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:59:32 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qBskT-00C95P-IF; Wed, 21 Jun 2023 08:59:30 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qBskU-001eco-0U;
        Wed, 21 Jun 2023 08:59:30 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] hrtimer: fix sparse warnings on hrtimer locking
Date:   Wed, 21 Jun 2023 08:59:28 +0100
Message-Id: <20230621075928.394481-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __acquires() to the points the hertier spinlock is acquired and a
__releases() to when it gets released in unlock_hrtimer_base() as sparse
is warning about thses during lock imbalance checks.

Adding these removes the following sparse warnings:

kernel/time/hrtimer.c:175:33: warning: context imbalance in 'lock_hrtimer_base' - wrong count at exit
kernel/time/hrtimer.c:1301:28: warning: context imbalance in 'hrtimer_start_range_ns' - unexpected unlock
kernel/time/hrtimer.c:1336:28: warning: context imbalance in 'hrtimer_try_to_cancel' - unexpected unlock
kernel/time/hrtimer.c:1457:9: warning: context imbalance in '__hrtimer_get_remaining' - unexpected unlock

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 kernel/time/hrtimer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e8c08292defc..238262e4aba7 100644
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
-- 
2.39.2

