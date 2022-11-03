Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732BC618492
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiKCQcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiKCQbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:31:36 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458B22BD0;
        Thu,  3 Nov 2022 09:31:31 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 29B25240005;
        Thu,  3 Nov 2022 16:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667493089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=g9u2f1LNWBQapoAmKfsDvXiLDEIzMMojEqVOp7/coKU=;
        b=CsPoPljDVUlVC7jnGSQ5jPhSfoRX0DqL0ZFgn5mWhbiEhQKjX3vm8lcsK1V3VMzdMu5Xm5
        RTZHucmj7vix9y5wB569YAMCWAv/IV3r4wcUJWKo50ttbZhIBED29s2q6TFS1n5XD3fO87
        uReoXaPokD/u4+6KF7xUx7qKfmtoZt60N3GfZRIofTNKbhCSccpS9wrQ43uy5fSWZoHRBX
        HNN4ttFPsMhCaoR5T2ZU+AyYwDwpwkhzvZrg3XzOE6W+1sGSnuURQgIwNaP6Wv56EzMkhn
        AyuDxi3hjLSvJZv2k7rlX8mU5A/wswD3jTWDyr+nSkYfq4ZvgAehbfHVmpD8Mg==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v7 00/28] Allwinner A31/A83T MIPI CSI-2 and A31 ISP / CSI Rework
Date:   Thu,  3 Nov 2022 17:30:45 +0100
Message-Id: <20221103163113.245462-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This part only concerns the rework of the CSI driver to support the MIPI CSI-2
and ISP workflows.

Every patch was reviewed at this point and the whole thing looks good to go.
Since this multi-part series has been going on for a while, it would be great
to see it merged soon!

Changes since v6:
- Removed merged patches;
- Added collected tags;
- Rebased on the latest media tree;
- Followed media/video pipeline helpers changes.

Changes since v5:
- Rebased on latest media tree;
- Switched to using media_pad_remote_pad_first;
- Switched to using media_pad_remote_pad_unique;
- Declared variant const to avoid a warning.

Changes since v4:
- Removed the v4l2 controls handler from the driver;
- Removed the info message about video device registration;
- Fixed "literature" typos;
- Moved patches dependent on the ISP driver to its dedicated series;
- Rebased on the latest media tree;
- Added collected tags;

Changes since v3:
- Updated Kconfig to follow the latest media-wide changes;
- Rebased on latest changes to the driver (JPEG/sRGB colorspaces);
- Added helper to get a single enabled link for an entity's pad, to replace
  source selection at link_validate time and select the remote source at
  stream on time instead;
- Kept clock-managed regmap mmio;
- Added collected review tags;
- Various cosmetic cleanups;

Changes since all-in-one v2:
- Reworked capture video device registration, which stays in the main path.
- Reworked async subdev handling with a dedicated structure holding the
  corresponding source to avoid matching in the driver;
- Added mutex for mbus format serialization;
- Remove useless else in link_validate;
- Reworked commit logs to include missing information;
- Cleaned up Kconfig, added PM dependency;
- Moved platform-specific clock rate to of match data;
- Added collected Reviewed-by tags;
- Updated copyright years;

Paul Kocialkowski (28):
  media: sun6i-csi: Add bridge v4l2 subdev with port management
  media: sun6i-csi: Rename sun6i_video to sun6i_csi_capture
  media: sun6i-csi: Add capture state using vsync for page flip
  media: sun6i-csi: Rework register definitions, invert misleading
    fields
  media: sun6i-csi: Add dimensions and format helpers to capture
  media: sun6i-csi: Implement address configuration without indirection
  media: sun6i-csi: Split stream sequences and irq code in capture
  media: sun6i-csi: Move power management to runtime pm in capture
  media: sun6i-csi: Move register configuration to capture
  media: sun6i-csi: Rework capture format management with helper
  media: sun6i-csi: Remove custom format helper and rework configure
  media: sun6i-csi: Add bridge dimensions and format helpers
  media: sun6i-csi: Get mbus code from bridge instead of storing it
  media: sun6i-csi: Tidy capture configure code
  media: sun6i-csi: Introduce bridge format structure, list and helper
  media: sun6i-csi: Introduce capture format structure, list and helper
  media: sun6i-csi: Configure registers from format tables
  media: sun6i-csi: Introduce format match structure, list and helper
  media: sun6i-csi: Implement capture link validation with logic
  media: sun6i-csi: Get bridge subdev directly in capture stream ops
  media: sun6i-csi: Move hardware control to the bridge
  media: sun6i-csi: Rename the capture video device to sun6i-csi-capture
  media: sun6i-csi: Cleanup headers and includes, update copyright lines
  media: sun6i-csi: Add support for MIPI CSI-2 to the bridge code
  media: sun6i-csi: Only configure capture when streaming
  media: sun6i-csi: Add extra checks to the interrupt routine
  media: sun6i-csi: Request a shared interrupt
  MAINTAINERS: Add myself as sun6i-csi maintainer and rename/move entry

 MAINTAINERS                                   |   17 +-
 .../media/platform/sunxi/sun6i-csi/Makefile   |    2 +-
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      |  751 +-----------
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  141 +--
 .../sunxi/sun6i-csi/sun6i_csi_bridge.c        |  844 +++++++++++++
 .../sunxi/sun6i-csi/sun6i_csi_bridge.h        |   69 ++
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 1089 +++++++++++++++++
 .../sunxi/sun6i-csi/sun6i_csi_capture.h       |   88 ++
 .../platform/sunxi/sun6i-csi/sun6i_csi_reg.h  |  362 +++---
 .../platform/sunxi/sun6i-csi/sun6i_video.c    |  733 -----------
 .../platform/sunxi/sun6i-csi/sun6i_video.h    |   35 -
 11 files changed, 2338 insertions(+), 1793 deletions(-)
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
 delete mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
 delete mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h

-- 
2.38.1

