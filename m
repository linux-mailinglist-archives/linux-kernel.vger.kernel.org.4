Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D096372BCD2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjFLJge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbjFLJft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:35:49 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B888744BD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:27:24 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-78cc6ec0ba1so994943241.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686562043; x=1689154043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZ61BYiIXs/pR8R9VQFSM1kThwJZ0JutFXTW/ak4uso=;
        b=AUQCxG3wBHmv9pmMjQBJnT9Xpncoq8k5UbLZrY2bt/wTlAR/hHCpezu/OHdjDrixyT
         9WhssEdeFlS858XcOSxOMSO5UrZJ/gI6E0EJ+Lq6+kDHCLsLghxa9jSnSKQldMggk0Uz
         sCuhPW+O/v/2ipzPspiruiZfGcQYXlVx2VLhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562043; x=1689154043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZ61BYiIXs/pR8R9VQFSM1kThwJZ0JutFXTW/ak4uso=;
        b=WCedwa/NVUMTfpkSbxVuyGZkYBBE4kYei4dLg4nbp1n6fX8ucLcxtjNulSJFFe17Zx
         7N5zH2sRshHFGMeabinEEN0z2mdD6YaNv++Fulx/O4bDN4plkU2mv3mBeLG87cqUq23D
         Z0Y6IZtKs6ypT/XMqDHNh+rBBgCT1xAS5iQaSNMhnoH7WAusYrZ3dUtOnrfn4S80U5u2
         sbh5QP6hbUqOT5D83IoVujsPBvmvv/KusrU4Zbm0XVuutntNXLu2DO8jd3Z3e3zXYv5I
         SqGcsW4BG7qSa3YjEOfHZxkbaOQdsQ80SDCEQFyEaqXoq27o02SyxYchxdzDN946s7xA
         0iMw==
X-Gm-Message-State: AC+VfDxj1Lrjw4WjR0+sDtmwNDe0ym0rdhDgu8Umo9XbaDIndMGuJP/Q
        /NGy7XGZuhAlQryl1mepyj19u1Ey/w400TusF7uwjg==
X-Google-Smtp-Source: ACHHUZ63/0FutjMWIa2hW1hbOYJMT3/JrY6BNcAZ7xJddwUYYzpnmlEbrbSPTyWSd4ryo9nqj5JcASReEM40eYD/ShU=
X-Received: by 2002:a1f:3f96:0:b0:44f:e32a:148 with SMTP id
 m144-20020a1f3f96000000b0044fe32a0148mr3013133vka.8.1686562043752; Mon, 12
 Jun 2023 02:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230608075651.3214540-1-wenst@chromium.org> <ce04685b7c4840b683add0bdd4404da6@AcuMS.aculab.com>
 <CAGXv+5EtdhkMq916LLOfpz8ok_xump5tv+oeNBvPq-_3-93oqQ@mail.gmail.com> <0929093384864ff99c78800029ff5d76@AcuMS.aculab.com>
In-Reply-To: <0929093384864ff99c78800029ff5d76@AcuMS.aculab.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 12 Jun 2023 17:27:12 +0800
Message-ID: <CAGXv+5Hnrpv8kTU+0B9S4NyqALEz+DQOLfO3U7GwMZp9AoqLEw@mail.gmail.com>
Subject: Re: [PATCH] regulator: Use bitfield values for range selectors
To:     David Laight <David.Laight@aculab.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        "linux-actions@lists.infradead.org" 
        <linux-actions@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 3:48=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Chen-Yu Tsai
> > Sent: 12 June 2023 04:39
> >
> > On Sun, Jun 11, 2023 at 1:10=E2=80=AFAM David Laight <David.Laight@acul=
ab.com> wrote:
> > >
> > > From: Chen-Yu Tsai
> > > > Sent: 08 June 2023 08:57
> > > >
> > > > Right now the regulator helpers expect raw register values for the =
range
> > > > selectors. This is different from the voltage selectors, which are
> > > > normalized as bitfield values. This leads to a bit of confusion. Al=
so,
> > > > raw values are harder to copy from datasheets or match up with them=
,
> > > > as datasheets will typically have bitfield values.
> > > >
> > > > Make the helpers expect bitfield values, and convert existing users=
.
> > > > Include bitops.h explicitly for ffs(), and reorder the header inclu=
de
> > > > statements. While at it, also replace module.h with export.h, since=
 the
> > > > only use is EXPORT_SYMBOL_GPL.
> > > >
> > > ...
> > > >  static const unsigned int atc260x_ldo_voltage_range_sel[] =3D {
> > > > -     0x0, 0x20,
> > > > +     0x0, 0x1,
> > > >  };
> > >
> > > Is there any way the change can be done so that un-edited
> > > modules fail to compile?
> > > Otherwise the whole thing is an accident waiting to happen.
> >
> > I think we could change the field name in the regulator description?
> > But unsuspecting end users / developers might just edit the name and no=
t
> > see that the scheme has changed.
> >
> > Or we could add a sanity check at runtime that checks the values during
> > regulator registration. How does that sound?
> >
> > Mark, is this something you'd like?
>
> Can you change the name of the function the values are passed to?

    .set_voltage_sel =3D regulator_set_voltage_sel_pickable_regmap,

This one, and

    .get_voltage_sel =3D regulator_get_voltage_sel_pickable_regmap,

which calls the helper regulator_range_selector_to_index() that actually
uses the values.

Not sure how changing the helper names would help, or how it is different
from changing the field name? The names are already quite long but spot
on.

> Or maybe change the type to 'unsigned char' (assuming bit numbers
> are small).

That doesn't quite work if the range selector is in the upper four bits.
The values would fit nevertheless.

ChenYu
