Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86B7680D09
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbjA3MJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbjA3MIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:08:39 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF45144BB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675080502; x=1706616502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rU46NQL4hbbHQR9L/65OOymuaCyWdxogbhBIy2BOVDA=;
  b=y/hWzs5rMZn4+IrioSraFV5eIIYWvjtL4lEnHYRnoTIqvaN3ArCok0Qo
   m/DtO+H53EcitMw7+qaNRXkdVjap/MX+bCgkMQlp73QwpuDkPHhnKPJAu
   /lQQc4IGaF73kF7+ih1Dz550vp9fLUQYxj1yxSXnOwIYbe/Vcu5sHT7um
   di1FFaKIp6QAWnY8n18ZQiHhHYkW+rbE1UgXIWZh5A1YLYX6HFq1fHqWh
   +t8cvnTEu6Y0aFq5h6VrG/KK39Z7vxMfYIXh9AhnEdmGpZZIwvsPNbBb5
   P199oYv7rMteoBXl8k9VSSYmWDp8TjroUBJVDMtNMLvloiWpE9xqGApf4
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,257,1669100400"; 
   d="scan'208";a="197975239"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jan 2023 05:07:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 05:07:28 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 05:07:24 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/8] ASoC: mchp-spdifrx: fix return value in case completion times out
Date:   Mon, 30 Jan 2023 14:06:41 +0200
Message-ID: <20230130120647.638049-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230130120647.638049-1-claudiu.beznea@microchip.com>
References: <20230130120647.638049-1-claudiu.beznea@microchip.com>
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

wait_for_completion_interruptible_timeout() returns 0 in case of
timeout. Check this into account when returning from function.

Fixes: ef265c55c1ac ("ASoC: mchp-spdifrx: add driver for SPDIF RX")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-spdifrx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/mchp-spdifrx.c b/sound/soc/atmel/mchp-spdifrx.c
index 2d86e0ec930f..7f359371b31b 100644
--- a/sound/soc/atmel/mchp-spdifrx.c
+++ b/sound/soc/atmel/mchp-spdifrx.c
@@ -524,9 +524,10 @@ static int mchp_spdifrx_cs_get(struct mchp_spdifrx_dev *dev,
 	ret = wait_for_completion_interruptible_timeout(&ch_stat->done,
 							msecs_to_jiffies(100));
 	/* IP might not be started or valid stream might not be present */
-	if (ret < 0) {
+	if (ret <= 0) {
 		dev_dbg(dev->dev, "channel status for channel %d timeout\n",
 			channel);
+		return ret ? : -ETIMEDOUT;
 	}
 
 	memcpy(uvalue->value.iec958.status, ch_stat->data,
@@ -580,7 +581,7 @@ static int mchp_spdifrx_subcode_ch_get(struct mchp_spdifrx_dev *dev,
 		dev_dbg(dev->dev, "user data for channel %d timeout\n",
 			channel);
 		mchp_spdifrx_isr_blockend_dis(dev);
-		return ret;
+		return ret ? : -ETIMEDOUT;
 	}
 
 	spin_lock_irqsave(&user_data->lock, flags);
-- 
2.34.1

