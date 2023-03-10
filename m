Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296F16B3EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCJMGL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Mar 2023 07:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjCJMGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:06:02 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA25F34D6;
        Fri, 10 Mar 2023 04:05:56 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 6827D24E2B9;
        Fri, 10 Mar 2023 20:05:55 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 10 Mar
 2023 20:05:55 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 10 Mar
 2023 20:05:54 +0800
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
Subject: [PATCH v2 0/6] Add Starfive Camera Subsystem driver
Date:   Fri, 10 Mar 2023 20:05:47 +0800
Message-ID: <20230310120553.60586-1-jack.zhu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
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

Hi,

This patch series adds support for the Starfive Camera Subsystem
found on Starfive JH7110 SoC.

The driver implements V4L2, Media controller and V4L2 subdev interfaces.
Camera sensor using V4L2 subdev interface in the kernel is supported.

The driver is tested on VisionFive V2 board with IMX219 camera sensor.
GStreamer 1.18.5 with v4l2src plugin is supported.

Changes since v1:
- Deleted starfive,jh7110-mipi-csi2.yaml.
- Converted cdns,csi2rx.txt to cdns,csi2rx.yaml and added ‘resets’
  properties.
- Added ‘cdns,csi2rx.yaml’ in ‘CADENCE MIPI-CSI2 BRIDGES’ entry.
- The following contents were modified in starfive,jh7110-camss.yaml:
  dropped quotes from ’id’ and ‘schema’; dropped ‘|’ for ‘description’;
  corrected the wrong or redundant words: ‘a ISP’, ‘PD ISP’;
  dropped ‘minItems’ for ‘reg’, ‘clocks’, ‘resets’ and ‘interrupts’;
  dropped the '_clk' and 'rst_' prefix about the 'clock-names' and
  'reset-names';
  changed ‘endpoint@1’ to ‘endpoint’; updated examples;
- Updated Subject for some patches.
- Merged patch 6, 7, 8, 9, 10, 11 into one patch.

Jack Zhu (6):
  media: dt-bindings: Add bindings for JH7110 Camera Subsystem
  media: dt-bindings: cadence-csi2rx: Convert to DT schema
  media: admin-guide: Add starfive_camss.rst for Starfive Camera
    Subsystem
  media: cadence: Add support for external dphy and JH7110 SoC
  MAINTAINERS: Add Starfive Camera Subsystem driver
  media: starfive: Add Starfive Camera Subsystem driver

 .../admin-guide/media/starfive_camss.rst      |   68 +
 .../media/starfive_camss_graph.dot            |   28 +
 .../admin-guide/media/v4l-drivers.rst         |    1 +
 .../devicetree/bindings/media/cdns,csi2rx.txt |  100 --
 .../bindings/media/cdns,csi2rx.yaml           |  163 ++
 .../bindings/media/starfive,jh7110-camss.yaml |  144 ++
 MAINTAINERS                                   |   10 +
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/cadence/cdns-csi2rx.c  |  273 +++-
 drivers/media/platform/starfive/Kconfig       |   18 +
 drivers/media/platform/starfive/Makefile      |   14 +
 drivers/media/platform/starfive/stf_camss.c   |  728 +++++++++
 drivers/media/platform/starfive/stf_camss.h   |  104 ++
 drivers/media/platform/starfive/stf_common.h  |  149 ++
 drivers/media/platform/starfive/stf_isp.c     | 1079 ++++++++++++++
 drivers/media/platform/starfive/stf_isp.h     |  183 +++
 .../media/platform/starfive/stf_isp_hw_ops.c  | 1286 ++++++++++++++++
 drivers/media/platform/starfive/stf_video.c   | 1286 ++++++++++++++++
 drivers/media/platform/starfive/stf_video.h   |   89 ++
 drivers/media/platform/starfive/stf_vin.c     | 1314 +++++++++++++++++
 drivers/media/platform/starfive/stf_vin.h     |  194 +++
 .../media/platform/starfive/stf_vin_hw_ops.c  |  357 +++++
 include/uapi/linux/stf_isp_ioctl.h            |  127 ++
 24 files changed, 7607 insertions(+), 110 deletions(-)
 create mode 100644 Documentation/admin-guide/media/starfive_camss.rst
 create mode 100644 Documentation/admin-guide/media/starfive_camss_graph.dot
 delete mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.txt
 create mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
 create mode 100644 Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
 create mode 100644 drivers/media/platform/starfive/Kconfig
 create mode 100644 drivers/media/platform/starfive/Makefile
 create mode 100644 drivers/media/platform/starfive/stf_camss.c
 create mode 100644 drivers/media/platform/starfive/stf_camss.h
 create mode 100644 drivers/media/platform/starfive/stf_common.h
 create mode 100644 drivers/media/platform/starfive/stf_isp.c
 create mode 100644 drivers/media/platform/starfive/stf_isp.h
 create mode 100644 drivers/media/platform/starfive/stf_isp_hw_ops.c
 create mode 100644 drivers/media/platform/starfive/stf_video.c
 create mode 100644 drivers/media/platform/starfive/stf_video.h
 create mode 100644 drivers/media/platform/starfive/stf_vin.c
 create mode 100644 drivers/media/platform/starfive/stf_vin.h
 create mode 100644 drivers/media/platform/starfive/stf_vin_hw_ops.c
 create mode 100644 include/uapi/linux/stf_isp_ioctl.h

-- 
2.34.1

