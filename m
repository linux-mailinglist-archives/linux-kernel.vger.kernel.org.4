Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B16617D4E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiKCNCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiKCNBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:01:51 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F56140B7;
        Thu,  3 Nov 2022 06:01:23 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id f27so5048996eje.1;
        Thu, 03 Nov 2022 06:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wl5YV1yuldlFg2w/72zvpuZsJu+kXHIm+tqTSmy2/d8=;
        b=CPONfOgiGcvco/Rskk0DdFbIZ6HfBYRnFSFdPUAnHEC+XwcCXJCsupfbw3rVgS3WNv
         BaS1aWtcXN6CYybLmhEOjR+zwsqQmER5EQZb4WwjGlJwUD3uKQKaU7y6raDhT5HKa12G
         SNyARbOgA/gLJkgyoe7Yp/poxlzsPLjmK2XlYmtmqgZ4yE8u2etgLAdQl2YEZJzJGYU8
         1Bg/Eqc63Xs+Qa6K7xfCwZ8OeUZzyCLTyiUnU2J5ngw/bn/GJksblf7OAZXriwGgmagC
         BQWpu6cqpULKzsIISCWL1+yzx2Ou+axpQNFD6XLQsVLaw972Z/n4+eSHoT77VG2ab0Mc
         OQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wl5YV1yuldlFg2w/72zvpuZsJu+kXHIm+tqTSmy2/d8=;
        b=7z2TEYa7f9NCiHUioV13N2whYO057UsoNHppPkXESXVX6yrUEfceIh/0a0iYcFRT6H
         TPVa/ijNLSZK9Qo+BOKVQs0AwFHTfze7Wvmr6BfcwPgAVrggDhs8ryAJKUFHswvho4TA
         IQQ1VrGI0gC4Rt6ungR08jDufrwBFuuOYsKKeZ7BIrxHUJPHfc0wDJqGUrHxYJfkwuzW
         2HVqVr669iYO8KBHt+jWbZWDWYsvgazatOtz1ysEbAJAj9V9KGYeG1rJpXg0aY8Uzn+A
         f/4UIzy9EokN79qAt9BjcSYjjNaYFIcTsNh0eW3zssFjyLika1IvCOdbqD/vxnWZG9ln
         NNng==
X-Gm-Message-State: ACrzQf2rhuM55+O+fDFVLSOcTBVc2Wf4oS/NwDi9sL8ou7AdVNxaEoxS
        5GKFxCzhJcC9e2W88YW9gCQ=
X-Google-Smtp-Source: AMsMyM7gPXzJcckBUMqFFsZth/J4/WP/0PALvoZxooUDuYJmORo94PSzkWl3TrmVl08Shg3SeMiOHg==
X-Received: by 2002:a17:907:7617:b0:7ad:c0d5:bdf1 with SMTP id jx23-20020a170907761700b007adc0d5bdf1mr23207559ejc.211.1667480481889;
        Thu, 03 Nov 2022 06:01:21 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090676cc00b00779a605c777sm451829ejn.192.2022.11.03.06.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:01:21 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v4 07/13] dt-bindings: iio: temperature: ltc2983: require 4 wire rtd for current rotate
Date:   Thu,  3 Nov 2022 15:00:35 +0200
Message-Id: <20221103130041.2153295-8-demonsingur@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103130041.2153295-1-demonsingur@gmail.com>
References: <20221103130041.2153295-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

The driver will error out when current rotation is enabled but the RTD
is not 4-wire. Require it in the binding too.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 .../bindings/iio/temperature/adi,ltc2983.yaml | 25 +++++++++++--------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index bbac5f5cfbb3..b603219fb0c9 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -230,13 +230,6 @@ patternProperties:
           resistor is used for multiple 2-, 3-, and/or 4-wire RTDs.
         type: boolean
 
-      adi,current-rotate:
-        description:
-          Boolean property which enables excitation current rotation to
-          automatically remove parasitic thermocouple effects. Note that
-          this property is not allowed for 2- and 3-wire RTDs.
-        type: boolean
-
       adi,excitation-current-microamp:
         description:
           This property controls the magnitude of the excitation current
@@ -269,10 +262,22 @@ patternProperties:
     required:
       - adi,rsense-handle
 
-    dependencies:
-      adi,current-rotate: [ "adi,rsense-share" ]
-
     allOf:
+      - if:
+          properties:
+            adi,number-of-wires:
+              const: 4
+        then:
+          properties:
+            adi,current-rotate:
+              description:
+                Whether to enable excitation current rotation to automatically
+                remove parasitic thermocouple effects.
+              type: boolean
+
+          dependencies:
+            adi,current-rotate: [ "adi,rsense-share" ]
+
       - if:
           properties:
             adi,sensor-type:
-- 
2.38.1

