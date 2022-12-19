Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F76A650F7F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiLSP4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiLSP41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:56:27 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6EB6272;
        Mon, 19 Dec 2022 07:56:25 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:f69c:5603:d4ce:7aa2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 91FE36602C25;
        Mon, 19 Dec 2022 15:56:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671465383;
        bh=UyVulrVn+7bAVKLq/DGXCKRzuRojbWRGKmItzsniUQ0=;
        h=From:To:Cc:Subject:Date:From;
        b=KhN5FkuStBnUYbcL5zO5utJ1twZs259RkiQ0rKTDWaQya+3fTR3t4H3pp2ndipwOA
         aey+i8pzNYFD6bYYiK2nSWMzgMISxOKWGj+oh6sVpfgC/69zqQnrtumXX5PqK64H0z
         uhzN+iFAfYKGXjbDSatqMCYi2jJgbz2eT2aC6prJnuyio8KDJNBQBYJPrTGs6x9EQ3
         06TiqQHu0pWkQxFkIbvZFQdv00x3vuTT0vNWV5GFn/s5FS6zVm4xZ/gY1rIpxxeo2q
         TJWk+nhf3cocvtDTRfQQJyRgglb2kLz16xYwG+Brxl6dcpdBQuJ1e07zrMmh6Uzc8G
         ZhXwW5Sa+Zm4A==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v1 0/9] AV1 stateless decoder for RK3588
Date:   Mon, 19 Dec 2022 16:56:07 +0100
Message-Id: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
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
The harware support 8 and 10 bits bitstreams up to 7680x4320.
AV1 feature like film grain or scaling are done by the postprocessor.
The driver can produce NV12_4L4 and NV12 pixel formats.
A native 10bits NV12_4L4 format is possible but need more investigation
to be completly documented and enabled.

It is based on Daniel's "[RFC,v3] media: Add AV1 uAPI" [1] patches and
Sebastian's device-tree patches for RK3588.

The full branch can be found here:
https://gitlab.collabora.com/linux/for-upstream/-/commits/rk3588_av1_decoder_v1

Fluster score is: 151/239 while testing AV1-TEST-VECTORS with GStreamer-AV1-V4L2SL-Gst1.0.
The failing tests are:
- 10bits bitstream because 10bits output formats aren't yet implemented.
- the 2 tests with 2 spatial layers: few errors in luma/chroma values
- tests with resolution < hardware limit (64x64)

Benjamin

Benjamin Gaignard (9):
  dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible
  media: verisilicon: Add AV1 decoder mode and controls
  media: verisilicon: Save bit depth for AV1 decoder
  media: verisilicon: Check AV1 bitstreams bit depth
  media: verisilicon: Compute motion vectors size for AV1 frames
  media: verisilicon: Add AV1 entropy helpers
  media: verisilicon: Add Rockchip AV1 decoder
  media: verisilicon: Add film grain feature to AV1 driver
  media: verisilicon: Enable AV1 decoder on rk3588

 .../bindings/media/rockchip-vpu.yaml          |    1 +
 drivers/media/platform/verisilicon/Makefile   |    3 +
 drivers/media/platform/verisilicon/hantro.h   |    5 +
 .../media/platform/verisilicon/hantro_drv.c   |   54 +
 .../media/platform/verisilicon/hantro_hw.h    |  102 +
 .../platform/verisilicon/hantro_postproc.c    |    3 +
 .../media/platform/verisilicon/hantro_v4l2.c  |    5 +
 .../verisilicon/rockchip_av1_entropymode.c    | 4536 +++++++++++++++++
 .../verisilicon/rockchip_av1_entropymode.h    |  272 +
 .../verisilicon/rockchip_av1_filmgrain.c      |  401 ++
 .../verisilicon/rockchip_av1_filmgrain.h      |   36 +
 .../verisilicon/rockchip_vpu981_hw_av1_dec.c  | 2280 +++++++++
 .../verisilicon/rockchip_vpu981_regs.h        |  477 ++
 .../platform/verisilicon/rockchip_vpu_hw.c    |  116 +
 14 files changed, 8291 insertions(+)
 create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entropymode.c
 create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entropymode.h
 create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_filmgrain.c
 create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_filmgrain.h
 create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
 create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_regs.h

-- 
2.34.1

