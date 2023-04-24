Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAA56E60E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjDRMM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjDRMLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:11:40 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE0E7EEB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:11:07 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4edb9039a4cso2063565e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681819865; x=1684411865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jK7H3+ErS03Ewzys5ptfYi+3TCq3sJWDKGWiaxXPxVc=;
        b=fuHWc+pU6kSJ5B8ILg4cxboqaKg4YG4zzH+6szvYhrPIEcDw4trMLqi08eXiaM5Gkf
         4RQaBvCm/cvtj7QAiqHndJHs1DkkQ9rMq2qm+yoTBS8AJdGFkTyndwfOxGXf//6wdsyO
         kZW103oYYampkvOOTH33ac6xyyGemNBb2+RhXJe4rgIRdLBjZ83bpwBsIb4ikNmGvK2K
         6UnAbgQJdzHYWJC3RS3uFVwzg56p6BGs6cAiR2F6Mf7FFVmvDb1Blg80pTKDGbfnPZnN
         jvLrrgB9IdOweZLM57gORL1VfoEZoaRNKwQr7J/y/UYvhBtYDCHJ5Qtksulr2LnpxGf+
         xaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681819865; x=1684411865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jK7H3+ErS03Ewzys5ptfYi+3TCq3sJWDKGWiaxXPxVc=;
        b=hVefQR9zZvY9e8W9eABIWPJmY166U41AA+y5M96HjbCASTGI/g0TlRn8/wg5jEbOnH
         TK3aXWNGhag8Fl2DuQYnhB0ROYmN8Fsd6cwtZqbHIxl1icYU08XoPTYTdKjYCCCU+HR+
         K/8SGBRrUIX0DAZpOW1sfSuMmKvMIScbpTjSPauAB3fA9mWUhqn1EFY8Vn3aR75Xpa2t
         aMLi595/nHQssqIqjQiKru7dnhqeilJx1lNN11DcwUDlWThAyJW7zgWUb8RCEeyEtBrI
         QV1LQ93tll3Xz+K8OG6GyBEE98Zn5xAm4UrBE4wamnSufpuHYEgO20rL3xkyteB5Glmf
         5L6A==
X-Gm-Message-State: AAQBX9fvN64quwIbhArTkLRcoXrd/NUUTHWva/eH1H078Qq+hRzny9Ca
        5fcMfw/L4O4PaJU7/WeNXqAZaA==
X-Google-Smtp-Source: AKy350aWumsOXwDHQ/uYnZksZvKsIYQklkw41JcEKfVA2ot7VlI5J1+K4X9e8gNvBxNHCMWbjY7cmQ==
X-Received: by 2002:ac2:43bb:0:b0:4ed:c3a1:752a with SMTP id t27-20020ac243bb000000b004edc3a1752amr1958180lfl.45.1681819865345;
        Tue, 18 Apr 2023 05:11:05 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id q17-20020a19a411000000b004d86808fd33sm2365895lfc.15.2023.04.18.05.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 05:11:05 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 18 Apr 2023 14:11:00 +0200
Subject: [PATCH v2 5/5] drm/msm/dpu1: Handle the reg bus ICC path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-topic-dpu_regbus-v2-5-91a66d04898e@linaro.org>
References: <20230417-topic-dpu_regbus-v2-0-91a66d04898e@linaro.org>
In-Reply-To: <20230417-topic-dpu_regbus-v2-0-91a66d04898e@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681819856; l=3473;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xOdy2dn+gE2SKrybPYSqoFq4IriT0JQjTQ+e3Ay5cn0=;
 b=h9ntcpkRQz9/aOBujWPi2GBuMqSjHjzJl4e3f8Ec2wwZlXLEV4LprmN69VRjW49s9bxj9Fi/LWe0
 LEWJnLoPDtmj5vBJezWgfnSaCTM6RowO4Lqti71GkxnGl0OFOQI+
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

Apart from the already handled data bus (MAS_MDP_Pn<->DDR), there's
another path that needs to be handled to ensure MDSS functions properly,
namely the "reg bus", a.k.a the CPU-MDSS interconnect.

Gating that path may have a variety of effects.. from none to otherwise
inexplicable DSI timeouts..

On the DPU side, we need to keep the bus alive. The vendor driver
kickstarts it to max (300Mbps) throughput on first commit, but in
exchange for some battery life in rare DPU-enabled-panel-disabled
usecases, we can request it at DPU init and gate it at suspend.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 22 ++++++++++++++++++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index dd6c1c40ab9e..5e1ed338114d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -384,15 +384,17 @@ static int dpu_kms_global_obj_init(struct dpu_kms *dpu_kms)
 	return 0;
 }
 
-static int dpu_kms_parse_data_bus_icc_path(struct dpu_kms *dpu_kms)
+static int dpu_kms_parse_icc_paths(struct dpu_kms *dpu_kms)
 {
 	struct icc_path *path0;
 	struct icc_path *path1;
+	struct icc_path *reg_bus_path;
 	struct drm_device *dev = dpu_kms->dev;
 	struct device *dpu_dev = dev->dev;
 
 	path0 = msm_icc_get(dpu_dev, "mdp0-mem");
 	path1 = msm_icc_get(dpu_dev, "mdp1-mem");
+	reg_bus_path = msm_icc_get(dpu_dev, "cpu-cfg");
 
 	if (IS_ERR_OR_NULL(path0))
 		return PTR_ERR_OR_ZERO(path0);
@@ -404,6 +406,10 @@ static int dpu_kms_parse_data_bus_icc_path(struct dpu_kms *dpu_kms)
 		dpu_kms->mdp_path[1] = path1;
 		dpu_kms->num_mdp_paths++;
 	}
+
+	if (!IS_ERR_OR_NULL(reg_bus_path))
+		dpu_kms->reg_bus_path = reg_bus_path;
+
 	return 0;
 }
 
@@ -1039,7 +1045,7 @@ static int dpu_kms_hw_init(struct msm_kms *kms)
 		DPU_DEBUG("REG_DMA is not defined");
 	}
 
-	dpu_kms_parse_data_bus_icc_path(dpu_kms);
+	dpu_kms_parse_icc_paths(dpu_kms);
 
 	rc = pm_runtime_resume_and_get(&dpu_kms->pdev->dev);
 	if (rc < 0)
@@ -1241,6 +1247,9 @@ static int __maybe_unused dpu_runtime_suspend(struct device *dev)
 	for (i = 0; i < dpu_kms->num_mdp_paths; i++)
 		icc_set_bw(dpu_kms->mdp_path[i], 0, 0);
 
+	if (dpu_kms->reg_bus_path)
+		icc_set_bw(dpu_kms->reg_bus_path, 0, 0);
+
 	return 0;
 }
 
@@ -1261,6 +1270,15 @@ static int __maybe_unused dpu_runtime_resume(struct device *dev)
 		return rc;
 	}
 
+	/*
+	 * The vendor driver supports setting 76.8 / 150 / 300 MBps on this
+	 * path, but it seems to go for the highest level when display output
+	 * is enabled and zero otherwise. For simplicity, we can assume that
+	 * DPU being enabled and running implies that.
+	 */
+	if (dpu_kms->reg_bus_path)
+		icc_set_bw(dpu_kms->reg_bus_path, 0, MBps_to_icc(300));
+
 	dpu_vbif_init_memtypes(dpu_kms);
 
 	drm_for_each_encoder(encoder, ddev)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index d5d9bec90705..c332381d58c4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -111,6 +111,7 @@ struct dpu_kms {
 	atomic_t bandwidth_ref;
 	struct icc_path *mdp_path[2];
 	u32 num_mdp_paths;
+	struct icc_path *reg_bus_path;
 };
 
 struct vsync_info {

-- 
2.40.0

