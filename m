Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2CE710F56
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241665AbjEYPSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241652AbjEYPS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:18:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD39191;
        Thu, 25 May 2023 08:18:26 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:17:6c0::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2C63E6605974;
        Thu, 25 May 2023 16:18:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685027905;
        bh=UlQyQzcqGuTpdU5jKpxWIWS4C0om2CVjEO+7lI3Bg3g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HI8T4l6bZpDNxXnhASVlY2DPW1lDXkr2yecfHrGBcYCBVSX9vb8aMt4WzKCCNN0/T
         BWL2ukjX2BMOeXj2awDCSfe4N1VB9pI/uW6p8x/FvYyKkRF//W2SkBmzPIf7DKFk6f
         jx1A/4zgm9QHQ2GJJCvHVQS+g6PlzoOt5A/ipla6VNNhwzdUE0lQtzIbyt43eYLI+O
         fsgHF/VOk9zcOFn5jWLQTn8ki3NyeLZMWqOXwQZApgN7mo2L+2i7AKxH3jDljofb1K
         QF7FqUGe/TAhBfzdHNUtjYbvUvliGWUJNgySn+Ou0kOjjtEgrqwLZDVQZ9A10Bmd19
         iEUcfHR3LL2LQ==
Message-ID: <ab2b13e31e1af52ae52b0678b0abd5dd9d616e8a.camel@collabora.com>
Subject: Re: [PATCH v7 00/13] AV1 stateless decoder for RK3588
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Thu, 25 May 2023 11:18:13 -0400
In-Reply-To: <20230503083438.85139-1-benjamin.gaignard@collabora.com>
References: <20230503083438.85139-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 03 mai 2023 =C3=A0 10:34 +0200, Benjamin Gaignard a =C3=A9crit=
=C2=A0:
> This series implement AV1 stateless decoder for RK3588 SoC.
> The hardware support 8 and 10 bits bitstreams up to 7680x4320.
> AV1 feature like film grain or scaling are done by the postprocessor.
> The driver can produce NV12_4L4, NV12_10LE40_4L4, NV12 and P010 pixels fo=
rmats.
> Even if Rockchip have named the hardware VPU981 it looks like a VC9000 bu=
t=20
> with a different registers mapping.

Just wanted to add a comment about the series. After discussion with Ezequi=
el,
it seems this driver is getting quite big, at some point we should probably
split it, so the newer chips have a driver free from legacy, and also free =
from
having encoders in the same driver. But as usual, who makes the work tend t=
o
rule, and this one did not turned too badly, a lot of the extra work ended
related to issues with the VP9/G2 integration. G2 cores are much closer to
VC8000D/9000D then G1 and might have been the right moment to make the spli=
t,
but we kind of miss that opportunity. The difference is that G2 had highly
limited post processing support, VC8000D/9000D have the same post processor=
,
which is similar in functionality to the G1 post processor.

**Informative, feel free to skip the rest**

Because I was asked at least twice last week, the reason for having encoder=
s in
that driver is that the Hantro H1 and G1 cores shares the same cache storag=
e,
and cannot be run concurrently. The solution that was picked was to place t=
hem
both in the same driver, sharing the same m2m ctx and leaving it to the ker=
nel
scheduler to dispatch on both encoder and decoder cores. Newer VSI cores ca=
n run
concurrently.

In newer chips generation, notably RKVDEC2 and probably VC9000D (we don't h=
ave
spec), the multicore model will not work with such a scheduling model since=
 for
8k stream you need to use 2 cores, where you can use those two concurrently=
 for
other streams. The scheduling will have to be fancier to ensure we don't st=
arve
the 8K+ streams. Having a clean driver to do so will help. This AV1 core do=
es
not have 8K support with this method of binding two cores together, so I se=
e no
harm going forward similarly to what we did for the G2 core (HEVC/VP9). Per=
haps
there is going to be challenges in possibly moving the implementation in fu=
ture,
I'd be very happy to get feedback about this, so the we can help Ezequiel h=
ere
in making sure this driver does not become a giant blob of unrelated but si=
milar
chips all under the same driver.

regards,
Nicolas

>=20
> The full branch can be found here:
> https://gitlab.collabora.com/linux/for-upstream/-/commits/rk3588_av1_deco=
der_v7
>=20
> Fluster score is: 200/239 while testing AV1-TEST-VECTORS with GStreamer-A=
V1-V4L2SL-Gst1.0.
> The failing tests are:
> - the 2 tests with 2 spatial layers: few errors in luma/chroma values
> - tests with resolution < hardware limit (64x64)
> - 10bits film grain test: bad macroblocks while decoding, the same 8bits
>   test is working fine.
>=20
> Changes in v7:
> - Rebased on media_tree master branch.
> - Fix warnings exposed by W=3D1
> - Fix Angelo's comments
>=20
> Changes in v6:
> - Rename NV12_10LE40_4L4 pixel format into NV15_4L4.
> - Add defines for post-proc selection.
> - Change patch order as requested by Nicolas.
> - Fix frame-larger-than warning.
>=20
> Changes in v5:
> - Add a patch to initialize bit_depth field of V4L2_CTRL_TYPE_AV1_SEQUENC=
E
>   ioctl.
>=20
> Changes in v4:
> - Squash "Save bit depth for AV1 decoder" and "Check AV1 bitstreams bit
>   depth" patches.
> - Double motion vectors buffer size.
> - Fix the various errors reported by Hans.
>=20
> Changes in v3:
> - Fix arrays loops limites.
> - Remove unused field.
> - Reset raw pixel formats list when bit depth or film grain feature
>   values change.
> - Enable post-processor P010 support
>=20
> Changes in v2:
> - Remove useless +1 in sbs computation.=20
> - Describe NV12_10LE40_4L4 pixels format.
> - Post-processor could generate P010.
> - Fix comments done on v1.
> - The last patch make sure that only post-processed formats are used when=
 film
>   grain feature is enabled.
>=20
> Benjamin
>=20
>=20
> Benjamin Gaignard (12):
>   dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible
>   media: AV1: Make sure that bit depth in correctly initialize
>   media: Add NV15_4L4 pixel format
>   media: verisilicon: Get bit depth for V4L2_PIX_FMT_NV15_4L4
>   media: verisilicon: Add AV1 decoder mode and controls
>   media: verisilicon: Check AV1 bitstreams bit depth
>   media: verisilicon: Compute motion vectors size for AV1 frames
>   media: verisilicon: Add AV1 entropy helpers
>   media: verisilicon: Add Rockchip AV1 decoder
>   media: verisilicon: Add film grain feature to AV1 driver
>   media: verisilicon: Enable AV1 decoder on rk3588
>   media: verisilicon: Conditionally ignore native formats
>=20
> Nicolas Dufresne (1):
>   v4l2-common: Add support for fractional bpp
>=20
>  .../bindings/media/rockchip-vpu.yaml          |    1 +
>  .../media/v4l/pixfmt-yuv-planar.rst           |   16 +
>  drivers/media/platform/verisilicon/Makefile   |    3 +
>  drivers/media/platform/verisilicon/hantro.h   |    8 +
>  .../media/platform/verisilicon/hantro_drv.c   |   68 +-
>  .../media/platform/verisilicon/hantro_hw.h    |  102 +
>  .../platform/verisilicon/hantro_postproc.c    |    9 +-
>  .../media/platform/verisilicon/hantro_v4l2.c  |   67 +-
>  .../media/platform/verisilicon/hantro_v4l2.h  |    8 +-
>  .../verisilicon/rockchip_av1_entropymode.c    | 4424 +++++++++++++++++
>  .../verisilicon/rockchip_av1_entropymode.h    |  272 +
>  .../verisilicon/rockchip_av1_filmgrain.c      |  401 ++
>  .../verisilicon/rockchip_av1_filmgrain.h      |   36 +
>  .../verisilicon/rockchip_vpu981_hw_av1_dec.c  | 2232 +++++++++
>  .../verisilicon/rockchip_vpu981_regs.h        |  477 ++
>  .../platform/verisilicon/rockchip_vpu_hw.c    |  134 +
>  drivers/media/v4l2-core/v4l2-common.c         |  162 +-
>  drivers/media/v4l2-core/v4l2-ctrls-core.c     |    5 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
>  include/media/v4l2-common.h                   |    2 +
>  include/uapi/linux/videodev2.h                |    1 +
>  21 files changed, 8326 insertions(+), 103 deletions(-)
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entro=
pymode.c
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entro=
pymode.h
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_filmg=
rain.c
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_filmg=
rain.h
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_hw=
_av1_dec.c
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_re=
gs.h
>=20

