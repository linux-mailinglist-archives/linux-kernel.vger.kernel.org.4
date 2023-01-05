Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4489265F260
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbjAERQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbjAERPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:15:11 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269BD67BCC
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:09:21 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r2so1949183wrv.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 09:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvXKcEbwULcjNy/x9YB9utQCAcj11EGEkTp6VrX3MLc=;
        b=TKpKVqD9gSHNYL2zofVueeqK1Tll1hALYFD6l7hkdRVGqMsPq+U+j3e7bECAudp95d
         /Vvj//pM0bw+/ZaKglX4L+dJVfPk5wZ4kV+D7bOKicrrpo3vWIW4MvyNAkP0kqoG5M4j
         lzfUwDQgIdMotwuJ0OOjnDix6sODlL90Ly3aJ1Qg5v7bYv0ReUfuPVpjrxLUYvnCNwky
         wMS/5dwxViCEDJrlMX7G9ZrmMeQpCIuW24+h2NYjvKrAxI7UkYvdZNxTKCCLA2tc0LhT
         bupHaB4Rid1gBGvXeZ92DdMdoZf0Io4RnsrpWNbsvkOzmbuxARXyWcJInyxh9x2d/sYc
         H8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvXKcEbwULcjNy/x9YB9utQCAcj11EGEkTp6VrX3MLc=;
        b=miVkWIrR91c8LHJCgdwkgw3DyqccX4uH5wIeyNuJap/+nbbmsIqls7uhJxVsTzj5Gw
         8iYUpdeJO+aSZT211d6+vLM8rI8PclmxrZS7n0msuyikScQ6LRQyUy2l8VxgRqCc6eA2
         t4JgKOsIgvL41+zbRsGVpwsZMbUXcsrOnT4qIvfcpgDjCSATsBeumD8/Fw1hNoXCkCTb
         qy4xzLFbG5jY2uu1qva0L8NlH6E5Kb4JRmcTb911GzGc/M62kQlRL7IEP08qW4vumWf2
         2y3pAZrMZRWLJsl39rTqgfwedFGytryQur9HdPzNuYyChfSfBfycuk+KlQolniJh8u7l
         atXw==
X-Gm-Message-State: AFqh2koGP9er65jg9+75dt4klX6JWDAlZFtdJdJzumcB+6gL28WPBTeW
        Zf6KOvwtcv9fDRJ8tKxwrErBPA==
X-Google-Smtp-Source: AMrXdXs6DAkTMn1HVe6xKQPUdVm7ulbeOGCPzUQJnFZ7cJeSbtwnc2P0YPv4b1zCiyl/YPH8IHpLaw==
X-Received: by 2002:adf:f183:0:b0:255:96ed:950b with SMTP id h3-20020adff183000000b0025596ed950bmr30788321wro.60.1672938468864;
        Thu, 05 Jan 2023 09:07:48 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a245:805c:9cf4:fdb8:bb61:5f4e])
        by smtp.gmail.com with ESMTPSA id f14-20020adfe90e000000b002365730eae8sm37164853wrm.55.2023.01.05.09.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:07:48 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 2/8] soc: mediatek: pm-domains: Split bus_prot_mask
Date:   Thu,  5 Jan 2023 18:07:29 +0100
Message-Id: <20230105170735.1637416-3-msp@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105170735.1637416-1-msp@baylibre.com>
References: <20230105170735.1637416-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bus_prot_mask is used for all operations, set clear and acknowledge. In
preparation of m8365 power domain support split this one mask into two,
one mask for set and clear, another one for acknowledge.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/soc/mediatek/mtk-pm-domains.c | 24 ++++++++++++++----------
 drivers/soc/mediatek/mtk-pm-domains.h | 14 ++++++++------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 474b272f9b02..4333cd297405 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -122,18 +122,20 @@ static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, st
 	int i, ret;
 
 	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
-		u32 val, mask = bpd[i].bus_prot_mask;
+		u32 val;
+		u32 set_clr_mask = bpd[i].bus_prot_set_clr_mask;
+		u32 sta_mask = bpd[i].bus_prot_sta_mask;
 
-		if (!mask)
+		if (!set_clr_mask)
 			break;
 
 		if (bpd[i].bus_prot_reg_update)
-			regmap_set_bits(regmap, bpd[i].bus_prot_set, mask);
+			regmap_set_bits(regmap, bpd[i].bus_prot_set, set_clr_mask);
 		else
-			regmap_write(regmap, bpd[i].bus_prot_set, mask);
+			regmap_write(regmap, bpd[i].bus_prot_set, set_clr_mask);
 
 		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
-					       val, (val & mask) == mask,
+					       val, (val & sta_mask) == sta_mask,
 					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 		if (ret)
 			return ret;
@@ -159,21 +161,23 @@ static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
 	int i, ret;
 
 	for (i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
-		u32 val, mask = bpd[i].bus_prot_mask;
+		u32 val;
+		u32 set_clr_mask = bpd[i].bus_prot_set_clr_mask;
+		u32 sta_mask = bpd[i].bus_prot_sta_mask;
 
-		if (!mask)
+		if (!set_clr_mask)
 			continue;
 
 		if (bpd[i].bus_prot_reg_update)
-			regmap_clear_bits(regmap, bpd[i].bus_prot_clr, mask);
+			regmap_clear_bits(regmap, bpd[i].bus_prot_clr, set_clr_mask);
 		else
-			regmap_write(regmap, bpd[i].bus_prot_clr, mask);
+			regmap_write(regmap, bpd[i].bus_prot_clr, set_clr_mask);
 
 		if (bpd[i].ignore_clr_ack)
 			continue;
 
 		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
-					       val, !(val & mask),
+					       val, !(val & sta_mask),
 					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 		if (ret)
 			return ret;
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index 7d3c0c36316c..8aaed1c939d7 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -41,23 +41,24 @@
 
 #define SPM_MAX_BUS_PROT_DATA		6
 
-#define _BUS_PROT(_mask, _set, _clr, _sta, _update, _ignore) {	\
-		.bus_prot_mask = (_mask),			\
+#define _BUS_PROT(_set_clr_mask, _set, _clr, _sta_mask, _sta, _update, _ignore) {	\
+		.bus_prot_set_clr_mask = (_set_clr_mask),	\
 		.bus_prot_set = _set,				\
 		.bus_prot_clr = _clr,				\
+		.bus_prot_sta_mask = (_sta_mask),		\
 		.bus_prot_sta = _sta,				\
 		.bus_prot_reg_update = _update,			\
 		.ignore_clr_ack = _ignore,			\
 	}
 
 #define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
-		_BUS_PROT(_mask, _set, _clr, _sta, false, false)
+		_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, false)
 
 #define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
-		_BUS_PROT(_mask, _set, _clr, _sta, false, true)
+		_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, true)
 
 #define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
-		_BUS_PROT(_mask, _set, _clr, _sta, true, false)
+		_BUS_PROT(_mask, _set, _clr, _mask, _sta, true, false)
 
 #define BUS_PROT_UPDATE_TOPAXI(_mask)				\
 		BUS_PROT_UPDATE(_mask,				\
@@ -66,9 +67,10 @@
 				INFRA_TOPAXI_PROTECTSTA1)
 
 struct scpsys_bus_prot_data {
-	u32 bus_prot_mask;
+	u32 bus_prot_set_clr_mask;
 	u32 bus_prot_set;
 	u32 bus_prot_clr;
+	u32 bus_prot_sta_mask;
 	u32 bus_prot_sta;
 	bool bus_prot_reg_update;
 	bool ignore_clr_ack;
-- 
2.39.0

