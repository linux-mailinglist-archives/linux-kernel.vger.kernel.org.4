Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AAE734859
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjFRUuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 16:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjFRUuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:50:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63699E4D;
        Sun, 18 Jun 2023 13:50:02 -0700 (PDT)
Date:   Sun, 18 Jun 2023 20:50:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687121401;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FzRLgurewIvME1cnbVroMx6K+hOOPXTWA8wqVTWt6Dc=;
        b=luLJoCARG/X4N7bDiyo26cH2fnTZF4fYvVNhJsfiBJSsMm8eUqcQcDFy8XGDhYKLMNGddX
        fHplmh4FLqG0TCdp/5tClyjjh23KhvRi6PbGJHINcWWteZ8bOX2fmIzs9Yx+zaNrbIq0AC
        OfpuMzFe2VI5OEt1CXOg1LzXLxl31JAwDdqxKtQJv9hsfcoDaZDpTYAF+ZmN0fcBl7R17R
        4JRYDWZOwUyw4XcvCWz4w2Wh0nCq7s4jcx1pqbVEVsVJhSaaCKDx2QNqVuQI8S3ovBWNGT
        0v91BDpVEo5HWJ9fi5QM7fx0pD7vP2ThZT8f1TqRpiMucWPahSbhzGnMQjaKnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687121401;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FzRLgurewIvME1cnbVroMx6K+hOOPXTWA8wqVTWt6Dc=;
        b=lD10eJ0elR+QHCs9Wmu5D2ToV18cE+r70yUSPRESNDYac2593+3maHSjoceg1rlHN8oZ+H
        f4+xeuaIwMUUr+CA==
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
Message-ID: <168712140048.404.10922527392953092181.tip-bot2@tip-bot2>
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

Commit-ID:     3561fcb402b7ab7fdb4c1746dae4995889506605
Gitweb:        https://git.kernel.org/tip/3561fcb402b7ab7fdb4c1746dae4995889506605
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:16 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 18 Jun 2023 22:41:51 +02:00

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
index 191ecf5..03ef6af 100644
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
 
