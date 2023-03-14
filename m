Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587316B8A25
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 06:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCNFOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 01:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCNFOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 01:14:14 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F73872012
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 22:14:13 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id y2so14243621pjg.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 22:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678770852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=biu99pOIpHkrxRrUfbbTOFQqLHYffJjiCgW3KZFEeME=;
        b=rJ/PGmhmBYdQl95T44CdTly9zsIUXu0LWLvp80M2jBhAIGHZInB/+9LwZC5+u5D+uO
         UyQiNoloYqPgAzTuqTFkUR+t++LcLYJS5w+fJYtAMNyIUxt5fCBX3R/brS10ceRUZ+QX
         qEUM6QKTHGqeS3YVdRCMFLdS1uMMuQUzCzexaoKVDUZ8pfnd+7YzrAQSyeLEEy3pOHYi
         YMw1RFeIqpdCCJuT6AUaJ7HC+Dn9q3D36j2l2dz2O8CWb5xmDA2Nly4K9U6beGVbMN0i
         MqpNGHT1/LJ0WmXvw/WmiZWXqhOobyq9/xobp/Zn/+NAe6X9Q0Fm7wUAtXCQ301/t7KS
         CKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678770852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=biu99pOIpHkrxRrUfbbTOFQqLHYffJjiCgW3KZFEeME=;
        b=PWeiQcJ1tRT0w0a6NqUW9UeVqFBylwC5XcmY9proASqx9MEECRcu7XujOnwq9ib6KL
         C5OJpFUJQWtvo/kGxE0HpOqhkdKVq0MMuUxvdaIKpdXr/4JHAdE2wsLmau+oiYZV3oeP
         dR6Zp5jNy3GLKvzKwQNQ1sopP7Q2EpP9U3y+AL83wrOyNh19rXeuWK5YmeGrwkVMFIua
         JPekWpYC8fS1zW0g8XHup3OqY51XL3JMd4Hlbk/Ug3F4X3GkeepSg/Fp71tZPC5agPfQ
         I8oGovznbujLYBGPPQ4hzP6ZuaUTRhJ2ctK6zEnguoDoLk+RMaOT7Km4tbzamu8dpccI
         9R+A==
X-Gm-Message-State: AO0yUKWkQF08OquVxhwNb6GXkBt1K4R4OKiR9LCBcW94q00+odpjevgp
        1lIQxpMbnd7dmx9sxA0JnPTelQ==
X-Google-Smtp-Source: AK7set/7476nZ440mA6EG3nky8n8gyy/ecPL0HpSYIAJHbexzwyUi8sMNEqYPpJvq+mTWNXrGkybzQ==
X-Received: by 2002:a05:6a20:a021:b0:d0:212d:ead0 with SMTP id p33-20020a056a20a02100b000d0212dead0mr10357208pzj.26.1678770852552;
        Mon, 13 Mar 2023 22:14:12 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c5e:4a3e:15d0:d540:3861:ef0e])
        by smtp.gmail.com with ESMTPSA id z13-20020aa785cd000000b005a852875590sm580533pfn.113.2023.03.13.22.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 22:14:12 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Cc:     konrad.dybcio@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net, agross@kernel.org, andersson@kernel.org,
        saiprakash.ranjan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: watchdog: Document Qualcomm SM6115 watchdog
Date:   Tue, 14 Mar 2023 10:43:51 +0530
Message-Id: <20230314051351.1754321-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
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

Add devicetree binding for watchdog present on Qualcomm
SM6115 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
Changes since v1:
~ v1 can be seen here - https://lore.kernel.org/linux-arm-msm/20230119122619.1020908-1-bhupesh.sharma@linaro.org/
~ v2 collects Ack from Krzysztof and also fixes the subject as per his
  v1 review comments.

 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 6448b633c970..4ba61e1831ec 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -28,6 +28,7 @@ properties:
               - qcom,apss-wdt-sdm845
               - qcom,apss-wdt-sdx55
               - qcom,apss-wdt-sdx65
+              - qcom,apss-wdt-sm6115
               - qcom,apss-wdt-sm6350
               - qcom,apss-wdt-sm8150
               - qcom,apss-wdt-sm8250
-- 
2.38.1

