Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E66C63AC3C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiK1PYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiK1PY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:24:27 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8303BFACE;
        Mon, 28 Nov 2022 07:23:53 -0800 (PST)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id DEEED100012;
        Mon, 28 Nov 2022 15:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669649031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7HL0ISbsVkEIWmbEKG1N78X+sG+6Ylnu1Jo+z3jhzaE=;
        b=kAC1/FyAqtbv9hVp8wVbDuQMlFbCzMnb+xVN6ZO512uB8K2axp+jpOuDDI8AzyZeBBQzCQ
        VVARyMYmrS577kp/zHni2g6BjK5In3kHaoWifpqr8u2oJmiyuVr4u7oDdhCpQ6np3HRcNK
        EN8icA/QitD3kDNc0knv7uM1DD6CYLuGsgODdxipToeal6H18aJzHuiA3OzjZzIVYIRJNi
        UoQEwu7jCbbWI0/zcg9K4veZPnNfRpfWbxpFOIvzeSsGHxm99yEIdQRA3N+WPfF9dSdfVA
        fx1yGfUSKb1TS/WfWRzODHjvsrNpO7Hqnqvt/45Iroz8vQGYwEA/ixY8V2Gu5Q==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v2 00/21] Add Tegra20 parallel video input capture
Date:   Mon, 28 Nov 2022 16:23:15 +0100
Message-Id: <20221128152336.133953-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra20 and other Tegra SoCs have a video input (VI) peripheral that can
receive from either MIPI CSI-2 or parallel video (called respectively "CSI"
and "VIP" in the documentation). The kernel currently has a staging driver
for Tegra210 CSI capture. This patch set adds support for Tegra20 VIP
capture.

Unfortunately I had no real documentation available to base this work on.
I only had a working downstream 3.1 kernel, so I started with the driver
found there and heavily reworked it to fit into the mainline tegra-video
driver structure. The existing code appears written with the intent of
being modular and allow adding new input mechanisms and new SoCs while
keeping a unique VI core module. However its modularity and extensibility
was not enough to add Tegra20 VIP support, so I added some hooks to turn
hard-coded behaviour into per-SoC or per-bus customizable code. There are
also a fix, some generic cleanups and DT bindings.

Quick tour of the patches:

 * Device tree bindings and minor DTS improvements

   01. dt-bindings: display: tegra: add Tegra20 VIP
   02. dt-bindings: display: tegra: vi: add 'vip' property and example

 * A fix

   03. staging: media: tegra-video: fix .vidioc_enum_fmt_vid_cap to return all formats

 * Minor improvements to logging, comments, cleanups

   04. staging: media: tegra-video: improve documentation of tegra_video_format fields
   05. staging: media: tegra-video: document tegra_channel_get_remote_source_subdev
   06. staging: media: tegra-video: fix typos in comment
   07. staging: media: tegra-video: improve error messages
   08. staging: media: tegra-video: slightly simplify cleanup on errors
   09. staging: media: tegra-video: move private struct declaration to C file
   10. staging: media: tegra-video: remove unneeded include

 * Preparation to make the VI module generic enough to host Tegra20 and VIP

   11. staging: media: tegra-video: Kconfig: allow TPG only on Tegra210
   12. staging: media: tegra-video: move tegra_channel_fmt_align to a per-soc op
   13. staging: media: tegra-video: move default format to soc-specific data
   14. staging: media: tegra-video: move MIPI calibration calls from VI to CSI
   15. staging: media: tegra-video: add a per-soc enable/disable op
   16. staging: media: tegra-video: move syncpt init/free to a per-soc op
   17. staging: media: tegra-video: add syncpts for Tegra20 to struct tegra_vi
   18. staging: media: tegra-video: add hooks for planar YUV and H/V flip
   19. staging: media: tegra-video: add H/V flip controls

 * Implementation of VIP and Tegra20

   20. staging: media: tegra-video: add support for VIP (parallel video input)
   21. staging: media: tegra-video: add tegra20 variant

Enjoy!

Changed in v2:
- improved dt-bindings patches based on reviews
- removed patches 3 and 4 adding DT labels without a mainline user
- two small fixes to the last patch

[v1] https://lore.kernel.org/linux-tegra/20221124155634.5bc2a423@booty/T/#t

Luca

Luca Ceresoli (21):
  dt-bindings: display: tegra: add Tegra20 VIP
  dt-bindings: display: tegra: vi: add 'vip' property and example
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
 .../display/tegra/nvidia,tegra20-vip.yaml     |  63 ++
 MAINTAINERS                                   |  10 +
 drivers/staging/media/tegra-video/Kconfig     |   1 +
 drivers/staging/media/tegra-video/Makefile    |   2 +
 drivers/staging/media/tegra-video/csi.c       |  44 ++
 drivers/staging/media/tegra-video/tegra20.c   | 661 ++++++++++++++++++
 drivers/staging/media/tegra-video/tegra210.c  |  97 ++-
 drivers/staging/media/tegra-video/vi.c        | 321 ++-------
 drivers/staging/media/tegra-video/vi.h        |  76 +-
 drivers/staging/media/tegra-video/video.c     |   5 +
 drivers/staging/media/tegra-video/video.h     |   2 +-
 drivers/staging/media/tegra-video/vip.c       | 298 ++++++++
 drivers/staging/media/tegra-video/vip.h       |  72 ++
 14 files changed, 1434 insertions(+), 286 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
 create mode 100644 drivers/staging/media/tegra-video/tegra20.c
 create mode 100644 drivers/staging/media/tegra-video/vip.c
 create mode 100644 drivers/staging/media/tegra-video/vip.h

-- 
2.34.1

