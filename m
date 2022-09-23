Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443E25E7621
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiIWIrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiIWIr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:47:29 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023E9123D89;
        Fri, 23 Sep 2022 01:47:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q35-20020a17090a752600b002038d8a68fbso5122850pjk.0;
        Fri, 23 Sep 2022 01:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=H4sBQJbOmLAwSIZHr6g3xEa+1ZYKdNzIBMUVl6Xhy5w=;
        b=DSq3xxSDiaudkX1/yfrb2j/brgc18aCXSpCfkrWySuXtOVP6BU6I7T2HodojJxg505
         lIxYoJV44i7nGwZ3M8YtRAvYguz3bzwdO2rXltAIcc+yHnIWbhhE1pLDFa7k68CkB2IF
         /7r/K3aP27eIZZgR0cChoeiIbEga5S0no22OTC8ctA/k8pC/taKuFHvm6J4X//5/nPUW
         tA4tUJbDcSk3FHshK2HHD9O3a6Rx9FshfdG/H53Rx3fNsRqLsAG2bHrzzHmTCdwkYj+3
         9l0LhGF5XJr0WvjObXix2MyZxOfVkPAVIOFNuOAqiX1j5RQkr5W25A2T0tatKfIH/kit
         863w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=H4sBQJbOmLAwSIZHr6g3xEa+1ZYKdNzIBMUVl6Xhy5w=;
        b=KG1G1QrI3Nj+8NCG4UWajjYm+Pu09yqmO5yTlCWq6buJKdq2WA5e8r8X036P5d5Pkg
         olaf47Z7dlRE04aJhwRv5kjQ1SdBnGQeqQwCr0W0DhgFiJpIblVqbh7H2xiPXWTjAGp7
         fch7cgpSS0R+KTs7ucUK+rV6A2nPqynBNLCMOC/CK5Ja1rinj2fYZoJSh5BleN+qLla9
         rlNHFEoKZWQ1OjlmtNpq9fkYawrMMLveCyVLbBEyaVHAkV0iRVWYKAWOefnaANyP9PXD
         FJPRNk4/U9aNTyUitopITaZ/f/l9J2glH/2uIO9Q8pYjZtVFWqqyaOOtnAZgYEEO+oP/
         4Vxg==
X-Gm-Message-State: ACrzQf2hvLkiodo/bbe5WtGyWVLpCTBJ+BO1/aZvsF7WS4Vncu91zL8V
        bVdTuIL5/ZOgGy0aZ2wNu5zOCbgSr5U=
X-Google-Smtp-Source: AMsMyM6BIvZYHj3bCGb3QK3JiJUnV3HFP/p5IYVFj0WhtxmgZ2h75kT7SflZZDncFi67XQF6dCWTrQ==
X-Received: by 2002:a17:90b:4c0b:b0:203:6d81:bb53 with SMTP id na11-20020a17090b4c0b00b002036d81bb53mr19835252pjb.3.1663922848077;
        Fri, 23 Sep 2022 01:47:28 -0700 (PDT)
Received: from localhost.localdomain ([103.150.184.130])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090276c600b001789b724712sm5364986plt.232.2022.09.23.01.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 01:47:27 -0700 (PDT)
From:   Yunlong Jia <ecs.beijing2022@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Henry Sun <henrysun@google.com>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Bob Moragues <moragues@chromium.org>,
        Yunlong Jia <ecs.beijing2022@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 1/3] dt-bindings: arm: qcom: Document additional skus for  sc7180 pazquel360
Date:   Fri, 23 Sep 2022 08:47:16 +0000
Message-Id: <20220923083657.v5.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pazquel360 is an extension project based on pazquel.
We create 3 sku on pazquel360:
   sku 20 for LTE with physical SIM _and_ eSIM and WiFi
   sku 21 for WiFi only
   sku 22 for LTE with only a physical SIM
 Both sku20 and sku22 are LTE SKUs.
 One has the eSIM stuffed and one doesn't.
 There is a single shared device tree for the two.

Signed-off-by: Yunlong Jia <ecs.beijing2022@gmail.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

(no changes since v4)

Changes in v4:
 1. Adjust the 'Signed-off-by'.

Changes in v3:
 1. Adjust the format of the changelog.

 Documentation/devicetree/bindings/arm/qcom.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index b6257683a700..ca4d8ac33353 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -463,6 +463,17 @@ properties:
           - const: google,pazquel-sku2
           - const: qcom,sc7180
 
+      - description: Google Pazquel360 with LTE (newest rev)
+        items:
+          - const: google,pazquel-sku22
+          - const: google,pazquel-sku20
+          - const: qcom,sc7180
+
+      - description: Google Pazquel360 with WiFi (newest rev)
+        items:
+          - const: google,pazquel-sku21
+          - const: qcom,sc7180
+
       - description: Sharp Dynabook Chromebook C1 (rev1)
         items:
           - const: google,pompom-rev1
-- 
2.17.1

