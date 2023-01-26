Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2616D67CF84
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjAZPNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjAZPNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:13:12 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FC1530C4;
        Thu, 26 Jan 2023 07:13:00 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id be8so2078850plb.7;
        Thu, 26 Jan 2023 07:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJLihLuF0yKMMg408sSjk4wJtac1oa0MPZR4v84EZyk=;
        b=ajYvFORYwYT2aGu312rNzNZC4DzemKiWaReBFW2DpSBaAOIb+hW0Bi+2bQpfmJDWL2
         EZFkK0ABOzEEWBGifZOFcYYG64Stklwf8VHjKPiHylrsYl5TbVBWFflI8Kyqq51W+TYx
         8gTl0i3GsOAgI/S0/wctI0nzJQuYcScjv8J8PCqXREqPlms4lPZFZ7IuI80E4nRFHCj2
         a6vG83j3Dx7xJFt9uJkJJb2DHJlAlA5gGwAcXXzF01euoZkAZrsj5pF/wmlX4Uga7RqV
         JYffJ4MFsvRT1RRd9Mh7jgM8CroVZiWM9HJTRXp5dvvz5J7uwMrcsT/09/VDrLiwT211
         QEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJLihLuF0yKMMg408sSjk4wJtac1oa0MPZR4v84EZyk=;
        b=I8XU35G6iBG+9xC/5bR+jhBAx7NKZmgfzhlGenWXKj6OiuCSgyiCBT9SGf0a+biq4r
         9bgPfUGUSPGi7oBYLOVCYplWBfcIqFcwF4Eb1CJajFB/2V/i4/LegSLoS2q596y0Xa1B
         2XVdt5VQm9VVrj0mQtETBetktyT4nYe0LAbPiVrPbEcuj7hRtfY9zPp07g8QYEcwnglA
         rgdq9FiVp7nOjDcpUmZWvEjDDjPqbOAFLbGFoTsRNvdQeVZWgvHUtw88zU8J5aBHxH0B
         V6y1P2wISPkYN2MZ5fxw02cVN8VenRA6vprQ1NCIgOMnheNs4ie4BnEf4dPy+Y1mavjH
         cf0w==
X-Gm-Message-State: AFqh2kppM0UdzDzfiC3m8SbTMWp/KoUEyl0TEQuasoLSP6jRo7zaUSVN
        Yanp6QjWvd9k480rXoAC8NTwN14/Ifb5jWH30mw=
X-Google-Smtp-Source: AMrXdXsaYvTBw1/bD43wF5Qyc8/V0QyLm+C2IC6gpKECwS+f8f6MVHeMq2wX1HQeAccctpOmIJCXEM/s04WRHLqpbes=
X-Received: by 2002:a17:90b:291:b0:227:3f:57be with SMTP id
 az17-20020a17090b029100b00227003f57bemr5724649pjb.158.1674745980446; Thu, 26
 Jan 2023 07:13:00 -0800 (PST)
MIME-Version: 1.0
References: <20230124221218.341511-1-william.zhang@broadcom.com> <20230124221218.341511-9-william.zhang@broadcom.com>
In-Reply-To: <20230124221218.341511-9-william.zhang@broadcom.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Thu, 26 Jan 2023 16:12:48 +0100
Message-ID: <CAOiHx=mQJXAkSsXkgGzpJUCzwxD1nC-Hbw3WX3OfRmp7cfFiww@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] spi: bcm63xx-hsspi: Handle cs_change correctly
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, f.fainelli@gmail.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
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

On Tue, 24 Jan 2023 at 23:33, William Zhang <william.zhang@broadcom.com> wr=
ote:
>
> The kernel SPI interface includes the cs_change flag that alters how
> the CS behaves.
>
> If we're in the middle of transfers, it tells us to unselect the
> CS momentarily since the target device requires that.
>
> If we're at the end of a transfer, it tells us to keep the CS
> selected, perhaps because the next transfer is likely targeted
> to the same device.
>
> We implement this scheme in the HSSPI driver in this change.
>
> Prior to this change, the CS would toggle momentarily if cs_change
> was set for the last transfer. This can be ignored by some or
> most devices, but the Microchip TPM2 device does not ignore it.
>
> With the change, the behavior is corrected and the 'glitch' is
> eliminated.
>
> Signed-off-by: Kursad Oney <kursad.oney@broadcom.com>
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>
> ---
>
> Changes in v2:
> - Fix unused variable =E2=80=98reg=E2=80=99 compile warning
>
>  drivers/spi/spi-bcm63xx-hsspi.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hs=
spi.c
> index 55cbe7deba08..696e14abba2d 100644
> --- a/drivers/spi/spi-bcm63xx-hsspi.c
> +++ b/drivers/spi/spi-bcm63xx-hsspi.c
> @@ -338,7 +338,7 @@ static int bcm63xx_hsspi_transfer_one(struct spi_mast=
er *master,
>         struct spi_device *spi =3D msg->spi;
>         int status =3D -EINVAL;
>         int dummy_cs;
> -       u32 reg;
> +       bool restore_polarity =3D true;

While restore polarity is how this is implemented, I think using a
more semantic name like keep_cs would be better.

>
>         mutex_lock(&bs->msg_mutex);
>         /* This controller does not support keeping CS active during idle=
.
> @@ -367,16 +367,29 @@ static int bcm63xx_hsspi_transfer_one(struct spi_ma=
ster *master,
>
>                 spi_transfer_delay_exec(t);
>
> -               if (t->cs_change)
> +               /*
> +                * cs_change rules:
> +                * (1) cs_change =3D 0 && last_xfer =3D 0:
> +                *     Do not touch the CS. On to the next xfer.
> +                * (2) cs_change =3D 1 && last_xfer =3D 0:
> +                *     Set cs =3D false before the next xfer.
> +                * (3) cs_change =3D 0 && last_xfer =3D 1:
> +                *     We want CS to be deactivated. So do NOT set cs =3D=
 false,
> +                *     instead just restore the original polarity. This h=
as the
> +                *     same effect of deactivating the CS.
> +                * (4) cs_change =3D 1 && last_xfer =3D 1:
> +                *     We want to keep CS active. So do NOT set cs =3D fa=
lse, and
> +                *     make sure we do NOT reverse polarity.
> +                */
> +               if (t->cs_change && !list_is_last(&t->transfer_list, &msg=
->transfers))
>                         bcm63xx_hsspi_set_cs(bs, spi->chip_select, false)=
;
> +
> +               restore_polarity =3D !t->cs_change;
>         }

I still find setting restore_polarity on each loop iteration when only
its last set value matters confusing and hard to read, so I still
propose keeping close to the generic implementation (
https://elixir.bootlin.com/linux/v6.1.8/source/drivers/spi/spi.c#L1560
) and do

if (t->cs_change) {
   if (list_is_last())
       restore_polarity =3D false;
   else
       bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
}

While there, you might also want to check the cs_off value(s) as well.



>
> -       mutex_lock(&bs->bus_mutex);
> -       reg =3D __raw_readl(bs->regs + HSSPI_GLOBAL_CTRL_REG);
> -       reg &=3D ~GLOBAL_CTRL_CS_POLARITY_MASK;
> -       reg |=3D bs->cs_polarity;
> -       __raw_writel(reg, bs->regs + HSSPI_GLOBAL_CTRL_REG);
> -       mutex_unlock(&bs->bus_mutex);
> +       bcm63xx_hsspi_set_cs(bs, dummy_cs, false);
> +       if (restore_polarity)
> +               bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
>
>         mutex_unlock(&bs->msg_mutex);
>         msg->status =3D status;
> --
> 2.37.3
>
