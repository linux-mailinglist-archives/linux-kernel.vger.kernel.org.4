Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F12D62EBA0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 03:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbiKRCG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 21:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239454AbiKRCGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 21:06:24 -0500
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D359B7DEDC;
        Thu, 17 Nov 2022 18:06:22 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="84465563"
X-IronPort-AV: E=Sophos;i="5.96,172,1665414000"; 
   d="scan'208";a="84465563"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 18 Nov 2022 11:06:19 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id D6496E8522;
        Fri, 18 Nov 2022 11:06:18 +0900 (JST)
Received: from oym-om2.fujitsu.com (oym-om2.o.css.fujitsu.com [10.85.58.162])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 099A81426B;
        Fri, 18 Nov 2022 11:06:18 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om2.fujitsu.com (Postfix) with ESMTP id CCB6640421206;
        Fri, 18 Nov 2022 11:06:17 +0900 (JST)
From:   "Masahiko, Yamada" <yamada.masahiko@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] perf: fix reset interface potential failure
Date:   Fri, 18 Nov 2022 11:00:15 +0900
Message-Id: <20221118020016.1571100-1-yamada.masahiko@fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential bug where PERF_EVENT_IOC_RESET
does not work when accessing PMU registers directly
from userspace in the perf_event interface.

In the x86 environment, the kernel(perf_event reset handling) has a
potential failure, but it works with the papi library side workaround.
The PMU register direct access feature from user space was implemented in
the perf_event facility from linux-5.18 version in the arm64 environment,
but it does not work with the workaround on the papi library side in the
arm64 environment.
The workaround worked in the x86 environment and not in the arm64
environment because in the arm64 environment, only CPU_CYCLES was
a 64 bit counter and the rest were 32 bit counters, so the workaround
cleared the upper 32 bits of the value measured by CPU_CYCLES.

For this reason, we have created a patch on the kernel
that fixes a potential perf_event reset failure.

The motivation for the fix is to initialize pc->offset.
The perf_mmap__read_self function in tools/lib/perf/mmap.c is set by:.
cnt = READ_ONCE(pc->offset);
The pc->offset value is set in the following process
in the perf_event_update_userpage function:.
userpg->offset -= local64_read(&event->hw.prev_count);
hw->prev_count is set in the armpmu_event_set_period function
in drivers/perf/arm_pmu.c and in the x86_perf_event_set_period function
in arch/x86/events/core.c as follows:.
local64_set(&hwc->prev_count, (u64)-left);

Therefore, this patch was created to initialize hwc->prev_count
during reset processing.

We used
https://github.com/deater/perf_event_tests/blob/master/tests/rdpmc/\
rdpmc_reset.c for verification testing.

The mmap_read_ self function in
https://github.com/deater/perf_event_tests/blob/master/tests/rdpmc/\
rdpmc_lib.c comes with a fix (lines 158 to 159) similar to
the workaround in the papi library.

The mmap_read_self function implements the equivalent of
the perf_mmap__read_self function.

The following is a workaround for the mmap_read_self function.

-----SNIP-----
    158                 count<<=(64-width);
    159                 count>>=(64-width);
-----SNIP-----

If you do not apply the kernel patch to fix a potential perf_event
failure, removing the workaround from perf_event_tests will cause
both the x86/arm64 versions to fail.

$ ./rdpmc_reset
This test checks if userspace rdpmc() style reads work.

total start/read/stop latency: 71772447 cycles
 Event 0 -- Raw count: 100069445 enabled: 6636 running: 6636
 Event 0 -- Raw count: -281474876643918 enabled: 16399496 running: 16399496
 Event 1 -- Raw count: 100069412 enabled: 2071 running: 2071
 Event 1 -- Raw count: -281474876645181 enabled: 16394819 running: 16394819

 Expected: 100000000
 High: -281474876643918 Low: -281474876643918 Average: -281474876643918
 ( note, a small value above 100000000 may be expected due
   to overhead and interrupt noise, among other reasons)
 Average Error = -281474976.64%
Error out of range!
Testing if resetting while using rdpmc works...            FAILED

In the environment with the kernel patch to fix a potential perf_event
failure, removing the workaround from perf_event_tests still works with
the x86/arm64 version.

$ ./rdpmc_reset
This test checks if userspace rdpmc() style reads work.

total start/read/stop latency: 71863055 cycles
 Event 0 -- Raw count: 100081688 enabled: 10353 running: 10353
 Event 0 -- Raw count: 100078316 enabled: 16493263 running: 16493263
 Event 1 -- Raw count: 100081789 enabled: 4186 running: 4186
 Event 1 -- Raw count: 100076770 enabled: 16486696 running: 16486696

 Expected: 100000000
 High: 100078316   Low:  100078316   Average:  100078316
 ( note, a small value above 100000000 may be expected due
   to overhead and interrupt noise, among other reasons)
 Average Error = 0.08%
Testing if resetting while using rdpmc works...            PASSED

Masahiko, Yamada (1):
  perf: fix reset interface potential failure

 kernel/events/core.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.27.0

