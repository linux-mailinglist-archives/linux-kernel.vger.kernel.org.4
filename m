Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8163623116
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiKIRIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiKIRIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:08:34 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F491DF04
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 09:08:30 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ft34so12152215ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 09:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHux2jjrYoVEJwP0MNszHotsTHFQdT2cU1/inZIsUFg=;
        b=aJzV4MBPzdttkFtPuCHAOshT6jPGNBb7lVNbTsO9VVVS+V/MkhszX/I/AWhC8H28jT
         wy7R0olId8GXrCXSaG+zbyMjDDPjf9ieVIXMUDBPTXJqZ5EmDXlc0vHvp6w/rvPzTM41
         qbeU2uR95aiFVJeENsDOj80OomP3V3Czml9LL0lzRAq0zTGTCz5fXcg2qgDDBIIIEGRz
         0Cy68ScPR/6lNbqfXITDCSBKSQ+3gidKOqHTm3nT3xbGrmYzvm2vEZWTkrAfL4j/zjIJ
         OZ7mdv98vr0pSAICpiRKNkzQm1f4zEGC9i1MlrdQsyzcQ/8M6ffCatvvm15i4h4I+RPJ
         t2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHux2jjrYoVEJwP0MNszHotsTHFQdT2cU1/inZIsUFg=;
        b=uSeVl4UyHDXWR/q5wvuJjhC7DbAHCi+G/mycUj91wC5KFFzM8QI8/Hr5c4vgb6rf+x
         efWflUSIQSQJcyELd7mJMP79s2VwQHRSGx/8T2Wgw9OKumQd/IErpknXRsud5z6rFcV3
         3HOI/lls/bQiuUpBT3W7K2svlRatIrxPwAxrPIg65LK1CGNkZVWm6ggiRbpMJR+Dsi4I
         O74AHqCgs24wj84YtVSXf6l0qCU6fJJfeQlFR8a5ob9QmJToOttEFKUeTnFTH0vLEWn/
         fZtGwwTNo+fFJvsedbXV2kn1B8bs8f/YHtcCdhCQMxNYIKYiBRDYSD8RxgW4GCrbaFnV
         tdEg==
X-Gm-Message-State: ACrzQf05TIqdMpw7r73pwjR/K4ENB5kppjaBCUSiEMpKOBzT126UjLb5
        AZg/+v4FvgOCKpHTkIibmzpn5A==
X-Google-Smtp-Source: AMsMyM6nqVNe4nxWMn/U4o0xAXjpk2JvCNNAgh2vyA1qC/klN+TtUOwpNWub26MagPzg6BcoTb2/3g==
X-Received: by 2002:a17:906:5ac2:b0:78d:3358:7694 with SMTP id x2-20020a1709065ac200b0078d33587694mr57535641ejs.276.1668013709376;
        Wed, 09 Nov 2022 09:08:29 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id w6-20020a056402070600b0046191f5e946sm7207012edx.21.2022.11.09.09.08.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Nov 2022 09:08:29 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] remoteproc: qcom: pas: Add SM6375 ADSP & CDSP
Date:   Wed,  9 Nov 2022 18:08:22 +0100
Message-Id: <20221109170822.58281-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221109170822.58281-1-konrad.dybcio@linaro.org>
References: <20221109170822.58281-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a config for the ADSP&CDSP present on SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 6afd0941e552..80151101376e 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -971,6 +971,8 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,sm6350-adsp-pas", .data = &sm6350_adsp_resource},
 	{ .compatible = "qcom,sm6350-cdsp-pas", .data = &sm6350_cdsp_resource},
 	{ .compatible = "qcom,sm6350-mpss-pas", .data = &mpss_resource_init},
+	{ .compatible = "qcom,sm6375-adsp-pas", .data = &sm6350_adsp_resource},
+	{ .compatible = "qcom,sm6375-cdsp-pas", .data = &sm8150_cdsp_resource},
 	{ .compatible = "qcom,sm8150-adsp-pas", .data = &sm8150_adsp_resource},
 	{ .compatible = "qcom,sm8150-cdsp-pas", .data = &sm8150_cdsp_resource},
 	{ .compatible = "qcom,sm8150-mpss-pas", .data = &mpss_resource_init},
-- 
2.38.1

