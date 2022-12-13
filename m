Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E803464B427
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbiLML0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbiLMLZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:25:44 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1256113F01;
        Tue, 13 Dec 2022 03:25:02 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BD801660036A;
        Tue, 13 Dec 2022 11:24:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670930700;
        bh=S28HSQxSYCXptuAQKVMiEpXE1fyqtwfRr7BZZg4uLno=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Oc9gXk0hl3JuuTZ3xweThzqAl1A/8eU8gP7vsaciJpgcjDqwoH9h8ptkg4wmHwRx+
         m/MiO+DE79mUHZfvyro4S5FWGQmx0AP7x9ZYCpvoLHltCdo6AmHrFr0CvYF3VCaNH2
         YBCabCdpSeAnMlADjUGhsM4lIGtwAhAreHs45rZ87XEfNhZp50sOJv8mQg4UK4yGwS
         l/uRCM86fDS5hpJBfHcK0qqWL5S06Vbeo+cXWppAlTzbat1dmf4KaRoM20LfKmNBjO
         bcXl+6oo1vMrzM5DNM6fHr8Wnnn0iKk4AwCCzMsbKIDboPLIt+YytoLlPhyl6pP+fm
         +neOrivoc51ig==
Message-ID: <8d2237d3-1a00-569b-fe83-57b889c266a2@collabora.com>
Date:   Tue, 13 Dec 2022 12:24:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/4] arm64: dts: mediatek: mt8183: Fix systimer 13 MHz
 clock description
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>
References: <20221201084229.3464449-1-wenst@chromium.org>
 <20221201084229.3464449-2-wenst@chromium.org>
 <5250d7d3-ff46-e08d-926c-4efd92390d88@collabora.com>
 <CAGXv+5E63+dE-=KbD_LW+BV+fBWnfaD+oH0+e9T_aS-XEffN5w@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5E63+dE-=KbD_LW+BV+fBWnfaD+oH0+e9T_aS-XEffN5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/12/22 11:33, Chen-Yu Tsai ha scritto:
> On Thu, Dec 1, 2022 at 5:31 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 01/12/22 09:42, Chen-Yu Tsai ha scritto:
>>> The systimer block derives its 13 MHz clock by dividing the main 26 MHz
>>> oscillator clock by 2 internally, not through the TOPCKGEN clock
>>> controller.
>>>
>>> On the MT8183 this divider is set either by power-on-reset or by the
>>> bootloader. The bootloader may then make the divider unconfigurable to,
>>> but can be read out by, the operating system.
>>>
>>> Making the systimer block take the 26 MHz clock directly requires
>>> changing the implementations. As an ABI compatible fix, change the
>>> input clock of the systimer block a fixed factor divide-by-2 clock
>>> that takes the 26 MHz oscillator as its input.
>>>
>>> Fixes: 5bc8e2875ffb ("arm64: dts: mt8183: add systimer0 device node")
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>
>> I generally not just like - but *love* - this change, I had that in my mind
>> for a couple of months now and forgot about it because reasons.
>>
>> There's just one thing that, since we're doing this now, we can clarify (and
>> that's important to avoid questions like "why isn't this board-specific"):
>> the 26MHz clock "clk26m" oscillator that we're using for the system timers
>> is a SoC-provided clock, and its name is "SYSCLK" as in "System bus clock".
> 
> Looking at the schematics it is terribly more complicated. :(
> 
> The crystal feeds the DCXO in the PMIC, which also acts as a buffer.
> The PMIC then feeds the SoC and any other chips, such as a modem.
> 
> On other platforms we describe the oscillator at the dtsi level as well.
> The reason why it isn't board-specific is that the requirements and
> properties of the crystal are specified in the platform's datasheet,
> i.e. it is a design requirement that every board use the same crystal.
> 
> I don't see the datasheet spelling out SYSCLK though. The TOPCKGEN part

I think I got confused with the MCU Debug System (DEM) part. :\

> mostly just refers to it as CLK26M, or some variant of it, which likely
> denotes some fan-out branch. The system timer part also just says "26M"
> or "26 MHz clock source".
> 
> Also, we can't change the clock name, as "clk26m" is hard-coded into
> the clk drivers.
> 

I wasn't proposing to change the clock-output-names, but nevermind anyway,
on an afterthought, it's probably a good idea to just go with clk26m,
regardless of whether I'm wrong or right about sysclk, as the first one is
the name that we can also find in many (all?) downstream code for other
SoC models.

>> I know that your target is to describe how we get from 26M to 13M, but at
>> this point it may be worth it to use the right names to help preventing
>> confusion about that clock not being an external crystal on the board but
>> something internal to the SoC.
> 
> But as I described above, it is an actual crystal on the board. We are
> simply omitting parts of the signal path. Notably the PMIC needs to be
> excluded due to circular dependency reasons. And also we most definitely
> don't want the system to be touching it.
> 

Let's go with this one.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

