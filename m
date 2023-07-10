Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F90B74DAC8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjGJQMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjGJQMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:12:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5865123;
        Mon, 10 Jul 2023 09:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689005557; x=1720541557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0SlN/itezSp5S5zjCF2SMzf5gnBS89SJ4xDj94AkcQw=;
  b=Uu0Ds1em9Lk23LHZobxne2tEvaESDgD3vrZExJS0WizvCzVkChwvH2YF
   Zx1M4+DhsRvt0igFRNfcE1oHdMN38+Y8hqIw8bedIO9M7NXclWLr9r9cx
   pwuyzG71FM/4y5GhSoGovaR/CKn03W7ERCn/QYqPj/pPFBa2JsGX9LUOW
   L8dGO7ho3bzEMLNFvFPL6flQ+4HhKPDER9cXmL8TsjJWaLBezOhEP1cvV
   FlE8q5hP8sIq7aH3Fk8gD9/ijGApm2n2dqbV0q4weyt6P0WJlIR1W3E5/
   Mk7MIH9C2o26PUK8J/epFVE6IHD3pSg/wxul959N4kyr948zI/0jnIJzw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="430464657"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="430464657"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 09:11:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="750388713"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="750388713"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 10 Jul 2023 09:10:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qItTH-001bF6-2N;
        Mon, 10 Jul 2023 19:10:43 +0300
Date:   Mon, 10 Jul 2023 19:10:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
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
        Richard Cochran <richardcochran@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Andy Gross <agross@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 09/15] spi: Use struct_size() helper
Message-ID: <ZKwtgwZtUUHGC+S3@smile.fi.intel.com>
References: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
 <20230710154932.68377-10-andriy.shevchenko@linux.intel.com>
 <20230710-doze-scared-9f0a2e1a9125-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710-doze-scared-9f0a2e1a9125-mkl@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 05:59:55PM +0200, Marc Kleine-Budde wrote:
> On 10.07.2023 18:49:26, Andy Shevchenko wrote:

...

> > +	struct spi_transfer	t[];
> 
> You might want to use the DECLARE_FLEX_ARRAY helper here.

Technically, yes, semantically documentation [1] disagrees with
you, so I leave it as is.

[1]: Documentation/process/deprecated.rst:269

-- 
With Best Regards,
Andy Shevchenko


