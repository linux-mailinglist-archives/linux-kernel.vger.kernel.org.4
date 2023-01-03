Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F91165C2BE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbjACPFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237628AbjACPEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:04:46 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481DB11A11
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 07:04:45 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id b2so32830830pld.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 07:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03EcVfcgn594UPANtn877VRHUEcrNy316gwc2wdWerc=;
        b=tAwja7qo6FA2QF9L8ZZa7e1lkzKJIkHyamwXHR8tc68vLGODBiKjEwpCCvC3tVNHto
         GJ25c8hpVSOWLPbOOef61/cw7aE7hz4j2AS/p07Xr9ZabWXVpPx6SMVrZm7VIqp4AnR1
         ZR+oSg5R22/Q7d1APEIpAhzuwtEFPtFGajKBXLK4BJGmVDSTprTOk8rh+LigIGcwhnHp
         GJSUHSv0l4LndZ1lXBm1zGKaEcCxOp9n3JC3tBiEWGt3BdyTl1wQekbWmH3CGnIBbFQg
         66lXT7/e7JpToyvPe/SqolNVQ5+Z9jdllB+XTXg5KVxqkXLYjIeMIGf+ii9e54kqDwgT
         O6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03EcVfcgn594UPANtn877VRHUEcrNy316gwc2wdWerc=;
        b=o2AdxeiSTCQwmjWinzrcmm5WqxgL5Ltjo33PqE4mbEsmgDqHwGotRpFwbPvjgk+4mS
         G2D9es0293l7HFKRsQHMU+Pc1sGSApHXKV75LY4Xk/z+vKhcfcftAq9chlvt0gMa/sM4
         U+pavaMlO4QdM6vbDvJ9qDLaZ7y2/FhIGoZENkZU39elVDkdTYZWADWXW8njfy8D16a0
         6v2il+QonVR47JB6zAsHSsqGi0PMSiyzML/CeMlT6x8v7UPkGTLGz3GQbI8LLbxiZhPh
         6hhV8h/qiVFgqoD7LLMFAOxrpNNB/MP16zgFop5y1kZl5kO7Glpn3WVpAD6CXAq07g6d
         /f5w==
X-Gm-Message-State: AFqh2krfzBHR8qDs/d2UWIQcuJ5eN9aU/tmqpYhU8K4WmHCCMTiV1y+x
        XOePAwWrpKNHLofezDd689JwGA==
X-Google-Smtp-Source: AMrXdXvIFIE4chcolI2qPMy9u0aChMMw3jLshK+Aq/mEXy7smiHsERS9+ufNo/GRVN/x/LXdVAie5Q==
X-Received: by 2002:a17:90b:485:b0:20d:bd5e:d54a with SMTP id bh5-20020a17090b048500b0020dbd5ed54amr46844701pjb.21.1672758284721;
        Tue, 03 Jan 2023 07:04:44 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c5e:e3b5:c341:16de:ce17:b857])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a0f0800b0021952b5e9bcsm20952300pjy.53.2023.01.03.07.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 07:04:44 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     quic_schowdhu@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v2 1/2] dt-bindings: soc: qcom: eud: Add SM6115 / SM4250 binding
Date:   Tue,  3 Jan 2023 20:34:18 +0530
Message-Id: <20230103150419.3923421-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230103150419.3923421-1-bhupesh.sharma@linaro.org>
References: <20230103150419.3923421-1-bhupesh.sharma@linaro.org>
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

Add dt-bindings for EUD found on Qualcomm SM6115 / SM4250 SoC.

On this SoC (and derivatives) the enable bit inside 'tcsr_check_reg'
needs to be set first to 'enable' the eud module.

So, update the dt-bindings to accommodate the third register
property required by the driver on these SoCs.

Cc: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/soc/qcom/qcom,eud.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
index c98aab209bc5d..1dffe14868735 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
@@ -18,12 +18,22 @@ properties:
     items:
       - enum:
           - qcom,sc7280-eud
+          - qcom,sm6115-eud
       - const: qcom,eud
 
   reg:
+    minItems: 2
     items:
       - description: EUD Base Register Region
       - description: EUD Mode Manager Register
+      - description: TCSR Check Register
+
+  reg-names:
+    minItems: 2
+    items:
+      - const: eud-base
+      - const: eud-mode-mgr
+      - const: tcsr-check-base
 
   interrupts:
     description: EUD interrupt
-- 
2.38.1

