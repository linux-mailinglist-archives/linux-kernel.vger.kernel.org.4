Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C4F736AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjFTLaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjFTLaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:30:07 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AB51BB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:30:05 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f883420152so1231663e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687260603; x=1689852603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mvj4Ws5lfpRkepZDTp/39wphy6EdJ013fn+mBz94DMg=;
        b=MbGQYduFNJMlpq71oNbfIylCEuMuMKZ2l0XzU8mFm+OFEGcP3WDjjh67j0j1jC87C8
         pYTHIQ/yvYrTj2pV4dMUjTJ6UTZXnbiWSQ8Bcqd5BEDSrCkiXMSYAGlCH9JFLDwe2Q7Y
         mFCRwPSLgLb5cvi1gzHZgJ+N4txzBsG/JA5MZbQ+3z6ZLyd9KK3U4BOT+yMswRus/yR3
         rsqZMTMW3mA+7fLlIRTcYW+jhhL8ZNAl9/zAZDWhWD7YgcIAm5rWZ+XC1P5AZvvYcyyU
         2uIaTnnDWx8PtkZFzMshkywp4fa254N2NrXrHNJNMC5bCB9I0vwDSuLrBYweWNSdDVKl
         fmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687260603; x=1689852603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvj4Ws5lfpRkepZDTp/39wphy6EdJ013fn+mBz94DMg=;
        b=RsZHOvItZ5G3/lSXLiknfMG+nzb9hdaABECg7bhp1S1uyBUSI8CRMcUUO2u7gEhDkH
         i6rAzTGH75ZKnukKueQS9Kz+a3/1f8KHvSwvb+t18CdlQExY1VufhOhUW64bESzjhaUo
         GrEmh4oUPBkhna7XZtyU7uvwtfHZ5HuFONuYs4t7scfL2qL+Y3RDI4SuGWvBlshVg3/i
         6B0uXg/4As6pCVUMd9kU40iGK132Yfj2QfxMnCNZRP4P5afI9Quax9bA0xBu8yefjqcm
         1R0kB15eV+ogHT5F3fNTBmW0yKEODVlbLAlQx1c3eVGBrkeOJPa2r1nzmKgLpDOeDoU1
         ZzUw==
X-Gm-Message-State: AC+VfDzHTkOA8umv+CkexrfwmD7DuBSZ1T81VwkeLx+pL0cbbi5tmf96
        qOB1fIDmDtxTeCNsMA0yElrbyw==
X-Google-Smtp-Source: ACHHUZ6ED/zWchOlt8YalqHTrP43Ype8jf/mpfCxQFHrsHIEf3K8XmAOEKaItoY4Q9L1P78PA+TQUA==
X-Received: by 2002:a05:6512:b0e:b0:4f8:54f3:a6c0 with SMTP id w14-20020a0565120b0e00b004f854f3a6c0mr7225414lfu.11.1687260603553;
        Tue, 20 Jun 2023 04:30:03 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id 8-20020ac24828000000b004eed8de597csm335709lft.32.2023.06.20.04.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:30:03 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 20 Jun 2023 13:29:58 +0200
Subject: [PATCH 1/2] drm/msm/dsi: Use pm_runtime_resume_and_get to prevent
 refcnt leaks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-topic-dsiphy_rpm-v1-1-446a7fd0ce43@linaro.org>
References: <20230620-topic-dsiphy_rpm-v1-0-446a7fd0ce43@linaro.org>
In-Reply-To: <20230620-topic-dsiphy_rpm-v1-0-446a7fd0ce43@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687260601; l=756;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=p+WuOmdprSDjusI/rvtFLxmtLwQxfj48jFs663vX5YQ=;
 b=FXvuUQg/5YWokhed8hsEyalTU7MwztoQeLbEK29H7mFag8FeR7dCHiJpMDyZtqenlstrvvDDB
 So/552dSW3VCVmtxh0gCXhw3vbmoCQ+QGVZWY9PrHc42lkTyes+CkvM
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper has been introduced to avoid programmer errors when using
pm_runtime_get, use it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index 9d5795c58a98..0a8e1dd4509e 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -516,7 +516,7 @@ static int dsi_phy_enable_resource(struct msm_dsi_phy *phy)
 	struct device *dev = &phy->pdev->dev;
 	int ret;
 
-	pm_runtime_get_sync(dev);
+	pm_runtime_resume_and_get(dev);
 
 	ret = clk_prepare_enable(phy->ahb_clk);
 	if (ret) {

-- 
2.41.0

