Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0D86E3C8B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 00:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDPWHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 18:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjDPWHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 18:07:22 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77BC26A8;
        Sun, 16 Apr 2023 15:07:20 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 452BF85C9B;
        Mon, 17 Apr 2023 00:07:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1681682838;
        bh=QKvk9+XBBRlUqKsk7bMr4Ef6sOzUUDhjPGcAEetatRM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UP2ewFEoUfz1Yxj8B3hg6QGvA+Tbdz7mVY7qFBYqT2SCIrLfSbPbSRGQCHOqWJWrc
         ORWUzUa6iPefZDb6K9QPJ47F0588aUJAQqJfqIJDLrCjbFg8mZQyKOdfVVSdugvhlf
         gj3D72BnNkyEWxlYU7o2ADx3rs+ftCsWsZYjpWZX2rxj4/vjSMHDAVxnhl3NgzCnaK
         fym/KOdj8BoGIcRYR24bj7QS3pc6jGir33VGXmdOpeLdRRhO1Szaq+qe5Nex0gzHIl
         IXbDVIOcy07IXnLtFjpNSuOZ3NWTPrR5Goli1tE2C5BFwzljvUCHiki9C6EcLQvg1X
         VPxHxEsrbigSA==
Message-ID: <414febc4-aab1-95ec-ac2e-e82a3f881d01@denx.de>
Date:   Mon, 17 Apr 2023 00:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/6] drm: bridge: samsung-dsim: Fix PMS Calculator on
 imx8m[mnp]
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
        Daniel Vetter <daniel@ffwll.ch>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230415104104.5537-1-aford173@gmail.com>
 <20230415104104.5537-2-aford173@gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230415104104.5537-2-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> According to Table 13-45 of the i.MX8M Mini Reference Manual, the min
> and max values for M and  the frequency range for the VCO_out
> calculator were incorrect.  This also appears to be the case for the
> imx8mn and imx8mp.
> 
> To fix this, make new variables to hold the min and max values of m
> and the minimum value of VCO_out, and update the PMS calculator to
> use these new variables instead of using hard-coded values to keep
> the backwards compatibility with other parts using this driver.

[...]

>   static const struct samsung_dsim_driver_data imx8mm_dsi_driver_data = {
> @@ -470,6 +485,9 @@ static const struct samsung_dsim_driver_data imx8mm_dsi_driver_data = {
>   	 */
>   	.pll_p_offset = 14,
>   	.reg_values = imx8mm_dsim_reg_values,
> +	.m_min = 64,
> +	.m_max = 1023,
> +	.vco_min = 1050,

You might want to call this 'min_freq' since there is a 'max_freq' which 
seems to indicate what VCO max frequency is.

Note that the same datasheet contains the following information:
"
MIPI_DPHY_M_PLLPMS field descriptions

12–4 PMS_M
Specifies the PLL PMS value for the M divider
NOTE: The programmable divider range should be within 25 to 125 to 
ensure PLL stability.
NOTE: The M and P divider values should be considered together to ensure 
VCO ouput frequency
(VCO_out) range is between 350 MHz to 750 MHz.
Please refer to the topic DPHY PLL for more information.
"
