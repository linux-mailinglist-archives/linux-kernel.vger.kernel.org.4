Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5843374EC13
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjGKK6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGKK6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:58:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DF19B;
        Tue, 11 Jul 2023 03:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689073109; x=1720609109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lIHyBeHEaNenp9Q/l2JAcaQuyI3ymSNUAckdiFell2M=;
  b=aSDhIFMueOPnwVS7Ho6a6OIntXPb4+TbR8av8tsm7N95ZF0HZvBNOrjE
   6IYDKI8Noo4KEC9bjea4tOfDBZw7+Is1haF4dzE/Lhk/AH2xCsqUR7RhD
   rw9HxOXIUWPylC8POOQphS1jmQDGgYb/JL1I3v44IvjCMzks+Q/feoNi2
   32RjOfZWWZ5qO9zM3XX0FbQGqD3n7QxD8Zwoh/76qRnViLx8ducan/skg
   gjgorJxdWER81EIUlIqRCqhk48WACRer5ZCZeCCnGT2JMwI370n4lDlCU
   O2aCNRtbAJDyaNdfxwQMN+cFvv4UzNPiDwnJiAY7sDzLgZ2y6CEOfedZU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="368087275"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="368087275"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 03:58:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="724404293"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="724404293"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jul 2023 03:58:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJB4O-001p51-1q;
        Tue, 11 Jul 2023 13:58:12 +0300
Date:   Tue, 11 Jul 2023 13:58:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
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
Subject: Re: [PATCH v2 02/15] spi: Drop duplicate IDR allocation code in
 spi_register_controller()
Message-ID: <ZK01xAqLc8AGFDo/@smile.fi.intel.com>
References: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
 <20230710154932.68377-3-andriy.shevchenko@linux.intel.com>
 <97f3436a-78ca-4a94-a409-ef04bd3b593f@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97f3436a-78ca-4a94-a409-ef04bd3b593f@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 06:09:00PM +0100, Mark Brown wrote:
> On Mon, Jul 10, 2023 at 06:49:19PM +0300, Andy Shevchenko wrote:
> 
> > Refactor spi_register_controller() to drop duplicate IDR allocation.
> > Instead of if-else-if branching use two sequential if:s, which allows
> > to re-use the logic of IDR allocation in all cases.
> 
> For legibility this should have been split into a separate factoring out
> of the shared code and rewriting of the logic, that'd make it trivial to
> review.

Should I do that for v3?

> > -		mutex_lock(&board_lock);
> > -		id = idr_alloc(&spi_master_idr, ctlr, first_dynamic,
> > -			       0, GFP_KERNEL);
> > -		mutex_unlock(&board_lock);
> > -		if (WARN(id < 0, "couldn't get idr"))
> > -			return id;
> > -		ctlr->bus_num = id;
> > +		status = spi_controller_id_alloc(ctlr, first_dynamic, 0);
> > +		if (status)
> > +			return status;
> 
> The original does not do the remapping of return codes that the previous
> two copies do...

Yes, I had to mention this in the commit message that in my opinion this makes
no difference. With the dynamically allocated aliases the absence of the slot
has the same effect as in the other cases.

-- 
With Best Regards,
Andy Shevchenko


