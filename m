Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB0463E15E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiK3ULT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiK3UKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:10:54 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA649FED3;
        Wed, 30 Nov 2022 12:10:01 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id l8so22135533ljh.13;
        Wed, 30 Nov 2022 12:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtbcVDOlSSICppU8bmiIzEOVnGi+rn0ffRRtzVm9HYM=;
        b=SZ5d6ev9r09CMO9NZ5TAAqxnvHGHw5iLAi67TfBuDpgAPToHeOTMHEt5FGGuqZ05fK
         tRuD1dhKOrKg467YlYTcyqyqKl8P+nLFsz9TbDbCgMKpRNUOaLm3TNwy0gYYhaq303oa
         joSoJWqcYob1I54np+894tqftUMhE1DfafMji4zK0cp9rQUpGeyKcwpjmBXsaKGeJSnN
         BNdJrA+U1IqpLJICLdJzBIgAHIOKJD2bDf275p+8mbjtK2Z8qrzekDuOrCn/t/WdstNE
         cpkjX3FcYcUmtit8BXo9SjOxJrVkPKoF3t/vL14vr+P7mjCBElZk4r6OdLbGyu/g5uff
         yjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtbcVDOlSSICppU8bmiIzEOVnGi+rn0ffRRtzVm9HYM=;
        b=3JkPbmuRiPs3MDX05d/RylAVAD2lxE27Y2y5H7n+ClMtzhiXthhUaQGlNtCU2Rotlc
         8m6RVUjz8+99pk2gtEoyFVmXOC6LIURuTzAffxcdglDZ9Fy2uinlqSR4utK9KabL1hCc
         rB5DBPhibwZNU68SrBaRPnK+wXcysTQsHq7AL4+BIe+bs1rMGCoy85K7pt2fTR8TEwov
         jyumPSm7VAqX2UMwd/Syx/bFrpXA7uMFrOw8dySmm5RJ43G8ldzkq7IM1WuToblIAMcp
         Pf6l48xToOXF5ZxQ3YWIog20vc3JhEmlK9lvsSE6srn2an3NSpsyZOw5fW7DM7EZeXlm
         yX1A==
X-Gm-Message-State: ANoB5pm4EPJl7Zq2wYF8oy0lTDVwWiIsvtyerl+kG0+aEz+yP/9OWelv
        twty1bSx08Udpo/La6Puee/vTAIy1ck=
X-Google-Smtp-Source: AA0mqf7CPPdhD9/47NvmpJGuRSGX1fRLAxNTyYeYNqwuRejlvC9chRe92gvY63/gfDu3dgJIVFL30w==
X-Received: by 2002:a2e:93d7:0:b0:279:7294:5e42 with SMTP id p23-20020a2e93d7000000b0027972945e42mr13933762ljh.81.1669838998761;
        Wed, 30 Nov 2022 12:09:58 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id a25-20020a056512201900b004b4e9580b1asm369754lfb.66.2022.11.30.12.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:09:58 -0800 (PST)
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
Subject: [PATCH v2 01/12] dt-bindings: display: msm: Rename mdss node name in example
Date:   Wed, 30 Nov 2022 21:09:39 +0100
Message-Id: <20221130200950.144618-2-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130200950.144618-1-a39.skl@gmail.com>
References: <20221130200950.144618-1-a39.skl@gmail.com>
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

Follow other YAMLs and replace mdss name into display-subystem.

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

