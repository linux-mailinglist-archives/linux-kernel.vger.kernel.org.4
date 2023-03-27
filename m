Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCC16CA751
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjC0OSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjC0OSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:18:06 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48C74EF4;
        Mon, 27 Mar 2023 07:16:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j11so11629398lfg.13;
        Mon, 27 Mar 2023 07:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679926579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUI/boJJyBwexqi5pzYq09R7cmCZZDfn8166TkbccPA=;
        b=YvZ7Iw91yPR370hSqcrya7kzWkDlx0GxaLLswqfgY2kDoRjodyH8c5ht4TRfTnzGh8
         rxXhBWE2D0R9rD55nyu6bPYVX+mf+UmYShlnvKzEm801re+x4thblmGWKsPK8ToE8ZhY
         uCvdWAN9YpWSI303VYcaZZlSQYEQjEkHFhxRIxCZQdjKf1hg4ouvncPeDDgDX/W+Mx6T
         Sm7/UciIprOe/XJMgwsXpkyBzhz/R0k0SsxXWWKHAOdVa992jSwh+rfFzOAiOMCl3aH4
         KCbW34r+pZoZcQ6wHUTz1pXh42NpZ7hHX3xBetpJ/JCOP7ub3IF8Ap30//LnjxKBdupf
         42zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679926579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUI/boJJyBwexqi5pzYq09R7cmCZZDfn8166TkbccPA=;
        b=JaK2m9wYG4ItQAOl8iL0PR3JJdq97jAddFIbnIi0I+I1p1Ezz964WehLQmyuPWSFfX
         52qs557mX8Xs5M6AFcIC+ZYYE5i4ptffdnnQpfcUIAIjBXtBJ6UogGQ+UzUleX+xh4oA
         Osow07hXXd/3+MzPU4wYSPZ4tnckZCg3oDxhhGwKALnpNeQwNE1/awrEyjY6KhUZIbEl
         wEYxYNGBRyI1P6vI2NmHrDMbpRjPhVX3/QG0jY4lO0K3q8ONGWwS6SY/JMsLdM4YAHKJ
         VKNz3iBHkN42v3nIISYqYZNqDU1tkF9hwmrqcR+ERu6n2Q0jkUJmlDImalhmlMwSD0rb
         VU6g==
X-Gm-Message-State: AAQBX9fqgjXpiOeSRGwsBfczI8DzpQPaoHTWBJ+Qqvq9QsNh9yUzxkwH
        qKkjwnyVPGv5qIY2DaYww/A=
X-Google-Smtp-Source: AKy350boc4Hh/2cICnB+086LKmzzAAQjIgE+Fd/KSb+swqqx82dlqsj8bj2XzWr/jrizAWajbTmAow==
X-Received: by 2002:a19:c202:0:b0:4db:2cdf:4c11 with SMTP id l2-20020a19c202000000b004db2cdf4c11mr3312945lfc.62.1679926579210;
        Mon, 27 Mar 2023 07:16:19 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id w3-20020ac24423000000b004e977970721sm4444519lfl.219.2023.03.27.07.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 07:16:18 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V6 2/3] dt-bindings: nvmem: convert base example to use NVMEM fixed cells layout
Date:   Mon, 27 Mar 2023 16:16:10 +0200
Message-Id: <20230327141611.25131-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327141611.25131-1-zajec5@gmail.com>
References: <20230327141611.25131-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

With support for the "fixed-layout" binding it's possible and preferred
now to define fixed NVMEM cells in the layout node. Do that for the
example binding.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Rob Herring <robh@kernel.org>
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

