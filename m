Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA41690301
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjBIJOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBIJOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:14:15 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023649E;
        Thu,  9 Feb 2023 01:14:14 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0FA9966020B9;
        Thu,  9 Feb 2023 09:14:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675934053;
        bh=X5aykjwR6Noi8jAOHiqv2GSFOIbKzmDiWJfxsu4VbMg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FkgnIEjwSVQE5ec4W06abDhr1CC/YzTFVarvXPYUPv7D1zgXwHOdWwPSCspFnzugx
         2VBw66rpynAQuskqFhNrPQaVMtIrP9oKKbJ4U75nvZIVmJK/zB3rFy5JKdp4v2NogA
         R3+fe3ywtA0F2km85iyHw7Udf2aD8o7JYTvQrB3NnsCNLE5CaogZHHm8hpA19w7+2N
         ryKevvAcea6/xFzwuN19ELDukLFQZsa1I7JvuGqSonY3icS+MH0pHogm2BuZNFDNgj
         iXKxjp9OQUWx+7eQp/Gr7mhjYtRCv6avpsyinnH0ar6LoxuS1ziPbTtXDho8KdWh3m
         /fBHZTZsz15UQ==
Message-ID: <62a86fd9-5770-c32c-ad65-467940cc3ee0@collabora.com>
Date:   Thu, 9 Feb 2023 10:14:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 35/45] clk: mediatek: Split MT8195 clock drivers and
 allow module build
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
 <20230206152928.918562-36-angelogioacchino.delregno@collabora.com>
 <CAGXv+5HTP0cLGEQ+qkAt8nsOp5DqCOgPyAOJ66fF91SKX=hZvw@mail.gmail.com>
 <45f8e284-8d56-898b-0897-94c576e09c2c@collabora.com>
 <CAGXv+5FmmDx0Q_d17hv1gu+drfD12-vtgPoTpefExHGvdkcQyA@mail.gmail.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5FmmDx0Q_d17hv1gu+drfD12-vtgPoTpefExHGvdkcQyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/02/23 04:46, Chen-Yu Tsai ha scritto:
> On Wed, Feb 8, 2023 at 5:00 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 08/02/23 09:28, Chen-Yu Tsai ha scritto:
>>> On Mon, Feb 6, 2023 at 11:30 PM AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>
>>>> MT8195 clock drivers were encapsulated in one single (and big) Kconfig
>>>> option: there's no reason to do that, as it is totally unnecessary to
>>>> build in all or none of them.
>>>>
>>>> Split them out: keep boot-critical clocks as bool and allow choosing
>>>> non critical clocks as tristate.
>>>
>>> The power domain controller references vppsys*, vdecsys*, vdosys*, wpesys,
>>> imgsys and camsys. I'd argue that this makes these clock drivers
>>> semi-boot-critical. Maybe mfgcfg as well when we add the GPU?
>>
>> You don't need to power on additional power domains if you want to load modules
>> from a ramdisk! :-)
> 
> Right.
> 
>> Besides, you caught me: mtk-pm-domains will be my next target after clocks...
>> I don't like how it behaves in regard to probe deferrals. Specifically,
>> I dislike the fact that you either register *all domains* or *none at all*
>> (unless instantiating two different driver instances and that's ugly).
> 
> I don't really like it either, but is it possible to split probe deferrals?
> I mean, if you skip a couple power domains because the clocks aren't
> available, how do you come back to them?
> 

Honestly, I have no clue right now - I didn't even think about any possible
implementation for now... but let's see what I can come up with whenever I
get a chance to actually take a look.

Surely not before finishing work on this series, though.

> And IIRC for a clock provider that is _not_ marked as disabled in the DT,
> trying to fetch a clock from it would just give -EPROBEDEFER until
> the provider is registered.
> 

Yes it will give a probe deferral. An internal probe retry mechanism on the
power domains that couldn't probe would be one of the possible options.

Actually, we have almost endless options on how to resolve that power domains
issue, so it's not worrying me at all!

Cheers,
Angelo

> ChenYu
> 
>>>
>>> They should be bundled together at the very least. The power domain
>>> controller not probing disables all display and multimedia capabilities.
>>>
>>> Also wondering if we should have "default COMMON_CLK_MT8195" ...
>>>
>>> I suppose the same questions apply to other SoCs.
>>>
>>> ChenYu
>>
>>

