Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC435B6466
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 01:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiILXyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 19:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiILXya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:54:30 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E78F3B8;
        Mon, 12 Sep 2022 16:54:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso7493185wma.1;
        Mon, 12 Sep 2022 16:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KIbgpY6+1YhC7lqEl0JPrCwtf2oGmEfe1YyH1pp/SBc=;
        b=kCicGgSECxPPDBKXnMGEOAp7I8wqLvhSd+8rg6aWfpMwtoL3F6/0j5WlmMftfzAp8m
         DOAETJ+Y4qTz34ZaixQYWDpp+dtrfMMx1G1+YScR4YAMv+FnpV4Q7caovFU3wLtSqro2
         y1ti0jS9QJe0VD1N+X8t80EjqJGM4KGzUT7UB3kcHHbqTNf+pRMlSGWl1KwC8llMno8y
         eDD09930fBB4MqVFBskX5ahNRHNespsgL+7zmJikfaCcFcvRI8D8/5ZO26OSTL+jp2iB
         HS86AEKjlCUa9jMus05VBGw0gsm4N133TSr1l1ZinqR5+9y1F0rkSCZC7Kpig0L93C2/
         XqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KIbgpY6+1YhC7lqEl0JPrCwtf2oGmEfe1YyH1pp/SBc=;
        b=RW56icnrTkUEiNI/S6Iahmsw2uWdW68EF7TetNSF0VgYwQvZVRPDYEfsE8tajeL/aT
         fyrYmALfPxvw5vfiGnj+BAXlfRJ6DIQMiPJ9nbhhmyHIhybjU0YGP8BbYLoz4CRO/Byg
         z4Dgp4mYBeWf5OT6aw5MfbFYZfW11v1gU21P0KhPwxXoZfW1bv0QPlJM5jnKAfA6dlqZ
         QXNRCHp39tH8FCJcZElSB/rBba+PsROAtQcZALEXClLJGgwtzCUnRY+mjioKxORvNuUd
         nMtdO9UOLtnz+a7/7L4FHaYkJQYl+CLYLK0TyPZqm18tLnLJcoXKpDvT/COnGQtOzGLT
         t2RA==
X-Gm-Message-State: ACgBeo0UxTQ885G7WN+WWiXP/DSUfu3W+wmK94JSyemFPu0mGOlDz5tP
        VquWzbD2GT/MoKcOSgrabo0T4khr2ys=
X-Google-Smtp-Source: AA6agR4WrCCP8pg9bYfF5l8JC/R67n0Ryj8bIpFR4K0Bn2K6ynVet7bq5LBEt11olK+O2abCJ+wVSg==
X-Received: by 2002:a7b:ce99:0:b0:3b4:9031:fc02 with SMTP id q25-20020a7bce99000000b003b49031fc02mr480729wmj.154.1663026866881;
        Mon, 12 Sep 2022 16:54:26 -0700 (PDT)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id bh16-20020a05600c3d1000b003a60ff7c082sm11633789wmb.15.2022.09.12.16.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 16:54:26 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio <linux-iio@vger.kernel.org>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 8/9] dt-bindings: iio: pressure: bmp085: Add BMP380 compatible string
Date:   Tue, 13 Sep 2022 01:53:50 +0200
Message-Id: <67224da4ae308bb752fc8fdecc54345cedab6c21.1663025017.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663025017.git.ang.iglesiasg@gmail.com>
References: <cover.1663025017.git.ang.iglesiasg@gmail.com>
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

Add bosch,bmp380 compatible string for the new family of sensors.
This family includes the BMP380, BMP384 and BMP388. The register map
in this family changes substantially and introduces new features
but core concepts and operations carryover from the previous iterations

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/pressure/bmp085.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
index 49257f9251e8..72cd2c2d3f17 100644
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/pressure/bmp085.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: BMP085/BMP180/BMP280/BME280 pressure iio sensors
+title: BMP085/BMP180/BMP280/BME280/BMP380 pressure iio sensors
 
 maintainers:
   - Andreas Klinger <ak@it-klinger.de>
@@ -16,6 +16,7 @@ description: |
     https://www.bosch-sensortec.com/bst/products/all_products/bmp180
     https://www.bosch-sensortec.com/bst/products/all_products/bmp280
     https://www.bosch-sensortec.com/bst/products/all_products/bme280
+    https://www.bosch-sensortec.com/bst/products/all_products/bmp380
 
 properties:
   compatible:
@@ -24,6 +25,7 @@ properties:
       - bosch,bmp180
       - bosch,bmp280
       - bosch,bme280
+      - bosch,bmp380
 
   reg:
     maxItems: 1
-- 
2.37.3

