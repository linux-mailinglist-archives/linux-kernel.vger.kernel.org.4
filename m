Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67ECF72BF2C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjFLKfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjFLKel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:34:41 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8E38A4A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:16:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6dfc4e01fso41930825e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686564944; x=1689156944;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbHf+IL1LUbmb6bIQ1QnD8svIjDZEIHNq/iB5p8Ynhk=;
        b=qTsqrCRoI1SlMNHPYIoSenkot+TI97imAKSIP7qodfi83YLP2skuV18QaXRM0oUFtt
         x4PLTYV5PNhoyV03BN3tqL3D3DWsmwiieH03kSXiNbVdWwE8khAr6caUxofA5T/Hfl5H
         pA0MRMpkpKTCVzkBwKFYkxqP9M+d610ZvRYmjnyiuTVMrWFMFIYoE0U+etgJdAxiqroy
         MzAg+JvrksLrthlUQGSd6WgaJBUmuZ3dZGbBynBwQsk98Ckm13mBGGL+bZhuRlGQvP9J
         qC36v0SlQ2kBW3ARTRh4ljW2PCF/xOxnus8Zx6m+w3TAeFwYvzjErPzFOJPesM5g5NCE
         BFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686564944; x=1689156944;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbHf+IL1LUbmb6bIQ1QnD8svIjDZEIHNq/iB5p8Ynhk=;
        b=bokQljdshcnMQBSTYtwmQp6E0OKDNj9J48eVcvUzypKV+PEN1Zb4+Ygi45wZR7nsrq
         TEcfNAnS0Ul71DUsZDwmDmjwKIqdc0L/0bwx9X9BKiV2Mnem+F7Np25CoSaMrkEWbisJ
         5KyH90nYmsZsseKHGHtdSkmQf5GILDUi/DXHQinyskXGXg4Wvlin33XweBk5D7g5jrQ0
         a4h6AXVElGNs2vuVQnFpIF0octnXfQ9x57KjI/ju3fMHccz0XTRyXCoiVKLYzqZAT/dw
         AeG9gi+EXKq27uIbPXVDLyC2uTIdAKhbCMIBpgZg8czLk5bDax0AvMIsUV/crQqER/LT
         sR4Q==
X-Gm-Message-State: AC+VfDwtT1kYr3puqL4s6BDvN0Bf5mCvkR/BPpnTWEjY1ygXyRQr83yC
        sg9a87raCQcrctKS79ZrjkaHZxicLRQnXlHUoQY23w==
X-Google-Smtp-Source: ACHHUZ6rMKubV+Yhbfrj2CxwMvftqavvFeWQK2uCaIcsrBnmv7wMoQMJKcLAmbLz7GX/9MSakxfHsA==
X-Received: by 2002:a1c:7708:0:b0:3f8:1729:f879 with SMTP id t8-20020a1c7708000000b003f81729f879mr2690033wmi.16.1686563862384;
        Mon, 12 Jun 2023 02:57:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f25-20020a7bcd19000000b003f7ff520a14sm10829525wmj.22.2023.06.12.02.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:57:42 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 12 Jun 2023 11:57:25 +0200
Subject: [PATCH v2 08/19] dt-bindings: clk: axg-clkc: expose all clock ids
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-8-38172d17c27a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6371;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=zwAa2o57kccACRvdkvpBerSAII7cBtUnqpo6Vgi95qo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkhuwIaAgDVc9AP5bZbhCnhZ83xloAs4gINtMKEiET
 wrT0kTOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIbsCAAKCRB33NvayMhJ0efvD/
 4x2N7+qvpkjBXMRMypdMS6fITuLX8rgeLZQYNmSK3EpXIswM0PMuafIXkr9huLD7OwJjiIO4k8s2ZE
 m5qtgQ+H+WvUzOYVtPpr0xqVrTvaRFjyuRF54MgcWzxappPAU6inch6t9BYSinZzPqOVgzXBn+EVLJ
 7ndzrvQk9Lh6NUmjZfJcJNY0MtmqQ1DNFoTjK6BySjFSzmRJkFmc/7iZ21F4MI+JhmXe0bvNFAYur7
 NuI/PpPSMen9bxPuKyRLEnLjSghHOblNaGeEpUaSWY7InEGyR2sUV0YWA8uqtqqOPOGeBY06Qhf7hl
 2e1Vkvk5rnR1aHNE46a1Ldp4P4YCt7kKhSba0gsfRt0g1jV7+a9GZWn+iPK2swUQoCrDBIEx7FbH6Q
 6WWj9mzww9+f84JFtQZxV2yPCuNw9mpJjeypFxgNByKpo6BcsG53Hz3JMAU8OPkHBvrJe6m+IP8ZPB
 MsR6hWLL27DcA06wQ8NUg5QXxZ4oHeRdxyN7T6OKOwlv9VtEhnQpBcnBYJkKD0Z6wtU7ZvCrN1Ynuo
 wf3BE27wE82c1SqJ/MWntfAOwWMTa2IeyvNe2JxBKstsIbDrkAMvGOiV7XrL8aqPpYJyb1B+lyODsG
 IpDzxZJByEdf+6ZJ5v/F9YiOXUda6l+hZTez1nnqvrUzBmJTrU2IfKjJokkw==
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

It was decided to move every axg-clkc ID to the public clock
dt-bindings headers to be merged in a single tree so we
can safely add new clocks without having merge issues.

[1] https://lore.kernel.org/all/c088e01c-0714-82be-8347-6140daf56640@linaro.org/
[2] https://lore.kernel.org/all/2fabe721-7434-43e7-bae5-088a42ba128d@app.fastmail.com/

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/axg.h              | 58 ------------------------------------
 include/dt-bindings/clock/axg-clkc.h | 48 +++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 58 deletions(-)

diff --git a/drivers/clk/meson/axg.h b/drivers/clk/meson/axg.h
index 39f9e2db82bd..ed157532b4d7 100644
--- a/drivers/clk/meson/axg.h
+++ b/drivers/clk/meson/axg.h
@@ -102,64 +102,6 @@
 #define HHI_DPLL_TOP_I			0x318
 #define HHI_DPLL_TOP2_I			0x31C
 
-/*
- * CLKID index values
- *
- * These indices are entirely contrived and do not map onto the hardware.
- * It has now been decided to expose everything by default in the DT header:
- * include/dt-bindings/clock/axg-clkc.h. Only the clocks ids we don't want
- * to expose, such as the internal muxes and dividers of composite clocks,
- * will remain defined here.
- */
-#define CLKID_MPEG_SEL				8
-#define CLKID_MPEG_DIV				9
-#define CLKID_SD_EMMC_B_CLK0_SEL		61
-#define CLKID_SD_EMMC_B_CLK0_DIV		62
-#define CLKID_SD_EMMC_C_CLK0_SEL		63
-#define CLKID_SD_EMMC_C_CLK0_DIV		64
-#define CLKID_MPLL0_DIV				65
-#define CLKID_MPLL1_DIV				66
-#define CLKID_MPLL2_DIV				67
-#define CLKID_MPLL3_DIV				68
-#define CLKID_MPLL_PREDIV			70
-#define CLKID_FCLK_DIV2_DIV			71
-#define CLKID_FCLK_DIV3_DIV			72
-#define CLKID_FCLK_DIV4_DIV			73
-#define CLKID_FCLK_DIV5_DIV			74
-#define CLKID_FCLK_DIV7_DIV			75
-#define CLKID_PCIE_PLL				76
-#define CLKID_PCIE_MUX				77
-#define CLKID_PCIE_REF				78
-#define CLKID_GEN_CLK_SEL			82
-#define CLKID_GEN_CLK_DIV			83
-#define CLKID_SYS_PLL_DCO			85
-#define CLKID_FIXED_PLL_DCO			86
-#define CLKID_GP0_PLL_DCO			87
-#define CLKID_HIFI_PLL_DCO			88
-#define CLKID_PCIE_PLL_DCO			89
-#define CLKID_PCIE_PLL_OD			90
-#define CLKID_VPU_0_DIV				91
-#define CLKID_VPU_1_DIV				94
-#define CLKID_VAPB_0_DIV			98
-#define CLKID_VAPB_1_DIV			101
-#define CLKID_VCLK_SEL				108
-#define CLKID_VCLK2_SEL				109
-#define CLKID_VCLK_INPUT			110
-#define CLKID_VCLK2_INPUT			111
-#define CLKID_VCLK_DIV				112
-#define CLKID_VCLK2_DIV				113
-#define CLKID_VCLK_DIV2_EN			114
-#define CLKID_VCLK_DIV4_EN			115
-#define CLKID_VCLK_DIV6_EN			116
-#define CLKID_VCLK_DIV12_EN			117
-#define CLKID_VCLK2_DIV2_EN			118
-#define CLKID_VCLK2_DIV4_EN			119
-#define CLKID_VCLK2_DIV6_EN			120
-#define CLKID_VCLK2_DIV12_EN			121
-#define CLKID_CTS_ENCL_SEL			132
-#define CLKID_VDIN_MEAS_SEL			134
-#define CLKID_VDIN_MEAS_DIV			135
-
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/axg-clkc.h>
 
diff --git a/include/dt-bindings/clock/axg-clkc.h b/include/dt-bindings/clock/axg-clkc.h
index 93752ea107e3..442162822b88 100644
--- a/include/dt-bindings/clock/axg-clkc.h
+++ b/include/dt-bindings/clock/axg-clkc.h
@@ -16,6 +16,8 @@
 #define CLKID_FCLK_DIV5				5
 #define CLKID_FCLK_DIV7				6
 #define CLKID_GP0_PLL				7
+#define CLKID_MPEG_SEL				8
+#define CLKID_MPEG_DIV				9
 #define CLKID_CLK81				10
 #define CLKID_MPLL0				11
 #define CLKID_MPLL1				12
@@ -67,23 +69,66 @@
 #define CLKID_AO_I2C				58
 #define CLKID_SD_EMMC_B_CLK0			59
 #define CLKID_SD_EMMC_C_CLK0			60
+#define CLKID_SD_EMMC_B_CLK0_SEL		61
+#define CLKID_SD_EMMC_B_CLK0_DIV		62
+#define CLKID_SD_EMMC_C_CLK0_SEL		63
+#define CLKID_SD_EMMC_C_CLK0_DIV		64
+#define CLKID_MPLL0_DIV				65
+#define CLKID_MPLL1_DIV				66
+#define CLKID_MPLL2_DIV				67
+#define CLKID_MPLL3_DIV				68
 #define CLKID_HIFI_PLL				69
+#define CLKID_MPLL_PREDIV			70
+#define CLKID_FCLK_DIV2_DIV			71
+#define CLKID_FCLK_DIV3_DIV			72
+#define CLKID_FCLK_DIV4_DIV			73
+#define CLKID_FCLK_DIV5_DIV			74
+#define CLKID_FCLK_DIV7_DIV			75
+#define CLKID_PCIE_PLL				76
+#define CLKID_PCIE_MUX				77
+#define CLKID_PCIE_REF				78
 #define CLKID_PCIE_CML_EN0			79
 #define CLKID_PCIE_CML_EN1			80
+#define CLKID_GEN_CLK_SEL			82
+#define CLKID_GEN_CLK_DIV			83
 #define CLKID_GEN_CLK				84
+#define CLKID_SYS_PLL_DCO			85
+#define CLKID_FIXED_PLL_DCO			86
+#define CLKID_GP0_PLL_DCO			87
+#define CLKID_HIFI_PLL_DCO			88
+#define CLKID_PCIE_PLL_DCO			89
+#define CLKID_PCIE_PLL_OD			90
+#define CLKID_VPU_0_DIV				91
 #define CLKID_VPU_0_SEL				92
 #define CLKID_VPU_0				93
+#define CLKID_VPU_1_DIV				94
 #define CLKID_VPU_1_SEL				95
 #define CLKID_VPU_1				96
 #define CLKID_VPU				97
+#define CLKID_VAPB_0_DIV			98
 #define CLKID_VAPB_0_SEL			99
 #define CLKID_VAPB_0				100
+#define CLKID_VAPB_1_DIV			101
 #define CLKID_VAPB_1_SEL			102
 #define CLKID_VAPB_1				103
 #define CLKID_VAPB_SEL				104
 #define CLKID_VAPB				105
 #define CLKID_VCLK				106
 #define CLKID_VCLK2				107
+#define CLKID_VCLK_SEL				108
+#define CLKID_VCLK2_SEL				109
+#define CLKID_VCLK_INPUT			110
+#define CLKID_VCLK2_INPUT			111
+#define CLKID_VCLK_DIV				112
+#define CLKID_VCLK2_DIV				113
+#define CLKID_VCLK_DIV2_EN			114
+#define CLKID_VCLK_DIV4_EN			115
+#define CLKID_VCLK_DIV6_EN			116
+#define CLKID_VCLK_DIV12_EN			117
+#define CLKID_VCLK2_DIV2_EN			118
+#define CLKID_VCLK2_DIV4_EN			119
+#define CLKID_VCLK2_DIV6_EN			120
+#define CLKID_VCLK2_DIV12_EN			121
 #define CLKID_VCLK_DIV1				122
 #define CLKID_VCLK_DIV2				123
 #define CLKID_VCLK_DIV4				124
@@ -94,7 +139,10 @@
 #define CLKID_VCLK2_DIV4			129
 #define CLKID_VCLK2_DIV6			130
 #define CLKID_VCLK2_DIV12			131
+#define CLKID_CTS_ENCL_SEL			132
 #define CLKID_CTS_ENCL				133
+#define CLKID_VDIN_MEAS_SEL			134
+#define CLKID_VDIN_MEAS_DIV			135
 #define CLKID_VDIN_MEAS				136
 
 #endif /* __AXG_CLKC_H */

-- 
2.34.1

