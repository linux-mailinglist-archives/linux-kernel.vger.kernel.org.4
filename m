Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7059E6DD392
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 09:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjDKHDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 03:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjDKHDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 03:03:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA8010EC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 00:03:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l26-20020a05600c1d1a00b003edd24054e0so5378657wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 00:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1681196594; x=1683788594;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hfUaJK5K49gfETGPOisBCfJxa2HZGrxX8QV+fOnnOk=;
        b=HnYFK4qZqI4RcIXlAvUrDPNcSifFMcVs8GEkxM0XP7F+xTSBSNj/S7IiVL0iGDSoFy
         pRqgAqa/xOFc0p/iNoWRXqes2yZZ6L168sZJR7TGUA9ylELoqrMdSJLDOBlh1hMBLpob
         yvDnmI6GszfQ6KYoSKVsMMfzYVDk5EmCE6jhxYSehWFN8SBgZ/ReFYsShee1Gdytf2X2
         riJ1rHZEh/69HQvHFsInHqTbwPJEj8aOvWF7A5+ABkyqPi7XDWm0l62zy/5L6NVIY45A
         5Oxx+55Ss7yvmexk/9StbJuIunmqcDfef6fEBTzXOCdfk7zTBGttdyj5sXaF19YkgEzG
         mBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681196594; x=1683788594;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8hfUaJK5K49gfETGPOisBCfJxa2HZGrxX8QV+fOnnOk=;
        b=li+K88q6zc+g1YJqU81x2Avkx+sXk9J4dl86kzVZH/lKzTlDCYP7shGPA5kIeFkVKe
         Rol9uyDD25H/7wpEy9Y23k6xN6TwDtXss0RqfErTTLI4X65ewi3yUgIDaPjtYkYlw1Va
         4rirC23PWpSIVYoCgw3j19HCZwL5PiQaKcvgwfnsfld54G1CFEkz0qrv869FQK8HFXj2
         EDkcKFvZIDdSfQLcFP0oeYt+dTjzABgPmbeiWRAByCQXKXmcaYKnDmryTaO7RNZVv7dx
         cSCsMa2WuBYhT5L5/9bh84jc2avlpBG60bo4PgfH8bBwIvLSG7OMOWJp1VD7jkNQ4iIx
         eVsQ==
X-Gm-Message-State: AAQBX9fmo91RDiL7jCMwkL4M/l8tKxV4trRrA1P5AQRu+n6YoEukrtvy
        V8i0gfSDWaYc8FViRKJ1qeen8Q==
X-Google-Smtp-Source: AKy350a8CllWGeVxvR6LgE7adUkYW/miVmQdA9w/Zz0JH4Oqzoo7pwigEO21rIknjgkedlOCSp0FfQ==
X-Received: by 2002:a05:600c:20e:b0:3ed:29db:cb80 with SMTP id 14-20020a05600c020e00b003ed29dbcb80mr6010292wmi.18.1681196594540;
        Tue, 11 Apr 2023 00:03:14 -0700 (PDT)
Received: from localhost ([2a04:cec0:11b6:9335:e66a:358b:d934:608b])
        by smtp.gmail.com with ESMTPSA id fm7-20020a05600c0c0700b003f063a709dbsm1688043wmb.2.2023.04.11.00.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 00:03:13 -0700 (PDT)
References: <20230320113445.17260-1-yu.tu@amlogic.com>
 <CAFBinCAE-ihq9oeXc=GqUEHVKUYM+n_e+2_5+gDMTGQcEEhRtg@mail.gmail.com>
 <b5e647e2-4561-e6c1-016f-2c3b260916bb@amlogic.com>
 <1jsfdy77n8.fsf@starbuckisacylon.baylibre.com>
 <d403dda4-e3db-4f26-6996-090a8c520b94@amlogic.com>
 <1j8rfp6u0h.fsf@starbuckisacylon.baylibre.com>
 <2e68acd1-f3d1-adbc-5ed2-66c40e006579@amlogic.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, kelvin.zhang@amlogic.com,
        qi.duan@amlogic.com
Subject: Re: [PATCH V2] clk: meson: vid-pll-div: added meson_vid_pll_div_ops
 support
Date:   Tue, 11 Apr 2023 09:02:11 +0200
In-reply-to: <2e68acd1-f3d1-adbc-5ed2-66c40e006579@amlogic.com>
Message-ID: <1jleiyyk7k.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 07 Apr 2023 at 18:08, Yu Tu <yu.tu@amlogic.com> wrote:

> On 2023/3/22 16:41, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>> On Wed 22 Mar 2023 at 15:46, Yu Tu <yu.tu@amlogic.com> wrote:
>>=20
>>> On 2023/3/21 17:41, Jerome Brunet wrote:
>>>> [ EXTERNAL EMAIL ]
>>> Hi Jerome,
>>> 	Thank you for your reply.
>>>> On Tue 21 Mar 2023 at 10:29, Yu Tu <yu.tu@amlogic.com> wrote:
>>>>
>>>>> Hi Martin=EF=BC=8C
>>>>> 	First of all, thank you for your reply.
>>>>>
>>>>> On 2023/3/20 23:35, Martin Blumenstingl wrote:
>>>>>> [ EXTERNAL EMAIL ]
>>>>>> Hello Yu Tu,
>>>>>> On Mon, Mar 20, 2023 at 12:35=E2=80=AFPM Yu Tu <yu.tu@amlogic.com> w=
rote:
>>>>>>>
>>>>>>> Since the previous code only provides "ro_ops" for the vid_pll_div
>>>>>>> clock. In fact, the clock can be set. So add "ops" that can set the
>>>>>>> clock, especially for later chips like S4 SOC and so on.
>>>>>>>
>>>>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>>>>> ---
>>>>>> please describe the changes you did compared to the previous version=
(s)
>>>>>
>>>>> I'll add it in the next version.
>>>>>
>>>>>> [...]
>>>>>>> diff --git a/drivers/clk/meson/vid-pll-div.h b/drivers/clk/meson/vi=
d-pll-div.h
>>>>>>> index c0128e33ccf9..bbccab340910 100644
>>>>>>> --- a/drivers/clk/meson/vid-pll-div.h
>>>>>>> +++ b/drivers/clk/meson/vid-pll-div.h
>>>>>>> @@ -10,11 +10,14 @@
>>>>>>>     #include <linux/clk-provider.h>
>>>>>>>     #include "parm.h"
>>>>>>>
>>>>>>> +#define VID_PLL_DIV_TABLE_SIZE         14
>>>>>> In v1 you used ARRAY_SIZE(vid_pll_div_table) wherever this new macro
>>>>>> is used instead.
>>>>>> I think using ARRAY_SIZE is the better approach because it means the
>>>>>> references will update automatically if an entry is added/removed fr=
om
>>>>>> vid_pll_div_table
>>>>>
>>>>> I agree with you. Perhaps the key is to understand what Jerome said.
>>>> I asked you to describe how this divider actually works. Not remove
>>>> ARRAY_SIZE().
>>>
>>> OKay! I misunderstood your meaning.
>>>
>>>> This divider uses tables only because the parameters are "magic".
>>>> I'd like the driver to be able come up with "computed" values instead.
>>>> What I requested is some explanation about how this HW clock works
>>>> because the documentation is not very clear when it comes to this. The=
se
>>>> values must come from somewhere, I'd like to understand "how".
>>>> This is the same as the PLL driver which can take a range and come up
>>>> with the different parameters, instead of using big pre-computed table=
s.
>>>>
>>>>>
>>>>>> Also I think there's a different understanding about what Jerome
>>>>>> previously wrote:
>>>>>>> It would be nice to actually describe how this vid pll work so we c=
an
>>>>>>> stop using precompute "magic" values and actually use the IP to its=
 full
>>>>>>> capacity.
>>>>>>    From what I understand is that you interpreted this as "let's cha=
nge
>>>>>> ARRAY_SIZE(vid_pll_div_table) to a new macro called
>>>>>> VID_PLL_DIV_TABLE_SIZE".
>>>>>> But I think what Jerome meant is: "let's get rid of vid_pll_div_table
>>>>>> and implement how to actually calculate the clock rate - without
>>>>>> hard-coding 14 possible clock settings in vid_pll_div_table". Look at
>>>>>> clk-mpll.c and/or clk-pll.c which allow calculating arbitrary rates
>>>>>> without any hard-coded tables.
>>>>>
>>>> exactly ... or at least an explanation about how it works and
>>>> why it is too complicated to compute the values at runtime.
>>>>
>>>>> In fact, pll and mpll are also fixed register writes corresponding
>>>>> values.
>>>> That is not true. The pll and mpll drivers are able to compute their
>>>> values at runtime. Please have a look at the drivers.
>>>>
>>>
>>> After consulting the engineer of the chip design, the clock is a digital
>>> frequency divider, and the frequency divider is verified by the sequence
>>> generator, which is bit0-bi15. bit16-bit17 confirms the size of the
>>> frequency division.
>> That, we already know. This is what the datasheet already give us.
>> It is still a bit light.
>> You don't set the bit randomly and check the output, do you ?
>> The question is how setting this bit impact the relation between
>> the input and output rate? IOW, from these 17bits, how do you come up
>> with the multiplier and divider values (and the other way around) ?
>>=20
>>> Whereas other PLLS and MPLLS are analog dividers so
>>> there are fixed formulas to calculate.
>>>
>>> So Neil had no problem implementing it this way. So now I want to know =
your
>>> advice what should I do next?
>> 1) Neil did what he could to get compute the rate (RO) which the little
>> information he had. You are trying to extend the driver, keeping an
>> dummy approach. It is only fair that I ask you to make this a real
>> driver.
>> 2) Because something has been done once, it not necessarily appropriate
>> to continue ... this type of argument hardly a valid reason.
>> I don't want to keep adding table based driver unless necessary.
>> So far, you have not proved this approach is really required, nor
>> provided the necessary information to make the calculation.
>
> Technically you are right. I am communicating and confirming with the chip
> designer to see if the general calculation formula can be given. If not, I
> will explain why. Please give me some time.
>
> But I have to mention that the SOC, although there is this register but
> actually does not use the clock. Can we treat this as a separate patch th=
at
> we will continue to send and explain later?
>
> This way I can continue with the other patches of S4 SOC first, and this
> clock stays the same way as the G12A first. Later, after the patch of the
> clock is corrected, it can be corrected to "ops" as required.Otherwise, we
> cannot continue other driver patches. I don't know if you agree?
>

Sure you can send your s4 series with RO ops and change to RW later on
if necessary.

>>=20
>>>
>>>>> But every SOC is different, so it makes more sense to set it
>>>>> outside. The VID PLL is a fixed value for all current SoCs.
>>>>>
>>>>>> Best regards,
>>>>>> Martin
>>>>>>
>>>>
>>=20

