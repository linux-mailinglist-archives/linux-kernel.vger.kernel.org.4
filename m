Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9260D6EE7BC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbjDYStc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbjDYStM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:49:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B96117A12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:49:08 -0700 (PDT)
Message-ID: <20230425183313.196462644@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682448547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=DCSkADwrTdaHqprFhioGbr3aS4AKwjAJNkVmh+N50Zw=;
        b=VTZY1lnd2NAe21P++0IRfRXClWQh2YO96ayeMriJurbq5WD0fXi1OND56EjzdwXo+cu0//
        WRbBXLNioZN/7XNoQgU/61vTEVdgIZBd+fxY9Xd0iH/CUCn9+21keYHwMfz/Q3vFbVYGEk
        lK6Il3hdAZPbp8Y1ADQrYXY5m2IB2K8iXHQKvijp1nKsyLcU7cl/YULzlsNyU+EPYTUGRQ
        1OhDYHCgTGHaO7kQAPWQcjT9CyeRXDH/128ap7dS6yj99+35exBbwlBELtitP5r4igJx7a
        YMRGP8QgZr2d/HUifuzSk/mhcHGaL4qL5M9akO2yRM844LEP0KQl7BGvEqvcFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682448547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=DCSkADwrTdaHqprFhioGbr3aS4AKwjAJNkVmh+N50Zw=;
        b=xtbsT/23TQ81TQI3kADGd7xmm0ZozIe54Bf4xIbRKBneEoMlpD/TGc4UIlh/6a4/e0e5SG
        04I9wZdGsJVrkmDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [patch 07/20] posix-timers: Set k_itimer::it_signal to NULL on exit()
References: <20230425181827.219128101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 25 Apr 2023 20:49:06 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Technically it's not required to set k_itimer::it_signal to NULL on exit()
because there is no other thread anymore which could lookup the timer
concurrently.

Set it to NULL for consistency sake and add a comment to that effect.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1107,6 +1107,14 @@ static void itimer_delete(struct k_itime
 	}
 	list_del(&timer->list);
 
+	/*
+	 * Setting timer::it_signal to NULL is technically not required
+	 * here as nothing can access the timer anymore legitimately via
+	 * the hash table. Set it to NULL nevertheless so that all deletion
+	 * paths are consistent.
+	 */
+	WRITE_ONCE(timer->it_signal, NULL);
+
 	spin_unlock_irqrestore(&timer->it_lock, flags);
 	release_posix_timer(timer, IT_ID_SET);
 }

