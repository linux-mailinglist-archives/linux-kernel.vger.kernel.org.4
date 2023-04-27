Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35086F0C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244505AbjD0TJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244687AbjD0TJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:09:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01E79E;
        Thu, 27 Apr 2023 12:09:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BE9D63F22;
        Thu, 27 Apr 2023 19:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAF8C433EF;
        Thu, 27 Apr 2023 19:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682622594;
        bh=4MuGyWTQQD8YDc9ZDP5EuTvCXfhs1RGXEGefTe8GbFs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OEyoAdAg2oHj1kpUaFAUQnORGNgUcMTwXna94WirWc4/7OFURAmKcVKLlVxGAFkME
         toxsg2t0o0U7Q+9nKKAWfOe1B/t1z3g1kRabot2L3KU7VvngL293h0JsGHTQ534ZJP
         wb/t5pQP0ryuyOaWJAQ0Akswuclq647TVGmt1KHHbj8adW21pY6mXqBy4ogxoG3XiT
         nl8v4DuX6FhDVh3IAmmeTltphT6HmwSaAdaxUAAee3iYvoH2HR36H28EF1sUk2sy35
         kac9ZjDMYlfFNHS8ZZYJ4TPcDUlbU3BEvZYy9X6SsaJklf3YKOr0nvFwrR0eNy/XBZ
         ccVK16xunjKbA==
Message-ID: <57dd81d0-510e-0fab-670d-1109eb8dd974@kernel.org>
Date:   Thu, 27 Apr 2023 14:09:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 29/65] clk: socfpga: gate: Add a determine_rate hook
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
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
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, patches@opensource.cirrus.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        alsa-devel@alsa-project.org, linux-mips@vger.kernel.org
References: <20221018-clk-range-checks-fixes-v3-0-9a1358472d52@cerno.tech>
 <20221018-clk-range-checks-fixes-v3-29-9a1358472d52@cerno.tech>
 <679921ee-98d4-d6ef-5934-e009fd4b31fc@kernel.org>
 <sjlp5ubnpvulgwhhymmfkmmobkgxacyqwagqozodkee3di2qik@3igj6k3zgbk6>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <sjlp5ubnpvulgwhhymmfkmmobkgxacyqwagqozodkee3di2qik@3igj6k3zgbk6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On 4/25/23 09:48, Maxime Ripard wrote:
> Hi Dinh,
> 
> On Mon, Apr 24, 2023 at 01:32:28PM -0500, Dinh Nguyen wrote:
>> On 4/4/23 05:11, Maxime Ripard wrote:
>>> The SoCFGPA gate clock implements a mux with a set_parent hook, but
>>> doesn't provide a determine_rate implementation.
>>>
>>> This is a bit odd, since set_parent() is there to, as its name implies,
>>> change the parent of a clock. However, the most likely candidate to
>>> trigger that parent change is a call to clk_set_rate(), with
>>> determine_rate() figuring out which parent is the best suited for a
>>> given rate.
>>>
>>> The other trigger would be a call to clk_set_parent(), but it's far less
>>> used, and it doesn't look like there's any obvious user for that clock.
>>>
>>> So, the set_parent hook is effectively unused, possibly because of an
>>> oversight. However, it could also be an explicit decision by the
>>> original author to avoid any reparenting but through an explicit call to
>>> clk_set_parent().
>>>
>>> The latter case would be equivalent to setting the flag
>>> CLK_SET_RATE_NO_REPARENT, together with setting our determine_rate hook
>>> to __clk_mux_determine_rate(). Indeed, if no determine_rate
>>> implementation is provided, clk_round_rate() (through
>>> clk_core_round_rate_nolock()) will call itself on the parent if
>>> CLK_SET_RATE_PARENT is set, and will not change the clock rate
>>> otherwise. __clk_mux_determine_rate() has the exact same behavior when
>>> CLK_SET_RATE_NO_REPARENT is set.
>>>
>>> And if it was an oversight, then we are at least explicit about our
>>> behavior now and it can be further refined down the line.
>>>
>>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>>> ---
>>>    drivers/clk/socfpga/clk-gate.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
>>> index 32ccda960f28..cbba8462a09e 100644
>>> --- a/drivers/clk/socfpga/clk-gate.c
>>> +++ b/drivers/clk/socfpga/clk-gate.c
>>> @@ -110,6 +110,7 @@ static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
>>>    static struct clk_ops gateclk_ops = {
>>>    	.recalc_rate = socfpga_clk_recalc_rate,
>>> +	.determine_rate = __clk_mux_determine_rate,
>>>    	.get_parent = socfpga_clk_get_parent,
>>>    	.set_parent = socfpga_clk_set_parent,
>>>    };
>>> @@ -166,7 +167,7 @@ void __init socfpga_gate_init(struct device_node *node)
>>>    	init.name = clk_name;
>>>    	init.ops = ops;
>>> -	init.flags = 0;
>>> +	init.flags = CLK_SET_RATE_NO_REPARENT;
>>>    	init.num_parents = of_clk_parent_fill(node, parent_name, SOCFPGA_MAX_PARENTS);
>>>    	if (init.num_parents < 2) {
>>>
>>
>> This patch broke SoCFPGA boot serial port. The characters are mangled.
> 
> Do you have any other access to that board? If so, could you dump
> clk_summary in debugfs with and without that patch?
> 

That dump from the clk_summary are identical for both cases.
