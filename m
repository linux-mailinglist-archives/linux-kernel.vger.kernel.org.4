Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7B374D442
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjGJLIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjGJLIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:08:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5705610D;
        Mon, 10 Jul 2023 04:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688987294; x=1720523294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VFbT1YSYy4BNeDq7qC0WXbC9ofiSs7SR6qU8CkE8Ddw=;
  b=J8/3l5FQh9eXSIGZFCIgPwQcQjsO7bmOqfP4T8l0nPWzmKPzqITFQoR4
   bQFSiUei2hrJqasHv8rRYvBBFckmtA09FCKjsDU/gpbxxXhzxIX2xBTu+
   qvT5g6acBz7Y28lx73bYZMnsI+rs4Pq41kH33uBPRz0NdocFhpTKSDbkv
   S4P7n5Mr2YjYGW9eInWffhNLugVF+Qgum9upfTWJqYj4h6L3r5g9/3YLl
   V+CbkkMUPPg6G4YvCatrIjaAS13+P6hWsKYyNXi3o63AIxqQAo0AVtsF2
   FrQ5MO7dxYJUvRETSpFaZOtFlSNP5bgMeuu6H1FuEirhtZ6Y1z4SMK5Bg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="349117630"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="349117630"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 04:08:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="967393168"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="967393168"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jul 2023 04:08:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qIokK-001XII-18;
        Mon, 10 Jul 2023 14:08:00 +0300
Date:   Mon, 10 Jul 2023 14:08:00 +0300
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
Message-ID: <ZKvmkAP5ZuT6lGLN@smile.fi.intel.com>
References: <20230710102751.83314-1-andriy.shevchenko@linux.intel.com>
 <20230710102751.83314-5-andriy.shevchenko@linux.intel.com>
 <1ffd5603-4140-4bf6-bfed-af70a6759bda@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ffd5603-4140-4bf6-bfed-af70a6759bda@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 12:04:35PM +0100, Mark Brown wrote:
> On Mon, Jul 10, 2023 at 01:27:47PM +0300, Andy Shevchenko wrote:
> 
> > Convert the users to SPI_CONTROLLER_NO_?X and SPI_CONTROLLER_MUST_.X
> > and kill the not used anymore definitions.
> 
> The above is not what this change does:

How to improve it? I was sure that the form of "converting to something and
something" is clear...

> > -	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
> > +	controller->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;

-- 
With Best Regards,
Andy Shevchenko


