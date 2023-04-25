Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9886EE7BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbjDYSty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbjDYSt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:49:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC2717DEB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:49:16 -0700 (PDT)
Message-ID: <20230425183313.462051641@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682448555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Zmf4oijJ4qkmpNPO93IBkLhAnn4mWoGj5cJI22MX9Lg=;
        b=uqHMREOyx+/aWTaOduKAvl9umoYnudFh45Ah+mMG2jN6FF6M2YBU7Fe9k/lHJn0kRrqCjm
        iB5qiNoegoQAEp8Vaxaj4m6dsiCu1lJEEflHT1kKQ+rUqsWRm8aGq57w6f64CDnNgMkIuC
        hrCI08xetzruHArKygkP1BJE5/fC7aEVrfotrljAX0g2Hi3yzH7CBB46qIalJAKfYmapHw
        mA6ta4eMTmuwRNzWbUUjhcN4Znkc3eZCib1/I9Zok+N2qMAhaa9Vgofaxh7xu2mzSl1Z2Z
        1pXarTS4Lsz+NCuLF+OKosRyzCQtBavUFIA/bU0RT4L72u28rJj+sJVwu5QCqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682448555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Zmf4oijJ4qkmpNPO93IBkLhAnn4mWoGj5cJI22MX9Lg=;
        b=KG0gt4QfS2XTE0+++hT+G3wWq05Wv2hCSSmhElz37nqd1tnCsNKiXNvir6eLU5cbJkCr2u
        PJ2UBSKwxyEuCkBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [patch 12/20] posix-timers: Document sys_clock_getoverrun()
References: <20230425181827.219128101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 25 Apr 2023 20:49:14 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the syscall in detail and with coherent sentences.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
---
 kernel/time/posix-timers.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -782,14 +782,23 @@ SYSCALL_DEFINE2(timer_gettime32, timer_t
 
 #endif
 
-/*
- * Get the number of overruns of a POSIX.1b interval timer.  This is to
- * be the overrun of the timer last delivered.  At the same time we are
- * accumulating overruns on the next timer.  The overrun is frozen when
- * the signal is delivered, either at the notify time (if the info block
- * is not queued) or at the actual delivery time (as we are informed by
- * the call back to posixtimer_rearm().  So all we need to do is
- * to pick up the frozen overrun.
+/**
+ * sys_timer_getoverrun - Get the number of overruns of a POSIX.1b interval timer
+ * @timer_id:	The timer ID which identifies the timer
+ *
+ * The "overrun count" of a timer is one plus the number of expiration
+ * intervals which have elapsed between the first expiry, which queues the
+ * signal and the actual signal delivery. On signal delivery the "overrun
+ * count" is calculated and cached, so it can be returned directly here.
+ *
+ * As this is relative to the last queued signal the returned overrun count
+ * is meaningless outside of the signal delivery path and even there it
+ * does not accurately reflect the current state when user space evaluates
+ * it.
+ *
+ * Returns:
+ *	-EINVAL		@timer_id is invalid
+ *	1..INT_MAX	The number of overruns related to the last delivered signal
  */
 SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 {

