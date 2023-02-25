Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B89F6A2898
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 10:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjBYJpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 04:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBYJo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 04:44:58 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EF112861;
        Sat, 25 Feb 2023 01:44:53 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id i34so6716990eda.7;
        Sat, 25 Feb 2023 01:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGOWTRLVEDUCucddLTbmkUQYiNE/Jmd74FP3Z6iTsOE=;
        b=HdAfUM3+Xk6xSrdPFcVV/6aZf7cbVCN46/OB1Xmjw8mDryF4HT1MjP5Q8T3SHtnOFl
         HSPl0hgbYzpvjOJbDWJV9AznPenosAwmY4AwSYErPbqqbJvs8Pxru+wJNXDPsn00UuxM
         7EyBcSLgcXgJ6gRSic20W8ZsKxOfJIgk1bLgrrvhxEfgV7UeCC3YvAkkbfxn6/NOekpt
         LBbuR5xtTGayxsvOzW4wrO28TsOiObWrNTF8CyrB4Y2okux2H8Ckoyyk/n8xsQiC0h/A
         l+86/SK76Hw26DIQPvVl+CZGAekaHBTa1T0uNKH4iCIIDI9/+Znx5vHzcEpsaK58ijAD
         7+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGOWTRLVEDUCucddLTbmkUQYiNE/Jmd74FP3Z6iTsOE=;
        b=SJ5Qq4GGTdn9kUaNskwtFbePYf38tW+gHc6oKu3ZvAyfAizqzLe0pT6kB1/6GfbGOZ
         MyjtEX1BeMNZeYZkiv4Qj5MXXSvilTPZiZRWXlS6GK5mA5M4TbMZgh4yIZ8xPMunSI8N
         IsOegCZ8045zPk7dF1G54YDQ/6cut/wduRfFZ8LZr0qT0CzSknI0eNLzwKil7k5zQk3+
         CQqLS1IJrLuyoEOQeAo3SyTQUJhjtiHjPpOcpbgFRoB7jxTmkb6EIC7sbgtN4K4oAL21
         aApZwrUA/ydxdFNDri5Df0MOyH30rlBzb1ghQ3mxdR/qTOyB9IFlkyMWkt9zTmDao0az
         lM9A==
X-Gm-Message-State: AO0yUKX+Q0zZkgT26JZuGck0tBJZQiq18S+OlnCVAl1Mn22CqZjVYDsR
        WjCvOii1eDvGNvi1/qt6DYA=
X-Google-Smtp-Source: AK7set9pPbyjz2YwHd5Pxs0+eAiz8IwCkaeXbgrW9Bc9AZpbU7+nWh+RmA3rXHFke1UG7UC9NoGh3g==
X-Received: by 2002:a17:906:7f8c:b0:8b0:fc14:bbcb with SMTP id f12-20020a1709067f8c00b008b0fc14bbcbmr21416314ejr.42.1677318291916;
        Sat, 25 Feb 2023 01:44:51 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.97])
        by smtp.gmail.com with ESMTPSA id va13-20020a17090711cd00b008b23b22b062sm653649ejb.114.2023.02.25.01.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 01:44:51 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Golle <daniel@makrotopia.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/4] dt-bindings: clock: Add MediaTek MT6735 clock bindings
Date:   Sat, 25 Feb 2023 12:42:43 +0300
Message-Id: <20230225094246.261697-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230225094246.261697-1-y.oudjana@protonmail.com>
References: <20230225094246.261697-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add clock definitions for the main clock controllers of MT6735 (apmixedsys,
topckgen, infracfg and pericfg).

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 MAINTAINERS                                   | 10 +++
 .../clock/mediatek,mt6735-apmixedsys.h        | 16 ++++
 .../clock/mediatek,mt6735-infracfg.h          | 25 ++++++
 .../clock/mediatek,mt6735-pericfg.h           | 37 +++++++++
 .../clock/mediatek,mt6735-topckgen.h          | 79 +++++++++++++++++++
 5 files changed, 167 insertions(+)
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-infracfg.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-pericfg.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-topckgen.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e2a35aebba0c..5323f71c48fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13101,6 +13101,16 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mmc/mtk-sd.yaml
 F:	drivers/mmc/host/mtk-sd.c
 
+MEDIATEK MT6735 CLOCK DRIVERS
+M:	Yassine Oudjana <y.oudjana@protonmail.com>
+L:	linux-clk@vger.kernel.org
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
+F:	include/dt-bindings/clock/mediatek,mt6735-infracfg.h
+F:	include/dt-bindings/clock/mediatek,mt6735-pericfg.h
+F:	include/dt-bindings/clock/mediatek,mt6735-topckgen.h
+
 MEDIATEK MT76 WIRELESS LAN DRIVER
 M:	Felix Fietkau <nbd@nbd.name>
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
diff --git a/include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h b/include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
new file mode 100644
index 000000000000..3dda719fd5d5
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLK_MT6735_APMIXEDSYS_H
+#define _DT_BINDINGS_CLK_MT6735_APMIXEDSYS_H
+
+#define ARMPLL				0
+#define MAINPLL				1
+#define UNIVPLL				2
+#define MMPLL				3
+#define MSDCPLL				4
+#define VENCPLL				5
+#define TVDPLL				6
+#define APLL1				7
+#define APLL2				8
+
+#endif
diff --git a/include/dt-bindings/clock/mediatek,mt6735-infracfg.h b/include/dt-bindings/clock/mediatek,mt6735-infracfg.h
new file mode 100644
index 000000000000..a42be76c778d
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,mt6735-infracfg.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLK_MT6735_INFRACFG_H
+#define _DT_BINDINGS_CLK_MT6735_INFRACFG_H
+
+#define CLK_DBG				0
+#define CLK_GCE				1
+#define CLK_TRBG			2
+#define CLK_CPUM			3
+#define CLK_DEVAPC			4
+#define CLK_AUDIO			5
+#define CLK_GCPU			6
+#define CLK_L2C_SRAM			7
+#define CLK_M4U				8
+#define CLK_CLDMA			9
+#define CLK_CONNMCU_BUS			10
+#define CLK_KP				11
+#define CLK_APXGPT			12
+#define CLK_SEJ				13
+#define CLK_CCIF0_AP			14
+#define CLK_CCIF1_AP			15
+#define CLK_PMIC_SPI			16
+#define CLK_PMIC_WRAP			17
+
+#endif
diff --git a/include/dt-bindings/clock/mediatek,mt6735-pericfg.h b/include/dt-bindings/clock/mediatek,mt6735-pericfg.h
new file mode 100644
index 000000000000..72401f009176
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,mt6735-pericfg.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLK_MT6735_PERICFG_H
+#define _DT_BINDINGS_CLK_MT6735_PERICFG_H
+
+#define CLK_DISP_PWM			0
+#define CLK_THERM			1
+#define CLK_PWM1			2
+#define CLK_PWM2			3
+#define CLK_PWM3			4
+#define CLK_PWM4			5
+#define CLK_PWM5			6
+#define CLK_PWM6			7
+#define CLK_PWM7			8
+#define CLK_PWM				9
+#define CLK_USB0			10
+#define CLK_IRDA			11
+#define CLK_APDMA			12
+#define CLK_MSDC30_0			13
+#define CLK_MSDC30_1			14
+#define CLK_MSDC30_2			15
+#define CLK_MSDC30_3			16
+#define CLK_UART0			17
+#define CLK_UART1			18
+#define CLK_UART2			19
+#define CLK_UART3			20
+#define CLK_UART4			21
+#define CLK_BTIF			22
+#define CLK_I2C0			23
+#define CLK_I2C1			24
+#define CLK_I2C2			25
+#define CLK_I2C3			26
+#define CLK_AUXADC			27
+#define CLK_SPI0			28
+#define CLK_IRTX			29
+
+#endif
diff --git a/include/dt-bindings/clock/mediatek,mt6735-topckgen.h b/include/dt-bindings/clock/mediatek,mt6735-topckgen.h
new file mode 100644
index 000000000000..a771910a4b8a
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,mt6735-topckgen.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLK_MT6735_TOPCKGEN_H
+#define _DT_BINDINGS_CLK_MT6735_TOPCKGEN_H
+
+#define AD_SYS_26M_CK			0
+#define CLKPH_MCK_O			1
+#define DMPLL				2
+#define DPI_CK				3
+#define WHPLL_AUDIO_CK			4
+
+#define SYSPLL_D2			5
+#define SYSPLL_D3			6
+#define SYSPLL_D5			7
+#define SYSPLL1_D2			8
+#define SYSPLL1_D4			9
+#define SYSPLL1_D8			10
+#define SYSPLL1_D16			11
+#define SYSPLL2_D2			12
+#define SYSPLL2_D4			13
+#define SYSPLL3_D2			14
+#define SYSPLL3_D4			15
+#define SYSPLL4_D2			16
+#define SYSPLL4_D4			17
+#define UNIVPLL_D2			18
+#define UNIVPLL_D3			19
+#define UNIVPLL_D5			20
+#define UNIVPLL_D26			21
+#define UNIVPLL1_D2			22
+#define UNIVPLL1_D4			23
+#define UNIVPLL1_D8			24
+#define UNIVPLL2_D2			25
+#define UNIVPLL2_D4			26
+#define UNIVPLL2_D8			27
+#define UNIVPLL3_D2			28
+#define UNIVPLL3_D4			29
+#define MSDCPLL_D2			30
+#define MSDCPLL_D4			31
+#define MSDCPLL_D8			32
+#define MSDCPLL_D16			33
+#define VENCPLL_D3			34
+#define TVDPLL_D2			35
+#define TVDPLL_D4			36
+#define DMPLL_D2			37
+#define DMPLL_D4			38
+#define DMPLL_D8			39
+#define AD_SYS_26M_D2			40
+
+#define AXI_SEL				41
+#define MEM_SEL				42
+#define DDRPHY_SEL			43
+#define MM_SEL				44
+#define PWM_SEL				45
+#define VDEC_SEL			46
+#define MFG_SEL				47
+#define CAMTG_SEL			48
+#define UART_SEL			49
+#define SPI_SEL				50
+#define USB20_SEL			51
+#define MSDC50_0_SEL			52
+#define MSDC30_0_SEL			53
+#define MSDC30_1_SEL			54
+#define MSDC30_2_SEL			55
+#define MSDC30_3_SEL			56
+#define AUDIO_SEL			57
+#define AUDINTBUS_SEL			58
+#define PMICSPI_SEL			59
+#define SCP_SEL				60
+#define ATB_SEL				61
+#define DPI0_SEL			62
+#define SCAM_SEL			63
+#define MFG13M_SEL			64
+#define AUD1_SEL			65
+#define AUD2_SEL			66
+#define IRDA_SEL			67
+#define IRTX_SEL			68
+#define DISPPWM_SEL			69
+
+#endif
-- 
2.39.2

