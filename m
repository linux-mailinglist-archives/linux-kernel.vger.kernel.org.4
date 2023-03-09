Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C356B3035
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjCIWJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCIWJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:09:02 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1716F4B40
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 14:09:01 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id ff4so2477817qvb.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 14:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1678399741;
        h=mime-version:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OXNyR4ldCmmeOEB/szGPTm+ITsBHmfaV/WCZ2Vpd7cw=;
        b=bAMrz2llNFkXvlarv9jhJiKYOO+cU69QYOFihMNbNfO/3vGrlMcNYUcqlaqD5TKNgU
         vehhcmzUhB4YP8p6FJIcTu8fk1uLXzeH1NQNFJIQKemXmM6t6reFrU4AxldNbayA85kc
         g47dJunLFid6LQ1sgm9eiiT7ewk1wHLty4PIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678399741;
        h=mime-version:message-id:subject:cc:to:date:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OXNyR4ldCmmeOEB/szGPTm+ITsBHmfaV/WCZ2Vpd7cw=;
        b=J0H0gfjK6iZl3eeGUtl73SsSUahpRukApR0UnbGYfbNVr8PAkJSQcIPsM2+VKWFi8a
         SytcLNdIZQXf4eUJw1lq+CTjBPsNnZZ5U6NXEADkQc/rQ9gGzeNEIOI0viJUQ/tdxQGA
         p8VOtGIis3IBqw5UEb7QlvPRQ6qq9HgXP0UzQTXyfiscmvccOI2ZDlhcV0nZKT0dqwph
         H7WUL4TGsb+bUZ90XuugL2d/d5FplLPnhazcP4oZNhtJIOzH51uTuvXjzXHJKQ2GF/+i
         p4+HQu3+YaagwWzcAmI5RCIpHaom9f4EQERNvKDE8prBQmiJbg6y0CoFikAnpgccdLSE
         m+Vw==
X-Gm-Message-State: AO0yUKUfNKg2GTAsylDDRfFbN957F3YdRZjfq49k7TwH1r2hzE4VdXgE
        770ZHqMHFpnf2prlRqIQfRRwMtg26fGMxNtB9JA=
X-Google-Smtp-Source: AK7set//U+PyWSlasp1uLb7rQiH/rLxJJkj9e6xic09tbEW4OYLoJN/wzRCRWTcM/EbjVo7vwPdBgQ==
X-Received: by 2002:a05:6214:f0f:b0:56f:1b7e:d87f with SMTP id gw15-20020a0562140f0f00b0056f1b7ed87fmr43954528qvb.34.1678399740768;
        Thu, 09 Mar 2023 14:09:00 -0800 (PST)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id bs37-20020a05620a472500b007424376ca4bsm98277qkb.18.2023.03.09.14.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 14:09:00 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 9 Mar 2023 17:08:55 -0500 (EST)
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [perf] perf_fuzzer triggers KASAN BUG in x86_pmu_del
Message-ID: <41f6fea1-999a-0463-3dd6-cea750f51976@maine.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I hit this KASAN BUG running the perf_fuzzer on a haswell machine running
6.3.0-rc1

It is reproducible.

It looks like it's from the __set_bit line here in x86_pmu_del().  Let me 
know if there's more I can do to debug this.

Vince

	/*
         * If we're called during a txn, we only need to undo x86_pmu.add.
         * The events never got scheduled and ->cancel_txn will truncate
         * the event_list.
         *
         * XXX assumes any ->del() called during a TXN will only be on
         * an event added during that same TXN.
         */
        if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
                goto do_del;

        __set_bit(event->hw.idx, cpuc->dirty);


[ 5867.174432] ==================================================================
[ 5867.181684] BUG: KASAN: wild-memory-access in x86_pmu_del+0x92/0x2e0
[ 5867.188058] Write of size 8 at addr 1fff8880d09a1fa0 by task perf_fuzzer/3025
[ 5867.196720] CPU: 7 PID: 3025 Comm: perf_fuzzer Not tainted 6.3.0-rc1 #179
[ 5867.203521] Hardware name: LENOVO 10AM000AUS/SHARKBAY, BIOS FBKT72AUS 01/26/2014
[ 5867.210931] Call Trace:
[ 5867.213398]  <TASK>
[ 5867.215518]  dump_stack_lvl+0x57/0x90
[ 5867.219204]  kasan_report+0xbb/0xf0
[ 5867.222713]  ? perf_event_update_userpage+0x2a1/0x450
[ 5867.227788]  ? x86_pmu_del+0x92/0x2e0
[ 5867.231477]  kasan_check_range+0x13f/0x1a0
[ 5867.235594]  x86_pmu_del+0x92/0x2e0
[ 5867.239105]  ? lock_is_held_type+0xe3/0x140
[ 5867.243309]  event_sched_out+0x1c6/0x480
[ 5867.247261]  merge_sched_in+0x728/0x7b0
[ 5867.251128]  visit_groups_merge.constprop.0.isra.0+0x30e/0x970
[ 5867.256985]  ? __pfx_visit_groups_merge.constprop.0.isra.0+0x10/0x10
[ 5867.263366]  ? visit_groups_merge.constprop.0.isra.0+0x374/0x970
[ 5867.269399]  ctx_flexible_sched_in+0x11c/0x140
[ 5867.273865]  ? __pfx_ctx_flexible_sched_in+0x10/0x10
[ 5867.278849]  ? lock_is_held_type+0xe3/0x140
[ 5867.283053]  ctx_sched_in+0x1a5/0x3b0
[ 5867.286736]  ? __pfx_ctx_sched_in+0x10/0x10
[ 5867.290938]  ? ctx_sched_out+0x191/0x340
[ 5867.294885]  __perf_event_task_sched_in+0x258/0x400
[ 5867.299789]  ? __pfx___perf_event_task_sched_in+0x10/0x10
[ 5867.305208]  finish_task_switch.isra.0+0x3d4/0x570
[ 5867.310025]  schedule_tail+0xe/0x90
[ 5867.313535]  ret_from_fork+0x12/0x50
[ 5867.317135]  </TASK>
[ 5867.319347] ==================================================================
[ 5867.326586] Disabling lock debugging due to kernel taint

