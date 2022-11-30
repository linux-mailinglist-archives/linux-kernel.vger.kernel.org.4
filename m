Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5276563D7A1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiK3OGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiK3OGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:06:20 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B80A421BD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:06:19 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id f18so5188761wrj.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newflow-co-uk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YmPa+knot3YDUCqalKlJVkyrJNSYU8WAPL5glC3+iuk=;
        b=tBrTWpUni2WldZziqoWqCnmX+s7fB0Z+i7/GE8YtjEhzoiSWa9n9JxRiUSbcCCCt9L
         R6j4738fB4o8UR1CND0nQzO9ZNt7Zl0BBfKbuASfuFqbpDzojBRj+0hASWAjxMT1tkVD
         Vab1GXjRzjnS7Pcfc/4jvPyYvQY2DcWRklCJGwzfgLWFrK0ZBv3yOtTSHnubCh2dw5/6
         RZKTo/KO9itmj0tqxi0cY1ZrHgPMQv4+oJIsa833/skTlBSiV5wYE/dbQyWoyZxEn1/2
         NzXQSr+RSTuOd1nBgDK4zQOBrmGDwyZF7BzV7pYSg1hicHjS51/mI/ZaohS6sqwsG3rS
         W5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmPa+knot3YDUCqalKlJVkyrJNSYU8WAPL5glC3+iuk=;
        b=M/9/8HqJnz2JvKdIfeUgF8cXIdvNp2L3e9LJdqe4QBpIhtT6J4veXfzBLkeEEm5AUH
         ZxnOkzKyG6WTbQhiEuZml52/73X3qXemwmOtubVfSVnvwrCcQHOwoXYARCKIPVAbswYL
         J6qZDrOW8/gYdHvFxeoJSrUnfuWh2KNYyGq1g59bU0I6ZPtSsp+MyThtXAj3xnXli6be
         ARkHPS+eq63Pxryi6vxZeyPkc/myC0syggpy2QyOvwCtgAjFRzNSq7Odg/7PFkTzQGXP
         juVfBqSUFNVJPQEuy9jJO5MEoOvFdxkdHeWcS5dtqD9AU5WPpu38Y7PvgbFZBccutkMz
         T0Yg==
X-Gm-Message-State: ANoB5pnsvGweP5Y1stZnunIOrAtuCIKUqbVqrX9m3Qnh+ZjDpWknLSEN
        hnhOD3KBVtGBFuL4YFSOMUMKRQ==
X-Google-Smtp-Source: AA0mqf5XOIYaklTWEnWoa4T3BjTjSzwtUZIRVFVfQhZEvXrHRfHwxemA3QGt13z94tChsEPLGvKvfw==
X-Received: by 2002:a05:6000:181:b0:241:c6f9:3e5a with SMTP id p1-20020a056000018100b00241c6f93e5amr29041409wrx.157.1669817177933;
        Wed, 30 Nov 2022 06:06:17 -0800 (PST)
Received: from mpfj-unity.. ([94.12.112.226])
        by smtp.gmail.com with ESMTPSA id v128-20020a1cac86000000b003cfa80443a0sm2062542wme.35.2022.11.30.06.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 06:06:17 -0800 (PST)
From:   Mark Jackson <mpfj@newflow.co.uk>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Mark Jackson <mpfj@newflow.co.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND 4/5] ARM: dts: am335x-nano: Fix GPIO settings for MMC pins
Date:   Wed, 30 Nov 2022 14:05:46 +0000
Message-Id: <20221130140547.295859-5-mpfj@newflow.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221130140547.295859-1-mpfj@newflow.co.uk>
References: <20221130140547.295859-1-mpfj@newflow.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MMC slot uses GPIO pins for Write Protext and Card Detect.
Define these so everything works correctly.

Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
---
 arch/arm/boot/dts/am335x-nano.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am335x-nano.dts
index 960ef1384bbe..58062cec39c0 100644
--- a/arch/arm/boot/dts/am335x-nano.dts
+++ b/arch/arm/boot/dts/am335x-nano.dts
@@ -418,8 +418,9 @@ &mmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	bus-width = <4>;
-	cd-gpios = <&gpio3 8 0>;
-	wp-gpios = <&gpio3 18 0>;
+	cd-debounce-delay-ms = <5>;
+	cd-gpios = <&gpio3 8 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio3 18 GPIO_ACTIVE_HIGH>;
 };
 
 #include "tps65217.dtsi"
-- 
2.34.1

