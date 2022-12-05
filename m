Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9375C642297
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 06:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiLEFUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 00:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiLEFTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 00:19:55 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7039FCD2;
        Sun,  4 Dec 2022 21:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670217595; x=1701753595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=97m/dDy4gUxTGV0oPsWMYrepMwx9K5cDv4BzNhP8KWE=;
  b=IAN5d1oEeRitONRjTADBrKCYfD3gqPHmOY9WunQo8a33/SiRsqQM7B7k
   Y4nggMk/gJvBL7cTkn7r7gVN3BG08qsEJDd5NevZ3OEDxTmb2w7t9ACwN
   rZh2/T7eYSnlC7nENMnt0n3JVq2rLF0yXzlpDsJk2OZlgun0qWb8GMZ2C
   ogvB6MNouqJ1dTziGdej0eML6GUQ9V6wYkN6Hb48OGvK5TvRCTqx0q+QB
   ctXuv67aiKmRba2/EPZv0ABU6IREmJXsxdIB+Xyon6TeJGJo92P9JZklM
   vSNpC2gNANV7hOpmWQV3+jxE21weddgux91IiK9KvntMew+UISoR3tmyu
   A==;
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="186499742"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Dec 2022 22:19:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sun, 4 Dec 2022 22:19:53 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Sun, 4 Dec 2022 22:19:51 -0700
From:   shravan kumar <shravan.chippa@microchip.com>
To:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Shravan Chippa" <shravan.chippa@microchip.com>
Subject: [PATCH v6 1/5] media: i2c: imx334: modify link frequency as for the configureation
Date:   Mon, 5 Dec 2022 10:49:32 +0530
Message-ID: <20221205051937.3897001-2-shravan.chippa@microchip.com>
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

