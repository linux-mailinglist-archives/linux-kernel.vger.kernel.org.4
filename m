Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805FF6BEA0E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 14:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCQN0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 09:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCQN0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:26:31 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426A020689;
        Fri, 17 Mar 2023 06:26:30 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id z5so5056019ljc.8;
        Fri, 17 Mar 2023 06:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679059588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnovJjydcD88B/V7T4Cq2Usmwr/ZvKcG59naHHxKAo4=;
        b=ERZqWXNGwld4o+URwuztNFRN0kvGEcwaZ8SNLPKcpP7I/t4aJYBq56wKDiRxbDa+ad
         5ZOMIihWQFASsxkCa2bwVtieCBLs86C0D1Vr5na48kYLKJL7Q0jUcxr5bUj/NX/teYNJ
         AvftqwjAleb0IydwVPNM8cp6YlkUmg6taljsiWYKg40vKSqJA+Q8XPL7H89q05OobzcQ
         Iy5mtH1P93oJp4ar0Slw2qe+DF2uiGmoveDcHpZOLPy/ApXfCVGfkQbMGAPGWqoYD2Js
         CFyWpv8tKjrzRmHPMisqZgrkD5Kzqm9r9JS/9yoZ3/Oany/hRNzLrBesoJ8chwuodVlJ
         CUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679059588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnovJjydcD88B/V7T4Cq2Usmwr/ZvKcG59naHHxKAo4=;
        b=VLMDP+Y+t7wRGjZTv9BJaau0a+ZR9L2KbIYMRN+LXaJ++ijB6Oy2ND4V7T2nixr7/J
         OdvNlbJZPSF32iWVIEskesuvi4l5A21WlXgk1j9+N03v4ThFBiEhpDaHawWzw9Fi0uUp
         km+Gb8jGOk4X+3ouZySBPQm6a8IhBkxtxXsoLGbLlgb9G4+YO2ttmUmfxraBkaqbjUJn
         coHuNLRRjxRWFvLQ18b07iTwtmcPS+F2moOyJLz7HdbXCvnUaRmmz820n6j+f05Xi3bb
         7iSfL3setvD4UgKopXf+BZApfekaCZay0CafGHx/L/0rQiGqHHLYJ37ZcGD9CPsGCaNr
         mc9A==
X-Gm-Message-State: AO0yUKUNm37Ib5fo+d4JAb9e4wR5zbud+uzaZ6JeiC7HVPF78FWcITkN
        m+71Te7TRNc/8bzX2jkbkE8=
X-Google-Smtp-Source: AK7set9KzhUQ6sINcVegUPh51rWRnl9XPmJkiNZ7yM9o/q+C5mYcrpTdB32IocsNb0lN+emb2APq8A==
X-Received: by 2002:a2e:87ce:0:b0:299:a8fc:1fd4 with SMTP id v14-20020a2e87ce000000b00299a8fc1fd4mr1950127ljj.51.1679059588626;
        Fri, 17 Mar 2023 06:26:28 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id p15-20020a2e740f000000b00295b588d21dsm411083ljc.49.2023.03.17.06.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 06:26:28 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V4 2/4] dt-bindings: nvmem: convert base example to use NVMEM fixed cells layout
Date:   Fri, 17 Mar 2023 14:26:18 +0100
Message-Id: <20230317132620.31142-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230317132620.31142-1-zajec5@gmail.com>
References: <20230317132620.31142-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

With support for the "fixed-layout" binding it's possible and preferred
now to define fixed NVMEM cells in the layout node. Do that for the
binding example binding.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../devicetree/bindings/nvmem/nvmem.yaml      | 42 +++++++++++--------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index b79f1bb795fb..980244100690 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -68,24 +68,30 @@ examples:
 
           /* ... */
 
-          /* Data cells */
-          tsens_calibration: calib@404 {
-              reg = <0x404 0x10>;
-          };
-
-          tsens_calibration_bckp: calib_bckp@504 {
-              reg = <0x504 0x11>;
-              bits = <6 128>;
-          };
-
-          pvs_version: pvs-version@6 {
-              reg = <0x6 0x2>;
-              bits = <7 2>;
-          };
-
-          speed_bin: speed-bin@c{
-              reg = <0xc 0x1>;
-              bits = <2 3>;
+          nvmem-layout {
+              compatible = "fixed-layout";
+              #address-cells = <1>;
+              #size-cells = <1>;
+
+              /* Data cells */
+              tsens_calibration: calib@404 {
+                  reg = <0x404 0x10>;
+              };
+
+              tsens_calibration_bckp: calib_bckp@504 {
+                  reg = <0x504 0x11>;
+                  bits = <6 128>;
+              };
+
+              pvs_version: pvs-version@6 {
+                  reg = <0x6 0x2>;
+                  bits = <7 2>;
+              };
+
+              speed_bin: speed-bin@c{
+                  reg = <0xc 0x1>;
+                  bits = <2 3>;
+              };
           };
       };
 
-- 
2.34.1

