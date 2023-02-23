Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA77E6A06BC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjBWKwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbjBWKwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:52:19 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345A072E43
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:52:13 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id i9so13106457lfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=312OV1ExLaf1docfwSJg/DyYHuD2OoIvYCwHKB24HQI=;
        b=Ce/cN8SJNqmnOLGti7C/wIYSkPwOXN+WsO7YJlUi1HVGSsH4IugGMhdMSOArjMUlwz
         AfXqXzfVXH7StipBipyI9C3rVs/AfBEsOlpjoGUJH6oUehAIfEiVTE3C8iOSLzVu/Lym
         /2bcRB2hfvVFzai8oYsySHFBGqcL9QaQK0N/izI0yShx3HtY8Ngi1xEHljGpBafM+oCJ
         SCvH6y3c6LpK5hC/pNqwwIfaGs4EQfZlF7AyG9hek48zBPsI3xMZUy97nqProR/RqSYk
         lJOjp5loyoTQHXMZpg7J2h+5BR/glkMobFjQAxPjq9GGDGwqLeYNFHMwlydmAu+ROLIU
         iwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=312OV1ExLaf1docfwSJg/DyYHuD2OoIvYCwHKB24HQI=;
        b=E5s2q+n/ZTfxkveElizBfZhR9qfJnZ+28sNDIkpErjwEgm5+9FZ4/bBvRBVblEL7Sj
         cpDRD7LNp8NAhUsFe0bTKglV1YW4DJCUrWOUnNvt3KZ6eetxTdo4Utku8MSd+c3Rop6F
         f+1QfODzKSpaR1cwu4WxtN6V+yAzjRsenX121PHoOSEC/h21KtRf4X5dm7vJxZop5wBD
         UVI0l3pjVNDvrt/1QQvkHbVhw75OR+FGDSYxB2nsOM+VYC741ftPto+WzIjQDCAVSydy
         yw5OTHk4jlqA7Q53lRwXkEp/fgaRMHn82zEHTDKSk2Ws7vZqhMHM9e6qRUJjLw1r5K+C
         YVvw==
X-Gm-Message-State: AO0yUKXVhYPpGNepJ5lAlxfCJg23sw1CMimXQF0Az/sjRDUAr0vSXs4z
        drbG648FW5dsQDfJPyXnfX08hQ==
X-Google-Smtp-Source: AK7set8osHC1BKuwQhKilzcKra4Qow5sccaKlgb33WRhd1YaD6tJd1VO+rXTjbpXroqZwNqtZ8dETQ==
X-Received: by 2002:ac2:5225:0:b0:4dc:4bda:c26f with SMTP id i5-20020ac25225000000b004dc4bdac26fmr3063427lfl.23.1677149532652;
        Thu, 23 Feb 2023 02:52:12 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id m25-20020ac24ad9000000b004cf07a0051csm262304lfp.228.2023.02.23.02.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 02:52:12 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 23 Feb 2023 11:52:03 +0100
Subject: [PATCH v3 7/7] drm/msm/adreno: Enable optional icc voting from OPP
 tables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-opp-v3-7-5f22163cd1df@linaro.org>
References: <20230223-topic-opp-v3-0-5f22163cd1df@linaro.org>
In-Reply-To: <20230223-topic-opp-v3-0-5f22163cd1df@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677149522; l=828;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Yh6pwT6P3XDwmr1GaQu8MRHxTbI8EpTO/tdF6ItczWk=;
 b=2rrRDrTtljtkMy2NiIvypriRAjz8Zl6PZhh4lLLHUrTd/4LPzZWyfiOavFuEJQnJLGhxCc/L8cSg
 DQgfDp28B0bz+/nmo/25V3K4pnLZVeMgAtqBwOy48QqoAzn8bDYx
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

