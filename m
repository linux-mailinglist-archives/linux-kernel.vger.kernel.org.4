Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6202E62ED17
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 06:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbiKRFNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 00:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbiKRFNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 00:13:20 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Nov 2022 21:13:19 PST
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9669A6BDDA;
        Thu, 17 Nov 2022 21:13:19 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="96382888"
X-IronPort-AV: E=Sophos;i="5.96,173,1665414000"; 
   d="scan'208";a="96382888"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP; 18 Nov 2022 14:12:14 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2EBE2E8521;
        Fri, 18 Nov 2022 14:12:12 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6E642DAD9D;
        Fri, 18 Nov 2022 14:12:11 +0900 (JST)
Received: from localhost.localdomain (unknown [10.124.154.64])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id 1F3474057108F;
        Fri, 18 Nov 2022 14:12:11 +0900 (JST)
From:   Itaru Kitayama <itaru.kitayama@fujitsu.com>
To:     yamada.masahiko@fujitsu.com
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org
Subject: [PATCH 1/1] perf: fix reset interface potential failure
Date:   Fri, 18 Nov 2022 14:11:56 +0900
Message-Id: <20221118051156.961494-1-itaru.kitayama@fujitsu.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221118020016.1571100-2-yamada.masahiko@fujitsu.com>
References: <20221118020016.1571100-2-yamada.masahiko@fujitsu.com>
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

On Fri, Nov 18, 2022 at 11:00:16AM +0900, Masahiko wrote:
> There is a potential bug where PERF_EVENT_IOC_RESET
> does not work when accessing PMU registers directly
> from userspace in the perf_event interface.
> we have created a patch on the kernel
> that fixes a potential perf_event reset failure.
> 
> The motivation is to initialize pc->offset.
> The perf_mmap__read_self function in tools/lib/perf/mmap.c is set by:.
> cnt = READ_ONCE(pc->offset);
> The pc->offset value is set in the following process
> in the perf_event_update_userpage function:.
> userpg->offset -= local64_read(&event->hw.prev_count);
> hw->prev_count is set in the armpmu_event_set_period function
> in drivers/perf/arm_pmu.c and in the x86_perf_event_set_period function
> in arch/x86/events/core.c as follows:.
> local64_set(&hwc->prev_count, (u64)-left);
> 
> Therefore, this patch was created to initialize hwc->prev_count
> during reset processing.
> 
> Signed-off-by: Masahiko, Yamada <yamada.masahiko@fujitsu.com>
> ---
>  kernel/events/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4ec3717003d5..296549755a9c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5468,8 +5468,13 @@ static __poll_t perf_poll(struct file *file, poll_table *wait)
>  
>  static void _perf_event_reset(struct perf_event *event)
>  {
> +	struct hw_perf_event *hwc = &event->hw;
> +	s64 left;
> +
>  	(void)perf_event_read(event, false);
>  	local64_set(&event->count, 0);
> +	left = local64_read(&hwc->period_left);
> +	local64_set(&hwc->prev_count, (u64)-left);
>  	perf_event_update_userpage(event);
>  }
>  
> -- 
> 2.27.0

Reviewed-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>

