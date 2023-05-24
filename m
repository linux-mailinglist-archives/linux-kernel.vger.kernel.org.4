Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0231070F818
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbjEXNyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbjEXNy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:54:29 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E1CA7;
        Wed, 24 May 2023 06:54:28 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 770C38467A;
        Wed, 24 May 2023 15:54:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1684936466;
        bh=H9hgBK0Z2k4KJJri9AujHyxs0n8pT/bxbNuwzwsiCD8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BKJc/stDc1RkyJLgAWaetW9Omb0UyyG8moL/uAoBsi7B6NkeSYbJmzq5bv4tjoqEI
         iD0CMkZAqmHD2fcHv9bxLxF+IcmC52hpehwWsB8qjwWbsNWNhvAf5dr+F4i3GL2gqd
         szo2JC9cePe9cIQOzIpdM9ee4rLAPgD6+CsYfyWj2KukDenhhiRtBjpjsptgFgE9uu
         74HFFLZGdJsPhIKDmy/68A72hObbwJHnDturWRDNABjc3K+ociAHFCWZ/xUj32jogC
         KPRUxRMMBcvX5PCandiuEAiuy4aFLFKuknILFRb0Czqa1kUj1Tk1/3VoKjxI5HYWJ9
         ea1pBJgPn2dOg==
Message-ID: <cc7a0a1a-31bb-92f4-6365-5e0c4a4bc85c@denx.de>
Date:   Wed, 24 May 2023 15:54:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 7/8] ARM: dts: stm32: adopt generic iio bindings for adc
 channels on dhcor-drc
Content-Language: en-US
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     kernel@dh-electronics.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230524133918.1439516-1-olivier.moysan@foss.st.com>
 <20230524133918.1439516-8-olivier.moysan@foss.st.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230524133918.1439516-8-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/23 15:39, Olivier Moysan wrote:
> Use STM32 ADC generic bindings instead of legacy bindings on
> DHCOR DRC Compact board.
> 
> The STM32 ADC specific binding to declare channels has been deprecated,
> hence adopt the generic IIO channels bindings, instead.
> The STM32MP151 device tree now exposes internal channels using the
> generic binding. This makes the change mandatory here to avoid a mixed
> use of legacy and generic binding, which is not supported by the driver.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>   .../dts/stm32mp15xx-dhcor-drc-compact.dtsi    | 28 ++++++++++++++++---
>   1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi
> index 39af79dc654c..92d906bfd5d7 100644
> --- a/arch/arm/boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi
> @@ -57,15 +57,35 @@ &adc {	/* X11 ADC inputs */
>   	status = "okay";
>   
>   	adc1: adc@0 {


I sent similar patch recently too:

[PATCH] ARM: dts: stm32: Update to generic ADC channel binding on DHSOM 
systems

But I needed to add #address-cells/#size-cells here and to adc@100, 
otherwise DTB checker was complaining . Did you run DTB check and was it 
OK on your side ?

> -		st,adc-channels = <0 1 6>;
> -		st,min-sample-time-nsecs = <5000>;
>   		status = "okay";
> +		channel@0 {
> +			reg = <0>;
> +			st,min-sample-time-ns = <5000>;
> +		};
> +		channel@1 {
> +			reg = <1>;
> +			st,min-sample-time-ns = <5000>;
> +		};
> +		channel@6 {
> +			reg = <6>;
> +			st,min-sample-time-ns = <5000>;
> +		};
>   	};

[...]
