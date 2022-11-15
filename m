Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FB9629A84
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbiKONcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbiKONbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:31:50 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866A329C82
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:31:37 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id u24so21816040edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cCi/ES9FuqiQm+KWnSYhmAQtDDx+gMJGxqOaQjv7UIk=;
        b=Wzx8DYBHXIYeswZwDCSF56PUk7V4nUuegWHM7Fy6L+Mg6b4kHm8LTHxaeNZEJMoA/i
         dzCxvPoOj7o8hhckG6o7DbOmNuZ61dazbyjTHKsXFh0Aqi4g33YZRH0uXNgYacvfIWr7
         NHdFsxnUyE5PZ6Jscp+azDvCoZZkalOuZC5C7QdYPVJAI5nZHMs+A4M+lUrH17UpkfHZ
         62UFl4cRGDB9vMH+ULMSCIs+He7M3K/OQ4qPSHBo/qziRcuXxI1LPC46dnuHHD3x4exP
         0lWJ7xY9ASWgL/r9a2P8cOPxycPcI98RxyMAI0ejbAGex4DBC163JVxGwuBHgv1Vgfbk
         UzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCi/ES9FuqiQm+KWnSYhmAQtDDx+gMJGxqOaQjv7UIk=;
        b=avQMQ8gi5W3VXt3MTfVv1xMB6VwsZM7RsedvEdqKWEdxVHhU9/ejtRw+xz5EyUAfxt
         gEzUx9bXCA/y5/ngzcOyLCbr6UGyGh3O0t58guPkQzsW189nQhO+cGUvJJ2AmmjxA8J6
         WfsoW6tL3yf2ZLrXUJfmV68Hn3jyA7Jyiof1sZod/qI6glKFt/nbw2cLYQ3QCmquMa+T
         ecePYIHyxd5pc8mCl9tZmPD8jx5sZmPQ4WnHUSNtkQN881LxzHLTIvdveiwRpWFh/zDn
         GPCZzB8+uoVwzCmEw14FplBtTpi/zt2SUVIu/B1Vnvl7jdi9hy3rKV6bDpExazxYNDnr
         0kgw==
X-Gm-Message-State: ANoB5plx781YGPCbceOEn9pIqMpzdkmEAGKzcfMXr/1rMXbn0HOQWLiP
        0TB/gJnH5eZT5PMgILnhSI/T5Q==
X-Google-Smtp-Source: AA0mqf7bl80L9QHfvrgMQcRIUQbJ3AxQoxSjPv/3VC37LXF/mTDNhPsQrYKvsB8QW8ZSzZywGnLJ+g==
X-Received: by 2002:aa7:d799:0:b0:461:6f87:20bb with SMTP id s25-20020aa7d799000000b004616f8720bbmr14959954edq.300.1668519096017;
        Tue, 15 Nov 2022 05:31:36 -0800 (PST)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id q22-20020aa7d456000000b004618f2127d2sm6162176edr.57.2022.11.15.05.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:31:35 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        quic_kalyant@quicinc.com, swboyd@chromium.org,
        robert.foss@linaro.org, angelogioacchino.delregno@somainline.org,
        loic.poulain@linaro.org, quic_khsieh@quicinc.com,
        quic_vpolimer@quicinc.com, vkoul@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        vinod.koul@linaro.org, quic_jesszhan@quicinc.com,
        andersson@kernel.org
Subject: [PATCH v2 11/12] arm64: dts: qcom: sm8350-hdk: Enable display & dsi nodes
Date:   Tue, 15 Nov 2022 14:31:04 +0100
Message-Id: <20221115133105.980877-12-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115133105.980877-1-robert.foss@linaro.org>
References: <20221115133105.980877-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the display subsystem and the dsi0 output for
the sm8350-hdk board.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index e6deb08c6da0..39462c659c58 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -213,10 +213,32 @@ &cdsp {
 	firmware-name = "qcom/sm8350/cdsp.mbn";
 };
 
+&dispcc {
+	status = "okay";
+};
+
+&dsi0 {
+	vdda-supply = <&vreg_l6b_1p2>;
+	status = "okay";
+};
+
+&dsi0_phy  {
+	vdds-supply = <&vreg_l5b_0p88>;
+	status = "okay";
+};
+
 &gpi_dma1 {
 	status = "okay";
 };
 
+&mdss {
+	status = "okay";
+};
+
+&mdss_mdp {
+	status = "okay";
+};
+
 &mpss {
 	status = "okay";
 	firmware-name = "qcom/sm8350/modem.mbn";
-- 
2.34.1

