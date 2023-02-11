Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8E46930A7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjBKLwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjBKLwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:52:15 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5061D28231
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:52:04 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id d40so6069571eda.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xu29OnoYbs7XlgjQ7eQ5Uic7usShH1dqxj/7r0Nr9hA=;
        b=Azhb35xQfIkRkppUDbGElCHDXkOGIHdkj1Wv+qJ9Ee16d9Isac9HTm6yCOEXSMRLCI
         xtpA8d+cpYU/ZIYscQwv9uDWxWMpLgT1wl/6JirdYNKfZ/Jz9Tx7N22uGIBi/qZLhsed
         RTNgmdvFI/iWwkiySU9bWbkOtdvmIl/64w3c8qECr+fV/bkKxIoyjqvH6qofhw2pV+/B
         d/ul1NoifWxFv0E7kVA46uZOfWZLjGr8VHGUPlZFSY/h4XAnI7beO+Yw9V/3U5p/AP+q
         cF4JXHsznSlH+gNl632wsRfoqbsJu6QflbMJrhF8itMclgsZYKxRQ1sa1ht4EPSJccRM
         KL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xu29OnoYbs7XlgjQ7eQ5Uic7usShH1dqxj/7r0Nr9hA=;
        b=mj3HztG6VUBmp6FhHPjxN11+u0m2GgirI0AUxYlz97hqn3ktSOIPvj0JOpRqBiV6q8
         CQl+AgA1lQfM7DxGQMl1Kd3eJxLgTTgTo/CBniF3OcZI+YjtMeevnwJFRhXB873ebkGu
         jo/DL+CgpWXqb3LX3SMgI59zBN8Kkju7LWmNP+fJm6rL6LTyy3mXEZPBMHj7z6jhwpsr
         il+I+kN8dncsNNgMbLl4DLXOHNpsMfZ4AdtWcW/ewU+YBmhlkM4CWMTaXMRwMhNr92Tz
         99g9tn+1Pr6B1Vigb1Pv67DP/iCoH9JeLWEVoW73ubdWePRs2IMswVFRrWEtOy4jLQ+A
         AqgA==
X-Gm-Message-State: AO0yUKXzl0lHJFUQtiIirxonquUCUqdH3x3I9KoD3tyZsHS6qcIopoZ8
        iZ8CmjeDxwTgN9MEhqG/cZ/bQg==
X-Google-Smtp-Source: AK7set+zlTzVfecZAmxXHXbYPcxJi6BLvT4chUPZUZHzMJWd+/2Pm9Csni4qi7rylweFb3x30/UkDg==
X-Received: by 2002:a50:9f28:0:b0:4ab:b0d5:6bb0 with SMTP id b37-20020a509f28000000b004abb0d56bb0mr4200948edf.18.1676116322880;
        Sat, 11 Feb 2023 03:52:02 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id r10-20020a50d68a000000b004aabb714230sm3636070edi.35.2023.02.11.03.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 03:52:02 -0800 (PST)
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
        Douglas Anderson <dianders@chromium.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Harigovindan P <harigovi@codeaurora.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] drm/msm/dsi: dsi_cfg: Merge SC7180 config into SDM845
Date:   Sat, 11 Feb 2023 12:51:06 +0100
Message-Id: <20230211115110.1462920-7-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230211115110.1462920-1-konrad.dybcio@linaro.org>
References: <20230211115110.1462920-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The configs are identical, other than the number of *maximum* DSI
hosts allowed. This isn't an issue, unless somebody deliberately
tries to access the inexistent host by adding a dt node for it.

Remove the SC7180 struct and point the hw revision match to the
SDM845's one. On a note, this could have been done back when
7180 support was introduced.

Fixes: 6125bd327e16 ("drm/msm: add DSI support for sc7180")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_cfg.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index 860681bfc084..142a0f1e2576 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -169,7 +169,7 @@ static const struct msm_dsi_config sdm845_dsi_cfg = {
 	.bus_clk_names = dsi_v2_4_clk_names,
 	.num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
 	.io_start = {
-		{ 0xae94000, 0xae96000, 0 },
+		{ 0xae94000, 0xae96000, 0 }, /* SDM845 / SDM670 / SC7180 */
 	},
 };
 
@@ -188,17 +188,6 @@ static const struct msm_dsi_config sm8550_dsi_cfg = {
 	},
 };
 
-static const struct msm_dsi_config sc7180_dsi_cfg = {
-	.io_offset = DSI_6G_REG_SHIFT,
-	.regulator_data = dsi_v2_4_regulators,
-	.num_regulators = ARRAY_SIZE(dsi_v2_4_regulators),
-	.bus_clk_names = dsi_v2_4_clk_names,
-	.num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
-	.io_start = {
-		{ 0xae94000, 0 },
-	},
-};
-
 static const struct regulator_bulk_data sc7280_dsi_regulators[] = {
 	{ .supply = "vdda", .init_load_uA = 8350 },	/* 1.2 V */
 };
@@ -299,7 +288,7 @@ static const struct msm_dsi_cfg_handler dsi_cfg_handlers[] = {
 	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_4_0,
 		&sdm845_dsi_cfg, &msm_dsi_6g_v2_host_ops},
 	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_4_1,
-		&sc7180_dsi_cfg, &msm_dsi_6g_v2_host_ops},
+		&sdm845_dsi_cfg, &msm_dsi_6g_v2_host_ops},
 	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_5_0,
 		&sc7280_dsi_cfg, &msm_dsi_6g_v2_host_ops},
 	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_6_0,
-- 
2.39.1

