Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D266172827F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbjFHOTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjFHOTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:19:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902901730;
        Thu,  8 Jun 2023 07:19:01 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E45726606EC6;
        Thu,  8 Jun 2023 15:18:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686233940;
        bh=EY/Cv+BYzvq4HCOJOX2J805Hf5LJ5niFUoHwigfrkP4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mmWaOXwv2awwKmTlM0y4Hgladq081m791POg6DvoFJVWcrMtq+lHgb+npqE0ZhEVL
         76Rn7K59zwEvcWcH4KkzV7KOrmns970zFDAw1PL+KTSy/VXKzX4TB8dI12No52fNrY
         2WrxPGhPaYCZzIk8NsCLaOl90L3gM+qiy7ZRUxPq0j3QbgNk0NF8deQZvTvI4oaRqH
         F8yKKj4hKX7KmTDZ1+uzot3014eJe06arvZ4jFquQAGuxCigvetuzM/i+l+V5PGjdY
         N18R59I+d6T3IpBTSoy+WPaR0p+IHrQkKJKsUpnhhMzXjDSJZACiwntwSj7Stq92Q+
         Dp1kDQtf2aeXg==
Message-ID: <6d5bd11c-6f57-adc9-b35c-78cb80882d52@collabora.com>
Date:   Thu, 8 Jun 2023 16:18:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/4] arm64: dts: mediatek: mt8186: Wire up CPU
 frequency/voltage scaling
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230607090653.2468317-1-wenst@chromium.org>
 <20230607090653.2468317-3-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230607090653.2468317-3-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/06/23 11:06, Chen-Yu Tsai ha scritto:
> This adds clocks, dynamic power coefficients, and OPP tables for the CPU
> cores, so that everything required at the SoC level for CPU freqency and
> voltage scaling is available.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 274 +++++++++++++++++++++++
>   1 file changed, 274 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index 1b754f7a0725..6735c1feb26d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -136,6 +136,240 @@ cci_opp_15: opp-1400000000 {
>   		};
>   	};
>   
> +	cluster0_opp: opp-table-cluster0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-500000000 {
> +			opp-hz = /bits/ 64 <500000000>;
> +			opp-microvolt = <600000>;
> +			opp-level = <15>;

As far as I remember we don't need opp-level, can you please recheck that
and in case remove the levels from all OPPs?

Thanks,
Angelo


