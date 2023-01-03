Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E691165C4B9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbjACREa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbjACRCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:02:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE0213E29;
        Tue,  3 Jan 2023 09:01:11 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:abfa:cf23:1e4e:2b14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2E89E6602CEE;
        Tue,  3 Jan 2023 17:01:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672765269;
        bh=tup4Eb76uspONm3q+7VqPIP2eK1mHXuDxCsrk3zil+E=;
        h=From:To:Cc:Subject:Date:From;
        b=KT9UTq4eeQv0Q4/KCdUvU9Bd96a6GbLZAcLFHIXJhg8zZ+Sm4j2x1zf+0SJFrKeo9
         jvwa6VTL4GkcdUHdBn7b0p9ozMWVHncNPrTkFsY6rtlQMGxheGrkB3KCwRA0JhWf9/
         aJ5Ri3h1sfMPKVHdCY5rBv7t7McWfSbUzYR1UhSSlblpggcfgOrtuJwgGH7GGJPNO8
         OnKHYw5oLFGbjKVO5kH0ZJkAy27pyyUKlRRgXS6qT9ZDHg+ny5mPB384sI8ANYoccE
         cwX7j90Sx1cfGfkABX3G5cA+OTDwkb60vMB9e7q+dIusJcWDQUYOsHjWow90Y8uK9s
         w5pSlEDS6jTHA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2 00/13] AV1 stateless decoder for RK3588
Date:   Tue,  3 Jan 2023 18:00:45 +0100
Message-Id: <20230103170058.810597-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implement AV1 stateless decoder for RK3588 SoC.
The hardware support 8 and 10 bits bitstreams up to 7680x4320.
AV1 feature like film grain or scaling are done by the postprocessor.
The driver can produce NV12_4L4, NV12_10LE40_4L4, NV12 and P010 pixels formats.
Even if Rockchip have named the hardware VPU981 it looks like a VC9000 but 
with a different registers mapping.

It is based on Daniel's "[PATCH v4] media: Add AV1 uAPI" [1] patches and
Sebastian's device-tree patches for RK3588.

The full branch can be found here:
https://gitlab.collabora.com/linux/for-upstream/-/commits/rk3588_av1_decoder_v2

Fluster score is: 200/239 while testing AV1-TEST-VECTORS with GStreamer-AV1-V4L2SL-Gst1.0.
The failing tests are:
- the 2 tests with 2 spatial layers: few errors in luma/chroma values
- tests with resolution < hardware limit (64x64)
- 10bits film grain test: bad macroblocks while decoding, the same 8bits
  test is working fine.

Changes in v2:
- Remove useless +1 in sbs computation. 
- Describe NV12_10LE40_4L4 pixels format.
- Post-processor could generate P010.
- Fix comments done on v1.
- The last patch make sure that only post-processed formats are used when film
  grain feature is enabled.

Benjamin

[1] https://lore.kernel.org/linux-media/20230103154832.6982-1-daniel.almeida@collabora.com/T/#u
 
Benjamin Gaignard (12):
  dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible
  media: Add NV12_10LE40_4L4 pixel format
  media: verisilicon: Get bit depth for V4L2_PIX_FMT_NV12_10LE40_4L4
  media: verisilicon: Add AV1 decoder mode and controls
  media: verisilicon: Save bit depth for AV1 decoder
  media: verisilicon: Check AV1 bitstreams bit depth
  media: verisilicon: Compute motion vectors size for AV1 frames
  media: verisilicon: Add AV1 entropy helpers
  media: verisilicon: Add Rockchip AV1 decoder
  media: verisilicon: Add film grain feature to AV1 driver
  media: verisilicon: Enable AV1 decoder on rk3588
  media: verisilicon: Conditionnaly ignore native formats

Nicolas Dufresne (1):
  v4l2-common: Add support for fractional bpp

 .../bindings/media/rockchip-vpu.yaml          |    1 +
 .../media/v4l/pixfmt-yuv-planar.rst           |    4 +
 drivers/media/platform/verisilicon/Makefile   |    3 +
 drivers/media/platform/verisilicon/hantro.h   |    8 +
 .../media/platform/verisilicon/hantro_drv.c   |   65 +
 .../media/platform/verisilicon/hantro_hw.h    |  103 +
 .../platform/verisilicon/hantro_postproc.c    |    7 +
 .../media/platform/verisilicon/hantro_v4l2.c  |   52 +-
 .../verisilicon/rockchip_av1_entropymode.c    | 4546 +++++++++++++++++
 .../verisilicon/rockchip_av1_entropymode.h    |  272 +
 .../verisilicon/rockchip_av1_filmgrain.c      |  401 ++
 .../verisilicon/rockchip_av1_filmgrain.h      |   36 +
 .../verisilicon/rockchip_vpu981_hw_av1_dec.c  | 2278 +++++++++
 .../verisilicon/rockchip_vpu981_regs.h        |  477 ++
 .../platform/verisilicon/rockchip_vpu_hw.c    |  119 +
 drivers/media/v4l2-core/v4l2-common.c         |  149 +-
 drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
 include/media/v4l2-common.h                   |    2 +
 include/uapi/linux/videodev2.h                |    1 +
 19 files changed, 8438 insertions(+), 87 deletions(-)
 create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entropymode.c
 create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entropymode.h
 create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_filmgrain.c
 create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_filmgrain.h
 create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
 create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_regs.h

-- 
2.34.1

