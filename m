Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3098F651522
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 22:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiLSVyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 16:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiLSVyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 16:54:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5FB9FE2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 13:54:51 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1p7O5h-0003Y4-3a; Mon, 19 Dec 2022 22:54:33 +0100
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1p7O5f-0000hb-HD; Mon, 19 Dec 2022 22:54:31 +0100
Date:   Mon, 19 Dec 2022 22:54:31 +0100
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        p.zabel@pengutronix.de, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v1 0/9] AV1 stateless decoder for RK3588
Message-ID: <20221219215431.GB26315@pengutronix.de>
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
 <CAAEAJfBP_D65kjHbwYP+LWfWKfzFtHtWo+3bDcbdO8tPtBurUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <CAAEAJfBP_D65kjHbwYP+LWfWKfzFtHtWo+3bDcbdO8tPtBurUA@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Benjamin,
Hi Ezequiel,

On Mon, Dec 19, 2022 at 06:07:38PM -0300, Ezequiel Garcia wrote:
>On Mon, Dec 19, 2022 at 12:56 PM Benjamin Gaignard
><benjamin.gaignard@collabora.com> wrote:
>>
>> This series implement AV1 stateless decoder for RK3588 SoC.
>> The harware support 8 and 10 bits bitstreams up to 7680x4320.
>> AV1 feature like film grain or scaling are done by the postprocessor.
>> The driver can produce NV12_4L4 and NV12 pixel formats.
>> A native 10bits NV12_4L4 format is possible but need more investigation
>> to be completly documented and enabled.
>>
>> It is based on Daniel's "[RFC,v3] media: Add AV1 uAPI" [1] patches and
>> Sebastian's device-tree patches for RK3588.
>>
>
>I thought the AV1 decoder in RK3588 was really a separate hardware
>from the Hantro G1/G2.
>
>Shouldn't this need a new driver for this new hardware?

Just jumping into this discussion as I am currently working on the rkvenc d=
river.

In my case I am extending the rkvdec driver to become more generic for
other rockchip specific enc/decoders.

My first change looks like this:
---
 drivers/staging/media/rkvdec/Makefile              |   4 +-
 drivers/staging/media/rkvdec/rkvdec-h264.c         | 100 ++++-----
 drivers/staging/media/rkvdec/rkvdec-vp9.c          | 142 ++++++-------
 drivers/staging/media/rkvdec/{rkvdec.c =3D> rkvpu.c} | 510 +++++++++++++++=
++++++++-----------------------
 drivers/staging/media/rkvdec/{rkvdec.h =3D> rkvpu.h} |  66 +++---
---

While working on other parts of the encoder I found many places in the
rkvdec driver (e.g. v4l2 and vb2 callbacks) that looked familiar to the han=
tro
functions but where limited to the decoder case.

I think there are two options for the av1 codec.

1) If the vpu981 is a driver that has nothing to do with verisilicon but
works with this driver framework, then we should integrate vepu981 into it
but consider rename the verisilicon unrelated parts to something generic.

2) Move the vepu981 av1 driver into the rkvdec instead.

If 1) is the way to go, we can even think of moving the staging code parts =
=66rom
rkvdec to the verisilicon code. Likewise to the vepu981-av1.

I could also keep on integrating the rkvenc on that base instead.

Regards,
Michael

>> The full branch can be found here:
>> https://gitlab.collabora.com/linux/for-upstream/-/commits/rk3588_av1_dec=
oder_v1
>>
>> Fluster score is: 151/239 while testing AV1-TEST-VECTORS with GStreamer-=
AV1-V4L2SL-Gst1.0.
>> The failing tests are:
>> - 10bits bitstream because 10bits output formats aren't yet implemented.
>> - the 2 tests with 2 spatial layers: few errors in luma/chroma values
>> - tests with resolution < hardware limit (64x64)
>>
>> Benjamin
>>
>> Benjamin Gaignard (9):
>>   dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible
>>   media: verisilicon: Add AV1 decoder mode and controls
>>   media: verisilicon: Save bit depth for AV1 decoder
>>   media: verisilicon: Check AV1 bitstreams bit depth
>>   media: verisilicon: Compute motion vectors size for AV1 frames
>>   media: verisilicon: Add AV1 entropy helpers
>>   media: verisilicon: Add Rockchip AV1 decoder
>>   media: verisilicon: Add film grain feature to AV1 driver
>>   media: verisilicon: Enable AV1 decoder on rk3588
>>
>>  .../bindings/media/rockchip-vpu.yaml          |    1 +
>>  drivers/media/platform/verisilicon/Makefile   |    3 +
>>  drivers/media/platform/verisilicon/hantro.h   |    5 +
>>  .../media/platform/verisilicon/hantro_drv.c   |   54 +
>>  .../media/platform/verisilicon/hantro_hw.h    |  102 +
>>  .../platform/verisilicon/hantro_postproc.c    |    3 +
>>  .../media/platform/verisilicon/hantro_v4l2.c  |    5 +
>>  .../verisilicon/rockchip_av1_entropymode.c    | 4536 +++++++++++++++++
>>  .../verisilicon/rockchip_av1_entropymode.h    |  272 +
>>  .../verisilicon/rockchip_av1_filmgrain.c      |  401 ++
>>  .../verisilicon/rockchip_av1_filmgrain.h      |   36 +
>>  .../verisilicon/rockchip_vpu981_hw_av1_dec.c  | 2280 +++++++++
>>  .../verisilicon/rockchip_vpu981_regs.h        |  477 ++
>>  .../platform/verisilicon/rockchip_vpu_hw.c    |  116 +
>>  14 files changed, 8291 insertions(+)
>>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entr=
opymode.c
>>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entr=
opymode.h
>>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_film=
grain.c
>>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_film=
grain.h
>>  create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_h=
w_av1_dec.c
>>  create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_r=
egs.h
>>
>> --
>> 2.34.1
>>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmOg3ZEACgkQC+njFXoe
LGT59Q//WpCrWWhjh59Vr+3RoFPGowh5BVF0cgBLcnHwvtlPN+S7WUf9Ej1YYJCg
UrnSFt9zlcJ/djSORCzAe/R7p2S0jwgkJNMUmM1hixXniWsQOhMLzjq4OHinDI3w
LFHjtfjNbswiC/fL6rYCjQWglNpVIiR0S6I0J05KaWIQT6Us9FwmKoyLfJDClJae
gemUkQbngHgtfoMRO+/Bui/JYx4SSbODQkg3PVtokq0aLLt1GXiCyvctckER8UyJ
yAfPmV3BiL2jrEjp4DLTGC00YmdtmDz5y2/Ent6IuIVsIpVTDKvze64OxMc2G/yz
2rDJgILeeHhm0ogOiwB7eSKb/M+ABSVtzlC7TPHvQcZyHCn3TaaqVkrQ/9MLwphq
r52x0GuqQF9rZhsg7ojcU8ARL7ve/2PE9C9qZfVkCOaOcLEWR4V7QcxID8lkcD/t
IRVtxwJL4duLcLx37PLZFGA3tDURHScQW/W2AILVLYJd+C2HsWRqTcC9cY8jQIf4
lQ8NEk+BCswj4aYC1h6317i0BMb979HF3jNH/LDXj0C3hD2T58MN3W5ufzYy9f/C
AA/U4XZXne8B/3tc2kUDSkG8RzcxMUOtB5hqpepBWGswcuQh2YLqWVGB+mTMW/k+
oW/DK7yjI6Aw9JtypRPBpsnxOwInZdbEPDEiJV/vhNK3Rg67X4g=
=+3xk
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
