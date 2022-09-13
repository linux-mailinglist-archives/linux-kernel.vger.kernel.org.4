Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAAF5B6CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiIMMOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiIMMOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:14:38 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6100AE73
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 05:14:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso8536603wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 05:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=TEgAz8TyTEUxFcTpNCv4lGZ7t5+w4UkFWYn6r6UPn6c=;
        b=YQciprlspECMqMacKKL+UoZsYMvy+wwP5FIdzqTDnrp7KrCIxkAGKWgRypAgcImwdq
         2zAHE6pnAIJvNJOiOJExV9H37yto1L25hZl6aAJFVJl9vlQeKUyGEKzArmLmwWW5jj/v
         AhCC7+agmScn3zm8awnWHu5nE5IAdOrTOUhCBr3C2JCk56DzVokAZGv74dxwFlNnhR5H
         9VsgBtyWTCyosDk6H+8d1I73pRXkZtKZwuY9PgMEr8hOs0kI7h+ZmBoBYG4hBiqSAUAS
         tcPPusQ2dd6hRGQiyibNPwYciz6yQQvLB0c2Y3ASHzsVQK8U/S+ZpUXj/r2V2mLMk1l0
         0gnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TEgAz8TyTEUxFcTpNCv4lGZ7t5+w4UkFWYn6r6UPn6c=;
        b=yRURHyEiyacOK2h7FkohVx9hBAcjpN4GTbzOm2kQ0mPAP0Qzb0zo/etW8fW3kCDJR1
         pj8yzLpPoJdfGBUwkixk7C+adfyjI4NhviUbCQGrAtB9dLpW1EE1s8iUst3JO5u1E+29
         R3Le8ZZs1ClnbdKNtDG4SaTjhOZveo8LdQQZAVwoTpf7D4wVOP9NBahLwLmkmIOoA/RP
         oCwSRMQ3fu8HMCNXt273mpsUfdINDQn2s98tiDZsQ68HmZC7y6E3f0DkUmTGNEV6dyM9
         0UGf5KAcBG5SUNhQM8Fgz3XLwvODbDhP525WGpIlvQMldCJfaMhtY0vUs2CRh2H6JWRX
         6LxQ==
X-Gm-Message-State: ACgBeo2iCm4LGBiCPVJXKsqGdH5cbnThnFRatJTv8gQQAZylEqgCQxtl
        N8hkfUPmYksqNn7S3LGrHA2aXA==
X-Google-Smtp-Source: AA6agR4CVpKz1Ub948TsXfSmQ+yeimOI33JVqs/kaXCDqOGwh4T3ZgWHyePnglOogaXVI0HW/ZYMMA==
X-Received: by 2002:a05:600c:384f:b0:3a6:603c:4338 with SMTP id s15-20020a05600c384f00b003a6603c4338mr2212671wmr.192.1663071272948;
        Tue, 13 Sep 2022 05:14:32 -0700 (PDT)
Received: from localhost.localdomain (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id p10-20020adf9d8a000000b00228634628f1sm10512230wre.110.2022.09.13.05.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 05:14:32 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, lee.jones@linaro.org, tony@atomide.com
Cc:     afd@ti.com, khilman@baylibre.com, narmstrong@baylibre.com,
        msp@baylibre.com, j-keerthy@ti.com, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v5 3/6] DONOTMERGE: arm64: dts: ti: k3-am642-sk: Enable tps65219 power-button
Date:   Tue, 13 Sep 2022 14:14:16 +0200
Message-Id: <20220913121419.15420-4-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913121419.15420-1-jneanne@baylibre.com>
References: <20220913121419.15420-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This board uses the pin as a power-button, enable it.

Needed for driver testing but official board support pending.
TI commitment is required before board upstream kick-off.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 1f7ce60ecb57..238798ea6a79 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -362,6 +362,7 @@
 		pinctrl-0 = <&pmic_irq_pins_default>;
 		interrupt-parent = <&gic500>;
 		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+		ti,power-button;
 
 		buck1-supply = <&vcc_3v3_sys>;
 		buck2-supply = <&vcc_3v3_sys>;
-- 
2.17.1

