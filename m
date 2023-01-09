Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EF266218C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbjAIJ1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbjAIJ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:26:56 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4E01134
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:26:48 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso6595299wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 01:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0s4VZeBOMQpwWZj/4UqywYFSz3/oNjsiCGTdYmq+Ed4=;
        b=J04hsYnIfObiB7uitaZtBveS7cW3lgxebEgkSl5zwlV9xX7YbGspbBRcZqo+qlCBZ1
         gliZkxatwpn7AMUl9hiHnr90mqm9lgWR+rnVGWdhef1+SBQSwl3c8+BpGRSfHmHd0fD/
         GtDVeK9TgIQUlPtaGspMJTJezyCDOFBFiuY44F6yNPrb/Rjyy+75chDNwC4Kn0hEREPv
         YFC66Tfrxf27bPuFIt1w8OIfSP009QfPCnLJKWbSJ1qkC/1jGz8mYhg+aWUaMWTnlAT3
         2bvHOgArSnr+mdqMa9IHxd18z/XI4IMB7Fc9fa+mpX17RvuD52UieNi1/gWY16PFCbQE
         UWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0s4VZeBOMQpwWZj/4UqywYFSz3/oNjsiCGTdYmq+Ed4=;
        b=WwWdQCYhLtzRsbG2APw3Ox+NV+ZHUtgi8+nVoMOd5iUMyog7bbsnZmhvrPyxNeSuqW
         miSuNu3MxcbhfOfyrU00fNfdJxPLuEeVO6e2KiB7sOwy3EfRcwEvIQn0fMiRDJuayT12
         U4wFJTu1PMDodkLjM1zKrhnevwbJzFIel8WB81teu0mW1QbxUK5/AyU/ABwqCFuExt1b
         i2cFPH5pyDWIfvutTVkD5sv38CJJeDUyybIUYhGlrUs1yk88Y7+Pzb3h/N3nBlvHq1bV
         P4/B8cWSN7jmaT72NZZwmaxSQ6phlGCVVTdT3doxKN7lHgHiaZBucWhXd3rARo+dnnWh
         HHtw==
X-Gm-Message-State: AFqh2kq91f4JkikU3+1SmUJBu2q+gpC13kqlirDjiVhtBPZfZ0uBscgx
        oQK51YyLovcu2N2gusQQIaCavw==
X-Google-Smtp-Source: AMrXdXtHftT9T3EUOo9MBZwTkvKxl8P6P8DOxkWAyF+P8TH7z5OCLVuk/hlWpII3wha/xpEgsQ+04A==
X-Received: by 2002:a05:600c:3550:b0:3d9:ed30:6a73 with SMTP id i16-20020a05600c355000b003d9ed306a73mr2888234wmq.9.1673256407211;
        Mon, 09 Jan 2023 01:26:47 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id s23-20020a1cf217000000b003d1e3b1624dsm15195758wmc.2.2023.01.09.01.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 01:26:46 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 09 Jan 2023 10:26:39 +0100
Subject: [PATCH v2 7/7] drm/msm/dsi: add support for DSI 2.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230103-topic-sm8550-upstream-mdss-dsi-v2-7-87f1c16d7635@linaro.org>
References: <20230103-topic-sm8550-upstream-mdss-dsi-v2-0-87f1c16d7635@linaro.org>
In-Reply-To: <20230103-topic-sm8550-upstream-mdss-dsi-v2-0-87f1c16d7635@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for DSI 2.7.0 (block used on sm8550).

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_cfg.c | 16 ++++++++++++++++
 drivers/gpu/drm/msm/dsi/dsi_cfg.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index 59a4cc95a251..33884ebd2f86 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -181,6 +181,20 @@ static const struct msm_dsi_config sdm845_dsi_cfg = {
 	.num_dsi = 2,
 };
 
+static const struct regulator_bulk_data sm8550_dsi_regulators[] = {
+	{ .supply = "vdda", .init_load_uA = 16800 },	/* 1.2 V */
+};
+
+static const struct msm_dsi_config sm8550_dsi_cfg = {
+	.io_offset = DSI_6G_REG_SHIFT,
+	.regulator_data = sm8550_dsi_regulators,
+	.num_regulators = ARRAY_SIZE(sm8550_dsi_regulators),
+	.bus_clk_names = dsi_sdm845_bus_clk_names,
+	.num_bus_clks = ARRAY_SIZE(dsi_sdm845_bus_clk_names),
+	.io_start = { 0xae94000, 0xae96000 },
+	.num_dsi = 2,
+};
+
 static const struct regulator_bulk_data sc7180_dsi_regulators[] = {
 	{ .supply = "vdda", .init_load_uA = 21800 },	/* 1.2 V */
 };
@@ -302,6 +316,8 @@ static const struct msm_dsi_cfg_handler dsi_cfg_handlers[] = {
 		&sc7280_dsi_cfg, &msm_dsi_6g_v2_host_ops},
 	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_6_0,
 		&sdm845_dsi_cfg, &msm_dsi_6g_v2_host_ops},
+	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_7_0,
+		&sm8550_dsi_cfg, &msm_dsi_6g_v2_host_ops},
 };
 
 const struct msm_dsi_cfg_handler *msm_dsi_cfg_get(u32 major, u32 minor)
diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
index 95957fab499d..44be4a88aa83 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
@@ -26,6 +26,7 @@
 #define MSM_DSI_6G_VER_MINOR_V2_4_1	0x20040001
 #define MSM_DSI_6G_VER_MINOR_V2_5_0	0x20050000
 #define MSM_DSI_6G_VER_MINOR_V2_6_0	0x20060000
+#define MSM_DSI_6G_VER_MINOR_V2_7_0	0x20070000
 
 #define MSM_DSI_V2_VER_MINOR_8064	0x0
 

-- 
2.34.1
