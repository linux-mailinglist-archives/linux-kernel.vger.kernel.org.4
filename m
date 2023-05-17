Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BEA7062DC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjEQI3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjEQI2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:28:47 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E048859C9
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:28:40 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f42c865534so4568255e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684312119; x=1686904119;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWJNt5mLERMfPY6t85vS3GLS9OgkOs8tsAb7gTjbagA=;
        b=aSNrweG/ckpFi7foF0NrTIW3e9EMvdHQPEVCKQzlDszJJR0GG7V67BG2Q1v+UVLosC
         o6SmFnQQz7YX3ypRaftU2b9T4Swqo+RnuOp3DP0SIR4ohpOpnQQzi5ptlaquPxxJ++8u
         dtrRlynnyvTpkeJcKVQlMJ+Ta0tpHOngcNwRUEilvCysfgNX1VglGYDRX98XSkjmL4RE
         GU7qMcKiYlGaVap4v01Zy8fh3aqZR05RYFyL+LzCib2wdYIqtrnaHVUjiA/vDr7/j9O1
         hrstUZk5PbUq5lwrdUC7eR/UQ/iCeGAOAq3VoArQfTwSkpmxFf2SCD4Cl5IDmSYZWVvP
         sARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684312119; x=1686904119;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWJNt5mLERMfPY6t85vS3GLS9OgkOs8tsAb7gTjbagA=;
        b=bzLTUYnG+o9sDOEiXZbk8B6aCHvq7dFkgqRDxZ+fOU5v9xx7rXkHdEII7OW7I+14jZ
         caLh0oHuzol+uAe7uHeWFHCLTAvsvfXO2ZA0kiaxZsT5s47D4L/AtWFVe2PU2SQ96Iky
         eS5bBwUGt0yGiyD97DgmCmxzJ/1ujcTC1ZF/rlcdqHBmypCScXl94vKkDFc7Ay/qjpVy
         uOk4fHLxGAFikNQ4QWR9XxqnF8lxyBoBijrG9VOo3Ev+mxLY/NBVuaXDPdKcJu743NmL
         VGplZ8iBxwPp9Sn4uLfVT8o79xJduGROZjgBxbDMCjgc8esuqaqAESzhmW691b/uw6Lm
         89oQ==
X-Gm-Message-State: AC+VfDwDRXQBrawze4a/0TUQECgRrtnu2AR5H26rUCvU04+ShQ+mwD9b
        2FFfaD/VpJBo1I2CvP8Q8HGrGQ==
X-Google-Smtp-Source: ACHHUZ4mlpFLpAU7cefSWGYrs4UJhmFzuC3B2e3+isK80bVXGYpXra6iVG2kgsIk/joUksSxxSMOgA==
X-Received: by 2002:a05:6000:18a:b0:306:2d45:a8e0 with SMTP id p10-20020a056000018a00b003062d45a8e0mr21870wrx.15.1684312119066;
        Wed, 17 May 2023 01:28:39 -0700 (PDT)
Received: from [127.0.1.1] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c4-20020a056000104400b0030922ba6d0csm2323066wrx.45.2023.05.17.01.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 01:28:38 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 17 May 2023 10:28:19 +0200
Subject: [PATCH 1/2] clk: mediatek: mt8365: fix the clock indexes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-fix-clk-index-v1-1-142077a1732b@baylibre.com>
References: <20230517-fix-clk-index-v1-0-142077a1732b@baylibre.com>
In-Reply-To: <20230517-fix-clk-index-v1-0-142077a1732b@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14130;
 i=amergnat@baylibre.com; h=from:subject:message-id;
 bh=t9+WXCcPhhVjhZHNXUEWCKLYAeulHyfhhS1yMeLulm0=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkZJA0Cagp5eBLZPPF9VITxcHAPz5wTPYall3DsnjW
 vcoVhUqJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZGSQNAAKCRArRkmdfjHURUqwD/
 wMONSTnpBBJ/Zuk0pGmh51R6j4sOafKTT9egzKWHmzleINSny6gojLeMFhYXHhB2eST3TU0P02xSXU
 sMMU/rEa2te4dMkqxQA8GT6vhipLj0RZLKYPCVfzUGn2fzi5hMTghLQzHQ6mAZ0oigVeRjGtsVK9+7
 UlvBK1ahHGdtUqdXY3w8G+PhDINBIx/dYnxjZz4Bzh6MB8Vwr1sc4kvaAwPRbtH+ePS0wiwZ+skGYV
 3ojpL3OVHhlbY7BU4UCGXWiiniLcFEHUOvvxN5gKZ+IwbGzhyNaW6fQjXhydx5VPKaNaj+zKYwxqOl
 F1OxD/e9d7xBBZlm/W5GGwlCIU2y+gjG4igm9PNLXiLUkenfNVj25cREVeI7ohPHcvgJa14ZsCH7sD
 7r1k36AQuXjvlSkGm4LEwM4zRN3k9H3NOBY1k94e0WUrjXjTlwPbH8H+dvtaFazXlLfvJ8xPHf886i
 cFGHYY3NLsNioCaNGCM1p55N133Km9M8zeS8hmtlFS2JGHpSz1Bz1mkHhBi78ydoPRhsBr2lihIqBS
 mQOLADY9zhEh0zMRjnHxkF7pZwFwwUkDfjTPKyRo5Za/nAZ5LqUkPhqxaI/OUZNFjNRTzSEPALUrhN
 OvTjIHC3OFo9l6xC4b4dwRKdFJ4Lu1B+nEQ5xSQ5V0fnYPUj51WlQkzSSVtA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before the patch [1], the clock probe was done directly in the
clk-mt8365 driver. In this probe function, the array which stores the
data clocks is sized using the higher defined numbers (*_NR_CLOCK) in
the clock lists [2]. Currently, with the patch [1], the specific
clk-mt8365 probe function is replaced by the mtk generic one [3], which
size the clock data array by adding all the clock descriptor array size
provided by the clk-mt8365 driver.

Actually, all clock indexes come from the header file [2], that mean, if
there are more clock (then more index) in the header file [2] than the
number of clock declared in the clock descriptor arrays (which is the
case currently), the clock data array will be undersized and then the
generic probe function will overflow when it will try to write in
"clk_data[CLK_INDEX]". Actually, instead of crashing at boot, the probe
function returns an error in the log which looks like:
"of_clk_hw_onecell_get: invalid index 135", then this clock isn't
enabled.

The simplest way to fix the regression is to remove from the header file
[2] the unused clocks.

[1]: Commit ffe91cb28f6a ("clk: mediatek: mt8365: Convert to
     mtk_clk_simple_{probe,remove}()")
[2]: include/dt-bindings/clock/mediatek,mt8365-clk.h
[3]: drivers/clk/mediatek/clk-mtk.c

Fixes: ffe91cb28f6a ("clk: mediatek: mt8365: Convert to mtk_clk_simple_{probe,remove}()")

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 include/dt-bindings/clock/mediatek,mt8365-clk.h | 361 ++++++++++++------------
 1 file changed, 177 insertions(+), 184 deletions(-)

diff --git a/include/dt-bindings/clock/mediatek,mt8365-clk.h b/include/dt-bindings/clock/mediatek,mt8365-clk.h
index f9aff1775810..fd59c8bdeb24 100644
--- a/include/dt-bindings/clock/mediatek,mt8365-clk.h
+++ b/include/dt-bindings/clock/mediatek,mt8365-clk.h
@@ -7,147 +7,142 @@
 #define _DT_BINDINGS_CLK_MT8365_H
 
 /* TOPCKGEN */
-#define CLK_TOP_CLK_NULL		0
-#define CLK_TOP_I2S0_BCK		1
-#define CLK_TOP_DSI0_LNTC_DSICK		2
-#define CLK_TOP_VPLL_DPIX		3
-#define CLK_TOP_LVDSTX_CLKDIG_CTS	4
-#define CLK_TOP_MFGPLL			5
-#define CLK_TOP_SYSPLL_D2		6
-#define CLK_TOP_SYSPLL1_D2		7
-#define CLK_TOP_SYSPLL1_D4		8
-#define CLK_TOP_SYSPLL1_D8		9
-#define CLK_TOP_SYSPLL1_D16		10
-#define CLK_TOP_SYSPLL_D3		11
-#define CLK_TOP_SYSPLL2_D2		12
-#define CLK_TOP_SYSPLL2_D4		13
-#define CLK_TOP_SYSPLL2_D8		14
-#define CLK_TOP_SYSPLL_D5		15
-#define CLK_TOP_SYSPLL3_D2		16
-#define CLK_TOP_SYSPLL3_D4		17
-#define CLK_TOP_SYSPLL_D7		18
-#define CLK_TOP_SYSPLL4_D2		19
-#define CLK_TOP_SYSPLL4_D4		20
-#define CLK_TOP_UNIVPLL			21
-#define CLK_TOP_UNIVPLL_D2		22
-#define CLK_TOP_UNIVPLL1_D2		23
-#define CLK_TOP_UNIVPLL1_D4		24
-#define CLK_TOP_UNIVPLL_D3		25
-#define CLK_TOP_UNIVPLL2_D2		26
-#define CLK_TOP_UNIVPLL2_D4		27
-#define CLK_TOP_UNIVPLL2_D8		28
-#define CLK_TOP_UNIVPLL2_D32		29
-#define CLK_TOP_UNIVPLL_D5		30
-#define CLK_TOP_UNIVPLL3_D2		31
-#define CLK_TOP_UNIVPLL3_D4		32
-#define CLK_TOP_MMPLL			33
-#define CLK_TOP_MMPLL_D2		34
-#define CLK_TOP_LVDSPLL_D2		35
-#define CLK_TOP_LVDSPLL_D4		36
-#define CLK_TOP_LVDSPLL_D8		37
-#define CLK_TOP_LVDSPLL_D16		38
-#define CLK_TOP_USB20_192M		39
-#define CLK_TOP_USB20_192M_D4		40
-#define CLK_TOP_USB20_192M_D8		41
-#define CLK_TOP_USB20_192M_D16		42
-#define CLK_TOP_USB20_192M_D32		43
-#define CLK_TOP_APLL1			44
-#define CLK_TOP_APLL1_D2		45
-#define CLK_TOP_APLL1_D4		46
-#define CLK_TOP_APLL1_D8		47
-#define CLK_TOP_APLL2			48
-#define CLK_TOP_APLL2_D2		49
-#define CLK_TOP_APLL2_D4		50
-#define CLK_TOP_APLL2_D8		51
-#define CLK_TOP_SYS_26M_D2		52
-#define CLK_TOP_MSDCPLL			53
-#define CLK_TOP_MSDCPLL_D2		54
-#define CLK_TOP_DSPPLL			55
-#define CLK_TOP_DSPPLL_D2		56
-#define CLK_TOP_DSPPLL_D4		57
-#define CLK_TOP_DSPPLL_D8		58
-#define CLK_TOP_APUPLL			59
-#define CLK_TOP_CLK26M_D52		60
-#define CLK_TOP_AXI_SEL			61
-#define CLK_TOP_MEM_SEL			62
-#define CLK_TOP_MM_SEL			63
-#define CLK_TOP_SCP_SEL			64
-#define CLK_TOP_MFG_SEL			65
-#define CLK_TOP_ATB_SEL			66
-#define CLK_TOP_CAMTG_SEL		67
-#define CLK_TOP_CAMTG1_SEL		68
-#define CLK_TOP_UART_SEL		69
-#define CLK_TOP_SPI_SEL			70
-#define CLK_TOP_MSDC50_0_HC_SEL		71
-#define CLK_TOP_MSDC2_2_HC_SEL		72
-#define CLK_TOP_MSDC50_0_SEL		73
-#define CLK_TOP_MSDC50_2_SEL		74
-#define CLK_TOP_MSDC30_1_SEL		75
-#define CLK_TOP_AUDIO_SEL		76
-#define CLK_TOP_AUD_INTBUS_SEL		77
-#define CLK_TOP_AUD_1_SEL		78
-#define CLK_TOP_AUD_2_SEL		79
-#define CLK_TOP_AUD_ENGEN1_SEL		80
-#define CLK_TOP_AUD_ENGEN2_SEL		81
-#define CLK_TOP_AUD_SPDIF_SEL		82
-#define CLK_TOP_DISP_PWM_SEL		83
-#define CLK_TOP_DXCC_SEL		84
-#define CLK_TOP_SSUSB_SYS_SEL		85
-#define CLK_TOP_SSUSB_XHCI_SEL		86
-#define CLK_TOP_SPM_SEL			87
-#define CLK_TOP_I2C_SEL			88
-#define CLK_TOP_PWM_SEL			89
-#define CLK_TOP_SENIF_SEL		90
-#define CLK_TOP_AES_FDE_SEL		91
-#define CLK_TOP_CAMTM_SEL		92
-#define CLK_TOP_DPI0_SEL		93
-#define CLK_TOP_DPI1_SEL		94
-#define CLK_TOP_DSP_SEL			95
-#define CLK_TOP_NFI2X_SEL		96
-#define CLK_TOP_NFIECC_SEL		97
-#define CLK_TOP_ECC_SEL			98
-#define CLK_TOP_ETH_SEL			99
-#define CLK_TOP_GCPU_SEL		100
-#define CLK_TOP_GCPU_CPM_SEL		101
-#define CLK_TOP_APU_SEL			102
-#define CLK_TOP_APU_IF_SEL		103
-#define CLK_TOP_MBIST_DIAG_SEL		104
-#define CLK_TOP_APLL_I2S0_SEL		105
-#define CLK_TOP_APLL_I2S1_SEL		106
-#define CLK_TOP_APLL_I2S2_SEL		107
-#define CLK_TOP_APLL_I2S3_SEL		108
-#define CLK_TOP_APLL_TDMOUT_SEL		109
-#define CLK_TOP_APLL_TDMIN_SEL		110
-#define CLK_TOP_APLL_SPDIF_SEL		111
-#define CLK_TOP_APLL12_CK_DIV0		112
-#define CLK_TOP_APLL12_CK_DIV1		113
-#define CLK_TOP_APLL12_CK_DIV2		114
-#define CLK_TOP_APLL12_CK_DIV3		115
-#define CLK_TOP_APLL12_CK_DIV4		116
-#define CLK_TOP_APLL12_CK_DIV4B		117
-#define CLK_TOP_APLL12_CK_DIV5		118
-#define CLK_TOP_APLL12_CK_DIV5B		119
-#define CLK_TOP_APLL12_CK_DIV6		120
-#define CLK_TOP_AUD_I2S0_M		121
-#define CLK_TOP_AUD_I2S1_M		122
-#define CLK_TOP_AUD_I2S2_M		123
-#define CLK_TOP_AUD_I2S3_M		124
-#define CLK_TOP_AUD_TDMOUT_M		125
-#define CLK_TOP_AUD_TDMOUT_B		126
-#define CLK_TOP_AUD_TDMIN_M		127
-#define CLK_TOP_AUD_TDMIN_B		128
-#define CLK_TOP_AUD_SPDIF_M		129
-#define CLK_TOP_USB20_48M_EN		130
-#define CLK_TOP_UNIVPLL_48M_EN		131
-#define CLK_TOP_LVDSTX_CLKDIG_EN	132
-#define CLK_TOP_VPLL_DPIX_EN		133
-#define CLK_TOP_SSUSB_TOP_CK_EN		134
-#define CLK_TOP_SSUSB_PHY_CK_EN		135
-#define CLK_TOP_CONN_32K		136
-#define CLK_TOP_CONN_26M		137
-#define CLK_TOP_DSP_32K			138
-#define CLK_TOP_DSP_26M			139
-#define CLK_TOP_NR_CLK			140
+#define CLK_TOP_I2S0_BCK		0
+#define CLK_TOP_DSI0_LNTC_DSICK		1
+#define CLK_TOP_VPLL_DPIX		2
+#define CLK_TOP_LVDSTX_CLKDIG_CTS	3
+#define CLK_TOP_MFGPLL			4
+#define CLK_TOP_SYSPLL_D2		5
+#define CLK_TOP_SYSPLL1_D2		6
+#define CLK_TOP_SYSPLL1_D4		7
+#define CLK_TOP_SYSPLL1_D8		8
+#define CLK_TOP_SYSPLL1_D16		9
+#define CLK_TOP_SYSPLL_D3		10
+#define CLK_TOP_SYSPLL2_D2		11
+#define CLK_TOP_SYSPLL2_D4		12
+#define CLK_TOP_SYSPLL2_D8		13
+#define CLK_TOP_SYSPLL_D5		14
+#define CLK_TOP_SYSPLL3_D2		15
+#define CLK_TOP_SYSPLL3_D4		16
+#define CLK_TOP_SYSPLL_D7		17
+#define CLK_TOP_SYSPLL4_D2		18
+#define CLK_TOP_SYSPLL4_D4		19
+#define CLK_TOP_UNIVPLL			20
+#define CLK_TOP_UNIVPLL_D2		21
+#define CLK_TOP_UNIVPLL1_D2		22
+#define CLK_TOP_UNIVPLL1_D4		23
+#define CLK_TOP_UNIVPLL_D3		24
+#define CLK_TOP_UNIVPLL2_D2		25
+#define CLK_TOP_UNIVPLL2_D4		26
+#define CLK_TOP_UNIVPLL2_D8		27
+#define CLK_TOP_UNIVPLL2_D32		28
+#define CLK_TOP_UNIVPLL_D5		29
+#define CLK_TOP_UNIVPLL3_D2		30
+#define CLK_TOP_UNIVPLL3_D4		31
+#define CLK_TOP_MMPLL			32
+#define CLK_TOP_MMPLL_D2		33
+#define CLK_TOP_LVDSPLL_D2		34
+#define CLK_TOP_LVDSPLL_D4		35
+#define CLK_TOP_LVDSPLL_D8		36
+#define CLK_TOP_LVDSPLL_D16		37
+#define CLK_TOP_USB20_192M		38
+#define CLK_TOP_USB20_192M_D4		39
+#define CLK_TOP_USB20_192M_D8		40
+#define CLK_TOP_USB20_192M_D16		41
+#define CLK_TOP_USB20_192M_D32		42
+#define CLK_TOP_APLL1			43
+#define CLK_TOP_APLL1_D2		44
+#define CLK_TOP_APLL1_D4		45
+#define CLK_TOP_APLL1_D8		46
+#define CLK_TOP_APLL2			47
+#define CLK_TOP_APLL2_D2		48
+#define CLK_TOP_APLL2_D4		49
+#define CLK_TOP_APLL2_D8		50
+#define CLK_TOP_SYS_26M_D2		51
+#define CLK_TOP_MSDCPLL			52
+#define CLK_TOP_MSDCPLL_D2		53
+#define CLK_TOP_DSPPLL			54
+#define CLK_TOP_DSPPLL_D2		55
+#define CLK_TOP_DSPPLL_D4		56
+#define CLK_TOP_DSPPLL_D8		57
+#define CLK_TOP_APUPLL			58
+#define CLK_TOP_CLK26M_D52		59
+#define CLK_TOP_AXI_SEL			60
+#define CLK_TOP_MEM_SEL			61
+#define CLK_TOP_MM_SEL			62
+#define CLK_TOP_SCP_SEL			63
+#define CLK_TOP_MFG_SEL			64
+#define CLK_TOP_ATB_SEL			65
+#define CLK_TOP_CAMTG_SEL		66
+#define CLK_TOP_CAMTG1_SEL		67
+#define CLK_TOP_UART_SEL		68
+#define CLK_TOP_SPI_SEL			69
+#define CLK_TOP_MSDC50_0_HC_SEL		70
+#define CLK_TOP_MSDC2_2_HC_SEL		71
+#define CLK_TOP_MSDC50_0_SEL		72
+#define CLK_TOP_MSDC50_2_SEL		73
+#define CLK_TOP_MSDC30_1_SEL		74
+#define CLK_TOP_AUDIO_SEL		75
+#define CLK_TOP_AUD_INTBUS_SEL		76
+#define CLK_TOP_AUD_1_SEL		77
+#define CLK_TOP_AUD_2_SEL		78
+#define CLK_TOP_AUD_ENGEN1_SEL		79
+#define CLK_TOP_AUD_ENGEN2_SEL		80
+#define CLK_TOP_AUD_SPDIF_SEL		81
+#define CLK_TOP_DISP_PWM_SEL		82
+#define CLK_TOP_DXCC_SEL		83
+#define CLK_TOP_SSUSB_SYS_SEL		84
+#define CLK_TOP_SSUSB_XHCI_SEL		85
+#define CLK_TOP_SPM_SEL			86
+#define CLK_TOP_I2C_SEL			87
+#define CLK_TOP_PWM_SEL			88
+#define CLK_TOP_SENIF_SEL		89
+#define CLK_TOP_AES_FDE_SEL		90
+#define CLK_TOP_CAMTM_SEL		91
+#define CLK_TOP_DPI0_SEL		92
+#define CLK_TOP_DPI1_SEL		93
+#define CLK_TOP_DSP_SEL			94
+#define CLK_TOP_NFI2X_SEL		95
+#define CLK_TOP_NFIECC_SEL		96
+#define CLK_TOP_ECC_SEL			97
+#define CLK_TOP_ETH_SEL			98
+#define CLK_TOP_GCPU_SEL		99
+#define CLK_TOP_GCPU_CPM_SEL		100
+#define CLK_TOP_APU_SEL			101
+#define CLK_TOP_APU_IF_SEL		102
+#define CLK_TOP_MBIST_DIAG_SEL		103
+#define CLK_TOP_APLL_I2S0_SEL		104
+#define CLK_TOP_APLL_I2S1_SEL		105
+#define CLK_TOP_APLL_I2S2_SEL		106
+#define CLK_TOP_APLL_I2S3_SEL		107
+#define CLK_TOP_APLL_TDMOUT_SEL		108
+#define CLK_TOP_APLL_TDMIN_SEL		109
+#define CLK_TOP_APLL_SPDIF_SEL		110
+#define CLK_TOP_APLL12_CK_DIV0		111
+#define CLK_TOP_APLL12_CK_DIV1		112
+#define CLK_TOP_APLL12_CK_DIV2		113
+#define CLK_TOP_APLL12_CK_DIV3		114
+#define CLK_TOP_APLL12_CK_DIV6		115
+#define CLK_TOP_AUD_I2S0_M		116
+#define CLK_TOP_AUD_I2S1_M		117
+#define CLK_TOP_AUD_I2S2_M		118
+#define CLK_TOP_AUD_I2S3_M		119
+#define CLK_TOP_AUD_TDMOUT_M		120
+#define CLK_TOP_AUD_TDMOUT_B		121
+#define CLK_TOP_AUD_TDMIN_M		122
+#define CLK_TOP_AUD_TDMIN_B		123
+#define CLK_TOP_AUD_SPDIF_M		124
+#define CLK_TOP_USB20_48M_EN		125
+#define CLK_TOP_UNIVPLL_48M_EN		126
+#define CLK_TOP_LVDSTX_CLKDIG_EN	127
+#define CLK_TOP_VPLL_DPIX_EN		128
+#define CLK_TOP_SSUSB_TOP_CK_EN		129
+#define CLK_TOP_SSUSB_PHY_CK_EN		130
+#define CLK_TOP_CONN_32K		131
+#define CLK_TOP_CONN_26M		132
+#define CLK_TOP_DSP_32K			133
+#define CLK_TOP_DSP_26M			134
+#define CLK_TOP_NR_CLK			135
 
 /* INFRACFG */
 #define CLK_IFR_PMIC_TMR		0
@@ -179,49 +174,47 @@
 #define CLK_IFR_GCPU			26
 #define CLK_IFR_TRNG			27
 #define CLK_IFR_AUXADC			28
-#define CLK_IFR_CPUM			29
-#define CLK_IFR_AUXADC_MD		30
-#define CLK_IFR_AP_DMA			31
-#define CLK_IFR_DEBUGSYS		32
-#define CLK_IFR_AUDIO			33
-#define CLK_IFR_PWM_FBCLK6		34
-#define CLK_IFR_DISP_PWM		35
-#define CLK_IFR_AUD_26M_BK		36
-#define CLK_IFR_CQ_DMA			37
-#define CLK_IFR_MSDC0_SF		38
-#define CLK_IFR_MSDC1_SF		39
-#define CLK_IFR_MSDC2_SF		40
-#define CLK_IFR_AP_MSDC0		41
-#define CLK_IFR_MD_MSDC0		42
-#define CLK_IFR_MSDC0_SRC		43
-#define CLK_IFR_MSDC1_SRC		44
-#define CLK_IFR_MSDC2_SRC		45
-#define CLK_IFR_PWRAP_TMR		46
-#define CLK_IFR_PWRAP_SPI		47
-#define CLK_IFR_PWRAP_SYS		48
-#define CLK_IFR_MCU_PM_BK		49
-#define CLK_IFR_IRRX_26M		50
-#define CLK_IFR_IRRX_32K		51
-#define CLK_IFR_I2C0_AXI		52
-#define CLK_IFR_I2C1_AXI		53
-#define CLK_IFR_I2C2_AXI		54
-#define CLK_IFR_I2C3_AXI		55
-#define CLK_IFR_NIC_AXI			56
-#define CLK_IFR_NIC_SLV_AXI		57
-#define CLK_IFR_APU_AXI			58
-#define CLK_IFR_NFIECC			59
-#define CLK_IFR_NFIECC_BK		60
-#define CLK_IFR_NFI1X_BK		61
-#define CLK_IFR_NFI_BK			62
-#define CLK_IFR_MSDC2_AP_BK		63
-#define CLK_IFR_MSDC2_MD_BK		64
-#define CLK_IFR_MSDC2_BK		65
-#define CLK_IFR_SUSB_133_BK		66
-#define CLK_IFR_SUSB_66_BK		67
-#define CLK_IFR_SSUSB_SYS		68
-#define CLK_IFR_SSUSB_REF		69
-#define CLK_IFR_SSUSB_XHCI		70
-#define CLK_IFR_NR_CLK			71
+#define CLK_IFR_AUXADC_MD		29
+#define CLK_IFR_AP_DMA			30
+#define CLK_IFR_DEBUGSYS		31
+#define CLK_IFR_AUDIO			32
+#define CLK_IFR_PWM_FBCLK6		33
+#define CLK_IFR_DISP_PWM		34
+#define CLK_IFR_AUD_26M_BK		35
+#define CLK_IFR_CQ_DMA			36
+#define CLK_IFR_MSDC0_SF		37
+#define CLK_IFR_MSDC1_SF		38
+#define CLK_IFR_MSDC2_SF		39
+#define CLK_IFR_AP_MSDC0		40
+#define CLK_IFR_MD_MSDC0		41
+#define CLK_IFR_MSDC0_SRC		42
+#define CLK_IFR_MSDC1_SRC		43
+#define CLK_IFR_MSDC2_SRC		44
+#define CLK_IFR_PWRAP_TMR		45
+#define CLK_IFR_PWRAP_SPI		46
+#define CLK_IFR_PWRAP_SYS		47
+#define CLK_IFR_IRRX_26M		48
+#define CLK_IFR_IRRX_32K		49
+#define CLK_IFR_I2C0_AXI		50
+#define CLK_IFR_I2C1_AXI		51
+#define CLK_IFR_I2C2_AXI		52
+#define CLK_IFR_I2C3_AXI		53
+#define CLK_IFR_NIC_AXI			54
+#define CLK_IFR_NIC_SLV_AXI		55
+#define CLK_IFR_APU_AXI			56
+#define CLK_IFR_NFIECC			57
+#define CLK_IFR_NFIECC_BK		58
+#define CLK_IFR_NFI1X_BK		59
+#define CLK_IFR_NFI_BK			60
+#define CLK_IFR_MSDC2_AP_BK		61
+#define CLK_IFR_MSDC2_MD_BK		62
+#define CLK_IFR_MSDC2_BK		63
+#define CLK_IFR_SUSB_133_BK		64
+#define CLK_IFR_SUSB_66_BK		65
+#define CLK_IFR_SSUSB_SYS		66
+#define CLK_IFR_SSUSB_REF		67
+#define CLK_IFR_SSUSB_XHCI		68
+#define CLK_IFR_NR_CLK			69
 
 /* PERICFG */
 #define CLK_PERIAXI			0

-- 
2.25.1

