Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD546965CF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjBNOGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjBNOGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:06:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240CF1A950;
        Tue, 14 Feb 2023 06:06:06 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:37c0:9b2b:ec16:1f37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4E8356602164;
        Tue, 14 Feb 2023 14:06:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676383564;
        bh=lCZGzUefVKylfoWUKV/EbWCoe8y5l0YLHLVmhsnBen0=;
        h=From:To:Cc:Subject:Date:From;
        b=RwMH/xazFJ2uDySFmxHEb18yvQr2Af9S6p4EhNuLHWpe4y6gLxmEIqWr3KhjLsPUW
         AYfQJ4cSAU0f2I+UT+YGs2StDNmrdhD9vBUCzHBmorb9SYbLrTSNQTTnL2sR7oM/HB
         XsbDbOXGHFYcrseVTFLhjdrHs1aNrnRALDRin7MeBHEsrBvVpm1x+2mTF4AOyPqpvV
         Syu19gmA4hrPqjTHPwBYdUfvF7XPufen89789JQ7ZwHfvRRnfaas1QyGr0gRR4VZ3z
         nUUVTTSk19KrCedlmxZrhiAxLnlN/solT8c67URdp8e7LkHzdeTN8+XdAjU8BQPBoO
         GMYvHsxisPwnQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil@xs4all.nl, nicolas.dufresne@collabora.com,
        jernej.skrabec@gmail.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v4 00/12] AV1 stateless decoder for RK3588
Date:   Tue, 14 Feb 2023 15:05:45 +0100
Message-Id: <20230214140557.537984-1-benjamin.gaignard@collabora.com>
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

It is based on Daniel's "[PATCH v6] media: Add AV1 uAPI" patches [1] and my
own series to fix 10 bits handling in verisilicon driver "[PATCH v8 0/6]
media: verisilicon: HEVC: fix 10bits handling" [2].

The full branch can be found here:
https://gitlab.collabora.com/linux/for-upstream/-/commits/rk3588_av1_decoder_v4

Fluster score is: 200/239 while testing AV1-TEST-VECTORS with GStreamer-AV1-V4L2SL-Gst1.0.
The failing tests are:
- the 2 tests with 2 spatial layers: few errors in luma/chroma values
- tests with resolution < hardware limit (64x64)
- 10bits film grain test: bad macroblocks while decoding, the same 8bits
  test is working fine.

Changes in v4:
- Squash "Save bit depth for AV1 decoder" and "Check AV1 bitstreams bit
  depth" patches.
- Double motion vectors buffer size.
- Fix the various errors reported by Hans.

Changes in v3:
- Fix arrays loops limites.
- Remove unused field.
- Reset raw pixel formats list when bit depth or film grain feature
  values change.
- Enable post-processor P010 support

Changes in v2:
- Remove useless +1 in sbs computation. 
- Describe NV12_10LE40_4L4 pixels format.
- Post-processor could generate P010.
- Fix comments done on v1.
- The last patch make sure that only post-processed formats are used when film
  grain feature is enabled.

Benjamin

[1] https://patchwork.kernel.org/project/linux-media/patch/20230214124254.13356-1-daniel.almeida@collabora.com/
[2] https://www.spinics.net/lists/linux-media/msg226954.html

Benjamin Gaignard (11):
  dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible
  media: Add NV12_10LE40_4L4 pixel format
  media: verisilicon: Get bit depth for V4L2_PIX_FMT_NV12_10LE40_4L4
  media: verisilicon: Add AV1 decoder mode and controls
  media: verisilicon: Check AV1 bitstreams bit depth
  media: verisilicon: Compute motion vectors size for AV1 frames
  media: verisilicon: Add AV1 entropy helpers
  media: verisilicon: Add Rockchip AV1 decoder
  media: verisilicon: Add film grain feature to AV1 driver
  media: verisilicon: Enable AV1 decoder on rk3588
  media: verisilicon: Conditionally ignore native formats

Nicolas Dufresne (1):
  v4l2-common: Add support for fractional bpp

 .../bindings/media/rockchip-vpu.yaml          |    1 +
 .../media/v4l/pixfmt-yuv-planar.rst           |    4 +
 drivers/media/platform/verisilicon/Makefile   |    3 +
 drivers/media/platform/verisilicon/hantro.h   |    8 +
 .../media/platform/verisilicon/hantro_drv.c   |   68 +-
 .../media/platform/verisilicon/hantro_hw.h    |  102 +
 .../platform/verisilicon/hantro_postproc.c    |    9 +-
 .../media/platform/verisilicon/hantro_v4l2.c  |   67 +-
 .../media/platform/verisilicon/hantro_v4l2.h  |    5 +-
 .../verisilicon/rockchip_av1_entropymode.c    | 4424 +++++++++++++++++
 .../verisilicon/rockchip_av1_entropymode.h    |  272 +
 .../verisilicon/rockchip_av1_filmgrain.c      |  401 ++
 .../verisilicon/rockchip_av1_filmgrain.h      |   36 +
 .../verisilicon/rockchip_vpu981_hw_av1_dec.c  | 2234 +++++++++
 .../verisilicon/rockchip_vpu981_regs.h        |  477 ++
 .../platform/verisilicon/rockchip_vpu_hw.c    |  134 +
 drivers/media/v4l2-core/v4l2-common.c         |  149 +-
 drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
 include/media/v4l2-common.h                   |    2 +
 include/uapi/linux/videodev2.h                |    1 +
 20 files changed, 8301 insertions(+), 97 deletions(-)
 create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entropymode.c
 create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entropymode.h
 create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_filmgrain.c
 create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_filmgrain.h
 create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
 create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_regs.h

-- 
2.34.1

