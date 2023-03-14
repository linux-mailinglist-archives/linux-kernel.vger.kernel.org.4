Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36A96B955E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjCNNFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjCNNFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:05:01 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA3AA6777
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:01:25 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id t14so15936155ljd.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678798851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqZsJOX1El+luUmSocWq2Ruds493hltfIeGTUI/M7s0=;
        b=B/vkYv7pcW9KifG8mE1qbX6/uLEckjlB8A/quad07fF3Q8vqrXi1JBCIAhjpHf3ZU3
         TaGEpitikRZY5/7u+AA1jkYZhoI45k+wfJ3jw5RWGT+JaTmQyu4ONZBnT8BsYjzM0ZWH
         gMEGPxtJZJtH9+ILJla7NwPBdgVF8d7PRNzN17d61dFg2zJ0BPXzA2BbULEsgpRtyfGf
         y1/MmusEN1gdWDGK7Np4hpAvcv1hTYAHtopOc5COl9TuhGEpzOIKPJwyWY4D59BrkFaP
         6DGHew5oWkg90IcsjwP+T7MxS2Lmi2GSIRWKb3TXdtQ61fX1tkaWVv+V7dle7sesBJMh
         /CHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678798851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqZsJOX1El+luUmSocWq2Ruds493hltfIeGTUI/M7s0=;
        b=4vQJ9X5fZc5Koe0FO7BcbDnePhcX1sT6lqhSsNXAo3A4GUewIEyJkW35DsJWPK2O2s
         IYkLSJhwN6R1X1rX+OmsHMpki9h60w3e0S4Z32G4YC773FJ+N4L9xZD2SjpUdcvNPydT
         QfzSIUevf+L542PJ5cJh3fEAAvjVoHt0D6LaiOc3iCinkszRpfdvgfvt4tyQDhBTT5nt
         zFGsMH+XDBBCyrhNqOv+jSugi/i3WkI88kKUTlMvR5lJqAcSNuqEPmCJao6/DgAwZ3T0
         u6hYHPmz2s8YHNVEouftHf6jqSqpaTe+G9Biu00VfgNAC8Sk1HAHZAeO9GBXEQA0wyKw
         evTA==
X-Gm-Message-State: AO0yUKU61PtGHyHfj4jaKR+/8VrorOBe4BP376VqA4Y7I+PKBKSEH5Bz
        eUODqoENKxMfRG7btW+zg245SHssbig6pzEYZAE=
X-Google-Smtp-Source: AK7set9qOvhwQgOeP4U1McR7yj1LUoKO8eAR6fKuhFRTzvH3/lO2wA88LCnFpHmHEttF3cZT0GEPtg==
X-Received: by 2002:ac2:5a11:0:b0:4dd:afb4:26b3 with SMTP id q17-20020ac25a11000000b004ddafb426b3mr768141lfn.16.1678798391245;
        Tue, 14 Mar 2023 05:53:11 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id s9-20020a19ad49000000b004dda74eccafsm395374lfd.68.2023.03.14.05.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 05:53:10 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 13:52:57 +0100
Subject: [PATCH 2/6] dt-bindings: dmaengine: qcom: gpi: Add QCM2290 GPI DMA
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230314-topic-2290_compats-v1-2-47e26c3c0365@linaro.org>
References: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
In-Reply-To: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678798384; l=817;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9mAqu5IGrrdUOaP0PlfWAkH94BH0kiBbnQ1iZWRCDUM=;
 b=Sh44OBUk8yAs+WqMAoK2kFFPM3jib6rHQJUJlUycILo2oU82/iPMiKJDnydXvXJL+YhzIpMEFN+N
 sGnknaghBoSI8VGUuzX1St9M1lXVjwwnkKWcthQp66XIHR9eCzzo
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

Add a compatible for the single GPI DMA controller on QCM2290. It uses
the same 0x10000 offset as SM6350.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index fc5de7b6f19e..f61145c91b6d 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,sm6350-gpi-dma
       - items:
           - enum:
+              - qcom,qcm2290-gpi-dma
               - qcom,qdu1000-gpi-dma
               - qcom,sc7280-gpi-dma
               - qcom,sm6115-gpi-dma

-- 
2.39.2

