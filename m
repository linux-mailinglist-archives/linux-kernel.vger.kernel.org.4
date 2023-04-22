Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C5D6EB839
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 11:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjDVJ2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 05:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVJ2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 05:28:31 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4A61BDD;
        Sat, 22 Apr 2023 02:28:29 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-b991e510fbcso2401449276.1;
        Sat, 22 Apr 2023 02:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682155709; x=1684747709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrXgHc8efjYKPkwCAQD6BX3ADaICeUgW7mmqaq5rXFY=;
        b=mYDtFN05gc6xnxflad2HBKpRR2B+Pw1fdLxqeW+G4m9fG+fTeIB6OSUzdgNHGZ8b9e
         QkPEEFKsV4g1xVa4oteRpQ2TPmS95MMYgwsyp3K93x3LFm4Po2hzv/nXt4xnagEhMpOr
         IoBYF0fr+WFT3SVCo8bzJVXmIDp6xaGsX21AQnmZV2ymKLkZIFiP+hOJApZ3mk3fVgxt
         uISMXTIfuPJjfu0v2L3HK2D+3UVnlOQnJfKp9SeKYqt6DaIlPIThdPW3BYzTD+s8F3mr
         vJKVGthFdilip0+JA2Q2mPCrAUvFCL0FI31OnDieMWf8QtVLw9/YvFy1zLBQYP/Q1ypf
         PdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682155709; x=1684747709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrXgHc8efjYKPkwCAQD6BX3ADaICeUgW7mmqaq5rXFY=;
        b=PqnZOUPNdo7RxYPXgfutKooTBkGkMpRTBbsk5/zQMIGcrZv+YRgYcFYiEjj1msrmXh
         m40zhuwhRGThDATCXu9WNlwJkfkEgqF6sCzRCF26GNOpzA+iECyr9sFhEY3gz8x/4W9K
         IV5MyPTr1R2IhW/Y4vOoXdZLDmJk5+6pm4SwNfc/B3eQYBN+9EjyKsl7G/qFcCfEL7lQ
         FAVu/r9uNs023ZuZguaJxTsXExqcf35HebARl6SJj+jtG/tW1aBaZzwQR6YsAr02Prg+
         CzIkwEWQYnfEYFHqOwab/oidSP8n1OtLWFdFIkKpLGIIpudK4JR70WMSScsrP3+ZPDd0
         eobQ==
X-Gm-Message-State: AAQBX9e3UH7US8Y4/uqHQTfP1/Pj2f6jl3zk1ZXYLd1vcAg8B9lU4hpE
        JtCZCDWcfoneUN0pGz2rXUmAedYYzQsy5nCDeGU=
X-Google-Smtp-Source: AKy350ZQfq3u09Hq+RMEg29XRBIYgpLLXGnaYuZqNkdXxw1XCvCUMMRB5gFIvyC2IiJLM6TJACL44hg3vea7CTMp5xs=
X-Received: by 2002:a25:ca10:0:b0:b8f:36fb:d60e with SMTP id
 a16-20020a25ca10000000b00b8f36fbd60emr5152912ybg.28.1682155708729; Sat, 22
 Apr 2023 02:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230323124510.2484808-1-noltari@gmail.com> <20230323124510.2484808-2-noltari@gmail.com>
 <20230324104020.54754079@xps-13> <CAKR-sGcbRRjqt3raXHcvfCfKFDfFWsuu+C7XW3qFckawMsqe4w@mail.gmail.com>
 <20230324114911.19e00ae1@xps-13> <CAKR-sGc3R_k_+-hzv5DOOeRO-5rHL1k_dq7mpZLcv=FgZ1Moug@mail.gmail.com>
 <20230324144559.3473c537@xps-13> <CAKR-sGdxFbMZYGcDnWHW9SU=6hchZMi75=BjGtDen_Ws1keORg@mail.gmail.com>
 <20230324153602.66a8841d@xps-13> <CAKR-sGegBo2M-+mHZknWBJhmgHtT21Lsd=W==5zU-raja6aJuA@mail.gmail.com>
In-Reply-To: <CAKR-sGegBo2M-+mHZknWBJhmgHtT21Lsd=W==5zU-raja6aJuA@mail.gmail.com>
From:   =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date:   Sat, 22 Apr 2023 11:28:17 +0200
Message-ID: <CAKR-sGc6j4FH2wVsJdwKW3U1K9+o2U6fZxBZEXF8J6aAiX-poQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mtd: nand: Macronix: document new binding
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        YouChing <ycllin@mxic.com.tw>
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, masonccyang@mxic.com.tw,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello YouChing and Jaime,

I still didn't get any feedback from you (or Macronix) on this issue.
Did you have time to look into it?

Thanks,
=C3=81lvaro.

El vie, 24 mar 2023 a las 18:04, =C3=81lvaro Fern=C3=A1ndez Rojas
(<noltari@gmail.com>) escribi=C3=B3:
>
> Hi Miqu=C3=A8l,
>
> 2023-03-24 15:36 GMT+01:00, Miquel Raynal <miquel.raynal@bootlin.com>:
> > Hi =C3=81lvaro,
> >
> > + YouChing and Jaime from Macronix
> > TLDR for them: there is a misbehavior since Mason added block
> > protection support. Just checking if the blocks are protected seems to
> > misconfigure the chip entirely, see below. Any hints?
>
> Could it be that the NAND is stuck expecting a read 0x00 command which
> isn=E2=80=99t sent after getting the features?
>
> >
> > noltari@gmail.com wrote on Fri, 24 Mar 2023 15:15:47 +0100:
> >
> >> Hi Miqu=C3=A8l,
> >>
> >> 2023-03-24 14:45 GMT+01:00, Miquel Raynal <miquel.raynal@bootlin.com>:
> >> > Hi =C3=81lvaro,
> >> >
> >> > noltari@gmail.com wrote on Fri, 24 Mar 2023 12:21:11 +0100:
> >> >
> >> >> El vie, 24 mar 2023 a las 11:49, Miquel Raynal
> >> >> (<miquel.raynal@bootlin.com>) escribi=C3=B3:
> >> >> >
> >> >> > Hi =C3=81lvaro,
> >> >> >
> >> >> > noltari@gmail.com wrote on Fri, 24 Mar 2023 11:31:17 +0100:
> >> >> >
> >> >> > > Hi Miqu=C3=A8l,
> >> >> > >
> >> >> > > El vie, 24 mar 2023 a las 10:40, Miquel Raynal
> >> >> > > (<miquel.raynal@bootlin.com>) escribi=C3=B3:
> >> >> > > >
> >> >> > > > Hi =C3=81lvaro,
> >> >> > > >
> >> >> > > > noltari@gmail.com wrote on Thu, 23 Mar 2023 13:45:09 +0100:
> >> >> > > >
> >> >> > > > > Add new "mxic,disable-block-protection" binding documentati=
on.
> >> >> > > > > This binding allows disabling block protection support for
> >> >> > > > > those
> >> >> > > > > devices not
> >> >> > > > > supporting it.
> >> >> > > > >
> >> >> > > > > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gm=
ail.com>
> >> >> > > > > ---
> >> >> > > > >  Documentation/devicetree/bindings/mtd/nand-macronix.txt | =
3
> >> >> > > > > +++
> >> >> > > > >  1 file changed, 3 insertions(+)
> >> >> > > > >
> >> >> > > > > diff --git
> >> >> > > > > a/Documentation/devicetree/bindings/mtd/nand-macronix.txt
> >> >> > > > > b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
> >> >> > > > > index ffab28a2c4d1..03f65ca32cd3 100644
> >> >> > > > > --- a/Documentation/devicetree/bindings/mtd/nand-macronix.t=
xt
> >> >> > > > > +++ b/Documentation/devicetree/bindings/mtd/nand-macronix.t=
xt
> >> >> > > > > @@ -16,6 +16,9 @@ in children nodes.
> >> >> > > > >  Required NAND chip properties in children mode:
> >> >> > > > >  - randomizer enable: should be "mxic,enable-randomizer-otp=
"
> >> >> > > > >
> >> >> > > > > +Optional NAND chip properties in children mode:
> >> >> > > > > +- block protection disable: should be
> >> >> > > > > "mxic,disable-block-protection"
> >> >> > > > > +
> >> >> > > >
> >> >> > > > Besides the fact that nowadays we prefer to see binding
> >> >> > > > conversions
> >> >> > > > to
> >> >> > > > yaml before adding anything, I don't think this will fly.
> >> >> > > >
> >> >> > > > I'm not sure exactly what "disable block protection" means, w=
e
> >> >> > > > already have similar properties like "lock" and
> >> >> > > > "secure-regions",
> >> >> > > > not
> >> >> > > > sure they will fit but I think it's worth checking.
> >> >> > >
> >> >> > > As explained in 2/2, commit 03a539c7a118 introduced a regressio=
n
> >> >> > > on
> >> >> > > Sercomm H500-s (BCM63268) OpenWrt devices with Macronix
> >> >> > > MX30LF1G18AC
> >> >> > > which hangs the device.
> >> >> > >
> >> >> > > This is the log with block protection disabled:
> >> >> > > [    0.495831] bcm6368_nand 10000200.nand: there is not valid m=
aps
> >> >> > > for
> >> >> > > state default
> >> >> > > [    0.504995] nand: device found, Manufacturer ID: 0xc2, Chip =
ID:
> >> >> > > 0xf1
> >> >> > > [    0.511526] nand: Macronix MX30LF1G18AC
> >> >> > > [    0.515586] nand: 128 MiB, SLC, erase size: 128 KiB, page si=
ze:
> >> >> > > 2048, OOB size: 64
> >> >> > > [    0.523516] bcm6368_nand 10000200.nand: detected 128MiB tota=
l,
> >> >> > > 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
> >> >> > > [    0.535912] Bad block table found at page 65472, version 0x0=
1
> >> >> > > [    0.544268] Bad block table found at page 65408, version 0x0=
1
> >> >> > > [    0.954329] 9 fixed-partitions partitions found on MTD devic=
e
> >> >> > > brcmnand.0
> >> >> > > ...
> >> >> > >
> >> >> > > This is the log with block protection enabled:
> >> >> > > [    0.495095] bcm6368_nand 10000200.nand: there is not valid m=
aps
> >> >> > > for
> >> >> > > state default
> >> >> > > [    0.504249] nand: device found, Manufacturer ID: 0xc2, Chip =
ID:
> >> >> > > 0xf1
> >> >> > > [    0.510772] nand: Macronix MX30LF1G18AC
> >> >> > > [    0.514874] nand: 128 MiB, SLC, erase size: 128 KiB, page si=
ze:
> >> >> > > 2048, OOB size: 64
> >> >> > > [    0.522780] bcm6368_nand 10000200.nand: detected 128MiB tota=
l,
> >> >> > > 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
> >> >> > > [    0.539687] Bad block table not found for chip 0
> >> >> > > [    0.550153] Bad block table not found for chip 0
> >> >> > > [    0.555069] Scanning device for bad blocks
> >> >> > > [    0.601213] CPU 1 Unable to handle kernel paging request at
> >> >> > > virtual
> >> >> > > address 10277f00, epc =3D=3D 8039ce70, ra =3D=3D 8016ad50
> >> >> > > *** Device hangs ***
> >> >> > >
> >> >> > > Enabling macronix_nand_block_protection_support() makes the dev=
ice
> >> >> > > unable to detect the bad block table and hangs it when trying t=
o
> >> >> > > scan
> >> >> > > for bad blocks.
> >> >> >
> >> >> > Please trace nand_macronix.c and look:
> >> >> > - are the get_features and set_features really supported by the
> >> >> >   controller driver?
> >> >>
> >> >> This is what I could find by debugging:
> >> >> [    0.494993] bcm6368_nand 10000200.nand: there is not valid maps =
for
> >> >> state default
> >> >> [    0.505375] nand: device found, Manufacturer ID: 0xc2, Chip ID:
> >> >> 0xf1
> >> >> [    0.512077] nand: Macronix MX30LF1G18AC
> >> >> [    0.515994] nand: 128 MiB, SLC, erase size: 128 KiB, page size:
> >> >> 2048, OOB size: 64
> >> >> [    0.523928] bcm6368_nand 10000200.nand: detected 128MiB total,
> >> >> 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
> >> >> [    0.534415] bcm6368_nand 10000200.nand: ll_op cmd 0xa00ee
> >> >> [    0.539988] bcm6368_nand 10000200.nand: ll_op cmd 0x600a0
> >> >> [    0.545659] bcm6368_nand 10000200.nand: ll_op cmd 0x10000
> >> >> [    0.551214] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURES =
=3D
> >> >> 0x00
> >> >> [    0.557843] bcm6368_nand 10000200.nand: ll_op cmd 0x10000
> >> >> [    0.563475] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURES =
=3D
> >> >> 0x00
> >> >> [    0.569998] bcm6368_nand 10000200.nand: ll_op cmd 0x10000
> >> >> [    0.575653] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURES =
=3D
> >> >> 0x00
> >> >> [    0.582246] bcm6368_nand 10000200.nand: ll_op cmd 0x80010000
> >> >> [    0.588067] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURES =
=3D
> >> >> 0x00
> >> >> [    0.594657] nand: nand_get_features: addr=3Da0 subfeature_param=
=3D[00
> >> >> 00 00 00] -> 0
> >> >> [    0.602341] macronix_nand_block_protection_support:
> >> >> ONFI_FEATURE_ADDR_MXIC_PROTECTION=3D0
> >> >> [    0.610548] macronix_nand_block_protection_support: !=3D
> >> >> MXIC_BLOCK_PROTECTION_ALL_LOCK
> >> >> [    0.624760] Bad block table not found for chip 0
> >> >> [    0.635542] Bad block table not found for chip 0
> >> >> [    0.640270] Scanning device for bad blocks
> >> >>
> >> >> I don't know how to tell if get_features / set_features is really
> >> >> supported...
> >> >
> >> > Looks like your driver does not support exec_op but the core provide=
s a
> >> > get/set_feature implementation.
> >>
> >> According to Florian, low level should be supported on brcmnand
> >> controllers >=3D 4.0
> >> Also:
> >> https://github.com/nomis/bcm963xx_4.12L.06B_consumer/blob/e2f23ddbb20b=
f75689372b6e6a5a0dc613f6e313/shared/opensource/include/bcm963xx/63268_map_p=
art.h#L1597
> >
> > Just to be sure, you're using a mainline controller driver, not this
> > one?
>
> Yes, this was just to prove that the HW I=E2=80=99m using has get/set fea=
tures support.
> I=E2=80=99m using OpenWrt, so it=E2=80=99s linux v5.15 driver.
>
> >
> >> >
> >> >>
> >> >> > - what is the state of the locking configuration in the chip when
> >> >> > you
> >> >> >   boot?
> >> >>
> >> >> Unlocked, I guess...
> >> >> How can I check that?
> >> >
> >> > It's in your dump, the chip returns 0, meaning it's all unlocked,
> >> > apparently.
> >>
> >> Well, I can read/write the device if block protection isn=E2=80=99t di=
sabled,
> >> so I guess we can confirm it=E2=80=99s unlocked=E2=80=A6
> >>
> >> >
> >> >> > - is there anything that locks the device by calling mxic_nand_lo=
ck()
> >> >> > ?
> >> >
> >> > So nobody locks the device I guess? Did you add traces there?
> >>
> >> It doesn=E2=80=99t get to the point that it enabled the lock/unlock fu=
nctions
> >> since it fails when checking if feature is 0x38, so there=E2=80=99s no=
 point
> >> in adding those traces=E2=80=A6
> >
> > Right, it returns before setting these I guess.
> >
> >>
> >> >
> >> >> > - finding no bbt is one thing, hanging is another, where is it
> >> >> > hanging
> >> >> >   exactly? (offset in nand/ and line in the code)
> >> >>
> >> >> I've got no idea...
> >> >
> >> > You can use ftrace or just add printks a bit everywhere and try to g=
et
> >> > closer and closer.
> >>
> >> I think that after trying to get the feature it just start reading
> >> nonsense from the NAND and at some point it hangs due to that garbage=
=E2=80=A6
> >
> > It should refuse to mount the device somehow, but in no case the kernel
> > should hang.
>
> Yes, I think that this is a side effect (maybe a different bug somewhere =
else).
>
> >
> >> Is it posible that the NAND starts behaving like this after getting
> >> the feature due to some specific config of my device?
> >>
> >> >
> >> > I looked at the patch, I don't see anything strange. Besides, I have=
 a
> >> > close enough datasheet and I don't see what could confuse the device=
.
> >> >
> >> > Are you really sure this patch is the problem? Is the WP pin wired o=
n
> >> > your design?
> >>
> >> There=E2=80=99s no WP pin in brcmnand controllers < 7.0
> >
> > What about the chip?
>
> Maybe it has a GPIO controlling that, but I don=E2=80=99t have that info=
=E2=80=A6
>
> >
> > Thanks,
> > Miqu=C3=A8l
> >
