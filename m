Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B4766BD78
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjAPMGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjAPMG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:06:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8798C1ABFE;
        Mon, 16 Jan 2023 04:06:28 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8AC37660035A;
        Mon, 16 Jan 2023 12:06:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673870787;
        bh=yHR1rnQBHPsnUcjrAlXmmewlqZnVelc/M9hoJD2YZ7s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mP+c1p5kIStdMYgRCtoDoTqhh7t3qaDfuXmAWSjwVkevbm0kOJ4SGtk2BcD26TBvg
         /woqsIieFDLYga48oaOaxH8BuWL5ptuDlmnPB9HMZKwqTnj33TNSRCHuKS/oF5xw5K
         BG1ymj4QP65EyQK2lgoTtjxyAHRpTnUEFg4lb+5pBgekeIFUhEOR9KwkszHzwPenT6
         vpdr/HkXleBJe7eO8feCeV+hWxa/FRTfk/HKiNHGp8XsaEbNLs+fTWi/mIE96ql9Rk
         WzKdiZ5wZzEgpAMIei4y+qwjfEW8Uzb/U3D/FsltkICj2O8YVf93rrMcxHkz3WRjD3
         K24BND5awdkTg==
Message-ID: <366d06e5-11d7-7e1f-0ed6-4f370496d338@collabora.com>
Date:   Mon, 16 Jan 2023 13:06:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/2] dt-bindings: watchdog: mtk-wdt: Add
 reset-by-toprgu support
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230116105305.31818-1-allen-kh.cheng@mediatek.com>
 <20230116105305.31818-2-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230116105305.31818-2-allen-kh.cheng@mediatek.com>
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

Il 16/01/23 11:53, Allen-KH Cheng ha scritto:
> In some applications, the mtk-wdt requires the toprgu (TOP Reset
> Generation Unit) to reset timer after system resets. Add optional
> mediatek,reset-by-toprgu property to enable it.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   .../devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml      | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> index b3605608410c..b4de6b134ce1 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -52,6 +52,12 @@ properties:
>       description: Disable sending output reset signal
>       type: boolean
>   
> +  mediatek,reset-by-toprgu:
> +    description: The top reset generate unit (toprgu) generates reset signals

TOPRGU = Top Reset Generation Unit

Please fix the description...

The Top Reset Generation Unit (TOPRGU) generate reset signals
and distributes them to each IP. If present, the watchdog timer
will be reset by TOPRGU once system resets.

Apart from that:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

