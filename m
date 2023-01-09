Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA40C66218A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbjAIJ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbjAIJ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:26:53 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ECD10F6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:26:46 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id co23so7490978wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 01:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rC1HixjrwVN9Qc0qid0oTivyKuzDUPdxp8z39RQ72Wo=;
        b=WCSTQ9fE7LeKldP5+7GocbbKTVHoX/d8InfYfMZRlbNol+MYwWcaNiBXl7GbiuWwhR
         bzVndpVTf3vfMDa/M6/bkeZZLfBe2xzuShKVFxgcyeSty4aaKRsgw5oGBKLZMabeD3nh
         IPT72zACPbO46ASTp4zicPPmdiDx3bMs341v9C/S2XjufaOs8VGF47L6qEi0b3KqaHeE
         hsGWCZaDK8JtLW1/XLTC5JfPFlfjA3d+9MI3sQOGMAO6HXi6YKlRvcZGLUkbd9kRk4vl
         No7fFvcO7s+J+h74KM1a17bxGK8BiD5nOCiGhvPPZi0GmeGrf0+kFN2nSC0HHU6aXl04
         sy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rC1HixjrwVN9Qc0qid0oTivyKuzDUPdxp8z39RQ72Wo=;
        b=I3kZN6jw3G79sQ2wXhAge8F3HLH8WgbZQSbBsAstQNnkxEMMmsauOL7JPoyCspr/pi
         6bQjSQk1Lb2JRkSgIsEDup3igiEpl3wD7OfKzKoPW+SGsxi8E784cNlafGVO3/b/qDIS
         TXU9Z7azvJ7hfL7q54qcoNp6o88a+f1rTFzj8GaKwwW/C/RwCek736u/FwWhDVeLuYfr
         i4MstLW1imDFBj+4E3/sVPq2yA9ZLpZ90wl/5MrdOAdKDpH2Kz9g8G7KbIqeT0jHkZQ0
         IfDSROxjQsGzf1WlxED190iZqIf9FFbaVqL6EIix0dvxsLvlZCrW9cAN5GJF4uQZ9swU
         UaAg==
X-Gm-Message-State: AFqh2kpOYAl2edY1cjpFdW1fI5vIHee2HNA80DM/g6Kt6ogwCzCGIzTn
        C7GToN4X17g4DqhpCyp1BrdwtQ==
X-Google-Smtp-Source: AMrXdXu4ne+cM168gcr5bsxq+9YaFJqprFI6YALoEk7kMsZ6KWiYfgjoLAmIbIm8Z4otE/XGn09ObA==
X-Received: by 2002:adf:e8ca:0:b0:2ba:bd95:e3b1 with SMTP id k10-20020adfe8ca000000b002babd95e3b1mr9260409wrn.29.1673256405383;
        Mon, 09 Jan 2023 01:26:45 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id s23-20020a1cf217000000b003d1e3b1624dsm15195758wmc.2.2023.01.09.01.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 01:26:45 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 09 Jan 2023 10:26:37 +0100
Subject: [PATCH v2 5/7] drm/msm: mdss: add support for SM8550
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230103-topic-sm8550-upstream-mdss-dsi-v2-5-87f1c16d7635@linaro.org>
References: <20230103-topic-sm8550-upstream-mdss-dsi-v2-0-87f1c16d7635@linaro.org>
In-Reply-To: <20230103-topic-sm8550-upstream-mdss-dsi-v2-0-87f1c16d7635@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the MDSS block on SM8550 platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/msm_mdss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index f9ef5085041d..02646e4bb4cd 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -297,6 +297,7 @@ static int msm_mdss_enable(struct msm_mdss *msm_mdss)
 		msm_mdss_setup_ubwc_dec_40(msm_mdss, UBWC_4_0, 6, 1, 2, 1);
 		break;
 	case DPU_HW_VER_810:
+	case DPU_HW_VER_900:
 		/* TODO: highest_bank_bit = 2 for LP_DDR4 */
 		msm_mdss_setup_ubwc_dec_40(msm_mdss, UBWC_4_0, 6, 1, 3, 1);
 		break;
@@ -532,6 +533,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,sm8250-mdss" },
 	{ .compatible = "qcom,sm8350-mdss" },
 	{ .compatible = "qcom,sm8450-mdss" },
+	{ .compatible = "qcom,sm8550-mdss" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mdss_dt_match);

-- 
2.34.1
