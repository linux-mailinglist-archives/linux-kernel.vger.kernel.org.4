Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6E56BFA75
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 14:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCRNnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 09:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjCRNnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 09:43:11 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A9732CEC
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 06:43:06 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id by8so6586663ljb.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 06:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679146984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vhpul7Rh3cRj+K0GuudZQvoFoP/xfXO3CkdZI/yylms=;
        b=j426X71mabGLe1BqLKd75IEf3x1OwnMZApw94sSoRjI9PIBDOgl5mmVj97uwADtRIo
         dPQ35g3OJujaMQjQn7viOa6Q7fmpMnQ/y5NCKb3hLvNau9VWW993qWBwOUW89sRwWHTB
         RrQQ/mhy3s7dFVDtwZap3HhE8vNBSXT72A3Y83fC026lvBC4bg3+0owmbu3Njq9nWxy7
         oa3wwhpAO6vi9u2HQ0NWCRRlydJOKZTTYJ5UyqV5YvtAQIrDrAid7V4U2aonZQlZRE7I
         qZemPNvc/UJ3Ghjgfsa73cPc1ni3yCKnhp+/HHHAdVb4vHCtrBcIP8or9yXx0OdCkHCJ
         Idgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679146984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vhpul7Rh3cRj+K0GuudZQvoFoP/xfXO3CkdZI/yylms=;
        b=cOSmgU9/SDRSaxPd10I2/RTCBwoK8TseeHmzabdXe653YIjxL/cclzfBdjtxi+AP2i
         OvBmhVTDClvQyo1+hyTWjfLefqkYUmm6m9z9W2OVSqmg1il/Y38CFxzAsnjM5uiuu3wd
         3KuvK6fgdA/o6kxK8PgVTWBDca0Z4HLijz6E/Sn3pb9yD8dJELtjXV7PLR0KbkJS7pYh
         c8Tzd5zOg8f9VtIy0VmO+qoMwCYK4aw6dWtxQlAPoyc4SBVl8wb2Kh/IxjNU/wUkSF2t
         CLY++UC4Ty+ELj5AxiPbgG63FY4Ow//7BP4U1GkduhBtSThoRyFOihM/f5szi2T7bL3B
         DWzg==
X-Gm-Message-State: AO0yUKXtiDmQx8gK4Jy6NDBrrdkCzYjoDQmqXz9+9CeOf5x47aPbvYfi
        k1h/x/6LTOq10v6GW0PC/wKKp5gbqeS7Bl9PxDk=
X-Google-Smtp-Source: AK7set+IUKK9tzzPVlhNLzpxw7e6QXgi8Si9QxetIZhZPNuGjkdCxGjG1Aq+32VGmSOdt+mXVZYAnw==
X-Received: by 2002:a2e:9f44:0:b0:29b:767f:1421 with SMTP id v4-20020a2e9f44000000b0029b767f1421mr686870ljk.45.1679146984292;
        Sat, 18 Mar 2023 06:43:04 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id c2-20020a2e9d82000000b0029a0b50a34asm888367ljj.36.2023.03.18.06.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 06:43:03 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 18 Mar 2023 14:42:53 +0100
Subject: [PATCH v6 7/9] drm/msm/dsi: Remove custom DSI config handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230307-topic-dsi_qcm-v6-7-70e13b1214fa@linaro.org>
References: <20230307-topic-dsi_qcm-v6-0-70e13b1214fa@linaro.org>
In-Reply-To: <20230307-topic-dsi_qcm-v6-0-70e13b1214fa@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679146971; l=1730;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=F4fPirOHyMQPj35ost0pdi8esBWoDrjWNUljpExX+4U=;
 b=JQL4C8eZU9KdW70xgkVjmI9WYhpJRT9iemBV2gYY5kx+UgSGZNBtZXViYaamh9bBOeacUVPvECKx
 Hx3zj/elBCkSn/QqsBsTWvU8RPfp3CbFyjYsorJTAB5uakOYwph8
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 drivers/gpu/drm/msm/dsi/dsi_host.c | 4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)

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

