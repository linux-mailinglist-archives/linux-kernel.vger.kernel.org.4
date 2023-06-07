Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0994E725C52
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbjFGK5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240033AbjFGK5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:57:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD92269D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:56:34 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3094910b150so7279476f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 03:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686135389; x=1688727389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTcB7fhvFZXuSVWwIsQAqPywer1oTBzWj1Dj0kwpdmg=;
        b=AVxfAGTqsO3F9VB2LBNBJEbp/WcziRZhsovq5RbHqPyZ7E3qxrySl7P3MC792JXYOq
         gjkpwLBdjQFKX2Rq95cU3q+6EPL1dqqEmn7VlK2DW9clURYnZ/q35VrokfhSr2ILYAXm
         +Q0nxH9NfbK5o1ZAYL/jWbVTa+b/gBwDGBH3sq7vvDKidtXg38trxhAaGgzu7GZ6QVQn
         5fcQgbHMEv8bQCbiaM97uWAEiFwD2Qkwoy9hNb8a0GLmidgoL6EPW9jZ6A77a3afpWkX
         o8Y3vYeqCTcifkPlE/S3NM/YBzpczOXjeo2xC26JcUFZtU09ub0ioSnUYrQE1BEle77t
         /trA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686135389; x=1688727389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTcB7fhvFZXuSVWwIsQAqPywer1oTBzWj1Dj0kwpdmg=;
        b=WitnyfpEInz7y2vwAOqemZkKy52iKIppIKFhRtJyPcxdR0J0NMNlT1uYeMaXEAZPLp
         lvhu+WqXiNii86FVYDXQHqN+JTwhIJPOinT8He14GCMGEWPYATuVdqGgZng7Mgjjv3oV
         wZ7Lo+iRhsGvX0j/DrDjjTyU6gxmpi1GNq87FQAQkM0Ybw6NpbCwcvXiGI5y/TgF2FXl
         GWnDrH3pJ2oW28WHm+naqRbdXW+yrE5NVQVxuanM66s9/dBwTkG1kLuhn2TebUELHFDW
         O0JJ70kyVpZHaiMV8Olelgl6Y4/TOMDAnZu7jkZwf3c2Dhel8ZC/hlHRjI9Vora2KVVZ
         lIJQ==
X-Gm-Message-State: AC+VfDxAkJMu/1WWf8nux95mI3+sm1zPm+Eldd4cFlpjydJLt/SBE8+N
        /qUo5tIyNLWq/3egcz6F9ZcY1A==
X-Google-Smtp-Source: ACHHUZ4fumcrKb8pooiAOdPPz0B8CCI+n6EuNqbae5B4JgTIBFlK+dELGeYqUfhpIfRCX9dJdTEANQ==
X-Received: by 2002:a5d:464c:0:b0:30d:779a:111d with SMTP id j12-20020a5d464c000000b0030d779a111dmr4284506wrs.17.1686135389303;
        Wed, 07 Jun 2023 03:56:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c290a00b003f60faa4612sm1761879wmd.22.2023.06.07.03.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:56:28 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 07 Jun 2023 12:56:17 +0200
Subject: [PATCH 06/18] dt-bindings: clk: gxbb-clkc: expose all clock ids
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-6-9676afa6b22c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8016;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=KiKGGALlXn5bKD15xyCXq+2b6M4JCPjE8pgNXBuK/xo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkgGJQnOEa43QHK7iLufgTFPbo9+zefPo3FS6933Jm
 YhRfR9OJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIBiUAAKCRB33NvayMhJ0V+mEA
 DLptDPB1zQk77Q7NvjeIu/6JAlaXYpRMCUKJtt/DC52QuI2C78LuipBWsT6dlV5w1xxjkOBPkc8D67
 jy2OYlh9iCPP4ttqQ+p9gXv6DSfdK5e9kBe4b7nuVwxr+sOyNobWb/2dQPQez0y4yVIAjPzL9NTJWW
 YZNLEJOLcXbn/vcR3669VBkkgOK0q4vOtmvKD5wiiJ3Grl4DU7SOm2Y+OJY0BvSPh/+VxORrrdMFpP
 5MHqDoahaBlhInA/MMszjrIfdWdimNJvJEOCF6Yv+Hr3+kfAtBSdQI33ZtiCEOveqJ6HZrXs10NQTl
 3hZq1XCFS0LdpPJYU2MkR2+e5ekjeELPFTXi+5Tu4NVtCp47oHZrzVMNldtvHUuBb5lInIhhn18YDy
 VE/rs7inxAcp7IYoMjKlY9EVrtr1uRXCNhJZ7eIOYVkfkmai66zwWrLZ4R9YKYbuuZWvJZ+akbqaW4
 ZDXujm4IoPJqm3a8gj/SvDCaGruVlpOnngHgi0vqIyYLRaAglL0frIercFL/GZepkOAY3W32oxzN0X
 q/XQmfwrZ0s51jyM+MmVq6KHazDlakyMENSQRN5FyIcYbWSI9HVSDP0AxRLhM50LvGW5LU8PMkxP79
 txfqPU25SgJr3JpXW4nZDhJEKkqsSFxxTwiDgGKB/U6gV1hw4t2CZdUKXlog==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

