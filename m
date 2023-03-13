Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAE26B74FE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjCMLAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjCMK7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:59:54 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2BA34C35;
        Mon, 13 Mar 2023 03:59:25 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id y189so2459178pgb.10;
        Mon, 13 Mar 2023 03:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678705158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vsy2LwxeFUk+ZOJmYzV0ZLx3OS9N/i1hwSUV0kkdxCM=;
        b=bGuZD/VLxXcb3aGciJIohMPcL7qBZxHLur9yZGiHL7e3FcGESx3W0w2U5CH+lOz7ql
         GAVxl5ckJKkz/aumySGqDDs9kVdMaaB0zOCwdCegFhftcGvXO9qCWZ9A49/IHaDAOr5u
         7A8kkbvZHC/PSNJO7y7lMZTNqhimTZs3O2su+S3EjmqtaUwSTmxCuLWtaKrWQRXW+e5d
         pBh0vrjTfreRS/p5qO5eqfNbLc+B74PqNv2sPBE2f2xP1xTL4bPfHB2rQL1I14u9Uf6A
         guQ027QE7frLarMNqZk1eFV/6Zs1S/9M2Sp3t8oafiY4BG3c+2mWQp7mlgkpnkbUVc3i
         pQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678705158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vsy2LwxeFUk+ZOJmYzV0ZLx3OS9N/i1hwSUV0kkdxCM=;
        b=qx9lAnHEqlvgxpmzEHUvey7Uoctp30INvZvJZWtfX4dmFda53k16Ny4HMGLNVC7ymd
         AsEmbxn4hmXR8tvs3s6rkGsMUYNf76ZhsYkKc2fvGhm7EVHyb1Zt9XosL+C69Es2odZB
         lhijNi8HyDkE1fA7kOgGByzWMObAgs5mNoDpik4PgCW44KAu84ffPHRUMgVHMLMzTH56
         YLSu0k/1bKwkfs/j/qEBBkQivPZT4Xt2OBTnUnWTtnTcBE/ygVgaXgIHQPkU0/VUD1h7
         hlJ2MNG/DjsBqitYioBQ+xtWz19ZgOemfELNZ08yuB4OYwkgtCU09FB6xuQvzpeBqQ3Y
         UEfw==
X-Gm-Message-State: AO0yUKXA8DFo9neqRkb/Nm+uGH1WIZ6oPjNikK9D9HpQto86qp8O7oj2
        qEA38iDxW9EOHTlM1fkoEl18i28PKp0W6vqqqZA=
X-Google-Smtp-Source: AK7set9Ehv9CzLEw3Sa0anMtfKyS2uQ3vqf1+BmUiwQX01+JeYZP96vMT79fOk02aIOJdh8qCoKrQCbVt6qSSsI447k=
X-Received: by 2002:a05:6a00:14d6:b0:5aa:310c:e65b with SMTP id
 w22-20020a056a0014d600b005aa310ce65bmr14168933pfu.2.1678705158151; Mon, 13
 Mar 2023 03:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230310144656.1540950-1-robh@kernel.org> <c2191745-714c-7cdc-ba2d-a254245bbdac@linaro.org>
In-Reply-To: <c2191745-714c-7cdc-ba2d-a254245bbdac@linaro.org>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Mon, 13 Mar 2023 11:59:06 +0100
Message-ID: <CAOiHx=m+q8ALpESkudkTPL3XKWz2O0-JGGVD0CqWbq3xQ-6dng@mail.gmail.com>
Subject: Re: [PATCH] mips: Use of_property_read_bool() for boolean properties
To:     =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi,

On Mon, 13 Mar 2023 at 09:31, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
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
> Just curious, is this property correct? I can't find it and wonder if
> this is dead code (always disabling the clock)... I'm probably missing
> something obvious :/
>
> >               clk_enable(clk_external);
> >       else
> >               clk_disable(clk_external);

The (whole) binding does seem to be undocumented, at least a quick
grep didn't find anything for "lantiq,pci-xway" in bindings :-/

The property itself is used in OpenWrt though, e.g.
https://github.com/openwrt/openwrt/blob/master/target/linux/lantiq/files/ar=
ch/mips/boot/dts/lantiq/danube_arcadyan_arv7518pw.dts#L209

Regards
Jonas
