Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6E862D988
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbiKQLha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239716AbiKQLg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:36:56 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7FE67F75
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:36:53 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id f18so4349436ejz.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rl6wZCAHM6P6IFwXGM/MR+ypnVw95L969SDFtD13ca0=;
        b=ozxzcdyD90On+2gTxP5SUgO5llMd2R6w0uGmvYJP98NuOQ0S9G/4M4toM+M5XI/mQw
         ZidgObGOTsKCDBAVmWb6GIdl2iigZyM5erPMqTx01cEUGJHHzO209sntd2MCA59bEcpP
         cJGqH2DlDBpz6mlWyk4sX/ZjuEXvCP/IDjeIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rl6wZCAHM6P6IFwXGM/MR+ypnVw95L969SDFtD13ca0=;
        b=zUOzY5h+JpofMsqCUKTj8URf3K8xhpLSY+FRZKg2N1Oddatbnh/iPHJsVrwuIWuKay
         zkSD84byvebC23a0kfUR+RaV1gSQWbezU6Ud4A8rLh2yI6s4iWuQSXGOVEW177f/wFOr
         kM6l4VTOD3Y7sOmwd4gMmUPDZ7BGkWDZzdHZeKdUD9UXgIX+VoVD+sQjpanyOXLeOBQM
         oGTxaYFa5SdKHrnbdLNx1eTdYVBfuurPEklsPKaB8Hk3Tl21u5pihjU7bqUXt7tqCwjv
         tWlxwm6mxmvYgTmP3YcokGYbGhyCRJpDhGpbzDedceCaGFWkEuFqGeFerqvtsXdexd3H
         1C5g==
X-Gm-Message-State: ANoB5pnmN3LOQKvwTRBnwibVxZy2UQqwgi+x0Rr9xWLH8SNnXZ6vXHEF
        JMpKhUsiHRDTPB+y9/wenRHlU7T/TV9SSQ==
X-Google-Smtp-Source: AA0mqf7kCdYsnpf/wlpecleW1xbZzFekkAt075piUcAc0HL5sNuqoSDI7E7pMUxCMuk5VxvbZEFRQw==
X-Received: by 2002:a17:906:b210:b0:7ae:d116:fabb with SMTP id p16-20020a170906b21000b007aed116fabbmr1744882ejz.317.1668685011937;
        Thu, 17 Nov 2022 03:36:51 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (mob-5-90-137-239.net.vodafone.it. [5.90.137.239])
        by smtp.gmail.com with ESMTPSA id g3-20020aa7c843000000b0043bbb3535d6sm413897edt.66.2022.11.17.03.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 03:36:51 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 3/5] clk: imx: rename video_pll1 to video_pll
Date:   Thu, 17 Nov 2022 12:36:35 +0100
Message-Id: <20221117113637.1978703-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221117113637.1978703-1-dario.binacchi@amarulasolutions.com>
References: <20221117113637.1978703-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike audio_pll1 and audio_pll2, there is no video_pll2. Further, the
name used in the RM is video_pll. So, let's rename "video_pll1" to
"video_pll" to be consistent with the RM and avoid misunderstandings.

The IMX8MN_VIDEO_PLL1* constants have not been removed to ensure
backward compatibility of the patch.

No functional changes intended.

Fixes: 96d6392b54dbb ("clk: imx: Add support for i.MX8MN clock driver")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Update the commit message.
- Add Fixes tag.
- Maintain IMX8MN_VIDEO_PLL1* constants to not break backward
  compatibility.

 drivers/clk/imx/clk-imx8mn.c             | 96 ++++++++++++------------
 include/dt-bindings/clock/imx8mn-clock.h | 12 ++-
 2 files changed, 56 insertions(+), 52 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 0fae97e61e2c..b80af5d1ef46 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -27,7 +27,7 @@ static u32 share_count_nand;
 static const char * const pll_ref_sels[] = { "osc_24m", "dummy", "dummy", "dummy", };
 static const char * const audio_pll1_bypass_sels[] = {"audio_pll1", "audio_pll1_ref_sel", };
 static const char * const audio_pll2_bypass_sels[] = {"audio_pll2", "audio_pll2_ref_sel", };
-static const char * const video_pll1_bypass_sels[] = {"video_pll1", "video_pll1_ref_sel", };
+static const char * const video_pll_bypass_sels[] = {"video_pll", "video_pll_ref_sel", };
 static const char * const dram_pll_bypass_sels[] = {"dram_pll", "dram_pll_ref_sel", };
 static const char * const gpu_pll_bypass_sels[] = {"gpu_pll", "gpu_pll_ref_sel", };
 static const char * const m7_alt_pll_bypass_sels[] = {"m7_alt_pll", "m7_alt_pll_ref_sel", };
@@ -41,23 +41,23 @@ static const char * const imx8mn_a53_sels[] = {"osc_24m", "arm_pll_out", "sys_pl
 static const char * const imx8mn_a53_core_sels[] = {"arm_a53_div", "arm_pll_out", };
 
 static const char * const imx8mn_m7_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll2_250m", "m7_alt_pll_out",
-				       "sys_pll1_800m", "audio_pll1_out", "video_pll1_out", "sys_pll3_out", };
+				       "sys_pll1_800m", "audio_pll1_out", "video_pll_out", "sys_pll3_out", };
 
 static const char * const imx8mn_gpu_core_sels[] = {"osc_24m", "gpu_pll_out", "sys_pll1_800m",
 						    "sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
-						    "video_pll1_out", "audio_pll2_out", };
+						    "video_pll_out", "audio_pll2_out", };
 
 static const char * const imx8mn_gpu_shader_sels[] = {"osc_24m", "gpu_pll_out", "sys_pll1_800m",
 						      "sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
-						      "video_pll1_out", "audio_pll2_out", };
+						      "video_pll_out", "audio_pll2_out", };
 
 static const char * const imx8mn_main_axi_sels[] = {"osc_24m", "sys_pll2_333m", "sys_pll1_800m",
 						    "sys_pll2_250m", "sys_pll2_1000m", "audio_pll1_out",
-						    "video_pll1_out", "sys_pll1_100m",};
+						    "video_pll_out", "sys_pll1_100m",};
 
 static const char * const imx8mn_enet_axi_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll1_800m",
 						    "sys_pll2_250m", "sys_pll2_200m", "audio_pll1_out",
-						    "video_pll1_out", "sys_pll3_out", };
+						    "video_pll_out", "sys_pll3_out", };
 
 static const char * const imx8mn_nand_usdhc_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll1_800m",
 						      "sys_pll2_200m", "sys_pll1_133m", "sys_pll3_out",
@@ -77,23 +77,23 @@ static const char * const imx8mn_usb_bus_sels[] = {"osc_24m", "sys_pll2_500m", "
 
 static const char * const imx8mn_gpu_axi_sels[] = {"osc_24m", "sys_pll1_800m", "gpu_pll_out",
 						   "sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
-						   "video_pll1_out", "audio_pll2_out", };
+						   "video_pll_out", "audio_pll2_out", };
 
 static const char * const imx8mn_gpu_ahb_sels[] = {"osc_24m", "sys_pll1_800m", "gpu_pll_out",
 						   "sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
-						   "video_pll1_out", "audio_pll2_out", };
+						   "video_pll_out", "audio_pll2_out", };
 
 static const char * const imx8mn_noc_sels[] = {"osc_24m", "sys_pll1_800m", "sys_pll3_out",
 					       "sys_pll2_1000m", "sys_pll2_500m", "audio_pll1_out",
-					       "video_pll1_out", "audio_pll2_out", };
+					       "video_pll_out", "audio_pll2_out", };
 
 static const char * const imx8mn_ahb_sels[] = {"osc_24m", "sys_pll1_133m", "sys_pll1_800m",
 					       "sys_pll1_400m", "sys_pll2_125m", "sys_pll3_out",
-					       "audio_pll1_out", "video_pll1_out", };
+					       "audio_pll1_out", "video_pll_out", };
 
 static const char * const imx8mn_audio_ahb_sels[] = {"osc_24m", "sys_pll2_500m", "sys_pll1_800m",
 						     "sys_pll2_1000m", "sys_pll2_166m", "sys_pll3_out",
-						     "audio_pll1_out", "video_pll1_out", };
+						     "audio_pll1_out", "video_pll_out", };
 
 static const char * const imx8mn_dram_alt_sels[] = {"osc_24m", "sys_pll1_800m", "sys_pll1_100m",
 						    "sys_pll2_500m", "sys_pll2_1000m", "sys_pll3_out",
@@ -103,49 +103,49 @@ static const char * const imx8mn_dram_apb_sels[] = {"osc_24m", "sys_pll2_200m",
 						    "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
 						    "sys_pll2_250m", "audio_pll2_out", };
 
-static const char * const imx8mn_disp_pixel_sels[] = {"osc_24m", "video_pll1_out", "audio_pll2_out",
+static const char * const imx8mn_disp_pixel_sels[] = {"osc_24m", "video_pll_out", "audio_pll2_out",
 						      "audio_pll1_out", "sys_pll1_800m", "sys_pll2_1000m",
 						      "sys_pll3_out", "clk_ext4", };
 
 static const char * const imx8mn_sai2_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "dummy",
+						"video_pll_out", "sys_pll1_133m", "dummy",
 						"clk_ext3", "clk_ext4", };
 
 static const char * const imx8mn_sai3_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "dummy",
+						"video_pll_out", "sys_pll1_133m", "dummy",
 						"clk_ext3", "clk_ext4", };
 
 static const char * const imx8mn_sai5_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "dummy",
+						"video_pll_out", "sys_pll1_133m", "dummy",
 						"clk_ext2", "clk_ext3", };
 
 static const char * const imx8mn_sai6_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "dummy",
+						"video_pll_out", "sys_pll1_133m", "dummy",
 						"clk_ext3", "clk_ext4", };
 
 static const char * const imx8mn_sai7_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "dummy",
+						"video_pll_out", "sys_pll1_133m", "dummy",
 						"clk_ext3", "clk_ext4", };
 
 static const char * const imx8mn_spdif1_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						  "video_pll1_out", "sys_pll1_133m", "dummy",
+						  "video_pll_out", "sys_pll1_133m", "dummy",
 						  "clk_ext2", "clk_ext3", };
 
 static const char * const imx8mn_enet_ref_sels[] = {"osc_24m", "sys_pll2_125m", "sys_pll2_50m",
 						    "sys_pll2_100m", "sys_pll1_160m", "audio_pll1_out",
-						    "video_pll1_out", "clk_ext4", };
+						    "video_pll_out", "clk_ext4", };
 
 static const char * const imx8mn_enet_timer_sels[] = {"osc_24m", "sys_pll2_100m", "audio_pll1_out",
 						      "clk_ext1", "clk_ext2", "clk_ext3",
-						      "clk_ext4", "video_pll1_out", };
+						      "clk_ext4", "video_pll_out", };
 
 static const char * const imx8mn_enet_phy_sels[] = {"osc_24m", "sys_pll2_50m", "sys_pll2_125m",
-						    "sys_pll2_200m", "sys_pll2_500m", "video_pll1_out",
+						    "sys_pll2_200m", "sys_pll2_500m", "video_pll_out",
 						    "audio_pll2_out", };
 
 static const char * const imx8mn_nand_sels[] = {"osc_24m", "sys_pll2_500m", "audio_pll1_out",
 						"sys_pll1_400m", "audio_pll2_out", "sys_pll3_out",
-						"sys_pll2_250m", "video_pll1_out", };
+						"sys_pll2_250m", "video_pll_out", };
 
 static const char * const imx8mn_qspi_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll2_333m",
 						"sys_pll2_500m", "audio_pll2_out", "sys_pll1_266m",
@@ -160,19 +160,19 @@ static const char * const imx8mn_usdhc2_sels[] = {"osc_24m", "sys_pll1_400m", "s
 						  "audio_pll2_out", "sys_pll1_100m", };
 
 static const char * const imx8mn_i2c1_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
-						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
+						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
 static const char * const imx8mn_i2c2_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
-						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
+						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
 static const char * const imx8mn_i2c3_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
-						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
+						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
 static const char * const imx8mn_i2c4_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
-						"sys_pll3_out",	"audio_pll1_out", "video_pll1_out",
+						"sys_pll3_out",	"audio_pll1_out", "video_pll_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
 static const char * const imx8mn_uart1_sels[] = {"osc_24m", "sys_pll1_80m", "sys_pll2_200m",
@@ -213,42 +213,42 @@ static const char * const imx8mn_ecspi2_sels[] = {"osc_24m", "sys_pll2_200m", "s
 
 static const char * const imx8mn_pwm1_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
-						"sys_pll1_80m", "video_pll1_out", };
+						"sys_pll1_80m", "video_pll_out", };
 
 static const char * const imx8mn_pwm2_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
-						"sys_pll1_80m", "video_pll1_out", };
+						"sys_pll1_80m", "video_pll_out", };
 
 static const char * const imx8mn_pwm3_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
-						"sys_pll1_80m", "video_pll1_out", };
+						"sys_pll1_80m", "video_pll_out", };
 
 static const char * const imx8mn_pwm4_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
-						"sys_pll1_80m", "video_pll1_out", };
+						"sys_pll1_80m", "video_pll_out", };
 
 static const char * const imx8mn_gpt1_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
-						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
 						"audio_pll1_out", "clk_ext1", };
 
 static const char * const imx8mn_gpt2_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
-						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
 						"audio_pll1_out", "clk_ext1", };
 
 static const char * const imx8mn_gpt3_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
-						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
 						"audio_pll1_out", "clk_ext1", };
 
 static const char * const imx8mn_gpt4_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
-						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
 						"audio_pll1_out", "clk_ext1", };
 
 static const char * const imx8mn_gpt5_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
-						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
 						"audio_pll1_out", "clk_ext1", };
 
 static const char * const imx8mn_gpt6_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
-						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
 						"audio_pll1_out", "clk_ext1", };
 
 static const char * const imx8mn_wdog_sels[] = {"osc_24m", "sys_pll1_133m", "sys_pll1_160m",
@@ -261,15 +261,15 @@ static const char * const imx8mn_wrclk_sels[] = {"osc_24m", "sys_pll1_40m", "m7_
 
 static const char * const imx8mn_dsi_core_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll2_250m",
 						    "sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out",
-						    "audio_pll2_out", "video_pll1_out", };
+						    "audio_pll2_out", "video_pll_out", };
 
 static const char * const imx8mn_dsi_phy_sels[] = {"osc_24m", "sys_pll2_125m", "sys_pll2_100m",
 						   "sys_pll1_800m", "sys_pll2_1000m", "clk_ext2",
-						   "audio_pll2_out", "video_pll1_out", };
+						   "audio_pll2_out", "video_pll_out", };
 
 static const char * const imx8mn_dsi_dbi_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll2_100m",
 						   "sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out",
-						   "audio_pll2_out", "video_pll1_out", };
+						   "audio_pll2_out", "video_pll_out", };
 
 static const char * const imx8mn_usdhc3_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll1_800m",
 						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
@@ -277,15 +277,15 @@ static const char * const imx8mn_usdhc3_sels[] = {"osc_24m", "sys_pll1_400m", "s
 
 static const char * const imx8mn_camera_pixel_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll2_250m",
 							"sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out",
-							"audio_pll2_out", "video_pll1_out", };
+							"audio_pll2_out", "video_pll_out", };
 
 static const char * const imx8mn_csi1_phy_sels[] = {"osc_24m", "sys_pll2_333m", "sys_pll2_100m",
 						    "sys_pll1_800m", "sys_pll2_1000m", "clk_ext2",
-						    "audio_pll2_out", "video_pll1_out", };
+						    "audio_pll2_out", "video_pll_out", };
 
 static const char * const imx8mn_csi2_phy_sels[] = {"osc_24m", "sys_pll2_333m", "sys_pll2_100m",
 						    "sys_pll1_800m", "sys_pll2_1000m", "clk_ext2",
-						    "audio_pll2_out", "video_pll1_out", };
+						    "audio_pll2_out", "video_pll_out", };
 
 static const char * const imx8mn_csi2_esc_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_80m",
 						    "sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out",
@@ -306,9 +306,9 @@ static const char * const imx8mn_clko1_sels[] = {"osc_24m", "sys_pll1_800m", "du
 						 "dummy", "sys_pll1_80m", };
 static const char * const imx8mn_clko2_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_400m",
 						 "sys_pll2_166m", "sys_pll3_out", "audio_pll1_out",
-						 "video_pll1_out", "osc_32k", };
+						 "video_pll_out", "osc_32k", };
 
-static const char * const clkout_sels[] = {"audio_pll1_out", "audio_pll2_out", "video_pll1_out",
+static const char * const clkout_sels[] = {"audio_pll1_out", "audio_pll2_out", "video_pll_out",
 					   "dummy", "dummy", "gpu_pll_out", "dummy",
 					   "arm_pll_out", "sys_pll1", "sys_pll2", "sys_pll3",
 					   "dummy", "dummy", "osc_24m", "dummy", "osc_32k"};
@@ -349,7 +349,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 
 	hws[IMX8MN_AUDIO_PLL1_REF_SEL] = imx_clk_hw_mux("audio_pll1_ref_sel", base + 0x0, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MN_AUDIO_PLL2_REF_SEL] = imx_clk_hw_mux("audio_pll2_ref_sel", base + 0x14, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	hws[IMX8MN_VIDEO_PLL1_REF_SEL] = imx_clk_hw_mux("video_pll1_ref_sel", base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	hws[IMX8MN_VIDEO_PLL_REF_SEL] = imx_clk_hw_mux("video_pll_ref_sel", base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MN_DRAM_PLL_REF_SEL] = imx_clk_hw_mux("dram_pll_ref_sel", base + 0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MN_GPU_PLL_REF_SEL] = imx_clk_hw_mux("gpu_pll_ref_sel", base + 0x64, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MN_M7_ALT_PLL_REF_SEL] = imx_clk_hw_mux("m7_alt_pll_ref_sel", base + 0x74, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
@@ -358,7 +358,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 
 	hws[IMX8MN_AUDIO_PLL1] = imx_clk_hw_pll14xx("audio_pll1", "audio_pll1_ref_sel", base, &imx_1443x_pll);
 	hws[IMX8MN_AUDIO_PLL2] = imx_clk_hw_pll14xx("audio_pll2", "audio_pll2_ref_sel", base + 0x14, &imx_1443x_pll);
-	hws[IMX8MN_VIDEO_PLL1] = imx_clk_hw_pll14xx("video_pll1", "video_pll1_ref_sel", base + 0x28, &imx_1443x_pll);
+	hws[IMX8MN_VIDEO_PLL] = imx_clk_hw_pll14xx("video_pll", "video_pll_ref_sel", base + 0x28, &imx_1443x_pll);
 	hws[IMX8MN_DRAM_PLL] = imx_clk_hw_pll14xx("dram_pll", "dram_pll_ref_sel", base + 0x50, &imx_1443x_dram_pll);
 	hws[IMX8MN_GPU_PLL] = imx_clk_hw_pll14xx("gpu_pll", "gpu_pll_ref_sel", base + 0x64, &imx_1416x_pll);
 	hws[IMX8MN_M7_ALT_PLL] = imx_clk_hw_pll14xx("m7_alt_pll", "m7_alt_pll_ref_sel", base + 0x74, &imx_1416x_pll);
@@ -370,7 +370,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	/* PLL bypass out */
 	hws[IMX8MN_AUDIO_PLL1_BYPASS] = imx_clk_hw_mux_flags("audio_pll1_bypass", base, 16, 1, audio_pll1_bypass_sels, ARRAY_SIZE(audio_pll1_bypass_sels), CLK_SET_RATE_PARENT);
 	hws[IMX8MN_AUDIO_PLL2_BYPASS] = imx_clk_hw_mux_flags("audio_pll2_bypass", base + 0x14, 16, 1, audio_pll2_bypass_sels, ARRAY_SIZE(audio_pll2_bypass_sels), CLK_SET_RATE_PARENT);
-	hws[IMX8MN_VIDEO_PLL1_BYPASS] = imx_clk_hw_mux_flags("video_pll1_bypass", base + 0x28, 16, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass_sels), CLK_SET_RATE_PARENT);
+	hws[IMX8MN_VIDEO_PLL_BYPASS] = imx_clk_hw_mux_flags("video_pll_bypass", base + 0x28, 16, 1, video_pll_bypass_sels, ARRAY_SIZE(video_pll_bypass_sels), CLK_SET_RATE_PARENT);
 	hws[IMX8MN_DRAM_PLL_BYPASS] = imx_clk_hw_mux_flags("dram_pll_bypass", base + 0x50, 16, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels), CLK_SET_RATE_PARENT);
 	hws[IMX8MN_GPU_PLL_BYPASS] = imx_clk_hw_mux_flags("gpu_pll_bypass", base + 0x64, 28, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels), CLK_SET_RATE_PARENT);
 	hws[IMX8MN_M7_ALT_PLL_BYPASS] = imx_clk_hw_mux_flags("m7_alt_pll_bypass", base + 0x74, 28, 1, m7_alt_pll_bypass_sels, ARRAY_SIZE(m7_alt_pll_bypass_sels), CLK_SET_RATE_PARENT);
@@ -380,7 +380,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	/* PLL out gate */
 	hws[IMX8MN_AUDIO_PLL1_OUT] = imx_clk_hw_gate("audio_pll1_out", "audio_pll1_bypass", base, 13);
 	hws[IMX8MN_AUDIO_PLL2_OUT] = imx_clk_hw_gate("audio_pll2_out", "audio_pll2_bypass", base + 0x14, 13);
-	hws[IMX8MN_VIDEO_PLL1_OUT] = imx_clk_hw_gate("video_pll1_out", "video_pll1_bypass", base + 0x28, 13);
+	hws[IMX8MN_VIDEO_PLL_OUT] = imx_clk_hw_gate("video_pll_out", "video_pll_bypass", base + 0x28, 13);
 	hws[IMX8MN_DRAM_PLL_OUT] = imx_clk_hw_gate("dram_pll_out", "dram_pll_bypass", base + 0x50, 13);
 	hws[IMX8MN_GPU_PLL_OUT] = imx_clk_hw_gate("gpu_pll_out", "gpu_pll_bypass", base + 0x64, 11);
 	hws[IMX8MN_M7_ALT_PLL_OUT] = imx_clk_hw_gate("m7_alt_pll_out", "m7_alt_pll_bypass", base + 0x74, 11);
diff --git a/include/dt-bindings/clock/imx8mn-clock.h b/include/dt-bindings/clock/imx8mn-clock.h
index 694e3c050d04..04809edab33c 100644
--- a/include/dt-bindings/clock/imx8mn-clock.h
+++ b/include/dt-bindings/clock/imx8mn-clock.h
@@ -16,7 +16,8 @@
 #define IMX8MN_CLK_EXT4				7
 #define IMX8MN_AUDIO_PLL1_REF_SEL		8
 #define IMX8MN_AUDIO_PLL2_REF_SEL		9
-#define IMX8MN_VIDEO_PLL1_REF_SEL		10
+#define IMX8MN_VIDEO_PLL_REF_SEL		10
+#define IMX8MN_VIDEO_PLL1_REF_SEL		IMX8MN_VIDEO_PLL_REF_SEL
 #define IMX8MN_DRAM_PLL_REF_SEL			11
 #define IMX8MN_GPU_PLL_REF_SEL			12
 #define IMX8MN_M7_ALT_PLL_REF_SEL		13
@@ -27,7 +28,8 @@
 #define IMX8MN_SYS_PLL3_REF_SEL			17
 #define IMX8MN_AUDIO_PLL1			18
 #define IMX8MN_AUDIO_PLL2			19
-#define IMX8MN_VIDEO_PLL1			20
+#define IMX8MN_VIDEO_PLL			20
+#define IMX8MN_VIDEO_PLL1			IMX8MN_VIDEO_PLL
 #define IMX8MN_DRAM_PLL				21
 #define IMX8MN_GPU_PLL				22
 #define IMX8MN_M7_ALT_PLL			23
@@ -38,7 +40,8 @@
 #define IMX8MN_SYS_PLL3				27
 #define IMX8MN_AUDIO_PLL1_BYPASS		28
 #define IMX8MN_AUDIO_PLL2_BYPASS		29
-#define IMX8MN_VIDEO_PLL1_BYPASS		30
+#define IMX8MN_VIDEO_PLL_BYPASS			30
+#define IMX8MN_VIDEO_PLL1_BYPASS		IMX8MN_VIDEO_PLL_BYPASS
 #define IMX8MN_DRAM_PLL_BYPASS			31
 #define IMX8MN_GPU_PLL_BYPASS			32
 #define IMX8MN_M7_ALT_PLL_BYPASS		33
@@ -49,7 +52,8 @@
 #define IMX8MN_SYS_PLL3_BYPASS			37
 #define IMX8MN_AUDIO_PLL1_OUT			38
 #define IMX8MN_AUDIO_PLL2_OUT			39
-#define IMX8MN_VIDEO_PLL1_OUT			40
+#define IMX8MN_VIDEO_PLL_OUT			40
+#define IMX8MN_VIDEO_PLL1_OUT			IMX8MN_VIDEO_PLL_OUT
 #define IMX8MN_DRAM_PLL_OUT			41
 #define IMX8MN_GPU_PLL_OUT			42
 #define IMX8MN_M7_ALT_PLL_OUT			43
-- 
2.32.0

