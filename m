Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2B7631892
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 03:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiKUCRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 21:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiKUCRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 21:17:23 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B527627B17;
        Sun, 20 Nov 2022 18:16:29 -0800 (PST)
Received: from droid01-xa.amlogic.com (10.88.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Mon, 21 Nov 2022
 10:16:27 +0800
From:   Jiucheng Xu <jiucheng.xu@amlogic.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Chris Healy <cphealy@gmail.com>,
        Chris Healy <healych@amazon.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v12 2/3] docs/perf: Add documentation for the Amlogic G12 DDR PMU
Date:   Mon, 21 Nov 2022 10:15:59 +0800
Message-ID: <20221121021602.3306998-2-jiucheng.xu@amlogic.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221121021602.3306998-1-jiucheng.xu@amlogic.com>
References: <20221121021602.3306998-1-jiucheng.xu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.88.11.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a user guide to show how to use DDR PMU to
monitor DDR bandwidth on Amlogic G12 SoC

Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
Reviewed-by: Chris Healy <healych@amazon.com>
---
Changes v11 -> v12:
  - No change

Changes v10 -> v11:
  - Reword perf documentation

Changes v9 -> v10:
  - Rebase code
  - Add "Reviewed-by" tag

Changes v8 -> v9:
  - No change

Changes v7 -> v8:
  - No change

Changes v6 -> v7:
  - Drop the Reported-by tag
  - Fix spelling error

Changes v5 -> v6:
  - No change

Changes v4 -> v5:
  - Fix building warning

Changes v3 -> v4:
  - No change

Changes v2 -> v3:
  - Rename doc name from aml-ddr-pmu.rst to meson-ddr-pmu.rst

Changes v1 -> v2:
  - Nothing was changed
---
 Documentation/admin-guide/perf/index.rst      |  1 +
 .../admin-guide/perf/meson-ddr-pmu.rst        | 70 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 72 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/meson-ddr-pmu.rst

diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index 793e1970bc05..c767e03e4d34 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -19,3 +19,4 @@ Performance monitor support
    arm_dsu_pmu
    thunderx2-pmu
    alibaba_pmu
+   meson-ddr-pmu
diff --git a/Documentation/admin-guide/perf/meson-ddr-pmu.rst b/Documentation/admin-guide/perf/meson-ddr-pmu.rst
new file mode 100644
index 000000000000..8e71be1d6346
--- /dev/null
+++ b/Documentation/admin-guide/perf/meson-ddr-pmu.rst
@@ -0,0 +1,70 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================================
+Amlogic SoC DDR Bandwidth Performance Monitoring Unit (PMU)
+===========================================================
+
+The Amlogic Meson G12 SoC contains a bandwidth monitor inside DRAM controller.
+The monitor includes 4 channels. Each channel can count the request accessing
+DRAM. The channel can count up to 3 AXI port simultaneously. It can be helpful
+to show if the performance bottleneck is on DDR bandwidth.
+
+Currently, this driver supports the following 5 perf events:
+
++ meson_ddr_bw/total_rw_bytes/
++ meson_ddr_bw/chan_1_rw_bytes/
++ meson_ddr_bw/chan_2_rw_bytes/
++ meson_ddr_bw/chan_3_rw_bytes/
++ meson_ddr_bw/chan_4_rw_bytes/
+
+meson_ddr_bw/chan_{1,2,3,4}_rw_bytes/ events are channel-specific events.
+Each channel support filtering, which can let the channel to monitor
+individual IP module in SoC.
+
+Below are DDR access request event filter keywords:
+
++ arm             - from CPU
++ vpu_read1       - from OSD + VPP read
++ gpu             - from 3D GPU
++ pcie            - from PCIe controller
++ hdcp            - from HDCP controller
++ hevc_front      - from HEVC codec front end
++ usb3_0          - from USB3.0 controller
++ hevc_back       - from HEVC codec back end
++ h265enc         - from HEVC encoder
++ vpu_read2       - from DI read
++ vpu_write1      - from VDIN write
++ vpu_write2      - from di write
++ vdec            - from legacy codec video decoder
++ hcodec          - from H264 encoder
++ ge2d            - from ge2d
++ spicc1          - from SPI controller 1
++ usb0            - from USB2.0 controller 0
++ dma             - from system DMA controller 1
++ arb0            - from arb0
++ sd_emmc_b       - from SD eMMC b controller
++ usb1            - from USB2.0 controller 1
++ audio           - from Audio module
++ sd_emmc_c       - from SD eMMC c controller
++ spicc2          - from SPI controller 2
++ ethernet        - from Ethernet controller
+
+
+Examples:
+
+  + Show the total DDR bandwidth per seconds:
+
+    .. code-block:: bash
+
+       perf stat -a -e meson_ddr_bw/total_rw_bytes/ -I 1000 sleep 10
+
+
+  + Show individual DDR bandwidth from CPU and GPU respectively, as well as
+    sum of them:
+
+    .. code-block:: bash
+
+       perf stat -a -e meson_ddr_bw/chan_1_rw_bytes,arm=1/ -I 1000 sleep 10
+       perf stat -a -e meson_ddr_bw/chan_2_rw_bytes,gpu=1/ -I 1000 sleep 10
+       perf stat -a -e meson_ddr_bw/chan_3_rw_bytes,arm=1,gpu=1/ -I 1000 sleep 10
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 415eaa30c523..b76c4deddf22 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1098,6 +1098,7 @@ M:	Jiucheng Xu <jiucheng.xu@amlogic.com>
 L:	linux-amlogic@lists.infradead.org
 S:	Supported
 W:	http://www.amlogic.com
+F:	Documentation/admin-guide/perf/meson-ddr-pmu.rst
 F:	drivers/perf/amlogic/
 F:	include/soc/amlogic/
 
-- 
2.25.1

