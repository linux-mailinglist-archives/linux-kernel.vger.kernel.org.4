Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094B5667AD7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjALQad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbjALQ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:29:57 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB96CD9;
        Thu, 12 Jan 2023 08:28:42 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 7134985405;
        Thu, 12 Jan 2023 17:28:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1673540920;
        bh=EN/egfl+RWRqGe9kuXZHtWvRoQNrYeHrMo8CDmwf6F4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=0Q4jfY2yYtG5HdyWahg+92OTb31gYfMv6vcvF64Pd/GI0aBfwgtWZKuKRLeYJJjun
         fgjMv12XeRP4lG0iIwhaEHmY3AvDDwxhzIYYdHpMG6DvgwLpRY49M+gHZbBCqS9sqb
         s/GfevAwIngULX4SiKMm8r0Njs1KI9Hke6JWQ2zf3U9KQ+S2l946D/vVIdqLMoS5tS
         S1JJHanv2zVO5582Sd9ffX35Br0+r7T8JlRqqBde0i9lIRUkYNLnYCeO5EQDwOSKpu
         9Q3S5zBweUXKbeesZSzvfdJyrPDkYEjvw6jAkjR29OZPOoSdysIBsuq2QvWLVhkqoS
         5x/szUwajA8bg==
Message-ID: <bc75d243-b2dc-6192-1b93-0a15d3fe5639@denx.de>
Date:   Thu, 12 Jan 2023 15:28:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 06/10] ARM: dts: stm32: adopt generic iio bindings for adc
 channels on avenger96
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     kernel@dh-electronics.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230112104446.1140551-1-olivier.moysan@foss.st.com>
 <20230112104446.1140551-7-olivier.moysan@foss.st.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230112104446.1140551-7-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/23 11:44, Olivier Moysan wrote:
> Use STM32 ADC generic bindings instead of legacy bindings on
> Avenger96 board.
> 
> The STM32 ADC specific binding to declare channels has been deprecated,
> hence adopt the generic IIO channels bindings, instead.
> The STM32MP151 device tree now exposes internal channels using the
> generic binding. This makes the change mandatory here to avoid a mixed
> use of legacy and generic binding, which is not supported by the driver.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>   .../boot/dts/stm32mp15xx-dhcor-avenger96.dtsi | 28 ++++++++++++++++---
>   1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
> index 50af4a27d6be..62efb550ae64 100644
> --- a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
> @@ -113,15 +113,35 @@ &adc {
>   	status = "okay";
>   
>   	adc1: adc@0 {
> -		st,adc-channels = <0 1 6>;
> -		st,min-sample-time-nsecs = <5000>;

U-Boot drivers/adc/stm32-adc.c depends on these properties , so if you 
drop them here and U-Boot DTs gets synced with Linux, the ADC driver 
there will start failing. Can you update the U-Boot ADC driver too ?

Maybe the easiest way would be to retain the old properties for now with 
a comment, and add the new properties ?
