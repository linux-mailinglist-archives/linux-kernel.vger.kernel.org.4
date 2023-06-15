Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C094E73237D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238824AbjFOXWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFOXVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:21:44 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD46B2D68
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:21:36 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f845060481so1674290e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686871295; x=1689463295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsmM0RVmGhdEwe/rih/x+k+rX6jJFYBfre/lrv7PkUc=;
        b=QxK4BzIR8IUBhOCy5aUHkaSxQ1FVwiCX9v8TWjmIKZxrM6iQhdZS075YcYr0T6/T5V
         cG3qCIAwYyWo5MXlUMb5/8OW+ZeInwEOo99SAvLMzeYqssas7QAY+7QsXkuCVT2GUg0x
         vv3hy70lsqmtHVCgnxKEbTuZppbJaCyn7xkPigVOR+HIwnmdcfsy0bgOOnzxSet0LOPf
         jB7qnjWq6y9G/vicSJr7Y51S4eW14hqGyROb4C6jziViqEei+zgrtAfGdLKswE4zVeqq
         04QDyy5jkZKfaMMa5dF5qLgKrhh3ZU6BVqL6idgqv5Dt4QaoICXLmi2QjKRs/S4pwuum
         lo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686871295; x=1689463295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsmM0RVmGhdEwe/rih/x+k+rX6jJFYBfre/lrv7PkUc=;
        b=F1V0ez2HAgwU1nrrszLRD3OdHYG/ADyrUP51dtpv/xxkVCguTHEhwqL40TDIkeo2wx
         GrqhLW0Ka47rfiTlgbiQT8oO00zC+5jMlFFZ7qDbaE8HysmHs6u64Gm52RtnR2DN/pYN
         bKSTnWLs16iRINqqrq+EIehTD4FEdEDKLRkbDL/pJtChDOH59wM16wzROzl1FoMXdKGT
         WRtLmAQT3VS00sd31RqxYO7KqbHTiiC/JWHJNQ1FkB8BXk0pROK4f3ZCLSfNS/baiCGj
         eK883xzO3doEU4Jsk/qUCuxlHMugR63Qdb1tT4FV7qmCFiUcIuIYfazNr0xZfhv6bWmc
         XSyA==
X-Gm-Message-State: AC+VfDxe7GFJEMWfxkowRk+kjiXLQK5QBnAocur/OKpnLAxq3PODJWx7
        JbHvX3ng3JqZzIIC1Wi5obdW0g==
X-Google-Smtp-Source: ACHHUZ57bxPcpLH/W26TQt+WKOvyGY/VYKwN0jb23n3AXd24tArYBiB8EX6js3HDzk6cTEl/2S6N3g==
X-Received: by 2002:a19:675a:0:b0:4f1:4468:ee65 with SMTP id e26-20020a19675a000000b004f14468ee65mr96060lfj.30.1686871295061;
        Thu, 15 Jun 2023 16:21:35 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id u25-20020a056512041900b004f24ee39661sm2744852lfk.137.2023.06.15.16.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 16:21:34 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 16 Jun 2023 01:20:52 +0200
Subject: [PATCH v9 11/20] drm/msm/a6xx: Move CX GMU power counter
 enablement to hw_init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v9-11-890d8f470c8b@linaro.org>
References: <20230223-topic-gmuwrapper-v9-0-890d8f470c8b@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v9-0-890d8f470c8b@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686871277; l=1883;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=NcBNg698ol/YkEOdeY7ojQoggNClubg5869lLN304Tc=;
 b=8sFX06msZKeW+kwKP3ZOXVdyHN22k+stTfTspDXSv/V6MFiUsi8VyYOuJztXYN7vAuhXvhy9v
 lEKWJf1OyO/AMgeFZYi9GWfzVwOr97iNrKw9rNMga9ujWibv7/jc7wo
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the introduction of A6xx support, we've been enabling the CX GMU
power counter 0 in a bit of a weird spot. Move it to hw_init so that
GMU wrapper GPUs can reuse the same code paths. As a bonus, this order
makes it easier to compare mainline and downstream register access traces.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 6 ------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 7 +++++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 906bed49f27d..aae7ea651607 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -479,12 +479,6 @@ static int a6xx_rpmh_start(struct a6xx_gmu *gmu)
 
 	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 0);
 
-	/* Set up CX GMU counter 0 to count busy ticks */
-	gmu_write(gmu, REG_A6XX_GPU_GMU_AO_GPU_CX_BUSY_MASK, 0xff000000);
-	gmu_rmw(gmu, REG_A6XX_GMU_CX_GMU_POWER_COUNTER_SELECT_0, 0xff, 0x20);
-
-	/* Enable the power counter */
-	gmu_write(gmu, REG_A6XX_GMU_CX_GMU_POWER_COUNTER_ENABLE, 1);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 8aa4670b4308..0efecde2af1a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1256,6 +1256,13 @@ static int hw_init(struct msm_gpu *gpu)
 			0x3f0243f0);
 	}
 
+	/* Set up the CX GMU counter 0 to count busy ticks */
+	gmu_write(gmu, REG_A6XX_GPU_GMU_AO_GPU_CX_BUSY_MASK, 0xff000000);
+
+	/* Enable the power counter */
+	gmu_rmw(gmu, REG_A6XX_GMU_CX_GMU_POWER_COUNTER_SELECT_0, 0xff, BIT(5));
+	gmu_write(gmu, REG_A6XX_GMU_CX_GMU_POWER_COUNTER_ENABLE, 1);
+
 	/* Protect registers from the CP */
 	a6xx_set_cp_protect(gpu);
 

-- 
2.41.0

