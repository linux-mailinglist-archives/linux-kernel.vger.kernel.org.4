Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045F564C2E4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 04:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbiLNDr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 22:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbiLNDr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 22:47:57 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33920101D9;
        Tue, 13 Dec 2022 19:47:57 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id s196so1194567pgs.3;
        Tue, 13 Dec 2022 19:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiIUzn2EddNcRpM3N08+Qqa+e8XOkPQxsi5T8BK8zVw=;
        b=Z20/VECNGDJ+fdiwSWlYkmV00xGED3fXWdN6MmZulRGw7TFyaaM1cWxa7QBg+2bB10
         uJNCRR37WRAL1o552kCDQ4tUA+dHUkCqLBxHhRmQGl5/jGElwAKCaMPoMpoRWbLRAgHy
         n/3ChyCo/ez44S1ETrwlCdLg27O30JW64jPaGsJzJmbBDNJlVj1eBQdHDg9sSwLRpDq/
         FFqDr/zVI6MXEqNJiHWpDE9FXtHv8V8KDwFkLfNss/K18o/qicnq+Qkmv9jSUbElV2rk
         7Ll9dnfpHO3boO+KkehaNhpSOfREDuD0bq6EWTBbt1Y6le1WKftCHuVykHLuJdYRN282
         kZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiIUzn2EddNcRpM3N08+Qqa+e8XOkPQxsi5T8BK8zVw=;
        b=zoSU1fduq5FIodBW69eZgFIgPC0aUNqYM3dsHqXxYUclbIS8BPATfnMoJKI+uNLO7H
         bj3IWaYa+nXuf/A635Hp1ezuBQXn4JTBFwa6XD+CkrjKQE3viE7tmVrxHHhNCEq0npYs
         J8FdMGz/kSlQCPF/iRi7kTlBr5AcG2npvgx01I8tJeX2ztkOGUImPhV8F1L0PCsR+q4o
         V3+JaQnt7F5eH3wknzBjg+c/WolzJaKMnITeFxb+TEzPSdWhOxl6LW3jkShyrdEaUH9g
         M94iuKM5SGHcTFtZPNrH2gybosBkKpuC4SNr7oLeP0pHLysm4EvMKdk+8j638s8/hVLh
         DGXA==
X-Gm-Message-State: ANoB5pkupJC1BV0iuwLaMpWuQzlDoYbiLC0xQUmvswSlnQnDlBOPIORo
        VS18jsg7UIcwzwbuOEkZtLHQWDugrvM=
X-Google-Smtp-Source: AA0mqf6H2OBSBAxYI4WkZp03aw/T1TXpTZDT4oH8lB5YG7yctBHqLKsgGFZ1JT1R8EkRrKw6QC+I8w==
X-Received: by 2002:a62:de04:0:b0:577:3885:9d43 with SMTP id h4-20020a62de04000000b0057738859d43mr23280525pfg.18.1670989676318;
        Tue, 13 Dec 2022 19:47:56 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e28b-7065-982a-58d7-b612-9bf3.emome-ip6.hinet.net. [2001:b400:e28b:7065:982a:58d7:b612:9bf3])
        by smtp.gmail.com with ESMTPSA id o24-20020aa79798000000b005745eb7eccasm8319817pfp.112.2022.12.13.19.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 19:47:55 -0800 (PST)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Matthias Kaehlcke <mka@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Bob Moragues <moragues@google.com>,
        Gavin Lee <gavin.lee@ecs.com.tw>, Harvey <hunge@google.com>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: qcom: Add zombie with NVMe
Date:   Wed, 14 Dec 2022 11:47:48 +0800
Message-Id: <20221214114706.1.Ie4ca64ad56748de5aacd36237d42c80dd003c1a9@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries in the device tree binding for sc7280-zombie with NVMe.

Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
---

 Documentation/devicetree/bindings/arm/qcom.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 27063a045bd0..0f8fabcae907 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -679,6 +679,18 @@ properties:
           - const: google,zombie-sku512
           - const: qcom,sc7280
 
+      - description: Google Zombie with NVMe (newest rev)
+        items:
+          - const: google,zombie-sku2
+          - const: google,zombie-sku3
+          - const: google,zombie-sku515
+          - const: qcom,sc7280
+
+      - description: Google Zombie with LTE and NVMe (newest rev)
+        items:
+          - const: google,zombie-sku514
+          - const: qcom,sc7280
+
       - items:
           - enum:
               - lenovo,flex-5g
-- 
2.17.1

