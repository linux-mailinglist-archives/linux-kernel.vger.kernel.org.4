Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228E2671DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjARN2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjARN2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:28:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD03E5924F;
        Wed, 18 Jan 2023 04:54:03 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D4EE76602DFF;
        Wed, 18 Jan 2023 12:54:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674046441;
        bh=W0maxCKa2xr4pnTX1HqInnogwxcqmMSgRc+NoZCdKOY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P2GIpFG0pdcWYxZdlMkFPN/2kgFVwaVu/WECh/MB7dooeOxYJSI3SVx1TjURSjkWx
         cYudLUfd27Y7Qc8W81DBRt9wKpZ+4zoDh0jfRjVpYCQCGtMjHnbXO6PFj3dUA/5OoG
         7XvrrhjKbvXAGvFHmT5NmfZbHsWdBLIO9XioxvzbaIr68WFGnK1pC6FjzDox/Arvzl
         0kXG3FdVlnqa3RZCci0FnSw/4gNJA7YdUl5V5L0Jr9PCu5igDqZBJ+tLEMkXGZwm7X
         +Ts+zuQJHrbag4d/u6Bc//5N/NzyFIXeLn+Dlu/PS9xY7AWQ90lMv3Whp4Pa3ZWmhG
         PL6tC9Z1wmLAw==
Message-ID: <0dc9466d-9baa-451b-98fa-7caf424acd4c@collabora.com>
Date:   Wed, 18 Jan 2023 13:53:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 2/2] thermal: mediatek: add support for MT7986 and
 MT7981
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Steven Liu <steven.liu@mediatek.com>,
        Henry Yen <Henry.Yen@mediatek.com>,
        Chad Monroe <chad@monroe.io>, John Crispin <john@phrozen.org>,
        Frank Wunderlich <frank-w@public-files.de>
References: <cover.1674012985.git.daniel@makrotopia.org>
 <aa957c759b1182aee00cc35178667f849f941b42.1674012985.git.daniel@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <aa957c759b1182aee00cc35178667f849f941b42.1674012985.git.daniel@makrotopia.org>
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

Il 18/01/23 04:55, Daniel Golle ha scritto:
> Add support for V3 generation thermal found in MT7986 and MT7981 SoCs.
> Brings code to assign values from efuse as well as new function to
> convert raw temperature to millidegree celsius, as found in MediaTek's
> SDK sources (but cleaned up and de-duplicated)
> 
> [1]: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/baf36c7eef477aae1f8f2653b6c29e2caf48475b
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>   drivers/thermal/mtk_thermal.c | 137 ++++++++++++++++++++++++++++++++--
>   1 file changed, 132 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 992750ee09e62..171f485a809bb 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c

..snip..

>   		.data = (void *)&mt8183_thermal_data,
> @@ -1068,15 +1186,24 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   		goto err_disable_clk_auxadc;
>   	}
>   
> -	if (mt->conf->version == MTK_THERMAL_V2) {
> +	if (mt->conf->version != MTK_THERMAL_V1) {
>   		mtk_thermal_turn_on_buffer(apmixed_base);
>   		mtk_thermal_release_periodic_ts(mt, auxadc_base);
>   	}
>   
> -	if (mt->conf->version == MTK_THERMAL_V1)
> +	switch (mt->conf->version) {
> +	case MTK_THERMAL_V1:
>   		mt->raw_to_mcelsius = raw_to_mcelsius_v1;
> -	else
> +		break;
> +	case MTK_THERMAL_V2:
>   		mt->raw_to_mcelsius = raw_to_mcelsius_v2;
> +		break;
> +	case MTK_THERMAL_V3:
> +		mt->raw_to_mcelsius = raw_to_mcelsius_v3;
> +		break;
> +	default:
> +		break;
> +	}

Either directly use a switch in your commit [1/2] or follow `else if` here.

I would prefer if you changed your first commit to use a switch, but I don't
really have strong opinions, which is why I gave you a Reviewed-by tag on
[1/2].

Your choice - but please don't "change the game" all of a sudden in a commit
whose purpose is to add support for a new version of MTK_THERMAL. :-)

Cheers,
Angelo

