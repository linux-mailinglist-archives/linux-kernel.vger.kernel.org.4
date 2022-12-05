Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C46E64229B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 06:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiLEFUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 00:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiLEFUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 00:20:06 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB5D1007B;
        Sun,  4 Dec 2022 21:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670217603; x=1701753603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J+Pa5idsEsF21ZZmOnUuVtv+9iQnHLggG8V2rnsPm0I=;
  b=w67Osr9oZiXmIeHQrJEKVbRR/gzyLkB8vFvW7fVCLisyMc5HkLQPah4M
   +Y71yJHG3h58VQOLhXvkk211Uh1kYnbCgj8Tvf7oEYURwYxicyAx2wkOr
   htybtDdrx4m2lpKx839TdlHGXdJkTberC0+iHSkfYC2gXI04GUkXO4FOy
   /JCZb9Pf/b8pSDOHnnJpvMWTvfx/BTgFg8YOleK5gdnaBRESA3BwrBBkM
   W/dOWkaMGr9eJnwQOGrTZWstV4io2Ap4dwftp+7Zg7YIUto0U+x+QgJTg
   /JVPzrFcReooUAWAni+fbvX6dVcK/ZIA2E7XEMe2QsN22GHFNWSkQ0QRF
   A==;
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="186499749"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Dec 2022 22:20:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sun, 4 Dec 2022 22:20:02 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Sun, 4 Dec 2022 22:19:59 -0700
From:   shravan kumar <shravan.chippa@microchip.com>
To:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Shravan Chippa" <shravan.chippa@microchip.com>
Subject: [PATCH v6 3/5] media: i2c: imx334: add missing reset values for mode 3840x2160_regs[]
Date:   Mon, 5 Dec 2022 10:49:34 +0530
Message-ID: <20221205051937.3897001-4-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221205051937.3897001-1-shravan.chippa@microchip.com>
References: <20221205051937.3897001-1-shravan.chippa@microchip.com>
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

There are some missing reset reg_mode values for the 3840x2160@60
resolution. The camera sensor still works in 3840x2160@60 resolution mode
because of the register reset values. This is an issue when we change the
modes dynamically. As an example, when we change the mode from 1920x1080@30
 resolution to 3840x2160@60 resoultion then the mode values will be written
to the registers from the array mode_3840x2160_regs[] which gives the wrong
output which is incorrect resolution.

So add the missing reset values to the mode_3840x2160_regs[].

Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
---
 drivers/media/i2c/imx334.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
index a742b60ea3b0..1fa7e3711c3d 100644
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
+	{0x3A18, 0xBF},
+	{0x3A19, 0x00},
+	{0x3A1A, 0x67},
+	{0x3A1B, 0x00},
+	{0x3A1C, 0x6F},
+	{0x3A1D, 0x00},
+	{0x3A1E, 0xD7},
+	{0x3A1F, 0x01},
+	{0x3A20, 0x6F},
+	{0x3A21, 0x00},
+	{0x3A22, 0xCF},
+	{0x3A23, 0x00},
+	{0x3A24, 0x6F},
+	{0x3A25, 0x00},
+	{0x3A26, 0xB7},
+	{0x3A27, 0x00},
+	{0x3A28, 0x5F},
+	{0x3A29, 0x00},
 };
 
 /* Supported sensor mode configurations */
-- 
2.34.1

