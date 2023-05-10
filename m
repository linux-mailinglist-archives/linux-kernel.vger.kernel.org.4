Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050576FD828
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbjEJH3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbjEJH2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:28:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE07E7ABF
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:28:38 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683703717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ypjjo6K+ZjX/gE7dPsSFsIuC37ELchmIlQCCnVAGgp8=;
        b=AZgOvS8o2/I6ef73VDPLLedAE04KQCERCWRx57+Qq12U2DNtp3JBH68p28ucBoooUtyHkC
        0WIkq7ePGQ8ZeLGivNKdHV16tlQDtR1BAtWPCbfu3wbm9RmCiBSSsQM1swY62dVY5oU9L2
        4QlsV5oN3SD5Jg/c3ABY968azlsTv4dk9/u/eMrL/InOR6TeEnXUtxL9CUZYiBrcKBxqwR
        FaQFS0c04XD00SBcG5zIUf3wJ2UhTFVZKtL+smq02AKE2ISeh8b7d4weeQZ5pvtgpRM3Oz
        J63arhhI61zXxGlgf1tf6JmHc5IQUwjMxsJbhwMDcOVP9gDLAO9DWpoEfdRlMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683703717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ypjjo6K+ZjX/gE7dPsSFsIuC37ELchmIlQCCnVAGgp8=;
        b=UapTFIp4zMIufwrsE4Vj0V0MTB6rsOocC4NfL+/mCZMHsa52cVBZJ/vfYoSEqfvDfCIf2a
        7ZIXGQGM1kUlU+Dw==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v6 03/21] timer: Add comment to get_next_timer_interrupt() description
Date:   Wed, 10 May 2023 09:27:59 +0200
Message-Id: <20230510072817.116056-4-anna-maria@linutronix.de>
In-Reply-To: <20230510072817.116056-1-anna-maria@linutronix.de>
References: <20230510072817.116056-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_next_timer_interrupt() does more than simply getting the next timer
interrupt. The timer bases are forwarded and also marked as idle whenever
possible.

To get not confused, add a comment to function description.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v6: s/handling/marking

v5: New patch, which adds only a comment to get_next_timer_interrupt()
instead of changing the function name
---
 kernel/time/timer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 6e251e3cf659..0699fd14d00a 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1912,6 +1912,10 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
  * @basej:	base time jiffies
  * @basem:	base time clock monotonic
  *
+ * If required, base->clk is forwarded and base is also marked as
+ * idle. Idle marking of timer bases is allowed only to be done by CPU
+ * itself.
+ *
  * Returns the tick aligned clock monotonic time of the next pending
  * timer or KTIME_MAX if no timer is pending.
  */
-- 
2.30.2

