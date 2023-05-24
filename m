Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACA570EEF4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239854AbjEXHHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239766AbjEXHG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:06:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BFD93
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:06:58 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684912016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ypjjo6K+ZjX/gE7dPsSFsIuC37ELchmIlQCCnVAGgp8=;
        b=TksK2xEVUsi1ZjbS5dg7wQVa7/RDG+ido0cCXWrd2wuzAE0GTXbAlFQ+fQSZdj4OgbOQqr
        YGaLWyBc2shTu4ofKXUcN5suBde5xSKwu3yfiX2TeUlgShn7UQ0FeuhzSqNxFoLWo3aVXi
        iMdEGWrTukCb4PiYbk7fXQk4lBSrHd7wXaPk2mbr0Q1NtbfE+4QYnPw539X0N1urWkaqEn
        MIpgF5iwQPE0ID0dnJz2dHSMfH6qcSK8Oe6CWfrDXw7/ZJ8aPcRw/yvcFxBuqHHqVO7LIM
        oZCUQ9Zwrac11S+D2SFEIKD5M17OtDHCksvaVjc/8oGCbCSEDdXS/6aUT4GcoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684912016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ypjjo6K+ZjX/gE7dPsSFsIuC37ELchmIlQCCnVAGgp8=;
        b=sULkadB9nFvaj+x9zAbIGMko8DCx3pDokGMDNJLPFtj8hXCBWb7L7Ou7x6L/j5Jdjv7JCU
        +/Z2ukjhNtAJ+PAw==
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
Subject: [PATCH v7 03/21] timer: Add comment to get_next_timer_interrupt() description
Date:   Wed, 24 May 2023 09:06:11 +0200
Message-Id: <20230524070629.6377-4-anna-maria@linutronix.de>
In-Reply-To: <20230524070629.6377-1-anna-maria@linutronix.de>
References: <20230524070629.6377-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

