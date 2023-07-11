Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D999274EF70
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjGKMwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjGKMwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:52:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BB898;
        Tue, 11 Jul 2023 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689079928; x=1720615928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fixFH5Llqroff/AhZ015VZ+OpUUgSBQ7xNlXodB8idQ=;
  b=nXYGAZBmCt/q8vpk2hgdP5RxkOpR8+FWs2GpP++Xb4iPebpuW50dI6ld
   HDfRX3kjPZuoHIK0bhysXuedh2zVn1qePdMpdhmLGXnkzqtifn2r2mqWp
   FetdbMxf+0J+xg092E4vnYifUT0n/G0bNNxd8El0uHSo/uR5nGibEno3L
   Jmh0DoL1JhHjgCOyThsiLu+Lx5951MOmIzweA3blnVnam/XYL+VDS5W11
   d77TFNBBZMuDVEn8vhLIeozSC+mGf/A0CsbpYbEWuVsf4ImS0A7BtfzGh
   zVehqdLyudfgZdv4w01fC+A1Q9qoiUkiVu3qCIUUXaR7zqL+C7FmjFewq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="344205663"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="344205663"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 05:52:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="786613329"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="786613329"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2023 05:51:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJCqO-001qnp-39;
        Tue, 11 Jul 2023 15:51:52 +0300
Date:   Tue, 11 Jul 2023 15:51:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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
Subject: Re: [PATCH v2 01/15] spi: Remove unneeded OF node NULL checks
Message-ID: <ZK1QaK3Qy/mDauae@smile.fi.intel.com>
References: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
 <20230710154932.68377-2-andriy.shevchenko@linux.intel.com>
 <f0b9e2e4-b2c0-4336-0ec4-5afd9f1b6c72@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0b9e2e4-b2c0-4336-0ec4-5afd9f1b6c72@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 10:12:55AM +0200, AngeloGioacchino Del Regno wrote:
> Il 10/07/23 17:49, Andy Shevchenko ha scritto:
> > In the couple of places the NULL check of OF node is implied by the call
> > that takes it as a parameter. Drop the respective duplicate checks.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Validated against spi-mt65xx, spi-mt7621, spi-mtk-nor, spi-mtk-snfi;
> 
> Reviewed-by: AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> # MediaTek

By some reason the tag is split and I'm not sure `b4` can cope with that.
In any case, added manually. Thank you for the review!

-- 
With Best Regards,
Andy Shevchenko


