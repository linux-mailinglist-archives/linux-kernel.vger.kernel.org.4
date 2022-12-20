Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18DC652564
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiLTRPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiLTRP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:15:26 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BE2FDE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 09:15:25 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id x11so11428721qtv.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 09:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aeo69u/xoE4sCrome1TMqX72pjX+WYUng/a16aTC6H4=;
        b=cRkTSjKVL0KBCa/58BB8ePvwVCa/GnsgtSMpSgWABdJnhZ/YV1p0Cm3q+3BVVLZ0HP
         UhnaEHcmNZcDy1zie3i00imr527fprWf+REa7XdsQDdgQP4Bb3TYBUEQU//gZgdKL7R/
         1egt+6qakDHGrzunNm3QosoQRQ8s4777VEd+JMPw9FbnfiY4snym0fN8naGsMVOpsCGX
         INPjOjHGU0xgDrLiXZI/qxv0gL4iY1rL39KHJO+T4uthy28fvOi7kjPI0GpzcArksHvw
         dMtUFtHz1CjWX/4paT6mlgPnOj5Dey3elj0BUwC7K2UarBnHru7yt3NjbBJKvkl6+Loc
         DUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aeo69u/xoE4sCrome1TMqX72pjX+WYUng/a16aTC6H4=;
        b=qGn0LStwSfMme5/iQ83qGMD1Mo7kJM1jRfNWCRfcdUq036uDesPXAhToBqtnz1Z/tV
         BJr7ZlePn76HBqgLmeS/3Px7W5jsOt9NHcOGPhGj3PnMQwZDj0gUYasHoxEzUNeFscEU
         Ur6+LZ14kd5XHEFsTBS9Y88x0ShVqHHBUJXp58yx2qJiA07Vnq20CHm2mKbR7D3pVCjL
         wAeUpl5HNxWUNCS66MMhxp6GBQBgO7608bADoyh5itQa9NKHVnqgWQcTOajYrBKCcLVv
         +1C/nF/eTYNiKSY60lzMeMez1i+atPVBFbBg3t0GHS4MKs9WNVa9THkAsU6fajgQhof7
         TNxg==
X-Gm-Message-State: AFqh2kq8Jc94902Z3n9sMl6j0Zn/XvkMuj4qZmy2vM+SauJ+q20MUM1m
        HaXbBXxOlkSze1yexicPrzS2bw==
X-Google-Smtp-Source: AMrXdXvCiNdwsUwZRmTRRU+f4j4gbnX3tH0LegVqXBK/6QK6cIlMgp25v2sqJBxmw1wHswtADtiKSw==
X-Received: by 2002:a05:622a:5148:b0:3a5:3134:48ac with SMTP id ew8-20020a05622a514800b003a5313448acmr5307540qtb.3.1671556522615;
        Tue, 20 Dec 2022 09:15:22 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id j3-20020a05620a288300b006f9c2be0b4bsm8869885qkp.135.2022.12.20.09.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 09:15:21 -0800 (PST)
Message-ID: <c3f40678b49b137e7caaa51778389caee59d8d6f.camel@ndufresne.ca>
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
Date:   Tue, 20 Dec 2022 12:15:20 -0500
In-Reply-To: <20221220134003.GC26315@pengutronix.de>
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
         <CAAEAJfBP_D65kjHbwYP+LWfWKfzFtHtWo+3bDcbdO8tPtBurUA@mail.gmail.com>
         <20221219215431.GB26315@pengutronix.de>
         <CAAEAJfBzZWHu9YE38HzRUQ2xRZohYa19JaK7EOaQDqz5K1sz_g@mail.gmail.com>
         <20221220134003.GC26315@pengutronix.de>
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

Le mardi 20 d=C3=A9cembre 2022 =C3=A0 14:40 +0100, Michael Grzeschik a =C3=
=A9crit=C2=A0:
> Hi Ezequiel,
>=20
> On Mon, Dec 19, 2022 at 10:52:02PM -0300, Ezequiel Garcia wrote:
> > On Mon, Dec 19, 2022 at 6:54 PM Michael Grzeschik <mgr@pengutronix.de> =
wrote:
> > > On Mon, Dec 19, 2022 at 06:07:38PM -0300, Ezequiel Garcia wrote:
> > > > On Mon, Dec 19, 2022 at 12:56 PM Benjamin Gaignard
> > > > <benjamin.gaignard@collabora.com> wrote:
> > > > >=20
> > > > > This series implement AV1 stateless decoder for RK3588 SoC.
> > > > > The harware support 8 and 10 bits bitstreams up to 7680x4320.
> > > > > AV1 feature like film grain or scaling are done by the postproces=
sor.
> > > > > The driver can produce NV12_4L4 and NV12 pixel formats.
> > > > > A native 10bits NV12_4L4 format is possible but need more investi=
gation
> > > > > to be completly documented and enabled.
> > > > >=20
> > > > > It is based on Daniel's "[RFC,v3] media: Add AV1 uAPI" [1] patche=
s and
> > > > > Sebastian's device-tree patches for RK3588.
> > > > >=20
> > > >=20
> > > > I thought the AV1 decoder in RK3588 was really a separate hardware
> > > > from the Hantro G1/G2.
> > > >=20
> > > > Shouldn't this need a new driver for this new hardware?
> > >=20
> > > Just jumping into this discussion as I am currently working on the rk=
venc driver.
> > >=20
> >=20
> > The more the merrier, there's always room for developers :-)
> >=20
> > > In my case I am extending the rkvdec driver to become more generic fo=
r
> > > other rockchip specific enc/decoders.
> > >=20
> > > My first change looks like this:
> > > ---
> > >  drivers/staging/media/rkvdec/Makefile              |   4 +-
> > >  drivers/staging/media/rkvdec/rkvdec-h264.c         | 100 ++++-----
> > >  drivers/staging/media/rkvdec/rkvdec-vp9.c          | 142 ++++++-----=
--
> > >  drivers/staging/media/rkvdec/{rkvdec.c =3D> rkvpu.c} | 510 +++++++++=
++++++++++++++-----------------------
> > >  drivers/staging/media/rkvdec/{rkvdec.h =3D> rkvpu.h} |  66 +++---
> > > ---
> > >=20
> > > While working on other parts of the encoder I found many places in th=
e
> > > rkvdec driver (e.g. v4l2 and vb2 callbacks) that looked familiar to t=
he hantro
> > > functions but where limited to the decoder case.
> > >=20
> >=20
> > Because stateless decoders devices are very similar in their general be=
havior,
> > their drivers could be very similar.
> >=20
> > Hantro and Rkvdec could look similar because the same humans worked on =
them.
> >=20
> > Most boilerplate code, as well as V4L2 format negotiation, VB2 buffer h=
andling
> > could be shared among all stateless decoder drivers. I think even at on=
e point
> > we experimented with having a shared/common code base for all stateless=
 codecs.
> >=20
> > In other words, it's entirely possible to support Hantro devices in
> > the Cedrus driver
> > and vice-versa, you would only have to write the hardware-specific bits=
.
> >=20
> > However, there is consensus to have a separate driver for each
> > different hardware,
> > even when the hardware is a bit similar. This may lead to some code dup=
lication,
> > but it's less fragile / more flexible. Maintaining drivers this way all=
ows
> > developers to evolve, testing on a small family of devices, without
> > breaking support
> > for other devices.
> >=20
> > This is important as sometimes it's hard to get the hardware,
> > but we still don't want to break the support!
> >=20
> > > I think there are two options for the av1 codec.
> > >=20
> > > 1) If the vpu981 is a driver that has nothing to do with verisilicon =
but
> > > works with this driver framework, then we should integrate vepu981 in=
to it
> > > but consider rename the verisilicon unrelated parts to something gene=
ric.
> > >=20
> > > 2) Move the vepu981 av1 driver into the rkvdec instead.
> > >=20
> > > If 1) is the way to go, we can even think of moving the staging code =
parts from
> > > rkvdec to the verisilicon code. Likewise to the vepu981-av1.
> > >=20
> >=20
> > The Hantro driver should only support G1, G2, and VC8000D;
> > which can be said to belong to the same family.
> >=20
> > The RKVDEC driver supports Rockchip vdpu34x core. I have to admit
> > I'm not exactly sure if we support anything else than vdpu34x.
>=20
> Currently the rkvdec is only supporting vdpu34x. My work would integrate
> vepu54x into the rkvdec boilerplate and so it would support encode as dec=
ode.

Which CODEC do you currently work on ? We are about to send a first RFC for=
 a
VP8 stateless encoder API (with a rk3399 driver to test), but haven't writt=
en
the Stateless Encoder API spec yet, so still some work there. And was plann=
ing
to make an H.264 Sateless Encoder soon. Would be nice to avoid duplicating =
the
effort.

>=20
> > I'm not familiar with the AV1 support provided by this patch,
> > but looking at the mpp code:
> >=20
> > ...
> >        "rk3588",
> >        ROCKCHIP_SOC_RK3588,
> >        HAVE_VDPU2 | HAVE_VDPU2_PP | HAVE_VEPU2 | HAVE_RKVDEC | HAVE_RKV=
ENC |
> >        HAVE_JPEG_DEC | HAVE_AV1DEC | HAVE_AVSDEC | HAVE_VEPU2_JPEG,
> >        {   &vdpu38x, &rkjpegd, &vdpu2, &vdpu2_jpeg_pp, &av1d, &avspd},
> >        {   &vepu58x, &vepu2, &vepu2_jpeg, NULL, },
> >=20
> > Seems RK3588 supports a Hantro core (VDPU2), a vdpu38x core and this AV=
1 core,
> > which according to this patchset is vdpu981 (?)
> >=20
> > If the vdpu38x device interface, configuration, buffer handling and
> > registers are
> > similar enough with vdpu34x, adding vdpu38x to the Rkvdec driver
> > should be straightforward.
> > If the vdpu38x core differs, it may be reason enough to consider a new =
driver.
> >=20
> > As for vdpu981 (AV1), I'm inclined to think it deserves its own driver.

Well, it has its own driver, Hantro (which is not rkvdec). But maybe you co=
uld
extend on why you think VC9000D decoder have no place in the hantro/verisil=
icon
family ?

> >=20
> > Again, I'm far less worried for a little code duplication in the
> > boilerplate (which can be solved
> > with helpers, etc.) and more worried about making sure we can evolve
> > drivers easily,
> > while minimizing regressions.
>=20
> Thanks for the explanation.
>=20
> As I agree that not breaking current drivers is a strong argument. Also
> rkvdec is still in staging, which makes it less harmful for the
> integration of the encoder path.

We are working on unstaging patches.

>=20
> Since we can not ensure that the rkvenc/rkvdec is not another unknown
> verisilicon core, going the way of working on a common rkvpu driver is
> probably the best for now.

We can collectively share our knowledge (to the limit of our legal rights t=
o
share) make the right call. In the case of this VC9000D decoder, there is a
massive amount of registers that aren't AV1 specific, and existed in VC8000
cores as it, same offset, same size. Hantro designs have this very specific
style, which is to share register, giving it a meaning for multiple CODECs.

I've commented about that in my review, but until we have more codecs suppo=
rt on
VC9000 cores, generalizing the register definition is premature.

Though, an typical example of things that are Hantro specific and common to=
 G1,
VC8000 and VC9000, is the handling of references for H.264 decoding. This
differs massively from how it works with rkvdec here.

>=20
> Also, since I have already done some work into that direction, it sounds
> good for me. :)

Great. For you interest, the modified Hantro H1 encoder is an information t=
hat
Rockchip disclosed to us directly. And that whys vepu121 (if my memory is r=
ight)
is implemented in Hantro driver. The register layout have been altered by R=
K but
that's all there is, it does share semantic (and a lot of code) with the "r=
eal"
H1 found on RK3288, IMX8M Mini and others.

>=20
>=20
> > > I could also keep on integrating the rkvenc on that base instead.
> > >=20
> > > Regards,
> > > Michael
> > >=20
> > > > > The full branch can be found here:
> > > > > https://gitlab.collabora.com/linux/for-upstream/-/commits/rk3588_=
av1_decoder_v1
> > > > >=20
> > > > > Fluster score is: 151/239 while testing AV1-TEST-VECTORS with GSt=
reamer-AV1-V4L2SL-Gst1.0.
> > > > > The failing tests are:
> > > > > - 10bits bitstream because 10bits output formats aren't yet imple=
mented.
> > > > > - the 2 tests with 2 spatial layers: few errors in luma/chroma va=
lues
> > > > > - tests with resolution < hardware limit (64x64)
> > > > >=20
> > > > > Benjamin
> > > > >=20
> > > > > Benjamin Gaignard (9):
> > > > >   dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible
> > > > >   media: verisilicon: Add AV1 decoder mode and controls
> > > > >   media: verisilicon: Save bit depth for AV1 decoder
> > > > >   media: verisilicon: Check AV1 bitstreams bit depth
> > > > >   media: verisilicon: Compute motion vectors size for AV1 frames
> > > > >   media: verisilicon: Add AV1 entropy helpers
> > > > >   media: verisilicon: Add Rockchip AV1 decoder
> > > > >   media: verisilicon: Add film grain feature to AV1 driver
> > > > >   media: verisilicon: Enable AV1 decoder on rk3588
> > > > >=20
> > > > >  .../bindings/media/rockchip-vpu.yaml          |    1 +
> > > > >  drivers/media/platform/verisilicon/Makefile   |    3 +
> > > > >  drivers/media/platform/verisilicon/hantro.h   |    5 +
> > > > >  .../media/platform/verisilicon/hantro_drv.c   |   54 +
> > > > >  .../media/platform/verisilicon/hantro_hw.h    |  102 +
> > > > >  .../platform/verisilicon/hantro_postproc.c    |    3 +
> > > > >  .../media/platform/verisilicon/hantro_v4l2.c  |    5 +
> > > > >  .../verisilicon/rockchip_av1_entropymode.c    | 4536 +++++++++++=
++++++
> > > > >  .../verisilicon/rockchip_av1_entropymode.h    |  272 +
> > > > >  .../verisilicon/rockchip_av1_filmgrain.c      |  401 ++
> > > > >  .../verisilicon/rockchip_av1_filmgrain.h      |   36 +
> > > > >  .../verisilicon/rockchip_vpu981_hw_av1_dec.c  | 2280 +++++++++
> > > > >  .../verisilicon/rockchip_vpu981_regs.h        |  477 ++
> > > > >  .../platform/verisilicon/rockchip_vpu_hw.c    |  116 +
> > > > >  14 files changed, 8291 insertions(+)
> > > > >  create mode 100644 drivers/media/platform/verisilicon/rockchip_a=
v1_entropymode.c
> > > > >  create mode 100644 drivers/media/platform/verisilicon/rockchip_a=
v1_entropymode.h
> > > > >  create mode 100644 drivers/media/platform/verisilicon/rockchip_a=
v1_filmgrain.c
> > > > >  create mode 100644 drivers/media/platform/verisilicon/rockchip_a=
v1_filmgrain.h
> > > > >  create mode 100644 drivers/media/platform/verisilicon/rockchip_v=
pu981_hw_av1_dec.c
> > > > >  create mode 100644 drivers/media/platform/verisilicon/rockchip_v=
pu981_regs.h
> > > > >=20
> > > > > --
> > > > > 2.34.1
> > > > >=20
> > > >=20
> > > > _______________________________________________
> > > > linux-arm-kernel mailing list
> > > > linux-arm-kernel@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > > >=20
> > >=20
> > > --
> > > Pengutronix e.K.                           |                         =
    |
> > > Steuerwalder Str. 21                       | http://www.pengutronix.d=
e/  |
> > > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0=
    |
> > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5=
555 |
> >=20
>=20

