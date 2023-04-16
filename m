Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDFC6E3C91
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 00:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjDPWIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 18:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPWIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 18:08:12 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2216211F;
        Sun, 16 Apr 2023 15:08:11 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4337685C9B;
        Mon, 17 Apr 2023 00:08:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1681682890;
        bh=P7xgL3CLNT5Y3Sll/H8HmI7CJlMVMPUZvFIyj+/G2Es=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IFxe2W0JkWDjpMS0PlKCOZBrlL1kiU60vH9dAdyi76jMrkP1rDZo2hDMtoRmYU/bE
         qxo5KYa25KfGg+ictSmyAqM0a+7q8NyGxqAD8BG5sIMWofER5JAOy4KE97nX7ZJi2e
         uORzWh7kIXBq7TQ0XEd4naZE7zocSVmLIABYfPP8g6HW0jan20a4eeKofjV4R/W9UN
         5lRgWq8Og+PoMmPlci4SToa3PObg6iCZzfbuAlFVBRyRoTZVEEgvmNPTCr9+RzuCIJ
         CWW3PPU2LBpMCGZcm4zgH3RJ9LdRBqzSMWVqJVKCg79G8MYQNHJhnRcgZXBy7j+4+m
         sMtN4/g4HyRmQ==
Message-ID: <7eed74e8-9f67-a410-3cec-f61a6db85238@denx.de>
Date:   Mon, 17 Apr 2023 00:08:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/6] drm: bridge: samsung-dsim: Fetch pll-clock-frequency
 automatically
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     m.szyprowski@samsung.com, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230415104104.5537-1-aford173@gmail.com>
 <20230415104104.5537-3-aford173@gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230415104104.5537-3-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/23 12:41, Adam Ford wrote:
> Fetch the clock rate of "sclk_mipi" (or "pll_clk") instead of
> having an entry in the device tree for samsung,pll-clock-frequency.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>   drivers/gpu/drm/bridge/samsung-dsim.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> index 9fec32b44e05..73f0c3fbbdf5 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1744,11 +1744,6 @@ static int samsung_dsim_parse_dt(struct samsung_dsim *dsi)
>   	struct device_node *node = dev->of_node;
>   	int ret;
>   
> -	ret = samsung_dsim_of_read_u32(node, "samsung,pll-clock-frequency",
> -				       &dsi->pll_clk_rate);
> -	if (ret < 0)
> -		return ret;
> -
>   	ret = samsung_dsim_of_read_u32(node, "samsung,burst-clock-frequency",
>   				       &dsi->burst_clk_rate);
>   	if (ret < 0)

Does this break compatibility with old samsung DTs ?
