Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9B7724661
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbjFFOic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbjFFOiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:38:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEB9198C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:44 -0700 (PDT)
Message-ID: <20230606142031.872478114@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rQhQI9gfYBa5P/AVMCL9wQCPxah+3H97GdCXzoiFlTY=;
        b=xj06h7G2AYuL8XA++I9UO3Tv1HthEl4dLE7oPU7JbFZ/+TZxwMAc8uTehkZNcyX/ZP4rer
        o1y5qyIdGw2Mu7QAHEEWRZ2lBuZZWBDOEuXPAnIwOVcgYNi801OeIE/mW5WpQmU1vFhAf/
        B+Xa9iasYCAVeffcCeSe+dzyLc4tRHmCFup6o5W6Bl8OHAD/F0cKE7m9SVXE8bvCwWKgOl
        zOII3BcKHF0ZP0frhI4/nZIRHH21D0ArWVsUAQbHTZHYzCihbcxJThjmTUsmFx05htv7U7
        cZo6rr+MrdUFepmjJMXA4nVC5KAPPzUitd0dpuAF2eozJdC8PXOPBC2iU3MQuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rQhQI9gfYBa5P/AVMCL9wQCPxah+3H97GdCXzoiFlTY=;
        b=H6NJu23pM67W+4Wwdro+qTF2fnserfMFQXQZIBAcn6l/+MFh0aGf5bjOGA8hsJVHoR2MQd
        gLnBPwseG2ePG/DA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [patch 15/45] posix-timers: Clear overrun in common_timer_set()
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:37:42 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keeping the overrun count of the previous setup around is just wrong. The
new setting has nothing to do with the previous one and has to start from a
clean slate.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -867,6 +867,7 @@ int common_timer_set(struct k_itimer *ti
 	timr->it_requeue_pending = (timr->it_requeue_pending + 2) &
 		~REQUEUE_PENDING;
 	timr->it_overrun_last = 0;
+	timr->it_overrun = -1LL;
 
 	/* Switch off the timer when it_value is zero */
 	if (!new_setting->it_value.tv_sec && !new_setting->it_value.tv_nsec)

