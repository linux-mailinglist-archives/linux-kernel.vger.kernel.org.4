Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F028C6905EC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjBIK73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBIK7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:59:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF8FB46F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 02:58:52 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j25so1354302wrc.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 02:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqyCPgVLwr/SMq8TuN0141mNn36IMKTzmD9m9yiTvNc=;
        b=fA3Jvt2bYKWJ7esxt2t/Bo3yI38SKiWE7LAJlanQzF79L666FMJQix/t+LsEqsNGlS
         HTMlbITLH5cF8YZYpcP707M8gTq337sMZc52HP4mURLTGxW2g9KHbpqlUlZX1ocacNN9
         i4M0gXNqr5ikGf1vOTF/INyqycnxYa7OWDPvSYXsawer5gJmN+N+YBNWTSb1GY/FR83F
         V/d1icJ5kihlSjGETHgDOl0ryWAgiPIAMQ9UQzcZJcQN7glXWM4IOqFofX924eYo9qwb
         TuU+OVVB8HcWePNmo3kE9qiuudkKkBe4TQ+010xk0+ad+ORniEjOfbyrBdy4KZSlBHUP
         n14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqyCPgVLwr/SMq8TuN0141mNn36IMKTzmD9m9yiTvNc=;
        b=3g35vPZLvpVSGyINko0VAdPE0Wl8o6xBGN8Ju3Z+KHWLLd+Okv6a9NnLwyjjriA0yU
         qQM7CbR1tyrx+SQDyuisQx/Alq6LSjUe8NcisLPMA/UK18CqlJYnXIO4TZ7iIgI02hMx
         JjQiE+j0dFgwdF7kLcmMBbdxdcbGtqtRYTPuWBv0zxxHrZMRAHdXMfsDaOcmUzU5Ie5J
         g281cd3UGIxov9YDqhC5pGO+/0Yek8WvPE2BfcS0lrkHoCgsaH5g5wsIP+2yIoVyJT7G
         gYRW6Fd9VPB8gcSx15OB1XjLvSCbXSzc2UMlIRuHPiwguYIa1Wja1KLhXaBQm5CDzcoe
         g/JA==
X-Gm-Message-State: AO0yUKU0y7GKalyQIPMuM2sAc2dCTGUX46quMlfXye9g+86z2+dnVD4r
        1azGYhFiMA1FFBvuIELsEfI5mQ==
X-Google-Smtp-Source: AK7set8AkDnBCYmDcO6b3+VQdgZz3RfH1PnwGDouui/n0lah+W4ABazpObkRkPUukQpoD5bEZTKQLg==
X-Received: by 2002:a5d:6842:0:b0:2bf:ae1e:84d2 with SMTP id o2-20020a5d6842000000b002bfae1e84d2mr9990867wrw.12.1675940329234;
        Thu, 09 Feb 2023 02:58:49 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d6987000000b002be063f6820sm927987wru.81.2023.02.09.02.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 02:58:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Lukasz Majewski <l.majewski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 2/6] ARM: dts: exynos: correct TMU phandle in Exynos4210
Date:   Thu,  9 Feb 2023 11:58:37 +0100
Message-Id: <20230209105841.779596-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209105841.779596-1-krzysztof.kozlowski@linaro.org>
References: <20230209105841.779596-1-krzysztof.kozlowski@linaro.org>
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

TMU node uses 0 as thermal-sensor-cells, thus thermal zone referencing
it must not have an argument to phandle.  Since thermal-sensors property is
already defined in included exynos4-cpu-thermal.dtsi, drop it from
exynos4210.dtsi to fix the error and remoev redundancy.

Fixes: 9843a2236003 ("ARM: dts: Provide dt bindings identical for Exynos TMU")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos4210.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 5a1ec714c612..0e27c3375e2e 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -393,7 +393,6 @@ &cpu_alert2 {
 &cpu_thermal {
 	polling-delay-passive = <0>;
 	polling-delay = <0>;
-	thermal-sensors = <&tmu 0>;
 };
 
 &gic {
-- 
2.34.1

