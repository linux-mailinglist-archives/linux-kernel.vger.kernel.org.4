Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20A474DA20
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjGJPoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjGJPoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:44:07 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD4AB1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:44:06 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666fb8b1bc8so4101745b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689003846; x=1691595846;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZcN5ySR/eMy3kuS7RhYT5swW3n3ayceXHRnIkc5HWU=;
        b=Gd2w51tljEjQOuB6d5PrJgUz/69dNvKX0DPeoL03WnuOg/KMtWJEdA/+4M6ietY9bJ
         6QPwlL2lWN0DHj8uyBlTLEbkouZ6SZTqJdIb7wS7GTsopTS7yA9kWOFsdwSVpX+tZLy5
         fabk7ZR1D4B70HRoTCjJOFR3Ije8EqSHcWRLnbDNiZ1uZfgA/xSFl3jMbWiQhP8Kjmhk
         p+kJC+8+7bxdPLW4I9Mv55oYCeRXxUM+CeVRW4eseFyV2QLQLNDgGZS1lkQsARNF6ihL
         oHrrdg4uJCmJEvJwN/1ZZNCREYJ4bd/XQr1LEzyfvPJMrE+pDBaag3SvMbvp8jYLUblC
         FLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689003846; x=1691595846;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZcN5ySR/eMy3kuS7RhYT5swW3n3ayceXHRnIkc5HWU=;
        b=WwBimj0r02ZrtWAS9p2cVfxRpIlDDb8GSzr+kWz9tUx2gMzr+AF8J2mIpYRBXKGEaz
         DnORwq7NZ9H3RLSsZeMlsF3HZSeJxxDd20L4VTF8ZoIdnA/qdaSLY4Qsayi0YpNAyyEK
         4iUjwovVKcxhTznvXcKZSnYwXDgsJ8quNe7UVMf2iX/VSQF53UGm+65ZmeCbztaOVNIy
         AzqmT05u+1Q/U21meial6LwJpS3Uqh8dSs4RGRHDRifqhhLZZPxRhI2GoRlpQP782fEO
         e1NC64QfRqbHxtxB3KzQc0LhN5i86RQUCgtbMXE3gJnvf22nf2IcZqqvxYkrOyR7RQFs
         fJ3w==
X-Gm-Message-State: ABy/qLYmrXNn76vb6lBVz3mhIqOVE2bSimlT60ooPTYCChYGxT5qjE3e
        u5+jekle/w+M+E/il44x1s2nUA==
X-Google-Smtp-Source: APBJJlFZwJnO/biLfmq6YgkXCbMIGHF8Z8cEiLAbNa+NKpEuOSq9PvXApF1d9oUbGKHWLRdyUlnsWw==
X-Received: by 2002:a17:902:a415:b0:1b7:ecbb:aa06 with SMTP id p21-20020a170902a41500b001b7ecbbaa06mr12924248plq.55.1689003846234;
        Mon, 10 Jul 2023 08:44:06 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902724300b001b1c3542f57sm52701pll.103.2023.07.10.08.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 08:44:05 -0700 (PDT)
From:   Eric Lin <eric.lin@sifive.com>
To:     atishp@atishpatra.org, anup@brainfault.org, will@kernel.org,
        mark.rutland@arm.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     greentime.hu@sifive.com, vincent.chen@sifive.com,
        Eric Lin <eric.lin@sifive.com>
Subject: [PATCH] perf: RISC-V: Remove PERF_HES_STOPPED flag checking in riscv_pmu_start()
Date:   Mon, 10 Jul 2023 15:43:28 +0000
Message-Id: <20230710154328.19574-1-eric.lin@sifive.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 096b52fd2bb4 ("perf: RISC-V: throttle perf events") the
perf_sample_event_took() function was added to report time spent in
overflow interrupts. If the interrupt takes too long, the perf framework
will lower the sysctl_perf_event_sample_rate and max_samples_per_tick.
When hwc->interrupts is larger than max_samples_per_tick, the
hwc->interrupts will be set to MAX_INTERRUPTS, and events will be
throttled within the __perf_event_account_interrupt() function.

However, the RISC-V PMU driver doesn't call riscv_pmu_stop() to update the
PERF_HES_STOPPED flag after perf_event_overflow() in pmu_sbi_ovf_handler()
function to avoid throttling. When the perf framework unthrottled the event
in the timer interrupt handler, it triggers riscv_pmu_start() function
and causes a WARN_ON_ONCE() warning, as shown below:

 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 240 at drivers/perf/riscv_pmu.c:184 riscv_pmu_start+0x7c/0x8e
 Modules linked in:
 CPU: 0 PID: 240 Comm: ls Not tainted 6.4-rc4-g19d0788e9ef2 #1
 Hardware name: SiFive (DT)
 epc : riscv_pmu_start+0x7c/0x8e
  ra : riscv_pmu_start+0x28/0x8e
 epc : ffffffff80aef864 ra : ffffffff80aef810 sp : ffff8f80004db6f0
  gp : ffffffff81c83750 tp : ffffaf80069f9bc0 t0 : ffff8f80004db6c0
  t1 : 0000000000000000 t2 : 000000000000001f s0 : ffff8f80004db720
  s1 : ffffaf8008ca1068 a0 : 0000ffffffffffff a1 : 0000000000000000
  a2 : 0000000000000001 a3 : 0000000000000870 a4 : 0000000000000000
  a5 : 0000000000000000 a6 : 0000000000000840 a7 : 0000000000000030
  s2 : 0000000000000000 s3 : ffffaf8005165800 s4 : ffffaf800424da00
  s5 : ffffffffffffffff s6 : ffffffff81cc7590 s7 : 0000000000000000
  s8 : 0000000000000006 s9 : 0000000000000001 s10: ffffaf807efbc340
  s11: ffffaf807efbbf00 t3 : ffffaf8006a16028 t4 : 00000000dbfbb796
  t5 : 0000000700000000 t6 : ffffaf8005269870
 status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
 [<ffffffff80aef864>] riscv_pmu_start+0x7c/0x8e
 [<ffffffff80185b56>] perf_adjust_freq_unthr_context+0x15e/0x174
 [<ffffffff80188642>] perf_event_task_tick+0x88/0x9c
 [<ffffffff800626a8>] scheduler_tick+0xfe/0x27c
 [<ffffffff800b5640>] update_process_times+0x9a/0xba
 [<ffffffff800c5bd4>] tick_sched_handle+0x32/0x66
 [<ffffffff800c5e0c>] tick_sched_timer+0x64/0xb0
 [<ffffffff800b5e50>] __hrtimer_run_queues+0x156/0x2f4
 [<ffffffff800b6bdc>] hrtimer_interrupt+0xe2/0x1fe
 [<ffffffff80acc9e8>] riscv_timer_interrupt+0x38/0x42
 [<ffffffff80090a16>] handle_percpu_devid_irq+0x90/0x1d2
 [<ffffffff8008a9f4>] generic_handle_domain_irq+0x28/0x36

After referring other PMU drivers like Arm, Loongarch, Csky, and Mips,
they don't call *_pmu_stop() to update with PERF_HES_STOPPED flag
after perf_event_overflow() function nor do they add PERF_HES_STOPPED
flag checking in *_pmu_start() which don't cause this warning.

Thus, it's recommended to remove this unnecessary check in
riscv_pmu_start() function to prevent this warning.

Signed-off-by: Eric Lin <eric.lin@sifive.com>
---
 drivers/perf/riscv_pmu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index ebca5eab9c9b..56897d4d4fd3 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -181,9 +181,6 @@ void riscv_pmu_start(struct perf_event *event, int flags)
 	uint64_t max_period = riscv_pmu_ctr_get_width_mask(event);
 	u64 init_val;
 
-	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
-		return;
-
 	if (flags & PERF_EF_RELOAD)
 		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
 
-- 
2.17.1

