Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6536A9671
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjCCLfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjCCLfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:35:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEBB9742;
        Fri,  3 Mar 2023 03:35:25 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 816886600013;
        Fri,  3 Mar 2023 11:35:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677843324;
        bh=eu7pJNx6dKERWOaTwlpIsno1hA3wEiySMHvMfeJYE70=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OWAWMphgfQ/q3vgZj4XMqZ9atH2LP76OvMbrjwHXlP8Bw57UJoVPgLvwWjSEJ5bn2
         p9tECf31NmQdbXNd94Uckl00o5aVSbd8/DteemZXQLDLMDq6Sf9LDD9fPh2TBJNZWn
         P0zPSzRSzrubuVLANG0HfOU2l4VgTcP8LLHqIvs4Qw/XpxAx7Hxo3TXPTjUOFNIWLx
         3eJPUCLV7MU56ifslMGhiXd6YUJOHCqdRE3sbIR9kUEIOGvbt5+5TpBqXhSRfXnRcv
         XLQ6XGmx21zEbfP1NOnRp5m0Zz4pLvWrQGnZoOvc5hZlvDADapx11K05RKy0mRPNDJ
         Sxzf45sVe0lSQ==
Message-ID: <8fb0176f-5587-e446-a084-05bd0572f2de@collabora.com>
Date:   Fri, 3 Mar 2023 12:35:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 7/7] arm64: dts: mediatek: mt8186: Add display nodes
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org
References: <20230303031728.24251-1-allen-kh.cheng@mediatek.com>
 <20230303031728.24251-8-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230303031728.24251-8-allen-kh.cheng@mediatek.com>
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

Il 03/03/23 04:17, Allen-KH Cheng ha scritto:
> Add display nodes and the GCE (Global Command Engine) properties
> to the display nodes in order to enable the usage of the CMDQ
> (Command Queue), which is required for operating the display.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 125 +++++++++++++++++++++++
>   1 file changed, 125 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index b9d5af26771e..909f1a6ae108 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -20,6 +20,13 @@
>   	#address-cells = <2>;
>   	#size-cells = <2>;
>   
> +	aliases {
> +		ovl = &ovl;

Are you sure that this alias shouldn't be `ovl0 = &ovl` instead?

> +		ovl_2l= &ovl_2l;

And this `ovl_2l0 = &ovl_2l` ?

Everything else looks good.

Regards,
Angelo

