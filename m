Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B1962D89E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239567AbiKQK4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKQK4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:56:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B5275C759;
        Thu, 17 Nov 2022 02:54:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CAB9D6E;
        Thu, 17 Nov 2022 02:54:25 -0800 (PST)
Received: from [10.57.69.157] (unknown [10.57.69.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 257C73F73B;
        Thu, 17 Nov 2022 02:54:17 -0800 (PST)
Message-ID: <99849c5e-5bd9-386b-99c5-fbc8c8df9656@arm.com>
Date:   Thu, 17 Nov 2022 10:54:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [linux-next-v2 5/5] arm64: dts: rockchip: Add missing of
 ethernet-phy-id to reset the phy on Rock 3A SBC
Content-Language: en-GB
To:     Anand Moon <linux.amoon@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221116200150.4657-1-linux.amoon@gmail.com>
 <20221116200150.4657-7-linux.amoon@gmail.com>
 <CAMdYzYo_DGiO0UxJEb3xues7Um=X9AgPvz+Xp_YWb9pp9HaScg@mail.gmail.com>
 <CANAwSgQJGH-+aXyUF18kGks4YKfBYvQ4-B7S2m8eaAr=yNS7vQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CANAwSgQJGH-+aXyUF18kGks4YKfBYvQ4-B7S2m8eaAr=yNS7vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-17 05:57, Anand Moon wrote:
> Hi Peter,
> 
> On Thu, 17 Nov 2022 at 02:16, Peter Geis <pgwipeout@gmail.com> wrote:
>>
>> On Wed, Nov 16, 2022 at 3:02 PM Anand Moon <linux.amoon@gmail.com> wrote:
>>>
>>> Add MDIO description with ethernet-phy-id compatible string
>>> which enable calling reset of the phy. The PHY will then be probed,
>>> independent of if it can be found on the bus or not,
>>> and that probing will enable the GPIO.
>>>
>>> ethernet-phy-id is read from ethenet register dump reg2 and reg3.
>>>
>>> Fix following warning.
>>> [   12.323417] rk_gmac-dwmac fe010000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
>>> [   12.324078] rk_gmac-dwmac fe010000.ethernet eth0: no phy at addr -1
>>> [   12.324099] rk_gmac-dwmac fe010000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -19)
>>>
>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>> ---
>>> V2: new to the patch series.
>>>
>>> alarm@rock-3a:~$ sudo ethtool -d eth0
>>> [sudo] password for alarm:
>>> ST GMAC Registers
>>> GMAC Registers
>>> Reg0  0x08072203
>>> Reg1  0x00000000
>>> Reg2  0x00000404
>>> Reg3  0x00000000
>>> Reg4  0x00000002
>>> ---
>>>   arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
>>> index 9f84a23a8789..fe36156a5017 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
>>> @@ -585,7 +585,7 @@ &i2s2_2ch {
>>>
>>>   &mdio1 {
>>>          rgmii_phy1: ethernet-phy@0 {
>>> -               compatible = "ethernet-phy-ieee802.3-c22";
>>> +               compatible = "ethernet-phy-id0000.0404", "ethernet-phy-ieee802.3-c22";
>>>                  reg = <0x0>;
>>>                  pinctrl-names = "default";
>>>                  pinctrl-0 = <&eth_phy_rst>, <&eth_phy_int>;
>>
>> Have you tried instead moving the reset to the mdio bus? I've had
>> success with this, though you'll need to change the reset assert and
>> deassert timing handles, they are different for the bus.
>>
> No can you share some examples?
> If you got a better way to solve this issue please let me know.
> I will give this a try.

Note that the Rock 3A schematic says the phy is configured for address 
1, not 0. From what I remember of adding the MDIO node for NanoiPi4, 
that didn't work if I got the address wrong, despite the fact that the 
auto-detection when the MDIO node is omitted claimed to find the same 
phy on both addresses 0 and 1.

Robin.

> 
> Thanks
> -Anand
>>> --
>>> 2.38.1
>>>
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
