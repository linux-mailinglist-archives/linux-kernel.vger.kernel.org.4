Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BEB6B9397
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjCNMTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjCNMRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:17:30 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B14C87A01
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:15:12 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id s22so19721008lfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678796060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0noliucXU9Jdvv0Hd20Z7afom/lMp4f8K7cr1zSsgo=;
        b=XoBFtXbQtSXG5WclW1los/dZpO5yHIqTv53yG2lZWaTzr3dY8/MjmGb20SpOrIH4nW
         TtkrTvuouYcQao6T0qYjiJK57B60oPgOdOXBvCdj3ftibMdf97Iw0IBnCwkh4st11YeV
         DuyMTdSASAAHbcW1silQ8yPEMSejsOBUtAF/m1jgfhOc3lG/vPozJYpc5diKICMENyzf
         yjRUKM5ciQ2dCUdBUSZlr6c/Kqa5VJYgl3q4jcZp+qXcvAielLI63LeiueIiKVzan6ar
         rmsq/OaCL1rntSFPApp0+oW8yk8Z5tEUJunOdLhiXN2kNZT/l33rUfoOUqM1fk2XGBS7
         afMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678796060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0noliucXU9Jdvv0Hd20Z7afom/lMp4f8K7cr1zSsgo=;
        b=BlDhIa3SBxe3cN9sIzESC9j1Jiyqf0rrtBObmNv3iXaWpw6FuFinIDm7IP8DZTnGp4
         nTS/qrk/N4OBFDcBI2b19UXkgDceS/DkjotrdDGUbLlFvlSChsmyoADW2QXSCnuEV5cz
         /sctU9pVEzdoExrMK6D73shWquXM4G91K4A/D8c6HvH8L+Q7eCQJCxGWeeCuaC72s70C
         S3BXS4rJVCFmESrb7vFVGaX5JVDTKzVbKm+9o8+t6+nad0hDfYjjdmKMKSocimk+WO0O
         jzy1QEfupPYD3KGhuCeXm0U/BNmPBnpp3lh611NFCsm0Lusk0b8Q+9rCB3DqMk8ZyKyx
         eNNw==
X-Gm-Message-State: AO0yUKWZ2x86ngMtA2OInftRJ7W7QcgwwRhfJNksQUSqkJB6HlaPuNtx
        AFs0uDJzmTbK6p6bRgtNmRvIZg==
X-Google-Smtp-Source: AK7set/VKwfxDeNKVkhVwQmiIpG92zx0bpa+hICEMxp1oB0u8pUIuUXXLyI1ZHxeFtZCzLflZ6YrPw==
X-Received: by 2002:a19:f508:0:b0:4de:e802:b7e3 with SMTP id j8-20020a19f508000000b004dee802b7e3mr581098lfb.19.1678796060264;
        Tue, 14 Mar 2023 05:14:20 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id s4-20020a19ad44000000b004dda87ecae3sm379058lfd.246.2023.03.14.05.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 05:14:19 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 13:13:45 +0100
Subject: [PATCH v4 07/10] drm/msm/dsi: Remove custom DSI config handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230307-topic-dsi_qcm-v4-7-54b4898189cb@linaro.org>
References: <20230307-topic-dsi_qcm-v4-0-54b4898189cb@linaro.org>
In-Reply-To: <20230307-topic-dsi_qcm-v4-0-54b4898189cb@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678796043; l=2248;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=XyYOOI1oosMrjhHufAshg6wFIoQ3jCyg3dymQPN3J1A=;
 b=h8pc1bjL2lI6iQ31RL4kpzTbX0PpqKAoYACSpyK+h0eLIKLO7FFFQ1qC3y+mRzAFZMW+u9eoWcZd
 juim+86NDrq6hafxwJkCfMB+ugGrgMXpOdNydQ/y53PIKQSjXWER
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the only user is handled by common code, remove the option to
specify custom handlers through match data.

This is effectively a revert of commit:
5ae15e76271 ("drm/msm/dsi: Allow to specify dsi config as pdata")

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi.c      | 4 ++--
 drivers/gpu/drm/msm/dsi/dsi_cfg.h  | 3 ---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 4 ----
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index f761973e4cba..baab79ab6e74 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -172,10 +172,10 @@ static int dsi_dev_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id dt_match[] = {
-	{ .compatible = "qcom,mdss-dsi-ctrl", .data = NULL /* autodetect cfg */ },
+	{ .compatible = "qcom,mdss-dsi-ctrl" },
 
 	/* Deprecated, don't use */
-	{ .compatible = "qcom,dsi-ctrl-6g-qcm2290", .data = NULL },
+	{ .compatible = "qcom,dsi-ctrl-6g-qcm2290" },
 	{}
 };
 
diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
index 8772a3631ac1..91bdaf50bb1a 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
@@ -65,8 +65,5 @@ struct msm_dsi_cfg_handler {
 
 const struct msm_dsi_cfg_handler *msm_dsi_cfg_get(u32 major, u32 minor);
 
-/* Non autodetect configs */
-extern const struct msm_dsi_cfg_handler qcm2290_dsi_cfg_handler;
-
 #endif /* __MSM_DSI_CFG_H__ */
 
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 9cfb9e91bfea..961689a255c4 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -214,10 +214,6 @@ static const struct msm_dsi_cfg_handler *dsi_get_config(
 	int ret;
 	u32 major = 0, minor = 0;
 
-	cfg_hnd = device_get_match_data(dev);
-	if (cfg_hnd)
-		return cfg_hnd;
-
 	ahb_clk = msm_clk_get(msm_host->pdev, "iface");
 	if (IS_ERR(ahb_clk)) {
 		pr_err("%s: cannot get interface clock\n", __func__);

-- 
2.39.2

