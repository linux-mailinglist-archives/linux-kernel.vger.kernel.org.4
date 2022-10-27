Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFFE60F615
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbiJ0LTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiJ0LTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:19:44 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31DBF3884;
        Thu, 27 Oct 2022 04:19:35 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 27 Oct 2022 20:19:35 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 12B8B20584CE;
        Thu, 27 Oct 2022 20:19:35 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 27 Oct 2022 20:19:35 +0900
Received: from [10.212.157.173] (unknown [10.212.157.173])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 5EA16B62A4;
        Thu, 27 Oct 2022 20:19:34 +0900 (JST)
Subject: Re: [PATCH 4/4] arm64: dts: uniphier: Add NX1 SoC and boards support
To:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221027045157.23325-1-hayashi.kunihiko@socionext.com>
 <20221027045157.23325-5-hayashi.kunihiko@socionext.com>
 <b3c4f9ec-ba8e-4af1-b347-e07b06530d6c@app.fastmail.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <8c11d7c4-dfc4-b84c-82cd-a9708bd79aab@socionext.com>
Date:   Thu, 27 Oct 2022 20:19:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b3c4f9ec-ba8e-4af1-b347-e07b06530d6c@app.fastmail.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thank you for your comment.

On 2022/10/27 19:01, Arnd Bergmann wrote:
> On Thu, Oct 27, 2022, at 06:51, Kunihiko Hayashi wrote:
>> Initial version of devicetree sources for NX1 SoC and boards.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> Can you add more information here? When new SoCs get added, I
> usually provide more than this in my own pull requests sending
> the patches to Linus, so please add some background here, such as:
> 
> - is this a new SoC, or or something that has been around for a while
>    and only now gets upstreamed?
> 
> - What is the target market for this SoC? Are there any products
>    one can buy with it?
> 
> - What type of CPU cores does it use, or any other noteworthy
>    IP blocks that are relevant for its purpose?

This advice is good for me.
I'll add some background for this SoC to the commit.

>> +			usb_hsphy0: hs-phy@200 {
>> +				compatible =
> "socionext,uniphier-nx1-usb3-hsphy";
>> +				reg = <0x200 0x10>;
> 
>> +			usb_ssphy0: ss-phy@300 {
>> +				compatible =
> "socionext,uniphier-nx1-usb3-ssphy";
>> +				reg = <0x300 0x10>;
> 
> I think these are usually just named 'phy@' instead of 'hs-phy@'

I see. Since it was adapted to other SoCs, I'll rename the node as well
in another patch.

>> +			ranges =
>> +			/* downstream I/O */
>> +				<0x81000000 0 0x00000000 0x0ffe0000 0
> 0x00010000>,
>> +			/* non-prefetchable memory */
>> +				<0x82000000 0 0x20000000 0x04200000 0
> 0x0bde0000>;
> 
> 200MB of memory space is rather small, is there no 64-bit range?

Unfortunately, this SoC has only 190MB of PCIe memory space.

>> +			#interrupt-cells = <1>;
>> +			interrupt-names = "dma", "msi";
>> +			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-map-mask = <0 0 0 7>;
>> +			interrupt-map = <0 0 0 1 &pcie_intc 0>,	/* INTA */
>> +					<0 0 0 2 &pcie_intc 1>,	/* INTB */
>> +					<0 0 0 3 &pcie_intc 2>,	/* INTC */
>> +					<0 0 0 4 &pcie_intc 3>;	/* INTD */
>> +			phy-names = "pcie-phy";
>> +			phys = <&pcie_phy>;
>> +
>> +			pcie_intc: legacy-interrupt-controller {
>> +				interrupt-controller;
>> +				#interrupt-cells = <1>;
>> +				interrupt-parent = <&gic>;
>> +				interrupts = <GIC_SPI 86
> IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>> +		};
> 
> Shouldn't there be an "msi-map" or "msi-parent" property pointing at
> the GIC?

Since Designware PCIe receives an interrupt from GIC with interrupt-name "msi"
and passes the interrupt to the linear irq domain corresponding to MSI,
I think there is neither "msi-map" nor "msi-parent" properties.

Thank you,

---
Best Regards
Kunihiko Hayashi
