Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6206A63A4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjB1XGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 18:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjB1XE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:04:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F6610AA9;
        Tue, 28 Feb 2023 15:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=jatBpF7sWuS+JQidrvoEBAvS0zsJRmdkksMQIO5yBOE=; b=MCt1v7Hh9tAmV4DDa0++HQf3gI
        gRyMpRdSmrIVHydfw1Unbq8ECxZ8V+l3PUGmhTt0XWMwJpfTK0RUvNIdp4wOpD6y9T0TIdbEDgDS0
        DNe28VQZ7xheNb/y3rufL1xaDxX3nwiLP/jHaeNLtuM63YpikV5eNyYa+uLWhXIo8RaTBplnU02+V
        8PRlWKmxMf4b15ic97vL11rVoVowwY/3ApHWzAFi8imdgieOXgLiyYm93juEbXL4PI9xwJ84rdbJI
        vS05EqYATfhZ/rhW+zv4+sEQ1/gyMMt62wWZ8v1o4d8OxAsr3o8FWmFePACtrtaYl7gmUi+qZAPQ2
        //EeoIRw==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pX91a-00EXo5-Co; Tue, 28 Feb 2023 23:04:46 +0000
Message-ID: <30194f43-10c1-faa8-f952-99cc30f5c128@infradead.org>
Date:   Tue, 28 Feb 2023 15:04:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 0/3] IRQ_DOMAIN: remove all "depends on", use only
 "select"
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Donggeun Kim <dg77.kim@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Peter Rosin <peda@axentia.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230213041535.12083-1-rdunlap@infradead.org>
 <b8fb48b9-349d-4723-9b35-6471cb65b6b5@app.fastmail.com>
 <8e6977b8-d256-4e51-82b7-e36d6ca259dc@infradead.org>
 <86y1p0xbqd.wl-maz@kernel.org>
 <6bb7bca5-e663-60c4-d574-9a4856cdb802@infradead.org>
 <87r0u9h9m7.wl-maz@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87r0u9h9m7.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/23 11:29, Marc Zyngier wrote:
> On Thu, 23 Feb 2023 18:37:01 +0000,
> Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Hi Marc,
>>
>> On 2/14/23 11:56, Marc Zyngier wrote:
>>> On Tue, 14 Feb 2023 18:30:54 +0000,
>>> Randy Dunlap <rdunlap@infradead.org> wrote:
>>>>
>>>>
>>>>
>>>> On 2/13/23 00:05, Arnd Bergmann wrote:
>>>>> On Mon, Feb 13, 2023, at 05:15, Randy Dunlap wrote:
>>>>>> IRQ_DOMAIN is a hidden (not user visible) symbol. Users cannot set
>>>>>> it directly thru "make *config", so drivers should select it instead
>>>>>> of depending on it if they need it.
>>>>>> Relying on it being set for a dependency is risky.
>>>>>>
>>>>>> Consistently using "select" or "depends on" can also help reduce
>>>>>> Kconfig circular dependency issues.
>>>>>>
>>>>>> IRQ_DOMAIN is selected 109 times and is depended on 3 times in
>>>>>> current linux-next. Eliminate the uses of "depends on" by
>>>>>> converting them to "select".
>>>>>>
>>>>>>  [PATCH 1/3] extcon: max8997: select IRQ_DOMAIN instead of depending on it
>>>>>>  [PATCH 2/3] of: OF_IRQ: select IRQ_DOMAIN instead of depending on it
>>>>>>  [PATCH 3/3] rtc: mt6397: select IRQ_DOMAIN instead of depending on it
>>>>>
>>>>> From a Kconfig perspective, your reasoning makes a lot of sense.
>>>>>
>>>>> Looking at the bigger picture, I wonder if we should just remove the
>>>>> option and make it unconditional. It is enabled in ever architecture
>>>>> defconfig other than alpha and sparc, and it's selected by a lot of
>>>>> very common options such as I2C,  GENERIC_MSI_IRQ, GENERIC_IRQ_CHIP,
>>>>> and PCI_HOST_GENERIC. Enabling the option on Alpha grows the kernel
>>>>> image from 9010KB to 9023KB, or on m68k Coldfire from 3346KB to
>>>>> 3351KB.
>>>>
>>>> Marc, what do you think about this suggestion?
>>>
>>> Seems sensible enough to me.
>>>
>>> I'd also get rid of the IRQ_DOMAIN_HIERARCHY option, which is used by
>>> a ton of things. Architectures that are not using it are either dead,
>>> or at least terminally comatose.
>>>
>>> I'm half-tempted to put the following patch into -next. Maybe after
>>> -rc1 though. And then the option can go as well.
>>>
>>> 	M.
>>
>> What is this patch based on?  It doesn't apply cleanly to current linux-next.
> 
> Not very surprising, I usually base my stuff on a stable rc tag. But
> in this instance, it may have been based on whatever was in my sandbox
> at that point in time, and subsequently discarded.
> 
>> I made a similar patch (to linux-next) that drops the IRQ_DOMAIN_HIERARCHY
>> option and converts its dependent code to always on.
>> It has been built (multiple randconfigs) on all ARCHes (except hexagon),
>> both 32-bit and 64-bit where applicable (not that it should matter here).
>>
>> But yes, let's plan to get one of these patches in soon (after -rc1).
> 
> Please send it based on -rc1 once it is out, and I'll be happy to
> stick that in -next for further simmering.

Alrighty, will do.
Thanks.

-- 
~Randy
