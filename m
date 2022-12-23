Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6591655310
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 18:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiLWRFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 12:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLWRFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 12:05:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A8718345;
        Fri, 23 Dec 2022 09:05:33 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 05A0A6602CDF;
        Fri, 23 Dec 2022 17:05:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671815132;
        bh=DilnnI7vRaCXcahELlHtM/5jZDRYaD/HhEUVFXz7hWo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AozgfGUBs7euhdMl7UmO4pz9LJ8Iyx0U7Nu8qcQhw2Y4bpNw8roJ2d8f6lTGWVu13
         oXIx6dTkzcMqNGb6lj9x887/uj8CcZ+z4e/Mho0R8FdLumxopwN066s2Q9LJgkNVs0
         FgvDlOYcNngeVjDKiF1T+9PoaNSUKq7RQ1vWDbjCLVGMr4rVeDbzrSMaFHUYLQkMp7
         dztTC5CFVglT/+TeZX8hb7SESVRFGnpHoRIT9CZ79ljb1brmVqcl7ydr57zkCE7gxQ
         0Wl10NEAKdJ1CR3vxjRegH5Yg+W8/KDtLMkZRwq9Pd+T9r+n5hoVX8/dJVLHLXzl0g
         vq4t3OVFzsG9w==
Message-ID: <6449640fcfbbfd4b72e619f03704b7e9031a8a17.camel@collabora.com>
Subject: Re: [PATCH] hantro: Fix JPEG encoder ENUM_FRAMESIZE on RK3399
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>, kernel@collabora.com,
        Robert Mader <robert.mader@collabora.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 23 Dec 2022 12:05:21 -0500
In-Reply-To: <CAAEAJfATk+jOq3qt-m2CZEbCVumHHWDFfuEXKA7k0NZQXajCRg@mail.gmail.com>
References: <20221223141644.703088-1-nicolas.dufresne@collabora.com>
         <CAAEAJfATk+jOq3qt-m2CZEbCVumHHWDFfuEXKA7k0NZQXajCRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le vendredi 23 d=C3=A9cembre 2022 =C3=A0 13:28 -0300, Ezequiel Garcia a =C3=
=A9crit=C2=A0:
> Hi everyone,
>=20
> On Fri, Dec 23, 2022 at 11:17 AM Nicolas Dufresne
> <nicolas.dufresne@collabora.com> wrote:
> >=20
> > The frmsize structure was left initialize to 0, as side effect, the dri=
ver was
> > reporting an invalid frmsize.
> >=20
> >   Size: Stepwise 0x0 - 0x0 with step 0/0
> >=20
> > Fix this by replicating the constraints in the raw formats too. This fi=
xes
> > taking picture in Gnome Cheese Software, or any software using GSteamer
> > encodebin feature.
> >=20
> > Fixes: 775fec69008d30 ("media: add Rockchip VPU JPEG encoder driver")
>=20
> The frmsize is only for bitstream formats (see comment in struct hantro_f=
mt).
> If I can read code correctly, this was broken by this commit:
>=20
> commit 79c987de8b35421a2a975982929f150dd415f8f7
> Author: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Date:   Mon Apr 4 18:06:40 2022 +0200
>=20
>     media: hantro: Use post processor scaling capacities
>=20
> Before that commit we used to return EINVAL for enum_framesizes
> in RAW formats. I guess we missed that :-)

I see, and gstreamer had a quirk for such a bogus response. Let me explain =
why
its bogus, for the general knowlege. A driver that supports ENUM_FRAMESIZE =
but
does not return any sizes, is in theory a driver that does not support anyt=
hing.
Fortunaly, GStreamer considered not having a single framesize bogus, and wo=
uld
fallback to the old school try_fmt() dance to find the supported sizes.

So yes, it used to work in gstreamer, and its indeed
79c987de8b35421a2a975982929f150dd415f8f7 that broke it. I'll correct his in=
 V2.

>=20
> To be completely honest, I'm not sure if we used to support encodebin,
> and I'm not too sure how to approach this issue, but I would really
> love to start with something super simple like:
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c
> b/drivers/media/platform/verisilicon/hantro_v4l2.c
> index 2c7a805289e7..0b28f86b7463 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -161,8 +161,11 @@ static int vidioc_enum_framesizes(struct file
> *file, void *priv,
>         }
>=20
>         /* For non-coded formats check if postprocessing scaling is possi=
ble */
> -       if (fmt->codec_mode =3D=3D HANTRO_MODE_NONE &&
> hantro_needs_postproc(ctx, fmt)) {
> -               return hanto_postproc_enum_framesizes(ctx, fsize);
> +       if (fmt->codec_mode =3D=3D HANTRO_MODE_NONE)
> +        if (hantro_needs_postproc(ctx, fmt))
> +            return hanto_postproc_enum_framesizes(ctx, fsize);
> +        else
> +            return -ENOTTY;
>         } else if (fsize->index !=3D 0) {
>                 vpu_debug(0, "invalid frame size index (expected 0, got %=
d)\n",
>                           fsize->index);
>=20
> (ENOTTY was suggested by Nicolas on IRC)
>=20
> Nicolas also pointed out that our current handling of frmsize is not corr=
ect,
> as we cannot express different constraints on combinations of RAW
> and bitstream formats.
>=20
> This seems to call for a rework of enum_framesizes, so frmsize
> is not static but somehow obtained per-codec.

So I'll respin along these line to we more or less "revert back" to working
state. Though having a framesize enumeration on encoder raw (OUTPUT queue) =
is
what makes most sense so that will have to be revisited with a corrected
mechanism, as whenever we add VP8 and H.264 encoding, we'll need different =
range
per codec. I'll check in January with my colleague, we might do that inside=
 the
VP8 encoder branch (that is nearly ready and will be sent after the holiday=
s),
or could be an intermediate set.

regards,
Nicolas

>=20
> Thanks,
> Ezequiel
>=20
> > Reported-by: Robert Mader <robert.mader@collabora.com>
> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>=20
> And thanks a lot for the report and the patch!
>=20

