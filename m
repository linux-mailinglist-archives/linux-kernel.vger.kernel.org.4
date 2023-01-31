Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E7A682CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjAaMog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjAaMoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:44:34 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A780B3802E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:44:30 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m7so14080357wru.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=13nzaN0F+f/sYz2TUmotbNZznv3QFhLhfctCZvdaWMw=;
        b=LzQuafCXiUu+/QVLuOx5+U472+tuIKY2ZoqVxBhNSMf1+0nTYu65UV++V4INo1WdLh
         NyWEzpLR4IR7mlrKPrk932zeVkzFbqVtAhFR158sVE2A1F0+Edr9iSmRtaY0BI/+O7CO
         65mVYDvDL1J6UgwfFJx9t4nxWofkcVaxPRzqmEIhkh5nPJM9wRnG26EQVTK0FqhkpLEa
         OoPYssOcwDIVZ/YN9CMgYwmOdcoCqzBoP3N7o/o90MHnphM9p1P7K3nDmAduwpdVsbXA
         aa6Yo40ZhJCs8VfFwWKOKLWbgg7RWcyJUWh3cwCGNSMlBFAmjZVI5310bnPgAfT9rpvu
         cNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=13nzaN0F+f/sYz2TUmotbNZznv3QFhLhfctCZvdaWMw=;
        b=e0Jv5i3l6PgGXCstfsZjOMvB6bC08TUN7hV6h3+WWxb9Pvvuzt6a07fABvx2jHA9jj
         HaAI21Htulv/DbKRdYUbBQH5chncYWROREEADE1rvwxz5+27ZOuc/K1m0PjaKgAbPI6t
         m/BS/Fcq+ioG/wxBOqaag2Uz2mV3O5GIUE/s7lAk1et2y4s2MpvfWV4sw97T2I6gsPvH
         JE7msKW8Z0IKMGBh2mPiPOMn2rfm1nAaNrBLqr/FdYT126vNtywL19WmADV94I6KGqrf
         4y+IZgzrLHjD50xYtTx4C6I9+SnoqBzYvXqicmFx1SQVcJxwCl1NdB56BKwQgRyasH95
         9Wew==
X-Gm-Message-State: AO0yUKV/7B5kVu7WXUDfxV+VGbm9/o3bErEzezRgZEoJmL4H/3Ad4O1Y
        hOYvcgWclBjhY6hNt604d/0IyQ==
X-Google-Smtp-Source: AK7set/j7xPrDGmbtp/qX4EpqTxjiUfqVFmdkLYAZw64K9V04dEjHh+gj+fF7FVSYTC/ycpetwe+pw==
X-Received: by 2002:adf:ba07:0:b0:2bf:ecee:acc6 with SMTP id o7-20020adfba07000000b002bfeceeacc6mr7185523wrg.61.1675169069219;
        Tue, 31 Jan 2023 04:44:29 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d566:ca83:9120:7d5])
        by smtp.gmail.com with ESMTPSA id az19-20020adfe193000000b002bdc3f5945dsm1767262wrb.89.2023.01.31.04.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 04:44:28 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] dt-bindings: arm: qcom: add the sa8775p-ride board
Date:   Tue, 31 Jan 2023 13:44:24 +0100
Message-Id: <20230131124424.167827-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Document the sa8775p SoC and its reference board: sa8775p-ride.

Link: https://lore.kernel.org/linux-arm-msm/20230131124026.167281-1-brgl@bgdev.pl/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 22553637c519..6709e64a4480 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -49,6 +49,7 @@ description: |
         qru1000
         sa8155p
         sa8540p
+        sa8775p
         sc7180
         sc7280
         sc8180x
@@ -89,6 +90,7 @@ description: |
         liquid
         mtp
         qrd
+        ride
         sbc
         x100
 
@@ -805,6 +807,11 @@ properties:
               - qcom,sa8540p-ride
           - const: qcom,sa8540p
 
+      - items:
+          - enum:
+              - qcom,sa8775p-ride
+          - const: qcom,sa8775p
+
       - items:
           - enum:
               - google,cheza
-- 
2.37.2

