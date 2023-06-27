Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC45A73FC8C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjF0NLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjF0NKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:10:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237C22944
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:10:48 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fa94ea1caaso20927665e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687871446; x=1690463446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSkTgto1wciA1QYvDz647UHGhIjKbn+WM2qFsAraruk=;
        b=BTpWm3D1SaQQcdSvu2iOaahwBhBctUEN8x9rY85tzMeWAWXxskesDYzv8KCk9i9uST
         VE0qMoz0++TWErwZhYq/u/z/tPhLA2uO3a4VRVbQtSgJhsB4j19gF97M0ruDt0/JGDWt
         FT8ODTj74ExKhT3uRHHnBrCkuE8HpOUyhOSC6KrKafWWLrQwO8+6J/TevLJoiYQPyNdq
         3vEtSlgwU2vEX+kxgym7U3TGrFYYgTZ0J3bpcHacMV0YijKnnRINVfod5XqvDz/k3kHk
         taIylnmMwuD+w10Jh2YdKSkW/LXk5Q/snuEtddA4TYa7ZflllOzt8GXga7lLIJvOJl0s
         ifBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687871446; x=1690463446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSkTgto1wciA1QYvDz647UHGhIjKbn+WM2qFsAraruk=;
        b=LYHK3tzkzjZE/p/zWOW33Ac3nF1xwd2YwBnkHZc0/U4iW8rf1KHcI7E/g/psDFqGZE
         ld8qo3n74LV5gN2P+Q/aHf63pybeXEJWY4ztaK/Hswc5ukbBqjd9hoAwTRF8LNs4ZsNk
         BYmPSEO2u9SUDbyDX/aeOO652QbGrfjKt31oniIx+43bwf3HVdVJQ3KdwG3aLNH7w9lm
         XS1yaMPn+HUGOwD0U/bBcNY1lzy0SyxcQrfrAEht8mPvNDktFtOIA2zr8ndSXviDYV75
         VY9Df3lMRLmCZZU60N24XqrEox6KDuMKM/l0GSCzi/79TmelSte5wNoRe4Udr+Y93vPg
         ouqA==
X-Gm-Message-State: AC+VfDwoQoDNrHF1nWHjWGUdXlQFy4nGNcAkgKHbzDcG9inqrSA3mISw
        TLQ4v1NOJVpIOy6lq99ATqXLZA==
X-Google-Smtp-Source: ACHHUZ6fQycTk0SMqrlX/g/EWykJ0ecRAPan75Qdn3STp9ALJwnanPdnHYOcsHt1O+S6tmoxm3ld7A==
X-Received: by 2002:a05:600c:216:b0:3fa:aeac:e978 with SMTP id 22-20020a05600c021600b003faaeace978mr4656036wmi.0.1687871446461;
        Tue, 27 Jun 2023 06:10:46 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id z26-20020a1c4c1a000000b003f91e32b1ebsm1403196wmf.17.2023.06.27.06.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 06:10:46 -0700 (PDT)
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
Subject: [PATCH v6 2/8] soc: mediatek: pm-domains: Move bools to a flags field
Date:   Tue, 27 Jun 2023 15:10:34 +0200
Message-Id: <20230627131040.3418538-3-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627131040.3418538-1-msp@baylibre.com>
References: <20230627131040.3418538-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify the macros, use a flags field for simple bools. This is in
preparation for more flags.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/soc/mediatek/mtk-pm-domains.c |  6 +++---
 drivers/soc/mediatek/mtk-pm-domains.h | 19 +++++++++++--------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 354249cc1b12..aa9ab413479e 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -128,7 +128,7 @@ static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, st
 		if (!mask)
 			break;
 
-		if (bpd[i].bus_prot_reg_update)
+		if (bpd[i].flags & BUS_PROT_REG_UPDATE)
 			regmap_set_bits(regmap, bpd[i].bus_prot_set, mask);
 		else
 			regmap_write(regmap, bpd[i].bus_prot_set, mask);
@@ -165,12 +165,12 @@ static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
 		if (!mask)
 			continue;
 
-		if (bpd[i].bus_prot_reg_update)
+		if (bpd[i].flags & BUS_PROT_REG_UPDATE)
 			regmap_clear_bits(regmap, bpd[i].bus_prot_clr, mask);
 		else
 			regmap_write(regmap, bpd[i].bus_prot_clr, mask);
 
-		if (bpd[i].ignore_clr_ack)
+		if (bpd[i].flags & BUS_PROT_IGNORE_CLR_ACK)
 			continue;
 
 		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index 5ec53ee073c4..d8c0c299dd45 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -42,23 +42,27 @@
 
 #define SPM_MAX_BUS_PROT_DATA		6
 
-#define _BUS_PROT(_mask, _set, _clr, _sta, _update, _ignore) {	\
+enum scpsys_bus_prot_flags {
+	BUS_PROT_REG_UPDATE = BIT(1),
+	BUS_PROT_IGNORE_CLR_ACK = BIT(2),
+};
+
+#define _BUS_PROT(_mask, _set, _clr, _sta, _flags) {		\
 		.bus_prot_mask = (_mask),			\
 		.bus_prot_set = _set,				\
 		.bus_prot_clr = _clr,				\
 		.bus_prot_sta = _sta,				\
-		.bus_prot_reg_update = _update,			\
-		.ignore_clr_ack = _ignore,			\
+		.flags = _flags					\
 	}
 
 #define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
-		_BUS_PROT(_mask, _set, _clr, _sta, false, false)
+		_BUS_PROT(_mask, _set, _clr, _sta, 0)
 
 #define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
-		_BUS_PROT(_mask, _set, _clr, _sta, false, true)
+		_BUS_PROT(_mask, _set, _clr, _sta, BUS_PROT_IGNORE_CLR_ACK)
 
 #define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
-		_BUS_PROT(_mask, _set, _clr, _sta, true, false)
+		_BUS_PROT(_mask, _set, _clr, _sta, BUS_PROT_REG_UPDATE)
 
 #define BUS_PROT_UPDATE_TOPAXI(_mask)				\
 		BUS_PROT_UPDATE(_mask,				\
@@ -71,8 +75,7 @@ struct scpsys_bus_prot_data {
 	u32 bus_prot_set;
 	u32 bus_prot_clr;
 	u32 bus_prot_sta;
-	bool bus_prot_reg_update;
-	bool ignore_clr_ack;
+	u8 flags;
 };
 
 /**
-- 
2.40.1

