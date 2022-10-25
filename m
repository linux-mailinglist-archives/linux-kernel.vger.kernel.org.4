Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E891C60C749
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiJYJEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbiJYJDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:03:53 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A0D159D64;
        Tue, 25 Oct 2022 02:03:34 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 29P8dHbv031240;
        Tue, 25 Oct 2022 16:39:17 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 25 Oct
 2022 17:02:03 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <eajames@linux.ibm.com>, <mchehab@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <hverkuil-cisco@xs4all.nl>,
        <laurent.pinchart@ideasonboard.com>, <xavier.roumegue@oss.nxp.com>,
        <ezequiel@vanguardiasur.com.ar>, <stanimir.varbanov@linaro.org>,
        <nicolas.dufresne@collabora.com>, <sakari.ailus@linux.intel.com>,
        <ming.qian@nxp.com>, <andrzej.p@collabora.com>,
        <linux-media@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 3/5] media: Documentation: aspeed-video: Add user documentation for the aspeed-video driver
Date:   Tue, 25 Oct 2022 17:02:01 +0800
Message-ID: <20221025090203.5623-4-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025090203.5623-1-jammy_huang@aspeedtech.com>
References: <20221025090203.5623-1-jammy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 29P8dHbv031240
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add user documentation for the aspeed-video driver.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
v10:
  - new
---
 .../media/drivers/aspeed-video.rst            | 61 +++++++++++++++++++
 .../userspace-api/media/drivers/index.rst     |  1 +
 2 files changed, 62 insertions(+)
 create mode 100644 Documentation/userspace-api/media/drivers/aspeed-video.rst

diff --git a/Documentation/userspace-api/media/drivers/aspeed-video.rst b/Documentation/userspace-api/media/drivers/aspeed-video.rst
new file mode 100644
index 000000000000..798a2588b175
--- /dev/null
+++ b/Documentation/userspace-api/media/drivers/aspeed-video.rst
@@ -0,0 +1,61 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: <isonum.txt>
+
+ASPEED video driver
+===================
+
+ASPEED Video Engine found on AST2400/2500/2600 SoC supports high performance
+video compressions with a wide range of video quality and compression ratio
+options. The adopted compressing algorithm is a modified JPEG algorithm.
+
+There are 2 types of compressions in this IP.
+
+* JPEG JFIF standard mode: for single frame and management compression
+* ASPEED proprietary mode: for multi-frame and differential compression.
+  Support 2-pass (high quality) video compression scheme (Patent pending by
+  ASPEED). Provide visually lossless video compression quality or to reduce
+  the network average loading under intranet KVM applications.
+
+More details on the ASPEED video hardware operations can be found in
+*chapter 6.2.16 KVM Video Driver* of SDK_User_Guide which available on
+AspeedTech-BMC/openbmc/releases.
+
+The ASPEED video driver implements the following driver-specific control:
+
+``V4L2_CID_ASPEED_HQ_MODE``
+-------------------------------
+    Enable/Disable ASPEED's High quality mode. This is a private control
+    that can be used to enable high quality for aspeed proprietary mode.
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 4
+
+    * - ``(0)``
+      - ASPEED HQ mode is disabled.
+    * - ``(1)``
+      - ASPEED HQ mode is enabled.
+
+``V4L2_CID_ASPEED_HQ_JPEG_QUALITY``
+-------------------------------
+    Define the quality of ASPEED's High quality mode. This is a private control
+    that can be used to decide compression quality if High quality mode enabled
+    . Higher the value, better the quality and bigger the size.
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 4
+
+    * - ``(1)``
+      - minimum
+    * - ``(12)``
+      - maximum
+    * - ``(1)``
+      - step
+    * - ``(1)``
+      - default
+
+**Copyright** |copy| 2022 ASPEED Technology Inc.
diff --git a/Documentation/userspace-api/media/drivers/index.rst b/Documentation/userspace-api/media/drivers/index.rst
index 32f82aed47d9..46a494e00b72 100644
--- a/Documentation/userspace-api/media/drivers/index.rst
+++ b/Documentation/userspace-api/media/drivers/index.rst
@@ -31,6 +31,7 @@ For more details see the file COPYING in the source distribution of Linux.
 	:maxdepth: 5
 	:numbered:
 
+	aspeed-video
 	ccs
 	cx2341x-uapi
 	dw100
-- 
2.25.1

