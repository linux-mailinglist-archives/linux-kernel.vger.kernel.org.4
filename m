Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1653C6930AC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjBKLwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjBKLw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:52:26 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4722BEB6E
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:52:10 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id fj20so7352207edb.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmt6VW0qzHeVmfsiW1rh5EIINQ5Xr+hUNmJsEmBTOOs=;
        b=EzfpwYOsuX2EE/VJNfqpGd6gfX3N3ZS3aObHcIi4JhKxtgNap2qsxZJ7nI/hBQWeO8
         SaB0NLjyYdJw9m3w4lxsp8VagGW1QSx16dWoz60m/gCm08jWxlBvsdo13QydlmhNAKED
         V8N80WYqq1DHALFRoU4/NahRAShWnQ+ibT3LGKmgiYPjJhV2iRjKkAk/ognNtVPo5KaJ
         zSlzgTN2nW+Dhwy6jO0N3Q9YYoDKhKWF38o7D24o1aF7w8XMyvu1707u4mtu1VlTuWH9
         sIW+5wx6/WfOWHqW0Ia1q73M2+U1kkeF372RfGS5n3NcJXtPelFkc91fSs2Nrb6KXiSQ
         imDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmt6VW0qzHeVmfsiW1rh5EIINQ5Xr+hUNmJsEmBTOOs=;
        b=cm3IBSODfMGgmlbow+Ua+bc2EgKro1q9Lz0P4IIzA17GYf0qwf7pggyh8vHKGHcDZT
         bxcgAjGqMrhnIVCXIdPiUUx6NV16KmgEAsaPmg2IQPkA10D6Ggn30T1ZdmDKpkvQ4yLn
         RjPT0gTwmqkBS+I9uQYf87zBYjhmp8emo+akFCiNKEQbEY2D+mtHrOjyEY0+O8bSQH7X
         Nahketqh7+NtWvdWCeVHX3lBR8t2I4fqNGTJKBxC0Ze+aF188Y1fjyrmOeeFQJrLceuO
         d7mEluC2TWv9Zm+QP2jRr0oOIWK1mTQGB8yhUYJk3WB0JtuTt+nQqG0Xnc9YwZ7RQE65
         ZMlg==
X-Gm-Message-State: AO0yUKXZpP2xT3c7v3vlBHFZNnedzgDrIK9x1FCkC4UnB7mKq+5ukQ54
        C7YUFiTfLcgYIpYoE5HrszhgRA==
X-Google-Smtp-Source: AK7set+HItO3J1ZJhnIfUsw7yCnVjuQ5TGwGNs3uryJQQ415r1DaItG0qGXWjy+dNKjFkdvZ3HoD3g==
X-Received: by 2002:a50:935a:0:b0:4ac:b4b1:53fe with SMTP id n26-20020a50935a000000b004acb4b153femr3345338eda.20.1676116329827;
        Sat, 11 Feb 2023 03:52:09 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id r10-20020a50d68a000000b004aabb714230sm3636070edi.35.2023.02.11.03.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 03:52:09 -0800 (PST)
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
        Johan Hovold <johan+linaro@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] drm/msm/dsi: Remove custom DSI config handling
Date:   Sat, 11 Feb 2023 12:51:08 +0100
Message-Id: <20230211115110.1462920-9-konrad.dybcio@linaro.org>
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

Now that the only user is handled by common code, remove the option to
specify custom handlers through match data.

This is effectively a revert of commit:
5ae15e76271 ("drm/msm/dsi: Allow to specify dsi config as pdata")

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
index 8dfa69bcff77..79c33d066348 100644
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

