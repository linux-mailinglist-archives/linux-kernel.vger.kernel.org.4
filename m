Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C313C617D4A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiKCNB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiKCNB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:01:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45901409E;
        Thu,  3 Nov 2022 06:01:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id 13so5033616ejn.3;
        Thu, 03 Nov 2022 06:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jneUenFAcWaeUzGS8zwAmnQ28hpu+G2lRJYvSOqR+rA=;
        b=FQoGpcoO6SNTCG7a4PT8aZFLsJq6p2rpARp1dFtrfHtREnC0ZfYFjxHX1eRT8lmjD5
         02P2Nd8wKtBEcvYGHdUk/FUAtQpTcN9Y/v7MNNaJLKV0OSTVYOt27op9Xg3/empK9DX/
         5l9i/2C8c8cQRvQxp54gq2n0S8+QkPPik2DTUguCTfeiU9ZbeCWDUl5vYeQAjjl9DtrX
         VoVklDtBlPzQFeWmfuKhBHzXCGdqO3VBmDuSHYtPLd1Km4HLysV70o6YQU8KLGGqJ7nQ
         sCo721AYojF5tCdBrczQdvkRys2/1Wx3SrpXxrhGMTY2bJQqV6fU9jQA0Lk5eVqbHUhV
         +smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jneUenFAcWaeUzGS8zwAmnQ28hpu+G2lRJYvSOqR+rA=;
        b=LAmYSHj42hqT2QQpTIAMAChKIUDHKXMxMzH2rZfvZWpyd+pRvBoM8tJsMBujNVlaBf
         JiWL/fNGMoccrTJOeKmvecp8ldSm4SAawyS8MfzlK0zmsdZpeAMtOG9fYYqDHFibN2ab
         TLLKlVeldMprgCwjknf1JFaG8vQiZeF5iQ7mvcjyWdhp6WTk3knqQccONC/ZcsdNEtO1
         Kt39tarXX99kpYtdt7rP2DtjsgE/gDMacdSasqJFBCwXFJ+rm1DwDaWAbJVQ56I1X9p3
         gof/jCqguC21eb30FDlFcyY4ieUgPX/+AfIPonNAIfplmZQVAAtKVTu7EmyPjg5QQbX5
         Tzxg==
X-Gm-Message-State: ACrzQf3P7YfXC3DeQ7OaaW89fwi99v+pqeNqP3gNeuiBUxQP+DGcmqJL
        0G85GeXfO3tQ5uGKEe6tyl8=
X-Google-Smtp-Source: AMsMyM7sZgPXG4IfYApBR7EtWm56vMwYw+9gZ74/U1dAieQgpn552B8x7OLbD0GgH4DDtyjmJ5ockA==
X-Received: by 2002:a17:906:5a6b:b0:7ad:bc80:bffe with SMTP id my43-20020a1709065a6b00b007adbc80bffemr23790198ejc.578.1667480477442;
        Thu, 03 Nov 2022 06:01:17 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090676cc00b00779a605c777sm451829ejn.192.2022.11.03.06.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:01:17 -0700 (PDT)
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
Subject: [PATCH v4 05/13] dt-bindings: iio: temperature: ltc2983: describe matrix items
Date:   Thu,  3 Nov 2022 15:00:33 +0200
Message-Id: <20221103130041.2153295-6-demonsingur@gmail.com>
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

Give a little bit of information on what each item in the matrix is
supposed to be.

Also, some matrices put the 'minItems' and 'maxItems' keywords in the
wrong level. They should be on the same level as the 'items' keyword.
Fix it.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 .../bindings/iio/temperature/adi,ltc2983.yaml | 23 ++++++++++---------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index 6b3a20448f78..4f26b337c957 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -126,8 +126,9 @@ patternProperties:
         minItems: 3
         maxItems: 64
         items:
-          minItems: 2
-          maxItems: 2
+          items:
+            - description: Voltage point in nV, signed.
+            - description: Temperature point in uK.
 
   "^diode@":
     type: object
@@ -249,12 +250,12 @@ patternProperties:
           resistance(ohm)-temperature(K). The entries added here are in uohm
           and uK. For more details values look at table 74 and 75.
         $ref: /schemas/types.yaml#/definitions/uint64-matrix
+        minItems: 3
+        maxItems: 64
         items:
-          minItems: 3
-          maxItems: 64
           items:
-            minItems: 2
-            maxItems: 2
+            - description: Resistance point in uOhms.
+            - description: Temperature point in uK.
 
     required:
       - adi,rsense-handle
@@ -328,8 +329,9 @@ patternProperties:
         minItems: 3
         maxItems: 64
         items:
-          minItems: 2
-          maxItems: 2
+          items:
+            - description: Resistance point in uOhms.
+            - description: Temperature point in uK.
 
       adi,custom-steinhart:
         description:
@@ -338,9 +340,8 @@ patternProperties:
           Steinhart sensors the coefficients are given in the raw
           format. Look at table 82 for more information.
         $ref: /schemas/types.yaml#/definitions/uint32-array
-        items:
-          minItems: 6
-          maxItems: 6
+        minItems: 6
+        maxItems: 6
 
     required:
       - adi,rsense-handle
-- 
2.38.1

