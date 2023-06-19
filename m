Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DEE734ECA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjFSIzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjFSIzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:55:06 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F3F10C1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:54:19 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9881b9d8cbdso295007866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687164857; x=1689756857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jf+CX0kaOeoHn02/GJLuhXeM59KH1/HKD3QeKH1HJTQ=;
        b=uTANpF6GTocrowzwTDclocMHhLO7JDU8eVdTlRUO+S/xCXYZW5AQC2Gl0aTVrgPgnN
         jiz/TtdHGds35Zs5wBYcFW5bVxe/+Zva7rCXUtVnXVLBUNjpMSsNxtx58E6lMOYNTS66
         n7piqc9iXeguQYTNZXwLWoTAUOC9eHp6d0ayISCzozCVHn3kAuJXp5Nd5VuCncy+AUjk
         t+RYbmYq5D+XMNvE0DDgpvtTQG7oqGwGRcHF0b+Nb+o6IsksSLdg1EWLtf+JdPS/5bvJ
         0+efO0y2o5NR+lPc28E+XidzL+1+Lpfd9//K4aMThnjVPfC11nLyPa4/o5xFu1mVIuwG
         blsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687164857; x=1689756857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jf+CX0kaOeoHn02/GJLuhXeM59KH1/HKD3QeKH1HJTQ=;
        b=dBPCVHN3HFZDnbdZFoW0EDDA7Rx7VK1xuDX6PL2lnZ0eoZrBQQa8gdSC4tDoyBKi1T
         yvQ20OIwfhaIyRaXfZp0mTvS5Lq9m7J4EbJHCbdeFex2CqIpYyo/k4Z57IcTaiUvdhJA
         JNci3O2jRqQrYbc0v8rxECoLQi/vSddE9qnkSK3x0gdIEpk+6NrhdjKR7xHUmu0PIWBg
         P6jTW5YJ2NhLI/tuG3E87+CwxxPbhUHXBXSihKj1Yh6Nha6K0DAmbhNlqi7xhpDhYPE2
         evhs9vwEBw7+ru4E7YFHOKS4IL5nY0NOfsKjh+bYQJ5xEB9BtxT9/WX0vXRub6s4KMNC
         rFmg==
X-Gm-Message-State: AC+VfDx3kVT4NXTGhG+FkKr1puDUcqoTGHsY24rUR2Ufxyavt7HkbWjB
        sQbHy1H+XGjL1eLJzYp6j+kP9A==
X-Google-Smtp-Source: ACHHUZ5NAyOrrxu/FHhE7bjsX68qNoY2squlc4IyPU7iG1nj3yqnD0KqFQuVR4Cz/WC7YDJjqB3kKQ==
X-Received: by 2002:a17:906:dc94:b0:982:87fd:7760 with SMTP id cs20-20020a170906dc9400b0098287fd7760mr8595144ejc.18.1687164857195;
        Mon, 19 Jun 2023 01:54:17 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a245:802c:bc2b:8db8:9210:41eb])
        by smtp.gmail.com with ESMTPSA id h27-20020a17090619db00b00987a6e01e94sm2994339ejd.214.2023.06.19.01.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 01:54:16 -0700 (PDT)
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
Subject: [PATCH v5 5/8] soc: mediatek: pm-domains: Unify configuration for infracfg and smi
Date:   Mon, 19 Jun 2023 10:53:41 +0200
Message-Id: <20230619085344.2885311-6-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230619085344.2885311-1-msp@baylibre.com>
References: <20230619085344.2885311-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use flags to distinguish between infracfg and smi subsystem for a bus
protection configuration. It simplifies enabling/disabling and prepares
the driver for the use of another regmap for mt8365.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/soc/mediatek/mt6795-pm-domains.h |  16 +-
 drivers/soc/mediatek/mt8167-pm-domains.h |  20 +-
 drivers/soc/mediatek/mt8173-pm-domains.h |  16 +-
 drivers/soc/mediatek/mt8183-pm-domains.h | 198 ++++-----
 drivers/soc/mediatek/mt8186-pm-domains.h | 212 +++++-----
 drivers/soc/mediatek/mt8188-pm-domains.h | 518 +++++++++++------------
 drivers/soc/mediatek/mt8192-pm-domains.h | 262 ++++++------
 drivers/soc/mediatek/mt8195-pm-domains.h | 464 ++++++++++----------
 drivers/soc/mediatek/mtk-pm-domains.c    |  64 ++-
 drivers/soc/mediatek/mtk-pm-domains.h    |  37 +-
 10 files changed, 908 insertions(+), 899 deletions(-)

diff --git a/drivers/soc/mediatek/mt6795-pm-domains.h b/drivers/soc/mediatek/mt6795-pm-domains.h
index ef07c9dfdd9b..a3f7785b04bd 100644
--- a/drivers/soc/mediatek/mt6795-pm-domains.h
+++ b/drivers/soc/mediatek/mt6795-pm-domains.h
@@ -46,9 +46,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt6795[] = {
 		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MM_M0 |
-					       MT8173_TOP_AXI_PROT_EN_MM_M1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MM_M0 |
+						     MT8173_TOP_AXI_PROT_EN_MM_M1),
 		},
 	},
 	[MT6795_POWER_DOMAIN_MJC] = {
@@ -95,11 +95,11 @@ static const struct scpsys_domain_data scpsys_domain_data_mt6795[] = {
 		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(13, 8),
 		.sram_pdn_ack_bits = GENMASK(21, 16),
-		.bp_infracfg = {
-			BUS_PROT_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MFG_S |
-					       MT8173_TOP_AXI_PROT_EN_MFG_M0 |
-					       MT8173_TOP_AXI_PROT_EN_MFG_M1 |
-					       MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT),
+		.bp_cfg = {
+			BUS_PROT_INFRA_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MFG_S |
+						     MT8173_TOP_AXI_PROT_EN_MFG_M0 |
+						     MT8173_TOP_AXI_PROT_EN_MFG_M1 |
+						     MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT),
 		},
 	},
 };
diff --git a/drivers/soc/mediatek/mt8167-pm-domains.h b/drivers/soc/mediatek/mt8167-pm-domains.h
index 4d6c32759606..8a0e898b79ab 100644
--- a/drivers/soc/mediatek/mt8167-pm-domains.h
+++ b/drivers/soc/mediatek/mt8167-pm-domains.h
@@ -22,9 +22,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
 		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_UPDATE_TOPAXI(MT8167_TOP_AXI_PROT_EN_MM_EMI |
-					       MT8167_TOP_AXI_PROT_EN_MCU_MM),
+		.bp_cfg = {
+			BUS_PROT_INFRA_UPDATE_TOPAXI(MT8167_TOP_AXI_PROT_EN_MM_EMI |
+						     MT8167_TOP_AXI_PROT_EN_MCU_MM),
 		},
 		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
@@ -56,9 +56,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
 		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = 0,
 		.sram_pdn_ack_bits = 0,
-		.bp_infracfg = {
-			BUS_PROT_UPDATE_TOPAXI(MT8167_TOP_AXI_PROT_EN_MCU_MFG |
-					       MT8167_TOP_AXI_PROT_EN_MFG_EMI),
+		.bp_cfg = {
+			BUS_PROT_INFRA_UPDATE_TOPAXI(MT8167_TOP_AXI_PROT_EN_MCU_MFG |
+						     MT8167_TOP_AXI_PROT_EN_MFG_EMI),
 		},
 	},
 	[MT8167_POWER_DOMAIN_MFG_2D] = {
@@ -88,10 +88,10 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = 0,
 		.caps = MTK_SCPD_ACTIVE_WAKEUP,
-		.bp_infracfg = {
-			BUS_PROT_UPDATE_TOPAXI(MT8167_TOP_AXI_PROT_EN_CONN_EMI |
-					       MT8167_TOP_AXI_PROT_EN_CONN_MCU |
-					       MT8167_TOP_AXI_PROT_EN_MCU_CONN),
+		.bp_cfg = {
+			BUS_PROT_INFRA_UPDATE_TOPAXI(MT8167_TOP_AXI_PROT_EN_CONN_EMI |
+						     MT8167_TOP_AXI_PROT_EN_CONN_MCU |
+						     MT8167_TOP_AXI_PROT_EN_MCU_CONN),
 		},
 	},
 };
diff --git a/drivers/soc/mediatek/mt8173-pm-domains.h b/drivers/soc/mediatek/mt8173-pm-domains.h
index 1a5dc63b7357..7be0f47f5214 100644
--- a/drivers/soc/mediatek/mt8173-pm-domains.h
+++ b/drivers/soc/mediatek/mt8173-pm-domains.h
@@ -46,9 +46,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MM_M0 |
-					       MT8173_TOP_AXI_PROT_EN_MM_M1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MM_M0 |
+						     MT8173_TOP_AXI_PROT_EN_MM_M1),
 		},
 	},
 	[MT8173_POWER_DOMAIN_VENC_LT] = {
@@ -106,11 +106,11 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(13, 8),
 		.sram_pdn_ack_bits = GENMASK(21, 16),
-		.bp_infracfg = {
-			BUS_PROT_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MFG_S |
-					       MT8173_TOP_AXI_PROT_EN_MFG_M0 |
-					       MT8173_TOP_AXI_PROT_EN_MFG_M1 |
-					       MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT),
+		.bp_cfg = {
+			BUS_PROT_INFRA_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MFG_S |
+						     MT8173_TOP_AXI_PROT_EN_MFG_M0 |
+						     MT8173_TOP_AXI_PROT_EN_MFG_M1 |
+						     MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT),
 		},
 	},
 };
diff --git a/drivers/soc/mediatek/mt8183-pm-domains.h b/drivers/soc/mediatek/mt8183-pm-domains.h
index 99de67fe5de8..5d5c0a620da4 100644
--- a/drivers/soc/mediatek/mt8183-pm-domains.h
+++ b/drivers/soc/mediatek/mt8183-pm-domains.h
@@ -28,9 +28,11 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = 0,
 		.sram_pdn_ack_bits = 0,
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_CONN, MT8183_TOP_AXI_PROT_EN_SET,
-				    MT8183_TOP_AXI_PROT_EN_CLR, MT8183_TOP_AXI_PROT_EN_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8183_TOP_AXI_PROT_EN_CONN,
+					  MT8183_TOP_AXI_PROT_EN_SET,
+					  MT8183_TOP_AXI_PROT_EN_CLR,
+					  MT8183_TOP_AXI_PROT_EN_STA1),
 		},
 	},
 	[MT8183_POWER_DOMAIN_MFG_ASYNC] = {
@@ -79,11 +81,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_1_MFG, MT8183_TOP_AXI_PROT_EN_1_SET,
-				    MT8183_TOP_AXI_PROT_EN_1_CLR, MT8183_TOP_AXI_PROT_EN_STA1_1),
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MFG, MT8183_TOP_AXI_PROT_EN_SET,
-				    MT8183_TOP_AXI_PROT_EN_CLR, MT8183_TOP_AXI_PROT_EN_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8183_TOP_AXI_PROT_EN_1_MFG,
+					  MT8183_TOP_AXI_PROT_EN_1_SET,
+					  MT8183_TOP_AXI_PROT_EN_1_CLR,
+					  MT8183_TOP_AXI_PROT_EN_STA1_1),
+			BUS_PROT_INFRA_WR(MT8183_TOP_AXI_PROT_EN_MFG,
+					  MT8183_TOP_AXI_PROT_EN_SET,
+					  MT8183_TOP_AXI_PROT_EN_CLR,
+					  MT8183_TOP_AXI_PROT_EN_STA1),
 		},
 	},
 	[MT8183_POWER_DOMAIN_DISP] = {
@@ -94,17 +100,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_1_DISP, MT8183_TOP_AXI_PROT_EN_1_SET,
-				    MT8183_TOP_AXI_PROT_EN_1_CLR, MT8183_TOP_AXI_PROT_EN_STA1_1),
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_DISP, MT8183_TOP_AXI_PROT_EN_SET,
-				    MT8183_TOP_AXI_PROT_EN_CLR, MT8183_TOP_AXI_PROT_EN_STA1),
-		},
-		.bp_smi = {
-			BUS_PROT_WR(MT8183_SMI_COMMON_SMI_CLAMP_DISP,
-				    MT8183_SMI_COMMON_CLAMP_EN_SET,
-				    MT8183_SMI_COMMON_CLAMP_EN_CLR,
-				    MT8183_SMI_COMMON_CLAMP_EN),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8183_TOP_AXI_PROT_EN_1_DISP,
+					  MT8183_TOP_AXI_PROT_EN_1_SET,
+					  MT8183_TOP_AXI_PROT_EN_1_CLR,
+					  MT8183_TOP_AXI_PROT_EN_STA1_1),
+			BUS_PROT_INFRA_WR(MT8183_TOP_AXI_PROT_EN_DISP,
+					  MT8183_TOP_AXI_PROT_EN_SET,
+					  MT8183_TOP_AXI_PROT_EN_CLR,
+					  MT8183_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_SMI_WR(MT8183_SMI_COMMON_SMI_CLAMP_DISP,
+					MT8183_SMI_COMMON_CLAMP_EN_SET,
+					MT8183_SMI_COMMON_CLAMP_EN_CLR,
+					MT8183_SMI_COMMON_CLAMP_EN),
 		},
 	},
 	[MT8183_POWER_DOMAIN_CAM] = {
@@ -115,21 +123,23 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(9, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MM_CAM, MT8183_TOP_AXI_PROT_EN_MM_SET,
-				    MT8183_TOP_AXI_PROT_EN_MM_CLR, MT8183_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_CAM, MT8183_TOP_AXI_PROT_EN_SET,
-				    MT8183_TOP_AXI_PROT_EN_CLR, MT8183_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR_IGN(MT8183_TOP_AXI_PROT_EN_MM_CAM_2ND,
-					MT8183_TOP_AXI_PROT_EN_MM_SET,
-					MT8183_TOP_AXI_PROT_EN_MM_CLR,
-					MT8183_TOP_AXI_PROT_EN_MM_STA1),
-		},
-		.bp_smi = {
-			BUS_PROT_WR(MT8183_SMI_COMMON_SMI_CLAMP_CAM,
-				    MT8183_SMI_COMMON_CLAMP_EN_SET,
-				    MT8183_SMI_COMMON_CLAMP_EN_CLR,
-				    MT8183_SMI_COMMON_CLAMP_EN),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8183_TOP_AXI_PROT_EN_MM_CAM,
+					  MT8183_TOP_AXI_PROT_EN_MM_SET,
+					  MT8183_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8183_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8183_TOP_AXI_PROT_EN_CAM,
+					  MT8183_TOP_AXI_PROT_EN_SET,
+					  MT8183_TOP_AXI_PROT_EN_CLR,
+					  MT8183_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_INFRA_WR_IGN(MT8183_TOP_AXI_PROT_EN_MM_CAM_2ND,
+					      MT8183_TOP_AXI_PROT_EN_MM_SET,
+					      MT8183_TOP_AXI_PROT_EN_MM_CLR,
+					      MT8183_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_SMI_WR(MT8183_SMI_COMMON_SMI_CLAMP_CAM,
+					MT8183_SMI_COMMON_CLAMP_EN_SET,
+					MT8183_SMI_COMMON_CLAMP_EN_CLR,
+					MT8183_SMI_COMMON_CLAMP_EN),
 		},
 	},
 	[MT8183_POWER_DOMAIN_ISP] = {
@@ -140,21 +150,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(9, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MM_ISP,
-				    MT8183_TOP_AXI_PROT_EN_MM_SET,
-				    MT8183_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8183_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR_IGN(MT8183_TOP_AXI_PROT_EN_MM_ISP_2ND,
-					MT8183_TOP_AXI_PROT_EN_MM_SET,
-					MT8183_TOP_AXI_PROT_EN_MM_CLR,
-					MT8183_TOP_AXI_PROT_EN_MM_STA1),
-		},
-		.bp_smi = {
-			BUS_PROT_WR(MT8183_SMI_COMMON_SMI_CLAMP_ISP,
-				    MT8183_SMI_COMMON_CLAMP_EN_SET,
-				    MT8183_SMI_COMMON_CLAMP_EN_CLR,
-				    MT8183_SMI_COMMON_CLAMP_EN),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8183_TOP_AXI_PROT_EN_MM_ISP,
+					  MT8183_TOP_AXI_PROT_EN_MM_SET,
+					  MT8183_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8183_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR_IGN(MT8183_TOP_AXI_PROT_EN_MM_ISP_2ND,
+					      MT8183_TOP_AXI_PROT_EN_MM_SET,
+					      MT8183_TOP_AXI_PROT_EN_MM_CLR,
+					      MT8183_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_SMI_WR(MT8183_SMI_COMMON_SMI_CLAMP_ISP,
+					MT8183_SMI_COMMON_CLAMP_EN_SET,
+					MT8183_SMI_COMMON_CLAMP_EN_CLR,
+					MT8183_SMI_COMMON_CLAMP_EN),
 		},
 	},
 	[MT8183_POWER_DOMAIN_VDEC] = {
@@ -165,11 +173,11 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_smi = {
-			BUS_PROT_WR(MT8183_SMI_COMMON_SMI_CLAMP_VDEC,
-				    MT8183_SMI_COMMON_CLAMP_EN_SET,
-				    MT8183_SMI_COMMON_CLAMP_EN_CLR,
-				    MT8183_SMI_COMMON_CLAMP_EN),
+		.bp_cfg = {
+			BUS_PROT_SMI_WR(MT8183_SMI_COMMON_SMI_CLAMP_VDEC,
+					MT8183_SMI_COMMON_CLAMP_EN_SET,
+					MT8183_SMI_COMMON_CLAMP_EN_CLR,
+					MT8183_SMI_COMMON_CLAMP_EN),
 		},
 	},
 	[MT8183_POWER_DOMAIN_VENC] = {
@@ -180,11 +188,11 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
-		.bp_smi = {
-			BUS_PROT_WR(MT8183_SMI_COMMON_SMI_CLAMP_VENC,
-				    MT8183_SMI_COMMON_CLAMP_EN_SET,
-				    MT8183_SMI_COMMON_CLAMP_EN_CLR,
-				    MT8183_SMI_COMMON_CLAMP_EN),
+		.bp_cfg = {
+			BUS_PROT_SMI_WR(MT8183_SMI_COMMON_SMI_CLAMP_VENC,
+					MT8183_SMI_COMMON_CLAMP_EN_SET,
+					MT8183_SMI_COMMON_CLAMP_EN_CLR,
+					MT8183_SMI_COMMON_CLAMP_EN),
 		},
 	},
 	[MT8183_POWER_DOMAIN_VPU_TOP] = {
@@ -195,25 +203,23 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MM_VPU_TOP,
-				    MT8183_TOP_AXI_PROT_EN_MM_SET,
-				    MT8183_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8183_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_VPU_TOP,
-				    MT8183_TOP_AXI_PROT_EN_SET,
-				    MT8183_TOP_AXI_PROT_EN_CLR,
-				    MT8183_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MM_VPU_TOP_2ND,
-				    MT8183_TOP_AXI_PROT_EN_MM_SET,
-				    MT8183_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8183_TOP_AXI_PROT_EN_MM_STA1),
-		},
-		.bp_smi = {
-			BUS_PROT_WR(MT8183_SMI_COMMON_SMI_CLAMP_VPU_TOP,
-				    MT8183_SMI_COMMON_CLAMP_EN_SET,
-				    MT8183_SMI_COMMON_CLAMP_EN_CLR,
-				    MT8183_SMI_COMMON_CLAMP_EN),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8183_TOP_AXI_PROT_EN_MM_VPU_TOP,
+					  MT8183_TOP_AXI_PROT_EN_MM_SET,
+					  MT8183_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8183_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8183_TOP_AXI_PROT_EN_VPU_TOP,
+					  MT8183_TOP_AXI_PROT_EN_SET,
+					  MT8183_TOP_AXI_PROT_EN_CLR,
+					  MT8183_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_INFRA_WR(MT8183_TOP_AXI_PROT_EN_MM_VPU_TOP_2ND,
+					  MT8183_TOP_AXI_PROT_EN_MM_SET,
+					  MT8183_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8183_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_SMI_WR(MT8183_SMI_COMMON_SMI_CLAMP_VPU_TOP,
+					MT8183_SMI_COMMON_CLAMP_EN_SET,
+					MT8183_SMI_COMMON_CLAMP_EN_CLR,
+					MT8183_SMI_COMMON_CLAMP_EN),
 		},
 	},
 	[MT8183_POWER_DOMAIN_VPU_CORE0] = {
@@ -224,15 +230,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE0,
-				    MT8183_TOP_AXI_PROT_EN_MCU_SET,
-				    MT8183_TOP_AXI_PROT_EN_MCU_CLR,
-				    MT8183_TOP_AXI_PROT_EN_MCU_STA1),
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE0_2ND,
-				    MT8183_TOP_AXI_PROT_EN_MCU_SET,
-				    MT8183_TOP_AXI_PROT_EN_MCU_CLR,
-				    MT8183_TOP_AXI_PROT_EN_MCU_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE0,
+					  MT8183_TOP_AXI_PROT_EN_MCU_SET,
+					  MT8183_TOP_AXI_PROT_EN_MCU_CLR,
+					  MT8183_TOP_AXI_PROT_EN_MCU_STA1),
+			BUS_PROT_INFRA_WR(MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE0_2ND,
+					  MT8183_TOP_AXI_PROT_EN_MCU_SET,
+					  MT8183_TOP_AXI_PROT_EN_MCU_CLR,
+					  MT8183_TOP_AXI_PROT_EN_MCU_STA1),
 		},
 		.caps = MTK_SCPD_SRAM_ISO,
 	},
@@ -244,15 +250,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE1,
-				    MT8183_TOP_AXI_PROT_EN_MCU_SET,
-				    MT8183_TOP_AXI_PROT_EN_MCU_CLR,
-				    MT8183_TOP_AXI_PROT_EN_MCU_STA1),
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE1_2ND,
-				    MT8183_TOP_AXI_PROT_EN_MCU_SET,
-				    MT8183_TOP_AXI_PROT_EN_MCU_CLR,
-				    MT8183_TOP_AXI_PROT_EN_MCU_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE1,
+					  MT8183_TOP_AXI_PROT_EN_MCU_SET,
+					  MT8183_TOP_AXI_PROT_EN_MCU_CLR,
+					  MT8183_TOP_AXI_PROT_EN_MCU_STA1),
+			BUS_PROT_INFRA_WR(MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE1_2ND,
+					  MT8183_TOP_AXI_PROT_EN_MCU_SET,
+					  MT8183_TOP_AXI_PROT_EN_MCU_CLR,
+					  MT8183_TOP_AXI_PROT_EN_MCU_STA1),
 		},
 		.caps = MTK_SCPD_SRAM_ISO,
 	},
diff --git a/drivers/soc/mediatek/mt8186-pm-domains.h b/drivers/soc/mediatek/mt8186-pm-domains.h
index fce86f79c505..25b5651f0ae2 100644
--- a/drivers/soc/mediatek/mt8186-pm-domains.h
+++ b/drivers/soc/mediatek/mt8186-pm-domains.h
@@ -33,23 +33,23 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_MFG1_STEP1,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_MFG1_STEP2,
-				MT8186_TOP_AXI_PROT_EN_SET,
-				MT8186_TOP_AXI_PROT_EN_CLR,
-				MT8186_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_MFG1_STEP3,
-				MT8186_TOP_AXI_PROT_EN_SET,
-				MT8186_TOP_AXI_PROT_EN_CLR,
-				MT8186_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_MFG1_STEP4,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_MFG1_STEP1,
+					      MT8186_TOP_AXI_PROT_EN_1_SET,
+					      MT8186_TOP_AXI_PROT_EN_1_CLR,
+					      MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_MFG1_STEP2,
+					      MT8186_TOP_AXI_PROT_EN_SET,
+					      MT8186_TOP_AXI_PROT_EN_CLR,
+					      MT8186_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_MFG1_STEP3,
+					      MT8186_TOP_AXI_PROT_EN_SET,
+					      MT8186_TOP_AXI_PROT_EN_CLR,
+					      MT8186_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_MFG1_STEP4,
+					      MT8186_TOP_AXI_PROT_EN_1_SET,
+					      MT8186_TOP_AXI_PROT_EN_1_CLR,
+					      MT8186_TOP_AXI_PROT_EN_1_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
 	},
@@ -101,15 +101,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_DIS_STEP1,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_DIS_STEP2,
-				MT8186_TOP_AXI_PROT_EN_SET,
-				MT8186_TOP_AXI_PROT_EN_CLR,
-				MT8186_TOP_AXI_PROT_EN_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_DIS_STEP1,
+					      MT8186_TOP_AXI_PROT_EN_1_SET,
+					      MT8186_TOP_AXI_PROT_EN_1_CLR,
+					      MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_DIS_STEP2,
+					      MT8186_TOP_AXI_PROT_EN_SET,
+					      MT8186_TOP_AXI_PROT_EN_CLR,
+					      MT8186_TOP_AXI_PROT_EN_STA),
 		},
 	},
 	[MT8186_POWER_DOMAIN_IMG] = {
@@ -120,15 +120,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_IMG_STEP1,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_IMG_STEP2,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_IMG_STEP1,
+					      MT8186_TOP_AXI_PROT_EN_1_SET,
+					      MT8186_TOP_AXI_PROT_EN_1_CLR,
+					      MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_IMG_STEP2,
+					      MT8186_TOP_AXI_PROT_EN_1_SET,
+					      MT8186_TOP_AXI_PROT_EN_1_CLR,
+					      MT8186_TOP_AXI_PROT_EN_1_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -150,15 +150,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_IPE_STEP1,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_IPE_STEP2,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_IPE_STEP1,
+					      MT8186_TOP_AXI_PROT_EN_1_SET,
+					      MT8186_TOP_AXI_PROT_EN_1_CLR,
+					      MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_IPE_STEP2,
+					      MT8186_TOP_AXI_PROT_EN_1_SET,
+					      MT8186_TOP_AXI_PROT_EN_1_CLR,
+					      MT8186_TOP_AXI_PROT_EN_1_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -170,15 +170,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_CAM_STEP1,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_CAM_STEP2,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_CAM_STEP1,
+					      MT8186_TOP_AXI_PROT_EN_1_SET,
+					      MT8186_TOP_AXI_PROT_EN_1_CLR,
+					      MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_CAM_STEP2,
+					      MT8186_TOP_AXI_PROT_EN_1_SET,
+					      MT8186_TOP_AXI_PROT_EN_1_CLR,
+					      MT8186_TOP_AXI_PROT_EN_1_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -210,15 +210,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_VENC_STEP1,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_VENC_STEP2,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_VENC_STEP1,
+					      MT8186_TOP_AXI_PROT_EN_1_SET,
+					      MT8186_TOP_AXI_PROT_EN_1_CLR,
+					      MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_VENC_STEP2,
+					      MT8186_TOP_AXI_PROT_EN_1_SET,
+					      MT8186_TOP_AXI_PROT_EN_1_CLR,
+					      MT8186_TOP_AXI_PROT_EN_1_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -230,15 +230,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_VDEC_STEP1,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_VDEC_STEP2,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_VDEC_STEP1,
+					      MT8186_TOP_AXI_PROT_EN_1_SET,
+					      MT8186_TOP_AXI_PROT_EN_1_CLR,
+					      MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_VDEC_STEP2,
+					      MT8186_TOP_AXI_PROT_EN_1_SET,
+					      MT8186_TOP_AXI_PROT_EN_1_CLR,
+					      MT8186_TOP_AXI_PROT_EN_1_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -250,15 +250,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_2_WPE_STEP1,
-				MT8186_TOP_AXI_PROT_EN_2_SET,
-				MT8186_TOP_AXI_PROT_EN_2_CLR,
-				MT8186_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_2_WPE_STEP2,
-				MT8186_TOP_AXI_PROT_EN_2_SET,
-				MT8186_TOP_AXI_PROT_EN_2_CLR,
-				MT8186_TOP_AXI_PROT_EN_2_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_2_WPE_STEP1,
+					      MT8186_TOP_AXI_PROT_EN_2_SET,
+					      MT8186_TOP_AXI_PROT_EN_2_CLR,
+					      MT8186_TOP_AXI_PROT_EN_2_STA),
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_2_WPE_STEP2,
+					      MT8186_TOP_AXI_PROT_EN_2_SET,
+					      MT8186_TOP_AXI_PROT_EN_2_CLR,
+					      MT8186_TOP_AXI_PROT_EN_2_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -268,23 +268,23 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 		.ctl_offs = 0x304,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_CONN_ON_STEP1,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_CONN_ON_STEP2,
-				MT8186_TOP_AXI_PROT_EN_SET,
-				MT8186_TOP_AXI_PROT_EN_CLR,
-				MT8186_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_CONN_ON_STEP3,
-				MT8186_TOP_AXI_PROT_EN_SET,
-				MT8186_TOP_AXI_PROT_EN_CLR,
-				MT8186_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_CONN_ON_STEP4,
-				MT8186_TOP_AXI_PROT_EN_SET,
-				MT8186_TOP_AXI_PROT_EN_CLR,
-				MT8186_TOP_AXI_PROT_EN_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_CONN_ON_STEP1,
+					      MT8186_TOP_AXI_PROT_EN_1_SET,
+					      MT8186_TOP_AXI_PROT_EN_1_CLR,
+					      MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_CONN_ON_STEP2,
+					      MT8186_TOP_AXI_PROT_EN_SET,
+					      MT8186_TOP_AXI_PROT_EN_CLR,
+					      MT8186_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_CONN_ON_STEP3,
+					      MT8186_TOP_AXI_PROT_EN_SET,
+					      MT8186_TOP_AXI_PROT_EN_CLR,
+					      MT8186_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_CONN_ON_STEP4,
+					      MT8186_TOP_AXI_PROT_EN_SET,
+					      MT8186_TOP_AXI_PROT_EN_CLR,
+					      MT8186_TOP_AXI_PROT_EN_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_ACTIVE_WAKEUP,
 	},
@@ -320,15 +320,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_3_ADSP_TOP_STEP1,
-				MT8186_TOP_AXI_PROT_EN_3_SET,
-				MT8186_TOP_AXI_PROT_EN_3_CLR,
-				MT8186_TOP_AXI_PROT_EN_3_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_3_ADSP_TOP_STEP2,
-				MT8186_TOP_AXI_PROT_EN_3_SET,
-				MT8186_TOP_AXI_PROT_EN_3_CLR,
-				MT8186_TOP_AXI_PROT_EN_3_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_3_ADSP_TOP_STEP1,
+					      MT8186_TOP_AXI_PROT_EN_3_SET,
+					      MT8186_TOP_AXI_PROT_EN_3_CLR,
+					      MT8186_TOP_AXI_PROT_EN_3_STA),
+			BUS_PROT_INFRA_WR_IGN(MT8186_TOP_AXI_PROT_EN_3_ADSP_TOP_STEP2,
+					      MT8186_TOP_AXI_PROT_EN_3_SET,
+					      MT8186_TOP_AXI_PROT_EN_3_CLR,
+					      MT8186_TOP_AXI_PROT_EN_3_STA),
 		},
 		.caps = MTK_SCPD_SRAM_ISO | MTK_SCPD_ACTIVE_WAKEUP,
 	},
diff --git a/drivers/soc/mediatek/mt8188-pm-domains.h b/drivers/soc/mediatek/mt8188-pm-domains.h
index 0692cb444ed0..aa56ba31327d 100644
--- a/drivers/soc/mediatek/mt8188-pm-domains.h
+++ b/drivers/soc/mediatek/mt8188-pm-domains.h
@@ -33,31 +33,31 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x178,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MFG1_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_SET,
-				    MT8188_TOP_AXI_PROT_EN_CLR,
-				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_MFG1_STEP2,
-				    MT8188_TOP_AXI_PROT_EN_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_1_MFG1_STEP3,
-				    MT8188_TOP_AXI_PROT_EN_1_SET,
-				    MT8188_TOP_AXI_PROT_EN_1_CLR,
-				    MT8188_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_MFG1_STEP4,
-				    MT8188_TOP_AXI_PROT_EN_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MFG1_STEP5,
-				    MT8188_TOP_AXI_PROT_EN_SET,
-				    MT8188_TOP_AXI_PROT_EN_CLR,
-				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MFG1_STEP6,
-				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
-				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
-				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MFG1_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_SET,
+					  MT8188_TOP_AXI_PROT_EN_CLR,
+					  MT8188_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_2_MFG1_STEP2,
+					  MT8188_TOP_AXI_PROT_EN_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_2_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_1_MFG1_STEP3,
+					  MT8188_TOP_AXI_PROT_EN_1_SET,
+					  MT8188_TOP_AXI_PROT_EN_1_CLR,
+					  MT8188_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_2_MFG1_STEP4,
+					  MT8188_TOP_AXI_PROT_EN_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_2_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MFG1_STEP5,
+					  MT8188_TOP_AXI_PROT_EN_SET,
+					  MT8188_TOP_AXI_PROT_EN_CLR,
+					  MT8188_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MFG1_STEP6,
+					  MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
+					  MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
+					  MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
 	},
@@ -99,15 +99,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x178,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_PEXTP_MAC_P0_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_SET,
-				    MT8188_TOP_AXI_PROT_EN_CLR,
-				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_PEXTP_MAC_P0_STEP2,
-				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
-				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
-				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_PEXTP_MAC_P0_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_SET,
+					  MT8188_TOP_AXI_PROT_EN_CLR,
+					  MT8188_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_PEXTP_MAC_P0_STEP2,
+					  MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
+					  MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
+					  MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -135,11 +135,11 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_ETHER_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
-				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
-				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_ETHER_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
+					  MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
+					  MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_ACTIVE_WAKEUP,
 	},
@@ -151,11 +151,11 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_HDMI_TX_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
-				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
-				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_HDMI_TX_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
+					  MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
+					  MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_ACTIVE_WAKEUP,
 	},
@@ -165,15 +165,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.ctl_offs = 0x35C,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP2,
-				    MT8188_TOP_AXI_PROT_EN_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_2_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_2_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP2,
+					  MT8188_TOP_AXI_PROT_EN_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_2_STA),
 		},
 		.caps = MTK_SCPD_ALWAYS_ON,
 	},
@@ -185,15 +185,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_INFRA_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_INFRA_STEP2,
-				    MT8188_TOP_AXI_PROT_EN_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_2_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_INFRA_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_2_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_INFRA_STEP2,
+					  MT8188_TOP_AXI_PROT_EN_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_2_STA),
 		},
 		.caps = MTK_SCPD_SRAM_ISO | MTK_SCPD_ALWAYS_ON,
 	},
@@ -205,15 +205,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_STEP2,
-				    MT8188_TOP_AXI_PROT_EN_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_2_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_2_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_STEP2,
+					  MT8188_TOP_AXI_PROT_EN_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_2_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_SRAM_ISO | MTK_SCPD_ACTIVE_WAKEUP,
 	},
@@ -225,15 +225,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_STEP2,
-				    MT8188_TOP_AXI_PROT_EN_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_2_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_2_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_STEP2,
+					  MT8188_TOP_AXI_PROT_EN_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_2_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_ACTIVE_WAKEUP,
 	},
@@ -245,15 +245,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_ASRC_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_ASRC_STEP2,
-				    MT8188_TOP_AXI_PROT_EN_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_2_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_ASRC_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_2_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_ASRC_STEP2,
+					  MT8188_TOP_AXI_PROT_EN_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_2_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -265,27 +265,27 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_VPPSYS0_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_SET,
-				    MT8188_TOP_AXI_PROT_EN_CLR,
-				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS0_STEP2,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_VPPSYS0_STEP3,
-				    MT8188_TOP_AXI_PROT_EN_SET,
-				    MT8188_TOP_AXI_PROT_EN_CLR,
-				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS0_STEP4,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VPPSYS0_STEP5,
-				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
-				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
-				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_VPPSYS0_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_SET,
+					  MT8188_TOP_AXI_PROT_EN_CLR,
+					  MT8188_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS0_STEP2,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_VPPSYS0_STEP3,
+					  MT8188_TOP_AXI_PROT_EN_SET,
+					  MT8188_TOP_AXI_PROT_EN_CLR,
+					  MT8188_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS0_STEP4,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VPPSYS0_STEP5,
+					  MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
+					  MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
+					  MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA),
 		},
 	},
 	[MT8188_POWER_DOMAIN_VDOSYS0] = {
@@ -296,19 +296,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDOSYS0_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_MM_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_VDOSYS0_STEP2,
-				    MT8188_TOP_AXI_PROT_EN_SET,
-				    MT8188_TOP_AXI_PROT_EN_CLR,
-				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VDOSYS0_STEP3,
-				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
-				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
-				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_VDOSYS0_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_MM_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_VDOSYS0_STEP2,
+					  MT8188_TOP_AXI_PROT_EN_SET,
+					  MT8188_TOP_AXI_PROT_EN_CLR,
+					  MT8188_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VDOSYS0_STEP3,
+					  MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
+					  MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
+					  MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA),
 		},
 	},
 	[MT8188_POWER_DOMAIN_VDOSYS1] = {
@@ -319,19 +319,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDOSYS1_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_MM_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDOSYS1_STEP2,
-				    MT8188_TOP_AXI_PROT_EN_MM_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VDOSYS1_STEP3,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_VDOSYS1_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_MM_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_VDOSYS1_STEP2,
+					  MT8188_TOP_AXI_PROT_EN_MM_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VDOSYS1_STEP3,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_STA),
 		},
 	},
 	[MT8188_POWER_DOMAIN_DP_TX] = {
@@ -342,11 +342,11 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_DP_TX_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
-				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
-				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_DP_TX_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
+					  MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
+					  MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -358,11 +358,11 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_EDP_TX_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
-				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
-				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_EDP_TX_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
+					  MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
+					  MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -374,19 +374,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VPPSYS1_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_MM_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VPPSYS1_STEP2,
-				    MT8188_TOP_AXI_PROT_EN_MM_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS1_STEP3,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_VPPSYS1_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_MM_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_VPPSYS1_STEP2,
+					  MT8188_TOP_AXI_PROT_EN_MM_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS1_STEP3,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_STA),
 		},
 	},
 	[MT8188_POWER_DOMAIN_WPE] = {
@@ -397,15 +397,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_WPE_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_WPE_STEP2,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_2_WPE_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_2_WPE_STEP2,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -417,15 +417,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDEC0_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_MM_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VDEC0_STEP2,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_VDEC0_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_MM_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VDEC0_STEP2,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -437,15 +437,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDEC1_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_MM_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDEC1_STEP2,
-				    MT8188_TOP_AXI_PROT_EN_MM_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_VDEC1_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_MM_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_VDEC1_STEP2,
+					  MT8188_TOP_AXI_PROT_EN_MM_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -457,19 +457,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VENC_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_MM_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VENC_STEP2,
-				    MT8188_TOP_AXI_PROT_EN_MM_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VENC_STEP3,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_VENC_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_MM_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_VENC_STEP2,
+					  MT8188_TOP_AXI_PROT_EN_MM_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VENC_STEP3,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -479,19 +479,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.ctl_offs = 0x3A4,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_MM_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP2,
-				    MT8188_TOP_AXI_PROT_EN_MM_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_IMG_VCORE_STEP3,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_MM_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP2,
+					  MT8188_TOP_AXI_PROT_EN_MM_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_2_IMG_VCORE_STEP3,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
 	},
@@ -503,15 +503,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_IMG_MAIN_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_IMG_MAIN_STEP2,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_2_IMG_MAIN_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_2_IMG_MAIN_STEP2,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -541,27 +541,27 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.ctl_offs = 0x3A0,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_MM_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_CAM_VCORE_STEP2,
-				    MT8188_TOP_AXI_PROT_EN_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_1_CAM_VCORE_STEP3,
-				    MT8188_TOP_AXI_PROT_EN_1_SET,
-				    MT8188_TOP_AXI_PROT_EN_1_CLR,
-				    MT8188_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP4,
-				    MT8188_TOP_AXI_PROT_EN_MM_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_CAM_VCORE_STEP5,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_MM_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_2_CAM_VCORE_STEP2,
+					  MT8188_TOP_AXI_PROT_EN_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_2_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_1_CAM_VCORE_STEP3,
+					  MT8188_TOP_AXI_PROT_EN_1_SET,
+					  MT8188_TOP_AXI_PROT_EN_1_CLR,
+					  MT8188_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP4,
+					  MT8188_TOP_AXI_PROT_EN_MM_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_2_CAM_VCORE_STEP5,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
 	},
@@ -573,23 +573,23 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_CAM_MAIN_STEP1,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_CAM_MAIN_STEP2,
-				    MT8188_TOP_AXI_PROT_EN_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_CAM_MAIN_STEP3,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_CAM_MAIN_STEP4,
-				    MT8188_TOP_AXI_PROT_EN_2_SET,
-				    MT8188_TOP_AXI_PROT_EN_2_CLR,
-				    MT8188_TOP_AXI_PROT_EN_2_STA),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_2_CAM_MAIN_STEP1,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_2_CAM_MAIN_STEP2,
+					  MT8188_TOP_AXI_PROT_EN_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_2_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_MM_2_CAM_MAIN_STEP3,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+			BUS_PROT_INFRA_WR(MT8188_TOP_AXI_PROT_EN_2_CAM_MAIN_STEP4,
+					  MT8188_TOP_AXI_PROT_EN_2_SET,
+					  MT8188_TOP_AXI_PROT_EN_2_CLR,
+					  MT8188_TOP_AXI_PROT_EN_2_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
diff --git a/drivers/soc/mediatek/mt8192-pm-domains.h b/drivers/soc/mediatek/mt8192-pm-domains.h
index b97b2051920f..17ee852cfc26 100644
--- a/drivers/soc/mediatek/mt8192-pm-domains.h
+++ b/drivers/soc/mediatek/mt8192-pm-domains.h
@@ -19,11 +19,11 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_2_AUDIO,
-				    MT8192_TOP_AXI_PROT_EN_2_SET,
-				    MT8192_TOP_AXI_PROT_EN_2_CLR,
-				    MT8192_TOP_AXI_PROT_EN_2_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_2_AUDIO,
+					  MT8192_TOP_AXI_PROT_EN_2_SET,
+					  MT8192_TOP_AXI_PROT_EN_2_CLR,
+					  MT8192_TOP_AXI_PROT_EN_2_STA1),
 		},
 	},
 	[MT8192_POWER_DOMAIN_CONN] = {
@@ -34,19 +34,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = 0,
 		.sram_pdn_ack_bits = 0,
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_CONN,
-				    MT8192_TOP_AXI_PROT_EN_SET,
-				    MT8192_TOP_AXI_PROT_EN_CLR,
-				    MT8192_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_CONN_2ND,
-				    MT8192_TOP_AXI_PROT_EN_SET,
-				    MT8192_TOP_AXI_PROT_EN_CLR,
-				    MT8192_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_1_CONN,
-				    MT8192_TOP_AXI_PROT_EN_1_SET,
-				    MT8192_TOP_AXI_PROT_EN_1_CLR,
-				    MT8192_TOP_AXI_PROT_EN_1_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_CONN,
+					  MT8192_TOP_AXI_PROT_EN_SET,
+					  MT8192_TOP_AXI_PROT_EN_CLR,
+					  MT8192_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_CONN_2ND,
+					  MT8192_TOP_AXI_PROT_EN_SET,
+					  MT8192_TOP_AXI_PROT_EN_CLR,
+					  MT8192_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_1_CONN,
+					  MT8192_TOP_AXI_PROT_EN_1_SET,
+					  MT8192_TOP_AXI_PROT_EN_1_CLR,
+					  MT8192_TOP_AXI_PROT_EN_1_STA1),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -68,23 +68,23 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_1_MFG1,
-				    MT8192_TOP_AXI_PROT_EN_1_SET,
-				    MT8192_TOP_AXI_PROT_EN_1_CLR,
-				    MT8192_TOP_AXI_PROT_EN_1_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_2_MFG1,
-				    MT8192_TOP_AXI_PROT_EN_2_SET,
-				    MT8192_TOP_AXI_PROT_EN_2_CLR,
-				    MT8192_TOP_AXI_PROT_EN_2_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MFG1,
-				    MT8192_TOP_AXI_PROT_EN_SET,
-				    MT8192_TOP_AXI_PROT_EN_CLR,
-				    MT8192_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_2_MFG1_2ND,
-				    MT8192_TOP_AXI_PROT_EN_2_SET,
-				    MT8192_TOP_AXI_PROT_EN_2_CLR,
-				    MT8192_TOP_AXI_PROT_EN_2_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_1_MFG1,
+					  MT8192_TOP_AXI_PROT_EN_1_SET,
+					  MT8192_TOP_AXI_PROT_EN_1_CLR,
+					  MT8192_TOP_AXI_PROT_EN_1_STA1),
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_2_MFG1,
+					  MT8192_TOP_AXI_PROT_EN_2_SET,
+					  MT8192_TOP_AXI_PROT_EN_2_CLR,
+					  MT8192_TOP_AXI_PROT_EN_2_STA1),
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_MFG1,
+					  MT8192_TOP_AXI_PROT_EN_SET,
+					  MT8192_TOP_AXI_PROT_EN_CLR,
+					  MT8192_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_2_MFG1_2ND,
+					  MT8192_TOP_AXI_PROT_EN_2_SET,
+					  MT8192_TOP_AXI_PROT_EN_2_CLR,
+					  MT8192_TOP_AXI_PROT_EN_2_STA1),
 		},
 		.caps = MTK_SCPD_DOMAIN_SUPPLY,
 	},
@@ -141,27 +141,27 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8192_TOP_AXI_PROT_EN_MM_DISP,
-					MT8192_TOP_AXI_PROT_EN_MM_SET,
-					MT8192_TOP_AXI_PROT_EN_MM_CLR,
-					MT8192_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR_IGN(MT8192_TOP_AXI_PROT_EN_MM_2_DISP,
-					MT8192_TOP_AXI_PROT_EN_MM_2_SET,
-					MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
-					MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_DISP,
-				    MT8192_TOP_AXI_PROT_EN_SET,
-				    MT8192_TOP_AXI_PROT_EN_CLR,
-				    MT8192_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_DISP_2ND,
-				    MT8192_TOP_AXI_PROT_EN_MM_SET,
-				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_2_DISP_2ND,
-				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR_IGN(MT8192_TOP_AXI_PROT_EN_MM_DISP,
+					      MT8192_TOP_AXI_PROT_EN_MM_SET,
+					      MT8192_TOP_AXI_PROT_EN_MM_CLR,
+					      MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR_IGN(MT8192_TOP_AXI_PROT_EN_MM_2_DISP,
+					      MT8192_TOP_AXI_PROT_EN_MM_2_SET,
+					      MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
+					      MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_DISP,
+					  MT8192_TOP_AXI_PROT_EN_SET,
+					  MT8192_TOP_AXI_PROT_EN_CLR,
+					  MT8192_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_MM_DISP_2ND,
+					  MT8192_TOP_AXI_PROT_EN_MM_SET,
+					  MT8192_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_MM_2_DISP_2ND,
+					  MT8192_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
 		},
 	},
 	[MT8192_POWER_DOMAIN_IPE] = {
@@ -172,15 +172,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_IPE,
-				    MT8192_TOP_AXI_PROT_EN_MM_SET,
-				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_IPE_2ND,
-				    MT8192_TOP_AXI_PROT_EN_MM_SET,
-				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_MM_IPE,
+					  MT8192_TOP_AXI_PROT_EN_MM_SET,
+					  MT8192_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_MM_IPE_2ND,
+					  MT8192_TOP_AXI_PROT_EN_MM_SET,
+					  MT8192_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8192_TOP_AXI_PROT_EN_MM_STA1),
 		},
 	},
 	[MT8192_POWER_DOMAIN_ISP] = {
@@ -191,15 +191,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_2_ISP,
-				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_2_ISP_2ND,
-				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_MM_2_ISP,
+					  MT8192_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_MM_2_ISP_2ND,
+					  MT8192_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
 		},
 	},
 	[MT8192_POWER_DOMAIN_ISP2] = {
@@ -210,15 +210,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_ISP2,
-				    MT8192_TOP_AXI_PROT_EN_MM_SET,
-				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_ISP2_2ND,
-				    MT8192_TOP_AXI_PROT_EN_MM_SET,
-				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_MM_ISP2,
+					  MT8192_TOP_AXI_PROT_EN_MM_SET,
+					  MT8192_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_MM_ISP2_2ND,
+					  MT8192_TOP_AXI_PROT_EN_MM_SET,
+					  MT8192_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8192_TOP_AXI_PROT_EN_MM_STA1),
 		},
 	},
 	[MT8192_POWER_DOMAIN_MDP] = {
@@ -229,15 +229,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_2_MDP,
-				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_2_MDP_2ND,
-				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_MM_2_MDP,
+					  MT8192_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_MM_2_MDP_2ND,
+					  MT8192_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
 		},
 	},
 	[MT8192_POWER_DOMAIN_VENC] = {
@@ -248,15 +248,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_VENC,
-				    MT8192_TOP_AXI_PROT_EN_MM_SET,
-				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_VENC_2ND,
-				    MT8192_TOP_AXI_PROT_EN_MM_SET,
-				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_MM_VENC,
+					  MT8192_TOP_AXI_PROT_EN_MM_SET,
+					  MT8192_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_MM_VENC_2ND,
+					  MT8192_TOP_AXI_PROT_EN_MM_SET,
+					  MT8192_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8192_TOP_AXI_PROT_EN_MM_STA1),
 		},
 	},
 	[MT8192_POWER_DOMAIN_VDEC] = {
@@ -267,15 +267,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_VDEC,
-				    MT8192_TOP_AXI_PROT_EN_MM_SET,
-				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_VDEC_2ND,
-				    MT8192_TOP_AXI_PROT_EN_MM_SET,
-				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_MM_VDEC,
+					  MT8192_TOP_AXI_PROT_EN_MM_SET,
+					  MT8192_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_MM_VDEC_2ND,
+					  MT8192_TOP_AXI_PROT_EN_MM_SET,
+					  MT8192_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8192_TOP_AXI_PROT_EN_MM_STA1),
 		},
 	},
 	[MT8192_POWER_DOMAIN_VDEC2] = {
@@ -295,27 +295,27 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_2_CAM,
-				    MT8192_TOP_AXI_PROT_EN_2_SET,
-				    MT8192_TOP_AXI_PROT_EN_2_CLR,
-				    MT8192_TOP_AXI_PROT_EN_2_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_CAM,
-				    MT8192_TOP_AXI_PROT_EN_MM_SET,
-				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_1_CAM,
-				    MT8192_TOP_AXI_PROT_EN_1_SET,
-				    MT8192_TOP_AXI_PROT_EN_1_CLR,
-				    MT8192_TOP_AXI_PROT_EN_1_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_CAM_2ND,
-				    MT8192_TOP_AXI_PROT_EN_MM_SET,
-				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_VDNR_CAM,
-				    MT8192_TOP_AXI_PROT_EN_VDNR_SET,
-				    MT8192_TOP_AXI_PROT_EN_VDNR_CLR,
-				    MT8192_TOP_AXI_PROT_EN_VDNR_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_2_CAM,
+					  MT8192_TOP_AXI_PROT_EN_2_SET,
+					  MT8192_TOP_AXI_PROT_EN_2_CLR,
+					  MT8192_TOP_AXI_PROT_EN_2_STA1),
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_MM_CAM,
+					  MT8192_TOP_AXI_PROT_EN_MM_SET,
+					  MT8192_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_1_CAM,
+					  MT8192_TOP_AXI_PROT_EN_1_SET,
+					  MT8192_TOP_AXI_PROT_EN_1_CLR,
+					  MT8192_TOP_AXI_PROT_EN_1_STA1),
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_MM_CAM_2ND,
+					  MT8192_TOP_AXI_PROT_EN_MM_SET,
+					  MT8192_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8192_TOP_AXI_PROT_EN_VDNR_CAM,
+					  MT8192_TOP_AXI_PROT_EN_VDNR_SET,
+					  MT8192_TOP_AXI_PROT_EN_VDNR_CLR,
+					  MT8192_TOP_AXI_PROT_EN_VDNR_STA1),
 		},
 	},
 	[MT8192_POWER_DOMAIN_CAM_RAWA] = {
diff --git a/drivers/soc/mediatek/mt8195-pm-domains.h b/drivers/soc/mediatek/mt8195-pm-domains.h
index d7387ea1b9c9..8360d79bc1b4 100644
--- a/drivers/soc/mediatek/mt8195-pm-domains.h
+++ b/drivers/soc/mediatek/mt8195-pm-domains.h
@@ -23,15 +23,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x178,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VDNR_PCIE_MAC_P0,
-				    MT8195_TOP_AXI_PROT_EN_VDNR_SET,
-				    MT8195_TOP_AXI_PROT_EN_VDNR_CLR,
-				    MT8195_TOP_AXI_PROT_EN_VDNR_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VDNR_1_PCIE_MAC_P0,
-				    MT8195_TOP_AXI_PROT_EN_VDNR_1_SET,
-				    MT8195_TOP_AXI_PROT_EN_VDNR_1_CLR,
-				    MT8195_TOP_AXI_PROT_EN_VDNR_1_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_VDNR_PCIE_MAC_P0,
+					  MT8195_TOP_AXI_PROT_EN_VDNR_SET,
+					  MT8195_TOP_AXI_PROT_EN_VDNR_CLR,
+					  MT8195_TOP_AXI_PROT_EN_VDNR_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_VDNR_1_PCIE_MAC_P0,
+					  MT8195_TOP_AXI_PROT_EN_VDNR_1_SET,
+					  MT8195_TOP_AXI_PROT_EN_VDNR_1_CLR,
+					  MT8195_TOP_AXI_PROT_EN_VDNR_1_STA1),
 		},
 	},
 	[MT8195_POWER_DOMAIN_PCIE_MAC_P1] = {
@@ -42,15 +42,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x178,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VDNR_PCIE_MAC_P1,
-				    MT8195_TOP_AXI_PROT_EN_VDNR_SET,
-				    MT8195_TOP_AXI_PROT_EN_VDNR_CLR,
-				    MT8195_TOP_AXI_PROT_EN_VDNR_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VDNR_1_PCIE_MAC_P1,
-				    MT8195_TOP_AXI_PROT_EN_VDNR_1_SET,
-				    MT8195_TOP_AXI_PROT_EN_VDNR_1_CLR,
-				    MT8195_TOP_AXI_PROT_EN_VDNR_1_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_VDNR_PCIE_MAC_P1,
+					  MT8195_TOP_AXI_PROT_EN_VDNR_SET,
+					  MT8195_TOP_AXI_PROT_EN_VDNR_CLR,
+					  MT8195_TOP_AXI_PROT_EN_VDNR_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_VDNR_1_PCIE_MAC_P1,
+					  MT8195_TOP_AXI_PROT_EN_VDNR_1_SET,
+					  MT8195_TOP_AXI_PROT_EN_VDNR_1_CLR,
+					  MT8195_TOP_AXI_PROT_EN_VDNR_1_STA1),
 		},
 	},
 	[MT8195_POWER_DOMAIN_PCIE_PHY] = {
@@ -95,11 +95,11 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_2_ADSP,
-				    MT8195_TOP_AXI_PROT_EN_2_SET,
-				    MT8195_TOP_AXI_PROT_EN_2_CLR,
-				    MT8195_TOP_AXI_PROT_EN_2_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_2_ADSP,
+					  MT8195_TOP_AXI_PROT_EN_2_SET,
+					  MT8195_TOP_AXI_PROT_EN_2_CLR,
+					  MT8195_TOP_AXI_PROT_EN_2_STA1),
 		},
 		.caps = MTK_SCPD_SRAM_ISO | MTK_SCPD_ACTIVE_WAKEUP,
 	},
@@ -111,11 +111,11 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_2_AUDIO,
-				    MT8195_TOP_AXI_PROT_EN_2_SET,
-				    MT8195_TOP_AXI_PROT_EN_2_CLR,
-				    MT8195_TOP_AXI_PROT_EN_2_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_2_AUDIO,
+					  MT8195_TOP_AXI_PROT_EN_2_SET,
+					  MT8195_TOP_AXI_PROT_EN_2_CLR,
+					  MT8195_TOP_AXI_PROT_EN_2_STA1),
 		},
 	},
 	[MT8195_POWER_DOMAIN_MFG0] = {
@@ -136,31 +136,31 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x178,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MFG1,
-				    MT8195_TOP_AXI_PROT_EN_SET,
-				    MT8195_TOP_AXI_PROT_EN_CLR,
-				    MT8195_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_2_MFG1,
-				    MT8195_TOP_AXI_PROT_EN_2_SET,
-				    MT8195_TOP_AXI_PROT_EN_2_CLR,
-				    MT8195_TOP_AXI_PROT_EN_2_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_1_MFG1,
-				    MT8195_TOP_AXI_PROT_EN_1_SET,
-				    MT8195_TOP_AXI_PROT_EN_1_CLR,
-				    MT8195_TOP_AXI_PROT_EN_1_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_2_MFG1_2ND,
-				    MT8195_TOP_AXI_PROT_EN_2_SET,
-				    MT8195_TOP_AXI_PROT_EN_2_CLR,
-				    MT8195_TOP_AXI_PROT_EN_2_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MFG1_2ND,
-				    MT8195_TOP_AXI_PROT_EN_SET,
-				    MT8195_TOP_AXI_PROT_EN_CLR,
-				    MT8195_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MFG1,
-				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
-				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
-				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MFG1,
+					  MT8195_TOP_AXI_PROT_EN_SET,
+					  MT8195_TOP_AXI_PROT_EN_CLR,
+					  MT8195_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_2_MFG1,
+					  MT8195_TOP_AXI_PROT_EN_2_SET,
+					  MT8195_TOP_AXI_PROT_EN_2_CLR,
+					  MT8195_TOP_AXI_PROT_EN_2_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_1_MFG1,
+					  MT8195_TOP_AXI_PROT_EN_1_SET,
+					  MT8195_TOP_AXI_PROT_EN_1_CLR,
+					  MT8195_TOP_AXI_PROT_EN_1_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_2_MFG1_2ND,
+					  MT8195_TOP_AXI_PROT_EN_2_SET,
+					  MT8195_TOP_AXI_PROT_EN_2_CLR,
+					  MT8195_TOP_AXI_PROT_EN_2_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MFG1_2ND,
+					  MT8195_TOP_AXI_PROT_EN_SET,
+					  MT8195_TOP_AXI_PROT_EN_CLR,
+					  MT8195_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MFG1,
+					  MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
+					  MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
+					  MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
 	},
@@ -222,27 +222,27 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VPPSYS0,
-				    MT8195_TOP_AXI_PROT_EN_SET,
-				    MT8195_TOP_AXI_PROT_EN_CLR,
-				    MT8195_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VPPSYS0,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VPPSYS0_2ND,
-				    MT8195_TOP_AXI_PROT_EN_SET,
-				    MT8195_TOP_AXI_PROT_EN_CLR,
-				    MT8195_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VPPSYS0_2ND,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VPPSYS0,
-				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
-				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
-				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_VPPSYS0,
+					  MT8195_TOP_AXI_PROT_EN_SET,
+					  MT8195_TOP_AXI_PROT_EN_CLR,
+					  MT8195_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VPPSYS0,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_VPPSYS0_2ND,
+					  MT8195_TOP_AXI_PROT_EN_SET,
+					  MT8195_TOP_AXI_PROT_EN_CLR,
+					  MT8195_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VPPSYS0_2ND,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VPPSYS0,
+					  MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
+					  MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
+					  MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1),
 		},
 	},
 	[MT8195_POWER_DOMAIN_VDOSYS0] = {
@@ -253,19 +253,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VDOSYS0,
-				    MT8195_TOP_AXI_PROT_EN_MM_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VDOSYS0,
-				    MT8195_TOP_AXI_PROT_EN_SET,
-				    MT8195_TOP_AXI_PROT_EN_CLR,
-				    MT8195_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VDOSYS0,
-				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
-				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
-				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_VDOSYS0,
+					  MT8195_TOP_AXI_PROT_EN_MM_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_VDOSYS0,
+					  MT8195_TOP_AXI_PROT_EN_SET,
+					  MT8195_TOP_AXI_PROT_EN_CLR,
+					  MT8195_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VDOSYS0,
+					  MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
+					  MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
+					  MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1),
 		},
 	},
 	[MT8195_POWER_DOMAIN_VPPSYS1] = {
@@ -276,19 +276,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VPPSYS1,
-				    MT8195_TOP_AXI_PROT_EN_MM_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VPPSYS1_2ND,
-				    MT8195_TOP_AXI_PROT_EN_MM_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VPPSYS1,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_VPPSYS1,
+					  MT8195_TOP_AXI_PROT_EN_MM_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_VPPSYS1_2ND,
+					  MT8195_TOP_AXI_PROT_EN_MM_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VPPSYS1,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
 		},
 	},
 	[MT8195_POWER_DOMAIN_VDOSYS1] = {
@@ -299,19 +299,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VDOSYS1,
-				    MT8195_TOP_AXI_PROT_EN_MM_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VDOSYS1_2ND,
-				    MT8195_TOP_AXI_PROT_EN_MM_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VDOSYS1,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_VDOSYS1,
+					  MT8195_TOP_AXI_PROT_EN_MM_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_VDOSYS1_2ND,
+					  MT8195_TOP_AXI_PROT_EN_MM_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VDOSYS1,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
 		},
 	},
 	[MT8195_POWER_DOMAIN_DP_TX] = {
@@ -322,11 +322,11 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VDNR_1_DP_TX,
-				    MT8195_TOP_AXI_PROT_EN_VDNR_1_SET,
-				    MT8195_TOP_AXI_PROT_EN_VDNR_1_CLR,
-				    MT8195_TOP_AXI_PROT_EN_VDNR_1_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_VDNR_1_DP_TX,
+					  MT8195_TOP_AXI_PROT_EN_VDNR_1_SET,
+					  MT8195_TOP_AXI_PROT_EN_VDNR_1_CLR,
+					  MT8195_TOP_AXI_PROT_EN_VDNR_1_STA1),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -338,11 +338,11 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VDNR_1_EPD_TX,
-				    MT8195_TOP_AXI_PROT_EN_VDNR_1_SET,
-				    MT8195_TOP_AXI_PROT_EN_VDNR_1_CLR,
-				    MT8195_TOP_AXI_PROT_EN_VDNR_1_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_VDNR_1_EPD_TX,
+					  MT8195_TOP_AXI_PROT_EN_VDNR_1_SET,
+					  MT8195_TOP_AXI_PROT_EN_VDNR_1_CLR,
+					  MT8195_TOP_AXI_PROT_EN_VDNR_1_STA1),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -364,19 +364,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_WPESYS,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_WPESYS,
-				    MT8195_TOP_AXI_PROT_EN_MM_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_WPESYS_2ND,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_2_WPESYS,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_WPESYS,
+					  MT8195_TOP_AXI_PROT_EN_MM_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_2_WPESYS_2ND,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
 		},
 	},
 	[MT8195_POWER_DOMAIN_VDEC0] = {
@@ -387,23 +387,23 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VDEC0,
-				    MT8195_TOP_AXI_PROT_EN_MM_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VDEC0,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VDEC0_2ND,
-				    MT8195_TOP_AXI_PROT_EN_MM_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VDEC0_2ND,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_VDEC0,
+					  MT8195_TOP_AXI_PROT_EN_MM_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VDEC0,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_VDEC0_2ND,
+					  MT8195_TOP_AXI_PROT_EN_MM_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VDEC0_2ND,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -415,15 +415,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VDEC1,
-				    MT8195_TOP_AXI_PROT_EN_MM_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VDEC1_2ND,
-				    MT8195_TOP_AXI_PROT_EN_MM_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_VDEC1,
+					  MT8195_TOP_AXI_PROT_EN_MM_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_VDEC1_2ND,
+					  MT8195_TOP_AXI_PROT_EN_MM_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_STA1),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -435,15 +435,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VDEC2,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VDEC2_2ND,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VDEC2,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VDEC2_2ND,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -455,19 +455,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VENC,
-				    MT8195_TOP_AXI_PROT_EN_MM_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VENC_2ND,
-				    MT8195_TOP_AXI_PROT_EN_MM_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VENC,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_VENC,
+					  MT8195_TOP_AXI_PROT_EN_MM_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_VENC_2ND,
+					  MT8195_TOP_AXI_PROT_EN_MM_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VENC,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -479,15 +479,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VENC_CORE1,
-				    MT8195_TOP_AXI_PROT_EN_MM_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VENC_CORE1,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_VENC_CORE1,
+					  MT8195_TOP_AXI_PROT_EN_MM_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VENC_CORE1,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -499,15 +499,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_IMG,
-				    MT8195_TOP_AXI_PROT_EN_MM_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_IMG_2ND,
-				    MT8195_TOP_AXI_PROT_EN_MM_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_IMG,
+					  MT8195_TOP_AXI_PROT_EN_MM_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_IMG_2ND,
+					  MT8195_TOP_AXI_PROT_EN_MM_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_STA1),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -529,15 +529,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_IPE,
-				    MT8195_TOP_AXI_PROT_EN_MM_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_IPE,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_IPE,
+					  MT8195_TOP_AXI_PROT_EN_MM_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_2_IPE,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -549,27 +549,27 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_2_CAM,
-				    MT8195_TOP_AXI_PROT_EN_2_SET,
-				    MT8195_TOP_AXI_PROT_EN_2_CLR,
-				    MT8195_TOP_AXI_PROT_EN_2_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_CAM,
-				    MT8195_TOP_AXI_PROT_EN_MM_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_1_CAM,
-				    MT8195_TOP_AXI_PROT_EN_1_SET,
-				    MT8195_TOP_AXI_PROT_EN_1_CLR,
-				    MT8195_TOP_AXI_PROT_EN_1_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_CAM_2ND,
-				    MT8195_TOP_AXI_PROT_EN_MM_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_CAM,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
-				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_2_CAM,
+					  MT8195_TOP_AXI_PROT_EN_2_SET,
+					  MT8195_TOP_AXI_PROT_EN_2_CLR,
+					  MT8195_TOP_AXI_PROT_EN_2_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_CAM,
+					  MT8195_TOP_AXI_PROT_EN_MM_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_1_CAM,
+					  MT8195_TOP_AXI_PROT_EN_1_SET,
+					  MT8195_TOP_AXI_PROT_EN_1_CLR,
+					  MT8195_TOP_AXI_PROT_EN_1_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_CAM_2ND,
+					  MT8195_TOP_AXI_PROT_EN_MM_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_INFRA_WR(MT8195_TOP_AXI_PROT_EN_MM_2_CAM,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+					  MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 69dc24a73ce9..3cdf62c0b6bd 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -118,9 +118,19 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
 					MTK_POLL_TIMEOUT);
 }
 
-static int scpsys_bus_protect_clear(const struct scpsys_bus_prot_data *bpd,
-				    struct regmap *regmap)
+static struct regmap *scpsys_bus_protect_get_regmap(struct scpsys_domain *pd,
+						    const struct scpsys_bus_prot_data *bpd)
 {
+	if (bpd->flags & BUS_PROT_COMPONENT_SMI)
+		return pd->smi;
+	else
+		return pd->infracfg;
+}
+
+static int scpsys_bus_protect_clear(struct scpsys_domain *pd,
+				    const struct scpsys_bus_prot_data *bpd)
+{
+	struct regmap *regmap = scpsys_bus_protect_get_regmap(pd, bpd);
 	u32 val;
 	u32 sta_mask = bpd->bus_prot_sta_mask;
 
@@ -137,9 +147,10 @@ static int scpsys_bus_protect_clear(const struct scpsys_bus_prot_data *bpd,
 					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 }
 
-static int scpsys_bus_protect_set(const struct scpsys_bus_prot_data *bpd,
-				  struct regmap *regmap)
+static int scpsys_bus_protect_set(struct scpsys_domain *pd,
+				  const struct scpsys_bus_prot_data *bpd)
 {
+	struct regmap *regmap = scpsys_bus_protect_get_regmap(pd, bpd);
 	u32 val;
 	u32 sta_mask = bpd->bus_prot_sta_mask;
 
@@ -153,15 +164,16 @@ static int scpsys_bus_protect_set(const struct scpsys_bus_prot_data *bpd,
 					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 }
 
-static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, struct regmap *regmap)
+static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
 {
-	int i, ret;
+	for (int i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
+		const struct scpsys_bus_prot_data *bpd = &pd->data->bp_cfg[i];
+		int ret;
 
-	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
-		if (!bpd[i].bus_prot_set_clr_mask)
+		if (!bpd->bus_prot_set_clr_mask)
 			break;
 
-		ret = scpsys_bus_protect_set(&bpd[i], regmap);
+		ret = scpsys_bus_protect_set(pd, bpd);
 		if (ret)
 			return ret;
 	}
@@ -169,27 +181,16 @@ static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, st
 	return 0;
 }
 
-static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
-{
-	int ret;
-
-	ret = _scpsys_bus_protect_enable(pd->data->bp_infracfg, pd->infracfg);
-	if (ret)
-		return ret;
-
-	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi);
-}
-
-static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
-				       struct regmap *regmap)
+static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
 {
-	int i, ret;
+	for (int i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
+		const struct scpsys_bus_prot_data *bpd = &pd->data->bp_cfg[i];
+		int ret;
 
-	for (i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
-		if (!bpd[i].bus_prot_set_clr_mask)
+		if (!bpd->bus_prot_set_clr_mask)
 			continue;
 
-		ret = scpsys_bus_protect_clear(&bpd[i], regmap);
+		ret = scpsys_bus_protect_clear(pd, bpd);
 		if (ret)
 			return ret;
 	}
@@ -197,17 +198,6 @@ static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
 	return 0;
 }
 
-static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
-{
-	int ret;
-
-	ret = _scpsys_bus_protect_disable(pd->data->bp_smi, pd->smi);
-	if (ret)
-		return ret;
-
-	return _scpsys_bus_protect_disable(pd->data->bp_infracfg, pd->infracfg);
-}
-
 static int scpsys_regulator_enable(struct regulator *supply)
 {
 	return supply ? regulator_enable(supply) : 0;
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index 4b6ae56e7c95..356788263db2 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -45,6 +45,8 @@
 enum scpsys_bus_prot_flags {
 	BUS_PROT_REG_UPDATE = BIT(1),
 	BUS_PROT_IGNORE_CLR_ACK = BIT(2),
+	BUS_PROT_COMPONENT_INFRA = BIT(3),
+	BUS_PROT_COMPONENT_SMI = BIT(4),
 };
 
 #define _BUS_PROT(_set_clr_mask, _set, _clr, _sta_mask, _sta, _flags) {	\
@@ -56,17 +58,30 @@ enum scpsys_bus_prot_flags {
 		.flags = _flags					\
 	}
 
-#define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
-		_BUS_PROT(_mask, _set, _clr, _mask, _sta, 0)
+#define BUS_PROT_INFRA_WR(_mask, _set, _clr, _sta) \
+		_BUS_PROT(_mask, _set, _clr, _mask, _sta, BUS_PROT_COMPONENT_INFRA)
 
-#define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
-		_BUS_PROT(_mask, _set, _clr, _mask, _sta, BUS_PROT_IGNORE_CLR_ACK)
+#define BUS_PROT_INFRA_WR_IGN(_mask, _set, _clr, _sta) \
+		_BUS_PROT(_mask, _set, _clr, _mask, _sta, \
+			  BUS_PROT_COMPONENT_INFRA | BUS_PROT_IGNORE_CLR_ACK)
 
-#define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
-		_BUS_PROT(_mask, _set, _clr, _mask, _sta, BUS_PROT_REG_UPDATE)
+#define BUS_PROT_INFRA_UPDATE(_mask, _set, _clr, _sta) \
+		_BUS_PROT(_mask, _set, _clr, _mask, _sta, \
+			  BUS_PROT_COMPONENT_INFRA | BUS_PROT_REG_UPDATE)
 
-#define BUS_PROT_UPDATE_TOPAXI(_mask)				\
-		BUS_PROT_UPDATE(_mask,				\
+#define BUS_PROT_SMI_WR(_mask, _set, _clr, _sta) \
+		_BUS_PROT(_mask, _set, _clr, _mask, _sta, BUS_PROT_COMPONENT_SMI)
+
+#define BUS_PROT_SMI_WR_IGN(_mask, _set, _clr, _sta) \
+		_BUS_PROT(_mask, _set, _clr, _mask, _sta, \
+			  BUS_PROT_COMPONENT_SMI | BUS_PROT_IGNORE_CLR_ACK)
+
+#define BUS_PROT_SMI_UPDATE(_mask, _set, _clr, _sta) \
+		_BUS_PROT(_mask, _set, _clr, _mask, _sta, \
+			  BUS_PROT_COMPONENT_SMI | BUS_PROT_REG_UPDATE)
+
+#define BUS_PROT_INFRA_UPDATE_TOPAXI(_mask)				\
+		BUS_PROT_INFRA_UPDATE(_mask,				\
 				INFRA_TOPAXI_PROTECTEN,		\
 				INFRA_TOPAXI_PROTECTEN,		\
 				INFRA_TOPAXI_PROTECTSTA1)
@@ -90,8 +105,7 @@ struct scpsys_bus_prot_data {
  * @ext_buck_iso_offs: The offset for external buck isolation
  * @ext_buck_iso_mask: The mask for external buck isolation
  * @caps: The flag for active wake-up action.
- * @bp_infracfg: bus protection for infracfg subsystem
- * @bp_smi: bus protection for smi subsystem
+ * @bp_cfg: bus protection configuration for any subsystem
  */
 struct scpsys_domain_data {
 	const char *name;
@@ -102,8 +116,7 @@ struct scpsys_domain_data {
 	int ext_buck_iso_offs;
 	u32 ext_buck_iso_mask;
 	u8 caps;
-	const struct scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
-	const struct scpsys_bus_prot_data bp_smi[SPM_MAX_BUS_PROT_DATA];
+	const struct scpsys_bus_prot_data bp_cfg[SPM_MAX_BUS_PROT_DATA];
 	int pwr_sta_offs;
 	int pwr_sta2nd_offs;
 };
-- 
2.40.1

