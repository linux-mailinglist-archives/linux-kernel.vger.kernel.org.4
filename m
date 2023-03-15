Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE5C6BADBF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjCOKe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjCOKeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:34:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A51E206A4;
        Wed, 15 Mar 2023 03:34:21 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 32B9C66015F1;
        Wed, 15 Mar 2023 10:34:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678876459;
        bh=FlyNjljVXfQH8sXqQul+9FStNcj5UQa68vjRYr8bIj4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZtBAzml0yzK/Dr2SNII7uZoStPKI9wVCgDn4+MmcAuhEA/Psq9w+6+B0ayJl9bq9U
         f2oJ77jcHyHREAxp1NDUctgXfCO6+jgcC6G50nj85wolvUHIofSU98AG5LF05sgQAB
         v9o7Vl5PfjaEPu2r+ne/giu9bYUzjJcGcIoS6rHksEF0ArNpQm14ZiryYnuIhC5gI2
         57RQj3HBsUkqfy/Hq8if2xEMaRFM2rJKPNW/xnFYoEEgeKtxqubuJmyJvKUN/cI5uo
         PenS7w8SIfBlnsKrZaF2nUIPck1nsRWqsG0cMbEiZOJxtAcm/Mp8tauAweWI0SLwso
         7Ynx9GUCILxUA==
Message-ID: <e15eac65-94d4-6a70-cab1-4fdb550116f7@collabora.com>
Date:   Wed, 15 Mar 2023 11:34:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] Revert "arm64: dts: mediatek: mt8173-elm: Move display to
 ps8640 auxiliary bus"
To:     Pin-yen Lin <treapking@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230315041107.2886940-1-treapking@chromium.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230315041107.2886940-1-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/03/23 05:11, Pin-yen Lin ha scritto:
> This reverts commit c2d94f72140a28d0f516b7c5e8274a9c185a04ff.
> 
> The `lg_lp120up1_mode` defined in panel-edp.c is not working for some
> panels used on elm/hana devices. Move the panel node out of the aux-bus
> subnode so the driver only uses the modes retrieved from the EDID.
> 
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 

This commit was sent to fix display functionality on MT8173-Elm (Acer Chromebook
R13).... apparently this should get fixed with [1].

Investigating if this is the case.

Regards,
Angelo

[1]: 
https://patchwork.kernel.org/project/dri-devel/patch/20230315035508.2874915-1-treapking@chromium.org/

> ---
> 
>   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 26 +++++++++-----------
>   1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> index d452cab28c67..d45a2aeb0eb1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -90,6 +90,18 @@ switch-volume-up {
>   		};
>   	};
>   
> +	panel: panel {
> +		compatible = "lg,lp120up1";
> +		power-supply = <&panel_fixed_3v3>;
> +		backlight = <&backlight>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&ps8640_out>;
> +			};
> +		};
> +	};
> +
>   	panel_fixed_3v3: regulator1 {
>   		compatible = "regulator-fixed";
>   		regulator-name = "PANEL_3V3";
> @@ -282,20 +294,6 @@ ps8640_out: endpoint {
>   				};
>   			};
>   		};
> -
> -		aux-bus {
> -			panel: panel {
> -				compatible = "lg,lp120up1";
> -				power-supply = <&panel_fixed_3v3>;
> -				backlight = <&backlight>;
> -
> -				port {
> -					panel_in: endpoint {
> -						remote-endpoint = <&ps8640_out>;
> -					};
> -				};
> -			};
> -		};
>   	};
>   };
>   

