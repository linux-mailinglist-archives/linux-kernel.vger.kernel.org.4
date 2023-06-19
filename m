Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612D1734ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjFSIz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjFSIy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:54:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C481ADA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:54:15 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-988aefaa44eso118676666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687164854; x=1689756854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fp2CY0ufDGcamwFQBbeDzmusiEpGslruFK5CPypDqWU=;
        b=dC9YSWU16Yyoc3srLfu6RqX/YnkDLDX6Y6E7496Ovko9QI/+rvX28OhG1C5YFs82Cn
         6XJ4Fyc8HAEXeo2npkE87P6YBbD5UCbQc4EYK0kj0Lvfx9ZKpZIreNCdMBQMDZlJAinM
         FTGLQL2Kt71uNdnJC0C4wS2XbGEC22Yzv7v0oleYS5CqDZ/N0f6W43kDC3lUnq9j4KRT
         dxTU3yfnyMW777IUK63YArbzpcD+9UfNFVLTPvJhcwGeWynFd7ZU2zJwGnNpgDHxH+Yn
         cAW3KdqW4LEgRawUXM3QPzRM5tBFU6aRsRImZiZm0fgwWEI0v6Zmpv+UoorRrSO+TbWw
         e8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687164854; x=1689756854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fp2CY0ufDGcamwFQBbeDzmusiEpGslruFK5CPypDqWU=;
        b=AiP3sd34Km9DKxKn0PCZUSSgtPuhqJa3L6dp0WvgrlFC/VTY/KKeYuQyjazMPsvG1w
         4mj+2LXxojGTOIbd7TFhPDAw7XzswL7Y9SdtEW6jZZUNsVvXuBcuFKO7KB9XiUxvDffU
         VCZH2DjXBFJAskN7+LdW0Qn7RUXcxeq2TlTiyWLpGmEkGNTwM25FOmSwfe1E3LUoH7SL
         VzsG+JmixHXPhBKLwoPdCVW9sj6sMv8hdiObDA0qF8j4ceuz/GWt2rbjlpF2SxAA6rDv
         u7n5YzL0Z9445qIWK7CtK3XEk2tqWDFERN1WxEyDnx8ctqG01wFewdehSVtkjnPGSKzW
         wuTg==
X-Gm-Message-State: AC+VfDz9zMBgcyBOhJ2V0IkHMUd3koJvgK4K0xFfCFhjYsK8xaa6LwqL
        Hv0eidknNAo5HDumJahhhkb/Ug==
X-Google-Smtp-Source: ACHHUZ5xugmtYuirqmRzIhzUWDWlP5X96hGOlG7cFBbVw5SzpqBBONkyAvcFrbpfnJZNknaMmZP9fw==
X-Received: by 2002:a17:906:9b88:b0:988:9641:fe38 with SMTP id dd8-20020a1709069b8800b009889641fe38mr2375669ejc.32.1687164854182;
        Mon, 19 Jun 2023 01:54:14 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a245:802c:bc2b:8db8:9210:41eb])
        by smtp.gmail.com with ESMTPSA id h27-20020a17090619db00b00987a6e01e94sm2994339ejd.214.2023.06.19.01.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 01:54:13 -0700 (PDT)
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
Subject: [PATCH v5 2/8] soc: mediatek: pm-domains: Move bools to a flags field
Date:   Mon, 19 Jun 2023 10:53:38 +0200
Message-Id: <20230619085344.2885311-3-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230619085344.2885311-1-msp@baylibre.com>
References: <20230619085344.2885311-1-msp@baylibre.com>
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
index 5ec53ee073c4..e26c8c317a6b 100644
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
+	u32 flags;
 };
 
 /**
-- 
2.40.1

