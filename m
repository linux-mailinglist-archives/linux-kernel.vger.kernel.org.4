Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0B76E3C83
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 00:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjDPWCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 18:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjDPWCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 18:02:50 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133CC211C;
        Sun, 16 Apr 2023 15:02:47 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 438B585C9B;
        Mon, 17 Apr 2023 00:02:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1681682564;
        bh=JXOO0HH7hgkSuYOF/8TS6jyPZhhE7U1JS+DTKN8pPds=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OoV12WlRdtE7Or0xGRTZE3jHnaCPBOcm80TQHxHgMiKO03ci3JoUjDzCS7OvLD5RX
         wU6uCJQAEK6aUAFm8GF3cf4tO7q4F6/z5Sy9ufHVMAkxPYWzhFR9RiZpmECV+Wcouq
         3KGXmT6HhVJdJg1PFlhHy0h+ObJdi+t+SUd+NNkwLnbasypWl1Qld9ddAKVcPH2rGP
         BdFWfuqzty3Pnm7huZDiQdFnBfEw/LRan04973rt4yjhun34SHjkOWouxTGUTMmFwg
         utIevBBGrwgDnIJ4kac+l6nc5gDz7JhpXwVfyOog+tTmX3hUzbU8BMpV1oaiDkiEz+
         7CvOwJlN1vNrA==
Message-ID: <6bfeb8aa-f4f4-4b24-a070-108e5553ad48@denx.de>
Date:   Mon, 17 Apr 2023 00:02:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/6] drm: bridge: samsung-dsim: Support multi-lane
 calculations
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
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230415104104.5537-1-aford173@gmail.com>
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

On 4/15/23 12:40, Adam Ford wrote:
> If there is more than one lane, the HFP, HBP, and HSA is calculated in
> bytes/pixel, then they are divided amongst the different lanes with some
> additional overhead. This is necessary to achieve higher resolutions while
> keeping the pixel clocks lower as the number of lanes increase.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>   drivers/gpu/drm/bridge/samsung-dsim.c | 40 +++++++++++++++++++++++----
>   1 file changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> index e0a402a85787..1ccbad4ea577 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -215,6 +215,7 @@
>   #define DSI_RX_FIFO_SIZE		256
>   #define DSI_XFER_TIMEOUT_MS		100
>   #define DSI_RX_FIFO_EMPTY		0x30800002
> +#define DSI_HSYNC_PKT_OVERHEAD	6
>   
>   #define OLD_SCLK_MIPI_CLK_NAME		"pll_clk"
>   
> @@ -879,13 +880,40 @@ static void samsung_dsim_set_display_mode(struct samsung_dsim *dsi)
>   			| DSIM_MAIN_VBP(m->vtotal - m->vsync_end);
>   		samsung_dsim_write(dsi, DSIM_MVPORCH_REG, reg);
>   
> -		reg = DSIM_MAIN_HFP(m->hsync_start - m->hdisplay)
> -			| DSIM_MAIN_HBP(m->htotal - m->hsync_end);
> -		samsung_dsim_write(dsi, DSIM_MHPORCH_REG, reg);
> +		/*
> +		 * If there is more than one lane, the HFP, HBP, and HSA
> +		 * is calculated in bytes/pixel, then they are divided
> +		 * amongst the different lanes with some additional
> +		 * overhead correction
> +		 */

Did you find any confirmation of this in the MX8M* datasheet or at least 
by measuring the DSI data lanes with a scope ?

It would be real cool if this could be confirmed somehow, and we could 
rule out that this tweaking of HSA/HSE/... stuff isn't related to either 
LP-HS transition timing calculation this driver is missing, OR, 
incorrect flags in various bridge/panel drivers like commit:

ca161b259cc84 ("drm/bridge: ti-sn65dsi83: Do not generate HFP/HBP/HSA 
and EOT packet")

