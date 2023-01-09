Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8929D6622EE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236985AbjAIKRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbjAIKPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:15:52 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF49018683
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:15:26 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id ay12-20020a05600c1e0c00b003d9ea12bafcso3199689wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rC1HixjrwVN9Qc0qid0oTivyKuzDUPdxp8z39RQ72Wo=;
        b=hrmmo8SfG3rmXaOE36H7v1YZqukMDa8MI8vpJRCx1CnZUlDPVo4sgTKsZe1EhicxGD
         Z7j3yv3t4IwRwCg0bPqLbt6upC4ABF6iKrwi+JCLHHa8GbiszajKnYfB9HrG6RKq9aXu
         rtVmJ/dFAKn6rp2DYq0toXAi01/YKxFGPs3WaVoSjq42zDs6FHcS1TbW/L4jN4lKB7/t
         lQBG6pawRi49WYYRWKs0yfLFWRMK7D2XSuYhWHkPU64igHOINl1a51eELIICdiX+HK5g
         2yapJv5ar9Jusxmy9ObnGiIbh9enqvpkD3xvOgnsA8XpFyBhHvtAjACkUDQNRds+F2kz
         Px8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rC1HixjrwVN9Qc0qid0oTivyKuzDUPdxp8z39RQ72Wo=;
        b=M/cvBbFH5hYgIUr7FnbTgFhx71oTAmbAq2H+Txx3qAXcCUdoj/I+AZIaV6+DjCpP1s
         IwM7YF9JOYLeMQ/C6f1Pj7lV+e5sx5VDVH3Z85+ZjeZRYO88oNZabAB+RXtEXiqX3EcL
         1V6yVdbyfnRAApp0RosnJn2a05u0ph4EAO6SoKimJihdVlLrpHQM+O8mnH5DPq6EkhFv
         TcfoMrINFHCOJVwHvUfhWP2RMttDXpvazKnhH2ZgkLqWfp2NMW4BXof1+NGHhB3L3hmi
         SNHdpmV/2qk/+Gbu4CQEwcVxhQWD/1c/n2TeldGQS4KvbvEpQm6fvIYboqcHDU6KONUG
         WDZA==
X-Gm-Message-State: AFqh2koIg3r7qR0t9R0DZsEhvigxPO5JaLaMURCGHtgZy7shQZWwX3IJ
        0MzCVQlfAA3c/yYUBhfQqxUtih7ynOsSrLm4
X-Google-Smtp-Source: AMrXdXvN9kPFfEkhuEuShiZhptcP7yVgJq6IbPS8mOT9HkvcQPU81vvmcJtpG//3N6IhBs5RiJbKnw==
X-Received: by 2002:a05:600c:1c90:b0:3cf:75a8:ecf4 with SMTP id k16-20020a05600c1c9000b003cf75a8ecf4mr46102577wms.24.1673259325399;
        Mon, 09 Jan 2023 02:15:25 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c2caa00b003cfd58409desm15815376wmc.13.2023.01.09.02.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:15:25 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 09 Jan 2023 11:15:21 +0100
Subject: [PATCH v3 5/7] drm/msm: mdss: add support for SM8550
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230103-topic-sm8550-upstream-mdss-dsi-v3-5-660c3bcb127f@linaro.org>
References: <20230103-topic-sm8550-upstream-mdss-dsi-v3-0-660c3bcb127f@linaro.org>
In-Reply-To: <20230103-topic-sm8550-upstream-mdss-dsi-v3-0-660c3bcb127f@linaro.org>
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
