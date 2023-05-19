Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF9370983B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjESN3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjESN3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:29:21 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B8A13A
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 06:29:20 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2af1822b710so21302031fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 06:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684502958; x=1687094958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBhLY1RBB0gRiRHK2AH+Ew8caVNbMAw5AWStImZv0V4=;
        b=fUM9Sf1CFj5DJCwIfKnYJ6R5zl2ELQpvHxg4T+Iq5cQR/PQng4wmMYRSvNbvO0eJF4
         g1aJ16Uo40Ktef25eTPMWy7PLk/e4lk0O7uzoFvJijUxf2WNmZH2NZ2qRkB0Mur02YQA
         Y0smjgE3TKcczJMI+A+vKHWYDmX7T2ymW9XE+s3OX3BXUvMr9HyUZEuuTbr2KpvXOaMg
         zVWvUitWelt2i0IR9pbfz+CV2DAb4b9q3QHQkWnXuTtkRzGs+ooL+1FZpwchKUT+SHbk
         oPnMUS+41ypDb3YT4X1ZI+OrN4BOy1xBKrC/1QGxmP09N4gucmGIs1Bn/c4FmMNwGcP8
         ZVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684502958; x=1687094958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBhLY1RBB0gRiRHK2AH+Ew8caVNbMAw5AWStImZv0V4=;
        b=foGUHYZhNlD6TXetAoLq6QsRhUJC0p0JO2403cnwV8DhEplvhGyZEdkmjygR769pDi
         1/X5opwWAxELxOoWECsVPbEFtpGGWUezgWuJ4igX9kfNbA2LOPImCjmULDSL4SHncVuT
         hUeUWXCmrMrPCF96b3qlobrCT3lOzj6Qg4eH3GVi3EOMkZyUJalV9tE696gQuO+R+mez
         533O3jxxhfstY4I+p0iokJhP7VYrVq9ny/cQ8Q0bYP2fGnzZA0kozOV5GMEaB4PJ/DtD
         wSk39nrmiUaV/bhPZD6Qsejou0MnZz3UKghkUSaIJkGBo1m325WuQhhtOKc3tCIIYx6E
         Omhg==
X-Gm-Message-State: AC+VfDza4dgX1UZ5fu1qgFZhW3gl7bU2Jipcy85wdynhunT43JcCdsG4
        2YfW955/xKOe8WqqJRie/pmLpWe46OkTMGfjpDQ=
X-Google-Smtp-Source: ACHHUZ6uaEACa/UT3gr/SiNQfbb6FOw6oRFeaCYBpZwcDkzIPTSrPcUwE474KRv/cAapDm8pCG8H1g==
X-Received: by 2002:a2e:8695:0:b0:2ae:db65:2d01 with SMTP id l21-20020a2e8695000000b002aedb652d01mr795280lji.23.1684502958286;
        Fri, 19 May 2023 06:29:18 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id q24-20020a2e9698000000b002ad92dff470sm821384lji.134.2023.05.19.06.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 06:29:17 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 19 May 2023 15:29:06 +0200
Subject: [PATCH v2 1/6] drm/msm/a6xx: Add REG_A6XX_GMU_AHB_FENCE_STATUS_CLR
 definition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-a7xx_prep-v2-1-5b9daa2b2cf0@linaro.org>
References: <20230517-topic-a7xx_prep-v2-0-5b9daa2b2cf0@linaro.org>
In-Reply-To: <20230517-topic-a7xx_prep-v2-0-5b9daa2b2cf0@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684502955; l=867;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=OCiKX/I/i3QBFBCW7ZU+1vuahZ35pMyKYqaVhGEDcJM=;
 b=mg01xARFIrulLxUI9/I/yVrcCgcgVFbSedvUodXJrTp6m2XCaCM/yiyj5pgGMeTbKrWXmVHu9
 zyYpddTSpXVAJBKkYpPZaAmHxLlmc3SwrXNoWJEA65Ga9aAO20VxL6E
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

Add a definition of the REG_A6XX_GMU_AHB_FENCE_STATUS_CLR register.
This may be substituted with a mesa header sync after MR22901 is merged.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h
index 9ab15d91aced..fcd9eb53baf8 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h
@@ -425,6 +425,8 @@ static inline uint32_t A6XX_GMU_GPU_NAP_CTRL_SID(uint32_t val)
 
 #define REG_A6XX_GMU_AHB_FENCE_STATUS				0x00009313
 
+#define REG_A6XX_GMU_AHB_FENCE_STATUS_CLR			0x00009314
+
 #define REG_A6XX_GMU_RBBM_INT_UNMASKED_STATUS			0x00009315
 
 #define REG_A6XX_GMU_AO_SPARE_CNTL				0x00009316

-- 
2.40.1

