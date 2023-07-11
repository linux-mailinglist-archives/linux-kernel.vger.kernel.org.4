Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3055574EC62
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjGKLMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjGKLMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:12:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F959B;
        Tue, 11 Jul 2023 04:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689073936; x=1720609936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=twR4kdv8R+UGB+uDynfbksgxMKi2k7OVYCc9yUjloq8=;
  b=KKBynze5CMpuIyfqkRGwCHesvRyiRgF8oxskHf5vbA2zYDjNImWkHPR5
   IlyAsxeGSCKSAULjWy0gMewmiMU1sETCJnhUjgPVkPyjGow95lid5WqpF
   LMqa4eg+LLvs9+bOx3MnwY6i69kDE/sdB1boBfjAruwfV55k0i+4qa8W5
   OwmKNwSfbaIiUmHD2RSquE03zm3qrqQGVPyLltHCg1DjeCh6+0XtQcKxR
   XTWD7JrU6xbO5skYm3trWSelXonfy4fkd7nye3VafhIdcLfjjcP/CRJmM
   NcqaHyErGUx+WYtCVqZxM9GCl79RCOM8RvRKY5LkZJ6orfD40Huedk4hb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="362053719"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="362053719"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 04:12:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="845225511"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="845225511"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 11 Jul 2023 04:12:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJBHj-001pIO-15;
        Tue, 11 Jul 2023 14:11:59 +0300
Date:   Tue, 11 Jul 2023 14:11:59 +0300
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
Subject: Re: [PATCH v2 00/15] spi: Header and core clean up and refactoring
Message-ID: <ZK04/8UQEaNinLoK@smile.fi.intel.com>
References: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
 <58c6f76a-8028-4ce8-a101-d5feb3b40897@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58c6f76a-8028-4ce8-a101-d5feb3b40897@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 06:31:12PM +0100, Mark Brown wrote:
> On Mon, Jul 10, 2023 at 06:49:17PM +0300, Andy Shevchenko wrote:
> > Various cleanups and refactorings of the SPI header and core parts
> > united in a single series. It also touches drivers under SPI subsystem
> > folder on the pure renaming purposes of some constants.
> 
> I've queued 1-3, 6-8 and 11- for CI thanks.

Thank you!
Do you think patch 9 deserves to be proceeded?

-- 
With Best Regards,
Andy Shevchenko


