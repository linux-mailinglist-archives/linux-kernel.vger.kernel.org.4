Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2894D638678
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiKYJop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKYJof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:44:35 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E8010FE6;
        Fri, 25 Nov 2022 01:44:33 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id f3so3538627pgc.2;
        Fri, 25 Nov 2022 01:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gn2sizkMrneWFfSzYUQB5soJBl7mIdJiiFc0egNz5Zs=;
        b=FhV17ZsZLAtH0WoI9gUlfg39GlVV8kW/K/UcVr+ZnKAnb1rUoguEPB/PoaeBbXR7Ml
         akewAfX6EeABiQZ1XEs0R1j/W0K7VZmEwIuHFPcO+07FjZrCXgGwyCXziBHrpY6Si1Zd
         0o+x1PuMcet0yy5GR2bDsL2oud4u/6tt3XV0kt7B09epr00tG4dbxEQDRmql1M6CY0+3
         5jwPD8x+Me5ZVayoXaZ6qZC22pHpC0iL1rH06ePV7nE/+AjJ6VQHIg6FRpfo5YwU+DpE
         IIM37JrUODJBhl74rIqIDBrP4hS3hfsJsaogES9kdWyeMW2ypjQoTxEYqlszo5J4HsC2
         r7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gn2sizkMrneWFfSzYUQB5soJBl7mIdJiiFc0egNz5Zs=;
        b=OEd6W7gs9tBakFB7dtF+EFNO1immbh37VYpL4ulHTlWfhTVlYANa5LCU/Ydo6HATb4
         p/pp4bJtHkBZfovGwjRvuKTEbHoukWcW0LHPOXhSisc2xMczNQTcKk9raaKG3QyD9g9s
         rBFm3IXFUjn/BhM98Ub+57FDK1wSY2Ered2FLh9c0lr84mZfUzHugBDFsJqHF73VFSl5
         ebxHaQcvuRNygrGPbTZsuJpTS5MTkv+Y5//VcbCYFJkE7m6PsqcguO89vT6vc4MrCpJB
         PFPI3sd8JT7Gi3W6JbilsfDcZjk2HfzgnV2G8MFi6BUDvflji+kIpeOa3BTROKADMjaT
         LvwA==
X-Gm-Message-State: ANoB5pl8l95MOmaYHddZBNACOCsPeruTfqYeJX+9WdtHRytFW4NziErk
        KDxctFhwiOvSMM95SYJMaSXmrdPGHuQ=
X-Google-Smtp-Source: AA0mqf4k6YNZxmULP3LyNodlGildtzieohyx6hSjvZTtEiwXCo6/Nu/MwyMHKHxAhHaqfWiMJdnA6w==
X-Received: by 2002:a63:f816:0:b0:477:c1a6:32bc with SMTP id n22-20020a63f816000000b00477c1a632bcmr8937643pgh.87.1669369473075;
        Fri, 25 Nov 2022 01:44:33 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2d2-0afd-e841-8cc0-6431-915a.emome-ip6.hinet.net. [2001:b400:e2d2:afd:e841:8cc0:6431:915a])
        by smtp.gmail.com with ESMTPSA id z14-20020a170903018e00b00186a2dd3ffdsm2963923plg.15.2022.11.25.01.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 01:44:32 -0800 (PST)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Abner Yen <abner.yen@ecs.corp-partner.google.com>,
        Gavin Lee <gavin.lee@ecs.corp-partner.google.com>,
        Harvey <hunge@google.com>, Matthias Kaehlcke <mka@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Bob Moragues <moragues@google.com>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: arm: qcom: Add zombie
Date:   Fri, 25 Nov 2022 17:44:24 +0800
Message-Id: <20221125174415.v5.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
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

Add an entry in the device tree binding for sc7280-zombie.

Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
---

(no changes since v1)

 Documentation/devicetree/bindings/arm/qcom.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1b5ac6b02bc5..46ec61e3dec3 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -595,6 +595,16 @@ properties:
           - const: google,villager-sku512
           - const: qcom,sc7280
 
+      - description: Google Zombie (newest rev)
+        items:
+          - const: google,zombie
+          - const: qcom,sc7280
+
+      - description: Google Zombie with LTE (newest rev)
+        items:
+          - const: google,zombie-sku512
+          - const: qcom,sc7280
+
       - items:
           - enum:
               - lenovo,flex-5g
-- 
2.17.1

