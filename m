Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADCB6930AA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjBKLwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjBKLwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:52:22 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C42C241FB
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:52:07 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m8so7284519edd.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nzh9retSVIyMmp57bQNIeqL4Qh27h4qyWsMsM/hhbxc=;
        b=kmXKYVHwswRrA4LI2hz1zuC1ZB+aegsUZUKkBR7KDF27Nrt0UScprMI5AI1B4FP4Y8
         dZE6kLHaWBnul93HSxeqQXNdaDxj71RW7guiOUs1GcWgsyIfewE5WdlnUFM4UKfCDQEp
         4CumJqfe1EIjTiDDqrWobK4hCWaxq1CGXWLJNPu3Jb2m6Ninl8cqqQ4EMN2jijTAhYrY
         VaS3fNHp4UZekS2JDauri54E+vRD+PCLKCTxKA3ZqoDpWIKHRbVchmsNx9miVqG3O/0U
         guDJI45qT93E5nTL8+9BsD/1noIirMXDJyqhym5JVwFLrB++A8VXBXextL8WzOVIAFG9
         bgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nzh9retSVIyMmp57bQNIeqL4Qh27h4qyWsMsM/hhbxc=;
        b=cws7c/B/izdqXkHNG9RoFVLok1w1JHEIF6k5mTI2vm/5blbMVcy2PzvAKnQ1Mz6n7O
         8TX7QgWAZGw1Qm16hXrm/fXIuvjsO35ye0tPfP1p+2uq1Ta26lB5MdTpO2MGrYeZ5krb
         7CehMeFpUh3e5jAYG4GiCt0MxUtxe+MI7o/2U6zk7nZOqoFK91ZGaYX7geKV6DXqmccF
         IGADmnUsn7ZJe85jC/lWlzxi3n3tH06dULSxYuWiBmOma9vyDOuwaA77tjSSKZUAjqs/
         qj+zmSg62VWJxEwGP98I4n0jVp6qxVa4e0Va8arzhv7MeppUcQRFBuVurAo5LYX2PzZq
         rIQw==
X-Gm-Message-State: AO0yUKVX5iKXSFxbUSnrIC9pvxGbuha5Jl0Z4JDlnTPNQmYcrOoooU5u
        WtLzW1F/Bg62gjQKCQyFK7EEQA==
X-Google-Smtp-Source: AK7set9gDFzCqt5oQQltwLSBeKE/xvPC8xj9Tf6vP9Bec/fKL55oBBqubpLWKTfK6NVSEQWLRenoKg==
X-Received: by 2002:a50:d0c4:0:b0:4ab:1f18:7839 with SMTP id g4-20020a50d0c4000000b004ab1f187839mr9908229edf.22.1676116326366;
        Sat, 11 Feb 2023 03:52:06 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id r10-20020a50d68a000000b004aabb714230sm3636070edi.35.2023.02.11.03.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 03:52:06 -0800 (PST)
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
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] drm/msm/dsi: Switch the QCM2290-specific compatible to index autodetection
Date:   Sat, 11 Feb 2023 12:51:07 +0100
Message-Id: <20230211115110.1462920-8-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230211115110.1462920-1-konrad.dybcio@linaro.org>
References: <20230211115110.1462920-1-konrad.dybcio@linaro.org>
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

Now that the logic can handle multiple sets of registers, move
the QCM2290 to the common logic and mark it deprecated. This allows us
to remove a couple of structs, saving some memory.

Fixes: ee1f09678f14 ("drm/msm/dsi: Add support for qcm2290 dsi controller")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi.c     |  4 +++-
 drivers/gpu/drm/msm/dsi/dsi_cfg.c | 29 +++--------------------------
 2 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index 31fdee2052be..90d43628b22b 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -174,7 +174,9 @@ static int dsi_dev_remove(struct platform_device *pdev)
 
 static const struct of_device_id dt_match[] = {
 	{ .compatible = "qcom,mdss-dsi-ctrl", .data = NULL /* autodetect cfg */ },
-	{ .compatible = "qcom,dsi-ctrl-6g-qcm2290", .data = &qcm2290_dsi_cfg_handler },
+
+	/* Deprecated, don't use */
+	{ .compatible = "qcom,dsi-ctrl-6g-qcm2290", .data = NULL },
 	{}
 };
 
diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index 142a0f1e2576..81d41f247040 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -169,8 +169,10 @@ static const struct msm_dsi_config sdm845_dsi_cfg = {
 	.bus_clk_names = dsi_v2_4_clk_names,
 	.num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
 	.io_start = {
-		{ 0xae94000, 0xae96000, 0 }, /* SDM845 / SDM670 / SC7180 */
+		{ 0xae94000, 0xae96000, 0 }, /* SDM845 / SDM670 */
+		{ 0x5e94000, 0 }, /* QCM2290 / SM6115 / SM6125 / SM6375 */
 	},
+	.num_variants = 2,
 };
 
 static const struct regulator_bulk_data sm8550_dsi_regulators[] = {
@@ -203,25 +205,6 @@ static const struct msm_dsi_config sc7280_dsi_cfg = {
 	},
 };
 
-static const char * const dsi_qcm2290_bus_clk_names[] = {
-	"iface", "bus",
-};
-
-static const struct regulator_bulk_data qcm2290_dsi_cfg_regulators[] = {
-	{ .supply = "vdda", .init_load_uA = 21800 },	/* 1.2 V */
-};
-
-static const struct msm_dsi_config qcm2290_dsi_cfg = {
-	.io_offset = DSI_6G_REG_SHIFT,
-	.regulator_data = qcm2290_dsi_cfg_regulators,
-	.num_regulators = ARRAY_SIZE(qcm2290_dsi_cfg_regulators),
-	.bus_clk_names = dsi_qcm2290_bus_clk_names,
-	.num_bus_clks = ARRAY_SIZE(dsi_qcm2290_bus_clk_names),
-	.io_start = {
-		{ 0x5e94000, 0 },
-	},
-};
-
 static const struct msm_dsi_host_cfg_ops msm_dsi_v2_host_ops = {
 	.link_clk_set_rate = dsi_link_clk_set_rate_v2,
 	.link_clk_enable = dsi_link_clk_enable_v2,
@@ -312,9 +295,3 @@ const struct msm_dsi_cfg_handler *msm_dsi_cfg_get(u32 major, u32 minor)
 
 	return cfg_hnd;
 }
-
-/*  Non autodetect configs */
-const struct msm_dsi_cfg_handler qcm2290_dsi_cfg_handler = {
-	.cfg = &qcm2290_dsi_cfg,
-	.ops = &msm_dsi_6g_v2_host_ops,
-};
-- 
2.39.1

