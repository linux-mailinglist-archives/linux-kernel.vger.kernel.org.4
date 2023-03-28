Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C356CBAD8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjC1J3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjC1J2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:28:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A605FEE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:28:39 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so11851903pjl.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679995719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZX8cxV4gmi38o9Pi6mmNL+xnFc7tlNvHJgTN5N6z5i8=;
        b=apzKnvIitSI/0WTFCPr0IhmcMljZeuRif+xWlXzw//hp7biuZMW+mEyGg8x0t72cer
         /T8HMiCeyZ0338n7h8aiKrGSX5fCGUNfA9xc/PLkwcziR9YOnbc1iqWaIZJ972AVMNGS
         4vSDNsV3xIDCKYwtWwdNc9hZP/PuMySyy/OqdLHtcXwbgjoknFlmy4x3VkcLZyFMHbqf
         PIkN55HNJcemfSj3WkfFdGHhiaUNUw/NTzim0J25RpQkeK3HCUg921fR5QMjVCgB7JUp
         W3Uqf+ERgD5Tld4AxO33d5J/CYAcw/+Bnj8sY6KGmtmXFsR5cAgu8Nxzy/BOKFXyi6uS
         23WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679995719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZX8cxV4gmi38o9Pi6mmNL+xnFc7tlNvHJgTN5N6z5i8=;
        b=2FVwtDhW0ZnS3AQhbwxbaPrw4izKKSQPECgygelP4A8rp0Z+FgofMgQKeU2V2tCbuW
         lDmN0jKvvt+deRe/im91cAMhFz6q5RcGtR59QAGF4ytTwqWO8Hxh6Dr9tPOk7zpmwyPI
         PM+jRswxWEOLJBtcHmnIq4CELrQtJHQD+Jlz1hF3qyuB3lLepkinysqwpeYhsgdY15sk
         +DrRtwk1FtvepfuSASiLaknlwPVUDinKUGffpNUzIDB3LYuKiRad3wK+D/wlT3zmOG0D
         un8F14KZbryUf5yYTRC+hFADdj1LFknuJPJTpKdt/Fn7Fq4WUZ008EDSg+wdHpEg3XET
         Ummg==
X-Gm-Message-State: AO0yUKWlI2spL156Ow6mVo5Vu3Y82paeinMmKlJMrfeqdRUTs3ntUKwq
        DQ7hVndCb/HInBcpwo6Y8VJiKQ==
X-Google-Smtp-Source: AK7set8smGMl8U9nMCJ3GwkZbTsYCWJDbk3rI8HmACPZpKWp77dqK8lAMva6k047wkQUMjhCNoDWRg==
X-Received: by 2002:a05:6a20:2a29:b0:db:9131:dd7c with SMTP id e41-20020a056a202a2900b000db9131dd7cmr12890996pzh.39.1679995719309;
        Tue, 28 Mar 2023 02:28:39 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:449a:10df:e7c1:9bdd:74f0])
        by smtp.gmail.com with ESMTPSA id a24-20020aa78658000000b005a8bc11d259sm21261518pfo.141.2023.03.28.02.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 02:28:39 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v3 3/9] dt-bindings: qcom-qce: Fix compatibles combinations for SM8150 and IPQ4019 SoCs
Date:   Tue, 28 Mar 2023 14:58:09 +0530
Message-Id: <20230328092815.292665-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230328092815.292665-1-bhupesh.sharma@linaro.org>
References: <20230328092815.292665-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the compatible list available in 'qce' dt-bindings does not
support SM8150 and IPQ4019 SoCs directly, leading to following
'dtbs_check' error:

 arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-griffin.dtb:
  crypto@1dfa000: compatible: 'oneOf' conditional failed, one must be fixed:
	['qcom,sm8150-qce', 'qcom,qce'] is too long
	['qcom,sm8150-qce', 'qcom,qce'] is too short

Fix the same.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
index e375bd981300..90ddf98a6df9 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -24,6 +24,12 @@ properties:
         deprecated: true
         description: Kept only for ABI backward compatibility
 
+      - items:
+          - enum:
+              - qcom,ipq4019-qce
+              - qcom,sm8150-qce
+          - const: qcom,qce
+
       - items:
           - enum:
               - qcom,ipq6018-qce
-- 
2.38.1

