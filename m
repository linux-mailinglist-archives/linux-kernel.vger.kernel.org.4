Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AC16CF6B0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 01:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjC2XIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 19:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjC2XIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:08:00 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64613596
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 16:07:57 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id e65so21380546ybh.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 16:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680131277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17W1Vyy8xywZeBqJlfSIAYU63G4aFCmdnFdPrSLNAkg=;
        b=jQgPlWdUIryVzMWz5eYCVlqf1Jx9xGi5sRKJqPKAN8hOHtO7Qknopt659dtHlGEmtl
         qzxvaxV6bJCAaPLVg2CyYOtNFHOdP5+cYM065FUE1aZuAfMYnYP2/OLaip4P55Khk2uS
         0GAb+mee2/y0d1vdm8svbShyI3AIXYcPC26QfxwbhAbt8xOsYmBtscC2QZpbk7QRSo7Z
         5wUwof8bZEXyZBP48Y0ZI8q7Mf8SBnRl844jIbwqOUaFR7zHRfHn7LS7bcxf8JlLf0dZ
         wapKtcuRbKsbfRH3rYQmh1t3AwIqxWFzqArFx9F0IAKNr80DBfu4O+LFnClphXgE6FhC
         XISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680131277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17W1Vyy8xywZeBqJlfSIAYU63G4aFCmdnFdPrSLNAkg=;
        b=oaZGLfmIPdRPmWbiPOuicNoM6sOU8skgfCR8F6tDYj0+xPjlPEUIONJNKH2J1ef2YN
         FGJxb2XMwDn9NdGKOKGuuH7dLdoVL39BJrH+LH8hIVePrztqwYSWuAhn2+hdIAv3mWKT
         LCgd1Y9N+UiA6UngXzLW/O+s7ZbLz9EVQsv7PBBycJztEnjC5xYDTRuXZpFAGZHdqWM+
         t4/aqIhQfA0+hBEKrqkW5/vBzkfhqjcd4KdIBV/MC8LqGMOhO/8Mhinc3fa5K7eJfb+E
         UgltBUI/St6d0paz1EdzGaWnevSomzBE0ATeIdCbCztooY1ooc/Y5TmJTqbezfq555cV
         98Ug==
X-Gm-Message-State: AAQBX9d9KHi0TEpaPz9MN/JvtgtEebcifo6/33mys2jTqTbdcioVq7UY
        J8o1h77NlZ22emcDvQ8lNP6hJFbGbfbMGzKy/pysrg==
X-Google-Smtp-Source: AKy350a5GZphBEgM8UisHAQrdtCXXOGmCc4O5BP2CwRX+zobEpWFYGZuSLf5PGCtIbsbkgteYBCmjBU4RiB4peKzOqs=
X-Received: by 2002:a05:6902:1501:b0:b6d:80ab:8bb6 with SMTP id
 q1-20020a056902150100b00b6d80ab8bb6mr14095187ybu.1.1680131276952; Wed, 29 Mar
 2023 16:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230324094205.33266-1-angelogioacchino.delregno@collabora.com> <20230324094205.33266-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230324094205.33266-7-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 30 Mar 2023 01:07:45 +0200
Message-ID: <CAFGrd9pR+8MVNcXyb2JPoL3wzksNdY08kUGPtH+NmawTW8uU1w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] soc: mediatek: pwrap: Add support for MT6795 Helio X10
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, flora.fu@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

" or

Le ven. 24 mars 2023 =C3=A0 10:42, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> a =C3=A9crit :
>
> Add the necessary bits to support the MT6795 Helio X10 smartphone SoC:
> this is always paired with a MT6331 PMIC, with MT6332 companion.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 131 ++++++++++++++++++++++++++-
>  1 file changed, 130 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/=
mtk-pmic-wrap.c
> index ceeac43f7bd1..20d32328382a 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -639,6 +639,91 @@ static int mt6779_regs[] =3D {
>         [PWRAP_WACS2_VLDCLR] =3D          0xC28,
>  };
>
> +static int mt6795_regs[] =3D {
> +       [PWRAP_MUX_SEL] =3D               0x0,
> +       [PWRAP_WRAP_EN] =3D               0x4,
> +       [PWRAP_DIO_EN] =3D                0x8,
> +       [PWRAP_SIDLY] =3D                 0xc,
> +       [PWRAP_RDDMY] =3D                 0x10,
> +       [PWRAP_SI_CK_CON] =3D             0x14,
> +       [PWRAP_CSHEXT_WRITE] =3D          0x18,
> +       [PWRAP_CSHEXT_READ] =3D           0x1c,
> +       [PWRAP_CSLEXT_START] =3D          0x20,
> +       [PWRAP_CSLEXT_END] =3D            0x24,
> +       [PWRAP_STAUPD_PRD] =3D            0x28,
> +       [PWRAP_STAUPD_GRPEN] =3D          0x2c,
> +       [PWRAP_EINT_STA0_ADR] =3D         0x30,
> +       [PWRAP_EINT_STA1_ADR] =3D         0x34,
> +       [PWRAP_STAUPD_MAN_TRIG] =3D       0x40,
> +       [PWRAP_STAUPD_STA] =3D            0x44,
> +       [PWRAP_WRAP_STA] =3D              0x48,
> +       [PWRAP_HARB_INIT] =3D             0x4c,
> +       [PWRAP_HARB_HPRIO] =3D            0x50,
> +       [PWRAP_HIPRIO_ARB_EN] =3D         0x54,
> +       [PWRAP_HARB_STA0] =3D             0x58,
> +       [PWRAP_HARB_STA1] =3D             0x5c,
> +       [PWRAP_MAN_EN] =3D                0x60,
> +       [PWRAP_MAN_CMD] =3D               0x64,
> +       [PWRAP_MAN_RDATA] =3D             0x68,
> +       [PWRAP_MAN_VLDCLR] =3D            0x6c,
> +       [PWRAP_WACS0_EN] =3D              0x70,
> +       [PWRAP_INIT_DONE0] =3D            0x74,
> +       [PWRAP_WACS0_CMD] =3D             0x78,
> +       [PWRAP_WACS0_RDATA] =3D           0x7c,
> +       [PWRAP_WACS0_VLDCLR] =3D          0x80,
> +       [PWRAP_WACS1_EN] =3D              0x84,
> +       [PWRAP_INIT_DONE1] =3D            0x88,
> +       [PWRAP_WACS1_CMD] =3D             0x8c,
> +       [PWRAP_WACS1_RDATA] =3D           0x90,
> +       [PWRAP_WACS1_VLDCLR] =3D          0x94,
> +       [PWRAP_WACS2_EN] =3D              0x98,
> +       [PWRAP_INIT_DONE2] =3D            0x9c,
> +       [PWRAP_WACS2_CMD] =3D             0xa0,
> +       [PWRAP_WACS2_RDATA] =3D           0xa4,
> +       [PWRAP_WACS2_VLDCLR] =3D          0xa8,
> +       [PWRAP_INT_EN] =3D                0xac,
> +       [PWRAP_INT_FLG_RAW] =3D           0xb0,
> +       [PWRAP_INT_FLG] =3D               0xb4,
> +       [PWRAP_INT_CLR] =3D               0xb8,
> +       [PWRAP_SIG_ADR] =3D               0xbc,
> +       [PWRAP_SIG_MODE] =3D              0xc0,
> +       [PWRAP_SIG_VALUE] =3D             0xc4,
> +       [PWRAP_SIG_ERRVAL] =3D            0xc8,
> +       [PWRAP_CRC_EN] =3D                0xcc,
> +       [PWRAP_TIMER_EN] =3D              0xd0,
> +       [PWRAP_TIMER_STA] =3D             0xd4,
> +       [PWRAP_WDT_UNIT] =3D              0xd8,
> +       [PWRAP_WDT_SRC_EN] =3D            0xdc,
> +       [PWRAP_WDT_FLG] =3D               0xe0,
> +       [PWRAP_DEBUG_INT_SEL] =3D         0xe4,
> +       [PWRAP_DVFS_ADR0] =3D             0xe8,
> +       [PWRAP_DVFS_WDATA0] =3D           0xec,
> +       [PWRAP_DVFS_ADR1] =3D             0xf0,
> +       [PWRAP_DVFS_WDATA1] =3D           0xf4,
> +       [PWRAP_DVFS_ADR2] =3D             0xf8,
> +       [PWRAP_DVFS_WDATA2] =3D           0xfc,
> +       [PWRAP_DVFS_ADR3] =3D             0x100,
> +       [PWRAP_DVFS_WDATA3] =3D           0x104,
> +       [PWRAP_DVFS_ADR4] =3D             0x108,
> +       [PWRAP_DVFS_WDATA4] =3D           0x10c,
> +       [PWRAP_DVFS_ADR5] =3D             0x110,
> +       [PWRAP_DVFS_WDATA5] =3D           0x114,
> +       [PWRAP_DVFS_ADR6] =3D             0x118,
> +       [PWRAP_DVFS_WDATA6] =3D           0x11c,
> +       [PWRAP_DVFS_ADR7] =3D             0x120,
> +       [PWRAP_DVFS_WDATA7] =3D           0x124,
> +       [PWRAP_SPMINF_STA] =3D            0x128,
> +       [PWRAP_CIPHER_KEY_SEL] =3D        0x12c,
> +       [PWRAP_CIPHER_IV_SEL] =3D         0x130,
> +       [PWRAP_CIPHER_EN] =3D             0x134,
> +       [PWRAP_CIPHER_RDY] =3D            0x138,
> +       [PWRAP_CIPHER_MODE] =3D           0x13c,
> +       [PWRAP_CIPHER_SWRST] =3D          0x140,
> +       [PWRAP_DCM_EN] =3D                0x144,
> +       [PWRAP_DCM_DBC_PRD] =3D           0x148,
> +       [PWRAP_EXT_CK] =3D                0x14c,
> +};
> +
>  static int mt6797_regs[] =3D {
>         [PWRAP_MUX_SEL] =3D               0x0,
>         [PWRAP_WRAP_EN] =3D               0x4,
> @@ -1230,6 +1315,7 @@ enum pwrap_type {
>         PWRAP_MT2701,
>         PWRAP_MT6765,
>         PWRAP_MT6779,
> +       PWRAP_MT6795,
>         PWRAP_MT6797,
>         PWRAP_MT6873,
>         PWRAP_MT7622,
> @@ -1650,6 +1736,20 @@ static void pwrap_init_chip_select_ext(struct pmic=
_wrapper *wrp, u8 hext_write,
>  static int pwrap_common_init_reg_clock(struct pmic_wrapper *wrp)
>  {
>         switch (wrp->master->type) {
> +       case PWRAP_MT6795:
> +               if (wrp->slave->type =3D=3D PMIC_MT6331) {
> +                       const u32 *dew_regs =3D wrp->slave->dew_regs;
> +
> +                       pwrap_write(wrp, dew_regs[PWRAP_DEW_RDDMY_NO], 0x=
8);
> +
> +                       if (wrp->slave->comp_type =3D=3D PMIC_MT6332) {
> +                               dew_regs =3D wrp->slave->comp_dew_regs;
> +                               pwrap_write(wrp, dew_regs[PWRAP_DEW_RDDMY=
_NO], 0x8);
> +                       }
> +               }
> +               pwrap_writel(wrp, 0x88, PWRAP_RDDMY);
> +               pwrap_init_chip_select_ext(wrp, 15, 15, 15, 15);
> +               break;
>         case PWRAP_MT8173:
>                 pwrap_init_chip_select_ext(wrp, 0, 4, 2, 2);
>                 break;
> @@ -1744,6 +1844,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *w=
rp)
>         case PWRAP_MT2701:
>         case PWRAP_MT6765:
>         case PWRAP_MT6779:
> +       case PWRAP_MT6795:
>         case PWRAP_MT6797:
>         case PWRAP_MT8173:
>         case PWRAP_MT8186:
> @@ -1914,6 +2015,19 @@ static int pwrap_mt2701_init_soc_specific(struct p=
mic_wrapper *wrp)
>         return 0;
>  }
>
> +static int pwrap_mt6795_init_soc_specific(struct pmic_wrapper *wrp)
> +{
> +       pwrap_writel(wrp, 0xf, PWRAP_STAUPD_GRPEN);
> +
> +       if (wrp->slave->type =3D=3D PMIC_MT6331)
> +               pwrap_writel(wrp, 0x1b4, PWRAP_EINT_STA0_ADR);
> +
> +       if (wrp->slave->comp_type =3D=3D PMIC_MT6332)
> +               pwrap_writel(wrp, 0x8112, PWRAP_EINT_STA1_ADR);
> +
> +       return 0;
> +}
> +
>  static int pwrap_mt7622_init_soc_specific(struct pmic_wrapper *wrp)
>  {
>         pwrap_writel(wrp, 0, PWRAP_STAUPD_PRD);
> @@ -1949,7 +2063,8 @@ static int pwrap_init(struct pmic_wrapper *wrp)
>         if (wrp->rstc_bridge)
>                 reset_control_reset(wrp->rstc_bridge);
>
> -       if (wrp->master->type =3D=3D PWRAP_MT8173) {
> +       if (wrp->master->type =3D=3D PWRAP_MT8173 ||
> +           wrp->master->type =3D=3D PWRAP_MT6795) {

I would prefer to put a switch case like it's done in
"pwrap_common_init_reg_clock" or
"pwrap_init_cipher".

My second choice (which isn't aligned with the current
implementation), is to add boolean
capabilities in the "struct pmic_wrapper_type".

>                 /* Enable DCM */
>                 pwrap_writel(wrp, 3, PWRAP_DCM_EN);
>                 pwrap_writel(wrp, 0, PWRAP_DCM_DBC_PRD);
> @@ -2185,6 +2300,19 @@ static const struct pmic_wrapper_type pwrap_mt6779=
 =3D {
>         .init_soc_specific =3D NULL,
>  };
>
> +static const struct pmic_wrapper_type pwrap_mt6795 =3D {
> +       .regs =3D mt6795_regs,
> +       .type =3D PWRAP_MT6795,
> +       .arb_en_all =3D 0x3f,
> +       .int_en_all =3D ~(u32)(BIT(31) | BIT(2) | BIT(1)),
> +       .int1_en_all =3D 0,
> +       .spi_w =3D PWRAP_MAN_CMD_SPI_WRITE,
> +       .wdt_src =3D PWRAP_WDT_SRC_MASK_NO_STAUPD,
> +       .caps =3D PWRAP_CAP_RESET | PWRAP_CAP_DCM,
> +       .init_reg_clock =3D pwrap_common_init_reg_clock,
> +       .init_soc_specific =3D pwrap_mt6795_init_soc_specific,

TBH, I don't know if variables should be reordered in alphabetic order
or keep the order of other structures.
it's just to notify.

> +};
> +
>  static const struct pmic_wrapper_type pwrap_mt6797 =3D {
>         .regs =3D mt6797_regs,
>         .type =3D PWRAP_MT6797,
> @@ -2318,6 +2446,7 @@ static const struct of_device_id of_pwrap_match_tbl=
[] =3D {
>         { .compatible =3D "mediatek,mt2701-pwrap", .data =3D &pwrap_mt270=
1 },
>         { .compatible =3D "mediatek,mt6765-pwrap", .data =3D &pwrap_mt676=
5 },
>         { .compatible =3D "mediatek,mt6779-pwrap", .data =3D &pwrap_mt677=
9 },
> +       { .compatible =3D "mediatek,mt6795-pwrap", .data =3D &pwrap_mt679=
5 },
>         { .compatible =3D "mediatek,mt6797-pwrap", .data =3D &pwrap_mt679=
7 },
>         { .compatible =3D "mediatek,mt6873-pwrap", .data =3D &pwrap_mt687=
3 },
>         { .compatible =3D "mediatek,mt7622-pwrap", .data =3D &pwrap_mt762=
2 },
> --
> 2.40.0
>

Regards,
Alex
