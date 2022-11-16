Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F8E62C317
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiKPPyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiKPPyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:54:22 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27FD47320
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:54:20 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id r12so30195593lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x61XENO10P73sJaqpMir6Zd1RPLJtcnUpkPInROKPhs=;
        b=J+WyS+18pYK5gb5pSIbpZhQddz2jw48TXdkqfC4atduq9Gxrl+Ap8HpdT76hIZ0BvO
         JFyMyOjnLLtufdmANsMfPQ8ZrrkYf0+DDL3vjvecLFpcVUmZLbjENKb8ZMpYyA0SRneN
         oc7ixZBwarobSdjo4upPkKTwWeaBguKvRY3SBLOW4Gp8RiC6NmJvFxF0j+4/Qfohk4ob
         J66ateLT1og/Ef49xPalLbP0D8nH85R0tz/7yIgeFY0YHFmTMSxVbcucfDYzdd55KSeC
         DWjd45KToS23UiNyu7Y3wp/X7ZnTIMkPeW6PsYZuaGVZZcnwDOeQwVD91+epvB32zckP
         x8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x61XENO10P73sJaqpMir6Zd1RPLJtcnUpkPInROKPhs=;
        b=y1/o9j6bTAdo6HKL1gqZyWmQI8ejtt2bms3T7R6iRJ7Y5zxCwkqWpb2unckLYLpc6D
         2oAmY5mVlbRpNojQ+nt6ucO79Sn7xX40tfdvh82pza3fA//0/HZEdaGhv3FO49crIvbV
         kD4SquAKx4d8Epa25YROII4HYZ5S9v5g5SSxycMyQ8rHDAKeIZIiZdgwCM8gnGXF82kR
         jpZiUQAXpj0E8u5xwINhKCLdh2MvuIvOy0+buQ27m0ZUe5z/lJyFG+nTCFi6OaxRd7jq
         /2lUntj4kF2HLb3t4dUmkb5TRcZmvnv7liRXxYoen7dp7uchd0X4VSbc6nZeaQcM7SGR
         fhIA==
X-Gm-Message-State: ANoB5plWdRMki3pBIagqrJzQ32RT67hJgFN8+spERTnHjam7YNHzNS5X
        KMDNa6IFKl98aYJRozUJZZLDMw==
X-Google-Smtp-Source: AA0mqf7Kx9Dbj5ynt4BC2nqBQdQuqsrtEUKsXay1mniKRqjawlRTFdGjV93sNPtcg61LNDtSsZr0tw==
X-Received: by 2002:a05:6512:224d:b0:4a2:be5c:688f with SMTP id i13-20020a056512224d00b004a2be5c688fmr6876505lfu.121.1668614058965;
        Wed, 16 Nov 2022 07:54:18 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u19-20020a05651220d300b0049462af8614sm2655128lfr.145.2022.11.16.07.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 07:54:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/5] dt-bindings: remoteproc: qcom: split and reorganize PAS/PIL
Date:   Wed, 16 Nov 2022 16:54:11 +0100
Message-Id: <20221116155416.164239-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The Qualcomm PAS/PIL (qcom,adsp.yaml) bindings grew considerably with huge
amount of if:then:else blocks and 40 compatibles (still growing).   These
if:then:else blocks constrain clocks, power-domains and interrupt per variants.
Adding new variants is now tricky - it's easy to forget to add variant to one
if:then: clause.

Split the bindings into reusable schema and per-soc bindings, groupping them
when applicable.

This part is finished, but more and more compatibles should be moved out of
qcom,adsp.yaml, eventually dropping the file.

Best regards,
Krzysztof

Krzysztof Kozlowski (5):
  dt-bindings: remoteproc: qcom,adsp: split common part
  dt-bindings: remoteproc: qcom,sm8350-pas: split into separate file
  dt-bindings: remoteproc: qcom,sm8150-pas: split into separate file
  dt-bindings: remoteproc: qcom,sm6350-pas: split into separate file
  dt-bindings: remoteproc: qcom,sc8280xp-pas: split into separate file

 .../bindings/remoteproc/qcom,adsp.yaml        | 234 +-----------------
 .../bindings/remoteproc/qcom,pas-common.yaml  | 121 +++++++++
 .../remoteproc/qcom,sc8280xp-pas.yaml         | 154 ++++++++++++
 .../bindings/remoteproc/qcom,sm6350-pas.yaml  | 169 +++++++++++++
 .../bindings/remoteproc/qcom,sm8150-pas.yaml  | 178 +++++++++++++
 .../bindings/remoteproc/qcom,sm8350-pas.yaml  | 188 ++++++++++++++
 6 files changed, 812 insertions(+), 232 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml

-- 
2.34.1

