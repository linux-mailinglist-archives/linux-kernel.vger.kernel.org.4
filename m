Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AAD649F83
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiLLNKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiLLNKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:10:38 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638B812A87;
        Mon, 12 Dec 2022 05:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670850629; x=1702386629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5xjzRZVtRE1cVlsbZZS0eIcjhBI2JgzIzQmwqEVYM3I=;
  b=NMxaAt8Qqwq6R5oqByu6iaMzL7G40QmtIgChUJ+4SkhKrhPKvWBiizjL
   3szMJQCms1iBUtShqkkxOjMaD0pMtJ8Fv0w5a+pZ+SPDjeINBnoaQIlaW
   //6HHHOIH0+MgUJCJvvkTz2la9XByeCXrzMwiobCnrePFHEYDuTKtB2hT
   HINBD1nMshtSbiLTorxSo6TuqvU8G/DsLRCqLOm39SUt1J8kpsjcFHVTg
   yMiH38n1tohLGAIZzhq6X9tC+FRZGuf6Dx5gzG5BA+LNAvOU+8Akd3wMQ
   amk+N/Zvl5NlcFfAM3ffIPHE+A+2Sp73AEP9C4QTqMiIicltIOIlo+Pgm
   A==;
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="187716955"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Dec 2022 06:10:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 06:10:28 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 12 Dec 2022 06:10:25 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 4/4] ASoC: mchp-spdiftx: use FIELD_PREP() where possible
Date:   Mon, 12 Dec 2022 15:15:35 +0200
Message-ID: <20221212131535.76111-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221212131535.76111-1-claudiu.beznea@microchip.com>
References: <20221212131535.76111-1-claudiu.beznea@microchip.com>
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

Use FIELD_PREP() in macro definitions.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-spdiftx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/mchp-spdiftx.c b/sound/soc/atmel/mchp-spdiftx.c
index dc96a6fbf514..20d135c718b0 100644
--- a/sound/soc/atmel/mchp-spdiftx.c
+++ b/sound/soc/atmel/mchp-spdiftx.c
@@ -6,6 +6,7 @@
 //
 // Author: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -71,11 +72,11 @@
 
 /* Valid Bits per Sample */
 #define SPDIFTX_MR_VBPS_MASK		GENMASK(13, 8)
-#define SPDIFTX_MR_VBPS(bps)		(((bps) << 8) & SPDIFTX_MR_VBPS_MASK)
+#define SPDIFTX_MR_VBPS(bps)		FIELD_PREP(SPDIFTX_MR_VBPS_MASK, bps)
 
 /* Chunk Size */
 #define SPDIFTX_MR_CHUNK_MASK		GENMASK(19, 16)
-#define SPDIFTX_MR_CHUNK(size)		(((size) << 16) & SPDIFTX_MR_CHUNK_MASK)
+#define SPDIFTX_MR_CHUNK(size)		FIELD_PREP(SPDIFTX_MR_CHUNK_MASK, size)
 
 /* Validity Bits for Channels 1 and 2 */
 #define SPDIFTX_MR_VALID1			BIT(24)
@@ -88,8 +89,7 @@
 
 /* Bytes per Sample */
 #define SPDIFTX_MR_BPS_MASK		GENMASK(29, 28)
-#define SPDIFTX_MR_BPS(bytes) \
-	((((bytes) - 1) << 28) & SPDIFTX_MR_BPS_MASK)
+#define SPDIFTX_MR_BPS(bytes)		FIELD_PREP(SPDIFTX_MR_BPS_MASK, (bytes - 1))
 
 /*
  * ---- Interrupt Enable/Disable/Mask/Status Register (Write/Read-only) ----
-- 
2.34.1

