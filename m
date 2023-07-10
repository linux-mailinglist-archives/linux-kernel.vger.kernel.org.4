Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F275074D5C8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjGJMiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjGJMiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:38:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE7CDE;
        Mon, 10 Jul 2023 05:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688992691; x=1720528691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2I7Ns5P9Fqk5itIQUPMwgPj6Db+DdMBwViqY3DgUc6U=;
  b=ZXblJpEOn8+jlXfw44vagMUmMc9v2eLeDBvGDDJd9V5ZHEqbtBXGd5Uh
   zIxitTJ26v1PIRV/2vgEZcT1LrgTqh1Z/EvyAHLQHoPAVpPKUIXLKneTt
   Qzbl3quDJVXAwEKmjvk3M4Rtx65evmZppagsgCItCZG9lq32X4joI2MuF
   tRQc0WSPyuWs3NoIimL0ngNjTET0OapRqqEdzA1ulT1hUGoNtOjgHjJ3g
   zP7oCmFbNRDcrPnqj+P4ZQwe71io3A0G00Z6t+jWPrgx8cQ2WLO4VAK8X
   +/RNBikWvyLWV7Abt5glGuwHLczROZ/2bR00zXPEr3HF8JpCBspJx5umS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="428025533"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="428025533"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 05:38:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="755983743"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="755983743"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 10 Jul 2023 05:38:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qIq9Q-001YUr-0L;
        Mon, 10 Jul 2023 15:38:00 +0300
Date:   Mon, 10 Jul 2023 15:37:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>, Kris Bahnsen <kris@embeddedts.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v1 4/8] spi: Get rid of old SPI_MASTER_NO_.X and
 SPI_MASTER_MUST_.X
Message-ID: <ZKv7p96D2B9vYd0J@smile.fi.intel.com>
References: <20230710102751.83314-1-andriy.shevchenko@linux.intel.com>
 <20230710102751.83314-5-andriy.shevchenko@linux.intel.com>
 <1ffd5603-4140-4bf6-bfed-af70a6759bda@sirena.org.uk>
 <ZKvmkAP5ZuT6lGLN@smile.fi.intel.com>
 <ZKvnPXl9H+cQR8Ok@smile.fi.intel.com>
 <353027bf-6d2a-40de-9e18-8553864b343c@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <353027bf-6d2a-40de-9e18-8553864b343c@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 12:22:59PM +0100, Mark Brown wrote:
> On Mon, Jul 10, 2023 at 02:10:53PM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 10, 2023 at 02:08:00PM +0300, Andy Shevchenko wrote:
> > > On Mon, Jul 10, 2023 at 12:04:35PM +0100, Mark Brown wrote:
> > > > On Mon, Jul 10, 2023 at 01:27:47PM +0300, Andy Shevchenko wrote:
> 
> > > > > Convert the users to SPI_CONTROLLER_NO_?X and SPI_CONTROLLER_MUST_.X
> > > > > and kill the not used anymore definitions.
> 
> > > > The above is not what this change does:
> 
> > > How to improve it? I was sure that the form of "converting to something and
> > > something" is clear...
> 
> > A wild guess, maybe you meant to split to two changes, one per each macro group?
> 
> No, doing TX and RX in one commit is fine.

No, I meant one per _NO_ and _MUST_.

> > > > > -	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
> > > > > +	controller->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
> 
> What part of the above change is replacing _NO_ with _MUST_?

None, that's why assuming the split by name should be fine.

-- 
With Best Regards,
Andy Shevchenko


