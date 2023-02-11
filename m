Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7E26930A3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjBKLwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjBKLwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:52:07 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC09F1F5CB
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:51:57 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a10so7288180edu.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zW+Y9s4c1yRvon1yWv9+3TgQXnziiU3kCR/96B6KXds=;
        b=TQtaWs28pO9XDAkHX2tefGKjjdl83OBLBeG56rO5GUjRm9XsfeAimbleEl0ZRh2mC2
         eRDM+Ma9OWB6TYiNkL8AT0JjkSGNebW6zZIdSVashk9ppxa3ANoUSv8f1XZ9n9+rVQ6w
         naWH5YN+NqDFuyUBvuRDviqWa1chRnaQD6VCvk+pAI53txqtv7Xb4Z1+oS4G93dgdj7J
         A5dfiYoFW0Yrl1zdc/htvnzttiRtS5Ia9Di6auyv950ldDvHkcW6DSn6VzuJoYOpxzmz
         rz5IjzIlsGYRTjEVgtsbMsBjSj6f86R+y8q5Jk/Vh4CmojKWbkU7udIqt1IKOWK4dwhL
         VONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zW+Y9s4c1yRvon1yWv9+3TgQXnziiU3kCR/96B6KXds=;
        b=ipMKHecC62HaEfDvcSvTMjR+wMqKeC/tYlRmjBP5N2+SEuPZQL4X2GvQz7HSO0Iju9
         EjH269XtOHCAXx4Apxd7L7qLzHsfEtvl/VuJf7PY5hz6RAI87qGawzUnRBnyLb9sypvV
         toSO2klBP7v6nQchEnZKZ5pFA7WctULxGCWqotJD7FmC4V7h6e9+fcJvsLyyKa+Arbl4
         j5OUw3zM9bEY8W0Swg7QQqygw087KG6paY43asBptagJ6fa+I0B+Oae1ST0hrK95d+vw
         AtV9g8lW/0mKAo5ARvfwHn6KLkLREQuxWQfS0O4WY/aAL5nKeE5XAzHVU9zaJEotLfNz
         NrNg==
X-Gm-Message-State: AO0yUKXECQZy1lvNKAz7msfLcBrTeGNjB8sI9Qqy2Ax1DPOZk59hOt/Y
        Dvb2+GHWFCV0BktFfOcC8SRtkw==
X-Google-Smtp-Source: AK7set/4aYd+qbpanSLKwt7HWW/q9Cv/BGaym6KARMys8+e4SWPJhZbGmGYx8lPFsJ5wssrev9LlGg==
X-Received: by 2002:a50:9feb:0:b0:4ac:b3af:1e1 with SMTP id c98-20020a509feb000000b004acb3af01e1mr3102029edf.13.1676116315918;
        Sat, 11 Feb 2023 03:51:55 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id r10-20020a50d68a000000b004aabb714230sm3636070edi.35.2023.02.11.03.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 03:51:55 -0800 (PST)
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] drm/msm/dsi: dsi_host: Fix DSI index detection when version clash occurs
Date:   Sat, 11 Feb 2023 12:51:04 +0100
Message-Id: <20230211115110.1462920-5-konrad.dybcio@linaro.org>
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

Now that msm_dsi_config is ready to accept multiple sets of registers
(where array[n][idx] holds the base registers of DSI(idx) for the nth
entry), loop through all available configs to resolve hw version
clashes.

Fixes: 32280d66fd44 ("drm/msm/dsi: Don't get DSI index from DT")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_cfg.h  |  1 +
 drivers/gpu/drm/msm/dsi/dsi_host.c | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
index 03493cc6b772..4a47705234bd 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
@@ -43,6 +43,7 @@ struct msm_dsi_config {
 	const int num_bus_clks;
 	/* Allow + 1 entry for the zero-terminator */
 	const resource_size_t io_start[VARIANTS_MAX][DSI_MAX + 1];
+	const int num_variants;
 };
 
 struct msm_dsi_host_cfg_ops {
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index f5092b4d0757..8dfa69bcff77 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1862,16 +1862,18 @@ static int dsi_host_get_id(struct msm_dsi_host *msm_host)
 	struct platform_device *pdev = msm_host->pdev;
 	const struct msm_dsi_config *cfg = msm_host->cfg_hnd->cfg;
 	struct resource *res;
-	int i;
+	int i, j, num_variants;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dsi_ctrl");
 	if (!res)
 		return -EINVAL;
 
-	for (i = 0; cfg->io_start[0][i]; i++) {
-		if (cfg->io_start[0][i] == res->start)
-			return i;
-	}
+	num_variants = cfg->num_variants ? cfg->num_variants : 1;
+
+	for (i = 0; i < num_variants; i++)
+		for (j = 0; cfg->io_start[i][j]; j++)
+			if (cfg->io_start[i][j] == res->start)
+				return j;
 
 	return -EINVAL;
 }
-- 
2.39.1

