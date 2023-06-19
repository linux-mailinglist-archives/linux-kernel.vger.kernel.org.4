Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38631735C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjFSQop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjFSQof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:44:35 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275D5E7B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:44:31 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f8689fbf59so2238867e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687193069; x=1689785069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uceOjOeFYW3YrOQKTUQY3Yfirv5mMIrxQprXiD+0ONY=;
        b=xOpv7V8piGwp9kSuScZZYSxnOZCd1tk3gtMa7ADQ1jETVtQDlOZSbz2uvTAIlOGc3W
         WklI9+RaTjwHA60bw1xN/rT+m1Xlh1D+00CdRAXqtyDZQwhFz9wiyFySTD9ik4C6HjOI
         +oHgfZYqmxzeIz6lR6rDj8pLEP1yiRds05eBGV3pi8O0xwqmlUvCMxTPdKpfNR4K/+bp
         kwtVrVUw9fVKf0fIgMu1OAYdESLJvmKaRLj7f2Msy52SLuJ23BLApzG6KmA9Rk61ffcC
         +DScSF9HB6sfexQETdwd9EC4aFcaYDeHHicOnu4Ct3QPlZxllOQPRpjUlFm/qAbkAuYd
         BuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687193069; x=1689785069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uceOjOeFYW3YrOQKTUQY3Yfirv5mMIrxQprXiD+0ONY=;
        b=PjgFmAiEyBPjRWWbfVg8bM1Lr6g2ZTbPFhAzvXIrPg+uKKY1DL/L2nCk8W03BeV7Wi
         6EWi+C2etGaIqBUBXFZ7dgegrHqTHY0t0DXZNVjwRXGwLwx5ShYCyKbfa3T0qNU0nlUH
         oZIlV6cHEj34IqDkcN8Ol+xzPW5/7BGen4QQL+UvplIG4GPq0Qh1XC1x3lpzrHIZG73t
         U3EZ4tnzHQ1ACOrxW1EOmvD8zohA7AjhHJCfP3QPSZHNaxxfwd+Tw5Kb9Y+v1R75nxJm
         7kf+8dCYmPxn4oLDTHGSOpAxGKCWrMeceEVNYXTg3ylaP57FcDlp/7wi+pE8blPnd1Fl
         35Lw==
X-Gm-Message-State: AC+VfDxMXZWEicjNJO9iQQtwtDitx1S4U61rLS3LQfG7KmP5fgmc/pCE
        jwS/tD2oGYgfBVkAUjrpHPFaUw==
X-Google-Smtp-Source: ACHHUZ55co0W+lBHMkpkIC71790GAjDutHsy5crYaSggmViTCmrlSdoglUSzsLjo7L/kFLehqHaRFg==
X-Received: by 2002:a05:6512:1046:b0:4f4:7a5:e800 with SMTP id c6-20020a056512104600b004f407a5e800mr5318895lfb.10.1687193069425;
        Mon, 19 Jun 2023 09:44:29 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id d9-20020ac24c89000000b004f849605be7sm1774293lfl.292.2023.06.19.09.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 09:44:29 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 18:44:25 +0200
Subject: [PATCH v3 5/6] drm/msm/a6xx: Improve GMU force shutdown sequence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-a7xx_prep-v3-5-a3ce3725385b@linaro.org>
References: <20230517-topic-a7xx_prep-v3-0-a3ce3725385b@linaro.org>
In-Reply-To: <20230517-topic-a7xx_prep-v3-0-a3ce3725385b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687193061; l=999;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=HgL0AdZtJqxx0twaid3jHnuqKqCDcBlTAxb3JHJlxVw=;
 b=Pf6zJ0t2/uvlo+V9LyriSjXmfPMpP8Bno7oiFYGpMsSxVxwUMlFcB7vC+QzDp3HIKqNnv00kF
 IyI9s9s/9X7CNSdq1Wjolu7Eh34qSmxBKzhPddf6H7Ru943onBZn7t1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GMU force shutdown sequence involves some additional register cleanup
which was not implemented previously. Do so.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 9929ff187368..55b12a8066ee 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -893,6 +893,13 @@ static void a6xx_gmu_force_off(struct a6xx_gmu *gmu)
 	/* Make sure there are no outstanding RPMh votes */
 	a6xx_gmu_rpmh_off(gmu);
 
+	/* Clear the WRITEDROPPED fields and put fence into allow mode */
+	gmu_write(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS_CLR, 0x7);
+	gmu_write(gmu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, 0);
+
+	/* Make sure the above writes go through */
+	wmb();
+
 	/* Halt the gmu cm3 core */
 	gmu_write(gmu, REG_A6XX_GMU_CM3_SYSRESET, 1);
 

-- 
2.41.0

