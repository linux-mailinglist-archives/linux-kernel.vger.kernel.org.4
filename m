Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9C1653E52
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbiLVKak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiLVKab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:30:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5671920998;
        Thu, 22 Dec 2022 02:30:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDD16B81D1B;
        Thu, 22 Dec 2022 10:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988A2C433D2;
        Thu, 22 Dec 2022 10:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671705023;
        bh=vUcSd9J2/pd1O0FG8ub/N5/m3MO3FZNyWwtsGOBo2Ww=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JJlDCVl2gTQ5OkZojlxa+xBwc1t19Hs+3PB2smEQ6GYOOZmoeQ2Yh00SE9ZqGvj32
         rXZphqCK/ZRYj/NUVTpMWGb2MvZL6cUUKCuVypiS+S171wVj8wJt7+3XL6s6tFWeFO
         Q+REsvNpj+th4kooz1Att2S+2BDdyAYhBnNjmcbgvz/nsz//NL99xKZykvodqslrl6
         Jm35ssvPtb77Z/BzIWZFSt7q9goQAFfaD1VuQpimS7XpiEf30P6H4OYqeLYnWaQQ7p
         qCV0Pv8kvO57I5pjPD63mut1owm7i5oKV11HFMY904xn/P1IuviL3hkUsZP3YTZHCC
         3+ij9OO/A+2KQ==
Message-ID: <2e7c901c-e322-ded6-b170-6d2436d74c0f@kernel.org>
Date:   Thu, 22 Dec 2022 11:30:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 6/7] ARM: dts: stm32: add ETZPC as a system bus for
 STM32MP15x boards
Content-Language: en-US
To:     Gatien Chevallier <gatien.chevallier@foss.st.com>,
        alexandre.torgue@foss.st.com, robh+dt@kernel.org,
        Oleksii_Moisieiev@epam.com, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        loic.pallardy@st.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, arnd@arndb.de
References: <20221221173055.11719-1-gatien.chevallier@foss.st.com>
 <20221221173055.11719-7-gatien.chevallier@foss.st.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221221173055.11719-7-gatien.chevallier@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 18:30, Gatien Chevallier wrote:
> The STM32 System Bus is an internal bus on which devices are connected.
> ETZPC is a peripheral overseeing the firewall bus that configures
> and control access to the peripherals connected on it.
> 
> For more information on which peripheral is securable, please read
> the STM32MP15 reference manual.
> 
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
>  arch/arm/boot/dts/stm32mp151.dtsi | 2737 +++++++++++++++--------------
>  1 file changed, 1406 insertions(+), 1331 deletions(-)
>  
> -		lptimer1: timer@40009000 {
> +		etzpc: etzpc@5c007000 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +			compatible = "st,stm32mp15-sys-bus";
> +			reg = <0x5c007000 0x400>;
>  			#address-cells = <1>;
> -			#size-cells = <0>;
> -			compatible = "st,stm32-lptimer";
> -			reg = <0x40009000 0x400>;
> -			interrupts-extended = <&exti 47 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&rcc LPTIM1_K>;
> -			clock-names = "mux";
> -			wakeup-source;
> -			status = "disabled";

Why entire bus is disabled? What resources do you miss?

> +			#size-cells = <1>;
> +			feature-domain-controller;
> +			#feature-domain-cells = <2>;
> +			ranges;
>  
Best regards,
Krzysztof

