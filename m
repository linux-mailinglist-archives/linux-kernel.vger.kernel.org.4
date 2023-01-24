Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F4167A3C3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjAXUXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjAXUXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:23:41 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90627D8F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:23:38 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso11814228wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gmEnLOdJR14tI3Ntkk00dRFSWjZDFa7+/nYKUeYSOJ0=;
        b=YqaBqbArvj9tbfXxPPzqzyMoylHmGoUYM+4Xi57XkIPMpujQwSX5eOg8gPnANqmOmG
         FGhqo/sTQ4dB7Uzkya2ud5U/S/eOA4KPEvG/lE4cNc1/nu84GAjvm9MVfy8xVYMHDDjE
         fRu1vtqSt76yMqKMa5zQRF4P1nsLXK00yjW7XbsKh0lHuua1RD8OnYnP67c/6cdMQm0X
         lFQ/QUpixTm2XVfv9qXxsjni03Vk4LUS+1BjxNRfeH95ZjpWzsFuoEVwiBej2oLPKrwn
         1E+iCfWFotzVMxxiukAKlHk/raUwCntYZ0BUJdg33cnXy4d0VUO+3WMH6b3Eianl4d8T
         MDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gmEnLOdJR14tI3Ntkk00dRFSWjZDFa7+/nYKUeYSOJ0=;
        b=tocfHbyeRYDJ1OXyiPApC3aZK4QuvGw0iYR39E3gb6nfqAgoMK/lV3WpVZtDqWj1oe
         2eth50gwj5ue99Ls7qwdzT2hFESiv2uBzTQ3HQV4XTcVH232Yf04ZqaByyapUW8Kch9L
         8O5OnDhfUVyD3WsbNiOpZO3ZT3Erhy1xORPmlfFwkHG49lhtByX8Fx3miWWsdRp9+AxH
         /fLXK/G4B0D43gGnK4QRwy9w0vDGuy4XiqLY/POjeuEnveZ6umjUuDCbpLSBjAelkNFn
         rsmKL2FWH3Vj4lxhPAmSVlVuIdwXb1J+YaJRtePA1jgkVsXKSprJmAyuZz0iDTvPB90n
         t9GQ==
X-Gm-Message-State: AFqh2kpPr+Adon+1+UL4dV0nB2krzHVQefrAX8VrRt734ho/kor2MzXr
        bj17EZpFo+zkf9AXfHjduJQ7dA==
X-Google-Smtp-Source: AMrXdXswcuYTJMXhy4DWMQbQ2A+Kg+0md+xzTgmnKD0QB2GaeTpXmAVDutq5HUKk8SJj/ebTyutWsg==
X-Received: by 2002:a1c:7712:0:b0:3da:1e35:dfec with SMTP id t18-20020a1c7712000000b003da1e35dfecmr29505954wmi.4.1674591817237;
        Tue, 24 Jan 2023 12:23:37 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b003d9df9e59c4sm15334737wmq.37.2023.01.24.12.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 12:23:36 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-hwmon@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: trivial-devices: Add Infineon TDA38640 Voltage Regulator
Date:   Tue, 24 Jan 2023 21:23:16 +0100
Message-Id: <20230124202317.3704963-1-Naresh.Solanki@9elements.com>
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

