Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA64E74AD5A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjGGIur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjGGIup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:50:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F09C51FE4;
        Fri,  7 Jul 2023 01:50:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6526ED75;
        Fri,  7 Jul 2023 01:51:25 -0700 (PDT)
Received: from [10.57.28.254] (unknown [10.57.28.254])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B06E3F73F;
        Fri,  7 Jul 2023 01:50:39 -0700 (PDT)
Message-ID: <5cf23bfd-a3b7-3dde-146b-4892d75b3485@arm.com>
Date:   Fri, 7 Jul 2023 09:50:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] arm64: dts: imx8mp: remove arm, primecell-periphid at
 etm nodes
Content-Language: en-GB
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Frank Li <Frank.li@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>, suzuki.poulose@arm.com,
        coresight@lists.linaro.org, imx@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230705205954.4159781-1-Frank.Li@nxp.com>
 <49ef52b7-0269-898c-7cc2-096f2f1037fc@arm.com>
 <ZKbSC8LBjLuo3ygD@lizhi-Precision-Tower-5810> <24260662.6Emhk5qWAg@steina-w>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <24260662.6Emhk5qWAg@steina-w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-07 06:34, Alexander Stein wrote:
> Hi Frank,
> 
> Am Donnerstag, 6. Juli 2023, 16:39:07 CEST schrieb Frank Li:
>> On Thu, Jul 06, 2023 at 12:06:19PM +0100, Robin Murphy wrote:
>>>>> Am Mittwoch, 5. Juli 2023, 22:59:53 CEST schrieb Frank Li:
>>>>>> The reg size of etm nodes is incorrectly set to 64k instead of 4k.
>>>>>> This
>>>>>> leads to a crash when calling amba_read_periphid().  After corrected
>>>>>> reg
>>>>>> size, amba_read_periphid() retrieve the correct periphid.
>>>>>> arm,primecell-periphid were removed from the etm nodes.
>>>>>
>>>>> So this means the reference manual is wrong here? It clearly states
>>>>> the size is 64kiB. Reference Manual i.MX8MP Rev 1. 06/2021
>>>>> On a side note: Is imx8mq affected by this as well? The DAP memory
>>>>> table lists similar sizes in the RM .
>>>>
>>>> Note that the 64K MMIO space per device is really an alignment thing.
>>>> It's a recommendation from ARM to allow individual device MMIO regions
>>>> to be mapped on kernels with 64K page size. Most of the time the real
>>>> MMIO space occupied by the device is actually much smaller than 64K.
>>>
>>> Indeed, it's quite common for TRM memory maps to be written in terms of
>>> the
>>> interconnect configuration, i.e. from the point of view of the
>>> interconnect
>>> itself, that whole range of address space is assigned to that peripheral,
>>> and it may even be true that the entire range is routed to the port where
>>> that peripheral is connected. However what's of more interest for DT is
>>> how
>>> much of that range the peripheral itself actually decodes.
>>
>> Yes, there are not problem by mapping bigger space in most case.
>>
>> amba bus's periphal use close to end of region to show device's identical
>> information.
> 
> Ah, thanks for the explanation. This make things more clear.
> But on the other is it sensible to assume the memory resource size to fit the
> IP address space? It appears to me the size is fixed to 4kiB anyway. Would it
> make more sense to read the values from the address "base + 4K - x" instead of
> "base + size - x"?

The size of PrimeCell components in general isn't necessarily 4KB 
though, and the ID registers were defined relative to the *end* of the 
register space. The old PrimeCell standards evolved into the CoreSight 
spec, and from the oldest version of that I can easily link to[1]:

"Each component occupies one or more contiguous 4KB blocks of address 
space. Where a component occupies more than one 4KB block, these 
registers must appear in the highest 4KB block."

(FWIW the latest Coresight 3.0 spec relaxes this restriction, but we 
tend to model newer stuff as platform drivers with explicit DT/ACPI 
identifiers rather than amba drivers anyway)

Thanks,
Robin.

[1] https://developer.arm.com/documentation/ihi0029/d/?lang=en

> 
> Best regards,
> Alexander
> 
>> In drivers/amba/bus.c,
>>
>> amba_read_periphid()
>> {
>> 	...
>> 	size = resource_size(&dev->res);
>> 	...
>> 	for (pid = 0, i = 0; i < 4; i++)
>> 		pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) << (i *
> 8);
>> }
>>
>> So the range in DTS for arm,primecell should be actual IP address space.
>>
>>> Robin.
>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
