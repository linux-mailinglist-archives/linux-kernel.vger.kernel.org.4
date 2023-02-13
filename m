Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6202869457A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjBMML5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjBMMLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:11:06 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A23B74B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:10:40 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id hx15so31236681ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/kPvMZiwgDK+KZq9Kf+lEuw04CYRxX2KFNzK4CB7Pw=;
        b=jMzFgbQ0fUe+4erNDvsfQTczPffpIp1t3k7O7tJhiPwIdCtYM+LM5pICdn7e7aqDvJ
         FhV2wU5125wBpyZqKBPD4oatdrTOkpv78KhcKieVTA31YzenyPoCe04XSFgXbKP8ya4T
         ZbQ6poWo5m4nl7GtVy4nKWGyJe+UVfT25kLdjxSkVcnfyQ9OPrpmrF/exUckeBgDln2i
         9oc5meWaJgngoMFPr3z34EFEjPglCKPMthuBIxto4VNRZrU8GP2BEKtYiLG81m7EOQhE
         6PyVlX45x58ss46CYbSKjyqgUho+TI46cNjnW57JnRR9jVBnXWIRN0lqQh8JdxsFJopr
         PeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/kPvMZiwgDK+KZq9Kf+lEuw04CYRxX2KFNzK4CB7Pw=;
        b=GgtkdkVj+tL5gAM9KUoEqoPyotpI86uoG3YqkXY69Tjmbb7Mpnd5vEcqOav+fYkJ/z
         xKfv4CzKlCg79YebnkG0haOAMjTzUUMrALSWQfxXKdjfnQRg/mNSALnRAel4fvlbfQS5
         VHHXkVUadukMPI7Og5ybKGHMG1JD1zE37U3BnKO2+mRhL38Stk4wDViH30KWqA23qQ01
         dx8IzrS89ybEB5kcKAErBGL5HBOF95cWeJ/KKYBtegwP+rnXORK+KDZNm5gKbjS5sGtu
         kJbMBTL0Q2pmd8oKVOpfCLg5uiWjYlttQfhlQ8oTvxDPh0sRlkL5TboN5yNd9KjpJbID
         WpKQ==
X-Gm-Message-State: AO0yUKXuVb+TpSVpKCExKnSVXYEKtL025WLF+Cehr4istucnO7FHTRxA
        ju0GSS7ul7CSUOpm5raYP2uKXA==
X-Google-Smtp-Source: AK7set/SJhRGtx/3GLxajWM1yaOaxem6JoqH27SsAme+rzLOiTZ1xSMA18qD5+XtxWSmj5vuNMVXBw==
X-Received: by 2002:a17:907:804:b0:8a9:fa2f:e440 with SMTP id wv4-20020a170907080400b008a9fa2fe440mr28641469ejb.55.1676290237351;
        Mon, 13 Feb 2023 04:10:37 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id dt19-20020a170906b79300b0088ed7de4821sm6651586ejb.158.2023.02.13.04.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 04:10:37 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Loic Poulain <loic.poulain@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/9] drm/msm/dsi: Remove custom DSI config handling
Date:   Mon, 13 Feb 2023 13:10:10 +0100
Message-Id: <20230213121012.1768296-8-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213121012.1768296-1-konrad.dybcio@linaro.org>
References: <20230213121012.1768296-1-konrad.dybcio@linaro.org>
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

Now that the only user is handled by common code, remove the option to
specify custom handlers through match data.

This is effectively a revert of commit:
5ae15e76271 ("drm/msm/dsi: Allow to specify dsi config as pdata")

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi.c      | 4 ++--
 drivers/gpu/drm/msm/dsi/dsi_host.c | 4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index 90d43628b22b..e0b911af618d 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -173,10 +173,10 @@ static int dsi_dev_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id dt_match[] = {
-	{ .compatible = "qcom,mdss-dsi-ctrl", .data = NULL /* autodetect cfg */ },
+	{ .compatible = "qcom,mdss-dsi-ctrl" },
 
 	/* Deprecated, don't use */
-	{ .compatible = "qcom,dsi-ctrl-6g-qcm2290", .data = NULL },
+	{ .compatible = "qcom,dsi-ctrl-6g-qcm2290" },
 	{}
 };
 
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 9cfb9e91bfea..961689a255c4 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -214,10 +214,6 @@ static const struct msm_dsi_cfg_handler *dsi_get_config(
 	int ret;
 	u32 major = 0, minor = 0;
 
-	cfg_hnd = device_get_match_data(dev);
-	if (cfg_hnd)
-		return cfg_hnd;
-
 	ahb_clk = msm_clk_get(msm_host->pdev, "iface");
 	if (IS_ERR(ahb_clk)) {
 		pr_err("%s: cannot get interface clock\n", __func__);
-- 
2.39.1

