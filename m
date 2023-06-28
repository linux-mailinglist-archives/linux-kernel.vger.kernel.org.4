Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673F47419A9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjF1UgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjF1Ufn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:35:43 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31A91FF6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:35:40 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f76a0a19d4so85735e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687984539; x=1690576539;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xum1FmervGOJztlBk+C1bmHU51hjupT71OA70zaOm4M=;
        b=l2GxzOqZH5S1/wNCuTgxdNfeAJ9LkJDOKkyEkUO+wng/hiC01RHCT2NWJFs4ToYzZh
         OiY+ojar4DTojCwg2v/JLSwjIyvMor3nTaNZ/4B00fSTDYDFbUekjEUyM5F4s55s7gYD
         JEklaZmjUEQlHZzEWYFWepF0rsfzxgrPjqKgsulfBFfztClaqXhSdNm7rFkZZQlKevr6
         GpLq5mxat0HJHc8OamQPVJvbnv9CBdnAeqwT1/2mT8x/8UwhTWHueg0pgWSZxfnIN59c
         MvrA22qb2F/Jkin7OgN+oYztdly5tdAeN7jLhGQqZFLLQXM23xqi9hXPFX01LnzHpOCr
         hkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687984539; x=1690576539;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xum1FmervGOJztlBk+C1bmHU51hjupT71OA70zaOm4M=;
        b=RTQJZEc+XUh7u0sAtOXwUW07l5tGRINMv33cU3oJcvQln8By9lZxM2ANRpEWsoqJ7q
         ZVa1WgffQCrcwpsF6pRGyTKIif3I9Cbm7F7EyXhcVsC767lMoKdkSULJN3rIX521BgCL
         Yb+AX3MpWGTppe2kVbzU7hD6e+HhwxG5b3B6eaN6/uLHsOe3QMyGcV50bJMnqfCmNORG
         1HvusreylLUBdtH1rnp2MXKOV/zbMANvIrIsnMJx65NNQ2Hophf+skxltmRLAOcstx/G
         +pcPaqURZh5H9CiHvN6QIOjl3DYmBq6DssZoGRam5rua/Whzbb2a1r+RHDAFlrvKZLym
         FB5Q==
X-Gm-Message-State: AC+VfDySuai7PY8I6rurKqJIa+x0XNikAE8S+3ETM2IzhEzF8GQe+1qW
        UQ/8QCbI/04z+LlT2bsFwrRc3A==
X-Google-Smtp-Source: ACHHUZ4np78b2+aOAS04Huk1rXeXqyT/Ios+cevOSKaxlVgkAUOcSGSkxjiJj+jK6kdNPd+GXqcrFw==
X-Received: by 2002:a05:6512:3483:b0:4fb:78a0:dd34 with SMTP id v3-20020a056512348300b004fb78a0dd34mr5568317lfr.42.1687984538874;
        Wed, 28 Jun 2023 13:35:38 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id m25-20020a056512015900b004fb86c89fa1sm753363lfo.135.2023.06.28.13.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:35:38 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 28 Jun 2023 22:35:09 +0200
Subject: [PATCH 09/14] drm/msm/a6xx: Send ACD state to QMP at GMU resume
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230628-topic-a7xx_drmmsm-v1-9-a7f4496e0c12@linaro.org>
References: <20230628-topic-a7xx_drmmsm-v1-0-a7f4496e0c12@linaro.org>
In-Reply-To: <20230628-topic-a7xx_drmmsm-v1-0-a7f4496e0c12@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687984524; l=3025;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=K7btdnJ3TF737HFTzRStzC87Yz1YWN6DeQhBOZrTry0=;
 b=GT0khEyNUJRJIkFtvtGDd/ThAKre9KhiJr6hnM9L5HWG/YRe3lIcnRgDBv5Q8+UCLmrj7LcB4
 2Csx6nJSY15DWGYaqKFBcIw9r2EioMmz3uGEjWkxuCksEeiGbDFFdpd
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QMP mailbox expects to be notified of the ACD (Adaptive Clock
Distribution) state. Get a handle to the mailbox at probe time and
poke it at GMU resume.

Since we don't fully support ACD yet, hardcode the message to "val: 0"
(state = disabled).

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 6476fcc240a0..9593a4e216d6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -974,11 +974,13 @@ static void a6xx_gmu_set_initial_bw(struct msm_gpu *gpu, struct a6xx_gmu *gmu)
 	dev_pm_opp_put(gpu_opp);
 }
 
+#define GMU_ACD_STATE_MSG_LEN	36
 int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 {
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	struct msm_gpu *gpu = &adreno_gpu->base;
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
+	char buf[GMU_ACD_STATE_MSG_LEN];
 	int status, ret;
 
 	if (WARN(!gmu->initialized, "The GMU is not set up yet\n"))
@@ -986,6 +988,18 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 
 	gmu->hung = false;
 
+	/* Notify AOSS about the ACD state (unimplemented for now => disable it ) */
+	if (!IS_ERR(gmu->qmp)) {
+		ret = snprintf(buf, sizeof(buf),
+			       "{class: gpu, res: acd, val: %d}",
+			       0 /* Hardcode ACD to be disabled for now */);
+		WARN_ON(ret >= GMU_ACD_STATE_MSG_LEN);
+
+		ret = qmp_send(gmu->qmp, buf, sizeof(buf));
+		if (ret)
+			dev_err(gmu->dev, "failed to send GPU ACD state\n");
+	}
+
 	/* Turn on the resources */
 	pm_runtime_get_sync(gmu->dev);
 
@@ -1733,6 +1747,10 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 		goto detach_cxpd;
 	}
 
+	gmu->qmp = qmp_get(gmu->dev);
+	if (IS_ERR(gmu->qmp) && adreno_is_a7xx(adreno_gpu))
+		return PTR_ERR(gmu->qmp);
+
 	init_completion(&gmu->pd_gate);
 	complete_all(&gmu->pd_gate);
 	gmu->pd_nb.notifier_call = cxpd_notifier_cb;
@@ -1756,6 +1774,9 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 
 	return 0;
 
+	if (!IS_ERR_OR_NULL(gmu->qmp))
+		qmp_put(gmu->qmp);
+
 detach_cxpd:
 	dev_pm_domain_detach(gmu->cxpd, false);
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index 236f81a43caa..592b296aab22 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -8,6 +8,7 @@
 #include <linux/iopoll.h>
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
+#include <linux/soc/qcom/qcom_aoss.h>
 #include "msm_drv.h"
 #include "a6xx_hfi.h"
 
@@ -96,6 +97,8 @@ struct a6xx_gmu {
 	/* For power domain callback */
 	struct notifier_block pd_nb;
 	struct completion pd_gate;
+
+	struct qmp *qmp;
 };
 
 static inline u32 gmu_read(struct a6xx_gmu *gmu, u32 offset)

-- 
2.41.0

