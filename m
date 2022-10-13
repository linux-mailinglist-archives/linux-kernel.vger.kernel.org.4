Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143405FD4A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 08:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiJMGWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 02:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJMGWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 02:22:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B802E122BD6;
        Wed, 12 Oct 2022 23:22:39 -0700 (PDT)
Received: from [192.168.1.15] (91-158-154-79.elisa-laajakaista.fi [91.158.154.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8DB94492;
        Thu, 13 Oct 2022 08:22:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1665642157;
        bh=rZBDZR7MZOuIelDaywoffQzbCi2SBztFLeybeY1iFms=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J2N2e5jmaqPq8FTEoqcSws3JE0J4/SzyThWGE9m+GBNvrZBlinotfty3KQ7c/oLY+
         8GYtKV8+vhYIW+khhV3kX8sUjyAE+9SUfAcoGb02oVan529TBbN3xKcx5+Rkl8VIJn
         nMvmBcuBzM++0M+sCSln/2n1Ed6ueTH1/ZoyeYA8=
Message-ID: <b56197a1-f23d-5f8a-b32d-f8787586364e@ideasonboard.com>
Date:   Thu, 13 Oct 2022 09:22:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/4] ARM: dts: omap3-n900: fix LCD reset line polarity
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221004213503.848262-1-dmitry.torokhov@gmail.com>
 <Y0UDEtQlN5Y9h7BU@atomide.com>
 <20221011123726.elsr53ue7nxzhvww@mercury.elektranox.org>
 <Y0V4cLGbYe4j+ls6@google.com> <Y0V99Agad6Ma+yTC@atomide.com>
 <Y0V/82JsRVZh6PlL@google.com> <Y0WCCw8k+KTuvdWX@atomide.com>
 <41373c20-3b97-ac47-81c8-75bf1bbe3a38@ideasonboard.com>
 <Y0cVw63d3+pAVbd2@google.com>
Content-Language: en-US
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <Y0cVw63d3+pAVbd2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2022 22:30, Dmitry Torokhov wrote:
> On Wed, Oct 12, 2022 at 01:58:15PM +0300, Tomi Valkeinen wrote:
>> Hi,
>>
>> On 11/10/2022 17:47, Tony Lindgren wrote:
>>> * Dmitry Torokhov <dmitry.torokhov@gmail.com> [221011 14:30]:
>>>> On Tue, Oct 11, 2022 at 05:30:12PM +0300, Tony Lindgren wrote:
>>>>> * Dmitry Torokhov <dmitry.torokhov@gmail.com> [221011 13:57]:
>>>>>> Hi Sebastian,
>>>>>>
>>>>>> On Tue, Oct 11, 2022 at 02:37:26PM +0200, Sebastian Reichel wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Tue, Oct 11, 2022 at 08:45:54AM +0300, Tony Lindgren wrote:
>>>>>>>> * Dmitry Torokhov <dmitry.torokhov@gmail.com> [221004 21:26]:
>>>>>>>>> The LCD driver (panel-sony-acx565akm), when probing, starts with line
>>>>>>>>> driven low, and then toggles it to high and keeps it there. Also, the
>>>>>>>>> line is driven low when powering off the device, and ls released when
>>>>>>>>> powering it back on. This means that the reset line should be described
>>>>>>>>> as "active low" in DTS. This will be important when the driver is
>>>>>>>>> converted to gpiod API which respects the polarity declared in DTS.
>>>>>>>>
>>>>>>>> We should ensure these patches get merged together with the driver
>>>>>>>> change to avoid breaking LCD for booting. Probably no need to have
>>>>>>>> the driver quirk handling for inverted polartity in this case.
>>>>>>>>
>>>>>>>> It's probably easiest to have an immutable branch for the driver
>>>>>>>> changes I can base the dts changes on. Or I can ack the dts changes
>>>>>>>> if they get merged with the driver.
>>>>>>>
>>>>>>> Both drivers are already using gpiod API:
>>>>>>>
>>>>>>> drivers/gpu/drm/panel/panel-sony-acx565akm.c
>>>>>>> drivers/gpu/drm/panel/panel-dsi-cm.c
>>>>>>
>>>>>> I was looking at
>>>>>>
>>>>>> drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
>>>>>> drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
>>>>>
>>>>> Ah OK that explains :)
>>>>>
>>>>>> which are not using gpiod. Should they be retired?
>>>>>
>>>>> Yes we should just get rid of them with omapdrm working just fine.
>>>>
>>>> Will you be submitting such patches? I'd like to get rid of
>>>> of_get_named_gpio() and friends if I can...
>>>
>>> Adding Tomi to Cc, my guess is he already has such patches and knows
>>> better which ones can go :)
>>
>> To be honest, I haven't really even had a glance towards fbdev for a long
>> time.
>>
>> There is one thing that omapdrm doesn't support, which is VRFB rotation. I
>> cannot say if the users of those above-mentioned panels require VRFB.
>>
>>>>>>> So this just breaks things.
>>>>>>
>>>>>> I missed the drivers in drivers/gpu/... and I see that they essentially
>>>>>> abuse gpiod API as gpiod_set_value() operates on logical level
>>>>>> (active/inactive) and not absolute (high/low). They should either use
>>>>>> the gpiod_*_raw() variants, or they should be adjusted to do the proper
>>>>>> thing together with the accompanying DTS change.
>>>>>>
>>>>>> What are your preferences?
>>>>>
>>>>> Seems like high/low at the connected device end is what we should use,
>>>>> right? Otherwise things will misbehave if the panel is connected to
>>>>> some other SoC possibly.
>>>>
>>>> It is exactly because of this case the driver should use active/inactive
>>>> and follow polarity described in DTS. If the driver does:
>>>>
>>>> 	gpiod_set_value_cansleep(d->reset, 1);
>>>>
>>>> then if DTS is saying that the reset line is active low, under the wraps
>>>> the line will be driven to "0", but if DTS is saying that the line is
>>>> active high, then the very same call will drive the line to "1".
>>>>
>>>> This allows accommodating different designs without having to change the
>>>> driver code.
>>
>> Isn't breaking an old dts file quite a bad thing? Why not just add a comment
>> to the .dts and to the driver about the situation. I don't quite see that
>> the fixing the dts (And, if done properly, adding a boot time fixup for old
>> dtbs) and changing the drivers is worth the hassle.
>>
>> Unless we see new users for these drivers, which would require the new users
>> to write broken dts files.
> 
> Or maybe there are devices with fixed DTSes and fixed up kernels but the
> fixes have not been contributed upstream. I don't know...
> 
> My personal opinion is that we pay too much attention to DTS
> compatibility in cases when it is not totally clear if there are devices
> that use DTSes that are not bundled with the kernel and also have a
> chance to have their kernel updated (and be lucky enough for the
> upstream kernel to work on such device without extensive work).
> 
> Anyway, my goal is to stop exposing of_get_named_gpio() and its
> derivatives, so please let me know your preference. Should I:
> 
> - mirror in omapfb drivers what gpu drivers do and use inverted
>    polarity

I would just go with the above for the time being. It should be an easy 
change, and as these omapfb and drm panel drivers are kind of copies of 
each other, I think it makes sense to use the same code in both.

That said, I personally don't mind fixing the dts files and the drivers, 
and even dropping the omapfb panel drivers. However, as I don't know if 
someone needs the omapfb drivers or has to use an old dtb, I don't want 
to step on that possible mine field. If someone else wants to go there 
(without my involvement), fine for me =).

  Tomi

