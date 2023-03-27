Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BAB6CA6E7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjC0OLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjC0OLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:11:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCBF2110
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:11:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DAFBB80BEC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A91C433D2;
        Mon, 27 Mar 2023 14:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679926260;
        bh=RRlj8SX8e59FcNYzqGReCEP8Q5Z1eD9qPrgCjM6F8jE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QUzbAp7cDBPuYbKlJ2W5QBYwjuPWjoUmmnG1/051vFdTWbjCnP6CVydyHfVwT0cm0
         aaxcdLQ9tHvXIHg2hcRG1XErPhCTraTdDGVcmm+uOxwFLc8JhAGjMHYhLpAqVfXG/P
         cfAraquHUKLuxpewVvx+Qon3Fk0Dg2Bn77xcn/4vacjVN+WNeX4jUYRbzMTDIf/Pqt
         zLQPc0AJVjVPNJFQSCVdWhSx0DofQYr7YoPMJ+hloGTeYlK8ZLuOGKQYshCp1bhOAE
         LYYX7ef0I4SFb8TGC3qMdyYVQkOtM7+53F1RJJKug48XWOkMGkVBHSsXc2VEQgr6dq
         hbym7vuVQfCfw==
Date:   Mon, 27 Mar 2023 15:10:55 +0100
From:   Will Deacon <will@kernel.org>
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Chris Healy <cphealy@gmail.com>,
        Chris Healy <healych@amazon.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf/amlogic: Fix large number of counter issue
Message-ID: <20230327141054.GC31752@willie-the-truck>
References: <20230209115403.521868-1-jiucheng.xu@amlogic.com>
 <20230209115403.521868-2-jiucheng.xu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209115403.521868-2-jiucheng.xu@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 07:54:02PM +0800, Jiucheng Xu wrote:
> When use 1ms interval, very large number of counter happens
> once in a while as below:
> 
> 25.968654513 281474976710655.84 MB meson_ddr_bw/chan_1_rw_bytes,arm=1/
> 26.118657346 281474976710655.88 MB meson_ddr_bw/chan_1_rw_bytes,arm=1/
> 26.180137180 281474976710655.66 MB meson_ddr_bw/chan_1_rw_bytes,arm=1/
> 
> Root cause is the race between irq handler
> and pmu.read callback. Use spin lock to protect the sw&hw
> counters.
> 
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> ---
>  drivers/perf/amlogic/meson_ddr_pmu_core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/amlogic/meson_ddr_pmu_core.c b/drivers/perf/amlogic/meson_ddr_pmu_core.c
> index 0b24dee1ed3c..9b2e5d5c0626 100644
> --- a/drivers/perf/amlogic/meson_ddr_pmu_core.c
> +++ b/drivers/perf/amlogic/meson_ddr_pmu_core.c
> @@ -14,6 +14,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/platform_device.h>
>  #include <linux/printk.h>
> +#include <linux/spinlock.h>
>  #include <linux/sysfs.h>
>  #include <linux/types.h>
>  
> @@ -23,6 +24,7 @@ struct ddr_pmu {
>  	struct pmu pmu;
>  	struct dmc_info info;
>  	struct dmc_counter counters;	/* save counters from hw */
> +	spinlock_t lock;		/* protect hw/sw counter */
>  	bool pmu_enabled;
>  	struct device *dev;
>  	char *name;
> @@ -92,10 +94,12 @@ static void meson_ddr_perf_event_update(struct perf_event *event)
>  	int idx;
>  	int chann_nr = pmu->info.hw_info->chann_nr;
>  
> +	spin_lock(&pmu->lock);

Why doesn't this need the _irqsave() variant if we're racing with the irq
handler?

Will
