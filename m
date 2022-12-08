Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C7E647321
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiLHPcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiLHPax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:30:53 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEA184B79
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:30:46 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m14so2031202wrh.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 07:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3nZeW09fXhVKKN3KyKLvbBj2rJc2M/wLUemiWl6Iqs=;
        b=YyB4q4SP2Ry2z6DrrRHmmwjWcPgRFwce6rxxmTxyykraQzc/9RkRP51FXEwHqZO7m/
         20wYbxkj8FWEHX88116T3WnWkCOFXqerpwf5iZ/n3l4lqcXnGpqP0AswXb6io8a3bJDE
         0tYCR3oJ9z+1xzl7MFTvoXVgohGjqbKUq/Ubv4wvkgzmemfm1HWm1ElB7eujYVenf5eq
         SERSELje+miYCcp9/+8hwqMAcaGpx6ry8DXjpTMXfLqhCBMtoWjoSnItTH/Uf2rmethG
         iofiTxEVvRhzFkl0Kat1YIuNJwBEb1OCyu9ZInTMC1nJ/z8o0LxSnyyjw3R7nGYPc9uj
         Q4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3nZeW09fXhVKKN3KyKLvbBj2rJc2M/wLUemiWl6Iqs=;
        b=KzgRvbEYJTni8QWT616e8iMODe08/2cY76/QS6iBnL9bb5KgHbCC4v95MSIE9qMMTl
         1iDCnargUXOg2dty/FWlCwFvuRLY5QW0I3Eexc+Au1jtmx5+8sFVveyhWWfh2msRJ2Pt
         0wi4dMDt4M6sDktcmK3Ec2RdLBzNM2NEfpGOXsF4J9yszZq+gwpxhbtpLMpJbi6N10X/
         z4/2l1/3zXuiOJOst1xFeV1NRdda1nWAnm5E+DJ70Ucj0mlzL1CFqlUPFFNWm8bB2wxh
         Nv/2eAyGHSZEfaohxy6c8soeVVO6OFGXpvFxfEeZWtcYSROTLLuNRtHHmPRKwtWB9yS7
         v/Mw==
X-Gm-Message-State: ANoB5pmmW/clBQn64VpUwWk8es9qV2PljRBvzSYqXDu4BR1lSn5AOb2K
        p3vubCCA30kDny8wz1q0OUYeoA==
X-Google-Smtp-Source: AA0mqf7iR2EvjsGHr5MUa13qi18194p51dzW5Cj4dAGfA4boSpbwmRh+IGQ2kMfCSK6jzlU1UqxyFQ==
X-Received: by 2002:a5d:58ea:0:b0:241:f85e:75ca with SMTP id f10-20020a5d58ea000000b00241f85e75camr1571723wrd.9.1670513445136;
        Thu, 08 Dec 2022 07:30:45 -0800 (PST)
Received: from predatorhelios.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b002366553eca7sm10673239wrt.83.2022.12.08.07.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 07:30:44 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
Subject: [PATCH v4 3/7] dt-bindings: mfd: syscon: Add mt8365-syscfg
Date:   Thu,  8 Dec 2022 16:30:36 +0100
Message-Id: <20221208153041.3965378-4-bero@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208153041.3965378-1-bero@baylibre.com>
References: <20221208153041.3965378-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Mediatek mt8365-syscfg

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 1b01bd0104316..7beeb0abc4db0 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -50,6 +50,7 @@ properties:
               - marvell,armada-3700-usb2-host-misc
               - mediatek,mt8135-pctl-a-syscfg
               - mediatek,mt8135-pctl-b-syscfg
+              - mediatek,mt8365-syscfg
               - microchip,lan966x-cpu-syscon
               - microchip,sparx5-cpu-syscon
               - mstar,msc313-pmsleep
-- 
2.38.1

