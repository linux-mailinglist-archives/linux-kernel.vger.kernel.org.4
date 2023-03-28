Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E307D6CBA5A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjC1JUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjC1JUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:20:05 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EDEFB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:20:03 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i7so14202633ybt.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679995203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rydAqL2xjCh9m8x5P5P2xf+yVVNlT8mq2EopIER2YF4=;
        b=Rjr+MdnqwFCGnuQdLml0S8Rg+dbGWPtX0rYliRuYF6Vx1BGLHxmv6BqbxyH+0adZWt
         F4F25hvkqcOJZlpWwo6b5GR+8oC7WRANZsp1iZtlM10kl43ujXjzT4mVnjn+QN7nkgH/
         ylTdaoxbTSTFpvfWJ/g0nndUO0lYAvmY9yhg1/8mIWR5OEvmAWMkjDfOKgUuhqZKCqbd
         /XnCOmgTUB7Jaf88M6jctxsTiOC4cPYSWTzYQ3VK+ZC/OsqtaI+LviwJ68FcYbjcW2li
         1YKX3WbXfqFml0Qo8EG3vuVsx79HR+CcCAm0vKhI+PvaHiudqk1bm6pgS6G6pcpgh7yx
         iwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679995203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rydAqL2xjCh9m8x5P5P2xf+yVVNlT8mq2EopIER2YF4=;
        b=tsUlJkLfeguaxPK3OEuIZDa6BQYGDERbURAL4FJno/ggWxRtINxQrfdNrOnRmDjsvo
         EUqfn4jOvq0lKr58+db7Dl9BkD9QGuanuCVHxpdCisKIkR04PMxuGEyJr0kZiByy2/1f
         jQ3/fTG+Niwovu4iu8gL/ifuSxdWKRcLzeXoXeK49g+wHTskyNiBb/GL1BB1z9FqqCEt
         8/U1kQAYlbccHEVtYaBf2b4pwqa49wfv+9e1eSKnYYJIF0DiilOh3QSitVkAxJfx2GtN
         7vW5D7rL476sfVx4Yh8G27AchG8nP70x/2LpkgmtWAPwZw1BI01wkLHd/Ro5Zvg864Fq
         83Zw==
X-Gm-Message-State: AAQBX9fxx/BoWz3kGRNMNCmg5FhCFuZemUHNBUYRJB88P6Y40OapZxS0
        PH5wdV8hrSXkfLTYqFhfsIxw7EGinIcYIehzxjm67Q==
X-Google-Smtp-Source: AKy350bysJsJQEMIVvOgRrtDQqvgDbyfnCMQZJxShJfJthTEA4O/F/mDGDMWyhxv19f8BsA5jRUCcPGquZnZUmPXvCU=
X-Received: by 2002:a05:6902:1586:b0:98e:6280:74ca with SMTP id
 k6-20020a056902158600b0098e628074camr9294491ybu.1.1679995202855; Tue, 28 Mar
 2023 02:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230324094205.33266-1-angelogioacchino.delregno@collabora.com> <20230324094205.33266-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230324094205.33266-3-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 28 Mar 2023 11:19:52 +0200
Message-ID: <CAFGrd9oyOz8-gf10-1QkaBzZwTvm9V7b63BZeoUbbM45CO8E1Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] soc: mediatek: pwrap: Move PMIC read test sequence
 in function
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

Le ven. 24 mars 2023 =C3=A0 10:42, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> a =C3=A9crit :
>
> The PMIC read test is performed in two places: pwrap_init_dual_io()
> and pwrap_init_sidly().
> In preparation for adding support for PMICs requiring a companion
> part, move this sequence to a new function pwrap_pmic_read_test().
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 32 +++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/=
mtk-pmic-wrap.c
> index 15789a03e6c6..5c500be48f7c 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -1455,6 +1455,18 @@ static int pwrap_regmap_write(void *context, u32 a=
dr, u32 wdata)
>         return pwrap_write(context, adr, wdata);
>  }
>
> +static bool pwrap_pmic_read_test(struct pmic_wrapper *wrp, const u32 *de=
w_regs,
> +                                u16 read_test_val)
> +{
> +       bool is_success;
> +       u32 rdata;
> +
> +       pwrap_read(wrp, dew_regs[PWRAP_DEW_READ_TEST], &rdata);
> +       is_success =3D ((rdata & U16_MAX) =3D=3D read_test_val);
> +
> +       return is_success;
> +}
> +
>  static int pwrap_reset_spislave(struct pmic_wrapper *wrp)
>  {
>         bool tmp;
> @@ -1498,18 +1510,18 @@ static int pwrap_reset_spislave(struct pmic_wrapp=
er *wrp)
>   */
>  static int pwrap_init_sidly(struct pmic_wrapper *wrp)
>  {
> -       u32 rdata;
>         u32 i;
>         u32 pass =3D 0;
> +       bool read_ok;
>         signed char dly[16] =3D {
>                 -1, 0, 1, 0, 2, -1, 1, 1, 3, -1, -1, -1, 3, -1, 2, 1
>         };
>
>         for (i =3D 0; i < 4; i++) {
>                 pwrap_writel(wrp, i, PWRAP_SIDLY);
> -               pwrap_read(wrp, wrp->slave->dew_regs[PWRAP_DEW_READ_TEST]=
,
> -                          &rdata);
> -               if (rdata =3D=3D PWRAP_DEW_READ_TEST_VAL) {
> +               read_ok =3D pwrap_pmic_read_test(wrp, wrp->slave->dew_reg=
s,
> +                                              PWRAP_DEW_READ_TEST_VAL);
> +               if (read_ok) {
>                         dev_dbg(wrp->dev, "[Read Test] pass, SIDLY=3D%x\n=
", i);
>                         pass |=3D 1 << i;
>                 }
> @@ -1529,8 +1541,7 @@ static int pwrap_init_sidly(struct pmic_wrapper *wr=
p)
>  static int pwrap_init_dual_io(struct pmic_wrapper *wrp)
>  {
>         int ret;
> -       bool tmp;
> -       u32 rdata;
> +       bool read_ok, tmp;
>
>         /* Enable dual IO mode */
>         pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_DIO_EN], 1);
> @@ -1546,12 +1557,9 @@ static int pwrap_init_dual_io(struct pmic_wrapper =
*wrp)
>         pwrap_writel(wrp, 1, PWRAP_DIO_EN);
>
>         /* Read Test */
> -       pwrap_read(wrp,
> -                  wrp->slave->dew_regs[PWRAP_DEW_READ_TEST], &rdata);
> -       if (rdata !=3D PWRAP_DEW_READ_TEST_VAL) {
> -               dev_err(wrp->dev,
> -                       "Read failed on DIO mode: 0x%04x!=3D0x%04x\n",
> -                       PWRAP_DEW_READ_TEST_VAL, rdata);
> +       read_ok =3D pwrap_pmic_read_test(wrp, wrp->slave->dew_regs, PWRAP=
_DEW_READ_TEST_VAL);
> +       if (!read_ok) {
> +               dev_err(wrp->dev, "Read failed on DIO mode.\n");
>                 return -EFAULT;
>         }

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

Regards,
Alexandre
