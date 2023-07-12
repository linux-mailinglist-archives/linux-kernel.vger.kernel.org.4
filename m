Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B23A7506EC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjGLLtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjGLLtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:49:04 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ECC1BEF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:48:20 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbdfda88f4so69790715e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689162495; x=1691754495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjCB4TOOxP7qsKNovkEsxKqV1LmaPoV1I20uND0A77g=;
        b=BFmaEGMw6Ft9GutczKIxNVxp9G1Ddpl+pAgdl5Rgpma7ch99AWsRPEuMfBkkyVQl3F
         w1DxYcYB2jI2O/b5AF4obdotjBMVItmIAe06ELlYExaTXCB7XCC0WXlLlH66OzSLgj5J
         AADN8Ldh/8dyv371o8tQebfv3N8vr5lpSVcvYq7YLNyqSWIj4K7HvTxAMDkMIsG8TJTQ
         EpiE2QRyOaK24dqPlG42Rp8LzMu6/Yxj2l2Q3lbotJHwMDSvXULRAXgEwCFNoBSAol0A
         vUQ1Qb7nVVipVPGN/KB2VLM4MeJw84QZNiBvwL8c0C2Py/SrL4qZgpHyCMpZszMiDa2p
         FPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689162495; x=1691754495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjCB4TOOxP7qsKNovkEsxKqV1LmaPoV1I20uND0A77g=;
        b=Lc8Wwu7hT5MoHhed+k337ThcZ869kxTuQFPx/aUpSCjj6OYb2ZSBNA85K0KU4wnvDA
         9Z/dkhNlh9tWu4rzofubA3RU8+RjCEDtNNoVuUC1zOcyrBBImWiEy+Klp9KXN/LEPsGE
         ZxemYrdP5eJ43VZHMlXZjZ/FIJVZ3iRQ4e6b0d6j2a8DYtQ8L0uNEyjKnz+hmiOqZyrN
         6Wql2D1c8jMfgNMYsL1K0cFctmGLpPI1UWat+J0stNcK0XctZFBZIWFeV+3paccW2qt7
         tWpH7ROGNYJ7N8IJ4+0LDF7QPdjSs+mas6q3RSo9ahfOwqySbFhCkl82bndplmO4OjI1
         pXFg==
X-Gm-Message-State: ABy/qLbG5govsUynwl3N2+WRdCtZykCrMKLXEUtJRGWdRw0NvFXDYSMh
        Xngh4BhyTmZ8YvVaz+djWBQ9pQ==
X-Google-Smtp-Source: APBJJlGvjdJB4E4+Oxx5hArMzW3BaecO1LGH1ByTg5gSqGeb4fmHvUE3RMYyoe3voqT7+sJJxfCHKw==
X-Received: by 2002:a05:600c:221a:b0:3fc:1bd:95a6 with SMTP id z26-20020a05600c221a00b003fc01bd95a6mr13025227wml.31.1689162495408;
        Wed, 12 Jul 2023 04:48:15 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d4482000000b003143867d2ebsm4867463wrq.63.2023.07.12.04.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 04:48:15 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 2/8] dt-bindings: trivial-devices: Add MPS MP2971 and MP2973
Date:   Wed, 12 Jul 2023 13:47:43 +0200
Message-ID: <20230712114754.500477-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712114754.500477-1-Naresh.Solanki@9elements.com>
References: <20230712114754.500477-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add Monolithic Power Systems MP2971 & MP2973 to trivial devices.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 246863a9bc7e..f639618508a9 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -119,6 +119,10 @@ properties:
           - fsl,mpr121
             # Monolithic Power Systems Inc. multi-phase controller mp2888
           - mps,mp2888
+            # Monolithic Power Systems Inc. multi-phase controller mp2971
+          - mps,mp2971
+            # Monolithic Power Systems Inc. multi-phase controller mp2973
+          - mps,mp2973
             # Monolithic Power Systems Inc. multi-phase controller mp2975
           - mps,mp2975
             # Honeywell Humidicon HIH-6130 humidity/temperature sensor
-- 
2.41.0

