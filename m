Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF3B6E677C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjDROvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjDROu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:50:59 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94850B77B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:50:58 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f09b9ac51dso69945775e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1681829457; x=1684421457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kIM8LW6yI6V143LdhT1FdSGC5xNGvUqWMyNhdIh0gqk=;
        b=ciG0U0QRb/NtYe41cCi/q6OdFth5UhsN/iDd2EGKEg6ZiIMqhZOrtWTKm4RzjQ7V4x
         SG6tPhxsMBoSPyg/USw2sFeZX47bslwOoMGthdyWnTrxhINAm1Sx09QYoEU0j8FQqj3m
         w9x2HmKD97bO91i2W8MbRHmEOMPKXlqiafPsO62wWViGAoof8j+vvGIxqY+eoceb9RiR
         fAlY0EpLzv8fYDgH/UEAXCo6XElzwjMOI69zF0v0EaMYPcu2kffTndwIIvfUbzT+eiU5
         Ss1BfG0RuANMUIHkDV8gkfDGi18LYQW5TrbVBBOEQp6eC+0McS70skcwRRla1ybCEkpV
         Nirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681829457; x=1684421457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIM8LW6yI6V143LdhT1FdSGC5xNGvUqWMyNhdIh0gqk=;
        b=JIGVJJYheHzVC2Yo/jJfzpVXsdsyw+wh0UD7h0XaOxAWLzkTPudGL7dvk6wCFEk20x
         vNuSd6FSmP2siB1SQkUhJet9ADoRNafdGJaErQmvq9udMJcxNk2RAcJHk1HoCiFV9qxY
         dF3gB9Ehp/WpC8hAQJy6CD2vYinL6psuTBuK1lmpMl+PdiMD9mDTJEDbIMs9ud9D4QGF
         9OhVDOF/FmNwYzHWaEWdLjNiaVsTjjkgoItI4NaQNsLCX6o6Z5YzDkBBVvaSBVuIRZpB
         FEmx37ToPrhnCU+we2NAeo3aq4LL2uusPFE8HegmChpMnU51sx8WU+vtW3klEFXOC2jA
         1S5w==
X-Gm-Message-State: AAQBX9eZ0LQSHUcexsVlg3/61f93Ws2X8HP9MA+m0vzYj7BeUDhtjhW+
        lXS4ugIgoiF0gQYtUI/PtSjv6Q==
X-Google-Smtp-Source: AKy350akkeZYqk9h4w91WZNPH0iayM5/fKMO5t5pZUNl/63Lsn9FR0tYXFPO4A0GVAQnAPL7l63wJg==
X-Received: by 2002:adf:dfc3:0:b0:2fb:b869:bc08 with SMTP id q3-20020adfdfc3000000b002fbb869bc08mr2181140wrn.23.1681829457063;
        Tue, 18 Apr 2023 07:50:57 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id z16-20020adff750000000b002fb6a79dea0sm3787823wrp.7.2023.04.18.07.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 07:50:56 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zev Weiss <zev@bewilderbeest.net>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: regulator: Add dt property
Date:   Tue, 18 Apr 2023 16:50:50 +0200
Message-Id: <20230418145051.4192963-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT property regulator-supplies.
This enables us to couple one or more regulator output to gether. This
is use in case of Single connector having 2 or more supplies.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 .../bindings/regulator/regulator-output.yaml         | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/regulator-output.yaml b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
index 078b37a1a71a..17f683d3c1f3 100644
--- a/Documentation/devicetree/bindings/regulator/regulator-output.yaml
+++ b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
@@ -21,13 +21,19 @@ properties:
   compatible:
     const: regulator-output
 
-  vout-supply:
+  regulator-supplies:
     description:
-      Phandle of the regulator supplying the output.
+      Specifies the name of the output supply provided by the regulator.
+      Defaults to "vout".
+    default: "vout"
+
+patternProperties:
+  ".*-supply":
+    description:
+      Specified the phandle for various supplies
 
 required:
   - compatible
-  - vout-supply
 
 additionalProperties: false
 

base-commit: c55470f8b0616b0adb758077dbae9b19c5aac005
-- 
2.39.1

