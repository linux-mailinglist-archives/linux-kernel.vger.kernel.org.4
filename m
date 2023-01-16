Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F080166BD0B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjAPLlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjAPLlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:41:10 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF3610CB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:41:09 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b3so42326009lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dGHe77W5+el0IE6FbRdtVCcIAo/MBAj9RuLYV7h71Y=;
        b=OLnkeMwg+dH2A4GCcRVev9FtOtnLh0ZS1dw8p+g9sULNPcwEUSEaOqQTAGm+G+vHEO
         VLWmuZjGrbobtrWwYfQmyib4Z941yVjBRLSvjWWSIRZQZ+fEzyU7licMbG3x+VqSKFft
         SeH950EQ1wCK1eJxgpT+VJOKpKYLUGud5mCE/UlDJ/Df5oOJWs5xeTxepQkW4EnEaMA6
         VKiwTV5ammFo33j6naCN5HD+N6tITn5CIQKjN69IWFDNKQyYJ3AUEFxrTFk+YcYrJtuf
         wtjM96VfP+ze/kDz0kuD/QNYBXvvd2XPIVW8hAiu++fUjp1k+FLAMFJiRok3RIEwvp8x
         143w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dGHe77W5+el0IE6FbRdtVCcIAo/MBAj9RuLYV7h71Y=;
        b=w5dXwbH7/V8hPHHKbUwm5PeQILGnEhvKJUarhk9KyLDbnj/VflkTdh517R25uOBdfO
         3fE5T2Xyv3iBCQqk7/y0jA5kXjGCDAnP/CgwireLujWhPMN9C7ACfhxEyhKXVKrtLqvb
         dYnrjA1Zgr0lvPMLUlhjOp/pG3NMw77V1ggCebUHhAzqIWyd92+vorWMBej/MHbh3xP/
         cJwQCqMxPlC9OJKpIv2IAh1uBKCzTjHdwVpOrnSx7Z8/n4VOvjisLmudBqfM15b5ZdYn
         0CM+ukL4cY/1PhcfrAankg3iOargYhscw++MYj0KgFs3sgQxQrCLzr5WzY7riu5qNiOG
         dlxQ==
X-Gm-Message-State: AFqh2kqUEQHBOigsMgSVv/cog6kDW9xKiZTsRxnrqAv+cdUs2IWa3y/K
        m+l+XGP/69N09nwWsYjnSDBP+A==
X-Google-Smtp-Source: AMrXdXveFQwM64kphTdh9VvJyOYqmqjJIcGg0+MVAT2K8ZYQnBqUWMZSnBMwW92nMB6jcRu72BtVNw==
X-Received: by 2002:a05:6512:3e10:b0:4b5:c489:8cf8 with SMTP id i16-20020a0565123e1000b004b5c4898cf8mr29527596lfv.61.1673869267773;
        Mon, 16 Jan 2023 03:41:07 -0800 (PST)
Received: from localhost.localdomain (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id k10-20020a05651c10aa00b0027fb9e64bd0sm918946ljn.86.2023.01.16.03.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 03:41:07 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Douglas Anderson <dianders@chromium.org>,
        sunliming <sunliming@kylinos.cn>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH 2/2] drm/msm/dsi: Add phy configuration for SM6375
Date:   Mon, 16 Jan 2023 12:40:59 +0100
Message-Id: <20230116114059.346327-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116114059.346327-1-konrad.dybcio@linaro.org>
References: <20230116114059.346327-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@somainline.org>

SM6375 uses a boring standard 7nm PHY. Add a configuration entry for it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
Depends on [1] to work properly, but won't hurt for it to land
separately..

[1] https://patchwork.kernel.org/project/linux-arm-msm/patch/1642586079-12472-1-git-send-email-loic.poulain@linaro.org/

 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c     |  2 ++
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h     |  1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 20 ++++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index cbe669fca26d..57445a5dc816 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -569,6 +569,8 @@ static const struct of_device_id dsi_phy_dt_match[] = {
 	  .data = &dsi_phy_7nm_8150_cfgs },
 	{ .compatible = "qcom,sc7280-dsi-phy-7nm",
 	  .data = &dsi_phy_7nm_7280_cfgs },
+	{ .compatible = "qcom,sm6375-dsi-phy-7nm",
+	  .data = &dsi_phy_7nm_6375_cfgs },
 	{ .compatible = "qcom,sm8350-dsi-phy-5nm",
 	  .data = &dsi_phy_5nm_8350_cfgs },
 	{ .compatible = "qcom,sm8450-dsi-phy-5nm",
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
index 5f0b1c9b09ef..c849bfd7494e 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
@@ -55,6 +55,7 @@ extern const struct msm_dsi_phy_cfg dsi_phy_14nm_8953_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_10nm_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_10nm_8998_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_7nm_cfgs;
+extern const struct msm_dsi_phy_cfg dsi_phy_7nm_6375_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_7nm_8150_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_7nm_7280_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_5nm_8350_cfgs;
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
index af5c952c6ad0..3b1ed02f644d 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
@@ -1152,6 +1152,26 @@ const struct msm_dsi_phy_cfg dsi_phy_7nm_cfgs = {
 	.quirks = DSI_PHY_7NM_QUIRK_V4_1,
 };
 
+const struct msm_dsi_phy_cfg dsi_phy_7nm_6375_cfgs = {
+	.has_phy_lane = true,
+	.ops = {
+		.enable = dsi_7nm_phy_enable,
+		.disable = dsi_7nm_phy_disable,
+		.pll_init = dsi_pll_7nm_init,
+		.save_pll_state = dsi_7nm_pll_save_state,
+		.restore_pll_state = dsi_7nm_pll_restore_state,
+	},
+	.min_pll_rate = 600000000UL,
+#ifdef CONFIG_64BIT
+	.max_pll_rate = 5000000000ULL,
+#else
+	.max_pll_rate = ULONG_MAX,
+#endif
+	.io_start = { 0x5e94400 },
+	.num_dsi_phy = 1,
+	.quirks = DSI_PHY_7NM_QUIRK_V4_1,
+};
+
 const struct msm_dsi_phy_cfg dsi_phy_7nm_8150_cfgs = {
 	.has_phy_lane = true,
 	.regulator_data = dsi_phy_7nm_36mA_regulators,
-- 
2.39.0

