Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9853D65C054
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbjACMyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjACMtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:49:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA38D30C;
        Tue,  3 Jan 2023 04:49:40 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A2BB56602CF4;
        Tue,  3 Jan 2023 12:49:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672750179;
        bh=8ji9uM0rPrYHIz3P734RsmkYAcXteBVac3pmsXFW90Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n6G0SNZjtaBdV/0/2Fd7PbL6pO+oO5JW0vDldxzUZnOI8gHX8lJ/Wx/uX0mxAjmJp
         OZrxOV6gtRankj1cdmrQ+kKsUDtV2DiWe626RinwkegpPV7iaTicYmbYaUtwd0on3w
         bXEAzTRbbxZaybjJg0o5JsmAT/He8PPj1HLIM4Pyi/2OV3UeMcQjGsMtN9a62cYSVw
         Rgi4RkDum2H+Xxrk1TFz+zvBw05dWj/+w7f+sktffPBao72r69/l1GDV72/+ALTyXE
         6slxPKIpLjNW70nc8hxFwgaIfh7P9IXeqVLkmCQZCjVFQS4gR3sBPuH/rZdc46nuX/
         OkAls005mxgMg==
Message-ID: <2f4a78f8-9cdd-9e44-20a2-b3bd6abd5cc7@collabora.com>
Date:   Tue, 3 Jan 2023 13:49:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 13/13] soc: mediatek: mtk-svs: keep svs alive even
 though debug cmd create fail
Content-Language: en-US
To:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221226094248.4506-1-roger.lu@mediatek.com>
 <20221226094248.4506-14-roger.lu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221226094248.4506-14-roger.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/12/22 10:42, Roger Lu ha scritto:
> Some projects might not support DEBUG_FS but still needs svs to be
> supported. Therefore, keep svs alive even though debug cmd create fail.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-svs.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index af3a12e29e78..c780a115543e 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -2390,10 +2390,8 @@ static int svs_probe(struct platform_device *pdev)
>   	}
>   

Instead of ignoring a planned failure, it's sensible to not fail at all:
enclose this call and the svs_create_debug_cmds() function in an ifdef.

#ifdef CONFIG_DEBUG_FS

>   	ret = svs_create_debug_cmds(svsp);
> -	if (ret) {
> +	if (ret)
>   		dev_err(svsp->dev, "svs create debug cmds fail: %d\n", ret);
> -		goto svs_probe_iounmap;
> -	}

#endif

>   
>   	return 0;
>   
> 

Regards,
Angelo


