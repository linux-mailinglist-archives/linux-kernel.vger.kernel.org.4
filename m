Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9F0722A67
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbjFEPIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbjFEPIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:08:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD030E8;
        Mon,  5 Jun 2023 08:08:29 -0700 (PDT)
Date:   Mon, 05 Jun 2023 15:08:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685977708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hXQRYqtlpQDTr+SKUec6AAcG5d95nzBgx1vMPLRNdJQ=;
        b=0C8QW2+/Zywgl/pf53SipFLPMiPLxVkfGL8QNfvhXgIkTRdGPqSWqrrkQ42g990+I89HSc
        UsEd3hzhf0gPXDsoZwRHYouiTTFtQLyZIQ+TEZuy3K+hk2EpykIa7I59cPQrRtS+/WxhBe
        wyzegNICBYNeYiGFZgos7mAxF3eTtqixUxSkDoakUk4EDI1cza7MEwl3Nch0kXC6OTi763
        og6l+AoWOvbw5uTWyw5exs7JEjKc7vLc9O/mW/j6rGaK3VpyixfS/xFKvsh2WMEhiOHcHW
        wQwwepYQMaaLwCToFnF6b0v+9Aa697YrCVov0I6maqCHBMwG2xAjTSeLsweLbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685977708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hXQRYqtlpQDTr+SKUec6AAcG5d95nzBgx1vMPLRNdJQ=;
        b=K3LMWL28exF4Rx49bkKmLK3BhaAHtMm0kQ8CE5gKXv7f6gSZ5/sPHSbBMjrBCBxKtlNCz/
        PEzE9SNHkXwYuTBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Document sys_clock_settime()
 permissions in place
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230425183313.514700292@linutronix.de>
References: <20230425183313.514700292@linutronix.de>
MIME-Version: 1.0
Message-ID: <168597770811.404.16869702165621785153.tip-bot2@tip-bot2>
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

Commit-ID:     6a0fc851449cdcad42f96e00854af4ac36a4b357
Gitweb:        https://git.kernel.org/tip/6a0fc851449cdcad42f96e00854af4ac36a4b357
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:16 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Jun 2023 17:03:38 +02:00

posix-timers: Document sys_clock_settime() permissions in place

The documentation of sys_clock_settime() permissions is at a random place
and mostly word salad.

Remove it and add a concise comment into sys_clock_settime().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183313.514700292@linutronix.de

---
 kernel/time/posix-timers.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 67c1d4d..9d99d4b 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -74,13 +74,6 @@ static const struct k_clock clock_realtime, clock_monotonic;
  *	    following: 1.) The k_itimer struct (sched.h) is used for
  *	    the timer.  2.) The list, it_lock, it_clock, it_id and
  *	    it_pid fields are not modified by timer code.
- *
- * Permissions: It is assumed that the clock_settime() function defined
- *	    for each clock will take care of permission checks.	 Some
- *	    clocks may be set able by any user (i.e. local process
- *	    clocks) others not.	 Currently the only set able clock we
- *	    have is CLOCK_REALTIME and its high res counter part, both of
- *	    which we beg off on and pass to do_sys_settimeofday().
  */
 static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags);
 
@@ -1159,6 +1152,10 @@ SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
 	if (get_timespec64(&new_tp, tp))
 		return -EFAULT;
 
+	/*
+	 * Permission checks have to be done inside the clock specific
+	 * setter callback.
+	 */
 	return kc->clock_set(which_clock, &new_tp);
 }
 
