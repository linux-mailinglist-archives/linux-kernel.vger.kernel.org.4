Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7598C65CC9B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 06:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjADFZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 00:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjADFZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 00:25:27 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB1E167CA
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 21:25:25 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id z12so26495868qtv.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 21:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sparkcharge.io; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFS/lCQcj6VGGmUkQIK4WQwbgzLe7pFGBO2z51//9yI=;
        b=NKXV9Fm1i9JCRE7A8ERMnQADG9tfJJIjStUM8uI7Zd1ba8vLDANg82dkmoa+A4r7Sl
         dMKbBcsWYvqtfPI5yAC8Wpfwwaa+El/4iXsUsGEcbwUdURkweWS3Ql8dQHpgDo7x+DFV
         B7iwmCI9JucvdJDoozwGq3krWcDfKRKAeRnggJW8JRif0eZ3xMQWEH2ty+qTL0iQ1G5u
         ioHd4/fZ4k+XseTlfWF0qSpOcMhp8zkf0OeXdPgIGhgjIcLws5ECpHVdSyh1LRS1UXau
         vfAcEakVoDcCZFkwqsaQ+xgpzxaZxeVBhYQcjLqrje261Y7VB5Z2avXB2P6B0u3UQYyK
         nl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFS/lCQcj6VGGmUkQIK4WQwbgzLe7pFGBO2z51//9yI=;
        b=N5QSxDlVfncnBpwhjyxxPJwUA4zyqsppge4H28I/Ug3Pb7DnVXqJAJx6Hhh/h06vlH
         V4LAVmePBHFuRIR3bDSiBVH37F5P20GgRXyBsZFIBigpC5cFbS3mmT0TiACInzoV3afM
         q39GH31EJeO2jgNt/akrWhdQXAO40VoDpf3ktNwkT0wtOXpBSnYFqNkUdSn6tJU8E8/R
         Zvzhu4LWvS0oKrpQFv1doqfr32pKbNUz0cpYjOikgvsWAhB0MgNZHboq7WxH6xup1B6H
         Ah8kiKLbIMiIvdxn2wXcEUfEzbcwjSQpx0lKrA84MopGaS04Ag2/d1BKhaMR+yPlkpXz
         U2GQ==
X-Gm-Message-State: AFqh2kqrNKktXjJmdzmreL2jZWOLzKGNM7LicEkM+YKCi+K+xPy+NhH1
        5ex3d8bTel8pyeyPkzBq4CQBaQ==
X-Google-Smtp-Source: AMrXdXuJA0DQCbJ/n73PHFUtowQN37EANSgPuI19HQ2cdjPM/nUgKiD9pJSVDNum/6Gd4Cd7D0KzxQ==
X-Received: by 2002:ac8:44d7:0:b0:3a5:4fa8:141c with SMTP id b23-20020ac844d7000000b003a54fa8141cmr74557522qto.23.1672809924601;
        Tue, 03 Jan 2023 21:25:24 -0800 (PST)
Received: from localhost.localdomain (c-66-31-16-167.hsd1.ma.comcast.net. [66.31.16.167])
        by smtp.gmail.com with ESMTPSA id t1-20020ac865c1000000b003a7e4129f83sm19425602qto.85.2023.01.03.21.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 21:25:24 -0800 (PST)
From:   Dennis Lambe Jr <dennis@sparkcharge.io>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Atsushi Nemoto <anemo@mba.ocn.ne.jp>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Dennis Lambe Jr <dennis@sparkcharge.io>
Subject: [PATCH v2 2/3] dt-bindings: m41t80: add xtal load capacitance
Date:   Wed,  4 Jan 2023 05:25:05 +0000
Message-Id: <20230104052506.575619-3-dennis@sparkcharge.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230104052506.575619-1-dennis@sparkcharge.io>
References: <20230104052506.575619-1-dennis@sparkcharge.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ST m41t82 and m41t83 support programmable load capacitance from 3.5
pF to 17.4 pF. The hardware defaults to 12.5 pF.

The accuracy of the xtal can be calibrated precisely by adjusting the
load capacitance.

Add default, minimum, and maximum for the standard rtc property
quartz-load-femtofarads on compatible devices.

Signed-off-by: Dennis Lambe Jr <dennis@sparkcharge.io>
---

Notes:
    v1 -> v2:
    	remove accidental wakeup-sources line
    		suggested by Krzysztof Kozlowski
    	spelling fix in changelog

 .../devicetree/bindings/rtc/st,m41t80.yaml       | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/st,m41t80.yaml b/Documentation/devicetree/bindings/rtc/st,m41t80.yaml
index fc9c6da6483f..6673adf6e99b 100644
--- a/Documentation/devicetree/bindings/rtc/st,m41t80.yaml
+++ b/Documentation/devicetree/bindings/rtc/st,m41t80.yaml
@@ -33,6 +33,11 @@ properties:
   "#clock-cells":
     const: 1
 
+  quartz-load-femtofarads:
+    default: 12500
+    minimum: 3500
+    maximum: 17375
+
   clock-output-names:
     maxItems: 1
     description: From common clock binding to override the default output clock name.
@@ -46,6 +51,17 @@ properties:
 
 allOf:
   - $ref: rtc.yaml
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - st,m41t82
+                - st,m41t83
+    then:
+      properties:
+        quartz-load-femtofarads: false
 
 unevaluatedProperties: false
 
-- 
2.25.1

