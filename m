Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FA36C2EB3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCUKZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjCUKYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:24:43 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D975918B08;
        Tue, 21 Mar 2023 03:24:28 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id q14so587954ljm.11;
        Tue, 21 Mar 2023 03:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679394267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlFYzvPaNc4+r1fF+4ETWq25exQj+hE48K2I2gE4XAQ=;
        b=in1ot4HNg4D0Zl6IetwLv2Twu6rMFjNgcqqzIJVhQeHgi3KQh4qiutrKGa3/8fu5Xw
         2yA9KTbmoyQCiCQskH7su5+akiRxGhHFAW1XZouCNVFYADNlSj+yO3/s0eAXCDOFdibO
         0Q5h9iaYUzVeV2kuoYKeBd61UnK0E2B289+4B/FBj6r2Cvgf4Ug/RqnteZYQw7hYE7cT
         2i1D3o8wEXPHJxnrV+Svn5RkhfdFtfXARqjkMR2r2ErAZf11MhfPtVhDW5mJ7Zs4OfV9
         sXqoKnxQWGgElib3o8ODymdeWX/byG/4maxcsNs/84tTdmrIptW68ZgUOhno50vNGf6z
         4/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679394267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlFYzvPaNc4+r1fF+4ETWq25exQj+hE48K2I2gE4XAQ=;
        b=RTECmv7gZpYQY8cd3saDew3gA1g+k6nCzg/XwqJ2oc4cWsFL0M6UH7gSdMWdAEHOkC
         LoU07O5ZWISsdGQG2TWVdvWqLDU3U2X6qpMFOkIARYtLhWFhWJ9qixPhv0rbo3ww8wlw
         lioCSw9xR2C6a/Oc/Ck/zfkQO9U8S0EAY4LgDPTZu1tXm2AgUJIG0pZmpSl/Zcmos05k
         r9l07s8XZyk94NmITY1OWPLrIcb3L1QEKHoSTIlRzz1der7D+H+Tawx9DVIuUBoe1JO5
         4UjUEgYxb+Wyyumb/YdBSLC70bES+mhhiwZCAJPh7Nt+XadAXKjF21WpOaxOaXUTQI3Q
         MVyA==
X-Gm-Message-State: AO0yUKUIQH3so2bviKHT1XqHxuuD4mWKWBa5FSyQL/d/4oBdSZY875k6
        9S663/J19uMDKEvaYk8IoXU=
X-Google-Smtp-Source: AK7set/eb9PAW6irBrQgsowgIBPUjzkAVtAeMdbC7yJTTnrV8dqxeJpxqpQ/oPGH3nHviN2oo95egg==
X-Received: by 2002:a2e:9d0c:0:b0:299:57eb:ef3a with SMTP id t12-20020a2e9d0c000000b0029957ebef3amr693229lji.2.1679394267021;
        Tue, 21 Mar 2023 03:24:27 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id n12-20020a2e904c000000b00299f0194108sm2163069ljg.31.2023.03.21.03.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 03:24:26 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V5 2/3] dt-bindings: nvmem: convert base example to use NVMEM fixed cells layout
Date:   Tue, 21 Mar 2023 11:24:17 +0100
Message-Id: <20230321102418.4190-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321102418.4190-1-zajec5@gmail.com>
References: <20230321102418.4190-1-zajec5@gmail.com>
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
example binding.

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

