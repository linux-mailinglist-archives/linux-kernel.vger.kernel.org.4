Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565056EC0B0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 17:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjDWPId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 11:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjDWPIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 11:08:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE6A1705
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 08:08:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50674656309so5171600a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 08:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682262508; x=1684854508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IuLX6n22q+dbXa0VFAcvggvBNepD8bsnQ2lqmRcCa0c=;
        b=ljLj9ZrdHyUvR9noreY2cCdb6yGNNSBCGJYqjUt1XCpcsM4Kjax3u6xRTvQLDzwoY1
         /WPxALxkg5TrwMzjTimoJ7miZMGEjWw85XKv5ipNlZKCMbtAXZN6B+XjRfTTsJeSGLz6
         iLU4eC1g072IUshxzMlIzzQ6U7/9pztyXr9fTQJ5xw2Ns2oNza3GZBz4lJW1b8TefVfH
         h3oK6N+toYbCoFH/P/4077Aw9b2j4Dy2n3+izM+P6zgTgWfIQezGQMmgMItgtgHIvBBA
         IRCmHMq9mGmvuuYqgAYMAn/gk2jYpslPxe2AhOhCXGqNGDdkOhQQP9abwQW+IjeOn5Uq
         R0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682262508; x=1684854508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IuLX6n22q+dbXa0VFAcvggvBNepD8bsnQ2lqmRcCa0c=;
        b=YraYVRIILso3EoCVAMMVs4AyUKxB7ySxP36UVrBMnrmDnFgchBoegXvcRH1gSjUhH5
         KoSmzw+LUDcausWUtNl4VVYuWTEStxrb4IFcod70Ufsi55m/dH7fWNxLiH8EUaF9oEGA
         efBiIsu+tmihKGwhEPXFIapflxICPcJNVRxv0rPjY44Lu6G3dHjo+sa2kpRk3AoJLHpj
         YEZB2JvR16j+TFfrsefaPlaXviKexs6JwVYeL/gq4H0kuJqVHWm2zAfWmgirYfmmAo6m
         DNK1jdkRUqxHB4V8lc4FSP0hfCtsI3aA1pX2tscyyChNLpql5cxmKj+JGZ2LFEGl2AqU
         mxiA==
X-Gm-Message-State: AAQBX9dQzo9QyuK3j9Ugko5WaSPdssz8mP/y0AnDyE2zXX8gCreePuaI
        z6iwZbQmUhkhkfdlmFqv16o2Og==
X-Google-Smtp-Source: AKy350bDpsVMNhD58NOSG7sY6lnuKQeOJFhZMI5m9y6vPvn0snrtJoLgzwkjK0Y7Z2TUwtH2ccKERA==
X-Received: by 2002:a05:6402:110b:b0:504:8905:5218 with SMTP id u11-20020a056402110b00b0050489055218mr10098234edv.1.1682262508503;
        Sun, 23 Apr 2023 08:08:28 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:5d52:d466:d57f:118c])
        by smtp.gmail.com with ESMTPSA id g18-20020a056402181200b004c2158e87e6sm3741393edy.97.2023.04.23.08.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 08:08:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: en7523: add missing cache properties
Date:   Sun, 23 Apr 2023 17:08:24 +0200
Message-Id: <20230423150824.118430-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As all level 2 and level 3 caches are unified, add required
cache-unified and cache-level properties to fix warnings like:

  en7523-evb.dtb: l2-cache0: 'cache-level' is a required property
  en7523-evb.dtb: l2-cache0: 'cache-unified' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/en7523.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/en7523.dtsi b/arch/arm/boot/dts/en7523.dtsi
index 7f839331a777..b523a868c4ad 100644
--- a/arch/arm/boot/dts/en7523.dtsi
+++ b/arch/arm/boot/dts/en7523.dtsi
@@ -81,6 +81,8 @@ cpu1: cpu@1 {
 
 		L2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
-- 
2.34.1

