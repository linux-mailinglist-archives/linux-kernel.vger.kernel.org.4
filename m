Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6BC67E8E5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbjA0PFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjA0PFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:05:43 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1824A7BE69;
        Fri, 27 Jan 2023 07:05:43 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso3680011wmq.5;
        Fri, 27 Jan 2023 07:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gepcoh1/hxUv6nKXHcQhtixyQIosb0XKZ35X3906qAc=;
        b=NWDPk6+RdbArgGiYL2c5OoIy8HWhZyEEVG07FXCpyTehvXUE2Pbj6JtRkyyb+fAKkj
         lmL1qZoIP+vYKEdjggclryVwDP34zv6/ghLS2wSes30w3la4h71562IhnhZkGr9PVnnB
         AaWKkRvl3/CTBMCme5T4jjoQLn1gwPfhHachm8k2qF8bPt/2CUW+Ap30AsPBzy0xtUNA
         QKi+CENchAych+BeBIREvESp9b3OPZYugMqUsiCkaSayIU3Vlok0qot4UdwlAl6Sw9Wy
         3m8qFBVykVI5Fs43V7I4q4BMd79W2bURAEaKzdmJAgGV4R65Ssk+giv5+pbTaEyJv0Bh
         Om5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gepcoh1/hxUv6nKXHcQhtixyQIosb0XKZ35X3906qAc=;
        b=chIPXrRu6D5KSzRf74/pqy6xpVxD8KHG7oLSn9JKZPEdAgWd+1NEWCWJ4hMeh8/7ob
         1bnJBhBA254tzP7oWulxVRXqLIT6ADVw7xfVGQnsqIgdfIl5xr20AQTPH7skfQLfyeR9
         oueepp8X7SiB8eIubEm+Lvn17tKQbBeIUMQhsNIFRoauNllQJsiZvewFF1f7bdmxt1ef
         mMd41QWEkLZgRIhpmZ/aWcc6TA0hefUyL+yNhEicOUXalaSNOEwNkuZXk7W6shZ0XyJm
         xNOQCTRLEYgQQS3XqNEqajl+Xc07bS/E0Kp9vNFs5C1ABW1c/OdnT9SfBl2SHYehD/AR
         Pm4A==
X-Gm-Message-State: AFqh2kqXmMXnW3FWfzNtOON0H/K2wkXeeV3xj0WdeFzt05dnSZ/N52CU
        awWAEBjqmJQh3ddUP1dR/bs=
X-Google-Smtp-Source: AMrXdXuSp44ZwmQGg0LnuJYoMK1vu0OceJljCbHt02EaiC/wLkMHGzV3oBGBHANWrskj1koMT2WeAQ==
X-Received: by 2002:a05:600c:5386:b0:3cf:9844:7b11 with SMTP id hg6-20020a05600c538600b003cf98447b11mr41889835wmb.23.1674831941414;
        Fri, 27 Jan 2023 07:05:41 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id l4-20020a7bc444000000b003db03725e86sm4573395wmi.8.2023.01.27.07.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 07:05:40 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: amlogic: add support for Radxa Zero2
Date:   Fri, 27 Jan 2023 15:05:35 +0000
Message-Id: <20230127150536.3719090-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Radxa Zero2 is a small form-factor SBC using the Amlogic
A311D chip.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes from v1:
- Add Krzysztof's Ack

 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 8aa6b6a92c29..6e3cb5a0d879 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -154,6 +154,7 @@ properties:
         items:
           - enum:
               - khadas,vim3
+              - radxa,zero2
           - const: amlogic,a311d
           - const: amlogic,g12b
 
-- 
2.34.1

