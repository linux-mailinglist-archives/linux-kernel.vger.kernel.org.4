Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCE865341E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiLUQeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiLUQeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:34:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89ED29A;
        Wed, 21 Dec 2022 08:34:06 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BE2DB6602CC7;
        Wed, 21 Dec 2022 16:34:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671640444;
        bh=de++j1P3f4DdBz0e3wcQHHBTm9Sh0a81SDLOULf9eDA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lDY7glmSygZPvPoifdftqUhARFQu3TJNdaGP8AentuXTYxeM12jpfLEnDIuga2BIb
         P6PYeqoWw8fMJVqG9WbHOwuztg/ExxGH1et4OMHjCIT8TTk5M5EaovArgTu86L8Ynq
         tbup4nDaRIVtWD1nLp88vzQInSoXFJx4hfSiQjiZ96o9Orpwb8vEq2WIuPNNm3sz8g
         AVELc2x/qEjpn9SskC3BqLixfA/bmIlJjEqe6BbxUQLoResV1naERPF06/s6MnpxiX
         LNkF8bfO7HODwaZ1k6qYM3j4qtoJ6MBY1AucYVZBlPPZbgtPlsWzH2dJVvmIobTH3K
         UvWQdEvFIQXFw==
Message-ID: <06799f6b9f1c9422b8f2c7a5eb484f06fbd41fb6.camel@collabora.com>
Subject: Re: [PATCH v1 0/9] AV1 stateless decoder for RK3588
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Wed, 21 Dec 2022 11:33:53 -0500
In-Reply-To: <CAAEAJfBP_D65kjHbwYP+LWfWKfzFtHtWo+3bDcbdO8tPtBurUA@mail.gmail.com>
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
         <CAAEAJfBP_D65kjHbwYP+LWfWKfzFtHtWo+3bDcbdO8tPtBurUA@mail.gmail.com>
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

Le lundi 19 d=C3=A9cembre 2022 =C3=A0 18:07 -0300, Ezequiel Garcia a =C3=A9=
crit=C2=A0:
> Hi Benjamin,
>=20
> On Mon, Dec 19, 2022 at 12:56 PM Benjamin Gaignard
> <benjamin.gaignard@collabora.com> wrote:
> >=20
> > This series implement AV1 stateless decoder for RK3588 SoC.
> > The harware support 8 and 10 bits bitstreams up to 7680x4320.
> > AV1 feature like film grain or scaling are done by the postprocessor.
> > The driver can produce NV12_4L4 and NV12 pixel formats.
> > A native 10bits NV12_4L4 format is possible but need more investigation
> > to be completly documented and enabled.
> >=20
> > It is based on Daniel's "[RFC,v3] media: Add AV1 uAPI" [1] patches and
> > Sebastian's device-tree patches for RK3588.
> >=20
>=20
> I thought the AV1 decoder in RK3588 was really a separate hardware
> from the Hantro G1/G2.
>=20
> Shouldn't this need a new driver for this new hardware?

As discussed on IRC, whenever we enable H.264 and HEVC on VC9000 cores, we =
will
benefit from sharing some very specific code with the G1 and G2 (respective=
ly).
Though for now, there is no overlap as the single core on RK3588 have all o=
ther
codecs disabled by fuse.

>=20
> Thanks!
> Ezequiel
>=20
> > The full branch can be found here:
> > https://gitlab.collabora.com/linux/for-upstream/-/commits/rk3588_av1_de=
coder_v1
> >=20
> > Fluster score is: 151/239 while testing AV1-TEST-VECTORS with GStreamer=
-AV1-V4L2SL-Gst1.0.
> > The failing tests are:
> > - 10bits bitstream because 10bits output formats aren't yet implemented=
.
> > - the 2 tests with 2 spatial layers: few errors in luma/chroma values
> > - tests with resolution < hardware limit (64x64)
> >=20
> > Benjamin
> >=20
> > Benjamin Gaignard (9):
> >   dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible
> >   media: verisilicon: Add AV1 decoder mode and controls
> >   media: verisilicon: Save bit depth for AV1 decoder
> >   media: verisilicon: Check AV1 bitstreams bit depth
> >   media: verisilicon: Compute motion vectors size for AV1 frames
> >   media: verisilicon: Add AV1 entropy helpers
> >   media: verisilicon: Add Rockchip AV1 decoder
> >   media: verisilicon: Add film grain feature to AV1 driver
> >   media: verisilicon: Enable AV1 decoder on rk3588
> >=20
> >  .../bindings/media/rockchip-vpu.yaml          |    1 +
> >  drivers/media/platform/verisilicon/Makefile   |    3 +
> >  drivers/media/platform/verisilicon/hantro.h   |    5 +
> >  .../media/platform/verisilicon/hantro_drv.c   |   54 +
> >  .../media/platform/verisilicon/hantro_hw.h    |  102 +
> >  .../platform/verisilicon/hantro_postproc.c    |    3 +
> >  .../media/platform/verisilicon/hantro_v4l2.c  |    5 +
> >  .../verisilicon/rockchip_av1_entropymode.c    | 4536 +++++++++++++++++
> >  .../verisilicon/rockchip_av1_entropymode.h    |  272 +
> >  .../verisilicon/rockchip_av1_filmgrain.c      |  401 ++
> >  .../verisilicon/rockchip_av1_filmgrain.h      |   36 +
> >  .../verisilicon/rockchip_vpu981_hw_av1_dec.c  | 2280 +++++++++
> >  .../verisilicon/rockchip_vpu981_regs.h        |  477 ++
> >  .../platform/verisilicon/rockchip_vpu_hw.c    |  116 +
> >  14 files changed, 8291 insertions(+)
> >  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_ent=
ropymode.c
> >  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_ent=
ropymode.h
> >  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_fil=
mgrain.c
> >  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_fil=
mgrain.h
> >  create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_=
hw_av1_dec.c
> >  create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_=
regs.h
> >=20
> > --
> > 2.34.1
> >=20

