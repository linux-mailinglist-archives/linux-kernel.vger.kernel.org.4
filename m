Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E5C6E7D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjDSOmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjDSOmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:42:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6B76595
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:42:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id he13so22242043wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20221208.gappssmtp.com; s=20221208; t=1681915320; x=1684507320;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fy+0cJCJMoy6q1lt77Xw630BaQNJm0bVoX1TCrs3OHc=;
        b=TzNkV/S3zFklfY2UCSUJJ8GaXQEK01Ig7lF3ptkDh7sr3gmXJ0YtaAtQE06vGXZaHX
         j/OVRey0YO0AksedTMCLzJTj85LrZ2G/vsgQaYgnFPrsmyitzLq3atec/uX4/Cv+ZPOS
         Rhu9fJQgcS58K/Wgv/w+GuXnwPuHG5MGJiJgBULg+t1oZWYef74qhBWDQvrXR9xippis
         lK7t1uqEDmGanbf8ABGrVfSqFgjbHqGfvC5O9R/906X3UYQ6SaEqvjY/JL4XsudvYZ0M
         qEGUUBcigDPecKfDHIjvy7AsPi9Fq/wAYwQfdsX3mN5WOWkBV4Qi1oxBAKGrMsPHXR96
         BUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681915320; x=1684507320;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fy+0cJCJMoy6q1lt77Xw630BaQNJm0bVoX1TCrs3OHc=;
        b=dXtI3M6tDlK5An1PS1szNaxRDSPU9dYMFEM8yph9MPwlKUAlKNlr/MmWIY7/OmHwaw
         qrNT0De6BfIKMYbNwQtRSV0lbIo8H27ahN0QfhIomSwWAuZeX0ADwwFPmAmfl4nBYZGj
         lL3XL+hmdPE8I+l/VIp1T0gjJSFYlNSQcY4GLfXStK28Uz7KozuLxGKvkMaUmKMn2mUK
         8rusdNQybfkf4DyEi+YUQI2cjIbz5nd+a1+Sa7aK/nA7+ZgiZ0gHwuB7QeZMn394so3S
         G6FhugP4TOEkjnGnea3K7ounE0oZfRtiS2rAsVv+ViL3YCp1OLtzMTaVhR+hX6l7bM/x
         HewA==
X-Gm-Message-State: AAQBX9cYnZ9ZxBOjSnSEcwV7IoO1OUywqjinwmLN3MExXAh6Cu5WvCBP
        GBijtaGnimjkFglK2ng2xA7Q
X-Google-Smtp-Source: AKy350bb1NXI+uElCaT8lhQg1emtnFFKn0pOu68118BMLxyYhN1FaTa9Dxc9OVnIZR5V+JRxT0jpGw==
X-Received: by 2002:a05:600c:329a:b0:3f1:7382:b59a with SMTP id t26-20020a05600c329a00b003f17382b59amr2551876wmp.15.1681915320689;
        Wed, 19 Apr 2023 07:42:00 -0700 (PDT)
Received: from [127.0.1.1] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id m22-20020a7bcb96000000b003f17131952fsm2388519wmi.29.2023.04.19.07.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:42:00 -0700 (PDT)
From:   Arnaud Vrac <avrac@freebox.fr>
Date:   Wed, 19 Apr 2023 16:41:17 +0200
Subject: [PATCH 10/11] drm/msm/dpu: tweak lm pairings in msm8998 hw catalog
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dpu-tweaks-v1-10-d1bac46db075@freebox.fr>
References: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
In-Reply-To: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Arnaud Vrac <avrac@freebox.fr>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837; i=avrac@freebox.fr;
 h=from:subject:message-id; bh=RJf9+pkwKnpAj0n2TU3Q6xrSZUQHiMRxoj2hVwg/D2M=;
 b=owEBbQKS/ZANAwAIAXED/9m7NDSrAcsmYgBkP/2tJVIeIaiPZf6H3y1PL945iCKPGqC5XoDbK
 VcSUvP5HoeJAjMEAAEIAB0WIQSUwb/ndwkXHdZ/QQZxA//ZuzQ0qwUCZD/9rQAKCRBxA//ZuzQ0
 q3kWEACrjFf+j8o/Ef0fbuwzpaWOroIhsFLQ666cwtToMvHEcF84UQvLMywCIwuYoeuN8TBhQiY
 g01vQtCeGnPg6/d/ZN10aYjVVxhZuooBA8B2c0sbNDrM2YgjIpJEKrLmqgXlXXT5zQvYHhKb2NS
 0hN1Odqd3m+C/oI9yrHWeZXMjE+ollCpLPwYxV56R6P2Dtzu51Vn5HGDzlVPFqvunCUvATTALei
 i/0BuGL90b7BrYpAhdCewFRtz6lWaV4UHmrpx+51BD9pw8pto1wdz8TTQczi5UWzns75ZRTXx7a
 LbAjWXCezkAOvfbjYh12wamJ2qde1Ea0WjzyjRZ3sHgPD6Q1SrMoePqs1prrNPxEK+g8DBTTPCj
 EnyCpixENCuF03h8cc2Tb+WqBxGTAghRF2IrUrq6pOxGZw8IZbLEGZyBH7Xk5BW0kK0k7CjCyzX
 bz8qW8P4deWATI9s2LCqzep56XCI8pZRtojfWoF4/88cecgiLZgEZfk7wmJSVXYE/DebFuSMIcN
 3C5jhV251DaYkRhD7H+TM7/1BlUDDZlB4Yu+hYMTFfZ2RJx2ML4tJBwl6wEqjoirVf2wSreup3Q
 W1dTG4AqleGljnyPIb6L3EjZLo+PXcCsAuT4EmX2dFzuKc0p8ZayIIHzfyHY40eXrWhu1JedzFd
 I6VtSRypg1lRpJw==
X-Developer-Key: i=avrac@freebox.fr; a=openpgp;
 fpr=6225092072BB58E3CEEC091E75392A176D952DB4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change lm blocks pairs so that lm blocks with the same features are
paired together:

LM_0 and LM_1 with PP and DSPP
LM_2 and LM_5 with PP
LM_3 and LM_4

This matches the sdm845 configuration and allows using pp or dspp when 2
lm blocks are needed in the topology. In the previous config the
reservation code could never find an lm pair without a matching feature
set.

Signed-off-by: Arnaud Vrac <avrac@freebox.fr>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
index 5ae1d41e3fa92..90db622eff4fa 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
@@ -102,17 +102,17 @@ static const struct dpu_sspp_cfg msm8998_sspp[] = {
 
 static const struct dpu_lm_cfg msm8998_lm[] = {
 	LM_BLK("lm_0", LM_0, 0x44000, MIXER_MSM8998_MASK,
-		&msm8998_lm_sblk, PINGPONG_0, LM_2, DSPP_0),
+		&msm8998_lm_sblk, PINGPONG_0, LM_1, DSPP_0),
 	LM_BLK("lm_1", LM_1, 0x45000, MIXER_MSM8998_MASK,
-		&msm8998_lm_sblk, PINGPONG_1, LM_5, DSPP_1),
+		&msm8998_lm_sblk, PINGPONG_1, LM_0, DSPP_1),
 	LM_BLK("lm_2", LM_2, 0x46000, MIXER_MSM8998_MASK,
-		&msm8998_lm_sblk, PINGPONG_2, LM_0, 0),
+		&msm8998_lm_sblk, PINGPONG_2, LM_5, 0),
 	LM_BLK("lm_3", LM_3, 0x47000, MIXER_MSM8998_MASK,
 		&msm8998_lm_sblk, PINGPONG_MAX, 0, 0),
 	LM_BLK("lm_4", LM_4, 0x48000, MIXER_MSM8998_MASK,
 		&msm8998_lm_sblk, PINGPONG_MAX, 0, 0),
 	LM_BLK("lm_5", LM_5, 0x49000, MIXER_MSM8998_MASK,
-		&msm8998_lm_sblk, PINGPONG_3, LM_1, 0),
+		&msm8998_lm_sblk, PINGPONG_3, LM_2, 0),
 };
 
 static const struct dpu_pingpong_cfg msm8998_pp[] = {

-- 
2.40.0

