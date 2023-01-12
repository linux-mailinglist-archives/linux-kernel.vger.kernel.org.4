Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746806672AD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjALM45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjALM4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:56:37 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA0C4FD7F;
        Thu, 12 Jan 2023 04:56:30 -0800 (PST)
Received: from localhost (89-26-75-29.goll.dyn.salzburg-online.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9D43B6602DB1;
        Thu, 12 Jan 2023 12:56:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673528188;
        bh=yf/m2C7hRsGEy7kT03CMC15PWE124hbMZmn+tBd+Utc=;
        h=From:Subject:Date:To:Cc:From;
        b=BXjQmggaqWxwA1vil5Rll9D905E+z8DNKKS1jMO4J4X+kOJJnbhqzCN7M0NyPkKl7
         gA6EnOMoQrYKtdpCXKVrXQcPIRKfsaWblqo581iqUCURcB6tA4oZZV5kvIPgrhBp1G
         yglk674pIxdAzHsdNQ2RB8U7naMHbTSkwJPmiKYQ2ZYBByObJrQWppU55Ou3ZlhWmk
         zNsUojSE3jmap24u07V+8zeKik4FruRAcrfKkZqK4wMAQMUQaekwxuNT4oO/4aFqv1
         BVnYcugpCzun1mUcRnIMNaGM5Hob+Rqe7uRYmeg/0ML+3aLrrCuLd64/m+bcvBGuwP
         fmgw8WYtr1Hvw==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
Subject: [PATCH v2 00/12] RkVDEC HEVC driver
Date:   Thu, 12 Jan 2023 13:56:16 +0100
Message-Id: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHEDwGMC/2XOMQrDMAyF4asEzVWxlVJIr1I6yLZSa3GDXEIh5
 O51kjHjD++Dt0AVU6nw6BYwmbXqp7SgSwcxc3kLamoN5Kh33nmc+BszHgpnwjsSWvQYxPduTDwM
 twRNB66CwbjEvPkTu+5sW04mo/72D8/Xuv4BA0TReJMAAAA=
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        Jonas Karlman <jonas@kwiboo.se>,
        Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Collabora Kernel-domain <kernel@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673528186; l=7516;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=yf/m2C7hRsGEy7kT03CMC15PWE124hbMZmn+tBd+Utc=;
 b=yj2iPr7OOCp5i8ebV9tk9mBflFqNoI+pjCtWjf+ZVetn0EvAIQ1m7Oy390HJ6IlfwOuVC65OJiXY
 jcuua3LOA3PPDoSR19gRCMbLepSbn/aEp5xFTVpykB19XDSYT1jJ
X-Developer-Key: i=sebastian.fricke@collabora.com; a=ed25519;
 pk=pYXedPwrTtErcj7ERYeo/IpTrpe4QbJuEzSB52fslBg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the HEVC codec variation for the RkVDEC driver. Currently only
the RK3399 is supported, but it is possible to enable the RK3288 as it
also supports this codec.

Changelog:

Changes since V1:
- Adjust NV15 documentation according to review requests by Laurent
- Add a new callback to check whether the supplied SPS (H264/HEVC) is
  compatible with the provided pixel format on the OUTPUT queue. This is used
  to ensure that streaming is only started with a compatible SPS and to unset
  the SPS in case a new OUTPUT queue pixel format is set which is not
  compatible with the latest SPS.
- Add a new callback to return a structure filled with major SPS attributes
  shared by HEVC/H264 in a human readable format.
  (e.g. subsampling=420 instead of chroma_format_idc=1, resolution in pixels
   and bitdepth + 8)
  The idea is to reduce code duplication when fetching those values and calculating
  the actual width & height and to make the code more readable and self-documenting.
- Rework the SPS validation function from H264 to act as the SPS validation
  callback, add helpful error messages to the checks
- Rework the way the SPS is stored in the driver and how the valid format is
  determined. The general workflow is:
  * Set the output format
  * Try & Set the SPS control
  * Driver figures out a matching CAPTURE queue format for the provided SPS and
    stores the SPS in the internal context
  * start streaming & prepare buffers & device_run ...
  User-space is also allowed to change the SPS control at anytime, but it is
  only accepted when no buffers are queued on the CAPTURE queue. Whenever the
  driver needs to know the currently valid CAPTURE queue format, then it will
  utilize the SPS in the context.
- Remove the new bit writer, as this tool should rather be implemented in a
  general manner in a separate patch instead of as a part of this series.
- Ensure that streaming is only started once both queues are running
- Update copyright dates for my changes

The HEVC codec has been tested with the GStreamer V4L2 HEVC plugin.

As general changes were made to the RkVDEC driver I have tested all 3 supported
codecs with GStreamer.

Current Fluster score:
HEVC:
`Ran 134/147 tests successfully               in 282.692 secs`
with
`python3 fluster.py run -d GStreamer-H.265-V4L2SL-Gst1.0 -ts JCT-VC-HEVC_V1 -j1`

H264:
`Ran 129/135 tests successfully               in 78.950 secs`
with
`python3 fluster.py run -d GStreamer-H.264-V4L2SL-Gst1.0 -ts JVT-AVC_V1 -j1`

VP9:
`Ran 228/303 tests successfully               in 327.417 secs`
with
`python3 fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0 -ts VP9-TEST-VECTORS -j1`

No regressions detected.

failed conformance tests:
- DBLK_D_VIXS_2 (Success on Hantro G2)
- DSLICE_A_HHI_5 (Success on Hantro G2)
- EXT_A_ericsson_4 (Success on Hantro G2)
- PICSIZE_A_Bossen_1 (Hardware limitation)
- PICSIZE_B_Bossen_1 (Hardware limitation)
- PICSIZE_C_Bossen_1 (Hardware limitation)
- PICSIZE_D_Bossen_1 (Hardware limitation)
- PPS_A_qualcomm_7 (Success on Hantro G2)
- SAODBLK_A_MainConcept_4 (Success on Hantro G2)
- SAODBLK_B_MainConcept_4 (Success on Hantro G2)
- TSUNEQBD_A_MAIN10_Technicolor_2 (Success on Hantro G2)
- VPSSPSPPS_A_MainConcept_1 (Success on Hantro G2)
- WPP_D_ericsson_MAIN10_2 (Fail on Hantro G2)
- WPP_D_ericsson_MAIN_2 (Fail on Hantro G2)

Not tested with FFMpeg so far.

Known issues:
- Unable to reliably decode multiple videos concurrently
- The SAODBLK_* tests timeout if the timeout time in fluster is lower than 120
- Currently the uv_virstride is calculated in a manner that is hardcoded
  for the two available formats NV12 and NV15. (@config_registers)

Notable design decisions:
- The giant static array of cabac values is moved to a separate c file,
I did so because a separate .h file would be incorrect as it doesn't
expose anything of any value for any other file than the rkvdec-hevc.c
file. Other options were:
  - Calculating the values instead of storing the results (No clear pattern
    found for the calculation using the static array and the formulas from the
    specification)
  - Supply them via firmware (Adding firmware makes the whole software
    way more complicated and the usage of the driver less obvious)

Ignored Checkpatch warnings:
```
WARNING: line length of 162 exceeds 100 columns

+               { .format = V4L2_PIX_FMT_NV15,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 5, 5, 0, 0 }, .hdiv = 2, .vdiv = 2,

ERROR: trailing statements should be on next line

+       case V4L2_PIX_FMT_NV15:         descr = "10-bit Y/CbCr 4:2:0 (Packed)"; break;
```

v4l2-compliance test:
```
v4l2-compliance 1.23.0-4989, 64 bits, 64-bit time_t
v4l2-compliance SHA: b3527e08fbbc 2023-01-10 11:22:13

Total for rkvdec device /dev/video1: 46, Succeeded: 46, Failed: 0, Warnings: 0
```

To: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-staging@lists.linux.dev
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Alex Bee <knaerzche@gmail.com>
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Collabora Kernel-domain <kernel@collabora.com>
Cc: Robert Beckett <bob.beckett@collabora.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>

---
Jonas Karlman (2):
      media: v4l2: Add NV15 pixel format
      media: v4l2-common: Add helpers to calculate bytesperline and sizeimage

Sebastian Fricke (10):
      staging: media: rkvdec: Helper for buffer queue busy check
      staging: media: rkvdec: Block start streaming until both queues run
      staging: media: rkvdec: Add SPS structure to internal context
      staging: media: rkvdec: Add a valid pixel format check as callback
      staging: media: rkvdec: Add a routine to fetch SPS attributes as a callback
      staging: media: rkvdec: Add a valid SPS check as a callback
      staging: media: rkvdec: h264: Add callbacks for h264
      staging: media: rkvdec: Wrapper for pixel format preparation
      staging: media: rkvdec: Enable S_CTRL IOCTL
      staging: media: rkvdec: Add HEVC backend

 .../userspace-api/media/v4l/pixfmt-yuv-planar.rst  |   75 +
 drivers/media/v4l2-core/v4l2-common.c              |   79 +-
 drivers/media/v4l2-core/v4l2-ioctl.c               |    1 +
 drivers/staging/media/rkvdec/Makefile              |    2 +-
 drivers/staging/media/rkvdec/TODO                  |   11 +-
 drivers/staging/media/rkvdec/rkvdec-h264.c         |  105 +-
 drivers/staging/media/rkvdec/rkvdec-hevc-data.c    | 1845 ++++++++++++++++++++
 drivers/staging/media/rkvdec/rkvdec-hevc.c         |  910 ++++++++++
 drivers/staging/media/rkvdec/rkvdec-regs.h         |    1 +
 drivers/staging/media/rkvdec/rkvdec.c              |  300 +++-
 drivers/staging/media/rkvdec/rkvdec.h              |   14 +
 include/uapi/linux/videodev2.h                     |    1 +
 12 files changed, 3244 insertions(+), 100 deletions(-)
---
base-commit: 6599e683db1bf22fee74302c47e31b9a42a1c3d2
change-id: 20230101-patch-series-v2-6-2-rc1-be130fda994d

Best regards,
-- 
Sebastian Fricke <sebastian.fricke@collabora.com>
