Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFAB725C58
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbjFGK6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240174AbjFGK5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:57:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFDB26B3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:56:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f6da07ff00so72533475e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 03:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686135391; x=1688727391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7t9Ryqt58Qb+WlUAiS6O01za23Xe6nA9m+o2fGogTVs=;
        b=EedDfEJBlHn+++dixRSFfvkKidiCLUzDx61Sb5806jrqkuYiAPdtbtU7q8s+XtJ5j4
         Fx60g3gTVe3fZIcm96NrfXD/YiFmV1BwV9wACAyRZc2AAyigZcWKyqSgQe+4eiY6bzvF
         bxzaQmwXq5FxfIxyvrMSCpyPwV3Zry0Al/g1KyJ0Q4PHryUzNoSCN9Whw758D3LBkBxY
         WlJT74sCbIGA3HFkDNJjeNkwiThWPlZpN3hYcLH/V8dQVpfPPlJXISb8jbD32CHG6Sw4
         h1fCeIaVaZx3vUpd58gYyJMD0mglysmOlVDpfWBk9ePwS2YWos4FXJARd3VUmyQOAWP1
         1BvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686135391; x=1688727391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7t9Ryqt58Qb+WlUAiS6O01za23Xe6nA9m+o2fGogTVs=;
        b=DUoVEOMa2yj4Yd+lS6xnb3HoF39bXfz9f6CRyoti4SLaiLXA3sgf6+o0tro0aKQGVH
         ugrtznFO1q5OwOJ9/MxzHTulx58wRhm/OEFgtwOXLiC64aUjXV0Z7obf8l6KXIQMS3DQ
         gO+H4oJcexW3nAv1kkLEyPEiDH6xsLKP6C6wQxqMVlEYVtUJzw7lkTVSPcQ0FHyFq4hn
         23y/H0JNVBG8+miSPyTfOcbqmCjfoHtJoeJYWVtCUbODFIj24c2p1lTq8G0pDjtjqh5e
         5ARw+XnHL1M1VeYs6cdKnrKqlyxa9BF0bLwU6NmwLndwVYVz4N03eB+cRvhqpwndm7BP
         Bi4Q==
X-Gm-Message-State: AC+VfDw99tbJA6OrxLxYmnl3lwwAm5XqJsWWebA4yvpWyQ1xhB6XNYKC
        ytr5vMM0R/GiIAKqvv/ln209Rg==
X-Google-Smtp-Source: ACHHUZ4U80f+d7DuCBpUwhg1wXmdCrVm8DyE/rQ2pIYPZ2L+PV/s9K84nX/Xn0GI3ugryIIufXSkCw==
X-Received: by 2002:a7b:cbd2:0:b0:3f6:44e:9d8 with SMTP id n18-20020a7bcbd2000000b003f6044e09d8mr5145592wmi.22.1686135391233;
        Wed, 07 Jun 2023 03:56:31 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c290a00b003f60faa4612sm1761879wmd.22.2023.06.07.03.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:56:30 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 07 Jun 2023 12:56:19 +0200
Subject: [PATCH 08/18] dt-bindings: clk: g12a-clks: expose all clock ids
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-8-9676afa6b22c@linaro.org>
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13595;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=bGK7ac8n0MRh9LI/j05Rq3/xiORoaDua4Qu9ye4M/Pg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkgGJRTTzeDHSnMRGSWsxRfPg9AbqNPi+qvyMYEGQK
 y1xLeO2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIBiUQAKCRB33NvayMhJ0SbsEA
 Cv17JvjbnLrT5bUyghT8RMggTl8tgU9Zzxdc80sNmNRcq9v6+nyWTvmmt31FSDfGgMg/iGCJQiRd8M
 kaFcvTaninh/RuBsoB/MlQ6WPTe0MGOnIH3Upepq1L/D9sL/o7wKqPgsTJXx3oSWq5RV2dYLURRPUE
 YpmP20rrLirr+jlcPBC6h3vHqoGDA6xy6KED7UL1q/8RKWCF1IjU+xccGCXmXa1F/YnJ2fisLJWz9n
 25HHj/N/AknlgV5uW1h0fID0c9+RVdHMoaD3LY1tCbxTExRGFM/JAHNJihsLNfCH1QsUVn1EPx6vHE
 aBjwuMNCByg03Vh39+FLZDmpNRUKjvp2PL2Vq7c2OgaVElfZKDHIoW9d4+23nFiuvlPpH8+oK2Il1E
 w6b8YN052gScfhlqqG2SDTpMJMI2TcGzGmmjY4OzvKwRl02vNLQzjtqURYYwMufNBMZrSs1YuZMTeQ
 wZPZFy2U+fwTI/h1X895v1vGJIMBaSteIvbRQv404Iwg+4etxFZVhuOovVZulGXJzCs5SZsrwG3vIJ
 weLDC8LFcGMLpH/ifUgNp+8FmMhn36zINz68/XHw9dJhXpgYrlR7HVwvImgGrXQF3/KgKvVoXyYbAw
 eBNbZi+rlGbM7w1EUclO/6jdCpQkXRp8Qx2DLagHXRgttCpMQorw4RXtVc1w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a policy change in clock ID bindings handling, expose
all the "private" clock IDs to the public clock dt-bindings
to move out of the previous maintenance scheme.

This refers to a discussion at [1] & [2] with Krzysztof about
the issue with the current maintenance.

It was decided to move every g12a-clkc ID to the public clock
dt-bindings headers to be merged in a single tree so we
can safely add new clocks without having merge issues.

[1] https://lore.kernel.org/all/c088e01c-0714-82be-8347-6140daf56640@linaro.org/
[2] https://lore.kernel.org/all/2fabe721-7434-43e7-bae5-088a42ba128d@app.fastmail.com/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/g12a.h              | 140 ----------------------------------
 include/dt-bindings/clock/g12a-clkc.h | 130 +++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+), 140 deletions(-)

diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
index a70a0cba892b..8e08af3c1476 100644
--- a/drivers/clk/meson/g12a.h
+++ b/drivers/clk/meson/g12a.h
@@ -126,146 +126,6 @@
 #define HHI_SYS1_PLL_CNTL5		0x394
 #define HHI_SYS1_PLL_CNTL6		0x398
 
-/*
- * CLKID index values
- *
- * These indices are entirely contrived and do not map onto the hardware.
- * It has now been decided to expose everything by default in the DT header:
- * include/dt-bindings/clock/g12a-clkc.h. Only the clocks ids we don't want
- * to expose, such as the internal muxes and dividers of composite clocks,
- * will remain defined here.
- */
-#define CLKID_MPEG_SEL				8
-#define CLKID_MPEG_DIV				9
-#define CLKID_SD_EMMC_A_CLK0_SEL		63
-#define CLKID_SD_EMMC_A_CLK0_DIV		64
-#define CLKID_SD_EMMC_B_CLK0_SEL		65
-#define CLKID_SD_EMMC_B_CLK0_DIV		66
-#define CLKID_SD_EMMC_C_CLK0_SEL		67
-#define CLKID_SD_EMMC_C_CLK0_DIV		68
-#define CLKID_MPLL0_DIV				69
-#define CLKID_MPLL1_DIV				70
-#define CLKID_MPLL2_DIV				71
-#define CLKID_MPLL3_DIV				72
-#define CLKID_MPLL_PREDIV			73
-#define CLKID_FCLK_DIV2_DIV			75
-#define CLKID_FCLK_DIV3_DIV			76
-#define CLKID_FCLK_DIV4_DIV			77
-#define CLKID_FCLK_DIV5_DIV			78
-#define CLKID_FCLK_DIV7_DIV			79
-#define CLKID_FCLK_DIV2P5_DIV			100
-#define CLKID_FIXED_PLL_DCO			101
-#define CLKID_SYS_PLL_DCO			102
-#define CLKID_GP0_PLL_DCO			103
-#define CLKID_HIFI_PLL_DCO			104
-#define CLKID_VPU_0_DIV				111
-#define CLKID_VPU_1_DIV				114
-#define CLKID_VAPB_0_DIV			118
-#define CLKID_VAPB_1_DIV			121
-#define CLKID_HDMI_PLL_DCO			125
-#define CLKID_HDMI_PLL_OD			126
-#define CLKID_HDMI_PLL_OD2			127
-#define CLKID_VID_PLL_SEL			130
-#define CLKID_VID_PLL_DIV			131
-#define CLKID_VCLK_SEL				132
-#define CLKID_VCLK2_SEL				133
-#define CLKID_VCLK_INPUT			134
-#define CLKID_VCLK2_INPUT			135
-#define CLKID_VCLK_DIV				136
-#define CLKID_VCLK2_DIV				137
-#define CLKID_VCLK_DIV2_EN			140
-#define CLKID_VCLK_DIV4_EN			141
-#define CLKID_VCLK_DIV6_EN			142
-#define CLKID_VCLK_DIV12_EN			143
-#define CLKID_VCLK2_DIV2_EN			144
-#define CLKID_VCLK2_DIV4_EN			145
-#define CLKID_VCLK2_DIV6_EN			146
-#define CLKID_VCLK2_DIV12_EN			147
-#define CLKID_CTS_ENCI_SEL			158
-#define CLKID_CTS_ENCP_SEL			159
-#define CLKID_CTS_VDAC_SEL			160
-#define CLKID_HDMI_TX_SEL			161
-#define CLKID_HDMI_SEL				166
-#define CLKID_HDMI_DIV				167
-#define CLKID_MALI_0_DIV			170
-#define CLKID_MALI_1_DIV			173
-#define CLKID_MPLL_50M_DIV			176
-#define CLKID_SYS_PLL_DIV16_EN			178
-#define CLKID_SYS_PLL_DIV16			179
-#define CLKID_CPU_CLK_DYN0_SEL			180
-#define CLKID_CPU_CLK_DYN0_DIV			181
-#define CLKID_CPU_CLK_DYN0			182
-#define CLKID_CPU_CLK_DYN1_SEL			183
-#define CLKID_CPU_CLK_DYN1_DIV			184
-#define CLKID_CPU_CLK_DYN1			185
-#define CLKID_CPU_CLK_DYN			186
-#define CLKID_CPU_CLK_DIV16_EN			188
-#define CLKID_CPU_CLK_DIV16			189
-#define CLKID_CPU_CLK_APB_DIV			190
-#define CLKID_CPU_CLK_APB			191
-#define CLKID_CPU_CLK_ATB_DIV			192
-#define CLKID_CPU_CLK_ATB			193
-#define CLKID_CPU_CLK_AXI_DIV			194
-#define CLKID_CPU_CLK_AXI			195
-#define CLKID_CPU_CLK_TRACE_DIV			196
-#define CLKID_CPU_CLK_TRACE			197
-#define CLKID_PCIE_PLL_DCO			198
-#define CLKID_PCIE_PLL_DCO_DIV2			199
-#define CLKID_PCIE_PLL_OD			200
-#define CLKID_VDEC_1_SEL			202
-#define CLKID_VDEC_1_DIV			203
-#define CLKID_VDEC_HEVC_SEL			205
-#define CLKID_VDEC_HEVC_DIV			206
-#define CLKID_VDEC_HEVCF_SEL			208
-#define CLKID_VDEC_HEVCF_DIV			209
-#define CLKID_TS_DIV				211
-#define CLKID_SYS1_PLL_DCO			213
-#define CLKID_SYS1_PLL				214
-#define CLKID_SYS1_PLL_DIV16_EN			215
-#define CLKID_SYS1_PLL_DIV16			216
-#define CLKID_CPUB_CLK_DYN0_SEL			217
-#define CLKID_CPUB_CLK_DYN0_DIV			218
-#define CLKID_CPUB_CLK_DYN0			219
-#define CLKID_CPUB_CLK_DYN1_SEL			220
-#define CLKID_CPUB_CLK_DYN1_DIV			221
-#define CLKID_CPUB_CLK_DYN1			222
-#define CLKID_CPUB_CLK_DYN			223
-#define CLKID_CPUB_CLK_DIV16_EN			225
-#define CLKID_CPUB_CLK_DIV16			226
-#define CLKID_CPUB_CLK_DIV2			227
-#define CLKID_CPUB_CLK_DIV3			228
-#define CLKID_CPUB_CLK_DIV4			229
-#define CLKID_CPUB_CLK_DIV5			230
-#define CLKID_CPUB_CLK_DIV6			231
-#define CLKID_CPUB_CLK_DIV7			232
-#define CLKID_CPUB_CLK_DIV8			233
-#define CLKID_CPUB_CLK_APB_SEL			234
-#define CLKID_CPUB_CLK_APB			235
-#define CLKID_CPUB_CLK_ATB_SEL			236
-#define CLKID_CPUB_CLK_ATB			237
-#define CLKID_CPUB_CLK_AXI_SEL			238
-#define CLKID_CPUB_CLK_AXI			239
-#define CLKID_CPUB_CLK_TRACE_SEL		240
-#define CLKID_CPUB_CLK_TRACE			241
-#define CLKID_GP1_PLL_DCO			242
-#define CLKID_DSU_CLK_DYN0_SEL			244
-#define CLKID_DSU_CLK_DYN0_DIV			245
-#define CLKID_DSU_CLK_DYN0			246
-#define CLKID_DSU_CLK_DYN1_SEL			247
-#define CLKID_DSU_CLK_DYN1_DIV			248
-#define CLKID_DSU_CLK_DYN1			249
-#define CLKID_DSU_CLK_DYN			250
-#define CLKID_DSU_CLK_FINAL			251
-#define CLKID_SPICC0_SCLK_SEL			256
-#define CLKID_SPICC0_SCLK_DIV			257
-#define CLKID_SPICC1_SCLK_SEL			259
-#define CLKID_SPICC1_SCLK_DIV			260
-#define CLKID_NNA_AXI_CLK_SEL			262
-#define CLKID_NNA_AXI_CLK_DIV			263
-#define CLKID_NNA_CORE_CLK_SEL			265
-#define CLKID_NNA_CORE_CLK_DIV			266
-#define CLKID_MIPI_DSI_PXCLK_DIV		268
-
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/g12a-clkc.h>
 
diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
index a93b58c5e18e..387767f4e298 100644
--- a/include/dt-bindings/clock/g12a-clkc.h
+++ b/include/dt-bindings/clock/g12a-clkc.h
@@ -16,6 +16,8 @@
 #define CLKID_FCLK_DIV5				5
 #define CLKID_FCLK_DIV7				6
 #define CLKID_GP0_PLL				7
+#define CLKID_MPEG_SEL				8
+#define CLKID_MPEG_DIV				9
 #define CLKID_CLK81				10
 #define CLKID_MPLL0				11
 #define CLKID_MPLL1				12
@@ -69,7 +71,23 @@
 #define CLKID_SD_EMMC_A_CLK0			60
 #define CLKID_SD_EMMC_B_CLK0			61
 #define CLKID_SD_EMMC_C_CLK0			62
+#define CLKID_SD_EMMC_A_CLK0_SEL		63
+#define CLKID_SD_EMMC_A_CLK0_DIV		64
+#define CLKID_SD_EMMC_B_CLK0_SEL		65
+#define CLKID_SD_EMMC_B_CLK0_DIV		66
+#define CLKID_SD_EMMC_C_CLK0_SEL		67
+#define CLKID_SD_EMMC_C_CLK0_DIV		68
+#define CLKID_MPLL0_DIV				69
+#define CLKID_MPLL1_DIV				70
+#define CLKID_MPLL2_DIV				71
+#define CLKID_MPLL3_DIV				72
+#define CLKID_MPLL_PREDIV			73
 #define CLKID_HIFI_PLL				74
+#define CLKID_FCLK_DIV2_DIV			75
+#define CLKID_FCLK_DIV3_DIV			76
+#define CLKID_FCLK_DIV4_DIV			77
+#define CLKID_FCLK_DIV5_DIV			78
+#define CLKID_FCLK_DIV7_DIV			79
 #define CLKID_VCLK2_VENCI0			80
 #define CLKID_VCLK2_VENCI1			81
 #define CLKID_VCLK2_VENCP0			82
@@ -90,26 +108,54 @@
 #define CLKID_VCLK2_VENCL			97
 #define CLKID_VCLK2_OTHER1			98
 #define CLKID_FCLK_DIV2P5			99
+#define CLKID_FCLK_DIV2P5_DIV			100
+#define CLKID_FIXED_PLL_DCO			101
+#define CLKID_SYS_PLL_DCO			102
+#define CLKID_GP0_PLL_DCO			103
+#define CLKID_HIFI_PLL_DCO			104
 #define CLKID_DMA				105
 #define CLKID_EFUSE				106
 #define CLKID_ROM_BOOT				107
 #define CLKID_RESET_SEC				108
 #define CLKID_SEC_AHB_APB3			109
 #define CLKID_VPU_0_SEL				110
+#define CLKID_VPU_0_DIV				111
 #define CLKID_VPU_0				112
 #define CLKID_VPU_1_SEL				113
+#define CLKID_VPU_1_DIV				114
 #define CLKID_VPU_1				115
 #define CLKID_VPU				116
 #define CLKID_VAPB_0_SEL			117
+#define CLKID_VAPB_0_DIV			118
 #define CLKID_VAPB_0				119
 #define CLKID_VAPB_1_SEL			120
+#define CLKID_VAPB_1_DIV			121
 #define CLKID_VAPB_1				122
 #define CLKID_VAPB_SEL				123
 #define CLKID_VAPB				124
+#define CLKID_HDMI_PLL_DCO			125
+#define CLKID_HDMI_PLL_OD			126
+#define CLKID_HDMI_PLL_OD2			127
 #define CLKID_HDMI_PLL				128
 #define CLKID_VID_PLL				129
+#define CLKID_VID_PLL_SEL			130
+#define CLKID_VID_PLL_DIV			131
+#define CLKID_VCLK_SEL				132
+#define CLKID_VCLK2_SEL				133
+#define CLKID_VCLK_INPUT			134
+#define CLKID_VCLK2_INPUT			135
+#define CLKID_VCLK_DIV				136
+#define CLKID_VCLK2_DIV				137
 #define CLKID_VCLK				138
 #define CLKID_VCLK2				139
+#define CLKID_VCLK_DIV2_EN			140
+#define CLKID_VCLK_DIV4_EN			141
+#define CLKID_VCLK_DIV6_EN			142
+#define CLKID_VCLK_DIV12_EN			143
+#define CLKID_VCLK2_DIV2_EN			144
+#define CLKID_VCLK2_DIV4_EN			145
+#define CLKID_VCLK2_DIV6_EN			146
+#define CLKID_VCLK2_DIV12_EN			147
 #define CLKID_VCLK_DIV1				148
 #define CLKID_VCLK_DIV2				149
 #define CLKID_VCLK_DIV4				150
@@ -120,33 +166,117 @@
 #define CLKID_VCLK2_DIV4			155
 #define CLKID_VCLK2_DIV6			156
 #define CLKID_VCLK2_DIV12			157
+#define CLKID_CTS_ENCI_SEL			158
+#define CLKID_CTS_ENCP_SEL			159
+#define CLKID_CTS_VDAC_SEL			160
+#define CLKID_HDMI_TX_SEL			161
 #define CLKID_CTS_ENCI				162
 #define CLKID_CTS_ENCP				163
 #define CLKID_CTS_VDAC				164
 #define CLKID_HDMI_TX				165
+#define CLKID_HDMI_SEL				166
+#define CLKID_HDMI_DIV				167
 #define CLKID_HDMI				168
 #define CLKID_MALI_0_SEL			169
+#define CLKID_MALI_0_DIV			170
 #define CLKID_MALI_0				171
 #define CLKID_MALI_1_SEL			172
+#define CLKID_MALI_1_DIV			173
 #define CLKID_MALI_1				174
 #define CLKID_MALI				175
+#define CLKID_MPLL_50M_DIV			176
 #define CLKID_MPLL_50M				177
+#define CLKID_SYS_PLL_DIV16_EN			178
+#define CLKID_SYS_PLL_DIV16			179
+#define CLKID_CPU_CLK_DYN0_SEL			180
+#define CLKID_CPU_CLK_DYN0_DIV			181
+#define CLKID_CPU_CLK_DYN0			182
+#define CLKID_CPU_CLK_DYN1_SEL			183
+#define CLKID_CPU_CLK_DYN1_DIV			184
+#define CLKID_CPU_CLK_DYN1			185
+#define CLKID_CPU_CLK_DYN			186
 #define CLKID_CPU_CLK				187
+#define CLKID_CPU_CLK_DIV16_EN			188
+#define CLKID_CPU_CLK_DIV16			189
+#define CLKID_CPU_CLK_APB_DIV			190
+#define CLKID_CPU_CLK_APB			191
+#define CLKID_CPU_CLK_ATB_DIV			192
+#define CLKID_CPU_CLK_ATB			193
+#define CLKID_CPU_CLK_AXI_DIV			194
+#define CLKID_CPU_CLK_AXI			195
+#define CLKID_CPU_CLK_TRACE_DIV			196
+#define CLKID_CPU_CLK_TRACE			197
+#define CLKID_PCIE_PLL_DCO			198
+#define CLKID_PCIE_PLL_DCO_DIV2			199
+#define CLKID_PCIE_PLL_OD			200
 #define CLKID_PCIE_PLL				201
+#define CLKID_VDEC_1_SEL			202
+#define CLKID_VDEC_1_DIV			203
 #define CLKID_VDEC_1				204
+#define CLKID_VDEC_HEVC_SEL			205
+#define CLKID_VDEC_HEVC_DIV			206
 #define CLKID_VDEC_HEVC				207
+#define CLKID_VDEC_HEVCF_SEL			208
+#define CLKID_VDEC_HEVCF_DIV			209
 #define CLKID_VDEC_HEVCF			210
+#define CLKID_TS_DIV				211
 #define CLKID_TS				212
+#define CLKID_SYS1_PLL_DCO			213
+#define CLKID_SYS1_PLL				214
+#define CLKID_SYS1_PLL_DIV16_EN			215
+#define CLKID_SYS1_PLL_DIV16			216
+#define CLKID_CPUB_CLK_DYN0_SEL			217
+#define CLKID_CPUB_CLK_DYN0_DIV			218
+#define CLKID_CPUB_CLK_DYN0			219
+#define CLKID_CPUB_CLK_DYN1_SEL			220
+#define CLKID_CPUB_CLK_DYN1_DIV			221
+#define CLKID_CPUB_CLK_DYN1			222
+#define CLKID_CPUB_CLK_DYN			223
 #define CLKID_CPUB_CLK				224
+#define CLKID_CPUB_CLK_DIV16_EN			225
+#define CLKID_CPUB_CLK_DIV16			226
+#define CLKID_CPUB_CLK_DIV2			227
+#define CLKID_CPUB_CLK_DIV3			228
+#define CLKID_CPUB_CLK_DIV4			229
+#define CLKID_CPUB_CLK_DIV5			230
+#define CLKID_CPUB_CLK_DIV6			231
+#define CLKID_CPUB_CLK_DIV7			232
+#define CLKID_CPUB_CLK_DIV8			233
+#define CLKID_CPUB_CLK_APB_SEL			234
+#define CLKID_CPUB_CLK_APB			235
+#define CLKID_CPUB_CLK_ATB_SEL			236
+#define CLKID_CPUB_CLK_ATB			237
+#define CLKID_CPUB_CLK_AXI_SEL			238
+#define CLKID_CPUB_CLK_AXI			239
+#define CLKID_CPUB_CLK_TRACE_SEL		240
+#define CLKID_CPUB_CLK_TRACE			241
+#define CLKID_GP1_PLL_DCO			242
 #define CLKID_GP1_PLL				243
+#define CLKID_DSU_CLK_DYN0_SEL			244
+#define CLKID_DSU_CLK_DYN0_DIV			245
+#define CLKID_DSU_CLK_DYN0			246
+#define CLKID_DSU_CLK_DYN1_SEL			247
+#define CLKID_DSU_CLK_DYN1_DIV			248
+#define CLKID_DSU_CLK_DYN1			249
+#define CLKID_DSU_CLK_DYN			250
+#define CLKID_DSU_CLK_FINAL			251
 #define CLKID_DSU_CLK				252
 #define CLKID_CPU1_CLK				253
 #define CLKID_CPU2_CLK				254
 #define CLKID_CPU3_CLK				255
+#define CLKID_SPICC0_SCLK_SEL			256
+#define CLKID_SPICC0_SCLK_DIV			257
 #define CLKID_SPICC0_SCLK			258
+#define CLKID_SPICC1_SCLK_SEL			259
+#define CLKID_SPICC1_SCLK_DIV			260
 #define CLKID_SPICC1_SCLK			261
+#define CLKID_NNA_AXI_CLK_SEL			262
+#define CLKID_NNA_AXI_CLK_DIV			263
 #define CLKID_NNA_AXI_CLK			264
+#define CLKID_NNA_CORE_CLK_SEL			265
+#define CLKID_NNA_CORE_CLK_DIV			266
 #define CLKID_NNA_CORE_CLK			267
+#define CLKID_MIPI_DSI_PXCLK_DIV		268
 #define CLKID_MIPI_DSI_PXCLK_SEL		269
 #define CLKID_MIPI_DSI_PXCLK			270
 

-- 
2.34.1

