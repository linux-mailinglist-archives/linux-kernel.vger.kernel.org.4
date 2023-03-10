Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205476B3EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjCJMGO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Mar 2023 07:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCJMGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:06:03 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F29BF8E51;
        Fri, 10 Mar 2023 04:05:57 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 3209C24E2E3;
        Fri, 10 Mar 2023 20:05:56 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 10 Mar
 2023 20:05:56 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 10 Mar
 2023 20:05:55 +0800
From:   Jack Zhu <jack.zhu@starfivetech.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        "Todor Tomov" <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jack.zhu@starfivetech.com>,
        <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 3/6] media: admin-guide: Add starfive_camss.rst for Starfive Camera Subsystem
Date:   Fri, 10 Mar 2023 20:05:50 +0800
Message-ID: <20230310120553.60586-4-jack.zhu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310120553.60586-1-jack.zhu@starfivetech.com>
References: <20230310120553.60586-1-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the file 'starfive_camss.rst' that documents the Starfive Camera
Subsystem driver which is used for handing image sensor data.

Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
---
 .../admin-guide/media/starfive_camss.rst      | 68 +++++++++++++++++++
 .../media/starfive_camss_graph.dot            | 28 ++++++++
 .../admin-guide/media/v4l-drivers.rst         |  1 +
 3 files changed, 97 insertions(+)
 create mode 100644 Documentation/admin-guide/media/starfive_camss.rst
 create mode 100644 Documentation/admin-guide/media/starfive_camss_graph.dot

diff --git a/Documentation/admin-guide/media/starfive_camss.rst b/Documentation/admin-guide/media/starfive_camss.rst
new file mode 100644
index 000000000000..12c5ebf794b8
--- /dev/null
+++ b/Documentation/admin-guide/media/starfive_camss.rst
@@ -0,0 +1,68 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: <isonum.txt>
+
+================================
+Starfive Camera Subsystem driver
+================================
+
+Introduction
+------------
+
+This file documents the driver for the Starfive Camera Subsystem found on
+Starfive JH7110 SoC. The driver is located under drivers/media/platform/starfive.
+
+The driver implements V4L2, Media controller and v4l2_subdev interfaces.
+Camera sensor using V4L2 subdev interface in the kernel is supported.
+
+The driver has been successfully used on the Gstreamer 1.18.5 with
+v4l2src plugin.
+
+
+Starfive Camera Subsystem hardware
+----------------------------------
+
+The Starfive Camera Subsystem hardware consists of:
+
+- MIPI DPHY Receiver: receives mipi data from a MIPI camera sensor.
+- MIPI CSIRx Controller: is responsible for handling and decoding CSI2 protocol
+  based camera sensor data stream.
+- ISP: handles the image data streams from the MIPI CSIRx Controller.
+- VIN(Video In): a top-level module, is responsible for controlling power
+  and clocks to other modules, dumps the input data to memory or transfers the
+  input data to ISP.
+
+
+Topology
+--------
+
+The media controller pipeline graph is as follows:
+
+.. _starfive_camss_graph:
+
+.. kernel-figure:: starfive_camss_graph.dot
+    :alt:   starfive_camss_graph.dot
+    :align: center
+
+The driver has 5 video devices:
+
+- stf_vin0_wr_video0: capture device for images directly from the VIN module.
+- stf_vin0_isp0_video1: capture device for images without scaling.
+- stf_vin0_isp0_ss0_video2: capture device for images with adjustable
+  scale-down factor.
+- stf_vin0_isp0_ss1_video3: capture device for images with adjustable
+  scale-down factor.
+- stf_vin0_isp0_raw_video4: capture device for RAW images.
+
+The driver has 6 subdevices:
+
+- stf_isp0: is responsible for all the isp operations.
+- stf_vin0_wr: used to dump RAW images to memory.
+- stf_vin0_isp0: used to capture unscaled images for the stf_vin0_isp0_video1
+  device.
+- stf_vin0_isp0_ss0: used to resize and downsample frames for
+  the stf_vin0_isp0_ss0_video2 capture device.
+- stf_vin0_isp0_ss1: used to resize and downsample frames for
+  the stf_vin0_isp0_ss1_video3 capture device.
+- stf_vin0_isp0_raw: used to configure the camss ISP to get RAW
+  images for stf_vin0_isp0_raw_video4 capture device.
diff --git a/Documentation/admin-guide/media/starfive_camss_graph.dot b/Documentation/admin-guide/media/starfive_camss_graph.dot
new file mode 100644
index 000000000000..c35dec8de254
--- /dev/null
+++ b/Documentation/admin-guide/media/starfive_camss_graph.dot
@@ -0,0 +1,28 @@
+digraph board {
+	rankdir=TB
+	n00000001 [label="{{<port0> 0} | stf_isp0\n/dev/v4l-subdev0 | {<port1> 1 | <port2> 2 | <port3> 3 | <port4> 4}}", shape=Mrecord, style=filled, fillcolor=green]
+	n00000001:port1 -> n00000010:port0
+	n00000001:port2 -> n00000019:port0 [style=dashed]
+	n00000001:port3 -> n00000022:port0 [style=dashed]
+	n00000001:port4 -> n0000002b:port0 [style=dashed]
+	n00000007 [label="{{<port0> 0} | stf_vin0_wr\n/dev/v4l-subdev1 | {<port1> 1}}", shape=Mrecord, style=filled, fillcolor=green]
+	n00000007:port1 -> n0000000a [style=bold]
+	n0000000a [label="stf_vin0_wr_video0\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
+	n00000010 [label="{{<port0> 0} | stf_vin0_isp0\n/dev/v4l-subdev2 | {<port1> 1}}", shape=Mrecord, style=filled, fillcolor=green]
+	n00000010:port1 -> n00000013 [style=bold]
+	n00000013 [label="stf_vin0_isp0_video1\n/dev/video1", shape=box, style=filled, fillcolor=yellow]
+	n00000019 [label="{{<port0> 0} | stf_vin0_isp0_ss0\n/dev/v4l-subdev3 | {<port1> 1}}", shape=Mrecord, style=filled, fillcolor=green]
+	n00000019:port1 -> n0000001c [style=bold]
+	n0000001c [label="stf_vin0_isp0_ss0_video2\n/dev/video2", shape=box, style=filled, fillcolor=yellow]
+	n00000022 [label="{{<port0> 0} | stf_vin0_isp0_ss1\n/dev/v4l-subdev4 | {<port1> 1}}", shape=Mrecord, style=filled, fillcolor=green]
+	n00000022:port1 -> n00000025 [style=bold]
+	n00000025 [label="stf_vin0_isp0_ss1_video3\n/dev/video3", shape=box, style=filled, fillcolor=yellow]
+	n0000002b [label="{{<port0> 0} | stf_vin0_isp0_raw\n/dev/v4l-subdev5 | {<port1> 1}}", shape=Mrecord, style=filled, fillcolor=green]
+	n0000002b:port1 -> n0000002e [style=bold]
+	n0000002e [label="stf_vin0_isp0_raw_video4\n/dev/video4", shape=box, style=filled, fillcolor=yellow]
+	n0000003c [label="{{<port0> 0} | cdns_csi2rx.19800000.csi-bridge\n/dev/v4l-subdev6 | {<port1> 1 | <port2> 2 | <port3> 3 | <port4> 4}}", shape=Mrecord, style=filled, fillcolor=green]
+	n0000003c:port1 -> n00000007:port0 [style=dashed]
+	n0000003c:port1 -> n00000001:port0
+	n00000054 [label="{{} | imx219 6-0010\n/dev/v4l-subdev7 | {<port0> 0}}", shape=Mrecord, style=filled, fillcolor=green]
+	n00000054:port0 -> n0000003c:port0 [style=bold]
+}
diff --git a/Documentation/admin-guide/media/v4l-drivers.rst b/Documentation/admin-guide/media/v4l-drivers.rst
index 90a026ee05c6..186f8b0a082d 100644
--- a/Documentation/admin-guide/media/v4l-drivers.rst
+++ b/Documentation/admin-guide/media/v4l-drivers.rst
@@ -30,6 +30,7 @@ Video4Linux (V4L) driver-specific documentation
 	si470x
 	si4713
 	si476x
+	starfive
 	vimc
 	visl
 	vivid
-- 
2.34.1

