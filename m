Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16F565379C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 21:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiLUUgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 15:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLUUgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 15:36:17 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E546580;
        Wed, 21 Dec 2022 12:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671654975; x=1703190975;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pm+AJyr6vEiR2uv5BRun3YZb1cegwZ2UTBD3o38XlSE=;
  b=nw2kkJTBNL6A18AtWlG1kl7T9yojbp7MuXcAk0SbPAeaj5W1zFCn89qG
   nVa79gAlvmNzbr67OxLAquUElqL0+f5r+xPqt/v6id+jFmudE+gakcyu9
   M5MIO8lOe2nCL7Cdvfz6qlMmPF6svaHFsNhWIfiJWvWIqGMME/d1zFK9P
   a/L76nvxNZVQWariGw7F2KnI+EQoJ2BKoPPf5/s9myffGOOJIExGbHikd
   Xcag1FqpVHW3funrU64kZSnFYxebU+D0afuDuX6VUdmoAzEJWWW2x46l5
   4XrlZ9/5av9O3iTFg1FwKkTpRlXV7DeGCkKKqkG47up3Vt49QZwj7+VJz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="347103677"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="347103677"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 12:36:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="682158034"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="682158034"
Received: from lijieqi-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.64.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 12:36:14 -0800
Message-ID: <838cf73badd8e0c1126dbc64db3aed2f20cbfe9c.camel@linux.intel.com>
Subject: Re: [RFC][PATCH] thermal/idle_inject: Support 100% idle injection
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 21 Dec 2022 12:36:14 -0800
In-Reply-To: <5276e5b8-8596-2811-e03f-c4f3f0d3ab5b@linaro.org>
References: <20221209013640.943210-1-srinivas.pandruvada@linux.intel.com>
         <5276e5b8-8596-2811-e03f-c4f3f0d3ab5b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-12-21 at 14:43 +0100, Daniel Lezcano wrote:
> 
> Hi Srinivas,
> 
> 
> On 09/12/2022 02:36, Srinivas Pandruvada wrote:
> > The users of idle injection framework allow 100% idle injection.
> > For
> > example: thermal/cpuidle_cooling.c driver. When the ratio set to
> > 100%,
> > the runtime_duration becomes zero.
> > 
> > In the function idle_inject_set_duration() in idle injection
> > framework
> > run_duration_us == 0 is silently ignored, without any error (it is
> > a
> > void function). So, the caller will assume that everything is fine
> > and
> > 100% idle is effective. But in reality the idle inject will be
> > whatever
> > set before.
> 
> Good catch
> 
> > There are two options:
> > - The caller change their max state to 99% instead of 100% and
> > document that 100% is not supported by idle inject framework
> > - Support 100% idle support in idle inject framework
> 
> Yes, from my POV a CPU being impossible to cool down for any reason 
> should end up by staying off.
> 
> > Since there are other protections via RT throttling, this framework
> > can
> > allow 100% idle. The RT throttling will be activated at 95% idle by
> > default. The caller disabling RT throttling and injecting 100%
> > idle,
> > should be aware that CPU can't be used at all.
> 
> Would it make sense to write a trace in this case ?

There is one printk already:
printk_deferred_once("sched: RT throttling activated\n")

You mean we should add

trace_sched_* for this?

> 
> > The idle inject timer is started for (run_duration_us +
> > idle_duration_us)
> > duration. Hence replace (run_duration_us && idle_duration_us) with
> > (run_duration_us + idle_duration_us) in the function
> > idle_inject_set_duration().
> 
> Sounds good to me
> 
I will submit a patch for this.

Thanks,
Srinivas

> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> >   drivers/powercap/idle_inject.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/powercap/idle_inject.c
> > b/drivers/powercap/idle_inject.c
> > index f48e71501429..4a4fe60d2563 100644
> > --- a/drivers/powercap/idle_inject.c
> > +++ b/drivers/powercap/idle_inject.c
> > @@ -184,7 +184,7 @@ void idle_inject_set_duration(struct
> > idle_inject_device *ii_dev,
> >                               unsigned int run_duration_us,
> >                               unsigned int idle_duration_us)
> >   {
> > -       if (run_duration_us && idle_duration_us) {
> > +       if (run_duration_us + idle_duration_us) {
> >                 WRITE_ONCE(ii_dev->run_duration_us,
> > run_duration_us);
> >                 WRITE_ONCE(ii_dev->idle_duration_us,
> > idle_duration_us);
> >         }
> 

