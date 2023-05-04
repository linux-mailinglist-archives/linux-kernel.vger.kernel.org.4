Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDC06F6D07
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjEDNjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjEDNjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:39:41 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA08E768B;
        Thu,  4 May 2023 06:39:40 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3445DKX4028271;
        Thu, 4 May 2023 08:39:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=zEWDZRH16IxZH8jYRpv51rOx+oio62y+XziPw6IiJ1w=;
 b=L9OXVtBpZ1h2EQYPU9fS+CdLeJbQogB3ovHqBxHZV93tB0yyeToDCRKM+3p1Z+XcLFZz
 DhnfCDaIAxZdN2kEgqy91hT0ZkrDGwKDxWYOZyY84Bl71CaNzT/kQ6H7HeGti1LPjN2A
 1C53tmN+15LZY4Xx0LsXz3jdPfYj804ASLi4vP04knaO2fZRiDoRcGlVawsjF8dnEBef
 /SeuYP9ruq4TACIUkQ8hZ4rHae8zIGOhnmbirZT1jFR/3kSOYyRRGhG6Ds8kk3q2z9qA
 m1ycJOjn8GapD45ROvo5FEKeAAyqeD0ftMxijnIycmgOTyr7CJvQgOt/JbzSOHf7FjX0 fg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3q8ynqxxwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 08:39:25 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 4 May
 2023 08:39:24 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 4 May 2023 08:39:24 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E168D11AA;
        Thu,  4 May 2023 13:39:23 +0000 (UTC)
Date:   Thu, 4 May 2023 13:39:23 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Maxime Ripard <maxime@cerno.tech>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>, Abel Vesa <abelvesa@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-actions@lists.infradead.org>,
        <patches@opensource.cirrus.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-phy@lists.infradead.org>,
        <linux-rtc@vger.kernel.org>, <linux-sunxi@lists.linux.dev>,
        <alsa-devel@alsa-project.org>, <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v3 14/65] clk: lochnagar: Add a determine_rate hook
Message-ID: <20230504133923.GE68926@ediswmail.ad.cirrus.com>
References: <20221018-clk-range-checks-fixes-v3-0-9a1358472d52@cerno.tech>
 <20221018-clk-range-checks-fixes-v3-14-9a1358472d52@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221018-clk-range-checks-fixes-v3-14-9a1358472d52@cerno.tech>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: by0VDh8QAdOEbtK8UU7dmeZOMGxMIv4b
X-Proofpoint-ORIG-GUID: by0VDh8QAdOEbtK8UU7dmeZOMGxMIv4b
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 12:11:04PM +0200, Maxime Ripard wrote:
> The lochnagar clocks implement a mux with a set_parent hook, but
> doesn't provide a determine_rate implementation.
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
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
