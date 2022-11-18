Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C3B62F4DF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240830AbiKRMeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiKRMeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:34:17 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7650C8A16E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:34:15 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id c25so6580596ljr.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FlHzCCH4KJwO0lgQdL8J9FjkLpXQgQjYuKByJocNfQU=;
        b=DhjurLkGZCt16EyCU9+P6tF42Bok0r6ikcxjd2UIhW93t7m++orv1R9GEA3MXkilBZ
         ZbtCPSq+D25dpx+k7esuGOUfqCEqGed/mtV4J0qjRslGgFoLVdl37/BF3OyOJoKjtLsq
         fh8mURuL0Y1PDTW8lQt5LX2QZNJbtl71fX1Vb2/L9HZbFOwcX7eJUZV2GL52/VLDscCs
         0o8RDBwCyeButTgipa28nsq7e4MxdeezJ9j8tNcEcgnEri8Uh3I9nvRGIaqOVl/f/qS3
         7XlcgBPsmplWYrkbZ6cl9wwcLzNlKS8IE7EqGhyBzQF3T+5rlyW00LfWFIcBJhUsiuaW
         xpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlHzCCH4KJwO0lgQdL8J9FjkLpXQgQjYuKByJocNfQU=;
        b=Qfekg+ECfFPhArVcED4kpUR/lnMURQz0D2kNelTu7OiVT29xoYz4/Hzt/HgQBUbWOa
         if/A9j+5xVrzGeZxTVgTytSCzEWySFa4uf2UQLyKlihpAAGHrCCaT0nISPNPrERE9wJ3
         QewuU5H3A5+YDFceWvXxtyF+aHvkGDe+SDhLRbmXV4fl8iBDQ4oaCU2oLW2yCgT5sENX
         NUccLLGh7/emwc2UQqjVxGkgFmFdhEIynMW2zOixFCCthyQBMkznCKRmWq9rF1fZPdc1
         dpvSz05ltOxDNP2FDX47p8qzaUTfHho3TVgick/f8IkTtia9AUw7cvkAlGPS46akWnFO
         AkSg==
X-Gm-Message-State: ANoB5pmGttX7w/sfeurkcaNTMtWw/4bjq2OSza8b4q+RXgZum7lVbZO6
        wW4AWLJjMxEwtJla4sqzScRyPg==
X-Google-Smtp-Source: AA0mqf7P1tz/5Tp9Df40oRr7GKytpVeScjeKcyYNn9SReYrD1IefrvrwYnl2oZBUqw+vK7Y99P29Qw==
X-Received: by 2002:a2e:a90d:0:b0:277:5e9d:508a with SMTP id j13-20020a2ea90d000000b002775e9d508amr2606716ljq.191.1668774853811;
        Fri, 18 Nov 2022 04:34:13 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m10-20020a19434a000000b004ac088fdfd2sm645833lfj.85.2022.11.18.04.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:34:13 -0800 (PST)
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
Subject: [PATCH v2 0/7] dt-bindings: remoteproc: qcom: split and reorganize PAS/PIL
Date:   Fri, 18 Nov 2022 13:33:55 +0100
Message-Id: <20221118123402.95784-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Changes since v1
================
1. Keep resets, reset-names, qcom,qmp and qcom,halt-regs in qcom,adsp, because
   they are not shared with most of PAS bindings.
2. Add firmware-name to examples.
3. New patches: qcom,sc8180x-pas and qcom,sdx55-pas.

Description
===========
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

Krzysztof Kozlowski (7):
  dt-bindings: remoteproc: qcom,adsp: split common part
  dt-bindings: remoteproc: qcom,sm8350-pas: split into separate file
  dt-bindings: remoteproc: qcom,sm8150-pas: split into separate file
  dt-bindings: remoteproc: qcom,sm6350-pas: split into separate file
  dt-bindings: remoteproc: qcom,sc8280xp-pas: split into separate file
  dt-bindings: remoteproc: qcom,sc8180x-pas: split into separate file
  dt-bindings: remoteproc: qcom,sdx55-pas: split into separate file

 .../bindings/remoteproc/qcom,adsp.yaml        | 241 +-----------------
 .../bindings/remoteproc/qcom,pas-common.yaml  |  97 +++++++
 .../bindings/remoteproc/qcom,sc8180x-pas.yaml | 101 ++++++++
 .../remoteproc/qcom,sc8280xp-pas.yaml         | 160 ++++++++++++
 .../bindings/remoteproc/qcom,sdx55-pas.yaml   | 101 ++++++++
 .../bindings/remoteproc/qcom,sm6350-pas.yaml  | 173 +++++++++++++
 .../bindings/remoteproc/qcom,sm8150-pas.yaml  | 184 +++++++++++++
 .../bindings/remoteproc/qcom,sm8350-pas.yaml  | 194 ++++++++++++++
 8 files changed, 1012 insertions(+), 239 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml

-- 
2.34.1

