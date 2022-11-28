Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A6263A8C5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiK1MyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiK1MyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:54:13 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265C5165A2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:54:11 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bs21so16653707wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK7qj9aXUJa826HEmyjR+0PMVp4wD4eGk7gtFFJ40nA=;
        b=Q0uW3L0fkalrrFMcdBSypGNKFGzHvgGybKj4IpUm+p6wU1mHUg44U8cxfL5nfhmDlT
         2VzKN44IStX/oQtwG2p43wxDtqw5wBJKqIJ9TWBxv8IWfEVs1EFUGo/Ord8B4rdm9dQi
         firV4AN+oeO9HjsZmMW/ytu8rz45dZN/EIlG/mihescrrIaBdwUbBuZBg1HYXp7MviY1
         pTbNuhFCrf7zM9FoIa4T10qV2DJ+4UzXaPCFdCrLE2M7xOunlFaiH8Sgwt62uEyY+Ag5
         1jBx6joYA/VIxaMf6tDk5Ap4jDZwSa3x9AAY9Tk3EpVhDJOQ98OURBJ+dGg+hJd+7Qiz
         L6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jK7qj9aXUJa826HEmyjR+0PMVp4wD4eGk7gtFFJ40nA=;
        b=WhRNellvAwtGtAoFut0l+KzJeCEnF5QwZAruUb40ID4skAMGL03Hiixbl7ddvOl04C
         3coE9nCnlqrOrJ8Wma2W4IT/KBJk9cWIQNz6zy6NpZHBO2x/EyjRquR4BcOHG64AJtLl
         pcQf6pDXeCBLH8X/fA6azzBFmfM5dPvPmLZHQe9FtZXmN37FYv6qElNWFkunnRg7Hyt8
         Gf3zACdj9ol6ePie5vQ4f5vqUmaaKvTZVEcwNW06EmPN/o2eXe23bOFj8on1T/Tp19di
         e0sV59mLt3PNxHJEMkr/P0HuxJ2JPRHjNDrMKjRUeeDE5weKqF5nCatqMbcFvyLSk3br
         N3sA==
X-Gm-Message-State: ANoB5pmI8ldQI64DRaGGfjl+5DxURONzY2yZ9a48+4iTnXxclx3pyyvl
        1eq/VOEjtRB2fJkBzlPUurXjjw==
X-Google-Smtp-Source: AA0mqf42I4YzFCmCIX6Y7CLLjIa2od2/zzq8dij0Vj6yhbihZB61n/r4BHawsiyTl6uEsUzNF00Z5g==
X-Received: by 2002:a5d:526b:0:b0:242:380:c10e with SMTP id l11-20020a5d526b000000b002420380c10emr10820781wrc.132.1669640049615;
        Mon, 28 Nov 2022 04:54:09 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d5543000000b00241a8a5bc11sm10737223wrw.80.2022.11.28.04.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 04:54:09 -0800 (PST)
References: <20221123021346.18136-1-yu.tu@amlogic.com>
 <20221123021346.18136-2-yu.tu@amlogic.com>
 <f03f331a-5666-298e-a1a2-bdb9bab11a48@linaro.org>
 <92b570ea-3ddc-8e91-5a7a-ed601bb7c02c@amlogic.com>
 <eb56ed39-cfaa-3368-a2c0-0a4e89440e40@linaro.org>
 <5b7176b4-d7a2-c67f-31c6-e842e0870836@linaro.org>
 <1jfse72wqk.fsf@starbuckisacylon.baylibre.com>
 <a6cf1b3f-259d-44b7-8a9a-2a0cd29c714b@amlogic.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        neil.armstrong@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com
Subject: Re: [PATCH V5 1/4] clk: meson: S4: add support for Amlogic S4 SoC
 PLL clock driver and bindings
Date:   Mon, 28 Nov 2022 13:33:47 +0100
In-reply-to: <a6cf1b3f-259d-44b7-8a9a-2a0cd29c714b@amlogic.com>
Message-ID: <1jedtnp7db.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 28 Nov 2022 at 15:39, Yu Tu <yu.tu@amlogic.com> wrote:

> Hi Jerome,
> 	Thank you for your reply.
>
> On 2022/11/25 17:23, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>> On Wed 23 Nov 2022 at 14:53, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>=20
>>> On 23/11/2022 14:23, Neil Armstrong wrote:
>>>> Hi,
>>>>
>>>> On 23/11/2022 12:16, Yu Tu wrote:
>>>>> Hi Krzysztof,
>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0Thank you for your reply.
>>>>>
>>>>> On 2022/11/23 18:08, Krzysztof Kozlowski wrote:
>>>>>> [ EXTERNAL EMAIL ]
>>>>>>
>>>>>> On 23/11/2022 03:13, Yu Tu wrote:
>>>>>>> Add the S4 PLL clock controller found and bindings in the s4 SoC fa=
mily.
>>>>>>>
>>>>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>>>>> ---
>>>>>>>  =C2=A0 .../bindings/clock/amlogic,s4-pll-clkc.yaml=C2=A0=C2=A0 |=
=C2=A0 51 +
>>>>>>
>>>>>> This is v5 and still bindings are here? Bindings are always separate
>>>>>> patches. Use subject prefixes matching the subsystem (git log --onel=
ine
>>>>>> -- ...).
>>>>>>
>>>>>> And this was split, wasn't it? What happened here?!?
>>>>>
>>>>> Put bindings and clock driver patch together from Jerome. Maybe you c=
an read this chat history.
>>>>> https://lore.kernel.or/all/1jy1v6z14n.fsf@starbuckisacylon.baylibre.c=
om/
>>>>
>>>> Jerome was asking you to send 2 patchsets, one with :
>>>> - bindings in separate patches
>>>> - drivers in separate patches
>>>> and a second with DT changes.
>> Indeed, this is what was asked. It is aligned with Krzysztof's request.
>
> According to your discussion, I still should send patches in the previous
> way in series. But I'm going to change it like you suggested.
> I don't know, am I getting it right?

3 people tried to explain this already and we all told you the same thing.

* 1 patchset per maintainer: clk and dt
* bindings must be dedicated patches - never mixed with driver code.

I strongly suggest that you take some time to (re)read:
* https://docs.kernel.org/process/submitting-patches.html
* https://docs.kernel.org/devicetree/bindings/submitting-patches.html

If still unclear, please take some time to look at the kernel mailing
list archive and see how others have done the same things.

Thx.

>
>>=20
>>>>
>>>> Then when the bindings + clocks patches are merged, a pull request of =
the bindings
>>>> can be done to me so I can merge it with DT.
>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>>>  =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 1 +
>>>>>>>  =C2=A0 drivers/clk/meson/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 13 +
>>>>>>>  =C2=A0 drivers/clk/meson/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 1 +
>>>>>>>  =C2=A0 drivers/clk/meson/s4-pll.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 875 ++++++++++++++++++
>>>>>>>  =C2=A0 drivers/clk/meson/s4-pll.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 88 ++
>>>>>>>  =C2=A0 .../dt-bindings/clock/amlogic,s4-pll-clkc.h=C2=A0=C2=A0 |=
=C2=A0 30 +
>>>>>>>  =C2=A0 7 files changed, 1059 insertions(+)
>>>>>>>  =C2=A0 create mode 100644 Documentation/devicetree/bindings/clock/=
amlogic,s4-pll-clkc.yaml
>>>>>>>  =C2=A0 create mode 100644 drivers/clk/meson/s4-pll.c
>>>>>>>  =C2=A0 create mode 100644 drivers/clk/meson/s4-pll.h
>>>>>>>  =C2=A0 create mode 100644 include/dt-bindings/clock/amlogic,s4-pll=
-clkc.h
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,s4-pll=
-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.ya=
ml
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..fd517e8ef14f
>>>>>>> --- /dev/null
>>>>>>> +++ b/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.y=
aml
>>>>>>> @@ -0,0 +1,51 @@
>>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>>> +%YAML 1.2
>>>>>>> +---
>>>>>>> +$id: http://devicetree.org/schemas/clock/amlogic,s4-pll-clkc.yaml#
>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>> +
>>>>>>> +title: Amlogic Meson S serials PLL Clock Controller
>>>>>>> +
>>>>>>> +maintainers:
>>>>>>> +=C2=A0 - Neil Armstrong <narmstrong@baylibre.com>
>>>>>>> +=C2=A0 - Jerome Brunet <jbrunet@baylibre.com>
>>>>>>> +=C2=A0 - Yu Tu <yu.hu@amlogic.com>
>>>>>>> +
>>>>>> One blank line.
>>>>>
>>>>>   =C2=A0I will delete this, on next version patch.
>>>>>
>>>>>>
>>>>>>> +
>>>>>>> +properties:
>>>>>>> +=C2=A0 compatible:
>>>>>>> +=C2=A0=C2=A0=C2=A0 const: amlogic,s4-pll-clkc
>>>>>>> +
>>>>>>> +=C2=A0 reg:
>>>>>>> +=C2=A0=C2=A0=C2=A0 maxItems: 1
>>>>>>> +
>>>>>>> +=C2=A0 clocks:
>>>>>>> +=C2=A0=C2=A0=C2=A0 maxItems: 1
>>>>>>> +
>>>>>>> +=C2=A0 clock-names:
>>>>>>> +=C2=A0=C2=A0=C2=A0 items:
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: xtal
>>>>>>> +
>>>>>>> +=C2=A0 "#clock-cells":
>>>>>>> +=C2=A0=C2=A0=C2=A0 const: 1
>>>>>>> +
>>>>>>> +required:
>>>>>>> +=C2=A0 - compatible
>>>>>>> +=C2=A0 - reg
>>>>>>> +=C2=A0 - clocks
>>>>>>> +=C2=A0 - clock-names
>>>>>>> +=C2=A0 - "#clock-cells"
>>>>>>> +
>>>>>>> +additionalProperties: false
>>>>>>> +
>>>>>>> +examples:
>>>>>>> +=C2=A0 - |
>>>>>>> +=C2=A0=C2=A0=C2=A0 clkc_pll: clock-controller@fe008000 {
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "amlogic,s4-pll-clkc=
";
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0xfe008000 0x1e8>;
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&xtal>;
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names =3D "xtal";
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #clock-cells =3D <1>;
>>>>>>> +=C2=A0=C2=A0=C2=A0 };
>>>>>>
>>>>>>
>>>>>>> +#endif /* __MESON_S4_PLL_H__ */
>>>>>>> diff --git a/include/dt-bindings/clock/amlogic,s4-pll-clkc.h b/incl=
ude/dt-bindings/clock/amlogic,s4-pll-clkc.h
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..345f87023886
>>>>>>> --- /dev/null
>>>>>>> +++ b/include/dt-bindings/clock/amlogic,s4-pll-clkc.h
>>>>>>
>>>>>> This belongs to bindings patch, not driver.
>>>>>>
>>>>>>> @@ -0,0 +1,30 @@
>>>>>>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>>>>>>> +/*
>>>>>>> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
>>>>>>> + * Author: Yu Tu <yu.tu@amlogic.com>
>>>>>>> + */
>>>>>>> +
>>>>>>> +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_S4_PLL_CLKC_H
>>>>>>> +#define _DT_BINDINGS_CLOCK_AMLOGIC_S4_PLL_CLKC_H
>>>>>>> +
>>>>>>> +/*
>>>>>>> + * CLKID index values
>>>>>>> + */
>>>>>>> +
>>>>>>> +#define CLKID_FIXED_PLL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 1
>>>>>>> +#define CLKID_FCLK_DIV2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 3
>>>>>>
>>>>>> Indexes start from 0 and are incremented by 1. Not by 2.
>>>>>>
>>>>>> NAK.
>>>>>
>>>>> I remember Jerome discussing this with you.You can look at this submi=
ssion history.
>>>>> https://lore.kernel.org/all/c088e01c-0714-82be-8347-6140daf56640@lina=
ro.org/
>>>>
>>>> Historically we did that by only exposing part of the numbers, control=
ling which
>>>> clocks were part of the bindings.
>>>>
>>>> But it seems this doesn't make sens anymore, maybe it would be time to=
 put all the
>>>> clock ids in the bindings for this new SoC and break with the previous=
 strategy.
>> Krzysztof and I agreed there is nothing wrong with the current
>> approach, I believe.
>> It does not prevent someone from using an un-exposed clock, sure, or
>> exposing it in the future if necessary.
>> However, I think it clearly shows that an un-exposed element is not
>> expected to be used by an external consumers. It should be enough to
>> trigger a discussion if this expectation is wrong.
>>=20
>>>
>>> So the outcome of the previous discussion was somewhere later in that
>>> thread:
>>>
>>>> It is just a choice to not expose some IDs.
>>>> It is not tied to the implementation at all.
>>>> I think we actually follow the rules and the idea behind it.
>>>
>>>
>>> Best regards,
>>> Krzysztof
>> .

