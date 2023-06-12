Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327E872BEA4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjFLKSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbjFLKRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:17:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251B2AD28
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:58:45 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f7353993cbso30096395e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686563861; x=1689155861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pW6LNHkUsFsDtatHPA0cTf9hV8W1qigWKCpwsjlPFFw=;
        b=c/uc4KxsNRJuJ5LrA5ofTHqYaSQTZ913puzEgT2mMR2sSfaV4emsaFkSnGa6PBcrk0
         /vDyvv7YbkF0+XfI8mWTYLhJ4deYQ5rSEEtyUNx3OecLMNO0XoiJJZF0UJ41qHi1xl3i
         HXrxUiWSoOMBBbjZtm4sEu+f1sP90rfj2vtSg6+CAxuESkMjDLTmCn85n7xbwQxT+Zib
         8yzlF0HdtnjjIx5h91wWdBreD6vrcAKS++4eX8Y+x1bm4CO+kHA0eFtM0qE4mfMl3ztn
         WPv+7m+sJFe8+bhnoWmEze21PEBRzDNFWFRn2fEkUM30YKKmzoELU9B4QYbMGWucw6P/
         WQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686563861; x=1689155861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pW6LNHkUsFsDtatHPA0cTf9hV8W1qigWKCpwsjlPFFw=;
        b=JBNnpyxQUIf6x0sVmifYmfUYv+K4VDMnyZ/RQ0su61oBoHHaPUS0yMgZ0yJbOQl0nw
         ncgjQKvJsA/mi4HujUlU4nCg053KsT1DfICtO8GkoOM9VBbTc4xesZd+O/8zsq9ImY4u
         qfYqwTu/mw/ZiZmzdWyORpWpA1hBCPSdRtT1M7a2OGGSIvC39qqTuGoPHfpB0U7Pdozj
         29vVVme6on5nazorfryucMMhMCbfPfyYo+qnGE+yUwdRv2kXKQDP+pFMPclKe1xgStjh
         1w12vZHh2orDv2GrIiFUcfxDpNDdhmGNK3rhk6EgfKz1xOkHWG5zhKhav/dYJYw2Eg+J
         t+lg==
X-Gm-Message-State: AC+VfDyl1Wc7/+zgjyhJsykDOA1AWUCGHj2UwUogOXEX8hCbPM0JGyJu
        1g4jPW72zawvGdkM+olMqYWM/A==
X-Google-Smtp-Source: ACHHUZ7mSX5HlmT+AV39OxscjjHTjDt0Mhmb1l1rw7w0rne9EpWVO1cKOdt1iAtqMy262JJ4HdbVRg==
X-Received: by 2002:a05:600c:34cf:b0:3f7:ecdf:ab2d with SMTP id d15-20020a05600c34cf00b003f7ecdfab2dmr8520586wmq.20.1686563861437;
        Mon, 12 Jun 2023 02:57:41 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f25-20020a7bcd19000000b003f7ff520a14sm10829525wmj.22.2023.06.12.02.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:57:41 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 12 Jun 2023 11:57:24 +0200
Subject: [PATCH v2 07/19] dt-bindings: clk: gxbb-clkc: expose all clock ids
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-7-38172d17c27a@linaro.org>
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-0-38172d17c27a@linaro.org>
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-0-38172d17c27a@linaro.org>
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8080;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=GEoLrmVkTd3U2cPEqC0OW2YcUoe4iepMGORul/q6OMA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkhuwHZCXvm7cZMrjnF1wfJtU6Eb5yVQEo4Hqqhw2e
 GaENpPaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIbsBwAKCRB33NvayMhJ0dVfEA
 DOsGUqJAuaqj30HPo9R5ZmiBoN8DCXuDm+Rxd2uZqC+U+UQQCZxzVkhXDuLvzA/u2KXpOMbR+h5Zel
 88mppTk7KO4uMxZGQvpMZY2jdrskR59+ZqsbP38eltvXuaQ3v0fkBr2sViXzNCLEENFUcewDUV5vDP
 38gghi+oETuXKDKBWckjtCDbZitqdISVXjBxGrZnTNCKJNI+bj2RZpGN9YiShZ6TNUUdzyhVz9Wwmz
 tC1rdJPKVgMYAhCUFAdGz4CvgUtnPUNV0M05El4Crnzxz2tqsK7QO6CFEHpaW+ZjEWDCjUGk6D9KHA
 NJbxiSyIbwHCaJFB78B+MZNgZywUCI03fJ/DN0/2IiDfAzPnQh8JGqECvVXo7U8EltpmdcINXL4MHG
 Kqo/Mz2q9skPlVN/HR08NWkI9zMRzXh5/yre/3B+XvakQj/1SiuoxV76zIQ0tU/5wK5Q21u/g1f/Ow
 VyqDgFE60wVwhSXX5pIBz5brNojlbFYOkIWta+DXu7/xuSo2Agd/HumCbv8IpLH9Wfc/oReL8keMlo
 9tjJGRPZ9TmNPDBikr59NNhYDvG68Wnv2HuBBg1Ba506jRAVgmRMIYZAIBlpc0jZzZdhZnIhxK1Q1e
 JkXpLfkFaPVP98bTENZM0gaFu7u0g7t69FSUP6S8fI4BsL3Dmba3wA1Ow1UQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

It was decided to move every gxbb-clkc ID to the public clock
dt-bindings headers to be merged in a single tree so we
can safely add new clocks without having merge issues.

[1] https://lore.kernel.org/all/c088e01c-0714-82be-8347-6140daf56640@linaro.org/
[2] https://lore.kernel.org/all/2fabe721-7434-43e7-bae5-088a42ba128d@app.fastmail.com/

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/gxbb.h              | 76 -----------------------------------
 include/dt-bindings/clock/gxbb-clkc.h | 65 ++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 76 deletions(-)

diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index 6751cda25986..798ffb911103 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -112,82 +112,6 @@
 #define HHI_BT656_CLK_CNTL		0x3D4 /* 0xf5 offset in data sheet */
 #define HHI_SAR_CLK_CNTL		0x3D8 /* 0xf6 offset in data sheet */
 
-/*
- * CLKID index values
- *
- * These indices are entirely contrived and do not map onto the hardware.
- * It has now been decided to expose everything by default in the DT header:
- * include/dt-bindings/clock/gxbb-clkc.h. Only the clocks ids we don't want
- * to expose, such as the internal muxes and dividers of composite clocks,
- * will remain defined here.
- */
-/* ID 1 is unused (it was used by the non-existing CLKID_CPUCLK before) */
-#define CLKID_MPEG_SEL		  10
-#define CLKID_MPEG_DIV		  11
-#define CLKID_SAR_ADC_DIV	  99
-#define CLKID_MALI_0_DIV	  101
-#define CLKID_MALI_1_DIV	  104
-#define CLKID_CTS_AMCLK_SEL	  108
-#define CLKID_CTS_AMCLK_DIV	  109
-#define CLKID_CTS_MCLK_I958_SEL	  111
-#define CLKID_CTS_MCLK_I958_DIV	  112
-#define CLKID_32K_CLK_SEL	  115
-#define CLKID_32K_CLK_DIV	  116
-#define CLKID_SD_EMMC_A_CLK0_SEL  117
-#define CLKID_SD_EMMC_A_CLK0_DIV  118
-#define CLKID_SD_EMMC_B_CLK0_SEL  120
-#define CLKID_SD_EMMC_B_CLK0_DIV  121
-#define CLKID_SD_EMMC_C_CLK0_SEL  123
-#define CLKID_SD_EMMC_C_CLK0_DIV  124
-#define CLKID_VPU_0_DIV		  127
-#define CLKID_VPU_1_DIV		  130
-#define CLKID_VAPB_0_DIV	  134
-#define CLKID_VAPB_1_DIV	  137
-#define CLKID_HDMI_PLL_PRE_MULT	  141
-#define CLKID_MPLL0_DIV		  142
-#define CLKID_MPLL1_DIV		  143
-#define CLKID_MPLL2_DIV		  144
-#define CLKID_MPLL_PREDIV	  145
-#define CLKID_FCLK_DIV2_DIV	  146
-#define CLKID_FCLK_DIV3_DIV	  147
-#define CLKID_FCLK_DIV4_DIV	  148
-#define CLKID_FCLK_DIV5_DIV	  149
-#define CLKID_FCLK_DIV7_DIV	  150
-#define CLKID_VDEC_1_SEL	  151
-#define CLKID_VDEC_1_DIV	  152
-#define CLKID_VDEC_HEVC_SEL	  154
-#define CLKID_VDEC_HEVC_DIV	  155
-#define CLKID_GEN_CLK_SEL	  157
-#define CLKID_GEN_CLK_DIV	  158
-#define CLKID_FIXED_PLL_DCO	  160
-#define CLKID_HDMI_PLL_DCO	  161
-#define CLKID_HDMI_PLL_OD	  162
-#define CLKID_HDMI_PLL_OD2	  163
-#define CLKID_SYS_PLL_DCO	  164
-#define CLKID_GP0_PLL_DCO	  165
-#define CLKID_VID_PLL_SEL	  167
-#define CLKID_VID_PLL_DIV	  168
-#define CLKID_VCLK_SEL		  169
-#define CLKID_VCLK2_SEL		  170
-#define CLKID_VCLK_INPUT	  171
-#define CLKID_VCLK2_INPUT	  172
-#define CLKID_VCLK_DIV		  173
-#define CLKID_VCLK2_DIV		  174
-#define CLKID_VCLK_DIV2_EN	  177
-#define CLKID_VCLK_DIV4_EN	  178
-#define CLKID_VCLK_DIV6_EN	  179
-#define CLKID_VCLK_DIV12_EN	  180
-#define CLKID_VCLK2_DIV2_EN	  181
-#define CLKID_VCLK2_DIV4_EN	  182
-#define CLKID_VCLK2_DIV6_EN	  183
-#define CLKID_VCLK2_DIV12_EN	  184
-#define CLKID_CTS_ENCI_SEL	  195
-#define CLKID_CTS_ENCP_SEL	  196
-#define CLKID_CTS_VDAC_SEL	  197
-#define CLKID_HDMI_TX_SEL	  198
-#define CLKID_HDMI_SEL		  203
-#define CLKID_HDMI_DIV		  204
-
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/gxbb-clkc.h>
 
diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
index 4073eb7a9da1..c0ce5e9c4151 100644
--- a/include/dt-bindings/clock/gxbb-clkc.h
+++ b/include/dt-bindings/clock/gxbb-clkc.h
@@ -15,6 +15,8 @@
 #define CLKID_FCLK_DIV5		7
 #define CLKID_FCLK_DIV7		8
 #define CLKID_GP0_PLL		9
+#define CLKID_MPEG_SEL		10
+#define CLKID_MPEG_DIV		11
 #define CLKID_CLK81		12
 #define CLKID_MPLL0		13
 #define CLKID_MPLL1		14
@@ -102,35 +104,92 @@
 #define CLKID_SD_EMMC_C		96
 #define CLKID_SAR_ADC_CLK	97
 #define CLKID_SAR_ADC_SEL	98
+#define CLKID_SAR_ADC_DIV	99
 #define CLKID_MALI_0_SEL	100
+#define CLKID_MALI_0_DIV	101
 #define CLKID_MALI_0		102
 #define CLKID_MALI_1_SEL	103
+#define CLKID_MALI_1_DIV	104
 #define CLKID_MALI_1		105
 #define CLKID_MALI		106
 #define CLKID_CTS_AMCLK		107
+#define CLKID_CTS_AMCLK_SEL	108
+#define CLKID_CTS_AMCLK_DIV	109
 #define CLKID_CTS_MCLK_I958	110
+#define CLKID_CTS_MCLK_I958_SEL	111
+#define CLKID_CTS_MCLK_I958_DIV 112
 #define CLKID_CTS_I958		113
 #define CLKID_32K_CLK		114
+#define CLKID_32K_CLK_SEL	115
+#define CLKID_32K_CLK_DIV	116
+#define CLKID_SD_EMMC_A_CLK0_SEL 117
+#define CLKID_SD_EMMC_A_CLK0_DIV 118
 #define CLKID_SD_EMMC_A_CLK0	119
+#define CLKID_SD_EMMC_B_CLK0_SEL 120
+#define CLKID_SD_EMMC_B_CLK0_DIV 121
 #define CLKID_SD_EMMC_B_CLK0	122
+#define CLKID_SD_EMMC_C_CLK0_SEL 123
+#define CLKID_SD_EMMC_C_CLK0_DIV 124
 #define CLKID_SD_EMMC_C_CLK0	125
 #define CLKID_VPU_0_SEL		126
+#define CLKID_VPU_0_DIV		127
 #define CLKID_VPU_0		128
 #define CLKID_VPU_1_SEL		129
+#define CLKID_VPU_1_DIV		130
 #define CLKID_VPU_1		131
 #define CLKID_VPU		132
 #define CLKID_VAPB_0_SEL	133
+#define CLKID_VAPB_0_DIV	134
 #define CLKID_VAPB_0		135
 #define CLKID_VAPB_1_SEL	136
+#define CLKID_VAPB_1_DIV	137
 #define CLKID_VAPB_1		138
 #define CLKID_VAPB_SEL		139
 #define CLKID_VAPB		140
+#define CLKID_HDMI_PLL_PRE_MULT	141
+#define CLKID_MPLL0_DIV		142
+#define CLKID_MPLL1_DIV		143
+#define CLKID_MPLL2_DIV		144
+#define CLKID_MPLL_PREDIV	145
+#define CLKID_FCLK_DIV2_DIV	146
+#define CLKID_FCLK_DIV3_DIV	147
+#define CLKID_FCLK_DIV4_DIV	148
+#define CLKID_FCLK_DIV5_DIV	149
+#define CLKID_FCLK_DIV7_DIV	150
+#define CLKID_VDEC_1_SEL	151
+#define CLKID_VDEC_1_DIV	152
 #define CLKID_VDEC_1		153
+#define CLKID_VDEC_HEVC_SEL	154
+#define CLKID_VDEC_HEVC_DIV	155
 #define CLKID_VDEC_HEVC		156
+#define CLKID_GEN_CLK_SEL	157
+#define CLKID_GEN_CLK_DIV	158
 #define CLKID_GEN_CLK		159
+#define CLKID_FIXED_PLL_DCO	160
+#define CLKID_HDMI_PLL_DCO	161
+#define CLKID_HDMI_PLL_OD	162
+#define CLKID_HDMI_PLL_OD2	163
+#define CLKID_SYS_PLL_DCO	164
+#define CLKID_GP0_PLL_DCO	165
 #define CLKID_VID_PLL		166
+#define CLKID_VID_PLL_SEL	167
+#define CLKID_VID_PLL_DIV	168
+#define CLKID_VCLK_SEL		169
+#define CLKID_VCLK2_SEL		170
+#define CLKID_VCLK_INPUT	171
+#define CLKID_VCLK2_INPUT	172
+#define CLKID_VCLK_DIV		173
+#define CLKID_VCLK2_DIV		174
 #define CLKID_VCLK		175
 #define CLKID_VCLK2		176
+#define CLKID_VCLK_DIV2_EN	177
+#define CLKID_VCLK_DIV4_EN	178
+#define CLKID_VCLK_DIV6_EN	179
+#define CLKID_VCLK_DIV12_EN	180
+#define CLKID_VCLK2_DIV2_EN	181
+#define CLKID_VCLK2_DIV4_EN	182
+#define CLKID_VCLK2_DIV6_EN	183
+#define CLKID_VCLK2_DIV12_EN	184
 #define CLKID_VCLK_DIV1		185
 #define CLKID_VCLK_DIV2		186
 #define CLKID_VCLK_DIV4		187
@@ -141,10 +200,16 @@
 #define CLKID_VCLK2_DIV4	192
 #define CLKID_VCLK2_DIV6	193
 #define CLKID_VCLK2_DIV12	194
+#define CLKID_CTS_ENCI_SEL	195
+#define CLKID_CTS_ENCP_SEL	196
+#define CLKID_CTS_VDAC_SEL	197
+#define CLKID_HDMI_TX_SEL	198
 #define CLKID_CTS_ENCI		199
 #define CLKID_CTS_ENCP		200
 #define CLKID_CTS_VDAC		201
 #define CLKID_HDMI_TX		202
+#define CLKID_HDMI_SEL		203
+#define CLKID_HDMI_DIV		204
 #define CLKID_HDMI		205
 #define CLKID_ACODEC		206
 

-- 
2.34.1

