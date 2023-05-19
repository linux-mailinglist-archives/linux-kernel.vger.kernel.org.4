Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A8C709F6B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 20:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjESSu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 14:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjESSuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 14:50:25 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078B4E54
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 11:50:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4efd6e26585so4046621e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684522202; x=1687114202;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HTUEsS20+JWfFefGFxAlmb68/xkcFppSNirNHBfFJGA=;
        b=UU98q5EnmW7KMZZAlzm7ITG5fh0J558Aki64lr9kuoXzScUd4PKrwzpCLp3V2J1Gs9
         A0bpqkO3SdR4aoLp+dx/6fLLp9shqwZazDcKxsavE6N8TIdxPCEUvw7fYC40BIlDq9Uy
         8Pstm7Bw9jt++JwvhrHH2HaRSdyQpPs3Iql6CzkqXd8ppPXj6qXa2pdGfb724U7U+LCo
         2F9S706SA7Cdb5H5bcQiFK+xbnwp/7Dqe8Z6ginVbHpUlv1Rp1ZU4H1xojiJNnnKe7a4
         J680SUmQHug1+O1pss2AOrdp7YHtMvDpjppSGQntWOd/5pedDLT+hzdAZsgkeo/oN5+a
         h/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684522202; x=1687114202;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTUEsS20+JWfFefGFxAlmb68/xkcFppSNirNHBfFJGA=;
        b=keXfOvncjt0l2R4KEUzUvVRjzoOuTqszFIZZl+LNeGPA9OGDRNl9BLqVsS9mmTmrkm
         6Qcos9pr0aDLZ21JM8yp53YmY4TjX6iBzC8DY50gt05PCJ2TQ4xpn2Mzj5Q13Rje6Bxy
         LZIOiFapGK3fnWx2jiioaJETL+uSXrmTilNmvQtsOrfpl+eAoJay785/+zVmi6X3v6K9
         G/IImnrPUnlTj0Mq9FB4Cd3YMTmoW3i/wkkk/nvxDylyjRYyC88bPpiUCmycy39eOuKH
         uOsfDwJzMyDFttUTvMDBzGlopE7Rt352fqwyUG8XFEDQehOfpBGVwNI4iJDj9l2N5O2X
         cpvw==
X-Gm-Message-State: AC+VfDyKnGb8xEI7E6Ka/kP1VFdzELq8GbYZXnzmJxb6V4xzTWvInKPp
        e/KdWZPS9JAHNCN3A2hrkJQgyw==
X-Google-Smtp-Source: ACHHUZ43IwIVha+deIV66TxN19aXSfFVWdZZsAoghj3lkwx8EWyN30cvOUHL1ecRK7AQxbPzKA6IAA==
X-Received: by 2002:a05:6512:147:b0:4f3:93d4:2bc7 with SMTP id m7-20020a056512014700b004f393d42bc7mr1259838lfo.36.1684522201760;
        Fri, 19 May 2023 11:50:01 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id x20-20020ac25dd4000000b004f37bd02a89sm678373lfq.287.2023.05.19.11.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 11:50:01 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 19 May 2023 20:49:59 +0200
Subject: [PATCH v2] drm/msm/dpu: Set DPU_DATA_HCTL_EN for in
 INTF_SC7180_MASK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-topic-hctl_en-v2-1-e7bea9f1f5dd@linaro.org>
X-B4-Tracking: v=1; b=H4sIANbEZ2QC/3WNQQqDMBBFryJZd0qMKKar3qNISeJoBkIiEyst4
 t2buu/yPfj/7SIjE2Zxq3bBuFGmFAuoSyWcN3FGoLGwUFI1spU9rGkhB96t4YkRGmOt1tp0Tmt
 RNtZkBMsmOl9W8RVCkQvjRO8z8hgKe8pr4s/Z3Oqf/Xe/1VCDnHrbjlMncWzvgaLhdE08i+E4j
 i9bE/tdwAAAAA==
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Shubhashree Dhar <dhar@codeaurora.org>,
        Raviteja Tamatam <travitej@codeaurora.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684522200; l=1779;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=pAP/phIYSh7fnR3TZQDt1S75nNfckM/QPQMkcpx1MHk=;
 b=rj0I0SkomI8uK3sxTU6N+M/TsYvAYp6mC3zNbbLftt+9EDVyjRN/yxroXTIbaQbeCe5jkQQWJ
 V2OsjvS6+ejAyhgX0axt2BVK9sX9Fys7RbW/io9F1g9F1a+hayUXayF
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

DPU5 and newer targets enable this unconditionally. Move it from the
SC7280 mask to the SC7180 one.

Fixes: 7e6ee55320f0 ("drm/msm/disp/dpu1: enable DATA_HCTL_EN for sc7280 target")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Depends on:
https://lore.kernel.org/linux-arm-msm/20230405-add-dsc-support-v2-0-1072c70e9786@quicinc.com/
---
Changes in v2:
- Use a more fitting fixes tag
- Add braces around 7280 macro definition (checkpatch)
- Link to v1: https://lore.kernel.org/r/20230508-topic-hctl_en-v1-1-0f8b5df60ed5@linaro.org
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 27420fc863d6..005f09fcf334 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -98,9 +98,12 @@
 #define INTF_SDM845_MASK (0)
 
 #define INTF_SC7180_MASK \
-	(BIT(DPU_INTF_INPUT_CTRL) | BIT(DPU_INTF_TE) | BIT(DPU_INTF_STATUS_SUPPORTED))
+	(BIT(DPU_INTF_INPUT_CTRL) | \
+	 BIT(DPU_INTF_TE) | \
+	 BIT(DPU_INTF_STATUS_SUPPORTED) | \
+	 BIT(DPU_DATA_HCTL_EN))
 
-#define INTF_SC7280_MASK INTF_SC7180_MASK | BIT(DPU_DATA_HCTL_EN) | BIT(DPU_INTF_DATA_COMPRESS)
+#define INTF_SC7280_MASK (INTF_SC7180_MASK | BIT(DPU_INTF_DATA_COMPRESS))
 
 #define WB_SM8250_MASK (BIT(DPU_WB_LINE_MODE) | \
 			 BIT(DPU_WB_UBWC) | \

---
base-commit: c47189dee0decd9ecc1e65ae376ad6d4b0b7f1f2
change-id: 20230508-topic-hctl_en-3abb999a6c99

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

