Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62107679C79
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbjAXOta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbjAXOtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:49:11 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732CD4B196
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:48:55 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y11so18454728edd.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gmEnLOdJR14tI3Ntkk00dRFSWjZDFa7+/nYKUeYSOJ0=;
        b=I9WJV4tHohdSFNvgT3DyyRpkrkbR321+ZvIjeLn6cxLNMil3v6RvbA23WpOl1FxWEZ
         RM+OHDDpxbAV8RAzSY6xlxgcpTrXPJk5RYx68GTxFl+059YF4psYeA6sgwHrInvtHg6w
         RGNIxRI/h2d7K2Xb2fbYAl+rtymmKdxwot95z3bsNwmg+1jh84fuVY3sSZ7cq9hLKI/Y
         OZzCuHUjUIrqEeJ9oVPeik/jPaC+4D5eXsw9bMw3TlmqaqRQrTYraFzHhI0K/odUEgp+
         2vka+hpM4gz8/c+V+Ta/loEiExVqCINA1nioIiaE5ygICF7gz+5aSI4j1PhVMU9k5AYa
         2GPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gmEnLOdJR14tI3Ntkk00dRFSWjZDFa7+/nYKUeYSOJ0=;
        b=zR3qttxtWRzRv8IT0Pk1r9dMrEYbet89KZx0Y3+755oUA6iSuUpmFu4KMwD7IB/guL
         M/OI9LHuNj/tuFJJZW6PHqIzxFZEOEO3Z01QZBuh6tmA1LNi94b0hULc6GL2d93R8NY1
         Fomj4uYCg06A2AJr+7WqlFpkpoZ9iRrJsOyzfvuK9VKT+LLHUegM88RhwSCdBQCPSwUo
         7NQ0PBJLhNwgTSSSZNMM40oS+3AH9ZxM8CmPOdhU9SNFsIOxOj2gdCB52eyPyLHygOiS
         bjkLPqjGG50vnJyFSOfTxflusV59U8DPECSkc4QuYKPRAU20x5IFXEtf25SimpPSSmbT
         IseQ==
X-Gm-Message-State: AFqh2krMNF1x/FF7fyMo/SeeP6zeYFFK87C4H/UbrOTU/vRAakj6x6cF
        67lovjikXgNkTEqLlDsBz6HcT1+jCWu+E+AbZP8=
X-Google-Smtp-Source: AMrXdXvn5O8bRNj0aUasc7ka2tDDIcHcDOU0IRE4ejFhCjw58kLWIlA0ka87oYwA8fHtt/cbAf9TAg==
X-Received: by 2002:aa7:cc81:0:b0:47e:eaae:9a5b with SMTP id p1-20020aa7cc81000000b0047eeaae9a5bmr28281849edt.42.1674571734030;
        Tue, 24 Jan 2023 06:48:54 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id b8-20020aa7c908000000b00482e0c55e2bsm728104edt.93.2023.01.24.06.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 06:48:53 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-hwmon@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: trivial-devices: Add Infineon TDA38640 Voltage Regulator
Date:   Tue, 24 Jan 2023 15:48:45 +0100
Message-Id: <20230124144847.423129-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Infineon TDA38640 is PMBUS compliant voltage regulator.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index f5c0a6283e61..a28b02036489 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -141,6 +141,8 @@ properties:
           - infineon,slb9645tt
             # Infineon SLB9673 I2C TPM 2.0
           - infineon,slb9673
+            # Infineon TDA38640 Voltage Regulator
+          - infineon,tda38640
             # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
           - infineon,tlv493d-a1b6
             # Infineon Multi-phase Digital VR Controller xdpe11280

base-commit: 4d891f76a30d3be4194a805c5e4277786140ef05
-- 
2.38.1

