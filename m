Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420066B8A84
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 06:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCNFiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 01:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjCNFiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 01:38:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A1982379
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 22:37:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso3790157pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 22:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678772260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2qLWiEu+kwQHNuuyN9RiYgLYwjEZFKFrGhRPUZl538=;
        b=BxxSAemif3HMqEBDGRssBokbkkaHm51vUuIzdJK/3H++ZYNX9HnjmVXIIgCVNGJ4xB
         4JbzAw5ygYQFgdkjMPKz7Cqupde1QscsZt1N28G8TkGyd/ZNg5hhyEw6Uo0ggqBezmVB
         uDYxWI7yt5SO7kwY91lKEVf0+uWmjbBsAsmt9ObcXmF6tYQXI6zRbgjWlJx0PKsus2YW
         5k8r8Vlv4cfKjbAsSgkXKYBv9Bm+9pvKFNBcDYKsXurGSxp4W58YRjERsu9b4IaWGQHq
         2xPs3EB9OBpNz13YCaLeWBP+DlPcTUGEz90Ju0StX8bodB8jJr+dmErzLt6fuFN0F55v
         kLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678772260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2qLWiEu+kwQHNuuyN9RiYgLYwjEZFKFrGhRPUZl538=;
        b=e+0p5Q4w6s57fyFSvyeTuFNlbPn50qnxDY+4w4TOXbxEI0VSzu5wo5/ZGk4mMbIpFY
         08K2DdsOVMsTgRGhaz1UCUgreTrEg4KBHX6wtqEq59XORy/4Pp0s78n0jVgrfJb09lBp
         VqEG/UqpQNgFBvhdIB9ZvlwVjD1H7XJ0njQxlb89j7jV06NW+j9tSLeWeG6Mfa0zgBWa
         i5PevfQXGKR4BdLTEcntlnDTvDYfSQVo3e6vQ0hryF1HafcfaJM6LWnCgXgvIv8y4z49
         ak6r+2ZFKAYLIT+luHPZlkSHq2GDF7mL9jFKpOhycDBM5PSwMbU/WFbflZHHYUR6cLX8
         ockg==
X-Gm-Message-State: AO0yUKU/XTuLkRya4lmJaS7d3LbCfpqouT3+eN+xE7PewvBKLO32FIwr
        n1JAn+WwKPiqHJI6173ocazr
X-Google-Smtp-Source: AK7set/tW8wGTpZIWi5ofRK6X2Wv0YYAJC3DAVTOdzgj/xECKUeNCPyeIhXQ4KNoQxMfnH3fCqvUoQ==
X-Received: by 2002:a17:902:a986:b0:19d:297:f30b with SMTP id bh6-20020a170902a98600b0019d0297f30bmr28982374plb.19.1678772259922;
        Mon, 13 Mar 2023 22:37:39 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id n126-20020a634084000000b005034a46fbf7sm675093pga.28.2023.03.13.22.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 22:37:39 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com,
        ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 01/13] dt-bindings: arm: msm: Update the maintainers for LLCC
Date:   Tue, 14 Mar 2023 11:07:13 +0530
Message-Id: <20230314053725.13623-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314053725.13623-1-manivannan.sadhasivam@linaro.org>
References: <20230314053725.13623-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both Rishabh and Sai have left Qualcomm, and there is no evidence of them
maintaining with a new identity. So their entry needs to be removed.

Listed Bjorn as the interim maintainer until someone volunteers to maintain
this binding.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
index 38efcad56dbd..6570b808fd0d 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
@@ -7,8 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Last Level Cache Controller
 
 maintainers:
-  - Rishabh Bhatnagar <rishabhb@codeaurora.org>
-  - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
+  - Bjorn Andersson <andersson@kernel.org>
 
 description: |
   LLCC (Last Level Cache Controller) provides last level of cache memory in SoC,
-- 
2.25.1

