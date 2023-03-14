Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9536B98DD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjCNPUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCNPUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D0264255;
        Tue, 14 Mar 2023 08:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1F44617D6;
        Tue, 14 Mar 2023 15:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C239C433D2;
        Tue, 14 Mar 2023 15:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678807216;
        bh=jcMA9GzTCMarVP15aTq1dWjq3xFQ8SxkJgCrDIaG+hM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s5tB6CWelGrwhBJgbM46SfWU193ooo0kVqMgeBTTb+2LDUhf2uIoYVqL2170sFLJR
         ihI5+I4PFcZeWWRT+ES2OeG0iwIcSquq+nHjcrTdGBDV6JGh1/2sYJzCOFQRVwuh/q
         I+0dEPcQrlOzH1sto/1UMU1dPCBRx5IEccQaJ5AJR4FKzoB/x8g8OcboJIMasFpCi0
         4t3SPLlGaKt/zMjlJ9duhkYgB0wBmzVGkG8nBadH47OMJB/GCNo2BvxpTR2Fxbq9eB
         JUY1hlQT7aINezRQa+NoEqk9Rokj/mSQBTkfVbfOctZ70uSUhm3zhzepCRiHzBooYT
         hdFqFPbrcPo1w==
Received: by mail-ua1-f53.google.com with SMTP id ay14so4293930uab.13;
        Tue, 14 Mar 2023 08:20:16 -0700 (PDT)
X-Gm-Message-State: AO0yUKX5bM1m/ve2fFdHbuGrnAlSXPhLzd3OuPmwy1c4VNUgRmICGiHB
        wVz2zxqyRwssDhdYxWfeb4oNlXqs7qGJ6Ht6XQ==
X-Google-Smtp-Source: AK7set/o9mZDZmAcIY3owEZFYv2AqPYqePQU6WtPL67HWict0qlMDoRdxAVygbNAHZRz8ImdTlOD51RbVReFROH5Rrw=
X-Received: by 2002:a1f:a9c7:0:b0:401:73f4:dfe with SMTP id
 s190-20020a1fa9c7000000b0040173f40dfemr23714881vke.3.1678807215097; Tue, 14
 Mar 2023 08:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230310144656.1540950-1-robh@kernel.org> <c2191745-714c-7cdc-ba2d-a254245bbdac@linaro.org>
In-Reply-To: <c2191745-714c-7cdc-ba2d-a254245bbdac@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Mar 2023 10:20:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJNv3-aRJ1ryoxTCRfnXxXg6ZCwbSspYfoBd71c+WR88w@mail.gmail.com>
Message-ID: <CAL_JsqJNv3-aRJ1ryoxTCRfnXxXg6ZCwbSspYfoBd71c+WR88w@mail.gmail.com>
Subject: Re: [PATCH] mips: Use of_property_read_bool() for boolean properties
To:     =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 3:25=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Rob,
>
> On 10/3/23 15:46, Rob Herring wrote:
> > It is preferred to use typed property access functions (i.e.
> > of_property_read_<type> functions) rather than low-level
> > of_get_property/of_find_property functions for reading properties.
> > Convert reading boolean properties to to of_property_read_bool().
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >   arch/mips/pci/pci-lantiq.c | 2 +-
> >   arch/mips/pci/pci-rt3883.c | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
> > index d967e4c0cf24..79e29bf42a24 100644
> > --- a/arch/mips/pci/pci-lantiq.c
> > +++ b/arch/mips/pci/pci-lantiq.c
> > @@ -118,7 +118,7 @@ static int ltq_pci_startup(struct platform_device *=
pdev)
> >
> >       /* and enable the clocks */
> >       clk_enable(clk_pci);
> > -     if (of_find_property(node, "lantiq,external-clock", NULL))
> > +     if (of_property_read_bool(node, "lantiq,external-clock"))
>
> Just curious, is this property correct?

Shrug. I can only tell from how it is used here and because we have
other similar properties used to select a clock.

> I can't find it and wonder if
> this is dead code (always disabling the clock)... I'm probably missing
> something obvious :/

If you don't use the external clock, then you disable it. Seems sensible to=
 me.

>
> >               clk_enable(clk_external);
> >       else
> >               clk_disable(clk_external);
>
