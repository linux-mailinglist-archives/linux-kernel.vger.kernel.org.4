Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA14652513
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiLTRAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiLTRAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:00:08 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE601838C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 09:00:05 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id mn15so8563435qvb.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 09:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+eNtJleCoyZ+rnpiQgOt/w5NmObbO6G26kWA+/nOGUg=;
        b=PXRNJruI4QH3avlJjKJcGvsE+EsMPLIJraLY7fTB+owDI5ZxGS55eJ3jz+eBCn97gb
         5mjKHNs+2CrTU8JLSJsOGISFT/dcqGvSLGQCYmMh62Q6ufRzwfKbkclHZtTSnDlC8ZMO
         pBCC6dQRQa55Ud/SLbYoWDRDD6g58+UPoNzI8kstddrU3feBsD1GmopdsR89m0FSqhtn
         6NynIUJ5q+MFJE+AfrNvHNwdPe0PLcx8H/gxG9LZquvBJOHGLp+idtI7sTiDswYgG9ex
         N1mOlEnK7ChJe/Y2z/iFvinl8FjoJ3C0Asp5hUyk/AOdcqcD+63hLDtTvD4r0fUNXMx1
         CMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+eNtJleCoyZ+rnpiQgOt/w5NmObbO6G26kWA+/nOGUg=;
        b=6aOfsmLGy15PbwuIpEF/fu/pSzA+EVKBPjuvK29Hh1fLfDfp0LeHgLwuMC7lMxezVK
         I16+x802j0NIgb+hVY/nKLH6gVM11zZ4bOtnw9f0SlWWVgWuPBcaYt2t9Kt9U8+NtKAy
         O3motolCXqR0otyYyaoVVb57l3pv2ItjoKdgio7k2GZdLFcnSUiB72Vg8R4dMaLGGmJs
         PMoPdsw4rOS7yDt3TfXFlo12TfcenbTbZpiMMjtdzgxbZ5MwWzGm56VCtNyA6vPdo5VX
         vLgFMpYaFefR0KWo5SM1mfgUjwXbMwngnSy4Up8vU4y1FJ8yeHEuksh1g0tAH3kiFflO
         l6cQ==
X-Gm-Message-State: ANoB5pksl6qKrmMctLi2RYmMSKZP5lfJYTKYKu4b7vTMxL/w8iRZjgZ8
        c98LTknmHiuvzzq8lAe4JOG2ew==
X-Google-Smtp-Source: AA0mqf7AJbYijJupMP4GW/Qkb0ZvvXqfYmCTrUF/82gvjy1X451bMmQPVjtNikol69Xn7HaIxHu91g==
X-Received: by 2002:ad4:4811:0:b0:4d1:e110:1621 with SMTP id qd17-20020ad44811000000b004d1e1101621mr66524292qvb.0.1671555604153;
        Tue, 20 Dec 2022 09:00:04 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id c7-20020a05620a268700b006f87d28ea3asm9214224qkp.54.2022.12.20.09.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 09:00:03 -0800 (PST)
Message-ID: <939ce9a0f7f73c0b9f0cf5590f2d8b02e0825fa5.camel@ndufresne.ca>
Subject: Re: [PATCH v1 0/9] AV1 stateless decoder for RK3588
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Michael Grzeschik <mgr@pengutronix.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        p.zabel@pengutronix.de, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Tue, 20 Dec 2022 12:00:01 -0500
In-Reply-To: <20221219215431.GB26315@pengutronix.de>
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
         <CAAEAJfBP_D65kjHbwYP+LWfWKfzFtHtWo+3bDcbdO8tPtBurUA@mail.gmail.com>
         <20221219215431.GB26315@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 19 d=C3=A9cembre 2022 =C3=A0 22:54 +0100, Michael Grzeschik a =C3=
=A9crit=C2=A0:
> Hi Benjamin,
> Hi Ezequiel,
>=20
> On Mon, Dec 19, 2022 at 06:07:38PM -0300, Ezequiel Garcia wrote:
> > On Mon, Dec 19, 2022 at 12:56 PM Benjamin Gaignard
> > <benjamin.gaignard@collabora.com> wrote:
> > >=20
> > > This series implement AV1 stateless decoder for RK3588 SoC.
> > > The harware support 8 and 10 bits bitstreams up to 7680x4320.
> > > AV1 feature like film grain or scaling are done by the postprocessor.
> > > The driver can produce NV12_4L4 and NV12 pixel formats.
> > > A native 10bits NV12_4L4 format is possible but need more investigati=
on
> > > to be completly documented and enabled.
> > >=20
> > > It is based on Daniel's "[RFC,v3] media: Add AV1 uAPI" [1] patches an=
d
> > > Sebastian's device-tree patches for RK3588.
> > >=20
> >=20
> > I thought the AV1 decoder in RK3588 was really a separate hardware
> > from the Hantro G1/G2.
> >=20
> > Shouldn't this need a new driver for this new hardware?
>=20
> Just jumping into this discussion as I am currently working on the rkvenc=
 driver.
>=20
> In my case I am extending the rkvdec driver to become more generic for
> other rockchip specific enc/decoders.
>=20
> My first change looks like this:
> ---
>  drivers/staging/media/rkvdec/Makefile              |   4 +-
>  drivers/staging/media/rkvdec/rkvdec-h264.c         | 100 ++++-----
>  drivers/staging/media/rkvdec/rkvdec-vp9.c          | 142 ++++++-------
>  drivers/staging/media/rkvdec/{rkvdec.c =3D> rkvpu.c} | 510 +++++++++++++=
++++++++++-----------------------
>  drivers/staging/media/rkvdec/{rkvdec.h =3D> rkvpu.h} |  66 +++---
> ---
>=20
> While working on other parts of the encoder I found many places in the
> rkvdec driver (e.g. v4l2 and vb2 callbacks) that looked familiar to the h=
antro
> functions but where limited to the decoder case.
>=20
> I think there are two options for the av1 codec.
>=20
> 1) If the vpu981 is a driver that has nothing to do with verisilicon but
> works with this driver framework, then we should integrate vepu981 into i=
t
> but consider rename the verisilicon unrelated parts to something generic.

I've raised in my review the the naming is sub-optimal. This is an unmodifi=
ed
VC9000D AV1 decoder. No other codecs have been included in the package, eve=
n
though VC9000D cores can support more.

Stating this driver have no place here seems a bit strange to me, but with
proper arguments, maybe we can make a case and start a VC9000D dedicated dr=
iver
(that will be a lot of copy paste, VC9000D post processor notably is identi=
cal
to VC8000 post processor, but one could argue we should make a VCX000 drive=
r ?

>=20
> 2) Move the vepu981 av1 driver into the rkvdec instead.

That make no sense, its not a Rockchip HW design, and will likely start
appearing on non-RK SoC in the future.

>=20
> If 1) is the way to go, we can even think of moving the staging code part=
s from
> rkvdec to the verisilicon code. Likewise to the vepu981-av1.

Again, I think using RK naming is unfortunate choice. This AV1 decoder is j=
ust
like the G1/H1 combo you will find on RK3288. And that same combo is found =
on
many older SoC (actually even newer SoC un the VC8000Nano brand).

Like all generation of Hantro chips, there is an optional dependency that c=
an
exist between encoder and decoders. The question is if this requires a sing=
le
driver to maintain a valid state or not. So far, it seems devs have assume =
that
is it needed.

p.s. fun fact, on most HW, the decoder rate is cut in half with running
concurrently with the encoder

>=20
> I could also keep on integrating the rkvenc on that base instead.

Do you know if there is any interaction between the encoder and decoder ? S=
hared
registers, shared internal cache ? That's basically what differentiate Hant=
ro
here. Also, be aware that some folks are considering starting on RKVDEC2 dr=
iver,
are you looking at RK32/33 series ? or more RK35 ?

>=20
> Regards,
> Michael
>=20
> > > The full branch can be found here:
> > > https://gitlab.collabora.com/linux/for-upstream/-/commits/rk3588_av1_=
decoder_v1
> > >=20
> > > Fluster score is: 151/239 while testing AV1-TEST-VECTORS with GStream=
er-AV1-V4L2SL-Gst1.0.
> > > The failing tests are:
> > > - 10bits bitstream because 10bits output formats aren't yet implement=
ed.
> > > - the 2 tests with 2 spatial layers: few errors in luma/chroma values
> > > - tests with resolution < hardware limit (64x64)
> > >=20
> > > Benjamin
> > >=20
> > > Benjamin Gaignard (9):
> > >   dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible
> > >   media: verisilicon: Add AV1 decoder mode and controls
> > >   media: verisilicon: Save bit depth for AV1 decoder
> > >   media: verisilicon: Check AV1 bitstreams bit depth
> > >   media: verisilicon: Compute motion vectors size for AV1 frames
> > >   media: verisilicon: Add AV1 entropy helpers
> > >   media: verisilicon: Add Rockchip AV1 decoder
> > >   media: verisilicon: Add film grain feature to AV1 driver
> > >   media: verisilicon: Enable AV1 decoder on rk3588
> > >=20
> > >  .../bindings/media/rockchip-vpu.yaml          |    1 +
> > >  drivers/media/platform/verisilicon/Makefile   |    3 +
> > >  drivers/media/platform/verisilicon/hantro.h   |    5 +
> > >  .../media/platform/verisilicon/hantro_drv.c   |   54 +
> > >  .../media/platform/verisilicon/hantro_hw.h    |  102 +
> > >  .../platform/verisilicon/hantro_postproc.c    |    3 +
> > >  .../media/platform/verisilicon/hantro_v4l2.c  |    5 +
> > >  .../verisilicon/rockchip_av1_entropymode.c    | 4536 +++++++++++++++=
++
> > >  .../verisilicon/rockchip_av1_entropymode.h    |  272 +
> > >  .../verisilicon/rockchip_av1_filmgrain.c      |  401 ++
> > >  .../verisilicon/rockchip_av1_filmgrain.h      |   36 +
> > >  .../verisilicon/rockchip_vpu981_hw_av1_dec.c  | 2280 +++++++++
> > >  .../verisilicon/rockchip_vpu981_regs.h        |  477 ++
> > >  .../platform/verisilicon/rockchip_vpu_hw.c    |  116 +
> > >  14 files changed, 8291 insertions(+)
> > >  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_e=
ntropymode.c
> > >  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_e=
ntropymode.h
> > >  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_f=
ilmgrain.c
> > >  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_f=
ilmgrain.h
> > >  create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu98=
1_hw_av1_dec.c
> > >  create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu98=
1_regs.h
> > >=20
> > > --
> > > 2.34.1
> > >=20
> >=20
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >=20
>=20

