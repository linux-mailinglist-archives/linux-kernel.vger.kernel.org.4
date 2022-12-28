Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5EE657415
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 09:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiL1ImB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 03:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbiL1IlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 03:41:20 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F71FFD09
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 00:41:14 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id b145so6226374pfb.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 00:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USFa3vv6r3M6at72+GYbrAEuQqTIcmw3cLL2W4/Vhuk=;
        b=kpqldBi40qr6VGpY4wIciIgIpry8ox+hTxyKAge6AX9QRyA7AAeM4uKrICN21Ek/NB
         EpxfHZd78zqiNNERABmX4jaGzGGQ3MF5KetlMnqlzpTbjNLQfRY2pLM0ogMMpk7wVcPZ
         LNxJqGsWgDQ1Y5HGeHze/TDe3rHfLFzktxduIOkD2lRHt/ZDbac6fnNLgrVlFiUaAym0
         rkxiezXfc4OFwPt2q3iCSm95FVv9djSK0FbhNuW4AcFmIAV622ibpB+M1XIDCT6zprKK
         mMv09WZP2jedMbEOgDzL/xdVBeSbC+NGXqpoGWvhDXqkawAd2bN63Kr9Om77SCFRiXVQ
         NZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USFa3vv6r3M6at72+GYbrAEuQqTIcmw3cLL2W4/Vhuk=;
        b=jBoQ+4j+gN6dt4Qm0pcgkP2DOLQovL9uaBIzO/2KUZaeTgOEblCjZPLX8Ji97pzCW1
         yCxQHRFcY4rB156FSHPfT6xAuw0w2ZaDQ+12BLsaIO1Dt+nbYTKyDxraF3PHnQ7ePCJG
         MV+LLiRnqPSbLnt9v3I9pjly0phTjsH2zOKxH6efF7JTPM9cAGxoztlBniC7x/1DhErW
         VAAB+A07Qea4YQ+EEy1hp0sLIQ1JVFN2/kEranwEJ7MuNvSEC1Al4gfuuVMs0lFMWZHq
         a2UeMQndkqrAaORpslsMutVEQ5n/2DGoB3qRXRaUn1gbGFPl0eqoBUN51PjR4XPlltLu
         R9Fg==
X-Gm-Message-State: AFqh2krB8k7HNIWO0v7dpZEJUvbzSbo1D2TKHUA/1XTYSfMEZxdfsXIa
        DubjkNeoI5B6jn2/fNCgh/C2
X-Google-Smtp-Source: AMrXdXttzAeX7SG+Jw9+MV91sz3bAxNDR5fgdUGZ8cafi5MRu6SswAWEpMziT8o2hrU+n9jRVEWSrw==
X-Received: by 2002:a05:6a00:1885:b0:580:9a80:6e37 with SMTP id x5-20020a056a00188500b005809a806e37mr25225588pfh.25.1672216873572;
        Wed, 28 Dec 2022 00:41:13 -0800 (PST)
Received: from localhost.localdomain ([117.217.178.73])
        by smtp.gmail.com with ESMTPSA id d188-20020a6236c5000000b0057a9b146592sm9786286pfa.186.2022.12.28.00.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 00:41:12 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 04/17] dt-bindings: arm: msm: Update the maintainers for LLCC
Date:   Wed, 28 Dec 2022 14:10:15 +0530
Message-Id: <20221228084028.46528-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
References: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
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

Rishabh Bhatnagar has left Qualcomm, and there is no evidence of him
maintaining with a new identity. So his entry needs to be removed.

Also, Sai Prakash Ranjan's email address should be updated to use
quicinc domain.

Cc: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Acked-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
index 38efcad56dbd..d1df49ffcc1b 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
@@ -7,8 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Last Level Cache Controller
 
 maintainers:
-  - Rishabh Bhatnagar <rishabhb@codeaurora.org>
-  - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
+  - Sai Prakash Ranjan <quic_saipraka@quicinc.com>
 
 description: |
   LLCC (Last Level Cache Controller) provides last level of cache memory in SoC,
-- 
2.25.1

