Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0C05E9D81
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbiIZJZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiIZJXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:23:01 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB0441D07
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:21:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a8so9801561lff.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=CHOK16bLC1OmHgxdWesWd738hxrAnoj1iE3o+cwHJlo=;
        b=ObPcSsUenrEfXG2REoHMrhp/ILCtZuuRRSbGWJVV0IEXrSo5xfW9WMZi+1UZSZRq0P
         AE4Xq/tHF1AndKe2QqaPEj0/U/b29/UXm840nOBYmqykiEICdlaChQq2KqdFy9aD4B4Q
         K05HcJLWWqva6Q2z4XQS6H4AfOFJGN0k/9tTcabffovUnFZZwPLb6p9bEva7xRqQuaca
         Af7S9DGxB8GUQG2zYY/4QYl/IS9EYjXs9vWRbg9MALy4Th+KKWDaPZaLmPXq5HfLui6A
         P19AjqaC0KEKcbJU6/GqN+tDIphRJfS80T6dpEu11f8muHgnTyjZ1Xy6tbpTUjTEj0zy
         RhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CHOK16bLC1OmHgxdWesWd738hxrAnoj1iE3o+cwHJlo=;
        b=OGklCUC7KcUgeWx+ZZEAEBmn4ILxmHHQoNRjuTWPisSdMI594X5UXL7J/iepVVEtXl
         n+T2XfG/GwyD1aBlBY/j/GdK618qij8Do+HMco4PWQ790IcfDBnN6SQr7p+EHWd429lz
         tgBBFCO3fk2+ZrzXg2FhPaDyv1CMN1qJGUOYnTCMWK/EdOujf2a3aZkuoT7Z9tFhLAFx
         EeajnZrGtlwYaOnZciaPoJe/6/WB+U44ynVaM3fVYymD6r73odhBZVhzqUiCv694t+Zf
         pj4iAJjyZ/Eic86tWxC4kwHkAhImOMbEPlc38OLZ1IwDHs0sA4eKH/vGyvKmbmNq013N
         Oc+w==
X-Gm-Message-State: ACrzQf3LPmxdW7kVrTGwjyyDMiHr1YjdNKPT4ZNwB926K1UrbYeUV6ik
        Gu1xKqOG/NzSOUU2HBMIpS54pQ==
X-Google-Smtp-Source: AMsMyM7YuJ/cOxWerqwhaEWit/fqS7hWmG9Ey78TLsqAVHJ/06SDdsyp/SJMSZYTKqLDKIBpWAwjfg==
X-Received: by 2002:a05:6512:3084:b0:49e:2275:fbb8 with SMTP id z4-20020a056512308400b0049e2275fbb8mr8082844lfd.40.1664184073590;
        Mon, 26 Sep 2022 02:21:13 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g8-20020a2ea4a8000000b0026c3ecf9a39sm2325600ljm.38.2022.09.26.02.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 02:21:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v2 2/4] dt-bindings: soc: qcom: smd-rpm: add qcom,glink-channels
Date:   Mon, 26 Sep 2022 11:21:02 +0200
Message-Id: <20220926092104.111449-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926092104.111449-1-krzysztof.kozlowski@linaro.org>
References: <20220926092104.111449-1-krzysztof.kozlowski@linaro.org>
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

The Qualcomm Resource Power Manager (RPM) over SMD bindings contain
compatibles and description for RPM devices on two different
communication channels: SMD and GLINK.  Except the difference in the
parent node, they use different properties for describing name of
channel qcom,smd-channels or qcom,glink-channels.  The first one is
already present but second is missing:

  qcom/sm6125-sony-xperia-seine-pdx201.dtb: rpm-requests: 'qcom,glink-channels' does not match any of the regexes: '^regulators(-[01])?$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>

---

Resend changes:
1. Add ack

Changes since v1:
1. New patch
---
 .../bindings/soc/qcom/qcom,smd-rpm.yaml       | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
index deccc637b6d4..0655f71b0f23 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -4,7 +4,7 @@
 $id: "http://devicetree.org/schemas/soc/qcom/qcom,smd-rpm.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Qualcomm Resource Power Manager (RPM) over SMD
+title: Qualcomm Resource Power Manager (RPM) over SMD/GLINK
 
 description: |
   This driver is used to interface with the Resource Power Manager (RPM) found
@@ -12,9 +12,9 @@ description: |
   to vote for state of the system resources, such as clocks, regulators and bus
   frequencies.
 
-  The SMD information for the RPM edge should be filled out.  See qcom,smd.yaml
-  for the required edge properties.  All SMD related properties will reside
-  within the RPM node itself.
+  The SMD or GLINK information for the RPM edge should be filled out.  See
+  qcom,smd.yaml for the required edge properties.  All SMD/GLINK related
+  properties will reside within the RPM node itself.
 
   The RPM exposes resources to its subnodes.  The rpm_requests node must be
   present and this subnode may contain children that designate regulator
@@ -55,6 +55,12 @@ properties:
   power-controller:
     $ref: /schemas/power/qcom,rpmpd.yaml#
 
+  qcom,glink-channels:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: Channel name used for the RPM communication
+    items:
+      - const: rpm_requests
+
   qcom,smd-channels:
     $ref: /schemas/types.yaml#/definitions/string-array
     description: Channel name used for the RPM communication
@@ -76,8 +82,15 @@ if:
           - qcom,rpm-msm8974
           - qcom,rpm-msm8953
 then:
+  properties:
+    qcom,glink-channels: false
   required:
     - qcom,smd-channels
+else:
+  properties:
+    qcom,smd-channels: false
+  required:
+    - qcom,glink-channels
 
 required:
   - compatible
-- 
2.34.1

