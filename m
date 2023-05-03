Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DEF6F516E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjECH2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjECH1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:27:54 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C6B4C08;
        Wed,  3 May 2023 00:27:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bc3a2d333so5698596a12.0;
        Wed, 03 May 2023 00:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683098846; x=1685690846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ypdkqPJjbiclAH5MyIicuceDqAshp12bpImWLmn/d8=;
        b=jQtVuZXOwV0WGZ/MPDTF/me9uREk3t2/WE9ZiVZAbgcw/aA/He1E273lKAaxmd3oBS
         q9hCC9qWrW3FGtK6fOiJ+vbKof5vzX/g6Y/OHLVXD4RAfOgKsKcweda2w5tFOO/MgGsc
         3ufy5EGnbYTNbh1GHEUWxzuCLV1Y4gYbN6cJUqwi1rY+MqL4Hc60/8inuV0PnWFxlaOw
         h5hYhateHNi+K2gDpB4CYcfgDFf/ZUAvT9aTIiwZalNx5hW1EveN2aXb/IGXi5eT2gPR
         MeAiRtyui7iM1Sw/3PESawMo+ZEN5b889WQCGNQhFKyeqyFiNxpyjq+hP4yEVhricPzJ
         bDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683098846; x=1685690846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ypdkqPJjbiclAH5MyIicuceDqAshp12bpImWLmn/d8=;
        b=Q5JAv9VYym95YxVvlEyGeKxMawqt9sTYI1BvmEdJNSlm9maOnIHnp9dpE/zWe4x4jM
         NjV1HffWzI+t+MCFUBHa0uBE9EI7Z3sg27jb23OHl+CLIAN0HtZptMdMuWV6/hzrRh0L
         dUwO+L2W4ZzJUKHQAT/moXaD9mIbPpNWpJtYVYIzDcJidZnJCDhPx7r+umc5AscRSRvY
         XjALBBR4Z7a2N0ruGiFgaXnM2QEBdrYjoW9RTrvWgPvo6NTCX3AmviptB4v6GaHiWlcJ
         oruCcAOG7aJHi9wmHbRuUijxbtLx2t4rElra4A/T2msaeBV55fDYuDCj/4HVl+AxxTT/
         FjBA==
X-Gm-Message-State: AC+VfDxWKRZ5xYjs0Y90gX0UKt1XAohL+KIS2oQy0e9tY+FDBM6TeRxT
        MkwaSIA06HgY9n8d5t3K9axs2uC9m2g=
X-Google-Smtp-Source: ACHHUZ6S9G4G72KhP8axul/9Aabc8aOFuEwWkD36wsvdZJYE5znLW7acElVOyPgqmhDAkSceTVsnUw==
X-Received: by 2002:a17:907:8a24:b0:933:3a22:8513 with SMTP id sc36-20020a1709078a2400b009333a228513mr2877794ejc.53.1683098846189;
        Wed, 03 May 2023 00:27:26 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id t26-20020a1709064f1a00b0094f34fe27c6sm17072009eju.170.2023.05.03.00.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 00:27:25 -0700 (PDT)
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
Subject: [PATCH 1/3] media: dt-bindings: media: camss: qcom,msm8996-camss: Add CAMSS power domain and power-domain-names
Date:   Wed,  3 May 2023 10:25:41 +0300
Message-Id: <20230503072543.4837-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503072543.4837-1-y.oudjana@protonmail.com>
References: <20230503072543.4837-1-y.oudjana@protonmail.com>
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

Add the CAMSS power domain which is needed for the proper operation of CAMSS, and add
power-domain-names to ease fetching it as well as the other power domains.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
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
2.40.0

