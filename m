Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D4C6A00DA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjBWBsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjBWBrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:47:49 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EE610D1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:47:48 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id f18so12475889lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uw9ANW8A0HIEHlu0J95K8GI8spDLrbsMISUzwV0ijx4=;
        b=tQWLe5WcJzNbK/0p370q5JCC8xgYGmEwPZJ1u6Jeop0GH/tTM6fKYVde7vjXHCszdz
         f/ZjfII2Yl+byBaNLDjx0CQfwG3e0seCepo4C4GVKGCVRZmJByOi0FjsUQHZE8NTYyXD
         6Ipy9iEz8c9OGNaIua1la3+dYcQjQ5wrpAkN9nkNKtGd37SwjHq0fGXCpH1cAOWMCyK7
         LNNwXLk3mMsep1eDtljLQAr/JxPlaTqfaFeiZvMdLEPMmSU8T0ykV/iMy2Sar3KaGFNS
         k8eNDCmuGPhCtt3HlOSqjC+lTp8Wp2DJsdE/BzOuBJTjlKFf+1TDR2RwuybWldBf7YO7
         u4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uw9ANW8A0HIEHlu0J95K8GI8spDLrbsMISUzwV0ijx4=;
        b=4isOBbrBY/xK0KTDhSfwnKOw8AM/W8TolpHO9mmQ1mxLiUVAwSl7sVG0e5BsyZKQOt
         mJVnVy4hf70YP+2yh1cMo+nU+gzfcQJIWgi+Y9kfTmfvHluAggGyz8JeEhsiJelQ+3mU
         H2rA671Co15dlqg3wHmppos/8RdG0896xMW1UyYuY4NtZ466air8HbN83dK9aEaQURpx
         9yWGSKviuudGf3c2RvdqsMRYN5YGa8OS7hZFAC24K2tMgQ/HxmucXKCdeFBc2UonHVmS
         ZrSDwOecPUoAxYyCQaptjykVpQ6cn/H70ycIRoBPdeZ4AuDBRhxYE1fYBzFGJBxYWUfC
         W7nA==
X-Gm-Message-State: AO0yUKWQLAefZXECR/rLegdOq+Ek2uuOaUHnh93FOOvgllvnH6sY0K1U
        0bTbPY+XpOCVM1RhwVG3zWmrsXwzK2K9x1fv
X-Google-Smtp-Source: AK7set9HAxRsGbwERh+lUn3YGqAoTzETv5bCEZ+5Z5csnzzygLG1C8GvwRh/vu7HzJtKMzBd/rQ6vQ==
X-Received: by 2002:a19:f512:0:b0:4cb:c11:d01f with SMTP id j18-20020a19f512000000b004cb0c11d01fmr3528085lfb.22.1677116866864;
        Wed, 22 Feb 2023 17:47:46 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id 12-20020ac2482c000000b004dc807b904bsm427376lft.120.2023.02.22.17.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 17:47:46 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 23 Feb 2023 02:47:42 +0100
Subject: [PATCH v2 6/6] drm/msm/adreno: Enable optional icc voting from OPP
 tables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-opp-v2-6-24ed24cd7358@linaro.org>
References: <20230223-topic-opp-v2-0-24ed24cd7358@linaro.org>
In-Reply-To: <20230223-topic-opp-v2-0-24ed24cd7358@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677116858; l=767;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=lx2DqRTcWzcl/VYcOjFYV+HDGYAZOMxix7RaJuIvTv8=;
 b=mYkZ7qwqRbSRNaoLVDbG+NeuUgSJomROk/h9vglxkqTqHBuqRkB9BIoLFrYD7vD+bXjLGT7PYIoJ
 MeljqooSASz7mlvRrVYqcvglbqNK7hJ+uUF4kGeKVT8KaExP5mtI
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the dev_pm_opp_of_find_icc_paths() call to let the OPP framework
handle bus voting as part of power level setting.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 36f062c7582f..5142a4c72cfc 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -548,6 +548,10 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
 		return PTR_ERR(gpu);
 	}
 
+	ret = dev_pm_opp_of_find_icc_paths(dev, NULL);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 

-- 
2.39.2

