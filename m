Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55876650777
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiLSGPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiLSGPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:15:37 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155E7AE53;
        Sun, 18 Dec 2022 22:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671430536; x=1702966536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=97m/dDy4gUxTGV0oPsWMYrepMwx9K5cDv4BzNhP8KWE=;
  b=vdDJ/vKyfS0uqtocE9q3Lma2ajFuUrx0x+GuLcQ0UOI4oTaQD5SGWOK6
   Wh8vVBDFnZ+bffv6lVvWoANklBTPTmTeltbgS7l+OfrakDGUuYULfDdOh
   l9ax9+OIt5Vqc8rDCtq3eau55hI13JKo+riqYiWAv3qxKaojJmRwJoKN/
   Hftjq5/bKPhw/R2AtbjnQlUW+afSRZVUuH3hiT3BXB8APWW7ISNRN2qN9
   pXatrYXIAHLhxktNRE5+sgLEcvlG4UBKe+vuA+L6MQ5HobTEet4Z6+bha
   xWinhk7c1TqLfgk45ET8XE+N06yJJ4Be47j89uWMDDtXuajfAuSLcVIc5
   g==;
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="204558703"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Dec 2022 23:15:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 18 Dec 2022 23:15:36 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Sun, 18 Dec 2022 23:15:33 -0700
From:   shravan kumar <shravan.chippa@microchip.com>
To:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "shravan kumar" <shravan.chippa@microchip.com>
Subject: [PATCH v7 1/5] media: i2c: imx334: modify link frequency as for the configureation
Date:   Mon, 19 Dec 2022 11:45:22 +0530
Message-ID: <20221219061526.3169369-2-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219061526.3169369-1-shravan.chippa@microchip.com>
References: <20221219061526.3169369-1-shravan.chippa@microchip.com>
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

Currently imx334 sensor driver is configured for 1782Mbps/lane for
3840x2160@60 resolution with reqired reg mode values but if we run the
command "v4l2-ctl --all -d /dev/v4l-subdevX" it is showing incorrect link
frequeny, This is because of the incorrect value of IMX334_LINK_FREQ
witch is 891000000. it should be 1782000000.

In general with the value of 891000000 link frequency it is not possible
to configure 3840x2160@60 resolution.

Fixes: 9746b11715c3 ("media: i2c: Add imx334 camera sensor driver")

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

