Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C1174BEBB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 20:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjGHS3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 14:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGHS3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 14:29:45 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BE9D2;
        Sat,  8 Jul 2023 11:29:44 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31297125334so2465983f8f.0;
        Sat, 08 Jul 2023 11:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688840983; x=1691432983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2nWPM4jwPafYGbRkd318KIxOMWqBhLm3R65ukPzT5Hw=;
        b=Eo+Ve0tiHadMyHDD4YevTQOQH7jWzOxi9XRPXgvke/Z4nauF7ijUaEBi86hGQl1XeI
         v/DReW2ssHDGOaL78gYoJwUkr+JrfAyCGMEIyZ9iV2OOaGFTxcsiHR2/n2LUpIyVU70h
         oEm2qI6A+t1pfxzOJBQx0x0JBQjis34S6KFKialnq17k8ZAoX4/xCIPJfd/V6uNtcUr2
         SwqD9LqMph/nDcn1lYu7Ksw46/xs55Sz+KcUILIIh4SawmW/BxIVfxfpTpR5z2gI4bPL
         6W3Fxz8xe3RtAXl/X/rW3fmFFswhtmiYF2GRediYYo3FA98sh/GGx5oB0CGJmayEPwte
         Pvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688840983; x=1691432983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2nWPM4jwPafYGbRkd318KIxOMWqBhLm3R65ukPzT5Hw=;
        b=BgUME7KrvC4WbXxpjgMmSVpDLxW+S9FKwZ9aFDT0ltR44W6G67HoHMstpeZeySoNuv
         kn02Bipdg4oXZgBhj+8duHI9BLfc8PUhH121J4zDYuxhFK+MgOzp9W8Zavd6kWyDKx27
         Csp0VfLiowEu08zZVBz961pJ9oN6nMjWNMeZDlgo4wSMWNCM1EsuxnsbnhW0x2pvUQEq
         zc8F7QCUZKsNLrX/Lm70bbNHxRn9W/FN2AKdv/YwIGmrR5A+7UBRH5QMF4v3zsmThKP7
         zX/OFBtiVgArj29rX8iveQIFyOvTnH+slqH+WOL2eXtl2ys+aR1pIa0ztRFs2alA+moC
         Fw8A==
X-Gm-Message-State: ABy/qLbHNYj2tKZsyWZX/D2MW+2h8PC4G8Fkb8cpM5yQyZvVpoqxmV0W
        eCJ5yYqcu8GEdeGOs8aVHa8ly7p/atE=
X-Google-Smtp-Source: APBJJlHEs+Abh2p4LsTa9DS8Xo9WLU3gZZVMEj49tQExaGWJKA40ooL/IXqMn0LcwfERBDMYoUmscw==
X-Received: by 2002:a5d:420d:0:b0:314:3f1:cebf with SMTP id n13-20020a5d420d000000b0031403f1cebfmr11449963wrq.28.1688840982706;
        Sat, 08 Jul 2023 11:29:42 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id h9-20020adfe989000000b0030647449730sm7492067wrm.74.2023.07.08.11.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 11:29:42 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 1/2] wifi: mt76: split get_of_eeprom in subfunction
Date:   Sat,  8 Jul 2023 20:29:35 +0200
Message-Id: <20230708182936.24469-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for NVMEM support, split get_of_eeprom() in subfunction
to tidy the code and facilitate the addition of alternative method to
get eeprom data. No behaviour change intended.

While at it also drop OF ifdef checks as OF have stubs and calling
of_get_property would result in the same error returned.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 51 ++++++++++++++-------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index dce851d42e08..c3a762074be8 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -9,31 +9,35 @@
 #include <linux/etherdevice.h>
 #include "mt76.h"
 
-int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
+static int mt76_get_of_eeprom_data(struct mt76_dev *dev, void *eep, int len)
 {
-#if defined(CONFIG_OF) && defined(CONFIG_MTD)
 	struct device_node *np = dev->dev->of_node;
-	struct mtd_info *mtd;
-	const __be32 *list;
 	const void *data;
-	const char *part;
-	phandle phandle;
 	int size;
-	size_t retlen;
-	int ret;
 
-	if (!np)
+	data = of_get_property(np, "mediatek,eeprom-data", &size);
+	if (!data)
 		return -ENOENT;
 
-	data = of_get_property(np, "mediatek,eeprom-data", &size);
-	if (data) {
-		if (size > len)
-			return -EINVAL;
+	if (size > len)
+		return -EINVAL;
 
-		memcpy(eep, data, size);
+	memcpy(eep, data, size);
 
-		return 0;
-	}
+	return 0;
+}
+
+static int mt76_get_of_epprom_from_mtd(struct mt76_dev *dev, void *eep, int offset, int len)
+{
+#ifdef CONFIG_MTD
+	struct device_node *np = dev->dev->of_node;
+	struct mtd_info *mtd;
+	const __be32 *list;
+	const char *part;
+	phandle phandle;
+	size_t retlen;
+	int size;
+	int ret;
 
 	list = of_get_property(np, "mediatek,mtd-eeprom", &size);
 	if (!list)
@@ -100,6 +104,21 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
 	return -ENOENT;
 #endif
 }
+
+int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
+{
+	struct device_node *np = dev->dev->of_node;
+	int ret;
+
+	if (!np)
+		return -ENOENT;
+
+	ret = mt76_get_of_eeprom_data(dev, eep, len);
+	if (!ret)
+		return 0;
+
+	return mt76_get_of_epprom_from_mtd(dev, eep, offset, len);
+}
 EXPORT_SYMBOL_GPL(mt76_get_of_eeprom);
 
 void
-- 
2.40.1

