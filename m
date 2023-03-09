Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A176B1B3A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCIGPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCIGPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:15:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91224C9A4E;
        Wed,  8 Mar 2023 22:15:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB203B81DEC;
        Thu,  9 Mar 2023 06:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BC6C433EF;
        Thu,  9 Mar 2023 06:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678342541;
        bh=S5+pdx69OCp0NpUvVJzuTRg/Jd7567+ywNHesio5JsQ=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=DV8Fr2LZYj25xMrNlhFvABHT/o2gO9E+ebdYhft3HIZuCTCFNPkcRIf5F8NImnHGH
         pp7aZmmtFnbMn1aQgWmA6QOC125bYu/HcFWrSbbyacfEnDTXAnoys6OzIuspN5imXW
         IXHh2kNbGTc9h3btOTfad+EohSXDc9yckTTmCmNySm5OSij2dchaWVxPf8V50d7fY/
         F412C6D4pCrHzF9KZjlQYSf6nVB3qIYmiUyVmec2MtU+guaFpKHFkHkXp9XC8se5Z+
         PHUmm4m0l6KXGRSsIvyvCRJ04F21YqzK9nUQHZWodIxsb94pApeuaadJSwio4ByKuW
         cG8bckkhPn2XQ==
Message-ID: <7b269c9f-803e-69d6-9416-1620e1726e7e@kernel.org>
Date:   Thu, 9 Mar 2023 07:15:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2 6/6] arm64: tegra: Add GTE nodes
Content-Language: en-US
To:     Dipen Patel <dipenp@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev
References: <20230214115553.10416-1-dipenp@nvidia.com>
 <20230214115553.10416-7-dipenp@nvidia.com>
 <16e3ddb4-219e-70a8-8644-c62973f84d31@kernel.org>
 <ef58cd61-f90d-f242-9923-e9544d1aa963@nvidia.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <ef58cd61-f90d-f242-9923-e9544d1aa963@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 21:13, Dipen Patel wrote:
> On 2/16/23 6:18 AM, Krzysztof Kozlowski wrote:
>> On 14/02/2023 12:55, Dipen Patel wrote:
>>> Add GTE nodes for the tegra234. Also modify AON GTE nodes for the
>>> tegra194 to remove nvidia,slice property and add nvidia,gpio-controller
>>> propertyto specify AON GPIO controller node so that GTE driver can
>>> do namespace conversion between GPIO lines provided by the gpiolib
>>> framework and hardware timestamping engine subsystem.
>>>
>>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>>> ---
>>>  arch/arm64/boot/dts/nvidia/tegra194.dtsi |  3 +--
>>>  arch/arm64/boot/dts/nvidia/tegra234.dtsi | 19 +++++++++++++++++++
>>>  2 files changed, 20 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>>> index 4afcbd60e144..4c92850b1ec4 100644
>>> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>>> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>>> @@ -1363,7 +1363,6 @@
>>>  			reg = <0x3aa0000 0x10000>;
>>>  			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>>>  			nvidia,int-threshold = <1>;
>>> -			nvidia,slices = <11>;
>>>  			#timestamp-cells = <1>;
>>>  			status = "okay";
>>>  		};
>>> @@ -1586,7 +1585,7 @@
>>>  			reg = <0xc1e0000 0x10000>;
>>>  			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>>>  			nvidia,int-threshold = <1>;
>>> -			nvidia,slices = <3>;
>>> +			nvidia,gpio-controller = <&gpio_aon>;
>>>  			#timestamp-cells = <1>;
>>>  			status = "okay";
>>>  		};
>>> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>>> index eaf05ee9acd1..4a87490c5fd4 100644
>>> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>>> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>>> @@ -1086,6 +1086,15 @@
>>>  			clock-names = "fuse";
>>>  		};
>>>  
>>> +		hte_lic: hardware-timestamp@3aa0000 {
>>> +			compatible = "nvidia,tegra234-gte-lic";
>>> +			reg = <0x3aa0000 0x10000>;
>>> +			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>>> +			nvidia,int-threshold = <1>;
>>> +			#timestamp-cells = <1>;
>>> +			status = "okay";
>>
>> Why do you need status? It's okay by default.
> what's harm of having to explicitly mentioned? 

Because useless code is not helping any review. We do not add other
useless properties, or shall we add them?

>I can see status = okay in this dtsi file
> for other nodes as well and was just following that.

So if you see a bug somewhere, you also duplicate it in your code?


Best regards,
Krzysztof

