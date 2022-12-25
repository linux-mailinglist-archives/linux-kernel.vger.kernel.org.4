Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AE1655D11
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 13:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiLYMAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 07:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiLYL7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 06:59:38 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1D2655D
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:59:13 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 1so12891450lfz.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAptk8rLRuc++EiVR2BhzhCRqBC2cNP+rXcT62Z3QGY=;
        b=zmGNYtMf+5LhzdwQftQDvVNNA+RobLBX7wcSRBRTkkHfTsvmtclRPocgH99ckU6EEf
         /FNaC0s/R6TrtcQwNhwLNn/Rki4cxAp0Yw0rl4Vx9vzLWOqjlExQM3fxMIq5hksaBH0h
         tE5yriELlFD4ok3T7NDt+I9ET4DSYmNg1wfcFwHovXFtoyiG32sSaHlvYZmO06A3rWyt
         6Iqh7CGU4I2TP0G/jAxsyUS4/JeHga/Be8UcfftZYmKyS+Pbmjl5mxrvY/5lA6TBn2IS
         t/dFTyAqNMZi/Yr++hRXj2w5gVcUm7SbzdmQNpHWChxxg6UzhIfXZ+9ryY6aWiqJeUt7
         YeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAptk8rLRuc++EiVR2BhzhCRqBC2cNP+rXcT62Z3QGY=;
        b=MwatqS4kJwztbvdus2hUgMnZa0Z/vzk4S84DNe0a8NAZWUy4XRXLRarywPcvhb5ffp
         mxjXDLVwNCzlGNXIAyrehsh5mkPEdxpq1XRs7WP4F6FaNQplvHeTzzm+2zxRPjYt+oW5
         RalJSrTnbFgquU2I2g9Oc20014qoM+Y4P6ZkEj0Ngzt9yL4MuzFLz21MJab3Ed/EuZl+
         lQPKM5oefTIOSBKDQSpbMN+Amf89VQB7Z5BTd+HQkAz+E0f4TZiiyUENYrGPjIFVLgnT
         xkgkWiUBmSfxVDPH5zUjya0owTzERngumkYgE/JB93vpQ3pQ1i1PXtrRAUQf5kdeCgCI
         oh4Q==
X-Gm-Message-State: AFqh2krLmW9BrAf823Y7hNuQbYuuFbv/OmxSnVNMu5IWjJGU9f5dGV67
        tJ326XVrMoWEBxrJZJygfC8c3w==
X-Google-Smtp-Source: AMrXdXvKd6pNRzuYv6mW/WnS7/IrdvhA/uDP7T3G8ajivWpzKMEAQFkTnJiW5WQJvksyCUsiPMMYLg==
X-Received: by 2002:ac2:562d:0:b0:4b5:670e:b708 with SMTP id b13-20020ac2562d000000b004b5670eb708mr3708603lff.14.1671969552074;
        Sun, 25 Dec 2022 03:59:12 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b17-20020ac25e91000000b004cb061887b5sm128819lfq.126.2022.12.25.03.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 03:59:11 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ASoC: dt-bindings: qcom,lpass-tx-macro: correct clocks on SC7280
Date:   Sun, 25 Dec 2022 12:59:07 +0100
Message-Id: <20221225115907.55250-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221225115907.55250-1-krzysztof.kozlowski@linaro.org>
References: <20221225115907.55250-1-krzysztof.kozlowski@linaro.org>
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

On SC7280 ADSP bypassed platform, there are only three clocks for TX
macro.  This is already reflected in "clock-names" but not in "clocks"
property:

  sc7280-herobrine-zombie-lte.dtb: codec@3220000: clocks: [[219, 8], [219, 7], [220]] is too short

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/sound/qcom,lpass-tx-macro.yaml        | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
index 66431aade3b7..da5f70910da5 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
@@ -30,7 +30,9 @@ properties:
     const: 0
 
   clocks:
-    maxItems: 5
+    oneOf:
+      - maxItems: 3
+      - maxItems: 5
 
   clock-names:
     oneOf:
-- 
2.34.1

