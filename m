Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDEF655EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 01:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiLZAro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 19:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLZArk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 19:47:40 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A702DCC
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 16:47:35 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id e17-20020a9d7311000000b00678202573f1so5937761otk.8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 16:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akxcV2cbB4tJ7g7nvmljID4qtmKpDankQRHava68ybw=;
        b=Znm9ABhYhs0gBpho7oHw1+ctmxtk10iMkj87Ow+SPaUuSDo+y9wbLzv+dEmN3ikApL
         0PdUfcxA7474J0/hToT5bYV1Oc/4or+WKS9CjK5XcUu1ao6a6lwprRHhg9xGU2thoWMs
         D5As1Wq0VR9zwBgTFk3Dozet0rR6nRGke9tIyp97gehT2N67j2M8WTzKMWHAwVJ7kap5
         de6S7VWIyaItgavgHO8RvE2fMD+RXtF3B6MXvb/QXhMbCZ/i+J75opQcDJANlwewfu/H
         IcKpyjxp1S9ngABTZbQIIROIVr9YIhdorvwg9Qw2PnVo0zI71hlNCbV8NV7QN6Wsgd8h
         1tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akxcV2cbB4tJ7g7nvmljID4qtmKpDankQRHava68ybw=;
        b=5Gha1vtCxeoqyGDiQOx1T+8vxEK9s7ANwK/k2f2cIQFyJ4kR78uAlcvOkheuC4imAS
         udnB4BuwoqJPH9ho5tbWNAj/5Sw8BBdAd49NAdx8QU/thgcEmtUuZZ1DeIhxaaThqE+p
         wHou8JL9IR0zjKoVH1kacVduaLZkFcuT19oF1qASU7m7Y0/2oULSzHe2I3QYNiKiZEOo
         GwW8Dbp+5kku3OuqIuuI5Vb3b7W41KtM69Qi+m+qZq2JwrhLrV+Z0AlG2oO5bNQTYwIC
         UHXqBy095SfPmCPFuBinn4VtrWoTXLE/WGpXv1ujYOtwRVVOC5huc8YFx26mf6eldQ4E
         ZgbQ==
X-Gm-Message-State: AFqh2krPg6lWQ97Q67n9/N3JqD/GGYl2qQwBgSkJJDgSxOl+wLKf84ZX
        40vKOk+JgjQVhqgI0A9Q3Co1oA==
X-Google-Smtp-Source: AMrXdXt6uI087vVxk6tkdMl+VzVrPk3bILzywaRz3jcyNP1gHjlYlMxWUnheK0pTJHZbOSzkDMLU9Q==
X-Received: by 2002:a9d:6d0e:0:b0:678:2963:3831 with SMTP id o14-20020a9d6d0e000000b0067829633831mr8661258otp.22.1672015654496;
        Sun, 25 Dec 2022 16:47:34 -0800 (PST)
Received: from localhost (2603-8081-5300-41db-0000-0000-0000-127b.res6.spectrum.com. [2603:8081:5300:41db::127b])
        by smtp.gmail.com with ESMTPSA id r9-20020a056830418900b006706e4f6863sm4698161otu.75.2022.12.25.16.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 16:47:33 -0800 (PST)
From:   Steev Klimaszewski <steev@kali.org>
To:     steev@kali.org
Cc:     agross@kernel.org, andersson@kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH] arm64: dts: qcom: c630: Fix firmware paths
Date:   Sun, 25 Dec 2022 18:47:27 -0600
Message-Id: <20221226004727.204986-1-steev@kali.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221225040821.8395-1-steev@kali.org>
References: <20221225040821.8395-1-steev@kali.org>
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

The firmware paths were pointing to qcom/manufacturer whereas other
devices have them under qcom/chipset/manufacturer, so fix this up on the
c630, so we follow the same standard setup.

Signed-off-by: Steev Klimaszewski <steev@kali.org>
---
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 7e80e2950f8d..b04cb563496c 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -94,7 +94,7 @@ backlight: backlight {
 };
 
 &adsp_pas {
-	firmware-name = "qcom/LENOVO/81JL/qcadsp850.mbn";
+	firmware-name = "qcom/sdm850/LENOVO/81JL/qcadsp850.mbn";
 	status = "okay";
 };
 
@@ -306,7 +306,7 @@ vreg_lvs2a_1p8: lvs2 {
 };
 
 &cdsp_pas {
-	firmware-name = "qcom/LENOVO/81JL/qccdsp850.mbn";
+	firmware-name = "qcom/sdm850/LENOVO/81JL/qccdsp850.mbn";
 	status = "okay";
 };
 
@@ -345,7 +345,7 @@ &gpu {
 	status = "okay";
 	zap-shader {
 		memory-region = <&gpu_mem>;
-		firmware-name = "qcom/LENOVO/81JL/qcdxkmsuc850.mbn";
+		firmware-name = "qcom/sdm850/LENOVO/81JL/qcdxkmsuc850.mbn";
 	};
 };
 
@@ -502,7 +502,7 @@ &mdss {
 
 &mss_pil {
 	status = "okay";
-	firmware-name = "qcom/LENOVO/81JL/qcdsp1v2850.mbn", "qcom/LENOVO/81JL/qcdsp2850.mbn";
+	firmware-name = "qcom/sdm850/LENOVO/81JL/qcdsp1v2850.mbn", "qcom/sdm850/LENOVO/81JL/qcdsp2850.mbn";
 };
 
 &qup_i2c10_default {
@@ -801,6 +801,7 @@ &usb_2_qmpphy {
 };
 
 &venus {
+	firmware-name = "qcom/sdm850/LENOVO/81JL/qcvss850.mbn";
 	status = "okay";
 };
 
-- 
2.35.1

