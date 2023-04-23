Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC0B6EC0B2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 17:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjDWPIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 11:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjDWPIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 11:08:47 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EBC10FA
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 08:08:41 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94eee951c70so516324666b.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 08:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682262520; x=1684854520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pZiCnxLQIdshs08PWQGzuL9B6PCTPo0yn+Dw1r7Avkc=;
        b=PXqMElIg3EV62/hW08GqgJCoaSPeZSxpDGOcRIRkOId4KjfZCkidw2XZfRadLR1Ccg
         g8XLs788/uBUo4wRTmfleIPzOdtPBYzvHJb5bQnruB4hum5GAKB5ZVI4zwlUmtQ7l8fB
         dQ8F4ubF0T7YpfGkgkptz+4SB4F9iRQyoMmIBXkHetWcqvxaObkqr5DBpjcIChaaFvWB
         csNVNk6V11Ve9zo7xmkMCgk5ZR10aRsdHmDqKDS9K89u2dO3r3BQUdlO1tyUVk5lxIPA
         Tkcb3MTStzZNslazvWgfxCaj9A5cNzGUQXJVzOau0Uk1qZ7TJm7FYoaOag+kiaVIOJBS
         d0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682262520; x=1684854520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZiCnxLQIdshs08PWQGzuL9B6PCTPo0yn+Dw1r7Avkc=;
        b=UTRzDMKUmJy7rzdh4gcoonEoUxsQwh6d8Eir2bGmM5jE4HdYc36yspOLr7ETqlDVpu
         FeKJTMj6gzlCOH7sPwbMNBTjJK8I5AXOFjQvsrkzNXILbK5KdMrhmohI2N2vJLP9ZM47
         BAFUKBmcyLR20vdQUTwmu+v/SRBS4O7MuUIxWCFq2ni2DyD9Jb/ZDD9D6swbvy9ux6PF
         LK2XdUDpAB1JkqJJWKrNh6vUu2zXMRKf9XNY8LydRADE3nNR1gt3FI8hXp3k4lffNevL
         wEWyXM//zBv//QWIpCT7uw4JhHQTJ3cUzazDsnI74HMEwCerQjpOpt4L7xRLLFSSAVM+
         CYHw==
X-Gm-Message-State: AAQBX9f0p+D/XBQ/ikItqUfaJqp40BbseVJalWtL0IENEjZ3I/Swa98W
        ShmKi2T6gudJW+FWbfCD+jcc+Q==
X-Google-Smtp-Source: AKy350ZnrIUchKcNocmGRr/MpWzSIHVUCSqb49vRNrU07G+Q5TLPJK7Jrpp4Kh4T9TWC7mqkk2YguQ==
X-Received: by 2002:a17:906:c287:b0:94f:6852:549b with SMTP id r7-20020a170906c28700b0094f6852549bmr9001482ejz.9.1682262519906;
        Sun, 23 Apr 2023 08:08:39 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:5d52:d466:d57f:118c])
        by smtp.gmail.com with ESMTPSA id bt4-20020a170906b14400b0094f3cb173c7sm4498694ejb.63.2023.04.23.08.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 08:08:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: vexpress: add missing cache properties
Date:   Sun, 23 Apr 2023 17:08:37 +0200
Message-Id: <20230423150837.118466-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As all level 2 and level 3 caches are unified, add required
cache-unified property to fix warnings like:

  vexpress-v2p-ca5s.dtb: cache-controller@2c0f0000: 'cache-unified' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
index 3b88209bacea..ff1f9a1bcfcf 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
@@ -132,6 +132,7 @@ L2: cache-controller@2c0f0000 {
 		reg = <0x2c0f0000 0x1000>;
 		interrupts = <0 84 4>;
 		cache-level = <2>;
+		cache-unified;
 	};
 
 	pmu {
-- 
2.34.1

