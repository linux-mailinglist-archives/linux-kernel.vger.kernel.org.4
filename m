Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7A268E750
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 06:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjBHFJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 00:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjBHFJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 00:09:28 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB581F4A9;
        Tue,  7 Feb 2023 21:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675832966; x=1707368966;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pp00KZGBDdw9ixDnmEBi+um8p4jUsSLszCBdrQrQV2A=;
  b=nET2KW76K6hb+vxI/2TJct091YqtK984ssFgdE15DmbkXaTYmOB0UtWt
   Ql30CQVBlkZsPK+/XFc6magsGi5OmIwPhLiMR4P/lyivroFZC82JvmKSU
   hsIoOQwKlFcdN+8TkOH92fkVUUdo9OZ5YOtw/nrOtsNvWk9pLE14UVwzO
   gaZjqK6vP9jkMbd1CDkNAhg7S+pqY3/ryNM9b6dWvT7narjT63GJltil0
   H4uYVFpEBjc94bxsz9+kfBdBZqUkx1jJgAhhVGVpoScLT6oXqOOYPR3MK
   H/Yuw0s/MoSUXASFJYo/vN/CyA6qyMBGDiLlK3FDxKfdRg8QeHDnXcqgl
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,280,1669100400"; 
   d="scan'208";a="136078366"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Feb 2023 22:09:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 22:09:24 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 22:09:19 -0700
From:   shravan kumar <shravan.chippa@microchip.com>
To:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>
CC:     <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <shravan.chippa@microchip.com>, Jacopo Mondi <jacopo@jmondi.org>,
        "Sakari Ailus" <sakari.ailus@iki.fi>
Subject: [PATCH v11 0/5] media: i2c: imx334: support lower bandwidth mode
Date:   Wed, 8 Feb 2023 10:39:10 +0530
Message-ID: <20230208050915.1958183-1-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shravan Chippa <shravan.chippa@microchip.com>

Hi

This patch series is for imx334 sensor driver support for lower bandwidth

Some platforms may not be capable of supporting the bandwidth
required for 12 bit or 3840x2160@60 resolutions.

Add support for dynamically selecting 10 bit and 1920x1080@30
resolutions while leaving the existing configuration as default

V10 -> V11
Changed veriable type int to unsigned int
Updated CC list

V10 -> V10
PATCH RESEND with updated CC list

V9 -> V10
Added new dt-binding patch
added support for handling multiple link-frequncy
minor changes on coding style

V8 -> V9
-Updated all array values with samall later to get unifamity
in mode array values
-corrected hblank_min, hbalank, pix_clk for 1920x1080@30 updated 
according to link frequency
-corrected mutex use for imx334_get_format_code function 
-corrected the fmt->format.code value assinment
-in function imx334_get_format_code variable "i" value comparision
corrected

V7 -> V8
-patch drop "mimx334-odify-link-frequency" as per the commnets
linkfrquncy will be half of the line bandwidth

-changed 1920x1080@30 mode link frequency from (891000000Mbps) 
to (445500000Mbps). linkfrquncy will be half of the line bandwidth

V6 -> V7
Reloved: kernel test robot warning
"drivers/media/i2c/imx334.c:767:15: warning: unused variable 'i' "

V5 -> V6
-Drop the dt-binding patch
-Optimize the code to avoid duplicating the lines
-Added proper mutex while imx334_mbus_codes array
-Modified Function __v4l2_ctrl_modify_range arguments as per the review
commants
-Added hblank dummy set ctrl
-Removed Redundant comment
-corrected code alignment 
-All commit msgs are re-written

V4 -> V5
-Added 5 more patchs as per the review comments witch has below updates
-Updated 1782000000Mbps link frequency for 3840x2160@60 as per the mode
values
-Updated 1782000000Mbps link frequency in dt-bindings also
-Updated 3840x2160@60 mode array with default(reset) values

-Updated hblank __v4l2_ctrl_s_ctrl() to __v4l2_ctrl_modify_range()
Suggested-by: Jacopo Mondi <jacopo@jmondi.org>

-Current mode update only when we try to set V4L2_SUBDEV_FORMAT_ACTIVE
-Added link frequency (891000000Mbps) and pixel rate (74250000) to
1920x1080@30 mode
Suggested-by: Sakari Ailus <sakari.ailus@iki.fi>

-Updated commit message

V3 -> V4
- Make the 12 bit and 3840x2160 as default
- Set bus code SRGGB12 if set format fails

V2 -> V3
- Fixed the warning reported by kernel test robot

V1 -> V2
- Addressed the review comment given by Jacopo Mondi,
  Which has bug in imx334_enum_frame_size() loop function,
- Renamed array codes[] to imx334_mbus_codes[]

Shravan Chippa (5):
  media: i2c: imx334: replace __v4l2_ctrl_s_ctrl to
    __v4l2_ctrl_modify_range
  media: i2c: imx334: add missing reset values for mode 3840x2160_regs[]
  media: i2c: imx334: support lower bandwidth mode
  dt-bindings: media: i2c: imx334 add new link_freq
  media: i2c: imx334: update pixel and link frequency

 .../bindings/media/i2c/sony,imx334.yaml       |   2 +-
 drivers/media/i2c/imx334.c                    | 361 ++++++++++++++++--
 2 files changed, 324 insertions(+), 39 deletions(-)

-- 
2.34.1

