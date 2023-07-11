Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF0374E700
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjGKGOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjGKGOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:14:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3861E5;
        Mon, 10 Jul 2023 23:14:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E6BD6132D;
        Tue, 11 Jul 2023 06:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4947DC433C8;
        Tue, 11 Jul 2023 06:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689056044;
        bh=OX+EN9qbWJzWqP/kGmkt0uY4vfp67tjShrtEo3vYIIs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XHcBvWqqsh7Y/fCXX+ln3tRKqpaTOfV7QFUKmY0Z4YHGpV+NhQLCAY4cdZI23ruHi
         W9CFe8hSqcGwczouqGiLmr8f43f2Utzg5fSvzYLisoobL+zCYv/wy98p8wUoz3QYv4
         4n9XddiPtuFKdmapWP43qzI5xeFzn8ehyngy+KMrdsbdtfhUQw00d1o1sQga/64v3z
         4P4hG6aiJsyY+iq6QlvA6AbUTlAQv+4QiS28YlRd6TStwI22re/xO4GQAiYO3M5vyj
         cp4YFXUYJNGbqQusxqTYDGjToyBF8BEnDvebrxUKo8lDGfI9pEIotFmWep2UUYi61K
         9AUJW4mzRXafw==
Message-ID: <02fe7c1e-cb6a-14bc-73fc-04956a2b8396@kernel.org>
Date:   Tue, 11 Jul 2023 08:13:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] arm64: dts: qcom: msm8916-samsung-serranove: Add
 RT5033 PMIC with charger
Content-Language: en-US
To:     Jakob Hauser <jahau@rocketmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230619203743.8136-1-jahau.ref@rocketmail.com>
 <20230619203743.8136-1-jahau@rocketmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230619203743.8136-1-jahau@rocketmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2023 22:37, Jakob Hauser wrote:
> For the regulators, apply the same settings as in the downstream
> devicetree [1], including the "regulator-always-on" for the SAFE_LDO.
> For the voltage of SAFE_LDO, however, there is only one voltage of 4.9 V
> available in the mainline driver [2][3].
> 
> The values of the battery data evolve from following sources:
> - precharge current: 450 mA corresponds to the default value of the chip. It
>   doesn't get changed by the downstream Android driver. Therefore let's stick
>   to this value.
> - constant charge current: The 1000 mA are taken from the downstream devicetree
>   of the serranove battery. It's not easy to spot. The value is in the line
>   "input_current_limit" [4]. The rows are according to the power supply type,
>   the 4th value stands for "main supply" [5]. That's the value used by the
>   Android driver when a charging cable is plugged into the device.
> - charge termination current: In the downstream devicetree of the battery
>   that's the line "full_check_current_1st", which contains the 150 mA [6].
> - precharge voltage: This one doesn't get set in the downstream Android driver.
>   The chip's default is 2.8 V. That seemed too low to have a notable effect of
>   handling the battery gentle. The chosen value of 3.5 V is a bit arbitrary
>   and possibly rather high. As the device is already several years old and
>   therefore most batteries too, a value on the safe side seems reasonable.
> - constant charge voltage: The value of 4.35 V is set in the line
>   "chg_float_voltage" of the downstream battery devicetree [7].
> 
> The "connector" sub-node in the extcon node, the "battery" node in the
> general section and the line "power-supplies" in the fuel-gauge node result
> from the way of implementation documented in the dt-bindings of
> rt5033-charger [8] and mfd rt5033 [9].
> 
> [1] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/arch/arm/boot/dts/samsung/msm8916/msm8916-sec-serranovelte-eur-r03.dtsi#L135-L181
> [2] https://github.com/torvalds/linux/blob/v6.3/include/linux/mfd/rt5033-private.h#L211-L212
> [3] https://github.com/torvalds/linux/blob/v6.3/drivers/regulator/rt5033-regulator.c#L83
> [4] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/arch/arm/boot/dts/samsung/msm8916/msm8916-sec-serranovelte-battery-r01.dtsi#L100
> [5] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/include/linux/power_supply.h#L173-L177
> [6] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/arch/arm/boot/dts/samsung/msm8916/msm8916-sec-serranovelte-battery-r01.dtsi#L102
> [7] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/arch/arm/boot/dts/samsung/msm8916/msm8916-sec-serranovelte-battery-r01.dtsi#L95
> [8] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml?h=next-20230616
> [9] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml?h=next-20230616
> 
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
> The patch is based on linux-next "next-20230616".
> 
> The driver rt5033-charger was just recently added to linux-next.

This appeared in today's next next-20230711 and causes new warnings

msm8916-samsung-serranove.dtb: extcon@14: 'connector' does not match any
of the regexes: 'pinctrl-[0-9]+'
https://krzk.eu/#/builders/90/builds/40/steps/17/logs/stdio

The commit mentions rt5033, but that is not the schema being here
tested, so clearly this is wrong or bindings were not updated.

Please fix (and test your future patches).

Best regards,
Krzysztof

