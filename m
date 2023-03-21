Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7115F6C2B59
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCUH1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCUH12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:27:28 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4724333CD0;
        Tue, 21 Mar 2023 00:27:27 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id f6-20020a4ace86000000b00537590ae0a2so2262219oos.8;
        Tue, 21 Mar 2023 00:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679383646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lN03r+lNraGva2aQZc0gY3Y2eDpzLMJTb6HI5Qu4Nls=;
        b=Q58pv5EQo1PPfrVfu5MO0Ee72vjuDSirtH/YKgKHtQIMaSpfJTL13qnlDi5Jru7ukn
         Px7NjPQGG7oAxuTyg2e6DXysVDjqZZJmZ7dvaadKv6b8YAs7N0Vn7j9axhAJntcIYcPq
         LUJqI1HhZvE0elu9Vv/o+rZ1r/GqzbfXIhrOs4PUeTWZC1+b0cbBUX9pzMUpyd0htNHU
         v37umS3OKbltDt2Gz7GBmvBmbPk0yykA/By8qG+npgvsGkbePsrlGMu2oZUYK/jk/K/I
         1XVq0bI33NiCUI3lI8Kp0k8c0iQ1Vsg64jC+dXdqv3HrAuaEwz/eUjzcR85jQUt8GCJr
         KgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679383646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lN03r+lNraGva2aQZc0gY3Y2eDpzLMJTb6HI5Qu4Nls=;
        b=UUDsDmlTEejdBLMFAUqqorITRDBky36k0g680UKKQQ/A/wANz1ZU4zlCcWj0YfttZm
         WKtC+gyErKSS2taUV9xPa5wIdNlP5k36U3X99WnlmnaweTQDGGryq3ZN7rljN305isnH
         8eJAhGLZPMcytulEgs8tP6yhUbFlL3iIS8auyFZSE9Lp3GkrUfj7fcPeCpYDh+wrGSsB
         xyqj9GWu5kxt9rCWa2bRarprZNPXG7IM3gvK17p0vFbWSe+xHH6CqAHmMKsJ1HMWDWht
         Rzs1YCNyKfMAAnxQUHOe8dvi5Mb1r/VHY+C4tN1eSpZ1nMZwe5DHTbUBj48/SsofETOC
         Acig==
X-Gm-Message-State: AO0yUKVCEueG9OwWVC13AtsESJZghLjQycFobDt8nJ2BiCQb2N3PGyLe
        WmoBwLJkmu4vJMFGTBRk9lLuhf3vs00ePXYkiqZHvHER67SeFQ==
X-Google-Smtp-Source: AK7set+RPNpCQUduEbQnJP50HrY1hohDtbIxM2hY1HZLWCi1BvyAVkO2LxZ16ASJNXCyb1AILINeIoRb0r3NASgVfYg=
X-Received: by 2002:a05:6820:516:b0:536:c774:d6cc with SMTP id
 m22-20020a056820051600b00536c774d6ccmr473837ooj.0.1679383646619; Tue, 21 Mar
 2023 00:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
 <20230320161823.1424278-2-sergio.paracuellos@gmail.com> <1e2f67b4-3bfb-d394-4f60-e6f63ce6a2fd@linaro.org>
 <CAMhs-H8OQ9gJLsifLuHD2GN8rYwnY=Zmdb0kMEfX4UUHhjMUyQ@mail.gmail.com>
 <d0f74721-bf5a-62de-53dc-62e7e735e2dc@linaro.org> <bdc82b4a-f1a9-0372-5a57-200a422b1b70@arinc9.com>
 <21a90597-78c9-4d46-7b01-257702e7afca@linaro.org> <525a6388-a4b8-3052-fe81-5aa21d8f424a@arinc9.com>
 <507f79cf-acd8-5238-031a-fd71024e0c6a@linaro.org> <CAMhs-H8_S5eO7B+dZ7jeq7Jjnw71QBmSo4M+woe3U5sH7dCADg@mail.gmail.com>
 <39ba681e-5bab-cffc-edf7-4bf86387987c@linaro.org> <132de602-6467-536c-c66d-657f22a59bd5@arinc9.com>
 <40e3acac-b58a-7af8-b025-3678f84434da@linaro.org> <CAMhs-H9AWXvtbg=qz06HN3piUO0E5YF3RmrdRLC7qH2n6KjrSw@mail.gmail.com>
 <d598f5f8-f998-2a31-bb21-97e641793dda@linaro.org>
In-Reply-To: <d598f5f8-f998-2a31-bb21-97e641793dda@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 21 Mar 2023 08:27:13 +0100
Message-ID: <CAMhs-H9snDAa9K7b+R+wi2VotFCrOQwF3B_55=dpAAkfZ0CdBQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device
 tree binding documentation
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 8:20=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/03/2023 07:56, Sergio Paracuellos wrote:
> > On Tue, Mar 21, 2023 at 7:43=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 21/03/2023 07:38, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> >>>>>>
> >>>>>> Ah, but indeed there are newer Mediatek MT6xxx and MT8xxx SoCs whi=
ch are
> >>>>>> ARM, so mediatek,mtmips-sysc would work.
> >>>>>
> >>>>> I can use 'mediatek,mtmips-sysc.yaml' as the name but compatibles w=
ill
> >>>>> start with ralink. There are already some existent compatibles for
> >>>>> mt762x already having ralink as prefix, so to be coherent ralink
> >>>>> should be maintained as prefix.
> >>>>
> >>>> The compatibles I mentioned start already with mediatek, so why do y=
ou
> >>>> want to introduce incorrect vendor name for these?
> >>>
> >>> Can you point out where these compatible strings for mt7620 and mt762=
8 are?
> >>
> >> git grep
> >
> > Not for *-sysc nodes. The only current one in use (from git grep):
>
> We do not talk about sysc nodes at all. They do not matter.

Ah, ok. That reason was from where all of my arguments were coming
from. But if it does not matter, I don't have problems using the
'mediatek' prefix in the new stuff.

>
> >
> > arch/mips/ralink/mt7620.c:      rt_sysc_membase =3D
> > plat_of_remap_node("ralink,mt7620a-sysc");
> >
> > That's the reason I also used prefix ralink for the rest.
> >
> > Does it make sense to you to maintain this one as ralink,mt7620a-sysc
> > and add the following with mediatek prefix?
> >
> > mediatek,mt7620-sysc
> > mediatek,mt7628-sysc
> > mediatek,mt7688-sysc
> >
> > That would be weird IMHO.
>
> What exactly would be weird? Did you read the discussion about vendor
> prefix from Arinc? mt7620 is not a Ralink product, so what would be
> weird is to use "ralink" vendor prefix. This was never a Ralink. However
> since there are compatibles using "ralink" for non-ralink devices, we
> agreed not to change them.
>
> These though use at least in one place mediatek, so the above argument
> does not apply. (and before you say "but they also use ralink and
> mediatek", it does not matter - it is already inconsistent thus we can
> choose whatever we want and ralink is not correct).

Ok, I see your point now. Thanks for clarification. I will maintain
'ralink,mt7620a-sysc' since it already exists and change the new stuff
to use mediatek as prefix. These are 'mediatek,mt7620-sysc',
'mediatek,mt7628-sysc' and 'mediatek,mt7688-sysc'. Doing so it will
properly match the 'mediatek,mtmips-sysc.yaml' file name.

>
>
> Best regards,
> Krzysztof
>

Thanks,
    Sergio Paracuellos
