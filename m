Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B424A6C82CB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjCXRDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjCXRDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:03:01 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE5B30F0;
        Fri, 24 Mar 2023 10:02:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id z11so1682352pfh.4;
        Fri, 24 Mar 2023 10:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679677378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygxBF71VOkM+KeTylKWK/Z0RCTPhhMfAZKU7dH6P7Hg=;
        b=OIEUXRh+v9HvcGnDSS5Aq05048LRCODXCmO/sixBVKIa2xfhzdcSmf8LxZfSe3x4mV
         vmOxAXKnX6rXI+Ox2iwdL0E5grJpHKmG4f+kzCuuj8bpVatkaXEi40WDKa8HeOjk3JaD
         UuCVSqAqznxYu5rskkKlchoJOB4jvvLBJkqkgpbRftz/cdkRge8Z5f5vEvPaj9glcT9k
         lu2uShqWGlq1Y3Q6GPytJXSfNbCDETst6V9+7HttPUGDON9m2V99Y8GxNmlCRayqtkJb
         CjcXDM5HGEFciOkTePuoPQvyIjkJdHm61F2n/G/1Qu9Z89sEJPlDPYfi9xbQksUbXV7S
         BLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679677378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygxBF71VOkM+KeTylKWK/Z0RCTPhhMfAZKU7dH6P7Hg=;
        b=Z98Zat84DZcX8y8wuyrMf12ZEeauXapEaeTMwV8zIZqCgy5S4t6UQBBKn1mWuQ07Rf
         MvfzvvmagwUF7tkL7HnF5t2XL4DyvwkQKLuONwG6nKRh0sl583ZnALvnTeDAvILj4TTf
         tnBSJ5zF59deXNgPD7GpKpzu1yiwQK95QgRjrjnbtjxRQGwz3dm3suQQoXL2NiLysCFi
         A7X62KZsbEiGQ8xl3bMa51NsjpG9WUWHu1C+pf26KRDTwsig24knGOr+CxHaoIlfG2P8
         4puG8ms3RllRsZtxby/DoS76Z+sxJnP67/6uNtfFa+vTavJ6JfRJ6FN2Y4btcYbgBYMI
         dgjg==
X-Gm-Message-State: AAQBX9db0pNHEx37NxEP1hO2L8FNARkEwD2YYz9biDXvePQJiwz6tVw/
        iurW8chPZtB92OejThush/r5wXXo5ao=
X-Google-Smtp-Source: AKy350bqR4UWk0q6amyqYrEhXv1TQkS5KayocmKIbksYrCm4ba7kc5di+dFSprJTaQbsheg4bMx9vA==
X-Received: by 2002:aa7:8bc2:0:b0:623:2bba:dd9 with SMTP id s2-20020aa78bc2000000b006232bba0dd9mr3545736pfd.14.1679677377917;
        Fri, 24 Mar 2023 10:02:57 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h4-20020a62b404000000b005a8bfe3b241sm14019591pfn.167.2023.03.24.10.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:02:57 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Young <sean@mess.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ravi Kumar V <kumarrav@codeaurora.org>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Matthew Lear <matthew.lear@broadcom.com>
Subject: [PATCH 1/2] dt-bindings: media: gpio-ir-receiver: Document wakeup-souce property
Date:   Fri, 24 Mar 2023 10:02:13 -0700
Message-Id: <20230324170214.3470675-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324170214.3470675-1-f.fainelli@gmail.com>
References: <20230324170214.3470675-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO IR receiver can be used as a wake-up source for the system,
document that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/media/gpio-ir-receiver.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/gpio-ir-receiver.yaml b/Documentation/devicetree/bindings/media/gpio-ir-receiver.yaml
index 61072745b983..7e76838388cd 100644
--- a/Documentation/devicetree/bindings/media/gpio-ir-receiver.yaml
+++ b/Documentation/devicetree/bindings/media/gpio-ir-receiver.yaml
@@ -23,6 +23,9 @@ properties:
     description: autosuspend delay time in milliseconds
     $ref: /schemas/types.yaml#/definitions/uint32
 
+  wakeup-source:
+     description: IR receiver can wake-up the system.
+
 required:
   - compatible
   - gpios
-- 
2.34.1

