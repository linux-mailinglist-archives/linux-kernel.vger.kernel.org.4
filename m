Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B007A6CBE31
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjC1Lz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjC1Lzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:55:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98C68A41
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:55:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68D8A60B24
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 11:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985ABC433D2;
        Tue, 28 Mar 2023 11:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680004549;
        bh=o1gbd6Q5+PuxNMWGpMNsW7Voev+NdraTBgWWGtpU/jo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I1coS1fgw8eKHOf0GZTTiaC3squr9cE6N4AbGLMRghil2Ld13FSlWwegdInImTIMC
         0oOObmG4zAPt1e+UMXYEYdho1rC+4xKcKyiw+pzc+AQ5N7siDyyiii8y/Duul23JIb
         j3n6YUzqW/PnZMgParnLG88VMWEC1KR82J1STm2Xd4oonlbXWANR7Od6O4ftr9ai35
         XLfufyKDUMQTRJQFNvEB8JA4a7hesFjyz+NSvOZKHj+CzTCG54bgROx0Oesi6Pd6Di
         OwJdEVnrQ1wTZVxFKGpRpfLoKDAVON1lx8H4YEcM5Gog73mA7lC0rwQQdP2bzNs3UH
         NmbaMXG/Ag2qg==
Date:   Tue, 28 Mar 2023 12:55:43 +0100
From:   Will Deacon <will@kernel.org>
To:     Jiucheng Xu <jiuchengxu@163.com>
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
Message-ID: <20230328115543.GA1159@willie-the-truck>
References: <20230209115403.521868-1-jiucheng.xu@amlogic.com>
 <20230209115403.521868-2-jiucheng.xu@amlogic.com>
 <20230327141054.GC31752@willie-the-truck>
 <79968005-28f3-d890-dfea-faca2e7d7947@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79968005-28f3-d890-dfea-faca2e7d7947@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:29:04AM +0800, Jiucheng Xu wrote:
> 
> My Amlogic email box has some issues. Use my personal email
> <jiucheng.xu@163.com> to reply.
> 
> On 2023/3/27 22:10, Will Deacon wrote:
> > [ EXTERNAL EMAIL ]
> > 
> > On Thu, Feb 09, 2023 at 07:54:02PM +0800, Jiucheng Xu wrote:
> > > When use 1ms interval, very large number of counter happens
> > > once in a while as below:
> > > 
> > > 25.968654513 281474976710655.84 MB meson_ddr_bw/chan_1_rw_bytes,arm=1/
> > > 26.118657346 281474976710655.88 MB meson_ddr_bw/chan_1_rw_bytes,arm=1/
> > > 26.180137180 281474976710655.66 MB meson_ddr_bw/chan_1_rw_bytes,arm=1/
> > > 
> > > Root cause is the race between irq handler
> > > and pmu.read callback. Use spin lock to protect the sw&hw
> > > counters.
> > > 
> > > Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> > > ---
> > >   drivers/perf/amlogic/meson_ddr_pmu_core.c | 10 +++++++++-
> > >   1 file changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/perf/amlogic/meson_ddr_pmu_core.c b/drivers/perf/amlogic/meson_ddr_pmu_core.c
> > > index 0b24dee1ed3c..9b2e5d5c0626 100644
> > > --- a/drivers/perf/amlogic/meson_ddr_pmu_core.c
> > > +++ b/drivers/perf/amlogic/meson_ddr_pmu_core.c
> > > @@ -14,6 +14,7 @@
> > >   #include <linux/perf_event.h>
> > >   #include <linux/platform_device.h>
> > >   #include <linux/printk.h>
> > > +#include <linux/spinlock.h>
> > >   #include <linux/sysfs.h>
> > >   #include <linux/types.h>
> > > @@ -23,6 +24,7 @@ struct ddr_pmu {
> > >   	struct pmu pmu;
> > >   	struct dmc_info info;
> > >   	struct dmc_counter counters;	/* save counters from hw */
> > > +	spinlock_t lock;		/* protect hw/sw counter */
> > >   	bool pmu_enabled;
> > >   	struct device *dev;
> > >   	char *name;
> > > @@ -92,10 +94,12 @@ static void meson_ddr_perf_event_update(struct perf_event *event)
> > >   	int idx;
> > >   	int chann_nr = pmu->info.hw_info->chann_nr;
> > > +	spin_lock(&pmu->lock);
> > Why doesn't this need the _irqsave() variant if we're racing with the irq
> > handler?
> > 
> > Will
> I think meson_ddr_perf_event_update function is called with hard irq off.
> So update function couldn't be interrupted by irq handler. Right?

I'm just confused about the race, then. The commit message says you have a
race between an irq handler and a callback, which you fix with a spinlock
that isn't irq safe. So either the race is real and the lock needs to be
irqsafe, or the race is something else entirely, no?

Will
