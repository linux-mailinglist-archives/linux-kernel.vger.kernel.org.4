Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B549E6C86CD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjCXU0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjCXU0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:26:30 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AF51BAD2;
        Fri, 24 Mar 2023 13:26:29 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id r16so2062345oij.5;
        Fri, 24 Mar 2023 13:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679689589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ARTWLAnE/R5/Yn3e8IzR5CYG/awWCo/Ki7MKRLqJWs=;
        b=b3akyZZSO0zm17UMJoPNErRfhBnAdIBg1i9mdR0zQLs4bhFtsYZu/9g643xr6DwIH2
         pSxOSplQEQb4Ab5asD3gr1XQ8BQLkOjyL+xa6auQ0eRHFXvWIWNHbhdaZlbVL1N5Bxj8
         lW6LSJUxgonx28IL7F9gc8tqonYgdyj/h8zttjlZPlwT8Zg61V4/Qb7GN8tIaStYgMgL
         MNKu2nHIELEzu+z+gKQEjUfnTH+lh/TGNXAvPdySB3FQx3hRMPAx1lYDZRYsmzYROc12
         nABEF43XTSElZwoGdrIBli4qY6qrI6u6+5L6MuFr2DmzuHM32juir0dm5ELmVIt6Lg+a
         pN9Q==
X-Gm-Message-State: AO0yUKXHiuDZ/QoVlNSMI0RpW22n37UYlEotAD+aFUT1HYr+JBMOpFh2
        CohcbUHElsyiUBLgC32blq1hK5YWFg==
X-Google-Smtp-Source: AK7set/v1YbeRweTPhFlmin/sC3QdECy0j/Wx51PrqueLQ6Jc/SuW1sAaCfWv2xWkuMsrDtBqGlKyQ==
X-Received: by 2002:a05:6808:6c4:b0:387:2f8e:fd56 with SMTP id m4-20020a05680806c400b003872f8efd56mr1612807oih.33.1679689588707;
        Fri, 24 Mar 2023 13:26:28 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o15-20020a05680803cf00b003875e29808esm2089833oie.0.2023.03.24.13.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:26:28 -0700 (PDT)
Received: (nullmailer pid 2448124 invoked by uid 1000);
        Fri, 24 Mar 2023 20:26:27 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: yamllint: Enable quoted string check
Date:   Fri, 24 Mar 2023 15:22:43 -0500
Message-Id: <20230324202243.2442956-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yamllint has a quoted string check. Enable the check aligned with the
DT schema style which is only using quotes when necessary with the
exception of regex patterns. There's also the frequent occurrence of '/'
which we allow rather than fixing.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/.yamllint | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/.yamllint b/Documentation/devicetree/bindings/.yamllint
index 4abe9f0a1d46..fea5231e1320 100644
--- a/Documentation/devicetree/bindings/.yamllint
+++ b/Documentation/devicetree/bindings/.yamllint
@@ -1,6 +1,11 @@
 extends: relaxed
 
 rules:
+  quoted-strings:
+    required: only-when-needed
+    extra-allowed:
+      - '[$^,[]'
+      - '^/$'
   line-length:
     # 80 chars should be enough, but don't fail if a line is longer
     max: 110
-- 
2.39.2

