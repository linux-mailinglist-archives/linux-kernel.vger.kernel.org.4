Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439AF67D139
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjAZQWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjAZQWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:22:47 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812626D5F7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:22:29 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x40so3749045lfu.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j66bgsq0G+UqpiCXy8nDNavsccxGHSiab1/UTenSNtA=;
        b=HB0+cxvDe7oLTnoR6sxS27eohS41Re7STMUjItv09RhfmNLncy+5rkRzWgAhcX/VjG
         a5pnOXqjHiKcQIGieKZlOEkpONhwT6VlfvQPBnIe8lRcN93WBgw1XTUlGnb+BUS6cihs
         xjCorHL6Of5cLhf+PLSK2ILqXH2GlO7TuJIN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j66bgsq0G+UqpiCXy8nDNavsccxGHSiab1/UTenSNtA=;
        b=TgHrf4bmff57MoVCD9oBQjcXiJ8Yl2MPVkrgddU4klD74n5Tmoc8MVKqmiXoOv93za
         w9A1sla6xGyikkEg60eii0J3RK9ZSulUayDCT/RUsP89tsu6MfEiN/5f4Rk4znIzv9IU
         wYF8VobupAwqOln/QveqvLdRXGI+0qtgShKKY/FFZsEqduIqKRc5xmsAAJPT2XUas8Iw
         tEv3NB+FuzQ46+0AzkvvFt8zc1Xf4CNXpO3PqNgK8Ybv9bUV5BgqPHsdU2Z0osYoo2z4
         L717HpPS3qdRWiE9kLMKShdUQroTGgFMih63xUwGhRRZwKnQ3iZBzefQ2K8OspEoaTpv
         2ANA==
X-Gm-Message-State: AFqh2krrj2JSw5ceSN96FcIjHaA7d/OjGo1u6P7i0qDTs3P3vH7wORN4
        ZE60Sk8OD6ilrsdQLIWXE9FEEH3MNsXRK7duZIzuPg==
X-Google-Smtp-Source: AMrXdXuwM68Z14kqcJpHXIU3u8z2GRTvjB35o2vtIgrFBUeXZcJuGv4OEZEXIJiFd+53C+UpxVwdfofuKWafaAVvTUs=
X-Received: by 2002:ac2:4a78:0:b0:4ae:5b4d:b124 with SMTP id
 q24-20020ac24a78000000b004ae5b4db124mr1673542lfp.261.1674750147577; Thu, 26
 Jan 2023 08:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20230124221218.341511-1-william.zhang@broadcom.com>
 <20230124221218.341511-9-william.zhang@broadcom.com> <CAOiHx=mQJXAkSsXkgGzpJUCzwxD1nC-Hbw3WX3OfRmp7cfFiww@mail.gmail.com>
In-Reply-To: <CAOiHx=mQJXAkSsXkgGzpJUCzwxD1nC-Hbw3WX3OfRmp7cfFiww@mail.gmail.com>
From:   Kursad Oney <kursad.oney@broadcom.com>
Date:   Thu, 26 Jan 2023 11:22:15 -0500
Message-ID: <CAMm8Nh0Lh+oUXZGCTBC-zQPQeg9-1dPUyoq34BP2ZP_vJqWX-A@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] spi: bcm63xx-hsspi: Handle cs_change correctly
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     William Zhang <william.zhang@broadcom.com>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        tomer.yacoby@broadcom.com, dregan@mail.com, f.fainelli@gmail.com,
        anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a7cb7c05f32d276e"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a7cb7c05f32d276e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas, William,


On Thu, Jan 26, 2023 at 10:13 AM Jonas Gorski <jonas.gorski@gmail.com> wrot=
e:
>
> On Tue, 24 Jan 2023 at 23:33, William Zhang <william.zhang@broadcom.com> =
wrote:
> >
> > The kernel SPI interface includes the cs_change flag that alters how
> > the CS behaves.
> >
> > If we're in the middle of transfers, it tells us to unselect the
> > CS momentarily since the target device requires that.
> >
> > If we're at the end of a transfer, it tells us to keep the CS
> > selected, perhaps because the next transfer is likely targeted
> > to the same device.
> >
> > We implement this scheme in the HSSPI driver in this change.
> >
> > Prior to this change, the CS would toggle momentarily if cs_change
> > was set for the last transfer. This can be ignored by some or
> > most devices, but the Microchip TPM2 device does not ignore it.
> >
> > With the change, the behavior is corrected and the 'glitch' is
> > eliminated.
> >
> > Signed-off-by: Kursad Oney <kursad.oney@broadcom.com>
> > Signed-off-by: William Zhang <william.zhang@broadcom.com>
> >
> > ---
> >
> > Changes in v2:
> > - Fix unused variable =E2=80=98reg=E2=80=99 compile warning
> >
> >  drivers/spi/spi-bcm63xx-hsspi.c | 29 +++++++++++++++++++++--------
> >  1 file changed, 21 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-=
hsspi.c
> > index 55cbe7deba08..696e14abba2d 100644
> > --- a/drivers/spi/spi-bcm63xx-hsspi.c
> > +++ b/drivers/spi/spi-bcm63xx-hsspi.c
> > @@ -338,7 +338,7 @@ static int bcm63xx_hsspi_transfer_one(struct spi_ma=
ster *master,
> >         struct spi_device *spi =3D msg->spi;
> >         int status =3D -EINVAL;
> >         int dummy_cs;
> > -       u32 reg;
> > +       bool restore_polarity =3D true;
>
> While restore polarity is how this is implemented, I think using a
> more semantic name like keep_cs would be better.

This sounds reasonable to me.

>
> >
> >         mutex_lock(&bs->msg_mutex);
> >         /* This controller does not support keeping CS active during id=
le.
> > @@ -367,16 +367,29 @@ static int bcm63xx_hsspi_transfer_one(struct spi_=
master *master,
> >
> >                 spi_transfer_delay_exec(t);
> >
> > -               if (t->cs_change)
> > +               /*
> > +                * cs_change rules:
> > +                * (1) cs_change =3D 0 && last_xfer =3D 0:
> > +                *     Do not touch the CS. On to the next xfer.
> > +                * (2) cs_change =3D 1 && last_xfer =3D 0:
> > +                *     Set cs =3D false before the next xfer.
> > +                * (3) cs_change =3D 0 && last_xfer =3D 1:
> > +                *     We want CS to be deactivated. So do NOT set cs =
=3D false,
> > +                *     instead just restore the original polarity. This=
 has the
> > +                *     same effect of deactivating the CS.
> > +                * (4) cs_change =3D 1 && last_xfer =3D 1:
> > +                *     We want to keep CS active. So do NOT set cs =3D =
false, and
> > +                *     make sure we do NOT reverse polarity.
> > +                */
> > +               if (t->cs_change && !list_is_last(&t->transfer_list, &m=
sg->transfers))
> >                         bcm63xx_hsspi_set_cs(bs, spi->chip_select, fals=
e);
> > +
> > +               restore_polarity =3D !t->cs_change;
> >         }
>
> I still find setting restore_polarity on each loop iteration when only
> its last set value matters confusing and hard to read, so I still
> propose keeping close to the generic implementation (
> https://elixir.bootlin.com/linux/v6.1.8/source/drivers/spi/spi.c#L1560
> ) and do
>
> if (t->cs_change) {
>    if (list_is_last())
>        restore_polarity =3D false;
>    else
>        bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
> }

OK I think this makes sense too but it might be a bit clearer to do:

if (list_is_last()) {
    if (cs_change)
        keep_cs =3D false;
    else
        bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
}

The gating condition here is when we reach the final transfer. But
list_is_last() is more expensive, so that's another consideration.

>
> While there, you might also want to check the cs_off value(s) as well.

Can you explain this please?

>
>
>
> >
> > -       mutex_lock(&bs->bus_mutex);
> > -       reg =3D __raw_readl(bs->regs + HSSPI_GLOBAL_CTRL_REG);
> > -       reg &=3D ~GLOBAL_CTRL_CS_POLARITY_MASK;
> > -       reg |=3D bs->cs_polarity;
> > -       __raw_writel(reg, bs->regs + HSSPI_GLOBAL_CTRL_REG);
> > -       mutex_unlock(&bs->bus_mutex);
> > +       bcm63xx_hsspi_set_cs(bs, dummy_cs, false);
> > +       if (restore_polarity)
> > +               bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
> >
> >         mutex_unlock(&bs->msg_mutex);
> >         msg->status =3D status;
> > --
> > 2.37.3
> >

--000000000000a7cb7c05f32d276e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
H97gptZzNuD5FN8AnEYMQC6vPslbDQ8OeHrqANhF8taWK+SSbnl4/km7NnYL6pYm2/HulJ7szr6k
Bga+i8qlQQLDYjSqVnvSx4I0lnIx8mkbKOjKUkaTAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGt1cnNhZC5vbmV5QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUKWCMBqRGX3LrgDeTNWWULeUnAkw
DQYJKoZIhvcNAQELBQADggEBAGiGVwLlVHzCwc131bPGlyqtSUpcV3ZIrDzgI5b9P928irKwLLfx
42XWJIfF5VAW8uJunv6HyQcNeBRM52s06xq2dcX7RdXXPLUU/YX5f3PGhzcRRC6UMknFS8JuNiK2
RdXw0IUu9RCTfRpaM27WGAYxZ7JV9ifux005OUgthb9fXYbMWSVRTm68SS3zmWnEQFFLCVK7X2/W
eX50x5mei/gYP8RsWh/OebUYfGNnz3I6D7hU/yeXOIXxSqWJU3e87v7O4nntiBsS+np8/aI0DPwO
9taRRqYu6VYqshU5nPIYjgZWPwbumnWj5akjBeUPbItThOMNwidMbPamkAkQI+YxggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwXP8QzF7cAzvmLbq4wDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAXouJwYpstNqblnDjK6EyH+AKFBPdtJp9HA
tZ72hiFWMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDEyNjE2
MjIyN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQCWmK/i2FrX38pkQpA1HCoOmWC7vtSuu35rHZedjmPry1Tr4QGSBLMw
hvQxSbNruWfoSSKx8MnjGWDH25iK32A0u5wPW+0HWEOnAp7HJvdy0tnXJkWYBNZxCjB8kK5wDPco
3gq8RRShrXmJqsQJRLjXApMXwZbZtw34v7441AcVDpT7OMUwiMvC8inALrChXtzZsQwsoprN4icl
j4QCeA1MYawNIOWG59t5W/BJ2wXvU/SG12Yk1vxiKQm2TPLW4tngs5CKBiX3MuVRcJGzHGX/IFw8
CSYAtCJOycHamH2DZ5k91kPz2thzaMBfF2aBxLvZ2DgS5j0TZ40LAtSCGKrh
--000000000000a7cb7c05f32d276e--
