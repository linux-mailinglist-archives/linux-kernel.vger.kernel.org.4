Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DD66C4B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjCVNWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjCVNWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:22:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9CF37544
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 06:22:19 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o7so17065730wrg.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 06:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679491337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/th2kVXqjdns9liPbOqVpfvQOOnugD39HQJSOA9ztTc=;
        b=pL+wBj+0z0up+rhipjI0mF/YWlGkhnUhxRFWlY0VrM8H7RGDLDT8NVnvtrXDbH/qxv
         oo8f5XZ2oLFdtUPxLOGq060KNa3KYV2DSyxyZfy+ORtuvas/UPvb1GWgR1hPwrvFXk/c
         w/NIYwsSO7Ab57meYQ8MVZT2yRw0h34ldBlFpK7PjyR1NHijNHtS1lrjMNWfQwC+LeUP
         sOAPDYNYf+Kzg7Oq56SCLOV81q2eYa6ciqlw6dCS4ijHvbXkvq4qEGYM1A1Rgm7SLXon
         9fjtSqjfMQGGE0MGk40DgOsqDW72WAhgo0SVJ1CRkRYVabLNrgmHcv2usdKMLDsUk0Sv
         TMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679491337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/th2kVXqjdns9liPbOqVpfvQOOnugD39HQJSOA9ztTc=;
        b=qlhhhegTl/yi/S0Q2/Li4gDwYqJVTmUmgTcWHzESHRdby03khP6bY83Rs2SNtyJoXb
         7NaoaseNXFP9lezj6Iydrga2yjxEO3rPvIf0xcn9+n0Y5L3wYH+lVOE5hhdmHO2q6vx+
         I392rb+4IC/cQAiiKA1vULHLfoCJUPX2jlzAQFfDJJqZwtHO6bsZOWC7UmophYMm/xzD
         nIwyv5iGD9jIvXZlg1yRKrQcKvXZhpH4EYeVYoUS6j4iTn6xflgwgzmI9mOZh0Hhna5F
         Z1CKLbk99xyLMS3X+5JGfSR4G/A5NjRbzoc+3GBq6Y/1hNp3tTFBD1syrVcIMklwMvOu
         9K+w==
X-Gm-Message-State: AO0yUKWZeGWlem2wh2FYHSmOuDT/4e3iiWzbkIEAyXhYC8SSjC+nI4UR
        drZKPATmWbDoUlhsymFWgaaGujSsvWV0wNcqQuE=
X-Google-Smtp-Source: AK7set86MU4ZYUAdrbcE61ulD+05sFsSTTWYsqJ/0JpKmJYJ93tqt8VQJ3y810OcoH+0SaOGq9k8uw==
X-Received: by 2002:adf:e405:0:b0:2cf:efa5:f505 with SMTP id g5-20020adfe405000000b002cfefa5f505mr5453463wrm.43.1679491337429;
        Wed, 22 Mar 2023 06:22:17 -0700 (PDT)
Received: from lmecxl1178.lme.st.com ([2a04:cec0:1013:81e9:8520:c2b5:32d0:9bd9])
        by smtp.gmail.com with ESMTPSA id b15-20020adfe30f000000b002c706c754fesm13867142wrj.32.2023.03.22.06.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:22:17 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v6 1/2] dt-bindings: optee driver interrupt can be a per-cpu interrupt
Date:   Wed, 22 Mar 2023 14:22:11 +0100
Message-Id: <20230322132212.3646972-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicit in optee firmware device tree bindings that the interrupt
used by optee driver for async notification can be a peripheral
interrupt or a per-cpu interrupt.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
No change since v5

No change since v4

Changes since v3:
- Patch added in this v4 to address review comments.
---
 .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml      | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
index d4dc0749f9fd..5d033570b57b 100644
--- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
+++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
@@ -28,7 +28,8 @@ properties:
     maxItems: 1
     description: |
       This interrupt which is used to signal an event by the secure world
-      software is expected to be edge-triggered.
+      software is expected to be either a per-cpu interrupt or an
+      edge-triggered peripheral interrupt.
 
   method:
     enum: [smc, hvc]
-- 
2.25.1

