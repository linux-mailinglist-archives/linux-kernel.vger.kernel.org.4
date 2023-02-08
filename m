Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CF768F3C4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjBHQuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjBHQtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:49:50 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F983E0B9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 08:49:47 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bu23so1558158wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 08:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zOVpiA9bQoklU4o2dljZY43CBbu8RtR1NwpXNWDYasE=;
        b=H29feLPkuAsqMJ3Bjfji8adSbgdNAnfPUHW8GlWuFDn/4k2xCjjJaAfKevVxKdCCZ6
         B7xhMdg6G+Jsi4e3aJsp2HRbQXL2tLQKiYqHvUdlPHyKgQ4+L/QeAwfG7i2kyCounZfs
         MBbyQHcXL30w8y3JdY61/LJlJF+foto0SD9gC+ZWMPWRoMmzPeq2OAk0JhNj1LQ7yYZB
         9e7Vekg+QP0tUnoov+DtkPFbEZF8ngnroSNap7yv9Qd1brL0iKQAzeXD5oPztyniAiv/
         e40lr6mQF/IAX3VIphsQgNEj3wzq0WpVJjK4fikT6VWqm+b1P+spgXS+vO9MUrQYvqKz
         jfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOVpiA9bQoklU4o2dljZY43CBbu8RtR1NwpXNWDYasE=;
        b=gsPCTtYWlp8AkSGyDn1W/INWCUUyMAp5CDxd1qLlh+KPrBpPjzCXiTehNscwtG8sKe
         AnOpdsSU5h/JX1nKM40t02f7GcSMlSralrs4lisGqK4+g5bsDeI9vbQOFRAMoIvfO6nJ
         UowDJBZGO4mRgHqPURsa7FNLDzcrN3Wn0LUPAEi8ZONIRuJ/tftSQrL/cEqaxstZ86ew
         kIAL0varR2TqcM56IrwXfg4I7VVBCI1UD/gMBsLaN83qGvHQ28/TjSAkg5iXThMgl351
         c7ZtDt2+pXbQKGUz5dzP8piw7v0DUEsHOV9pcUA0ZTN4IB8jRy54bnh2bDQAmDMss9+8
         r9LA==
X-Gm-Message-State: AO0yUKU+FT+ykhce49J/UBCD5VdLu4UFgtNvCNJ2iOt0ZxZG8WzkSsG9
        o7eSFUWE7HWQ6AIZwwjGIBZejA==
X-Google-Smtp-Source: AK7set9K7KvdCjwK0eDX13Uh3erBqstkIvVypRtzkwfl6qhku2fcQxKP3u+1xFO9t/ej/2+T9sRcAQ==
X-Received: by 2002:a5d:6043:0:b0:2c3:ea78:35be with SMTP id j3-20020a5d6043000000b002c3ea7835bemr2259611wrt.19.1675874986505;
        Wed, 08 Feb 2023 08:49:46 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d4907000000b002c3e306d3eesm9637434wrq.17.2023.02.08.08.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 08:49:46 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: exynos: correct SPI nor compatible in SMDKv310
Date:   Wed,  8 Feb 2023 17:49:41 +0100
Message-Id: <20230208164942.387390-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

SPI NOR flash compatible should come with generic jedec,spi-nor fallback
and proper vendor prefix:

  exynos4210-smdkv310.dtb: /soc/spi@13940000/flash@0: failed to match any schema with compatible: ['w25x80']

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos4210-smdkv310.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index a5dfd7fd49b3..181c99eca675 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -203,7 +203,7 @@ &spi_2 {
 	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "w25x80";
+		compatible = "winbond,w25x80", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <1000000>;
 
-- 
2.34.1

