Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4845638363
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 06:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKYFJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 00:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiKYFI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 00:08:57 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648972A71F;
        Thu, 24 Nov 2022 21:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669352933; x=1700888933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l6s5Zo+bMjQdENg18YdbOTnMLlT3vOWv+B9rkhLd0QQ=;
  b=MWCO7a0SelLB4W0ySwbdbesEd6hYVd2kpD1vJcRLta3cnsLdAjT4n9Dd
   OeEOVvVDDZMyL9YKxSKWT+ONtLy0903hfGOd9dKVzMxgg6rViIN46Mwgd
   +ArpYNXspVNqxoYPP0FQBSfTbSnyUhVaBqz0iDs56obp4Ca7QJ0RbIUpT
   i1CygVS618mqUqFnpostD/EIZI4t9E/AOvqYi3F3mAygE1U7REM4xDRad
   2EALES/x9NKVqbU0qRmOo0pLYMbRVQXkaFWHaTUfdEfxfAdxVUubIJKkS
   JOMNQprkdYIqRN1zqGVjr3LDS9icTIbHjSRnUMgxa9cHfOzouVFQyun/o
   w==;
X-IronPort-AV: E=Sophos;i="5.96,192,1665471600"; 
   d="scan'208";a="185123055"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Nov 2022 22:08:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 24 Nov 2022 22:08:42 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 24 Nov 2022 22:08:40 -0700
From:   shravan kumar <shravan.chippa@microchip.com>
To:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Shravan Chippa" <shravan.chippa@microchip.com>
Subject: [PATCH v5 4/6] media: i2c: imx334: add default values in 3840x2160@60 array
Date:   Fri, 25 Nov 2022 10:38:05 +0530
Message-ID: <20221125050807.1857479-5-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221125050807.1857479-1-shravan.chippa@microchip.com>
References: <20221125050807.1857479-1-shravan.chippa@microchip.com>
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

-If we have only one mode there is no need to update camera
reset(default) values when we initialize the camera

-If we have mutipull modes in this case we need all value to
write while camera initializing, so i will not effect other modes
while shifting dynamically

-All default values for 3840x2160@60 updated becouse if we change
the mode we will not be able to recover the values, so add in
mode_3840x2160_regs[] array

Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
---
 drivers/media/i2c/imx334.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
index d3bb62c162b3..cd41df56ab7d 100644
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

