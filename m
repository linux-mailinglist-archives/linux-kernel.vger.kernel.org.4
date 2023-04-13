Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CED6E13C9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjDMR4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDMR4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:56:32 -0400
X-Greylist: delayed 349 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Apr 2023 10:56:30 PDT
Received: from smtp-out1.aaront.org (smtp-out1.aaront.org [52.0.59.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C06113
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 10:56:30 -0700 (PDT)
Received: by smtp-out1.aaront.org (Postfix) with ESMTP id 4Py6Yq5dKpzTQ;
        Thu, 13 Apr 2023 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aaront.org; h=
    from:to:cc:subject:date:message-id:mime-version
    :content-transfer-encoding; s=qkjur4vrxk6kmqfk; bh=NASh0ELdjVlYA
    TWtGAhESwP0/qGYU3DPBNFRmdeYc2w=; b=bk+yB+y5g7aNNe+qVcdAAAAlBOrtE
    vYkhugGif5L11b2RlrpDktHU7rSCHqJdY3BTY2B1uaTxYGD77QkuQDtuJpcykS0k
    yUrL3DblVMRoxOPM2STXhponLNBelov46c/kBc8WbIS+HzWqDXGYxA5dc9Q2qAaK
    bIeao0IcchM4TCR+86gg91CgoVygkwidd3dR9DeZTeTIkeDENgyoDpucDEHFO8Jr
    5/iA+JNXRfz5hmw7FkKzLsXs0wL9PJinVqKgI59NbqM6AzdfG+jyYrJsDcMKf54W
    pf6r7faAqW3PZspgxK4mC51MTZzXpeWH1Agx6R85U4dqrb9Ang74md6mw==
From:   Aaron Thompson <dev@aaront.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Aaron Thompson <dev@aaront.org>
Subject: [RESEND PATCH] sched/clock: Fix local_clock() before sched_clock_init()
Date:   Thu, 13 Apr 2023 17:50:12 +0000
Message-Id: <20230413175012.2201-1-dev@aaront.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/sched/clock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 5732fa75ebab..b5cc2b53464d 100644
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
-- 
2.39.2

