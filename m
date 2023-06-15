Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379B47310F4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244237AbjFOHit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjFOHig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:38:36 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFCA2D4E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:38:06 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7872d7b79e1so1274165241.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686814666; x=1689406666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rj1FWSaP+wR2k09BkLiQXkojh6+CJ0TIXrVVOY/1fNI=;
        b=MWiZ/egKtAFrgJ2+UakmLX8cHWZLVe4XnDjn1lJq8NtRnXCM0PkkSBOsjCUR5zBed4
         rBzDOj3HmVT1pdViv7mD/HUGzfnu83JuhKDqN3BSYb3kVUwnXG6wqDrsKS+jXYJwXBZY
         cEel+fai2AJR5/G5U1vA0Q2areBdDmcpsDHj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686814666; x=1689406666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rj1FWSaP+wR2k09BkLiQXkojh6+CJ0TIXrVVOY/1fNI=;
        b=PrVBcHDtz+NP/o7NGkqfZl/chERQXah5G1TXSeOyWUauTpLxnTDyMIO8IOe5EBjfYr
         RPdanxTrMQYT++mYVfI+OYvlKNaocbf0phYS6KK55wxuF3lhnAE9IEuVnLAeVIdwyBJi
         DEsXXNtC8ez9M/OFTHFVwDUgSsZ/OI/uEn8XVoCmW7+Y+ClrlGwuXp6oZjTIc2BhLvWk
         ylFWC5eIDST8TtY7sc6+0iAKcZx4npiutp9zL3XOUOYimSlhSEC0SKA1qM1qkyLghtTh
         KFYBu8azMDKZhVShonTJIJQ2MCBIf9j1JppYYxJ3fblw85l5h4Piu4qPFMCdBgAu5c4n
         g9iw==
X-Gm-Message-State: AC+VfDzugLusWCTnfKsYpslKJX6VuxBWzjKtQIRqYqy3jbOoX4Fom/bI
        Q9WvB4rEIHc+MHMaqv6+/hhHyQcab+vayfSFrrT4mg==
X-Google-Smtp-Source: ACHHUZ7u2STWo0SwYbCs+SN8pial2kpqQLSUjVG7hKMNiBLDDv73WRlWui6r9LAiUbqqpE6DB37ApSsX0LNxO0Gf4iM=
X-Received: by 2002:a67:f7d7:0:b0:43f:54b4:d763 with SMTP id
 a23-20020a67f7d7000000b0043f54b4d763mr2119310vsp.3.1686814665777; Thu, 15 Jun
 2023 00:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230609083009.2822259-1-wenst@chromium.org> <20230609083009.2822259-4-wenst@chromium.org>
 <CAJ66y9H91WaRxaZzXRYc5LN9t+M+ZpEy6nbgo=W1kOn_Yu_BCg@mail.gmail.com>
In-Reply-To: <CAJ66y9H91WaRxaZzXRYc5LN9t+M+ZpEy6nbgo=W1kOn_Yu_BCg@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 15 Jun 2023 15:37:34 +0800
Message-ID: <CAGXv+5FOy+d_j=8uKHwUqih_po=Pt590BkBGMFc+Td9rBhutRA@mail.gmail.com>
Subject: Re: [PATCH 3/9] regulator: mt6358: Merge VCN33_* regulators
To:     Fei Shao <fshao@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Mon, Jun 12, 2023 at 6:57=E2=80=AFPM Fei Shao <fshao@chromium.org> wrote=
:
>
> On Fri, Jun 9, 2023 at 4:30=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
> >
> > The VCN33_BT and VCN33_WIFI regulators are actually the same regulator,
> > having the same voltage setting and output pin. There are simply two
> > enable bits that are ORed together to enable the regulator.
> >
> > Having two regulators representing the same output pin is misleading
> > from a design matching standpoint, and also error-prone in driver
> > implementations. If consumers try to set different voltages on either
> > regulator, the one set later would override the one set before. There
> > are ways around this, such as chaining them together and having the
> > downstream one act as a switch. But given there's only one output pin,
> > such a workaround doesn't match reality.
> >
> > Remove the VCN33_WIFI regulator. During the probe phase, have the drive=
r
> > sync the enable status of VCN33_WIFI to VCN33_BT. Also drop the suffix
> > so that the regulator name matches the pin name in the datasheet.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  drivers/regulator/mt6358-regulator.c       | 65 +++++++++++++++++-----
> >  include/linux/regulator/mt6358-regulator.h |  6 +-
> >  2 files changed, 52 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/m=
t6358-regulator.c
> > index c9e16bd092f6..faf6b0757019 100644
> > --- a/drivers/regulator/mt6358-regulator.c
> > +++ b/drivers/regulator/mt6358-regulator.c
> > @@ -277,7 +277,7 @@ static const unsigned int vcama_voltages[] =3D {
> >         2800000, 2900000, 3000000,
> >  };
> >
> > -static const unsigned int vcn33_bt_wifi_voltages[] =3D {
> > +static const unsigned int vcn33_voltages[] =3D {
> >         3300000, 3400000, 3500000,
> >  };
> >
> > @@ -321,7 +321,7 @@ static const u32 vcama_idx[] =3D {
> >         0, 7, 9, 10, 11, 12,
> >  };
> >
> > -static const u32 vcn33_bt_wifi_idx[] =3D {
> > +static const u32 vcn33_idx[] =3D {
> >         1, 2, 3,
> >  };
> >
> > @@ -566,12 +566,8 @@ static struct mt6358_regulator_info mt6358_regulat=
ors[] =3D {
> >                    MT6358_LDO_VCAMA1_CON0, 0, MT6358_VCAMA1_ANA_CON0, 0=
xf00),
> >         MT6358_LDO("ldo_vemc", VEMC, vmch_vemc_voltages, vmch_vemc_idx,
> >                    MT6358_LDO_VEMC_CON0, 0, MT6358_VEMC_ANA_CON0, 0x700=
),
> > -       MT6358_LDO("ldo_vcn33_bt", VCN33_BT, vcn33_bt_wifi_voltages,
> > -                  vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_0,
> > -                  0, MT6358_VCN33_ANA_CON0, 0x300),
> > -       MT6358_LDO("ldo_vcn33_wifi", VCN33_WIFI, vcn33_bt_wifi_voltages=
,
> > -                  vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_1,
> > -                  0, MT6358_VCN33_ANA_CON0, 0x300),
> > +       MT6358_LDO("ldo_vcn33", VCN33, vcn33_voltages, vcn33_idx,
> > +                  MT6358_LDO_VCN33_CON0_0, 0, MT6358_VCN33_ANA_CON0, 0=
x300),
> >         MT6358_LDO("ldo_vcama2", VCAMA2, vcama_voltages, vcama_idx,
> >                    MT6358_LDO_VCAMA2_CON0, 0, MT6358_VCAMA2_ANA_CON0, 0=
xf00),
> >         MT6358_LDO("ldo_vmc", VMC, vmc_voltages, vmc_idx,
> > @@ -662,12 +658,8 @@ static struct mt6358_regulator_info mt6366_regulat=
ors[] =3D {
> >                    MT6358_LDO_VMCH_CON0, 0, MT6358_VMCH_ANA_CON0, 0x700=
),
> >         MT6366_LDO("ldo_vemc", VEMC, vmch_vemc_voltages, vmch_vemc_idx,
> >                    MT6358_LDO_VEMC_CON0, 0, MT6358_VEMC_ANA_CON0, 0x700=
),
> > -       MT6366_LDO("ldo_vcn33_bt", VCN33_BT, vcn33_bt_wifi_voltages,
> > -                  vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_0,
> > -                  0, MT6358_VCN33_ANA_CON0, 0x300),
> > -       MT6366_LDO("ldo_vcn33_wifi", VCN33_WIFI, vcn33_bt_wifi_voltages=
,
> > -                  vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_1,
> > -                  0, MT6358_VCN33_ANA_CON0, 0x300),
> > +       MT6366_LDO("ldo_vcn33", VCN33, vcn33_voltages, vcn33_idx,
> > +                  MT6358_LDO_VCN33_CON0_0, 0, MT6358_VCN33_ANA_CON0, 0=
x300),
> >         MT6366_LDO("ldo_vmc", VMC, vmc_voltages, vmc_idx,
> >                    MT6358_LDO_VMC_CON0, 0, MT6358_VMC_ANA_CON0, 0xf00),
> >         MT6366_LDO("ldo_vsim2", VSIM2, vsim_voltages, vsim_idx,
> > @@ -690,13 +682,56 @@ static struct mt6358_regulator_info mt6366_regula=
tors[] =3D {
> >                     MT6358_LDO_VSRAM_CON1, 0x7f),
> >  };
> >
> > +static int mt6358_sync_vcn33_setting(struct device *dev)
> > +{
> > +       struct mt6397_chip *mt6397 =3D dev_get_drvdata(dev->parent);
> > +       unsigned int val;
> > +       int ret;
> > +
> > +       /*
> > +        * VCN33_WIFI and VCN33_BT are two separate enable bits for the=
 same
> > +        * regulator. They share the same voltage setting and output pi=
n.
> > +        * Instead of having two potentially conflicting regulators, ju=
st have
> > +        * one VCN33 regulator. Sync the two enable bits and only use o=
ne in
> > +        * the regulator device.
> > +        */
> > +       ret =3D regmap_read(mt6397->regmap, MT6358_LDO_VCN33_CON0_1, &v=
al);
> > +       if (ret) {
> > +               dev_err(dev, "Failed to read VCN33_WIFI setting\n");
> > +               return ret;
> > +       }
> > +
> > +       if (!(val & BIT(0)))
> > +               return 0;
> > +
> > +       /* Sync VCN33_WIFI enable status to VCN33_BT */
> > +       ret =3D regmap_update_bits(mt6397->regmap, MT6358_LDO_VCN33_CON=
0_0, BIT(0), BIT(0));
> > +       if (ret) {
> > +               dev_err(dev, "Failed to sync VCN33_WIFI setting to VCN3=
3_BT\n");
> > +               return ret;
> > +       }
> > +
> > +       /* Disable VCN33_WIFI */
> > +       ret =3D regmap_update_bits(mt6397->regmap, MT6358_LDO_VCN33_CON=
0_1, BIT(0), 0);
> > +       if (ret) {
> > +               dev_err(dev, "Failed to disable VCN33_BT\n");
>
> I think it should be "VCN33_WIFI" in the error message?

Mark already merged the patch. I send followup fixes for this and the
call sequence.

ChenYu
