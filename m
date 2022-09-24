Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781105E8DD9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 17:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbiIXP2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 11:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiIXP2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 11:28:33 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D33F9A682;
        Sat, 24 Sep 2022 08:28:30 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0EB961C0002;
        Sat, 24 Sep 2022 15:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1664033309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Y+GN/Y77mrI21YaO//Y6K2OXQ50jAuwAWf6PBaSr6oE=;
        b=RarHNf+P7agemyGav7PmtXraa+xdOav9nMXQlgDQcVk6Ba3X3p+jBBzxLwfoyRVsnb+RIp
        iLtHeA2zL9O8xtizkcaq9dzz1j15O/GcOMhbIpe8KF1mu9vSA2Jju7/MZfp7a6HSiVBSSB
        olL8g5lplqyjOpGaDVEI+oSNu6iSQ8cv2kxwSLUqucE0G4UPSqbBxJchtCzXZjVKTYs3Hl
        rbfZHMGcWEyB3K9sJtPVa2/m7aqmkqS6My8rT7TFLxN3KjKk6x8uRJ1DjN9/6A1OSWC1UL
        t/MB/VMV/k1B9axw+qFxLdhNRUupSvNfoKH9tfNTbLXreg8+3I4MEaVOaWDE4w==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v6 0/7] Allwinner A31/A83T MIPI CSI-2 and A31 ISP / Platform Support
Date:   Sat, 24 Sep 2022 17:28:13 +0200
Message-Id: <20220924152820.77149-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.3
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

This part only concerns Allwinner platform support changes.

Though some patches still need reviewing, they feel ready to go since the
MIPI CSI-2 bindings were merged, the updated CSI bindings were reviewed by
Rob and the new ISP bindings as well. Although they were not merged yet,
they seem ready to go at this point.

Since this multi-part series has been going on for a while, it would be
great to see it merged soon!

Changes since v5:
- Added BananaPi M3 camera sensor support as device-tree overlays;
- Cleaned-up OV8865 regulator definitions;
- Always declared the internal links between CSI and MIPI CSI-2 on A83T
  in device-tree.

Changes since v4:
- Removed mbus bindings patch: an equivalent change was merged;
- Added collected tags;
- Rebased on latest media tree.

Changes since v3:
- Reordered v3s mbus compatible in binding;
- Added collected tag;
- Removed rejected interconnects fix.

Changes since all-in-one v2:
- Corrected mbus index used for the interconnects;
- Used extended mbus binding and exported the DRAM clock for that;
- Reworked the description of the core openfirmware change to give
  more insight about the situation.

Paul Kocialkowski (7):
  clk: sunxi-ng: v3s: Export MBUS and DRAM clocks to the public header
  ARM: dts: sun8i: v3s: Add mbus node to represent the interconnect
  ARM: dts: sun8i: v3s: Add nodes for MIPI CSI-2 support
  ARM: dts: sun8i: v3s: Add support for the ISP
  ARM: dts: sun8i: a83t: Add MIPI CSI-2 controller node
  ARM: dts: sun8i-a83t: Add BananaPi M3 OV5640 camera overlay
  ARM: dts: sun8i-a83t: Add BananaPi M3 OV8865 camera overlay

 arch/arm/boot/dts/Makefile                    |   2 +
 .../sun8i-a83t-bananapi-m3-camera-ov5640.dts  | 117 +++++++++++++++++
 .../sun8i-a83t-bananapi-m3-camera-ov8865.dts  | 109 ++++++++++++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi             |  43 +++++++
 arch/arm/boot/dts/sun8i-v3s.dtsi              | 121 ++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.h          |   4 -
 include/dt-bindings/clock/sun8i-v3s-ccu.h     |   4 +-
 7 files changed, 394 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-a83t-bananapi-m3-camera-ov5640.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a83t-bananapi-m3-camera-ov8865.dts

-- 
2.37.3

