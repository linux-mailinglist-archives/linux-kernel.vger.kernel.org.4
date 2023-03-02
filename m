Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617496A8507
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjCBPPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjCBPP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:15:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8CE38B52;
        Thu,  2 Mar 2023 07:15:27 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2FF8966018CA;
        Thu,  2 Mar 2023 15:15:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677770125;
        bh=XDztbEfmSsWdhvyNwXpUvERVe2JxCB34x7YGEA1gAxQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hIWmhALVlRXTtzN+QFo5val3tRedI0IU+GM0t7eJZpQRWLt27+PIJs5zhXny57c56
         nb3DIulazp6wc9jOoxwUoI6EKCIzZ/isv10f7oEDbfg5sFw/13ajH4fEiLbr37Z9Ak
         7vfKqzVVq8vkuTkYKVpalIpsf0FRlxBdhCLcfaHZyPIytkFmCyqBQSwsSHIHlJO4J2
         WExHtCvzGOMr7LNNJG7hOuw/jIRlF/Ic8cNNHohI/kcw+MJzOXzlqaQ0H+Ncck9j8/
         v4X10skRDtTLXplMx3hzzr6o46n68XPc6N/8slULvetHRPziojT/ni9cIeMuXtPyD1
         IPHdia+fnJMTw==
Message-ID: <0398e95e-dbb8-2e41-7b36-12e36b8729f0@collabora.com>
Date:   Thu, 2 Mar 2023 16:15:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] watchdog: mtk_wdt: Add support for MT6735 WDT
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230302124015.75546-1-y.oudjana@protonmail.com>
 <20230302124015.75546-3-y.oudjana@protonmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230302124015.75546-3-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/03/23 13:40, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add support for the watchdog timer/top reset generation unit found on MT6735.
> Disable WDT_MODE_IRQ_EN in mtk_wdt_restart in order to make TOPRGU assert
> the SYSRST pin instead of issuing an IRQ. This change may be needed in other
> SoCs as well.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>   drivers/watchdog/mtk_wdt.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index a9c437598e7e..5a7a7b2b3727 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -10,6 +10,7 @@
>    */
>   
>   #include <dt-bindings/reset/mt2712-resets.h>
> +#include <dt-bindings/reset/mediatek,mt6735-wdt.h>
>   #include <dt-bindings/reset/mediatek,mt6795-resets.h>
>   #include <dt-bindings/reset/mt7986-resets.h>
>   #include <dt-bindings/reset/mt8183-resets.h>
> @@ -82,6 +83,10 @@ static const struct mtk_wdt_data mt2712_data = {
>   	.toprgu_sw_rst_num = MT2712_TOPRGU_SW_RST_NUM,
>   };
>   
> +static const struct mtk_wdt_data mt6735_data = {
> +	.toprgu_sw_rst_num = MT6735_TOPRGU_RST_NUM,
> +};
> +
>   static const struct mtk_wdt_data mt6795_data = {
>   	.toprgu_sw_rst_num = MT6795_TOPRGU_SW_RST_NUM,
>   };
> @@ -187,9 +192,15 @@ static int mtk_wdt_restart(struct watchdog_device *wdt_dev,
>   {
>   	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdt_dev);
>   	void __iomem *wdt_base;
> +	u32 reg;
>   
>   	wdt_base = mtk_wdt->wdt_base;
>   
> +	/* Enable reset in order to issue a system reset instead of an IRQ */
> +	reg = readl(wdt_base + WDT_MODE);
> +	reg &= ~WDT_MODE_IRQ_EN;
> +	writel(reg | WDT_MODE_KEY, wdt_base + WDT_MODE);

This is unnecessary and already done in mtk_wdt_start().
If you think you *require* this snippet, you most likely misconfigured the
devicetree node for your device :-)

Please remove this snippet.

Regards,
Angelo
