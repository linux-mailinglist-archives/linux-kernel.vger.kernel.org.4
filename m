Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B8470AE75
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 17:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjEUPMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 11:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjEUPDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 11:03:25 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A333BE4;
        Sun, 21 May 2023 07:59:37 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9659e9bbff5so944234966b.1;
        Sun, 21 May 2023 07:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684681176; x=1687273176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Meezc/i9bLiGiIpOa43/g44ICH2Bh3hwWynJC0Ok80=;
        b=lSlJlW60ZRaf/6KeD0XwAFYnxgleT+RXDUr6xXVG8Rhe2Ts0ReX1bcm6BDhHGJVK1n
         SV4USFwcEgQm7DEAjrvlnM2BfB3kplyLiiCVwB367oPsEdaSHLoMV43/IYHbx98809lm
         tlhZTiB7yRgC+Crt6efZ0Ju3Bk7APRfrbuwGILEY7oH7rCmeqznpmUF6wz+lE4tsVjhz
         4qRsvnZ3dGv2RtScFxS95yDRa5A3643XJYEEHh5km6gIXHUvJxKKsQBEsQyGftT8KJIq
         EsS+G9tfUkyaqjYQfaSTbJvzVbD65PifiE+59Lpsp1bGQIUW+avfmvr2A6ft92JOPTdB
         Pl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684681176; x=1687273176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Meezc/i9bLiGiIpOa43/g44ICH2Bh3hwWynJC0Ok80=;
        b=McGqEnltdAXD+td6m4n69DN1VQWkbQgw/8BvwgPpqjdgd8ZJi1pfhJMHniQtMUTizX
         dkoZINFwDwEMkSlUe7d+VWjNPDHyerv6ndNS+z360NM03UmXLPHTUC4KeXuczkV3UE0G
         +waa/UBjV1aErndkcWiKddvn/MRyW47RXEt1hoi3RPeRcRFnKC/6+o7u40n3vGGcyfD3
         pWPbBDm48gqLaeEcIOrz2AYNkEbZw8IQiN4wZZeZchS7ofEKEKL98EZWe3ceETJjH1V0
         SaOP8sDHi+wny1TRT2oSujetuMaL47YY2m0WUVB5kO0iTafTksaeQbP8YYl3asvcd7Ot
         z+UA==
X-Gm-Message-State: AC+VfDzKMD/SoPprudyjbkAGvs7RDGsZ5vg/uyUIJV7Nc4Wtr55L5L+u
        6VO2iQ6eGPf/TqGlQAJnTNbWApffefU=
X-Google-Smtp-Source: ACHHUZ6I5vqizuQoBnd1cFk4JfwWcb8Pp5t36p78y7rG7YnoFy2+fVAs/JDrbzaY7BSQ4mUQFqvXnw==
X-Received: by 2002:a17:907:2d90:b0:96f:a935:8998 with SMTP id gt16-20020a1709072d9000b0096fa9358998mr4314822ejc.39.1684681175878;
        Sun, 21 May 2023 07:59:35 -0700 (PDT)
Received: from localhost.my.domain (83.11.222.198.ipv4.supernova.orange.pl. [83.11.222.198])
        by smtp.gmail.com with ESMTPSA id f3-20020a056402160300b0050bca43ff55sm1912225edv.68.2023.05.21.07.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 07:59:35 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH 1/2] dt-bindings: mms114: Add linux,keycodes property for touch keys
Date:   Sun, 21 May 2023 16:58:42 +0200
Message-Id: <20230521145843.19489-2-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230521145843.19489-1-aweber.kernel@gmail.com>
References: <20230521145843.19489-1-aweber.kernel@gmail.com>
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

MELFAS MMS114 and similar touchscreens have support for touch keys.
Add the linux,keycodes property which can be used to set up the
keycodes for the touch keys.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 .../devicetree/bindings/input/touchscreen/melfas,mms114.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/melfas,mms114.yaml b/Documentation/devicetree/bindings/input/touchscreen/melfas,mms114.yaml
index fdd02898e249..07f9dd6b1c9c 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/melfas,mms114.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/melfas,mms114.yaml
@@ -52,6 +52,11 @@ properties:
   touchscreen-swapped-x-y: true
   touchscreen-max-pressure: true
 
+  linux,keycodes:
+    description: Keycodes for the touch keys
+    minItems: 1
+    maxItems: 15
+
 additionalProperties: false
 
 required:
-- 
2.40.1

