Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D6963835E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 06:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiKYFIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 00:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKYFIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 00:08:37 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B621027CCD;
        Thu, 24 Nov 2022 21:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669352916; x=1700888916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+D0/Fxfae05FKfgOGGCgFaFjNNeek2oUT39t1A4j0HI=;
  b=CiRwem05DSaXKwDx07xWhVc7fugqYPHhOD1i44PGeFozKt3ddaXJEb0E
   uI29f8eDRqhPw9+tq7lG5TSu7iGqTavhlznECa9m5CnwUMXDDowRJeNRt
   /zr0DUxyDrbgSvDl0bBt6k5VxcxD1bOKNHcLsDjkTzQFdp+y+69/Q646W
   /EHQvlSUwd9G+cp+fcFnXZRpRBEMUxXDWYeqYDCQ9o3WM+LZEta0cprp9
   KH73kKgVPg2QTvcPqkkLXU/KMMLYXNX2wf4VcG8+G6CCOoa3gUYOibEuY
   69oCyhaWwf1SmOGFoDsv8J+ts/UuFR3OLRRUBt8P0sITW09kEE4XfUvde
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,192,1665471600"; 
   d="scan'208";a="188604155"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Nov 2022 22:08:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 24 Nov 2022 22:08:33 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 24 Nov 2022 22:08:31 -0700
From:   shravan kumar <shravan.chippa@microchip.com>
To:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Shravan Chippa" <shravan.chippa@microchip.com>
Subject: [PATCH v5 2/6] media: i2c: imx334: modify link frequency as for the configureation
Date:   Fri, 25 Nov 2022 10:38:03 +0530
Message-ID: <20221125050807.1857479-3-shravan.chippa@microchip.com>
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

-Imx334 camera is configured for 1782Mbps/lane for 3840x2160@60
resolution. but the imx334_parse_hw_config() function comparing with
IMX334_LINK_FREQ(891Mbpa/lane) link frequency
-The 3840x2160@60 mode values for 1782Mbps/lane
-Updated Macro IMX334_LINK_FREQ to 1782Mbps/lane
-The same value is populated in the userspce also

Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
---
 drivers/media/i2c/imx334.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
index 7b0a9086447d..acc9f9f15e47 100644
--- a/drivers/media/i2c/imx334.c
+++ b/drivers/media/i2c/imx334.c
@@ -49,7 +49,7 @@
 #define IMX334_INCLK_RATE	24000000
 
 /* CSI2 HW configuration */
-#define IMX334_LINK_FREQ	891000000
+#define IMX334_LINK_FREQ	1782000000
 #define IMX334_NUM_DATA_LANES	4
 
 #define IMX334_REG_MIN		0x00
-- 
2.34.1

