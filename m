Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29084622FC0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiKIQJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiKIQJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:09:24 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50488220E3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:09:23 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id z14so26485509wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 08:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newflow-co-uk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQX/z0Y84XYNMSAACNl+rS33XaUw6j8xDZvxptKeil4=;
        b=L7D6YyDZ0MHtIQ+EDbTTj4jYmcZjGVoSIBZc+gvwub7Ftfg6CgOO79X23AKCMWZJU7
         8qnXePWDD1btaK4k166zgi/jENxXTRjggDVG4P08Jy/tV+ZFIe2VfpcGee1yeZbAKoKq
         I4TtIV8wSp6+F5YAsU9Ff7hd056JlFc3qURb3nifPQvCpK3yI0GobIIdTY2LyYp5nM8z
         Mfvv2jbRVE5uFAhqzANI9IGtxNg2/UgNjHLo4xZoUHCNiVbdlOW2SJqDvyVy6Sxnj/UG
         0V04RXbKwq1kedTsAgQI5XaeqqrKZCJW01mPZ/86yDzn/8ZbrkVKzyJAaQ02eNZBida6
         /PYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQX/z0Y84XYNMSAACNl+rS33XaUw6j8xDZvxptKeil4=;
        b=KrA1sxoiSMt2qNLA9PT3ZXA/GqSdCauVp2O/1dYvNsJv2CfHTjDA1EAVSOBvEFZWEO
         Qi4ysr4Dyca/xiMx+MYAFRKOY7o1B+pkRczphJhFc6SNda32mgHF7/N3f818erPY905v
         16if4eksGiIjTIzB6JaE/ysUY2dlQd9n/ZGuop0gNSF6rxi5fIbSIPLktvFT0CaVAvkw
         OjebQ+DB+FT1RasJpkzKKE5gmPc6uh+gpm/Cn3390AaaSh9az81WkagyudAfFe3aHeYc
         AT4OhjPC6lq9FkVLjDqegI3kEIpAf5hOmSu9XnyZozT7WkczJmS5e9cCpBSHiunx1FL+
         8HZQ==
X-Gm-Message-State: ACrzQf0xIDtpthGaPS0RuJzgyeF7zjYRAoIc6Rcbx6vO/Iv9fAsv7uwe
        v5D0s5ejIPFevMnsrSJTnCm4esjgJZnRUT4PW40=
X-Google-Smtp-Source: AMsMyM4gnHex2vkxMUDXbBTqNPq0ESTI+JIdEzzd3xRI6t+rc8oybYWBcCBfr7h6wISdNMwX9qaAOg==
X-Received: by 2002:adf:d84b:0:b0:236:e0da:61b7 with SMTP id k11-20020adfd84b000000b00236e0da61b7mr30671488wrl.79.1668010161881;
        Wed, 09 Nov 2022 08:09:21 -0800 (PST)
Received: from mpfj-unity.. ([94.12.112.226])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d6604000000b002366fb99cdasm13307772wru.50.2022.11.09.08.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 08:09:21 -0800 (PST)
From:   Mark Jackson <mpfj@newflow.co.uk>
To:     Mark Jackson <mpfj@newflow.co.uk>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ARM: dts: nanobone: Fix GPIO settings for MMC pins
Date:   Wed,  9 Nov 2022 16:09:03 +0000
Message-Id: <20221109160904.183147-5-mpfj@newflow.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109160904.183147-1-mpfj@newflow.co.uk>
References: <20221109160904.183147-1-mpfj@newflow.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 2be831927af6..728164298a5e 100644
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

