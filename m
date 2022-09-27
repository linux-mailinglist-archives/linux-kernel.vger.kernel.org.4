Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08CA5ECBA2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiI0Rtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiI0RtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:49:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA66A1057A;
        Tue, 27 Sep 2022 10:47:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29A271042;
        Tue, 27 Sep 2022 10:47:49 -0700 (PDT)
Received: from [10.57.65.170] (unknown [10.57.65.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 026E43F73B;
        Tue, 27 Sep 2022 10:47:40 -0700 (PDT)
Message-ID: <e75cc292-ff7a-0daa-e2f9-fde376b5e26e@arm.com>
Date:   Tue, 27 Sep 2022 18:47:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH-next v1] arm64: dts: rockchip: Enable NVM Express PCIe
 controller on rock3a
Content-Language: en-GB
To:     Anand Moon <linux.amoon@gmail.com>, Chukun Pan <amadeus@jmu.edu.cn>
Cc:     heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        michael.riesch@wolfvision.net, robh+dt@kernel.org
References: <20220926061420.1248-1-linux.amoon@gmail.com>
 <20220926180102.37614-1-amadeus@jmu.edu.cn>
 <CANAwSgTyt2D-aEMMowO6d+0ddTQb46o0pWMahnr7ny2rjY7iaQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CANAwSgTyt2D-aEMMowO6d+0ddTQb46o0pWMahnr7ny2rjY7iaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-27 14:46, Anand Moon wrote:
> Hi Chukun,
> 
> On Mon, 26 Sept 2022 at 23:31, Chukun Pan <amadeus@jmu.edu.cn> wrote:
>>
>> Hi,
>>
>> On 26-09-22, 06:14, Anand Moon wrote:
>>
>>> +     pcie30_3v3: gpio-regulator {
>>> +             compatible = "regulator-gpio";
>>> +             regulator-name = "pcie30_3v3";
>>> +             regulator-min-microvolt = <100000>;
>>> +             regulator-max-microvolt = <3300000>;
>>> +             gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
>>> +             gpios-states = <0x1>;
>>> +             states = <100000 0x0>, <3300000 0x1>;
>>> +     };
>>
>> This is actually no different from vcc3v3-pcie regulator?
>>
>>> +&pcie30phy {
>>> +     data-lanes = <0 1 2 3>;
>>> +     phy-supply = <&vcc3v3_pi6c_03>;
>>> +     status = "okay";
>>> +};
>>
>> It seems that there is no need to define additional data-lanes when
>> the pcie3x1 node is not enabled, and phy-supply seems unnecessary on
>> this board.
>>
> As per the schematic below pice support with 2 regulators
> 
> VCC3V3_PCIE        (SCT2250FPA)
> VCC3V3_PI6C_03  (PI6C557-03 is a spread spectrum clock generator
> supporting PCI Express and Ethernet requirements)

Neither of which have anything to do with the phy, which is in the SoC 
and runs off VDDA_0V9 and VCCA_1V8, see page 12. VCC3V3_PCIE is the 
general power supply for the M.2 socket, which I doubt is supposed to 
deliver 100mV when disabled.

(as a side note, is pcie2x1's vpcie3v3-supply as queued in -next 
actually correct? AFAICS the other socket is effectively powered 
straight from VCC3V3_SYS so shouldn't have needed VCC3V3_PCIE, but at 
least it's there now ready for this one)

Robin.

> 
> [0] https://dl.radxa.com/rock3/docs/hw/3a/rock3a_v1.3_sch.pdf
> 
>> Excuse me, can you try the patches I posted? Lspci can recognize
>> pcie3x2 normally, but I don't have a spare nvme hard drive right
>> now to test if it works.
>>
> 
> No, it did not work on my board, see bool logs.
> [0] https://pastebin.com/Lk93VFxg
> 
> [ 0.725985] phy phy-fe8c0000.phy.4: lane number 0, val 1
> [ 0.726975] phy phy-fe8c0000.phy.4: rockchip_p3phy_rk3568_init: lock
> failed 0x6890000, check input refclk and power supply
> [ 0.728172] phy phy-fe8c0000.phy.4: phy init failed --> -110
> [ 0.728704] rockchip-dw-pcie: probe of 3c0800000.pcie failed with error -110
> [ 0.745193] ALSA device list:
> 
> Thanks
> -Anand
> 
>> Thanks, Chukun
>>
>> ---
>> Chukun Pan (3):
>>    arm64: dts: rockchip: Add regulator suffix to ROCK3 Model A
>>    arm64: dts: rockchip: Rename pinctrl label of pcie2x1 on rock-3a
>>    arm64: dts: rockchip: Add PCIe v3 nodes to rock-3a
>>
>>   .../boot/dts/rockchip/rk3568-rock-3a.dts      | 36 ++++++++++++++-----
>>   1 file changed, 27 insertions(+), 9 deletions(-)
>>
>> --
>> 2.25.1
>>
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
