Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0634662EBA9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 03:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240871AbiKRCHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 21:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240499AbiKRCHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 21:07:50 -0500
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Nov 2022 18:07:36 PST
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0FD898F8;
        Thu, 17 Nov 2022 18:07:35 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="84612510"
X-IronPort-AV: E=Sophos;i="5.96,172,1665414000"; 
   d="scan'208";a="84612510"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 18 Nov 2022 11:06:28 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 4750ADE51A;
        Fri, 18 Nov 2022 11:06:27 +0900 (JST)
Received: from oym-om2.fujitsu.com (oym-om2.o.css.fujitsu.com [10.85.58.162])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 8D742CFF9D;
        Fri, 18 Nov 2022 11:06:26 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om2.fujitsu.com (Postfix) with ESMTP id 6789D40421239;
        Fri, 18 Nov 2022 11:06:26 +0900 (JST)
From:   "Masahiko, Yamada" <yamada.masahiko@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] perf: fix reset interface potential failure
Date:   Fri, 18 Nov 2022 11:00:16 +0900
Message-Id: <20221118020016.1571100-2-yamada.masahiko@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221118020016.1571100-1-yamada.masahiko@fujitsu.com>
References: <20221118020016.1571100-1-yamada.masahiko@fujitsu.com>
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
we have created a patch on the kernel
that fixes a potential perf_event reset failure.

The motivation is to initialize pc->offset.
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

Signed-off-by: Masahiko, Yamada <yamada.masahiko@fujitsu.com>
---
 kernel/events/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4ec3717003d5..296549755a9c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5468,8 +5468,13 @@ static __poll_t perf_poll(struct file *file, poll_table *wait)
 
 static void _perf_event_reset(struct perf_event *event)
 {
+	struct hw_perf_event *hwc = &event->hw;
+	s64 left;
+
 	(void)perf_event_read(event, false);
 	local64_set(&event->count, 0);
+	left = local64_read(&hwc->period_left);
+	local64_set(&hwc->prev_count, (u64)-left);
 	perf_event_update_userpage(event);
 }
 
-- 
2.27.0

