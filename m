Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B5673FC8E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjF0NLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjF0NK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:10:58 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB5E273C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:10:56 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso13087295e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687871455; x=1690463455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VMYcJx4syxwuFnZnbvKqO4Q62miCTx6QaRJP3Gp1m0=;
        b=DkXvGerQqSJxq9hbTx255R7KYi1farydUF4KzdZLz+7XiUuFgA4VuyDKgkTHlfgKyB
         H06qRKvdrKosv9/g70ARLzIYDchSVf/Kb05NnbRCkew85LKeUYH2JBa4huMXWSTY0orq
         G/TYTCDY5olZAjKlpdPGEiIQaCXp9vpsP+IpSt8nNx2opTvE5fOKZoKVG85A9xSCinHh
         zh1jN++fnGanSWwOn7CXDXM8oG5i4CGHdcWsQENSFvXO6VPPEIB84u0DHIozQrn53309
         nIg3qHNFWICHnLBK/XGZ5SYojhgNFBn8xc4xS6PL2D9QmeOEt9oxj3wMojERxOMPqAwn
         jDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687871455; x=1690463455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VMYcJx4syxwuFnZnbvKqO4Q62miCTx6QaRJP3Gp1m0=;
        b=PKr4+yo0mS/t1Z6IQm2Iabw+8H1HGnT0b72yURGaO+b0RwxxfFi1S0fYCUce5CUFi0
         g5q4JkDK7UeRwgwqAmOnAHzl+QvH6MCP2EQbX2B0JQU9GN14CbGQAdhuEblYikxKLKDI
         vnH7UJpDyFuYQ2WJO4x6BGH0KvqPY+JGor4PK2pDL/7BVmdePgpigErNlMkADvWauuQC
         WGGGSJtQ2/9dS7Yj9vagCFUvWSLC0xtovJL/tvB6n9KrDhRfAZNk3c3/r3yg4BDjbdUV
         y5WVcaKjUoQtCvAtWy2QFYRYXm7ohIrqJ5+xuzDHybQ1Bv6RsiNwff6B24IKMwa/GR17
         9NHQ==
X-Gm-Message-State: AC+VfDzJsBN/YTA7JAR8/F1aSFmGVUE1CU/lMJ7cQvK4PDSh2l2nBSQ7
        w7L0SL3i3e4sbofHmv9dMfJgGw==
X-Google-Smtp-Source: ACHHUZ5CJTbhlRNA3EXBZZR0mnjEvmoQxX3ePmgt3zHDLAx0hHI+qnmBxM9mo36T2npYTgLVsegiKg==
X-Received: by 2002:a1c:ed10:0:b0:3f7:e660:cdc5 with SMTP id l16-20020a1ced10000000b003f7e660cdc5mr28420040wmh.9.1687871455142;
        Tue, 27 Jun 2023 06:10:55 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id z26-20020a1c4c1a000000b003f91e32b1ebsm1403196wmf.17.2023.06.27.06.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 06:10:54 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v6 4/8] soc: mediatek: pm-domains: Create bus protection operation functions
Date:   Tue, 27 Jun 2023 15:10:36 +0200
Message-Id: <20230627131040.3418538-5-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627131040.3418538-1-msp@baylibre.com>
References: <20230627131040.3418538-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the register access used for bus protection enable/disable into
their own functions. These will be used later for WAY_EN support.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/soc/mediatek/mtk-pm-domains.c | 68 +++++++++++++++------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index c801fa763e89..69dc24a73ce9 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -118,26 +118,50 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
 					MTK_POLL_TIMEOUT);
 }
 
+static int scpsys_bus_protect_clear(const struct scpsys_bus_prot_data *bpd,
+				    struct regmap *regmap)
+{
+	u32 val;
+	u32 sta_mask = bpd->bus_prot_sta_mask;
+
+	if (bpd->flags & BUS_PROT_REG_UPDATE)
+		regmap_clear_bits(regmap, bpd->bus_prot_clr, bpd->bus_prot_set_clr_mask);
+	else
+		regmap_write(regmap, bpd->bus_prot_clr, bpd->bus_prot_set_clr_mask);
+
+	if (bpd->flags & BUS_PROT_IGNORE_CLR_ACK)
+		return 0;
+
+	return regmap_read_poll_timeout(regmap, bpd->bus_prot_sta,
+					val, !(val & sta_mask),
+					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+}
+
+static int scpsys_bus_protect_set(const struct scpsys_bus_prot_data *bpd,
+				  struct regmap *regmap)
+{
+	u32 val;
+	u32 sta_mask = bpd->bus_prot_sta_mask;
+
+	if (bpd->flags & BUS_PROT_REG_UPDATE)
+		regmap_set_bits(regmap, bpd->bus_prot_set, bpd->bus_prot_set_clr_mask);
+	else
+		regmap_write(regmap, bpd->bus_prot_set, bpd->bus_prot_set_clr_mask);
+
+	return regmap_read_poll_timeout(regmap, bpd->bus_prot_sta,
+					val, (val & sta_mask) == sta_mask,
+					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+}
+
 static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, struct regmap *regmap)
 {
 	int i, ret;
 
 	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
-		u32 val;
-		u32 set_clr_mask = bpd[i].bus_prot_set_clr_mask;
-		u32 sta_mask = bpd[i].bus_prot_sta_mask;
-
-		if (!set_clr_mask)
+		if (!bpd[i].bus_prot_set_clr_mask)
 			break;
 
-		if (bpd[i].flags & BUS_PROT_REG_UPDATE)
-			regmap_set_bits(regmap, bpd[i].bus_prot_set, set_clr_mask);
-		else
-			regmap_write(regmap, bpd[i].bus_prot_set, set_clr_mask);
-
-		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
-					       val, (val & sta_mask) == sta_mask,
-					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+		ret = scpsys_bus_protect_set(&bpd[i], regmap);
 		if (ret)
 			return ret;
 	}
@@ -162,24 +186,10 @@ static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
 	int i, ret;
 
 	for (i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
-		u32 val;
-		u32 set_clr_mask = bpd[i].bus_prot_set_clr_mask;
-		u32 sta_mask = bpd[i].bus_prot_sta_mask;
-
-		if (!set_clr_mask)
-			continue;
-
-		if (bpd[i].flags & BUS_PROT_REG_UPDATE)
-			regmap_clear_bits(regmap, bpd[i].bus_prot_clr, set_clr_mask);
-		else
-			regmap_write(regmap, bpd[i].bus_prot_clr, set_clr_mask);
-
-		if (bpd[i].flags & BUS_PROT_IGNORE_CLR_ACK)
+		if (!bpd[i].bus_prot_set_clr_mask)
 			continue;
 
-		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
-					       val, !(val & sta_mask),
-					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+		ret = scpsys_bus_protect_clear(&bpd[i], regmap);
 		if (ret)
 			return ret;
 	}
-- 
2.40.1

