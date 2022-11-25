Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565E263835B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 06:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiKYFIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 00:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKYFIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 00:08:18 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB74F27B0F;
        Thu, 24 Nov 2022 21:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669352894; x=1700888894;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+Iru+rPzbuM4DVegAhL9qv+EEr9L1O1AHIlf4byW/4Y=;
  b=h0DfmCC7CBjdy9PRidL3RwGO0t4MR5hYrEcK48UOg3JbcDsXVAQ+LI2p
   iUqhp/pOmGFboZWuCo6lmnkADUf99PawnhRDXo7fQuwwSCQHv/t84Une3
   Z4UWWXpKnSq/jVdOkrdKQXrTxII7TF0ZqaZNmuYUDo52BqzBesODo1bql
   VE6sR/JjGcUMqGhf3kyTEo2mp5sbgY65qQYHv6dBeFbJqPOY1A1FOADXR
   fxBzdO0ZP5SMKTIZexeYJI6e5HiK2gmhjX3RElyCm7XM6PLm+kZYGQQyv
   bc+FyjfA7Hn5AHE33rzwjzEvai4Il0v6fAnSLLg9IzVih773PV6kndIGO
   g==;
X-IronPort-AV: E=Sophos;i="5.96,192,1665471600"; 
   d="scan'208";a="188604123"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Nov 2022 22:08:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 24 Nov 2022 22:08:12 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 24 Nov 2022 22:08:09 -0700
From:   shravan kumar <shravan.chippa@microchip.com>
To:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Shravan Chippa" <shravan.chippa@microchip.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH v5 0/6] media: i2c: imx334: support lower bandwidth mode
Date:   Fri, 25 Nov 2022 10:38:01 +0530
Message-ID: <20221125050807.1857479-1-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Sorry for taking dealy to send updated the series
as i need to check the impact of my patch on 3840x2160@60 resolutions

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
- Modified supported_modes[] to get higher resolution first

Shravan Chippa (6):
  dt-bindings: imx334: modify link frequency in examples
  media: i2c: imx334: modify link frequency as for the configureation
  media: i2c: imx334: hblank set function modify
  media: i2c: imx334: add default values in 3840x2160@60 array
  media: i2c: imx334: support lower bandwidth mode
  media: i2c: imx334: updating pixel and link frequency

 .../bindings/media/i2c/sony,imx334.yaml       |   2 +-
 drivers/media/i2c/imx334.c                    | 338 ++++++++++++++++--
 2 files changed, 311 insertions(+), 29 deletions(-)

-- 
2.34.1

