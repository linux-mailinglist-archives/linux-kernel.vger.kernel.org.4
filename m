Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC17712C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbjEZSHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbjEZSHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:07:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DAB119;
        Fri, 26 May 2023 11:07:42 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96f99222e80so235589666b.1;
        Fri, 26 May 2023 11:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685124461; x=1687716461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1w9YqBJg1t/GBfhAmcVQVw/GD/zxil33PlKHiL+BD8=;
        b=NWO9GNc9Lrd8OS2zFQjDYuDJLesvnWm84bKgQQWmK84p1IjfaTXwRJ+pKpOX460Pc7
         YZOzNad00zNfy1DQD/8qaXPZXHTLVWmgqI1rXvqC5MsrUXO9LGQbo83cKST4c6a4A5xY
         O0UoT9EIH/tNs8Fl5h83Lm0zgCxQ0ODNmN3C8VKNbFokx+zwstQuaLRyK8hEk7xAIS/Y
         Z7BUilQoHZhAUseuK3RX40PrVo04KtDeZ6GRJpuYDJhcE3KEpJUQgARNj6sh8Cj5rTKT
         joGT1alhPRLu7BtLJM9weS1ZxLpfgYgYookLKhlCbPt29jxU7+tMPLzQCyihZhZFOG4c
         G35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685124461; x=1687716461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1w9YqBJg1t/GBfhAmcVQVw/GD/zxil33PlKHiL+BD8=;
        b=l/EPJ9RCpha77cNrg1hZd1pPF/9knY5P9gbyvCzpRrdxy/NGHckWUFZ1uWTSwv7F68
         0ZBE6l1Rq8FOiYpWh5+UcVcIYakdt9GbsZGMvh0AZigJwK5chxrUR5zEI04x+r5atY2z
         n85vg9xXHfrRUsHUST4oiretQU/d4mwNP21zTWPpdGos8ksCD7j7CF1psRoB6+tGbSI+
         iwgG2j8h1WhtZKSUFWwowhv9L3aH//Eez96K7ezTGDrZIQOxG3H2XPJZ3HG+divDngRU
         s/bfgqK73jI8I7/3+HNESvC1W7/VoFt7A5FqTaw8Tm0Cnl+FuXAjs8s2ueQAZzCVeFqw
         7vXg==
X-Gm-Message-State: AC+VfDxWSBv2j/23fXgsXNFT0GsgFT2hpNL8RDCVQ1YMkNUg72Qeqais
        BOgrES1hP3E9qJRoRGuQ+gQ=
X-Google-Smtp-Source: ACHHUZ6Hk7WskaLwKIR7814tj+kIfFg8Vgfj/ZziyvThXiVd4E8bhyQuysm255moYJBB0Dn5vX2BVA==
X-Received: by 2002:a17:907:da6:b0:96f:8afc:b310 with SMTP id go38-20020a1709070da600b0096f8afcb310mr2703876ejc.3.1685124460508;
        Fri, 26 May 2023 11:07:40 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906410b00b0096f689848desm2410823ejk.195.2023.05.26.11.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 11:07:40 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: media: camss: qcom,msm8996-camss: Add CAMSS power domain
Date:   Fri, 26 May 2023 21:07:10 +0300
Message-Id: <20230526180712.8481-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526180712.8481-1-y.oudjana@protonmail.com>
References: <20230526180712.8481-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add the CAMSS power domain which is needed for the proper operation of
CAMSS, and add power-domain-names to ease fetching it as well as the other
power domains.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../bindings/media/qcom,msm8996-camss.yaml          | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml b/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
index 8a10aa1cafc5..27c9a11f0df9 100644
--- a/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
@@ -85,6 +85,13 @@ properties:
     items:
       - description: VFE0 GDSC - Video Front End, Global Distributed Switch Controller.
       - description: VFE1 GDSC - Video Front End, Global Distributed Switch Controller.
+      - description: CAMSS GDSC - Camera Subsystem, Global Distributed Switch Controller.
+
+  power-domain-names:
+    items:
+      - const: vfe0
+      - const: vfe1
+      - const: camss
 
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
@@ -209,6 +216,7 @@ required:
   - interrupts
   - iommus
   - power-domains
+  - power-domain-names
   - reg
   - reg-names
   - vdda-supply
@@ -326,7 +334,10 @@ examples:
          <&vfe_smmu 3>;
 
       power-domains = <&mmcc VFE0_GDSC>,
-        <&mmcc VFE1_GDSC>;
+        <&mmcc VFE1_GDSC>,
+        <&mmcc CAMSS_GDSC>;
+
+      power-domain-names = "vfe0", "vfe1", "camss";
 
       reg = <0x00a34000 0x1000>,
         <0x00a00030 0x4>,
-- 
2.40.1

