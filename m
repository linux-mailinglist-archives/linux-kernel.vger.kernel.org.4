Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4A0622D55
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiKIOTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiKIOTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:19:14 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF3D1C105;
        Wed,  9 Nov 2022 06:19:11 -0800 (PST)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 57288FF804;
        Wed,  9 Nov 2022 14:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668003550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kDIfdqkfme+Jq0Kp8EdrxwE7slaIQ6UkG0ZphGZ60T8=;
        b=B97F4uUYLSsNcszZDnXtr665xosAPvLqT0FxShMsGjpOMTv4meG8gmaxHfJwVzcUSYor2D
        9UxKZtEfqc+Cg5UV3j86Df9I7OTFdESm5xRJI0vBtm1jQXyDvviojuopDqFl1ZOzrI+DLJ
        0U8Ak+Mimled4Rbo4Q5KDCet9tvHHGWJgDpvEmEU32lr9p4ULvx8O80IkPy05x8FOnfF79
        4dDVGdhx0D1vrUGa+Nx4GymEe41q81fhETeCtI6OqNorLJW0B5YIn20Bsn1iwQjRLDU5I9
        +NLVNI3EkVDaEoxJNkezTzdtNoUlxqku+UXYwNG2p1zsPruGkpobV9VDSCUb4Q==
From:   luca.ceresoli@bootlin.com
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH 00/23] Add Tegra20 parallel video input capture
Date:   Wed,  9 Nov 2022 15:18:29 +0100
Message-Id: <20221109141852.729246-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

Tegra20 and other Tegra SoCs have a video input (VI) peripheral that can
receive from either MIPI CSI-2 or parallel video (called respectively "CSI"
and "VIP" in the documentation). The kernel currently has a staging driver
for Tegra210 CSI capture. This patch set adds support for Tegra20 VIP
capture.

Unfortunately I had no real documentation available to base this work on,
and I started from a working downstream 3.1 kernel, that I have heavily
reworked to fit into the existing tegra-video driver. The existing code
appears written with the intent of being modular and allow adding new input
mechanisms and new SoCs while keeping a unique VI core module. However its
modularity and extensibility was not enough to add Tegra20 VIP support, so
I added some hooks to turn hard-coded behaviour into per-SoC or per-bus
customizable code. There are also some fixes, some generic cleanups and DT
bindings.

Quick tour of the patches:

 * Device tree bindings and minor DTS improvements

   01. dt-bindings: display: tegra: add bindings for Tegra20 VIP
   02. dt-bindings: display: tegra: vi: add 'vip' property and example
   03. ARM: dts: tegra20: add label to nvidia,tegra20-vi node
   04. ARM: dts: tegra20-tamonten: add label to avdd_vdac regulator

 * A fix

   05. staging: media: tegra-video: fix .vidioc_enum_fmt_vid_cap to return all formats

 * Minor improvements to logging, comments, cleanups

   06. staging: media: tegra-video: improve documentation of tegra_video_format fields
   07. staging: media: tegra-video: document tegra_channel_get_remote_source_subdev
   08. staging: media: tegra-video: fix typos in comment
   09. staging: media: tegra-video: improve error messages
   10. staging: media: tegra-video: slightly simplify cleanup on errors
   11. staging: media: tegra-video: move private struct declaration to C file
   12. staging: media: tegra-video: remove unneeded include

 * Preparation to make the VI module generic enough to host Tegra20 and VIP

   13. staging: media: tegra-video: Kconfig: allow TPG only on Tegra210
   14. staging: media: tegra-video: move tegra_channel_fmt_align to a per-soc op
   15. staging: media: tegra-video: move default format to soc-specific data
   16. staging: media: tegra-video: move MIPI calibration calls from VI to CSI
   17. staging: media: tegra-video: add a per-soc enable/disable op
   18. staging: media: tegra-video: move syncpt init/free to a per-soc op
   19. staging: media: tegra-video: add syncpts for Tegra20 to struct tegra_vi
   20. staging: media: tegra-video: add hooks for planar YUV and H/V flip
   21. staging: media: tegra-video: add H/V flip controls

 * Implementation of VIP and Tegra20

   22. staging: media: tegra-video: add support for VIP (parallel video input)
   23. staging: media: tegra-video: add tegra20 variant

Enjoy!

Luca

Luca Ceresoli (23):
  dt-bindings: display: tegra: add bindings for Tegra20 VIP
  dt-bindings: display: tegra: vi: add 'vip' property and example
  ARM: dts: tegra20: add label to nvidia,tegra20-vi node
  ARM: dts: tegra20-tamonten: add label to avdd_vdac regulator
  staging: media: tegra-video: fix .vidioc_enum_fmt_vid_cap to return
    all formats
  staging: media: tegra-video: improve documentation of
    tegra_video_format fields
  staging: media: tegra-video: document
    tegra_channel_get_remote_source_subdev
  staging: media: tegra-video: fix typos in comment
  staging: media: tegra-video: improve error messages
  staging: media: tegra-video: slightly simplify cleanup on errors
  staging: media: tegra-video: move private struct declaration to C file
  staging: media: tegra-video: remove unneeded include
  staging: media: tegra-video: Kconfig: allow TPG only on Tegra210
  staging: media: tegra-video: move tegra_channel_fmt_align to a per-soc
    op
  staging: media: tegra-video: move default format to soc-specific data
  staging: media: tegra-video: move MIPI calibration calls from VI to
    CSI
  staging: media: tegra-video: add a per-soc enable/disable op
  staging: media: tegra-video: move syncpt init/free to a per-soc op
  staging: media: tegra-video: add syncpts for Tegra20 to struct
    tegra_vi
  staging: media: tegra-video: add hooks for planar YUV and H/V flip
  staging: media: tegra-video: add H/V flip controls
  staging: media: tegra-video: add support for VIP (parallel video
    input)
  staging: media: tegra-video: add tegra20 variant

 .../display/tegra/nvidia,tegra20-vi.yaml      |  68 ++
 .../display/tegra/nvidia,tegra20-vip.yaml     |  64 ++
 MAINTAINERS                                   |  10 +
 arch/arm/boot/dts/tegra20-tamonten.dtsi       |   2 +-
 arch/arm/boot/dts/tegra20.dtsi                |   2 +-
 drivers/staging/media/tegra-video/Kconfig     |   1 +
 drivers/staging/media/tegra-video/Makefile    |   2 +
 drivers/staging/media/tegra-video/csi.c       |  44 ++
 drivers/staging/media/tegra-video/tegra20.c   | 649 ++++++++++++++++++
 drivers/staging/media/tegra-video/tegra210.c  |  97 ++-
 drivers/staging/media/tegra-video/vi.c        | 321 ++-------
 drivers/staging/media/tegra-video/vi.h        |  76 +-
 drivers/staging/media/tegra-video/video.c     |   5 +
 drivers/staging/media/tegra-video/video.h     |   2 +-
 drivers/staging/media/tegra-video/vip.c       | 298 ++++++++
 drivers/staging/media/tegra-video/vip.h       |  72 ++
 16 files changed, 1425 insertions(+), 288 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
 create mode 100644 drivers/staging/media/tegra-video/tegra20.c
 create mode 100644 drivers/staging/media/tegra-video/vip.c
 create mode 100644 drivers/staging/media/tegra-video/vip.h

-- 
2.34.1

