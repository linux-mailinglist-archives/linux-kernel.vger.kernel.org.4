Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE92A61F15D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiKGK7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbiKGK6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:58:42 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BE119C03;
        Mon,  7 Nov 2022 02:58:42 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A78o4vU010393;
        Mon, 7 Nov 2022 04:58:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=7lexxXZ3I3hljvfG/MXh5XgWwfTCj6K6EGi2gwpMgRA=;
 b=MlOb16frReJltGone9fs4amjkqovcdEamnVC3FlFeoZZd6zluUCjkGf0ihnUMsqujkaA
 H8I/V07ZcrCtj3Me8MCnu1HzAT6c7SRFW+Hh/FVPBKLTBK0lkpQcAFdVVvECWHTUpo/L
 d/dE/5urYwZVfafPQWAGGipJxVMewDDaKcb60xAi4A8h4kLf4cmEFO87PvkJnkW7tfL0
 mbQIqr5S1dRUOd8T1/4MBzSMJ4Q4RIhkv/R5+HYlOfm7QbUPuCEQIfOD3fVC8gn6g8Oz
 NCISdICUUpF19kLQlfICj24QVNW5fiPzst1JOV1+w7Md+3AcASEfckm6g8vj5m1MRnhx Bg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3knn81j3vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 04:58:26 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Mon, 7 Nov
 2022 04:58:23 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.15 via Frontend Transport; Mon, 7 Nov 2022 04:58:23 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D68F1468;
        Mon,  7 Nov 2022 10:58:23 +0000 (UTC)
Date:   Mon, 7 Nov 2022 10:58:23 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Maxime Ripard <maxime@cerno.tech>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Samuel Holland <samuel@sholland.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Takashi Iwai <tiwai@suse.com>,
        David Airlie <airlied@gmail.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Lechner <david@lechnology.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-mips@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-actions@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <patches@opensource.cirrus.com>, <linux-tegra@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 20/65] clk: wm831x: clkout: Add a determine_rate hook
Message-ID: <20221107105823.GF10437@ediswmail.ad.cirrus.com>
References: <20221018-clk-range-checks-fixes-v2-0-f6736dec138e@cerno.tech>
 <20221018-clk-range-checks-fixes-v2-20-f6736dec138e@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221018-clk-range-checks-fixes-v2-20-f6736dec138e@cerno.tech>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: BS92jlzbqC_0WCEemxbjcbgSY_UegXLF
X-Proofpoint-GUID: BS92jlzbqC_0WCEemxbjcbgSY_UegXLF
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 02:17:37PM +0100, Maxime Ripard wrote:
> The WM381x "clkout" clock implements a mux with a set_parent hook,
> but doesn't provide a determine_rate implementation.
> 
> This is a bit odd, since set_parent() is there to, as its name implies,
> change the parent of a clock. However, the most likely candidate to
> trigger that parent change is a call to clk_set_rate(), with
> determine_rate() figuring out which parent is the best suited for a
> given rate.
> 
> The other trigger would be a call to clk_set_parent(), but it's far less
> used, and it doesn't look like there's any obvious user for that clock.
> 
> So, the set_parent hook is effectively unused, possibly because of an
> oversight. However, it could also be an explicit decision by the
> original author to avoid any reparenting but through an explicit call to
> clk_set_parent().
> 
> The latter case would be equivalent to setting the flag
> CLK_SET_RATE_NO_REPARENT, together with setting our determine_rate hook
> to __clk_mux_determine_rate(). Indeed, if no determine_rate
> implementation is provided, clk_round_rate() (through
> clk_core_round_rate_nolock()) will call itself on the parent if
> CLK_SET_RATE_PARENT is set, and will not change the clock rate
> otherwise. __clk_mux_determine_rate() has the exact same behavior when
> CLK_SET_RATE_NO_REPARENT is set.
> 
> And if it was an oversight, then we are at least explicit about our
> behavior now and it can be further refined down the line.
> 

Yeah I don't think there would be anything wrong with this clock
changing parents on a rate change, but as you say this can be
refined down the line if someone needs the behaviour. It's an
older part so probably better to stick roughly to the current
behaviour for now.

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
