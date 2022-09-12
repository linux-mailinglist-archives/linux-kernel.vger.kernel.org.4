Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A145B59F8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiILMIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiILMI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:08:29 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B68B93340E;
        Mon, 12 Sep 2022 05:08:28 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 12 Sep 2022 21:08:28 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 2EBE420584CE;
        Mon, 12 Sep 2022 21:08:28 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 12 Sep 2022 21:08:28 +0900
Received: from [10.212.158.44] (unknown [10.212.158.44])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 048DBB62A4;
        Mon, 12 Sep 2022 21:08:26 +0900 (JST)
Subject: Re: [PATCH v2 6/8] ARM: dts: uniphier: Add ahci controller and glue
 layer nodes for PXs2
To:     Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220912071511.1385-1-hayashi.kunihiko@socionext.com>
 <20220912071511.1385-7-hayashi.kunihiko@socionext.com>
 <a8d5db25-9191-4af0-b9e0-77fb75493a7f@www.fastmail.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <0a3e5fe1-0099-ef11-29f4-0d3a64ae5e9a@socionext.com>
Date:   Mon, 12 Sep 2022 21:10:40 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a8d5db25-9191-4af0-b9e0-77fb75493a7f@www.fastmail.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 2022/09/12 17:36, Arnd Bergmann wrote:
> On Mon, Sep 12, 2022, at 9:15 AM, Kunihiko Hayashi wrote:
>> Add ahci controller and glue layer nodes including reset and phy.
>> This supports for PXs2 and the boards without PXs2 vodka board that
>> doesn't implement any SATA connectors.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> +		ahci: ahci@65600000 {
>> +			compatible = "socionext,uniphier-pxs2-ahci",
>> +				     "generic-ahci";
>> +			status = "disabled";
>> +			reg = <0x65600000 0x10000>;
>> +			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&sys_clk 28>;
>> +			resets = <&sys_rst 28>, <&ahci_rst 0>;
>> +			ports-implemented = <1>;
>> +			phys = <&ahci_phy>;
>> +		};
>> +
>> +		ahci-glue@65700000 {
>> +			compatible = "socionext,uniphier-pxs2-ahci-glue",
>> +				     "simple-mfd";
> 
> Here as well, the "ahci-glue" name seems rather unusual for a node
> name. What does it actually do, and why is this not just part of
> the sata node?

According to ata/sata-common.yaml, "ahci@65600000" node for generic SATA
host controller is better expressed as "sata@65600000". I'll fix it.

However, "ahci-glue@65700000" is the integration of SATA related functions
(reset and phy). Maybe "sata-controller" seems to be the best, but
I couldn't find this usage.

>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges = <0 0x65700000 0x100>;
>> +
>> +			ahci_rst: reset@0 {
>> +				compatible =
> "socionext,uniphier-pxs2-ahci-reset";
> 
> I think the node name here should be "reset-controller@0".

Yes, I'll fix it.

>> +
>> +			ahci_phy: phy@10 {
>> +				compatible =
> "socionext,uniphier-pxs2-ahci-phy";
> 
> and "sata-phy@10" here.

I'll fix it too.

Thank you,

---
Best Regards
Kunihiko Hayashi
