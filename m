Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21996EE7C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbjDYSuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbjDYStu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:49:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20E918E9F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:49:22 -0700 (PDT)
Message-ID: <20230425183313.672220780@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682448561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=VWLz1MHVpVYMioS5C8vBOILIM1xk3aX0J2F+OIQgCbk=;
        b=RkziKtFNP6RD3SMThBazEymOBQa1asoO3FGPWvQXyePX4hPHDwTTG0OsZakCseLfrdOGpf
        knBG9G61pQpdhUxy6bRYWoc+8ZCapWekwoEibeUZ/+2Fgn+pfc+JrUR6xE8PBJWUr6gklR
        zLmQadGDWfeDynZ7GpwbfPWl1ey6prcc5tU4uMjNgB2YGjos+sNk46Au/VOBFaxTZL/n6S
        AkTms53m1A31Q2eVO8Ro+QMukiWq3m6NG9k4P4MPF520JjC69T10wFDfn0rYJklRyLiudz
        3T0tXaUU3dkW+PeS9Xk7WmQ4ypMnTM17er6H+866LbmgA3uyNdd16IA/Xjqbaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682448561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=VWLz1MHVpVYMioS5C8vBOILIM1xk3aX0J2F+OIQgCbk=;
        b=ICJQ1M4SOgah23Bo8sPdJ6fWjrxsMOpnV7OwmUhaV84xZOmtcdEc8+NPS21qO+QEVcmxpD
        QNLOjyfNBaB8SICw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [patch 16/20] posix-timers: Comment SIGEV_THREAD_ID properly
References: <20230425181827.219128101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 25 Apr 2023 20:49:20 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the word salad.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -53,12 +53,9 @@ static const struct k_clock * const posi
 static const struct k_clock *clockid_to_kclock(const clockid_t id);
 static const struct k_clock clock_realtime, clock_monotonic;
 
-/*
- * we assume that the new SIGEV_THREAD_ID shares no bits with the other
- * SIGEV values.  Here we put out an error if this assumption fails.
- */
+/* SIGEV_THREAD_ID cannot share a bit with the other SIGEV values. */
 #if SIGEV_THREAD_ID != (SIGEV_THREAD_ID & \
-                       ~(SIGEV_SIGNAL | SIGEV_NONE | SIGEV_THREAD))
+			~(SIGEV_SIGNAL | SIGEV_NONE | SIGEV_THREAD))
 #error "SIGEV_THREAD_ID must not share bit with other SIGEV values!"
 #endif
 

