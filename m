Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4A872B629
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 05:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjFLDlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 23:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjFLDl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:41:28 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562AC13D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 20:41:27 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-78676ca8435so3053011241.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 20:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686541286; x=1689133286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0yObU04YXPKaEXcwQwsNv6xKVAxQLOf2xkwrlUP+rU=;
        b=Yu9Y8pLbZVjWpVTJxr+nJLC+x4fmPdNp2vnd4LmRDpy5/e3vJU9c7M4rvkAhNmYb+5
         tgF1wrdIr2Z92r1ie9HBkC64JdpD3meCjcCMgOLMvLygOqbvA3yTXVjzRy0Llcdv4zpx
         rejUqW/ThF9rDI++hd1O2IqkOORMWMERiLtCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686541286; x=1689133286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0yObU04YXPKaEXcwQwsNv6xKVAxQLOf2xkwrlUP+rU=;
        b=SdENhp8TsKuyGFMgnXuj5VRWy2xSUX20Oi7ADXKXVKgGN8khxSKgI78t9sX3pOOrYi
         1+fBnMzTJP3CNQMcMKnuy7TscYP5mXSN+lcBELRHjhnIlrahmkTimQL5jCCxO9tSTAGv
         4+Hz5D1KZljQE8/8UTkPOpuekTUWqv8AGptiBsibA/ymsAjKu9LvHE7iFbrGWd5MejXO
         Hlh256L1Z4BSD7moKuDvGAa6k7YpoVhqBLjlW78zNZnMxemvBVmkIkQ4N2xoJI/jKEJU
         Q/PySljDKOn+KCct9BgKwBpawxFuGEESBw+jtcIFUDCXkxefdAmRR1krBLqrGrdNTZfk
         IURQ==
X-Gm-Message-State: AC+VfDxdSP+5WyQf9lg0l44EbYxfMdv699M0WSnOh33g1MzjKAkB1SZE
        N4HB+XiKRRQuWtV2amOktbs2Vcv47NYekd2e24iX9A==
X-Google-Smtp-Source: ACHHUZ7aRRMTX5aeSzx7lEcBi3oa1seaW5Y2o10aJStTIUjlp+y8oBg9SDllqefozc4/ijT9j1m7RrhHC7h0Sf9ibRs=
X-Received: by 2002:a05:6122:d94:b0:458:8ee3:cad9 with SMTP id
 bc20-20020a0561220d9400b004588ee3cad9mr3545673vkb.8.1686541286415; Sun, 11
 Jun 2023 20:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230609083009.2822259-1-wenst@chromium.org> <20230609083009.2822259-4-wenst@chromium.org>
 <07816a63-0d54-aced-a109-209c446f6bfa@collabora.com>
In-Reply-To: <07816a63-0d54-aced-a109-209c446f6bfa@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 12 Jun 2023 11:41:15 +0800
Message-ID: <CAGXv+5ESw8PR92pQL7+hgphBirBVSDW5qCcZyadWPZ2Sg5h8DA@mail.gmail.com>
Subject: Re: [PATCH 3/9] regulator: mt6358: Merge VCN33_* regulators
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
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

On Fri, Jun 9, 2023 at 4:58=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 09/06/23 10:30, Chen-Yu Tsai ha scritto:
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
> >   drivers/regulator/mt6358-regulator.c       | 65 +++++++++++++++++----=
-
> >   include/linux/regulator/mt6358-regulator.h |  6 +-
> >   2 files changed, 52 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/m=
t6358-regulator.c
> > index c9e16bd092f6..faf6b0757019 100644
> > --- a/drivers/regulator/mt6358-regulator.c
> > +++ b/drivers/regulator/mt6358-regulator.c
> > @@ -277,7 +277,7 @@ static const unsigned int vcama_voltages[] =3D {
> >       2800000, 2900000, 3000000,
> >   };
> >
> > -static const unsigned int vcn33_bt_wifi_voltages[] =3D {
> > +static const unsigned int vcn33_voltages[] =3D {
> >       3300000, 3400000, 3500000,
> >   };
> >
> > @@ -321,7 +321,7 @@ static const u32 vcama_idx[] =3D {
> >       0, 7, 9, 10, 11, 12,
> >   };
> >
> > -static const u32 vcn33_bt_wifi_idx[] =3D {
> > +static const u32 vcn33_idx[] =3D {
> >       1, 2, 3,
> >   };
> >
> > @@ -566,12 +566,8 @@ static struct mt6358_regulator_info mt6358_regulat=
ors[] =3D {
> >                  MT6358_LDO_VCAMA1_CON0, 0, MT6358_VCAMA1_ANA_CON0, 0xf=
00),
> >       MT6358_LDO("ldo_vemc", VEMC, vmch_vemc_voltages, vmch_vemc_idx,
> >                  MT6358_LDO_VEMC_CON0, 0, MT6358_VEMC_ANA_CON0, 0x700),
> > -     MT6358_LDO("ldo_vcn33_bt", VCN33_BT, vcn33_bt_wifi_voltages,
> > -                vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_0,
> > -                0, MT6358_VCN33_ANA_CON0, 0x300),
> > -     MT6358_LDO("ldo_vcn33_wifi", VCN33_WIFI, vcn33_bt_wifi_voltages,
> > -                vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_1,
> > -                0, MT6358_VCN33_ANA_CON0, 0x300),
> > +     MT6358_LDO("ldo_vcn33", VCN33, vcn33_voltages, vcn33_idx,
> > +                MT6358_LDO_VCN33_CON0_0, 0, MT6358_VCN33_ANA_CON0, 0x3=
00),
> >       MT6358_LDO("ldo_vcama2", VCAMA2, vcama_voltages, vcama_idx,
> >                  MT6358_LDO_VCAMA2_CON0, 0, MT6358_VCAMA2_ANA_CON0, 0xf=
00),
> >       MT6358_LDO("ldo_vmc", VMC, vmc_voltages, vmc_idx,
> > @@ -662,12 +658,8 @@ static struct mt6358_regulator_info mt6366_regulat=
ors[] =3D {
> >                  MT6358_LDO_VMCH_CON0, 0, MT6358_VMCH_ANA_CON0, 0x700),
> >       MT6366_LDO("ldo_vemc", VEMC, vmch_vemc_voltages, vmch_vemc_idx,
> >                  MT6358_LDO_VEMC_CON0, 0, MT6358_VEMC_ANA_CON0, 0x700),
> > -     MT6366_LDO("ldo_vcn33_bt", VCN33_BT, vcn33_bt_wifi_voltages,
> > -                vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_0,
> > -                0, MT6358_VCN33_ANA_CON0, 0x300),
> > -     MT6366_LDO("ldo_vcn33_wifi", VCN33_WIFI, vcn33_bt_wifi_voltages,
> > -                vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_1,
> > -                0, MT6358_VCN33_ANA_CON0, 0x300),
> > +     MT6366_LDO("ldo_vcn33", VCN33, vcn33_voltages, vcn33_idx,
> > +                MT6358_LDO_VCN33_CON0_0, 0, MT6358_VCN33_ANA_CON0, 0x3=
00),
> >       MT6366_LDO("ldo_vmc", VMC, vmc_voltages, vmc_idx,
> >                  MT6358_LDO_VMC_CON0, 0, MT6358_VMC_ANA_CON0, 0xf00),
> >       MT6366_LDO("ldo_vsim2", VSIM2, vsim_voltages, vsim_idx,
> > @@ -690,13 +682,56 @@ static struct mt6358_regulator_info mt6366_regula=
tors[] =3D {
> >                   MT6358_LDO_VSRAM_CON1, 0x7f),
> >   };
> >
> > +static int mt6358_sync_vcn33_setting(struct device *dev)
> > +{
> > +     struct mt6397_chip *mt6397 =3D dev_get_drvdata(dev->parent);
> > +     unsigned int val;
> > +     int ret;
> > +
> > +     /*
> > +      * VCN33_WIFI and VCN33_BT are two separate enable bits for the s=
ame
> > +      * regulator. They share the same voltage setting and output pin.
> > +      * Instead of having two potentially conflicting regulators, just=
 have
> > +      * one VCN33 regulator. Sync the two enable bits and only use one=
 in
> > +      * the regulator device.
> > +      */
> > +     ret =3D regmap_read(mt6397->regmap, MT6358_LDO_VCN33_CON0_1, &val=
);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to read VCN33_WIFI setting\n");
> > +             return ret;
> > +     }
> > +
> > +     if (!(val & BIT(0)))
> > +             return 0;
> > +
> > +     /* Sync VCN33_WIFI enable status to VCN33_BT */
> > +     ret =3D regmap_update_bits(mt6397->regmap, MT6358_LDO_VCN33_CON0_=
0, BIT(0), BIT(0));
> > +     if (ret) {
> > +             dev_err(dev, "Failed to sync VCN33_WIFI setting to VCN33_=
BT\n");
> > +             return ret;
> > +     }
> > +
> > +     /* Disable VCN33_WIFI */
> > +     ret =3D regmap_update_bits(mt6397->regmap, MT6358_LDO_VCN33_CON0_=
1, BIT(0), 0);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to disable VCN33_BT\n");
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >   static int mt6358_regulator_probe(struct platform_device *pdev)
> >   {
> >       struct mt6397_chip *mt6397 =3D dev_get_drvdata(pdev->dev.parent);
> >       struct regulator_config config =3D {};
> >       struct regulator_dev *rdev;
> >       struct mt6358_regulator_info *mt6358_info;
> > -     int i, max_regulator;
> > +     int i, max_regulator, ret;
> > +
> > +     ret =3D mt6358_sync_vcn33_setting(&pdev->dev);
> > +     if (ret)
> > +             return ret;
>
> I'd put this after the chip_id check, and I would also add a safety check=
 for
> that...
>
>         switch (mt6397->chip_id) {
>         case MT6366_CHIP_ID:
>                 max_regulator =3D MT6366_MAX_REGULATOR;
>                 mt6358_info =3D mt6366_regulators;
>                 break;
>         case MT6358_CHIP_ID:
>                 max_regulator =3D MT6358_MAX_REGULATOR;
>                 mt6358_info =3D mt6358_regulators;
>                 break;
>         default:
>                 return -EINVAL;
>         }
>
>         ret =3D mt6358_sync_vcn33_setting(....)

Sounds good. We wouldn't want to be poking random bits in some other PMIC.

> ...but I agree with your point here about this being a strange design and
> also with your way of fixing the driver.

What I heard was that they support separate Bluetooth and WiFi drivers that
don't have a common reference counting framework for their regulator
supplies using this scheme. Maybe they are doing the power sequencing in
some small firmware.

ChenYu
