Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287AB68C01C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjBFObB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjBFOa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:30:58 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84A3824491
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:30:51 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 06 Feb 2023 23:30:50 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 383502058B4F;
        Mon,  6 Feb 2023 23:30:50 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 6 Feb 2023 23:31:00 +0900
Received: from [10.212.157.140] (unknown [10.212.157.140])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 6C0803D7B;
        Mon,  6 Feb 2023 23:30:49 +0900 (JST)
Message-ID: <cabaac65-8717-0dfa-2b4c-c95eb16b5beb@socionext.com>
Date:   Mon, 6 Feb 2023 23:30:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] bus: unifier-system-bus: Remove open coded "ranges"
 parsing
To:     Rob Herring <robh@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230201220011.247100-1-robh@kernel.org>
 <bb307806-fa02-d147-2c25-6b3b3bbd411b@socionext.com>
 <CAL_JsqLfq6U3OORsKE962f2RZ7kQXLNEb2ShzrWqGY+=oVsf=g@mail.gmail.com>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <CAL_JsqLfq6U3OORsKE962f2RZ7kQXLNEb2ShzrWqGY+=oVsf=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2023/02/04 0:06, Rob Herring wrote:
> On Wed, Feb 1, 2023 at 11:50 PM Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
>>
>> Hi Rob,
>>
>> On 2023/02/02 7:00, Rob Herring wrote:
>>> "ranges" is a standard property and we have common helper functions for
>>> parsing it, so let's use them.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>> Compile tested only!
>>
>> Please fix the driver's name.
>>
>> s/unifier-system-bus/uniphier-system-bus/
> 
> doh!
> 
>>
>>> ---
>>>    drivers/bus/uniphier-system-bus.c | 54 +++++++------------------------
>>>    1 file changed, 11 insertions(+), 43 deletions(-)
>>>
>>> diff --git a/drivers/bus/uniphier-system-bus.c
>>> b/drivers/bus/uniphier-system-bus.c
>>> index f70dedace20b..cb5c89ce7b86 100644
>>> --- a/drivers/bus/uniphier-system-bus.c
>>> +++ b/drivers/bus/uniphier-system-bus.c
>>> @@ -176,10 +176,9 @@ static int uniphier_system_bus_probe(struct
>>> platform_device *pdev)
>>>    {
>>>        struct device *dev = &pdev->dev;
>>>        struct uniphier_system_bus_priv *priv;
>>> -     const __be32 *ranges;
>>> -     u32 cells, addr, size;
>>> -     u64 paddr;
>>> -     int pna, bank, rlen, rone, ret;
>>> +     struct of_range_parser parser;
>>> +     struct of_range range;
>>> +     int ret;
>>>
>>>        priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>>        if (!priv)
>>> @@ -191,48 +190,17 @@ static int uniphier_system_bus_probe(struct
>>> platform_device *pdev)
>>>
>>>        priv->dev = dev;
>>>
>>> -     pna = of_n_addr_cells(dev->of_node);
>>> -
>>> -     ret = of_property_read_u32(dev->of_node, "#address-cells",
>>> &cells);
>>> -     if (ret) {
>>> -             dev_err(dev, "failed to get #address-cells\n");
>>> -             return ret;
>>> -     }
>>> -     if (cells != 2) {
>>> -             dev_err(dev, "#address-cells must be 2\n");
>>> -             return -EINVAL;
>>> -     }
>>
>> Don't you need to check the value of "#address-cells"?
> 
> Doesn't your schema do that?
> 
> It's not the kernel's job to validate the DT. If it is, then it does a
> terrible job.

Ah, this is the code before DT validation, and it's no longer necessary.

>>> -
>>> -     ret = of_property_read_u32(dev->of_node, "#size-cells", &cells);
>>> -     if (ret) {
>>> -             dev_err(dev, "failed to get #size-cells\n");
>>> +     ret = of_range_parser_init(&parser, dev->of_node);
>>> +     if (ret)
>>>                return ret;
>>> -     }
>>> -     if (cells != 1) {
>>> -             dev_err(dev, "#size-cells must be 1\n");
>>> -             return -EINVAL;
>>> -     }
>>
>> Same as "#size-cells"
> 
> While the address clearly needs cells to hold the chip select, there's
> no reason to restrict the size cells.

I see.
I understand that size is limited by value, not by cell width.
It's also no longer necessary.

>>
>> I confirmed the value of all the arguments of
>> uniphier_system_bus_add_bank()
>> match the previous ones.
>>
>> Tested-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> Thanks.
Thank you,

---
Best Regards
Kunihiko Hayashi
