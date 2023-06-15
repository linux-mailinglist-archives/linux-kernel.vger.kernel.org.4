Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209B673233F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238971AbjFOXVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjFOXV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:21:27 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99A0296A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:21:24 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f845060481so1674107e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686871283; x=1689463283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6a1QMmj81oXqiu8nN+luqgMSndStx7gXh0gMxhBOOQU=;
        b=bnm2oqpcOD3oUBEBY4/+9G1rwJOOkHaxxb/MKoOlS4zT4IbznR7AYXh0nexgmiF0kn
         48BtXsBNuWaURsK/FTEBnbFS0YgaiRKrqmaBxyogMz8Vqk0WWSpXlrhUMJzAJh3oC3Tj
         vNjjaDKIcaNzlJwqrN8gWI9gUOgTdBnErOuzlHmdw9qCH+lf/cpnEhM7byVE5JkW+SPq
         tXtnGauYGKhHfUc86ZTEyectBvgAxdZxR/96uSzNYzH4oIXDOvWDTS/wG+WFbZ6hWqPV
         QY3WJdWZ3wR4xzNi8c71vFo2VIyAmaqcXZikCaT5YhuDWsjTO8T4fmUDnRtE33ihgbng
         YjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686871283; x=1689463283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6a1QMmj81oXqiu8nN+luqgMSndStx7gXh0gMxhBOOQU=;
        b=JZplTgiOldm/euuwOEYATTgAx43sc9y2skPY1T946bd6xNAua7h9zW+LpXZ/maZHWo
         W/2VfuhEvgGzioP6/uHEsbbh+is2hxlGgA1iOCIkwP9WzsfAIpM7iACYf+GjNKvo3huZ
         NAkWb7NH+MEj7sARkIedr3NyPZSccXwW0Z2de7cAaIGHejdY2q4uxdlgZ4IVHv5/Jqbc
         PFDR2ZMFWuWqlU8liVSvxibQ6I3NFc5mj86AmLmFobU/KF+HeCfx3LEf3PNSszWc1Rc/
         3z2pizPcd0LC0dZv+9coTNEM7Z3QDdH/VgkQ5b9vWz2qYANLT6JEumjqMQngPPZ4IYKo
         AKBQ==
X-Gm-Message-State: AC+VfDwUOGTE1Y49NfjkWUUYO3BARZsRoXyWBvcDCWmz3B1c67mgu1hD
        6Lr+8T7tJROZ7QP06hwQW9K82Q==
X-Google-Smtp-Source: ACHHUZ4YEcCeVa8ugJonftGODrNlpJM5dJgZg94FEbXaKFQpvvxHse3N3U7BrVsY6xiGjq6JVIYaBQ==
X-Received: by 2002:a19:5f15:0:b0:4f3:92a9:aa06 with SMTP id t21-20020a195f15000000b004f392a9aa06mr70560lfb.48.1686871282945;
        Thu, 15 Jun 2023 16:21:22 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id u25-20020a056512041900b004f24ee39661sm2744852lfk.137.2023.06.15.16.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 16:21:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 16 Jun 2023 01:20:44 +0200
Subject: [PATCH v9 03/20] drm/msm/adreno: Use adreno_is_revn for A690
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v9-3-890d8f470c8b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686871276; l=824;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=zkQglxSAYJ6XB8sCRIg7Jh2Ryhgw+vFHA/mfzuc8H1A=;
 b=97c9wz7gJsAfoY56WRmkvESFippkdb670pINXb4BLBXtrNr+y4CB2brw3RN31wQvf5iaVN4AH
 DITwGzQ0X3ZBxOJeLPRD/Q42Dk0XxQhL0jDuD39KPtAKI+sfROBTHBl
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

The adreno_is_revn rework came at the same time as A690 introduction
and that resulted in it not covering all cases. Fix it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 9a7626c7ac4d..5a26c8a2de7c 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -286,7 +286,7 @@ static inline int adreno_is_a660(const struct adreno_gpu *gpu)
 
 static inline int adreno_is_a690(const struct adreno_gpu *gpu)
 {
-	return gpu->revn == 690;
+	return adreno_is_revn(gpu, 690);
 };
 
 /* check for a615, a616, a618, a619 or any derivatives */

-- 
2.41.0

