Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3366EE7C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbjDYSuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbjDYStq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:49:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45E817A26
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:49:19 -0700 (PDT)
Message-ID: <20230425183313.567072835@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682448558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=8NduAiJ2J+swWwUoiKJ97uYPpuB6SXNqBekstp0ggR4=;
        b=uniI75pnAS9TOvDGmGZVsKmTpGEdI0zkV8W39Bh9j4CS6jwK7SePZXC0PFEhjigIof0tKR
        hfUjXedgBzFvaYT/1oJge5OzjdmM1FTqMM56fPHeH64X2wTtR4RgmynD4DY8WQtey20Za7
        toQNRYI0cs7wosSn87CVNDBJaPbWb6J8MP1dtGYqj6nQN0tP8sxJYDNRk5k9UFrf305LUH
        gX1251nDmA9zYB9WrCDGvA9NIU/NIv/oF5ky1Wm4jh6okYMsgdhmhh0X2ZSvHgESiYIcjS
        37NjCmKupda66UurjPkqe8iOlzjq6oaa6zJFjTC+77VXXL3i+IZpnafbWgBxtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682448558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=8NduAiJ2J+swWwUoiKJ97uYPpuB6SXNqBekstp0ggR4=;
        b=tHHXQwEvpOzhjSgJCn9tEFVsh2raSSAt1VXbS50b9x8XaRNKQzbrJB5uamjTTG9WIy6dWh
        Nmr5sCpuU8+bHlCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [patch 14/20] posix-timers: Document nanosleep() details
References: <20230425181827.219128101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 25 Apr 2023 20:49:17 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The descriptions for common_nsleep() is wrong and common_nsleep_timens()
lacks any form of comment.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1376,7 +1376,7 @@ SYSCALL_DEFINE2(clock_getres_time32, clo
 #endif
 
 /*
- * nanosleep for monotonic and realtime clocks
+ * sys_clock_nanosleep() for CLOCK_REALTIME and CLOCK_TAI
  */
 static int common_nsleep(const clockid_t which_clock, int flags,
 			 const struct timespec64 *rqtp)
@@ -1388,8 +1388,13 @@ static int common_nsleep(const clockid_t
 				 which_clock);
 }
 
+/*
+ * sys_clock_nanosleep() for CLOCK_MONOTONIC and CLOCK_BOOTTIME
+ *
+ * Absolute nanosleeps for these clocks are time-namespace adjusted.
+ */
 static int common_nsleep_timens(const clockid_t which_clock, int flags,
-			 const struct timespec64 *rqtp)
+				const struct timespec64 *rqtp)
 {
 	ktime_t texp = timespec64_to_ktime(*rqtp);
 

