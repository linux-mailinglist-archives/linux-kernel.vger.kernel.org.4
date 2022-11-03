Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A641C617D4D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiKCNCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiKCNBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:01:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CF714D08;
        Thu,  3 Nov 2022 06:01:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a5so2834830edb.11;
        Thu, 03 Nov 2022 06:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zzx2/3zXVy+XSamreVFgLFmkVq8rfCdvsS38b4AXRWY=;
        b=X1CPalRZEolGGCg7hNs9GpAz8NcvoKOm73Glkl6rdeCTYeNycT8nGqnS4slOaXXcUP
         sQHQcKYJiArOGahmozpOM/uq3pjz0CracaSSKah4t6XDy6W8NzHSuGdbJ2C/ah4tezPO
         jfPnX8gO6pt1IKhFQA6swYZM2UQjqREJzy7/SshzvXSKP8AsR8AzGcyRNzex9pAycfGW
         dd5DA71qJv+QL8MBGppz3JG+qejX96opwqOIdyhyL+ngT+87YCORC3zCxtuKzLRRvm5I
         MYzySPiHaDehn95AGczZe0oZxouHGQUecRo6MKht7i4U7j7NnuRtA7s13fZCXUQjLhD1
         aSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zzx2/3zXVy+XSamreVFgLFmkVq8rfCdvsS38b4AXRWY=;
        b=jpQZXjdSbj7vlPFMwwjx4ITUhgSMnJO/0Sjj9n/kbea4+wWwMikP7HGMHSEpzIPj0/
         XKvx66hMOlCvhmxOGC6zTdDJ+xUL/E6asmOFFuxgc3cha/6ixLKh1C+Qq2TLJ+zv8xvQ
         PeOgoe2hSCZKaSh9hqWOovtEMuKFAQbajGXCtC6xB66Zi5QeQ2OJngjSblk/qnTxkp1U
         M7iEm0Eypu4xcbFITd5BXOj+DiJDcsRkv267z2aBesiHP3RqPwPQpAbyLBwatSFLbC69
         af1pSPDN9VNR+pQqc5JWA/xt8uNiEh3n+e89nBtmoGUpfzr7yyrMOWjyMthmsbu1CY3+
         u2dA==
X-Gm-Message-State: ACrzQf3QAMC4rbHThG6z2xHOnVAw9d5moHAhEW9CzHDyEojarcBV0Tcl
        5IfkEx487hFOuaNbuE2bDpI=
X-Google-Smtp-Source: AMsMyM6DsMozimHmhUJyME6ejc3SLsFmDriKX9DT06PElS5EWi1V+J1RouazjREIIwXK17XrSeXo1Q==
X-Received: by 2002:a05:6402:5107:b0:462:3014:3d73 with SMTP id m7-20020a056402510700b0046230143d73mr30160511edd.177.1667480480236;
        Thu, 03 Nov 2022 06:01:20 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090676cc00b00779a605c777sm451829ejn.192.2022.11.03.06.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:01:20 -0700 (PDT)
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
Subject: [PATCH v4 06/13] dt-bindings: iio: temperature: ltc2983: require custom sensor tables
Date:   Thu,  3 Nov 2022 15:00:34 +0200
Message-Id: <20221103130041.2153295-7-demonsingur@gmail.com>
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

The driver will error out when a custom sensor type is used but a
custom sensor table is not provided. Require it in the binding too.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 .../bindings/iio/temperature/adi,ltc2983.yaml | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index 4f26b337c957..bbac5f5cfbb3 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -130,6 +130,15 @@ patternProperties:
             - description: Voltage point in nV, signed.
             - description: Temperature point in uK.
 
+    allOf:
+      - if:
+          properties:
+            adi,sensor-type:
+              const: 9
+        then:
+          required:
+            - adi,custom-thermocouple
+
   "^diode@":
     type: object
     description:
@@ -263,6 +272,15 @@ patternProperties:
     dependencies:
       adi,current-rotate: [ "adi,rsense-share" ]
 
+    allOf:
+      - if:
+          properties:
+            adi,sensor-type:
+              const: 18
+        then:
+          required:
+            - adi,custom-rtd
+
   "^thermistor@":
     type: object
     description:
@@ -349,6 +367,22 @@ patternProperties:
     dependencies:
       adi,current-rotate: [ "adi,rsense-share" ]
 
+    allOf:
+      - if:
+          properties:
+            adi,sensor-type:
+              const: 26
+        then:
+          required:
+            - adi,custom-steinhart
+      - if:
+          properties:
+            adi,sensor-type:
+              const: 27
+        then:
+          required:
+            - adi,custom-thermistor
+
   "^adc@":
     type: object
     description: Represents a channel which is being used as a direct adc.
-- 
2.38.1

