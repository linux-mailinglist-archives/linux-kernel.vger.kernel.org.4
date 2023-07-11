Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7694774EF47
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjGKMsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGKMsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:48:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B69135;
        Tue, 11 Jul 2023 05:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689079694; x=1720615694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nee+8F3UgjHiHBrgA29lPenNEyq01aBvrZNu0iQvTPs=;
  b=gkXp+Uwhe4htgOPQlLvPKwEYJ87AuGK4oRDPFCl9H/4KxahunwYnzCxt
   F5Shi4r69loeghlKwFItgM4JRNhTKAYIeC3k3n5qKRyvOjKCREg3QIwS2
   wf3thcO/tqqYNqzv7/yv20tfFrNe6+31O3Xh5LUzwtXX8k9okVrbdyF1N
   T/DWP0DB0gKj5dBVyNj74CCfNytKU8jmDXKzsFcngkedEGDEvDInOTeLW
   w4WcqDxgjA/KmkKemgCgLCTm9bwkfQU0/s0CosD7fCxq3xcyJLxhIwEh0
   FW9nDWoRdsIwwbo0z1p8qlpiYpjRDBS9WAOYjaN6QQgQ0zfPtN6eJTnrM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430694931"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="430694931"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 05:48:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="967787376"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="967787376"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 11 Jul 2023 05:48:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJCmb-001qkh-0z;
        Tue, 11 Jul 2023 15:47:57 +0300
Date:   Tue, 11 Jul 2023 15:47:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v2 05/15] spi: Remove code duplication in
 spi_add_device_locked()
Message-ID: <ZK1PfXsUJipjcCH6@smile.fi.intel.com>
References: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
 <20230710154932.68377-6-andriy.shevchenko@linux.intel.com>
 <7557bada-3076-4d6e-a5c5-d368433706e2@sirena.org.uk>
 <ZK03rBqoQ0IZz617@smile.fi.intel.com>
 <20230711120133.45drgk46y4cz7aut@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711120133.45drgk46y4cz7aut@mercury.elektranox.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 02:01:33PM +0200, Sebastian Reichel wrote:
> On Tue, Jul 11, 2023 at 02:06:20PM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 10, 2023 at 06:16:22PM +0100, Mark Brown wrote:
> > > On Mon, Jul 10, 2023 at 06:49:22PM +0300, Andy Shevchenko wrote:

...

> > > > -	struct device *dev = ctlr->dev.parent;
> > > > -
> > > > -	/* Chipselects are numbered 0..max; validate. */
> > > > -	if (spi_get_chipselect(spi, 0) >= ctlr->num_chipselect) {
> > > > -		dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, 0),
> > > > -			ctlr->num_chipselect);
> > > > -		return -EINVAL;
> > > > -	}
> > > > -
> > > > -	/* Set the bus ID string */
> > > > -	spi_dev_set_name(spi);
> > > 
> > > I see that this is duplicating spi_add_device() (and we really could do
> > > better with code sharing there I think) but I can't immediately see
> > > where the duplication that's intended to be elimiated is here - where
> > > else in the one call path that spi_add_device_locked() has would we do
> > > the above?  Based on the changelog I was expecting to see some
> > > duplicated code in the function itself.
> > 
> > Oh, by some reason Sebastian wasn't in this rather long Cc list.
> > Added him.
> > 
> > Reading again I don't see any useful explanation why that piece of code has to
> > be duplicated among these two functions. It's 100% a copy.
> > 
> > Sebastian, can you shed some light here?
> 
> The patch in this thread is obviously wrong. It results in the
> checks never beeing called for spi_add_device_locked(). The copy is
> in spi_add_device() and those two are not calling into each other.

Ah, now I see, I missed __ in the name.
Thank you for opening my eyes!

> But it should be fine to move the code to the start of
> __spi_add_device(), which allows removing the duplication. In that
> case the code will be run with the add_lock held, which is probably
> what I was worried about two years ago. Looking at it again, the
> lock is held anyways in case of spi_add_device_locked().

Right, I will re-do that.

-- 
With Best Regards,
Andy Shevchenko


