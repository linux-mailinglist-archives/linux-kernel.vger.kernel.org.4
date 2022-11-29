Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097B363C98E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbiK2UrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbiK2Uq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:46:56 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011A6264AE;
        Tue, 29 Nov 2022 12:46:55 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id r8so18656315ljn.8;
        Tue, 29 Nov 2022 12:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bc2wd09Vf93CqCZ4OitfPPdDRgWz7evH44zLSPOfnkw=;
        b=Goy5X3TGbfRaFrdqc6vQC+dVOU5SDvgc//B7vrY+xmhxApivyBX6X6g0CsQL1U+12f
         AklX7NKyRYGyQT1piHT03Obs5wzFoHeS4Lg/jVbknKveBoB7WDmuYJqBkveGjeFUFjbk
         7nNoMc9RkNfL1IMI9q3YL5Yy/IuQrABXcXajqjV+aozEK+sYUQCswoHeoV+LyE6oz7vd
         VhkwBdBBz/JlWsJEzTht/1rPwvkPUWRqtflSOJ6DSa43ONxG1EiAlPTC/VDatnpdL2nf
         haFvMzty+TFL6AzeVLysm5R/8xUNTbZVi5cKc+XaFKBanW7yz6YuiPuul0nirgYizT5U
         n5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bc2wd09Vf93CqCZ4OitfPPdDRgWz7evH44zLSPOfnkw=;
        b=nrsAGuBK42WmR5KHZZ1aNCAlv1DasshtbI40cEbu2h+RBNe3JTpo3F610xzLB1eD+j
         a0VlIvgxIhjKO77pOXKFmiQ2ApJMZDvDa4LAnJARI9QyCTueQcoh+eATbViAT9JqkLsT
         afcqc1/R9r+fK5hJVaR/ANL7E1zRKzwdth83H3Qjzxx9wISvak+V9/nB+IAseRJ7I0YZ
         C3d+EAl4LqsC/vk9qdrKZNZutbojTeEotJKaAj8CmW/iXtybSGRSljKVZ07GoCIm+mzR
         bO+R2YKdUPtl+m6SoAZBAVli8vK+siHX/+EMG5JrgO2Ckl59rYCoa3A9XtJEFqJENKZe
         s4oQ==
X-Gm-Message-State: ANoB5pkPxaDQjj8uxLJY+AFzVprg8Ospdnn89bq5Zyg7B4Gpch76eox1
        VgqqJ/+y9mBdPlTmJULzaXLMtv2ewcM=
X-Google-Smtp-Source: AA0mqf50ce6u/oMNPHzvmd0XckXmqYwp8E3XMboa2j9FJlBeVEF4COF+erao2NEaj7JiigRUIyS8UA==
X-Received: by 2002:a2e:9c45:0:b0:26f:bd73:489b with SMTP id t5-20020a2e9c45000000b0026fbd73489bmr15874760ljj.478.1669754814273;
        Tue, 29 Nov 2022 12:46:54 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id o11-20020ac24e8b000000b004ae24368195sm2325620lfr.233.2022.11.29.12.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 12:46:53 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 01/12] dt-bindings: display: msm: Replace mdss with display-subsystem
Date:   Tue, 29 Nov 2022 21:46:05 +0100
Message-Id: <20221129204616.47006-2-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221129204616.47006-1-a39.skl@gmail.com>
References: <20221129204616.47006-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow other YAMLs and replace mdss name.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 .../devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml      | 2 +-
 .../devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
index d6f043a4b08d..4795e13c7b59 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
@@ -72,7 +72,7 @@ examples:
     #include <dt-bindings/interconnect/qcom,qcm2290.h>
     #include <dt-bindings/power/qcom-rpmpd.h>
 
-    mdss@5e00000 {
+    display-subsystem@5e00000 {
         #address-cells = <1>;
         #size-cells = <1>;
         compatible = "qcom,qcm2290-mdss";
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
index a86d7f53fa84..886858ef6700 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
@@ -62,7 +62,7 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/power/qcom-rpmpd.h>
 
-    mdss@5e00000 {
+    display-subsystem@5e00000 {
         #address-cells = <1>;
         #size-cells = <1>;
         compatible = "qcom,sm6115-mdss";
-- 
2.25.1

