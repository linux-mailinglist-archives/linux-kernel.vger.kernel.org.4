Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FBC6B8CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjCNILd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjCNIK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:10:59 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE3A97FEC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:09:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id j11so58458303edq.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678781363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpSUX7WridYFFvb5Xp7cUrsNqCFgLBD3FO2lvz7TpLw=;
        b=xhONnVNZBzNkDZcDF4u2HT+ctYxoTFnZ93Tex9vHHMXPMP5fPYTexIiCZCbpXhWZFx
         oiMc34e64z/RkEjsaM26XTjtrG1fZafIunMDvn63Ob3007EILXQYf4mXCtefe5tpxSD5
         JpZDO/5EubmA8pV7fTK6qp0cvZlFnUyuBi/3mqP0s/lCvjkRIYCCqXO3mCgJNM/q8yaC
         O0VsVmnKV3ae30JUgXvUQpTaCvRo3HUvyCN2GuIC9ROeiTFTx8uugmVvEmYUbsSsBn7c
         vLhk7ZO1ft1M5EFfK8bRUck0s3Mbvg/OMfGkL8SXJGcagqfjEgCGpxAhutF318FA6XX8
         hL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678781363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpSUX7WridYFFvb5Xp7cUrsNqCFgLBD3FO2lvz7TpLw=;
        b=Sw+LNpeg3chMf0dJKuyR6jmVCMIDqvpQKw7id3yYWVhLsZMPSR5jc1P40Hn+s9pzrE
         A9cdMUOnSH7XQGLQKziboFS/gXZEYtr2dkEZysxbQAXWCkq794NsrNIB3Qy++6RRv7Y4
         nY0AzWi9Q5KTBPppyOuoP5YWaHrWrnUWUcVp1WjvQ/ZBJS4O4IW+4Ys3785XM7DuqsE5
         GyXABkwHGjx9hHDa7Zq5dYm4UWFUjsyJIdTIb3wyx41eeY19o4cP3yf9YkfZT4yTFjfi
         lSA3Jos4uhx6+fq5P+BL/MeF5pDUhwPNXORNva+s1FZlFJI7ty6s1lGHx1Y9eWp/x0Ue
         OZEA==
X-Gm-Message-State: AO0yUKVEPjgjwU+fMNz0vjBoZ4cKMoIhYc93Nii3yfjNrO9TMfOWcxcB
        PZPmdIgs5nqNOZqqqGZuB7V6Gg==
X-Google-Smtp-Source: AK7set+oQzK0YF58etbtDT3XedATdfjVZZOCg/XVjGBoot/E8Ncg3zAWKakxktZtLLUin0yiT1J46Q==
X-Received: by 2002:aa7:cf0c:0:b0:4fd:8210:58d4 with SMTP id a12-20020aa7cf0c000000b004fd821058d4mr1270463edy.15.1678781363393;
        Tue, 14 Mar 2023 01:09:23 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6932:5570:6254:9edd])
        by smtp.gmail.com with ESMTPSA id co2-20020a0564020c0200b004fce9ff4830sm584872edb.88.2023.03.14.01.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 01:09:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 04/13] mailbox: qcom-apcs-ipc: do not grow the of_device_id
Date:   Tue, 14 Mar 2023 09:09:08 +0100
Message-Id: <20230314080917.68246-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230314080917.68246-1-krzysztof.kozlowski@linaro.org>
References: <20230314080917.68246-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-organize the compatible devices and add a comment to avoid unneeded
of_device_id growth with every new SoC.  These devices have quite a lot
of similarities and they can use only one compatible fallback for driver
binding.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 6bbf87c6d60b..f3ac0b035945 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -143,17 +143,19 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
 static const struct of_device_id qcom_apcs_ipc_of_match[] = {
 	{ .compatible = "qcom,ipq5332-apcs-apps-global", .data = &ipq6018_apcs_data },
 	{ .compatible = "qcom,ipq6018-apcs-apps-global", .data = &ipq6018_apcs_data },
-	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = &ipq6018_apcs_data },
 	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = &msm8916_apcs_data },
-	{ .compatible = "qcom,msm8939-apcs-kpss-global", .data = &msm8916_apcs_data },
 	{ .compatible = "qcom,msm8953-apcs-kpss-global", .data = &msm8994_apcs_data },
+	{ .compatible = "qcom,msm8996-apcs-hmss-global", .data = &msm8996_apcs_data },
+	{ .compatible = "qcom,sc7180-apss-shared", .data = &apps_shared_apcs_data },
+	{ .compatible = "qcom,sdx55-apcs-gcc", .data = &sdx55_apcs_data },
+	/* Do not add any more entries using existing driver data */
+	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = &ipq6018_apcs_data },
+	{ .compatible = "qcom,msm8939-apcs-kpss-global", .data = &msm8916_apcs_data },
 	{ .compatible = "qcom,msm8976-apcs-kpss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,msm8994-apcs-kpss-global", .data = &msm8994_apcs_data },
-	{ .compatible = "qcom,msm8996-apcs-hmss-global", .data = &msm8996_apcs_data },
 	{ .compatible = "qcom,msm8998-apcs-hmss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,qcm2290-apcs-hmss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,qcs404-apcs-apps-global", .data = &msm8916_apcs_data },
-	{ .compatible = "qcom,sc7180-apss-shared", .data = &apps_shared_apcs_data },
 	{ .compatible = "qcom,sc8180x-apss-shared", .data = &apps_shared_apcs_data },
 	{ .compatible = "qcom,sdm660-apcs-hmss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,sdm845-apss-shared", .data = &apps_shared_apcs_data },
@@ -161,7 +163,6 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
 	{ .compatible = "qcom,sm6125-apcs-hmss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,sm8150-apss-shared", .data = &apps_shared_apcs_data },
 	{ .compatible = "qcom,sm6115-apcs-hmss-global", .data = &msm8994_apcs_data },
-	{ .compatible = "qcom,sdx55-apcs-gcc", .data = &sdx55_apcs_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_apcs_ipc_of_match);
-- 
2.34.1

