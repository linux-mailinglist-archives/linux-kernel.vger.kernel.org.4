Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98E26ADFA2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjCGNC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjCGNB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:01:56 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ED73756E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:01:54 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j11so16890179lfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678194112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7PaidmNsI4X4+HjLVSO/Mw/Vgb1gA+84W9VJP5fzGmw=;
        b=ybDeVf3o3AYMMPETLq2Rdp9UGraYIOlwXEM3om7QZZEOw1tG4ydNiM9rck7drBz1h0
         jWEFVmcl/EKs/NL/y1jVMDZ49zWO7OBk4um0M0rK9XpMSU7r8RZG17JZIxmgQ6hmXKA1
         /jDMG8WfHpNXWlGxHtJrAP/YQeCgxwGS/Tw5baoUbjUo8glTUO0xB5AUpDZ92/0kwt7+
         Sh99yfvUMkuPgHA+uCbGtpApsCwT9j1U0kUGYA6nyFASz+kT6rT0TzFm3NfXubj+9+7H
         P1kJMStI5ESo46W0i1Za41E43Fqd2IOOTtWplXoKOocoX7tGl1tnkvilQleSmdrFDGIy
         495A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678194112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7PaidmNsI4X4+HjLVSO/Mw/Vgb1gA+84W9VJP5fzGmw=;
        b=Eu1UQRcJv2UuLRfrKNSR0AU8OZ+f8FH45SO1nQcE+Aqc8Bnwo7ajgcwLjS2n1SIOId
         U2RT8//GraEo6OplpSTbCYlHNqKLlCNVOBCP8K+cSKl0eh/H7DyNibxr5uG9MPVxt6ke
         bKm2mGOUtlovrh6r5DtlXjwMaCvnQbzyFhMXxfPdDCgS0qtbKyX0hByMpnPnYv1STVh1
         K4vBKsbFGqPAKvhlrj82zoj2zjMtbrRCWrjZJpvPMzU3toJt+9g0I8MnaGsE9FTAJGoY
         sFqYwmTtDNzFI2Z/DqO6p+V3jpy+BGBUgNqQLOKTGm5/JMkZsY62mHDMNqEkLcdtyiqN
         R1nA==
X-Gm-Message-State: AO0yUKVr85DdT+KlkScfRwkbqjvHni4sHZCX7x8VptnIxRutZFj37s3w
        bpE9MvWCd0B2EmYLk5gbbU5pJw==
X-Google-Smtp-Source: AK7set86logaWA856+uKhpszQ0hgdJdLY0fLjfYHHI2H8Bw8JAPRe3fTlXWXmcU0Ng9gw9NRXSTViw==
X-Received: by 2002:ac2:5dfb:0:b0:4d5:8f3e:7852 with SMTP id z27-20020ac25dfb000000b004d58f3e7852mr4051427lfq.49.1678194112386;
        Tue, 07 Mar 2023 05:01:52 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id u2-20020ac248a2000000b004cc5e97d356sm2048265lfg.148.2023.03.07.05.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:01:51 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 07 Mar 2023 14:01:45 +0100
Subject: [PATCH v3 07/10] drm/msm/dsi: Remove custom DSI config handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230307-topic-dsi_qcm-v3-7-8bd7e1add38a@linaro.org>
References: <20230307-topic-dsi_qcm-v3-0-8bd7e1add38a@linaro.org>
In-Reply-To: <20230307-topic-dsi_qcm-v3-0-8bd7e1add38a@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678194100; l=1669;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=x9eSVOGZMp5LDI1BiTB/gmaSF0y+os8hsi63E66yEQw=;
 b=SE4rbaWLt+hWaIAtC7Qt02TIAq4KXSrCYpl8fpJ4Mi/B1KvuDGHtJetP3PvPm2tCvYDkNx2j6kcR
 POEjl9jlCTiSdZQTrezBPqu+t3WWg1iGpvdUwufC2NSGmldNRviD
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
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi.c      | 4 ++--
 drivers/gpu/drm/msm/dsi/dsi_host.c | 4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index 90d43628b22b..e0b911af618d 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -173,10 +173,10 @@ static int dsi_dev_remove(struct platform_device *pdev)
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

