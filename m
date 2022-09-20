Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4477C5BE99D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiITPE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiITPEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:04:37 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079C740576
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:04:20 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id j24so2849740lja.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=SVZ6k+oM0JCP4OT8+67fkZtMwtYdCVTR4DStHO3hiQc=;
        b=TCQUnPGF1UuuBoi6/uhKU93aTXQN/UD3K0JA7QSOz1/xzTet2+lmsaLsDYz2kvg0QB
         WZE7cq8G8/2D3yEbZEbGHQRC3rOiShdM5R2gdM8DEj5ouK78j1ekB6RU3SEG+xM/Y25q
         coZZXSvLyAGWCzp5m5yMF8Xa3SLh+jHYtuo+1GbzJZgPevWy9cbN6sOXh63F3rRGfJlt
         kINaIJdjVikOmbmEAhIbBIhyiXyJFjmLwpmomrJnHm0WE1TuBbU1fd3BE50Sk7djyoLI
         Q/Ua6D8WhnreJsct34iSp0BpWWsQ7N2ybsx3e8uFY16sj+8H7g9N/NSDdIJQ+VSu1EAG
         qSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SVZ6k+oM0JCP4OT8+67fkZtMwtYdCVTR4DStHO3hiQc=;
        b=yYYHUumYbFaktug06JCRxqYSZ4FDVSSV4bo/V2fdur3iWwvOdDL3u/exYBL+Emla+h
         Pj5oEm8peAYNDhqEP+HIBs3nVVdJ8O4K4c830+815C6lSywQMH4zrl078xnnydy0bvFJ
         jznOR9WRDlreOhhP0LMpEmeK1t86KF+w9v2YsPxAsfK93CGhpbdUWCPNkuxVNiT0Q4GV
         7+PzGKDD0mg/xLaAHYaW1HUuk2Btswo2U60LMCJRiMsOAriFgLaQc/N/qAEkmAAH8K0q
         i6VUq2tIURF7Oz2W+gFUlbHGhIaqlScB+MyQ01cyNPGnk9GfCHIGjYlWfplS5/HPVyMj
         Vieg==
X-Gm-Message-State: ACrzQf3EiLEe5OZHiVb7lW2gcdsnmvI6ZPBVm2biv7MhL0K6T/KnJlZ/
        VTS/KpmIMF4TLUQn/U1LgNBrEQ==
X-Google-Smtp-Source: AMsMyM4DR4FdEL3K5QffgANOg+HXdWCQW+PXjnEIBuHuGq/Qi/MmRcI+cYdSeqEr91reB+lbMPkikQ==
X-Received: by 2002:a05:651c:482:b0:26b:e964:3f00 with SMTP id s2-20020a05651c048200b0026be9643f00mr6821597ljc.464.1663686258847;
        Tue, 20 Sep 2022 08:04:18 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p10-20020ac246ca000000b0049f54a976e3sm8294lfo.58.2022.09.20.08.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 08:04:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/3] dt-bindings: hwlock: qcom-hwspinlock: add syscon to MSM8974
Date:   Tue, 20 Sep 2022 17:04:12 +0200
Message-Id: <20220920150414.637634-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220920150414.637634-1-krzysztof.kozlowski@linaro.org>
References: <20220920150414.637634-1-krzysztof.kozlowski@linaro.org>
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

The TCSR_MUTEX region contains two set of registers: mutex and halt.
Add syscon, so the TCSR mutex device (hwspinlock) can use MMIO based
method and in the same time share regmap with other devices for the halt
regs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/hwlock/qcom-hwspinlock.yaml         | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
index 1a3adf75934b..ee2726149cf3 100644
--- a/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
+++ b/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
@@ -24,9 +24,13 @@ properties:
               - qcom,apq8084-tcsr-mutex
               - qcom,ipq6018-tcsr-mutex
               - qcom,msm8226-tcsr-mutex
-              - qcom,msm8974-tcsr-mutex
               - qcom,msm8994-tcsr-mutex
           - const: qcom,tcsr-mutex
+      - items:
+          - enum:
+              - qcom,msm8974-tcsr-mutex
+          - const: qcom,tcsr-mutex
+          - const: syscon
 
   reg:
     maxItems: 1
-- 
2.34.1

