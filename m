Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2486935C8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 04:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjBLDOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 22:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBLDN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 22:13:59 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AC315C8A;
        Sat, 11 Feb 2023 19:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676171638; x=1707707638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8Ee53bw0HTAKCWMxXPAJRBW6Y+YE/qZmXr9sA0iMSzM=;
  b=nTUw4M66NTXzklVY0e9u965pPREEaq4R/zwK1rf5gCpdWQMzG2HdsDCU
   6GezG+wPjra26EHS2ckJRzBmsUG01clclvPGt8k5QmSkjaTTl+ogZv5m5
   DOsvEPyT/9ACmmRVgCsBcyQxP6CZ3NpUnIlcg8TDy0iZrl8j1K0gTzMQ1
   ryLp9c6bk2ocaWRISpjwU9ObhJcP0nUubtHSqK+d9+Qe7PAO+Ui4BMZsD
   GS79gAnxVCskp1SjM3Axa+cMj8FZtL7m9fnuGAGHOIm6JcFVILidsI5/P
   aujrpTvVA2wk4coiRefhAliRGQlr8uLrzP8II74Oyt8kpH3VzZytWHMfv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="332824343"
X-IronPort-AV: E=Sophos;i="5.97,290,1669104000"; 
   d="scan'208";a="332824343"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2023 19:13:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="842406476"
X-IronPort-AV: E=Sophos;i="5.97,290,1669104000"; 
   d="scan'208";a="842406476"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 11 Feb 2023 19:13:56 -0800
Date:   Sat, 11 Feb 2023 19:23:45 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Haowen Bai <baihaowen@meizu.com>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        "open list:THERMAL DRIVER FOR AMLOGIC SOCS" 
        <linux-amlogic@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] thermal: Remove core header inclusion from drivers
Message-ID: <20230212032345.GA17062@ranerica-svr.sc.intel.com>
References: <20230206153432.1017282-1-daniel.lezcano@linaro.org>
 <20230211021023.GA13306@ranerica-svr.sc.intel.com>
 <9a121d43-b6d9-fe99-1e4c-498dac2e6b17@linaro.org>
 <258dedb542d4dcb73e9ec903d205ba64639c9f0a.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <258dedb542d4dcb73e9ec903d205ba64639c9f0a.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 08:32:48AM -0800, srinivas pandruvada wrote:
> On Sat, 2023-02-11 at 08:53 +0100, Daniel Lezcano wrote:
> > On 11/02/2023 03:10, Ricardo Neri wrote:
> > > On Mon, Feb 06, 2023 at 04:34:29PM +0100, Daniel Lezcano wrote:
> > > > As the name states "thermal_core.h" is the header file for the
> > > > core
> > > > components of the thermal framework.
> > > > 
> > > > Too many drivers are including it. Hopefully the recent cleanups
> > > > helped to self encapsulate the code a bit more and prevented the
> > > > drivers to need this header.
> > > > 
> > > > Remove this inclusion in every place where it is possible.
> > > > 
> > > > Some other drivers did a confusion with the core header and the
> > > > one
> > > > exported in linux/thermal.h. They include the former instead of
> > > > the
> > > > latter. The changes also fix this.
> > > > 
> > > > The tegra/soctherm driver still remains as it uses an internal
> > > > function which need to be replaced.
> > > > 
> > > > The Intel HFI driver uses the netlink internal framework core and
> > > > should be changed to prevent to deal with the internals.
> > > 
> > > I don't see any of the thermal netlink functionality exposed. Is
> > > there any work in progress?
> > 
> > commit bd30cdfd9bd73b68e4977ce7c5540aa7b14c25cd
> > Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > 
> >      thermal: intel: hfi: Notify user space for HFI events
> > 
> This is already exposed and we use it in user space.
> thermal_genl_cpu_capability_event() is called from intel_hfi driver to
> send the cpu capabilities.
> 
> Not sure what do you mean by  "don't see netlink functionality
> exposed"?
> 
> thermal_genl_cpu_caps struct and thermal_genl_cpu_capability_event()
> are defined in drivers/thermal/thermal_netlink.h.

Yes, I mean exactly this. The HFI code uses this functionality, but it is
declared in "../thermal_netlink.h". I just wondered if that is OK or also
needs to be declared somewhere in include/linux/

Thanks and BR,
Ricardo
