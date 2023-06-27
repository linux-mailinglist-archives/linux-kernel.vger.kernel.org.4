Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9B273FC96
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjF0NLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjF0NLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:11:10 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CA32956
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:11:01 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fba66f3b14so6286775e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687871459; x=1690463459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJUEvqPoFHkc+t8zpcT7RXTO9MzNPX3an+ITJWOHWUY=;
        b=g5Smmpn6JhxRQcipgOvKykZrvCKN1rTz39bH0no04tfgIQ0+BmgxdCacWFiEfdiAMx
         Yue7Rh+UWNAXQEnckXdBcRfSZ+q+GZXgJGQg27uBW8GCZoFowKPABolpTBfuy1JFtd06
         9+ygMs8ZRldqjPLVRbg2fR3CCxMHmnWqXzzIN0Vk76mJ+ox/rnS5yLP09AlBK3p5bm61
         kF79PNnU6ItCavsI0LxmpbbE+YzoiJ7fQJosSe/R64RpDo5mAbNpYXs9wsDRMSw3SLhW
         1Vnsk+GNHSiMqOKnYfpl+Ek80ghe/Tl88dI3pzzxm5wZv8popO4YlC5RVI8PldDlmSI0
         lsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687871459; x=1690463459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJUEvqPoFHkc+t8zpcT7RXTO9MzNPX3an+ITJWOHWUY=;
        b=PHyuyVozMNtsSpHRKiyg2/w5jl/k6T615uiqL0DZkdwT1ATTbYO/TzfBm/bi+FBBZA
         dji7/npFUnb2wIbkINFzu8Ia3JNPHYd8oR1MxtOyZDgjYvmHGdJYS6nqJtAgkZiScwoO
         +t4HcmmzA1jq/qcHJU6xNyEfukYBSfBKPMRavNXzK0fPt9nrlkiKGs5bwpfMjonRHcj0
         +/SeyOE6lu6qjOxe/a8HDSsR/EhykOF4W1FbbSfMX/wZoeGiLaIYMoQM5oe/FahRko/I
         XHw+bBa4rkQKHpYTGOWGHzsyNBgm9tYbOZ3JDSWGz+7EBeAEojIz+SzQL6de5Fc4QBFX
         wJCQ==
X-Gm-Message-State: AC+VfDyHpyvhOgQjrZO4lgWOGxWaCPZzJQby/sV3C26PRecpwZyvYYr6
        N++yoalUdJPCZIvEgx9hjoiQ/g==
X-Google-Smtp-Source: ACHHUZ5rNY3dhMymiwV5hnF4JUKE28KTcpMERwXjXGREY9L8BEdPcVH0sSVpYTCPQu3WejayjZ8wkQ==
X-Received: by 2002:a05:600c:2903:b0:3fa:7fa9:4f9a with SMTP id i3-20020a05600c290300b003fa7fa94f9amr10006480wmd.16.1687871459632;
        Tue, 27 Jun 2023 06:10:59 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id z26-20020a1c4c1a000000b003f91e32b1ebsm1403196wmf.17.2023.06.27.06.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 06:10:59 -0700 (PDT)
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
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v6 8/8] soc: mediatek: pm-domains: Add support for MT8365
Date:   Tue, 27 Jun 2023 15:10:40 +0200
Message-Id: <20230627131040.3418538-9-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627131040.3418538-1-msp@baylibre.com>
References: <20230627131040.3418538-1-msp@baylibre.com>
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

From: Fabien Parent <fparent@baylibre.com>

Add the needed board data to support MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/soc/mediatek/mt8365-pm-domains.h | 197 +++++++++++++++++++++++
 drivers/soc/mediatek/mtk-pm-domains.c    |   5 +
 include/linux/soc/mediatek/infracfg.h    |  41 +++++
 3 files changed, 243 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt8365-pm-domains.h

diff --git a/drivers/soc/mediatek/mt8365-pm-domains.h b/drivers/soc/mediatek/mt8365-pm-domains.h
new file mode 100644
index 000000000000..3d83d49eaa7c
--- /dev/null
+++ b/drivers/soc/mediatek/mt8365-pm-domains.h
@@ -0,0 +1,197 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SOC_MEDIATEK_MT8365_PM_DOMAINS_H
+#define __SOC_MEDIATEK_MT8365_PM_DOMAINS_H
+
+#include "mtk-pm-domains.h"
+#include <dt-bindings/power/mediatek,mt8365-power.h>
+
+/*
+ * MT8365 power domain support
+ */
+
+#define MT8365_BUS_PROT_INFRA_WR_TOPAXI(_mask)				\
+		BUS_PROT_WR(INFRA, _mask,				\
+			    MT8365_INFRA_TOPAXI_PROTECTEN_SET,		\
+			    MT8365_INFRA_TOPAXI_PROTECTEN_CLR,		\
+			    MT8365_INFRA_TOPAXI_PROTECTEN_STA1)
+
+#define MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(_mask)			\
+		BUS_PROT_WR(INFRA, _mask,				\
+			    MT8365_INFRA_TOPAXI_PROTECTEN_1_SET,	\
+			    MT8365_INFRA_TOPAXI_PROTECTEN_1_CLR,	\
+			    MT8365_INFRA_TOPAXI_PROTECTEN_1_STA1)
+
+#define MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(port)			\
+		BUS_PROT_WR(SMI, BIT(port),				\
+			    MT8365_SMI_COMMON_CLAMP_EN_SET,		\
+			    MT8365_SMI_COMMON_CLAMP_EN_CLR,		\
+			    MT8365_SMI_COMMON_CLAMP_EN)
+
+#define MT8365_BUS_PROT_WAY_EN(_set_mask, _set, _sta_mask, _sta)	\
+		_BUS_PROT(_set_mask, _set, _set, _sta_mask, _sta,	\
+			  BUS_PROT_COMPONENT_INFRA |			\
+			  BUS_PROT_STA_COMPONENT_INFRA_NAO |		\
+			  BUS_PROT_INVERTED |				\
+			  BUS_PROT_REG_UPDATE)
+
+static const struct scpsys_domain_data scpsys_domain_data_mt8365[] = {
+	[MT8365_POWER_DOMAIN_MM] = {
+		.name = "mm",
+		.sta_mask = PWR_STATUS_DISP,
+		.ctl_offs = 0x30c,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_0 |
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_1),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_MM_M0 |
+				MT8365_INFRA_TOPAXI_PROTECTEN_MDMCU_M1 |
+				MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_0 |
+				MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_1),
+			MT8365_BUS_PROT_WAY_EN(
+				MT8365_INFRA_TOPAXI_SI0_WAY_EN_MMAPB_S,
+				MT8365_INFRA_TOPAXI_SI0_CTL,
+				MT8365_INFRA_NAO_TOPAXI_SI0_CTRL_UPDATED,
+				MT8365_INFRA_NAO_TOPAXI_SI0_STA),
+			MT8365_BUS_PROT_WAY_EN(
+				MT8365_INFRA_TOPAXI_SI2_WAY_EN_PERI_M1,
+				MT8365_INFRA_TOPAXI_SI2_CTL,
+				MT8365_INFRA_NAO_TOPAXI_SI2_CTRL_UPDATED,
+				MT8365_INFRA_NAO_TOPAXI_SI2_STA),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_MMAPB_S),
+		},
+		.caps = MTK_SCPD_STRICT_BUS_PROTECTION | MTK_SCPD_HAS_INFRA_NAO,
+	},
+	[MT8365_POWER_DOMAIN_VENC] = {
+		.name = "venc",
+		.sta_mask = PWR_STATUS_VENC,
+		.ctl_offs = 0x0304,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(1),
+		},
+	},
+	[MT8365_POWER_DOMAIN_AUDIO] = {
+		.name = "audio",
+		.sta_mask = PWR_STATUS_AUDIO,
+		.ctl_offs = 0x0314,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(12, 8),
+		.sram_pdn_ack_bits = GENMASK(17, 13),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_PWRDNREQ_MP1_L2C_AFIFO |
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_AUDIO_M),
+		},
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8365_POWER_DOMAIN_CONN] = {
+		.name = "conn",
+		.sta_mask = PWR_STATUS_CONN,
+		.ctl_offs = 0x032c,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = 0,
+		.sram_pdn_ack_bits = 0,
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_AP2CONN_AHB),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_CONN2INFRA_AXI_GALS_MST),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_CONN2INFRA_AHB),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_INFRA2CONN_AHB_GALS_SLV),
+		},
+		.caps = MTK_SCPD_ACTIVE_WAKEUP | MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8365_POWER_DOMAIN_MFG] = {
+		.name = "mfg",
+		.sta_mask = PWR_STATUS_MFG,
+		.ctl_offs = 0x0338,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(9, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(BIT(25)),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M0 |
+				MT8365_INFRA_TOPAXI_PROTECTEN_INFRA2MFG),
+		},
+	},
+	[MT8365_POWER_DOMAIN_CAM] = {
+		.name = "cam",
+		.sta_mask = BIT(25),
+		.ctl_offs = 0x0344,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(9, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_CAM2MM_AXI_GALS_MST),
+			MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(2),
+		},
+	},
+	[MT8365_POWER_DOMAIN_VDEC] = {
+		.name = "vdec",
+		.sta_mask = BIT(31),
+		.ctl_offs = 0x0370,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(3),
+		},
+	},
+	[MT8365_POWER_DOMAIN_APU] = {
+		.name = "apu",
+		.sta_mask = BIT(16),
+		.ctl_offs = 0x0378,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(14, 8),
+		.sram_pdn_ack_bits = GENMASK(21, 15),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_APU2AP |
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_APU_CBIP_GALS_MST),
+			MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(4),
+		},
+	},
+	[MT8365_POWER_DOMAIN_DSP] = {
+		.name = "dsp",
+		.sta_mask = BIT(17),
+		.ctl_offs = 0x037C,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_PWRDNREQ_INFRA_GALS_ADB |
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_M |
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_S),
+		},
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+};
+
+static const struct scpsys_soc_data mt8365_scpsys_data = {
+	.domains_data = scpsys_domain_data_mt8365,
+	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8365),
+};
+
+#endif /* __SOC_MEDIATEK_MT8365_PM_DOMAINS_H */
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 632285bf0d44..261367476488 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -24,6 +24,7 @@
 #include "mt8188-pm-domains.h"
 #include "mt8192-pm-domains.h"
 #include "mt8195-pm-domains.h"
+#include "mt8365-pm-domains.h"
 
 #define MTK_POLL_DELAY_US		10
 #define MTK_POLL_TIMEOUT		USEC_PER_SEC
@@ -652,6 +653,10 @@ static const struct of_device_id scpsys_of_match[] = {
 		.compatible = "mediatek,mt8195-power-controller",
 		.data = &mt8195_scpsys_data,
 	},
+	{
+		.compatible = "mediatek,mt8365-power-controller",
+		.data = &mt8365_scpsys_data,
+	},
 	{ }
 };
 
diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
index 07f67b3d8e97..f853397697b5 100644
--- a/include/linux/soc/mediatek/infracfg.h
+++ b/include/linux/soc/mediatek/infracfg.h
@@ -2,6 +2,47 @@
 #ifndef __SOC_MEDIATEK_INFRACFG_H
 #define __SOC_MEDIATEK_INFRACFG_H
 
+#define MT8365_INFRA_TOPAXI_PROTECTEN_STA1				0x228
+#define MT8365_INFRA_TOPAXI_PROTECTEN_SET				0x2a0
+#define MT8365_INFRA_TOPAXI_PROTECTEN_CLR				0x2a4
+# define MT8365_INFRA_TOPAXI_PROTECTEN_MM_M0				BIT(1)
+# define MT8365_INFRA_TOPAXI_PROTECTEN_MDMCU_M1				BIT(2)
+# define MT8365_INFRA_TOPAXI_PROTECTEN_MMAPB_S				BIT(6)
+# define MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_0		BIT(10)
+# define MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_1		BIT(11)
+# define MT8365_INFRA_TOPAXI_PROTECTEN_AP2CONN_AHB			BIT(13)
+# define MT8365_INFRA_TOPAXI_PROTECTEN_CONN2INFRA_AHB			BIT(14)
+# define MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M0				BIT(21)
+# define MT8365_INFRA_TOPAXI_PROTECTEN_INFRA2MFG			BIT(22)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_STA1				0x258
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_SET				0x2a8
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_CLR				0x2ac
+# define MT8365_INFRA_TOPAXI_PROTECTEN_1_APU2AP				BIT(2)
+# define MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_0	BIT(16)
+# define MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_1	BIT(17)
+# define MT8365_INFRA_TOPAXI_PROTECTEN_1_CONN2INFRA_AXI_GALS_MST	BIT(18)
+# define MT8365_INFRA_TOPAXI_PROTECTEN_1_CAM2MM_AXI_GALS_MST		BIT(19)
+# define MT8365_INFRA_TOPAXI_PROTECTEN_1_APU_CBIP_GALS_MST		BIT(20)
+# define MT8365_INFRA_TOPAXI_PROTECTEN_1_INFRA2CONN_AHB_GALS_SLV	BIT(21)
+# define MT8365_INFRA_TOPAXI_PROTECTEN_1_PWRDNREQ_INFRA_GALS_ADB	BIT(24)
+# define MT8365_INFRA_TOPAXI_PROTECTEN_1_PWRDNREQ_MP1_L2C_AFIFO		BIT(27)
+# define MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_AUDIO_M		BIT(28)
+# define MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_M		BIT(30)
+# define MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_S		BIT(31)
+
+#define MT8365_INFRA_NAO_TOPAXI_SI0_STA					0x0
+# define MT8365_INFRA_NAO_TOPAXI_SI0_CTRL_UPDATED			BIT(24)
+#define MT8365_INFRA_NAO_TOPAXI_SI2_STA					0x28
+# define MT8365_INFRA_NAO_TOPAXI_SI2_CTRL_UPDATED			BIT(14)
+#define MT8365_INFRA_TOPAXI_SI0_CTL					0x200
+# define MT8365_INFRA_TOPAXI_SI0_WAY_EN_MMAPB_S				BIT(6)
+#define MT8365_INFRA_TOPAXI_SI2_CTL					0x234
+# define MT8365_INFRA_TOPAXI_SI2_WAY_EN_PERI_M1				BIT(5)
+
+#define MT8365_SMI_COMMON_CLAMP_EN			0x3c0
+#define MT8365_SMI_COMMON_CLAMP_EN_SET			0x3c4
+#define MT8365_SMI_COMMON_CLAMP_EN_CLR			0x3c8
+
 #define MT8195_TOP_AXI_PROT_EN_STA1                     0x228
 #define MT8195_TOP_AXI_PROT_EN_1_STA1                   0x258
 #define MT8195_TOP_AXI_PROT_EN_SET			0x2a0
-- 
2.40.1

