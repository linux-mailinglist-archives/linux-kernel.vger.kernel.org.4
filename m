Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D60C6F5335
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjECIeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjECIet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:34:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DAC49F0;
        Wed,  3 May 2023 01:34:47 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:8234:977e:ebbe:d70b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AD6DB6602338;
        Wed,  3 May 2023 09:34:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683102886;
        bh=KaqkJvEMba9WXHV9EWAyvWYFN18VeoPcjrsUhdVX16g=;
        h=From:To:Cc:Subject:Date:From;
        b=CgmRKEkTGgIx1oEyBFrOUg0/jrYKx20PgHF5wGTgZYvuPKx/k2BmTLcXwDBvBa/5L
         /M+Vv1Q4XO1GbiCLQ6tHEIlJ5TztDqgPsgBETHtO7eaREav4QSKUJkicStLlIOaySs
         mhHTRCIa6yI2L0fEomcSgDPPZu2kMzFJuiRiSQN79oAZOPjs/Fm5Xe/zxix8MPQXZN
         LvgZPptlHAXkzuK+fz+gvo6zGVZ3Opa7dTcLAaJ8ifXXQ+zpXk1QVu5QMs+k3T5dTa
         XT5k0hgIpkpddtYP7EqOCwdHYZmF/RsK85Jf3Qr9yqDeJah4YVvjbYG/8ynQgTtfX1
         MRD/g+UN7sCUg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v7 00/13] AV1 stateless decoder for RK3588
Date:   Wed,  3 May 2023 10:34:25 +0200
Message-Id: <20230503083438.85139-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

The full branch can be found here:
https://gitlab.collabora.com/linux/for-upstream/-/commits/rk3588_av1_decoder_v7

Fluster score is: 200/239 while testing AV1-TEST-VECTORS with GStreamer-AV1-V4L2SL-Gst1.0.
The failing tests are:
- the 2 tests with 2 spatial layers: few errors in luma/chroma values
- tests with resolution < hardware limit (64x64)
- 10bits film grain test: bad macroblocks while decoding, the same 8bits
  test is working fine.

Changes in v7:
- Rebased on media_tree master branch.
- Fix warnings exposed by W=1
- Fix Angelo's comments

Changes in v6:
- Rename NV12_10LE40_4L4 pixel format into NV15_4L4.
- Add defines for post-proc selection.
- Change patch order as requested by Nicolas.
- Fix frame-larger-than warning.

Changes in v5:
- Add a patch to initialize bit_depth field of V4L2_CTRL_TYPE_AV1_SEQUENCE
  ioctl.

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


Benjamin Gaignard (12):
  dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible
  media: AV1: Make sure that bit depth in correctly initialize
  media: Add NV15_4L4 pixel format
  media: verisilicon: Get bit depth for V4L2_PIX_FMT_NV15_4L4
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
 .../media/v4l/pixfmt-yuv-planar.rst           |   16 +
 drivers/media/platform/verisilicon/Makefile   |    3 +
 drivers/media/platform/verisilicon/hantro.h   |    8 +
 .../media/platform/verisilicon/hantro_drv.c   |   68 +-
 .../media/platform/verisilicon/hantro_hw.h    |  102 +
 .../platform/verisilicon/hantro_postproc.c    |    9 +-
 .../media/platform/verisilicon/hantro_v4l2.c  |   67 +-
 .../media/platform/verisilicon/hantro_v4l2.h  |    8 +-
 .../verisilicon/rockchip_av1_entropymode.c    | 4424 +++++++++++++++++
 .../verisilicon/rockchip_av1_entropymode.h    |  272 +
 .../verisilicon/rockchip_av1_filmgrain.c      |  401 ++
 .../verisilicon/rockchip_av1_filmgrain.h      |   36 +
 .../verisilicon/rockchip_vpu981_hw_av1_dec.c  | 2232 +++++++++
 .../verisilicon/rockchip_vpu981_regs.h        |  477 ++
 .../platform/verisilicon/rockchip_vpu_hw.c    |  134 +
 drivers/media/v4l2-core/v4l2-common.c         |  162 +-
 drivers/media/v4l2-core/v4l2-ctrls-core.c     |    5 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
 include/media/v4l2-common.h                   |    2 +
 include/uapi/linux/videodev2.h                |    1 +
 21 files changed, 8326 insertions(+), 103 deletions(-)
 create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entropymode.c
 create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entropymode.h
 create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_filmgrain.c
 create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_filmgrain.h
 create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
 create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_regs.h

-- 
2.34.1

