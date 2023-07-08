Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD42B74BEBD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 20:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjGHS3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 14:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHS3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 14:29:46 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4A7130;
        Sat,  8 Jul 2023 11:29:45 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbf1b82de7so24520085e9.1;
        Sat, 08 Jul 2023 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688840984; x=1691432984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRlinllzuoLno5ix8NJN30aYnS4fPlc7sOxq/5PjHIk=;
        b=qu+RlsIaWJd8WTxko1JbxVTi2ZRF7I15gRBdEyTNLfm4+1YU0LEOFxXJKCmCZx4YPc
         Ki0bBjXQwBl8NaKHddnzIJI2Mij6+V+yE6uvl6l1XmSAVrYvC5sG2VjQhUsxakdvkBK1
         39b+6bIJw2iuskMXwiLzm3PLKfI3LYPiUsDt6HAPSpYnSJFCkclV3zcMU3s9mg/IG6GL
         +VOY8OuxYuucrplErZc5fXwHGZfhcmqkV2B0eq3xGJdAzmYeMET5T7QEAWtN9BX7oCFu
         M7ddlT44sT/CngI3SzNKFmrKkYG4nwEP1EQmoszDP3zkW5xtBfsGc0PlKdfD39LKBaFF
         Twdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688840984; x=1691432984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRlinllzuoLno5ix8NJN30aYnS4fPlc7sOxq/5PjHIk=;
        b=UasoNzYV1rodkMyaYsjG5AKfh2Piw2CiiCItl1WJHuLhyywIolWaXX7EfY56rLafOB
         Yr6MpXyODldynA6U1FA0vjL+0wFVcOcbI1Uz4E0UF2GYUBYgWZa6rkNvTO1Xrc3l66I3
         SHGak6HRyBKgO2l5U3MdhtGV9gxjnfdgH/KA+zlrkYWjy4POE51wJ/TqdVMXJGTollm2
         VFfnf/JMQKb2NRQgl4qEfqUHY9Z86V8QN/4aaL7m/43rvnhBXLtG/daO6ruBL6H7P1QB
         dKsXhA37M/377R0tssNcgmVRcszt85yYUC91wFO3uEKe00pEwWe4L8PcgqFoH6xAxhLr
         LbzA==
X-Gm-Message-State: ABy/qLYAYWO31Ty0sa7emuy4lcOfyvRRbYTB/8KWICwDix+4iPWNddY/
        olDQIYEAdN2y+9/9X3dpTRE=
X-Google-Smtp-Source: APBJJlHQCf5NSpNxS5BwssHQcf8A1hFtRUGQ9JeBaBFBFtD02S1IhjHLWTq+vacSUBIVP3j3aXcnkw==
X-Received: by 2002:a05:600c:2207:b0:3f7:e660:cdc5 with SMTP id z7-20020a05600c220700b003f7e660cdc5mr7583435wml.9.1688840983788;
        Sat, 08 Jul 2023 11:29:43 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id h9-20020adfe989000000b0030647449730sm7492067wrm.74.2023.07.08.11.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 11:29:43 -0700 (PDT)
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
Subject: [PATCH 2/2] wifi: mt76: add support for providing eeprom in nvmem cells
Date:   Sat,  8 Jul 2023 20:29:36 +0200
Message-Id: <20230708182936.24469-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230708182936.24469-1-ansuelsmth@gmail.com>
References: <20230708182936.24469-1-ansuelsmth@gmail.com>
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

Add support for providing eeprom in nvmem cells by adding nvmem cell as
an alternative source for mt76_get_of_eeprom().

Nvmem cells will follow standard nvmem cell definition and needs to be
called 'eeprom' to be correctly identified.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 38 ++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index c3a762074be8..36564930aef1 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -6,6 +6,7 @@
 #include <linux/of_net.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/etherdevice.h>
 #include "mt76.h"
 
@@ -105,6 +106,37 @@ static int mt76_get_of_epprom_from_mtd(struct mt76_dev *dev, void *eep, int offs
 #endif
 }
 
+static int mt76_get_of_epprom_from_nvmem(struct mt76_dev *dev, void *eep, int len)
+{
+	struct device_node *np = dev->dev->of_node;
+	struct nvmem_cell *cell;
+	const void *data;
+	size_t retlen;
+	int ret = 0;
+
+	cell = of_nvmem_cell_get(np, "eeprom");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	data = nvmem_cell_read(cell, &retlen);
+	nvmem_cell_put(cell);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	if (retlen < len) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	memcpy(eep, data, len);
+
+exit:
+	kfree(data);
+
+	return ret;
+}
+
 int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
 {
 	struct device_node *np = dev->dev->of_node;
@@ -117,7 +149,11 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
 	if (!ret)
 		return 0;
 
-	return mt76_get_of_epprom_from_mtd(dev, eep, offset, len);
+	ret = mt76_get_of_epprom_from_mtd(dev, eep, offset, len);
+	if (!ret)
+		return 0;
+
+	return mt76_get_of_epprom_from_nvmem(dev, eep, len);
 }
 EXPORT_SYMBOL_GPL(mt76_get_of_eeprom);
 
-- 
2.40.1

