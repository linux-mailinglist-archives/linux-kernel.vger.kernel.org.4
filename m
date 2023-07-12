Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C587750010
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjGLH3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjGLH3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:29:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C982310C4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 00:29:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c755e52b531so4369725276.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 00:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689146943; x=1691738943;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hbkQ9TWsaiiPF1uIe82FC8sECrgsl3HPxxU3EX8RtQ=;
        b=exJRQ2XrZdF3a3pbvLN03kkSxvamb5gl7cv1MKiBarMH9TkagZE4PqPX0ZrnlcxeCv
         7YbpjospGSPXOaJWgPKFr8XBLXE9ywD8heYRXmBojtUjt8erWJwgwsqdLvyQhvMnH9Lc
         sJagt1j4sorG1i84hOjq8ydNdrQCCTAWmVyB5hMS+Fb0916n1psmpgx9gyYiv+29Z8cb
         2uMS8hXYK4StvfNHCng1FHnXeq8S+yidF6aI49gLECFgYFdWg5kcj4denRyED+HuYWFD
         7cLDCOAeEDesWoIi9dO96YXZRnIpJlhrf3asX4m0bdFyMiDSzh5HGFuCAcFzs7lmWyFo
         XFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689146943; x=1691738943;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hbkQ9TWsaiiPF1uIe82FC8sECrgsl3HPxxU3EX8RtQ=;
        b=i15DVxE3drSx5vjpkdclm4PR3XI5HC2HrdIdp986I5kW4EIkwiTVqRh9Tf7Z8DMI2h
         cLgJGjYe6HLgJFesmqkh361L+ZnOZ3Wnah5Sj8IErm0r2BSrXAqvnffczl25mX17WwQd
         VZT3xG+Jx4Zu/ymlxdgbMyajcJvMKOaNO6J3IFwv+wRkLcHG+0lkL/Kj8tTmeoZ2gabO
         7qSowZhhLOKZoJCRL+2ffGjXMFogaqs6aTEBjiXwfC9dHUwcPOi0q1yKjj6oSyn9pXiv
         gCfUyGU/CLwgzh5dk6BDf9YU8mFebwusJVJMf6/VR8izR083i/b8bUu6pegP+OI8uHVn
         R9eA==
X-Gm-Message-State: ABy/qLYOGz8Xhwxi32lKnK0uYKh9eV+Z9phkdCZlGih/mYex8ULHK0FU
        vQo/PIjibM/gDVGIb58acfNt78gJtcQw
X-Google-Smtp-Source: APBJJlELqXvXv84piivJzzI4HaIYbFy2SgDMpUfzcRb/yJ+zlXV2JUECoe9NsnOJOc2H2H5zR7ZGv/VvC5e3
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:a359:73aa:74d4:e205])
 (user=kyletso job=sendgmr) by 2002:a5b:54b:0:b0:c4e:27df:1a0f with SMTP id
 r11-20020a5b054b000000b00c4e27df1a0fmr150587ybp.13.1689146943096; Wed, 12 Jul
 2023 00:29:03 -0700 (PDT)
Date:   Wed, 12 Jul 2023 15:28:52 +0800
In-Reply-To: <20230712072853.1755559-1-kyletso@google.com>
Mime-Version: 1.0
References: <20230712072853.1755559-1-kyletso@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230712072853.1755559-2-kyletso@google.com>
Subject: [PATCH 1/2] dt-bindings: connector: Add child nodes for multiple PD capabilities
From:   Kyle Tso <kyletso@google.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a new optional property "capabilities" which is a child node
under connector to contain multiple USB Power Delivery capabilities.

Define a new property with pattern (e.g. caps0, caps1) which is a child
node under "capabilities". Each node contains PDO data of a selectable
Power Delivery capability.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
 .../bindings/connector/usb-connector.yaml     | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 1c4d3eb87763..b8c96d0a127a 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -228,6 +228,50 @@ properties:
       SNK_READY for non-pd link.
     type: boolean
 
+  capabilities:
+    description: A child node to contain all the selectable USB Power Delivery capabilities.
+    type: object
+
+    patternProperties:
+      "^caps[0-9]+$":
+        description: Child nodes under "capabilities" node. Each node contains a selectable USB
+          Power Delivery capability.
+        type: object
+
+        properties:
+          source-pdos:
+            description: An array of u32 with each entry providing supported power
+              source data object(PDO), the detailed bit definitions of PDO can be found
+              in "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.2
+              Source_Capabilities Message, the order of each entry(PDO) should follow
+              the PD spec chapter 6.4.1. Required for power source and power dual role.
+              User can specify the source PDO array via PDO_FIXED/BATT/VAR/PPS_APDO()
+              defined in dt-bindings/usb/pd.h.
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            minItems: 1
+            maxItems: 7
+
+          sink-pdos:
+            description: An array of u32 with each entry providing supported power sink
+              data object(PDO), the detailed bit definitions of PDO can be found in
+              "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.3
+              Sink Capabilities Message, the order of each entry(PDO) should follow the
+              PD spec chapter 6.4.1. Required for power sink and power dual role. User
+              can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO() defined
+              in dt-bindings/usb/pd.h.
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            minItems: 1
+            maxItems: 7
+
+          op-sink-microwatt:
+            description: Sink required operating power in microwatt, if source can't
+              offer the power, Capability Mismatch is set. Required for power sink and
+              power dual role.
+
+        additionalProperties: false
+
+    additionalProperties: false
+
 dependencies:
   sink-vdos-v1: [ 'sink-vdos' ]
   sink-vdos: [ 'sink-vdos-v1' ]
-- 
2.41.0.255.g8b1d071c50-goog

