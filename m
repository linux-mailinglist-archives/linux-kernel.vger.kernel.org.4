Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6511C6EB7E1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 09:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjDVHn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 03:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDVHn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 03:43:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACC419BD;
        Sat, 22 Apr 2023 00:43:25 -0700 (PDT)
Date:   Sat, 22 Apr 2023 07:43:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682149403;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X9vMKu/RlNQ7C/4jlltWW/zd/41Ilk8l/QMNavq8fmY=;
        b=Q1CBR2tPwFJBi8heCUlh1cmDDTJlrKmd8OFeuZjrtT0/9VcH6xY+AjVuio7tzjnpSKQ+SZ
        AmBKBGxKR6Iv7iU3jqYHisQn4lRgSqn3d0gycPM9HL0/zKTpSAP5WiDBWvnOdrbI3knvZv
        FV7QGbqFgeY3MEkZ2p98Glq3iJG7UoJK5D6PbWhi0ebNOZAxWngg8TAH5g+RbBdc+hPBCr
        5XEMe6pZRR/IM2dAmWeKcxPedFB6VJPI4yXaX3T+X8Scg5sAusj1tvkI2VmmkzSEJjuv8x
        SsyGCh7yNaM7XipNzwQpqGRl1jcpA7nbjo5ADnEuO5TpwLTPp7rTkkp2dwoeDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682149403;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X9vMKu/RlNQ7C/4jlltWW/zd/41Ilk8l/QMNavq8fmY=;
        b=ie2R8dax70DE6fdOwVFQDA3IbvnN2z9p7TABtCHGrykFyBjm3k012CWOBbGrKCc7x8FU0d
        JE9XbuhWRlYQksCg==
From:   "tip-bot2 for Aaron Thompson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/clock: Fix local_clock() before sched_clock_init()
Cc:     Aaron Thompson <dev@aaront.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230413175012.2201-1-dev@aaront.org>
References: <20230413175012.2201-1-dev@aaront.org>
MIME-Version: 1.0
Message-ID: <168214940282.404.16454263292921385535.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f31dcb152a3d0816e2f1deab4e64572336da197d
Gitweb:        https://git.kernel.org/tip/f31dcb152a3d0816e2f1deab4e64572336da197d
Author:        Aaron Thompson <dev@aaront.org>
AuthorDate:    Thu, 13 Apr 2023 17:50:12 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Apr 2023 13:24:21 +02:00

sched/clock: Fix local_clock() before sched_clock_init()

Have local_clock() return sched_clock() if sched_clock_init() has not
yet run. sched_clock_cpu() has this check but it was not included in the
new noinstr implementation of local_clock().

The effect can be seen on x86 with CONFIG_PRINTK_TIME enabled, for
instance. scd->clock quickly reaches the value of TICK_NSEC and that
value is returned until sched_clock_init() runs.

dmesg without this patch:

    [    0.000000] kvm-clock: ...
    [    0.000002] kvm-clock: ...
    [    0.000672] clocksource: ...
    [    0.001000] tsc: ...
    [    0.001000] e820: ...
    [    0.001000] e820: ...
     ...
    [    0.001000] ..TIMER: ...
    [    0.001000] clocksource: ...
    [    0.378956] Calibrating delay loop ...
    [    0.379955] pid_max: ...

dmesg with this patch:

    [    0.000000] kvm-clock: ...
    [    0.000001] kvm-clock: ...
    [    0.000675] clocksource: ...
    [    0.002685] tsc: ...
    [    0.003331] e820: ...
    [    0.004190] e820: ...
     ...
    [    0.421939] ..TIMER: ...
    [    0.422842] clocksource: ...
    [    0.424582] Calibrating delay loop ...
    [    0.425580] pid_max: ...

Fixes: 776f22913b8e ("sched/clock: Make local_clock() noinstr")
Signed-off-by: Aaron Thompson <dev@aaront.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230413175012.2201-1-dev@aaront.org
---
 kernel/sched/clock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 5732fa7..b5cc2b5 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -300,6 +300,9 @@ noinstr u64 local_clock(void)
 	if (static_branch_likely(&__sched_clock_stable))
 		return sched_clock() + __sched_clock_offset;
 
+	if (!static_branch_likely(&sched_clock_running))
+		return sched_clock();
+
 	preempt_disable_notrace();
 	clock = sched_clock_local(this_scd());
 	preempt_enable_notrace();
