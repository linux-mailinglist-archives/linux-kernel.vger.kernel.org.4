Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC88D5B46BD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 16:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiIJOcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 10:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiIJOcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 10:32:24 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACAA3F1C0;
        Sat, 10 Sep 2022 07:32:22 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so7065910wmk.3;
        Sat, 10 Sep 2022 07:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=EneIXY/B5LBT5BBbtyztaHF9mjVl7aiyd+xPwT0PgL0=;
        b=YxkJN1KztGkCir4zCR9DpON6tjppUXTo83/S4W1M+hgd6rBHAbU+/3dyadpRwNSbkp
         5NUrEhvPAcp5hWXDKx+g+STrWre34p2OY+8QarZSsuMFqOy71TNJbhTpgVoutjZmqZQR
         x8QWqBMO0eMH01k63x/uKXsq9oSb8gwxtmcUJ+mvK7oAteQ6I+ziQH4o59eaMqWzN/0g
         VOulgjNxNwtol3qFCOmv40A7M3qcSo1hTOl4uHPl3S0UzwEkvF7RpMRiRo36y1lFlaW2
         /y+5qiw48JvnNceppbWKKPZcdHkDHQ6w6/Fct47W5KNaT5+m2rb1Sv7t6uAIutZEvH/Z
         1wFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EneIXY/B5LBT5BBbtyztaHF9mjVl7aiyd+xPwT0PgL0=;
        b=prhcZXQsXB/mJPriP+ZZtUINGi64RnOpRHzSTa7KuYzhwBurHU0pcqgUBdBl4rpydD
         tcEablexeZwQ4d9YcP4qjaThhg/MigmTLRf0FAnPETupjD8cj9jOTaiQx5qLLrq+St6P
         vjUJ7pjaDfjQecv+Vry0QT9cmgk4lMOQmY7GLtXMKezQaJW+kuHy7goJAzu1eWooVdy4
         SIHQ5KNIEsHVy2ES693aQ9XeJyMBOR7fX9Q8rj6o/KxycFL8DyhQxXuHACgoPQXgiCI2
         jw8kfADjYOp7eJzaQ8g+pKNkiAz4SKcZu9Rq8AIhI57SytgBp4rYDLchLkJNhyjmo1sZ
         IqAQ==
X-Gm-Message-State: ACgBeo3xnxu5UcDtlcTRtif7vPf/iztLBYawoqitlviIkpM0DTcWl7Rf
        quHiE3j2NGFaOjzE7U645kg=
X-Google-Smtp-Source: AA6agR6FptnQU7TepK9E8qa/NAxIBA1fiR1Px3U3q7yEkMKOHZy+/eXvTspoHH7b+on/dmhvyZjH1g==
X-Received: by 2002:a05:600c:4e92:b0:3a5:fd90:24e3 with SMTP id f18-20020a05600c4e9200b003a5fd9024e3mr8795831wmq.59.1662820340712;
        Sat, 10 Sep 2022 07:32:20 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c430300b003a5dbdea6a8sm4354253wme.27.2022.09.10.07.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 07:32:20 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Caleb Connolly <caleb@connolly.tech>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/9] dt-bindings: arm: qcom: Add compatible for oneplus,billie2 phone
Date:   Sat, 10 Sep 2022 17:32:07 +0300
Message-Id: <20220910143213.477261-4-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220910143213.477261-1-iskren.chernev@gmail.com>
References: <20220910143213.477261-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oneplus,billie2 (OnePlus Nord N100) is based on QualComm Snapdragon
SM4250 SoC.

Add support for the same in dt-bindings.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Caleb Connolly <caleb@connolly.tech>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 9cd798810eff..377bfb21cbc8 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -54,6 +54,8 @@ description: |
         sdm845
         sdx55
         sdx65
+        sm4250
+        sm6115
         sm6125
         sm6350
         sm7225
@@ -680,6 +682,11 @@ properties:
               - xiaomi,polaris
           - const: qcom,sdm845
 
+      - items:
+          - enum:
+              - oneplus,billie2
+          - const: qcom,sm4250
+
       - items:
           - enum:
               - sony,pdx201
-- 
2.37.2

