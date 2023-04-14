Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1316E23C2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjDNM5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDNM5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:57:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4D0AF3E;
        Fri, 14 Apr 2023 05:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681477035; x=1713013035;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g5QWjqlSCRm+8C4DR7BqUn/dNA+yyAAWSClT7bKJ/y8=;
  b=m9Zpyfpy8O7oZm/8D3WUYiNuWyn5kYlTOD9m0Pti7WjSVUFk70wEpXKv
   uThAFHCsyVrjOHH6oMBdL1+MJnCNfIG5pWlTt1DYRSNZGc8dYMxaszSpS
   1Z6WQZmLWtFoZua+fW4O/HFShMQwawNTgsBBllVpAAyK4ZXJ3wB+lgnpw
   2FvRexeSenP0nqDn4bgvPjGlDYP5gDhR4vYrTlKCXvJ5mKS8IcdbdOKwQ
   uA3jZtNUBt8be8sUYKz4/xIbQ/B0YP3Q8RJujF2gSzeiIFajTrsm7nvDv
   n40ACOJ7xqYlxAE8Ka1NYD1uL3oLhHEIGQd+v0+QrocgdrrFD6kkFth9h
   g==;
X-IronPort-AV: E=Sophos;i="5.99,195,1677567600"; 
   d="scan'208";a="209087503"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Apr 2023 05:57:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 14 Apr 2023 05:33:20 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 14 Apr 2023 05:33:15 -0700
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
Subject: [PATCH v13 0/1] media: i2c: imx334: support lower bandwidth mode
Date:   Fri, 14 Apr 2023 18:03:10 +0530
Message-ID: <20230414123311.23923-1-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
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
resolutions.

V12 -> V13
dropped 4 applied patches (ref link: https://git.linuxtv.org/mchehab/media-next.git/log/)

patch 5 changes:
compilation error removed
updated hblank value while changing the modes

V11 -> V12
Update default link frequency from device tree max link
frequency value.
Update init_cfg() function to update the link frequency
menu_skip_mask value.

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

Shravan Chippa (1):
  media: i2c: imx334: update pixel, hblank and link frequency

 drivers/media/i2c/imx334.c | 62 +++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 14 deletions(-)

-- 
2.34.1

