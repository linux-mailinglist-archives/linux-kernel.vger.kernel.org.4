Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA9F6D0944
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjC3PTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjC3PTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:19:10 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E22CDC8;
        Thu, 30 Mar 2023 08:18:08 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 9596F24DEAE;
        Thu, 30 Mar 2023 23:16:09 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 30 Mar
 2023 23:16:09 +0800
Received: from [192.168.125.96] (113.72.144.76) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 30 Mar
 2023 23:16:08 +0800
Message-ID: <2d5a8dae-73fd-b1f8-089e-041637d66b0d@starfivetech.com>
Date:   Thu, 30 Mar 2023 23:16:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 3/3] riscv: dts: starfive: add tdm node and sound card
To:     Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20230329153320.31390-1-walker.chen@starfivetech.com>
 <20230329153320.31390-4-walker.chen@starfivetech.com>
 <d455a90a-7e63-2254-75cb-70cb26ae7483@linaro.org>
 <af015701-f1ff-4b1e-9b1b-c635fc684ce6@spud>
Content-Language: en-US
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <af015701-f1ff-4b1e-9b1b-c635fc684ce6@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.76]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/30 15:58, Conor Dooley wrote:
> On Thu, Mar 30, 2023 at 09:43:10AM +0200, Krzysztof Kozlowski wrote:
>> On 29/03/2023 17:33, Walker Chen wrote:
>> > Add the tdm controller node and sound card for the StarFive JH7110 SoC.
> 
>> > +		compatible = "fixed-clock";
>> > +		clock-output-names = "wm8960_mclk";
>> > +		#clock-cells = <0>;
>> > +	};
>> > +
>> >  	i2srx_bclk_ext: i2srx-bclk-ext-clock {
>> >  		compatible = "fixed-clock";
>> >  		clock-output-names = "i2srx_bclk_ext";
>> > @@ -375,6 +381,27 @@
>> >  			status = "disabled";
>> >  		};
>> >  
>> > +		tdm: tdm@10090000 {
>> > +			compatible = "starfive,jh7110-tdm";
>> > +			reg = <0x0 0x10090000 0x0 0x1000>;
>> > +			clocks = <&syscrg JH7110_SYSCLK_TDM_AHB>,
>> > +				 <&syscrg JH7110_SYSCLK_TDM_APB>,
>> > +				 <&syscrg JH7110_SYSCLK_TDM_INTERNAL>,
>> > +				 <&syscrg JH7110_SYSCLK_TDM_TDM>,
>> > +				 <&syscrg JH7110_SYSCLK_MCLK_INNER>,
>> > +				 <&tdm_ext>;
>> > +			clock-names = "tdm_ahb", "tdm_apb",
>> > +				      "tdm_internal", "tdm",
>> > +				      "mclk_inner", "tdm_ext";
>> > +			resets = <&syscrg JH7110_SYSRST_TDM_AHB>,
>> > +				 <&syscrg JH7110_SYSRST_TDM_APB>,
>> > +				 <&syscrg JH7110_SYSRST_TDM_CORE>;
>> > +			dmas = <&dma 20>, <&dma 21>;
>> > +			dma-names = "rx","tx";
>> > +			#sound-dai-cells = <0>;
>> > +			status = "disabled";
>> > +		};
>> > +
>> >  		stgcrg: clock-controller@10230000 {
>> >  			compatible = "starfive,jh7110-stgcrg";
>> >  			reg = <0x0 0x10230000 0x0 0x10000>;
>> > @@ -601,5 +628,12 @@
>> >  			#reset-cells = <1>;
>> >  			power-domains = <&pwrc JH7110_PD_VOUT>;
>> >  		};
>> > +
>> > +		sound0: snd-card0 {
>> 
>> 1. Why card0?
>> 2. Where is this node located? In MMIO bus? Run some basic checks on
>> your DTS before submitting upstream.
>> dtbs_check
>> dtbs W=1
>> 
>> 3. Why this is even in the DTSI? This really looks wrong.
> 
> Excuse me for not following here, but Walker, could you point me at
> where in the schematic for the VisionFive 2 that this wm8960 actually
> is?
> I know ~nothing about audio, but good old Google tells me that this is a
> dedicated codec chip and I was looking at [1] and could not easily find
> it on the schematic.
> 
> Thanks,
> Conor.
> 
> 1 https://doc-en.rvspace.org/VisionFive2/PDF/SCH_RV002_V1.2A_20221216.pdf

Hi Conor,

The TDM need work together with external codec WM8960 by plugging the raspberry pie
 audio board into the 40-pin, which is found in sheet 21 of the schematic. Because the
 40-pin of VisionFive2 is fully compatible with the pins of Raspberry pie audio board. 

For more information of the audio board, you can take a look at the following webpage:
https://wiki.seeedstudio.com/ReSpeaker_2_Mics_Pi_HAT/

The schematic of audio board:
https://files.seeedstudio.com/wiki/MIC_HATv1.0_for_raspberrypi/src/ReSpeaker%202-Mics%20Pi%20HAT_SCH.pdf

Best regards,
Walker
