Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4537767636E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 04:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjAUDhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 22:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjAUDhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 22:37:46 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20C037B5C;
        Fri, 20 Jan 2023 19:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674272259; x=1705808259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+szvL+ndfqTkBWLkYZZHX8t/alFfcilUJhnbtl8bXGo=;
  b=eUFZwod3dhEGW/febsGX1cMu+JjHr0LuE95qZLyDP3HxM+drQpBY8hA/
   06NIs5A45Ud+CpaNlsrZpbHiMf1sNpGgoYJW4v/NhbL1j1UMnkp4wVBM8
   kX9cC1KNRcMsZYLY0CNsLiK4hqjulAyzJpClf1aAXHGxtTMpU5bFoCKrn
   RABimhCqvvBL9wBlcTfQMq5OFhdypi1aCWtChBYjOc9rZLyf0ftI8IdFA
   a4BK2xt1RbAV1jf293Fm+oYizslp4cMWJ3wF1EQojS4llwxQP3fsfTblm
   DFPgDO5pAtfJrZW2Zy9pn8UecsAMIj9SaUmmiqPb5wdDBQkiBBpUGxXJe
   A==;
X-IronPort-AV: E=Sophos;i="5.97,234,1669100400"; 
   d="scan'208";a="196788416"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2023 20:37:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 20:37:38 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Fri, 20 Jan 2023 20:37:32 -0700
From:   shravan kumar <shravan.chippa@microchip.com>
To:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>
CC:     <festevam@gmail.com>, <kernel@pengutronix.de>, <linux-imx@nxp.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <shravan.chippa@microchip.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Subject: [PATCH RESEND v10 2/5] media: i2c: imx334: add missing reset values for mode 3840x2160_regs[]
Date:   Sat, 21 Jan 2023 09:07:10 +0530
Message-ID: <20230121033713.3535351-3-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230121033713.3535351-1-shravan.chippa@microchip.com>
References: <20230121033713.3535351-1-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shravan Chippa <shravan.chippa@microchip.com>

There are some missing reset reg_mode values for the 3840x2160@60
resolution. The camera sensor still works in 3840x2160@60 resolution mode
because of the register reset values. This is an issue when we change the
modes dynamically. As an example, when we change the mode from 1920x1080@30
 resolution to 3840x2160@60 resoultion then the mode values will be written
to the registers from the array mode_3840x2160_regs[] which gives the wrong
output which is incorrect resolution.

So add the missing reset values to the mode_3840x2160_regs[].

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
---
 drivers/media/i2c/imx334.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
index ebacba3059b3..40ece08f20f5 100644
--- a/drivers/media/i2c/imx334.c
+++ b/drivers/media/i2c/imx334.c
@@ -166,6 +166,7 @@ static const struct imx334_reg mode_3840x2160_regs[] = {
 	{0x3288, 0x21},
 	{0x328a, 0x02},
 	{0x302c, 0x3c},
+	{0x302d, 0x00},
 	{0x302e, 0x00},
 	{0x302f, 0x0f},
 	{0x3076, 0x70},
@@ -240,7 +241,26 @@ static const struct imx334_reg mode_3840x2160_regs[] = {
 	{0x3794, 0x7a},
 	{0x3796, 0xa1},
 	{0x3e04, 0x0e},
+	{0x319e, 0x00},
 	{0x3a00, 0x01},
+	{0x3a18, 0xbf},
+	{0x3a19, 0x00},
+	{0x3a1a, 0x67},
+	{0x3a1b, 0x00},
+	{0x3a1c, 0x6f},
+	{0x3a1d, 0x00},
+	{0x3a1e, 0xd7},
+	{0x3a1f, 0x01},
+	{0x3a20, 0x6f},
+	{0x3a21, 0x00},
+	{0x3a22, 0xcf},
+	{0x3a23, 0x00},
+	{0x3a24, 0x6f},
+	{0x3a25, 0x00},
+	{0x3a26, 0xb7},
+	{0x3a27, 0x00},
+	{0x3a28, 0x5f},
+	{0x3a29, 0x00},
 };
 
 /* Supported sensor mode configurations */
-- 
2.34.1

