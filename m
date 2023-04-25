Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9826EE7C6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjDYSub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbjDYStx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:49:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BECE17DE4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:49:25 -0700 (PDT)
Message-ID: <20230425183313.724863461@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682448563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=zhKy/+ejuXue7alxdJMuNxsTX5eKJNWbTH8CrXSTa84=;
        b=FzWcsXkY1rn6uaAzMResVDXYjyP3/75Gm3AlbAbLScxnrzNQbyeAyakrbAnFEXjoRxOiKR
        EQzIN5Dy516lyfpbSO5ze45rXikk7Wjz2CLM9gRRwjh0Di5+FHkq2vntYK+FYfvC445OCB
        lsKKzZUm5sRrIX3N/S0gnc8OfHc4WZZ0Cw+SkHUG6o2NPrkmIrSwMYqridkN0m95LXFsEm
        PvvieaC/KzoUhuSbMvngusxe8b6Uw7DfQ5uFS5di7HmLdrshUJ/lOGqJlMzLbfYgJepjSb
        ZgaKzxxQJq+hzuArqrdDG84kxZPSIR9RZNmdWdQHnwtf28TiFFfChAkof/2EBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682448563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=zhKy/+ejuXue7alxdJMuNxsTX5eKJNWbTH8CrXSTa84=;
        b=DmBsE9o+vRUolZwlSEo+qjOxgYPNJwct0Q5CIFDNXIRpYEMpHwuOHxnLLr6wupwhsjrc5m
        Sgid4XCkrlMWq/CQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [patch 17/20] posix-timers: Clarify posix_timer_rearm() comment
References: <20230425181827.219128101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 25 Apr 2023 20:49:22 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another incomprehensible piece of art.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -274,15 +274,9 @@ static void common_hrtimer_rearm(struct
 }
 
 /*
- * This function is exported for use by the signal deliver code.  It is
- * called just prior to the info block being released and passes that
- * block to us.  It's function is to update the overrun entry AND to
- * restart the timer.  It should only be called if the timer is to be
- * restarted (i.e. we have flagged this in the sys_private entry of the
- * info block).
- *
- * To protect against the timer going away while the interrupt is queued,
- * we require that the it_requeue_pending flag be set.
+ * This function is called from the signal delivery code if
+ * info->si_sys_private is not zero, which indicates that the timer has to
+ * be rearmed. Restart the timer and update info::si_overrun.
  */
 void posixtimer_rearm(struct kernel_siginfo *info)
 {

