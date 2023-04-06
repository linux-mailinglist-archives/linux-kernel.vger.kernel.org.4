Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACBA6D94B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbjDFLJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237301AbjDFLJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:09:04 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4ED8A63;
        Thu,  6 Apr 2023 04:09:02 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id k37so50374473lfv.0;
        Thu, 06 Apr 2023 04:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680779340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvGmFR5di2sik7RBLdOP/KeRkjaQDZZlALHIAzFWnQk=;
        b=ao57XiWUibLYquPdos2FQfTnS7PDp4fRz7WDvmBVwry8vdNjEDUiEmAcI7jkqt7Rt/
         tDaLAkBdRAC1WKmzjpeMa1lo11uRzyVgrKMbKLc3JcMj/GkqGnXWjkQC1zFOjKnnECsz
         nVX6aiWTFarnsAAyzTSjFhRmuANSYNGU+kKnAFogS5GqR7VYGwMW1H5CkXMUtCG10nwx
         vF3UsJFDuAHwTYtqCBV6kJYxmTxgod1TED92CBw0UiO4NCMr5xkgnqXLNtmqhoKv1ou/
         YHLSQwUXCD8kMAwxel703A/kfForyNImw+0stN7QzUkhbhmB20FPs/2ldKl8EBgc4AGa
         K52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680779340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvGmFR5di2sik7RBLdOP/KeRkjaQDZZlALHIAzFWnQk=;
        b=E4OzcxqkQtuSYzYkmK7J8B80i/CHuIGklbxMb1k0fHWVuU/Ii7m/l/X2yPvbJbiakw
         Z3BML3k8HKNk9xbauB7O0Rue7UoVgYjSgp95NtwW1FNunQyJQ4KHGJy9Jfty46Ro32Ur
         5rRvTneVr1032DHMiHi4vLf4uxQr2KnIyqTAg/4t+rspCP+v4hRAWlJRvMbqWdl75U2d
         /UgzViUXUKbcou8fnpuW3srDRF6jBZoMKaWLHoI6Ni/dNpZjRiQu8EnBFGaqlm60Yvs+
         YepwvEZXu5iQHbYdclD3JcWI1o9IZvatNd9Ei+A1ELsGXNCHFn79PS5aFnCyBxzwG5sx
         KKfA==
X-Gm-Message-State: AAQBX9dgp2ULH3H8brfuLr1OW7W4vrUmwROLhJ1DeRXGdr5xGT/NLYMN
        3/YQn49H00Uu7wXzHbG8GRQ=
X-Google-Smtp-Source: AKy350YiEAMb49gHFQPlKUUaEKEJ1rx2G2QINX9BCYS+LCn/wRFkt+q9Q5JA8ZUFCb2sccpQIKjouw==
X-Received: by 2002:ac2:4910:0:b0:4eb:ddb:d03f with SMTP id n16-20020ac24910000000b004eb0ddbd03fmr2268881lfi.62.1680779340223;
        Thu, 06 Apr 2023 04:09:00 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id r26-20020ac252ba000000b004e048852377sm218667lfm.263.2023.04.06.04.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 04:08:59 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 3/3] ARM: dts: BCM5301X: Specify WAN port MAC address for Luxul XWR-3150
Date:   Thu,  6 Apr 2023 13:08:04 +0200
Message-Id: <20230406110804.12024-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406110804.12024-1-zajec5@gmail.com>
References: <20230406110804.12024-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

It needs to be calculated based on the base Ethernet interface one.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
This PATCH is a proof of concept that can go separately through the ARM
DT tree. I'd actually suggest that. There are more .dts files I'll want
to update.
Srini: can you just take the first 2 patches from this series?
---
 arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts b/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts
index 60a2c441d5bd..2dd05f4dce92 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts
@@ -27,6 +27,7 @@ nvram@1eff0000 {
 		reg = <0x1eff0000 0x10000>;
 
 		et0macaddr: et0macaddr {
+			#nvmem-cell-cells = <1>;
 		};
 	};
 
@@ -76,7 +77,7 @@ button-restart {
 };
 
 &gmac0 {
-	nvmem-cells = <&et0macaddr>;
+	nvmem-cells = <&et0macaddr 0>;
 	nvmem-cell-names = "mac-address";
 };
 
@@ -119,6 +120,8 @@ port@3 {
 		port@4 {
 			reg = <4>;
 			label = "wan";
+			nvmem-cells = <&et0macaddr 5>;
+			nvmem-cell-names = "mac-address";
 		};
 
 		port@5 {
-- 
2.34.1

