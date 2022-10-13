Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9312E5FCE45
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiJLWRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJLWRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:17:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70A6A485A;
        Wed, 12 Oct 2022 15:17:46 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w18so135991wro.7;
        Wed, 12 Oct 2022 15:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwX9EaBzR0CFNo7qwx2QQhwUBrLNnhL6o4LAfvIe/aE=;
        b=DQMs/KKUHhGzV2CxDfQFog12x/6lB2hB5ZOTWJEKU6P12F20aRYIGRG5r+aFNmeSxQ
         7rk4zeieP5JTwq0ALMimyzhG2JY3ZSE/K9p6fYdRXYO13d+IwYFLhvTiXfe8YqmykCmn
         jGHxoPeqgs+Fk6ED2l0NrVCyiCugC70lFbDHOnjqYy9ieVgZJTT5FXUn7re/4wiRcog/
         NQA53Rizf4HKk8TmEM7sPdysIoDRW8KGTpG4KMIjGggjY3Q+g70cvUDtXytJR/WJmqdA
         WdikFETPxk1990XIalPmjfSvN6MgtMVxzGJUhWMG0TLGbLjMb1vGVjYKAym88bA7plXl
         9cJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwX9EaBzR0CFNo7qwx2QQhwUBrLNnhL6o4LAfvIe/aE=;
        b=654PH8UGHc6A7x4RlUqfa+94iqfLSLSd4BzNm3f6HugK4BYFeqEJtUcIg4CVs1bHb/
         LubBXhn+oRHKRrqgiQ+Q6yl92EYmLKZiFvFsZSR105JvM4t+x/3+zPxg9iy3fNrmlm9v
         UJweyy6ea9hRuJ6y5xhbVDwRMPNSWMBAHWDtpXrWPdkSbSlTRmkBS4VCfNSLiZIAoqg4
         ut4G6M9kwJaiwUqMh8qnLxrxRnjzZGAivus2OZbPMktEXKTb5YXNBmPnTLdQUxr7L5RC
         ecR8fcGrUB87pFyNpo/4Uegcg7RWhk2toYWcdhHLcE9nwm190FzX1FNwmHdfO5T0AjYO
         B+hA==
X-Gm-Message-State: ACrzQf18OhO6F7vPa3jYMjxDtcrevbnbeG1jYVdlrAYJviM5vZdCf3WJ
        ZLWd22aCRUHneBbdWWRzIyzQAdxbZjGlYGKu
X-Google-Smtp-Source: AMsMyM5Cms9xqdEIMqXRLXwlMwtw0oQKPJOM0LAyxp4kTfeNuk2ybdd1wJV3wBTwgbp0VW5aEwPbfQ==
X-Received: by 2002:a17:907:1b22:b0:741:8809:b4e6 with SMTP id mp34-20020a1709071b2200b007418809b4e6mr24404514ejc.84.1665613054819;
        Wed, 12 Oct 2022 15:17:34 -0700 (PDT)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id d41-20020a056402402900b0045bef7cf489sm8306043eda.89.2022.10.12.15.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 15:17:33 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: Re: [PATCH v1] ARM: dts: sun8i: h3: orangepi-pc: Add CMA reserved memory node
Date:   Thu, 13 Oct 2022 00:17:32 +0200
Message-ID: <2057585.bB369e8A3T@kista>
In-Reply-To: <f0e66966-b1c5-f130-54a4-ad63b77e1f26@collabora.com>
References: <20220914151125.212876-1-dmitry.osipenko@collabora.com> <1826631.tdWV9SEqCh@jernej-laptop> <f0e66966-b1c5-f130-54a4-ad63b77e1f26@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dne =C4=8Detrtek, 15. september 2022 ob 11:01:36 CEST je Dmitry Osipenko=20
napisal(a):
> Hi,
>=20
> On 9/14/22 21:34, Jernej =C5=A0krabec wrote:
> > Dne sreda, 14. september 2022 ob 17:33:27 CEST je Cl=C3=A9ment P=C3=A9r=
on=20
napisal(a):
> >> Hi Dmitry,
> >>=20
> >> On Wed, 14 Sept 2022 at 17:12, Dmitry Osipenko
> >>=20
> >> <dmitry.osipenko@collabora.com> wrote:
> >>> Add 256MB CMA node to the Orange Pi PC board. This fixes memory
> >>> allocation
> >>> failures for Cedrus video decoder on trying to play a 1080p video with
> >>> gstreamer.
> >>>=20
> >>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>> ---
> >>>=20
> >>>  arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 14 ++++++++++++++
> >>>  1 file changed, 14 insertions(+)
> >>>=20
> >>> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
> >>> b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts index
> >>> b96e015f54ee..e655346a9fb4 100644
> >>> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
> >>> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
> >>> @@ -60,6 +60,20 @@ chosen {
> >>>=20
> >>>                 stdout-path =3D "serial0:115200n8";
> >>>        =20
> >>>         };
> >>>=20
> >>> +       reserved-memory {
> >>> +               #address-cells =3D <1>;
> >>> +               #size-cells =3D <1>;
> >>> +               ranges;
> >>> +
> >>> +               linux,cma@40000000 {
> >>> +                       compatible =3D "shared-dma-pool";
> >>> +                       alloc-ranges =3D <0x40000000 0x40000000>;
> >>> +                       size =3D <0x10000000>; /* 256MiB */
> >>> +                       linux,cma-default;
> >>> +                       reusable;
> >>> +               };
> >>> +       };
> >>> +
> >>=20
> >> This change seems legit for all H3 boards and could be moved to the H3
> >> dtsi, no?
> >=20
> > That's true. However, there is a reason why this node doesn't exist. One
> > or
> > two H2+ boards (which use H3 dtsi) have only 256 MiB of RAM, so this ca=
n't
> > work with them. A few H3 boards have 512 MiB of RAM, so you eat basical=
ly
> > half of the RAM with that.
>=20
> It's a "reusable" CMA, hence it won't be eaten. System is free to use
> the reusable CMA. In practice, CMA may get populated with a pinned pages
> over time, hence system will work fine, but CMA will get fragmented and
> this may cause problems for a larger CMA allocations.
>=20
> The main problem with 512M boards should be that they may not have a
> suitable area for 256M CMA because it should be only either a low or
> high part of the memory that might be busy at a boot time, and then
> kernel will fail to boot.
>=20
> > Additionally, contrary to A20 and similar SoCs, which
> > have such node, Cedrus can address whole RAM, so this is not strictly
> > needed. It's better to leave this decision to distribution. Some don't
> > care about Cedrus and some do a lot. Default size can be set via kernel
> > config and it can be overriden by kernel argument if necessary.
>=20
> In my experience generic distributions usually don't care about
> particular boards/devices. They ship a multiplatform kernel using
> default config that has 64M for CMA and Cedrus doesn't work well with tha=
t.

It still can be overriden using cma=3D kernel argument.

>=20
> BTW, the sunxi_defconfig doesn't specify CMA size at all, so it defaults
> to 16M.

That can be easily changed, someone just need to send patch. Historically,=
=20
from A20 times, default choice for CMA size was 96 MiB. Good choice, and in=
 my=20
opinion also maximum, is 128 MiB. That's enough for 1080p. 256 MiB is reall=
y=20
only needed for 4k content, which only H3 and its variants support, from wh=
at=20
I can tell.

Best regards,
Jernej


