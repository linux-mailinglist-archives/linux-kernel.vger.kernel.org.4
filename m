Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBB5642D34
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiLEQkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbiLEQjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:39:22 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5C120373
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:38:07 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id m19so16541282edj.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 08:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FA6VZLr8EX+1LwmM9brJgk2AqL1UbJ0XsUIaiz9n7JY=;
        b=tuw0NhESTq3UZ+zy40f7o9AcmkK+r5BotJvqEeJrQPDv77id5pMwvQOHANJ2pRtiTl
         xfu6zuqe1cvA141nvEgxDsqRM6STYF64bsrkifcmQGHQfR6upjeQ2pNje7FVJr/e3bD/
         7Q8yXuYkEQkCGpUntC88RpDTIMB7KJ7F4idNK0jBre+Ez8Wn5egIntB5VRXzSDec4ICR
         xn0GB/c0+JK1b0gWuCkNWcFtQ/QTSlNO8lezjo0kRY1JbCt35Vss2vzU4viHBqOU6Ciy
         wUKYJF+T/HFTNyQQwori8EBSxhi4ogLMiDJpL5GPTOcJnuPfL2KtbCtqReGC/cMny0BV
         sPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FA6VZLr8EX+1LwmM9brJgk2AqL1UbJ0XsUIaiz9n7JY=;
        b=TKaO4nxDy0/n3RhFL1XgPCEW5LsPZziwpc5k5QwXrnSf2VOBmvpSgYqBOvS5VJE3ud
         2l7tiRzQ3IBH0KlZxyahTrVhehjMWu6DClDzoFAquVKN79aK8orw+bSIHcQhMRZ1t8qo
         8n/eRapSIsxTYRCKp6DmN75gi61Z/Z56CZGumzbenBy3xfPTUEn4zQXy+bjc2JLdL5bl
         SLRUpvkms5B2HXci6zwgAK4ZMHUmu/XoQC1vjfwddQsLQzicGyZNKKXPT48C0hX/ERyl
         vpBWVudG7pEFPECgsH4IUm+K3nm3kVcSYqt//YdNBvnsJQh5grc0tdSRQUS4uyb519HI
         5I1A==
X-Gm-Message-State: ANoB5plU7bnirCQJ8z4D7ANe5OyoLuqaisddVbAp0PPwyHfAGY5TvcMK
        FFGxqd8I/lI9eKYbHXf1FHL5rA==
X-Google-Smtp-Source: AA0mqf4UTFIOaQqMzS0VIDvYTbzzH/oX2gTN+rgxrjAy0Q4o2IYeg3hUbwZ7Nzsbb/5KoI4Sh/LVdw==
X-Received: by 2002:aa7:d556:0:b0:45c:6467:94e2 with SMTP id u22-20020aa7d556000000b0045c646794e2mr73784880edr.295.1670258287354;
        Mon, 05 Dec 2022 08:38:07 -0800 (PST)
Received: from prec5560.localdomain (ip5f58f364.dynamic.kabel-deutschland.de. [95.88.243.100])
        by smtp.gmail.com with ESMTPSA id e21-20020a170906315500b007bed316a6d9sm6413610eje.18.2022.12.05.08.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 08:38:06 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        quic_kalyant@quicinc.com, angelogioacchino.delregno@somainline.org,
        robert.foss@linaro.org, loic.poulain@linaro.org,
        swboyd@chromium.org, quic_vpolimer@quicinc.com, vkoul@kernel.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Marek <jonathan@marek.ca>, vinod.koul@linaro.org,
        quic_jesszhan@quicinc.com, andersson@kernel.org
Subject: [PATCH v3 05/11] drm/msm: Add support for SM8350
Date:   Mon,  5 Dec 2022 17:37:48 +0100
Message-Id: <20221205163754.221139-6-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221205163754.221139-1-robert.foss@linaro.org>
References: <20221205163754.221139-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatibles string, "qcom,sm8350-mdss", for the multimedia display
subsystem unit used on Qualcomm SM8350 platform.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/gpu/drm/msm/msm_mdss.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index a2264fb517a1..39746b972cdd 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -293,6 +293,9 @@ static int msm_mdss_enable(struct msm_mdss *msm_mdss)
 		/* UBWC_2_0 */
 		msm_mdss_setup_ubwc_dec_20(msm_mdss, 0x1e);
 		break;
+	case DPU_HW_VER_700:
+		msm_mdss_setup_ubwc_dec_40(msm_mdss, UBWC_4_0, 6, 1, 1, 1);
+		break;
 	case DPU_HW_VER_720:
 		msm_mdss_setup_ubwc_dec_40(msm_mdss, UBWC_3_0, 6, 1, 1, 1);
 		break;
@@ -530,6 +533,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,sc8180x-mdss" },
 	{ .compatible = "qcom,sm8150-mdss" },
 	{ .compatible = "qcom,sm8250-mdss" },
+	{ .compatible = "qcom,sm8350-mdss" },
 	{ .compatible = "qcom,sm8450-mdss" },
 	{}
 };
-- 
2.34.1

