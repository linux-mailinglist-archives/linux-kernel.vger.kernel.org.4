Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0642063D7A0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiK3OGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiK3OGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:06:19 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462825B87A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:06:18 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id y16so7503191wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newflow-co-uk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FS/5LEGLs22k9BmiIQdsJAlL0wF9ROsh2ANGCIE2GiM=;
        b=FTwSnQQsQoXK7Zp7fZZK1TSre3vHCjetsbJko+RbwZ+sXHHRzCqAyUyJNTFo45Xsse
         YCAXoD/4Niw2d71spQEH4mHciYnOFfp+YlpKU240mR2StFGJrzICMo0sBPO1nCOXvOik
         ODd1QZFBfN1H3iBG1YYHcN2zaaaNvwY8RebKWhGAOLIJ9TNcrROrm4UBtybA7Hex9WTF
         xXalW7ry/RAXmBuTOiIywYFM5ORubNxHfRo+683WcPF9SRruNM2bN0Yum4+hWNdgGYIG
         uC2FjEAk1zq0K9IPsHB5PqJ6gODdVQzRqpg34HZ6NBSOmAg8jOAouwuZrios23IrYBvi
         l6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FS/5LEGLs22k9BmiIQdsJAlL0wF9ROsh2ANGCIE2GiM=;
        b=Hu9T2TikB/uRWpmBzMUH17Fk2Nf6AR42HjLT0GbQe6OCz1qNqX9R49AesnKJEKsW4Y
         DaPhy2IDmCJBzZ4vjlkbyHU9ihDatHTWlBBsyYSCrntEY8fImHoHj3aFdTLnQBMnt32M
         dHjIuWPInDOb5vfCBh8m7DgDkA3D8/7fB9N+q2B/T/C/SvNOHbdl2+NRU+wWIcbNJRNH
         bxCnlgXh13sbV3SkhNsDExiB7vKp1VnYc1yxNYcGhpPoKYmNjsRm95lajchM7c9c6V6N
         OGYulus/BbU/VqudlS9Ghnnp+V89CNkm7YyENH1E6ZQBy6oSLtM9iMV1XpEhAbg/9tpG
         sZGg==
X-Gm-Message-State: ANoB5pnPACOmaBAofuT8ytpZvgGSz8i+FCgB2H54xcI/WOzXAauydOuk
        ramkig/tGvMjTJeXtCP4PDSuXw==
X-Google-Smtp-Source: AA0mqf5R/G3UZPMgxCqt17NYN7XNS+SHe47tJfswingJtr2K8Y//kYWA5tErnqvCt2h+rdj18PFqng==
X-Received: by 2002:a05:6000:60c:b0:242:10ac:6ab2 with SMTP id bn12-20020a056000060c00b0024210ac6ab2mr11725807wrb.552.1669817176846;
        Wed, 30 Nov 2022 06:06:16 -0800 (PST)
Received: from mpfj-unity.. ([94.12.112.226])
        by smtp.gmail.com with ESMTPSA id v128-20020a1cac86000000b003cfa80443a0sm2062542wme.35.2022.11.30.06.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 06:06:16 -0800 (PST)
From:   Mark Jackson <mpfj@newflow.co.uk>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Mark Jackson <mpfj@newflow.co.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND 3/5] ARM: dts: am335x-nano: Enable I2C temperature sensor
Date:   Wed, 30 Nov 2022 14:05:45 +0000
Message-Id: <20221130140547.295859-4-mpfj@newflow.co.uk>
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

The NanoBone platform supports a temperature sensor on the I2C bus.

Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
---
 arch/arm/boot/dts/am335x-nano.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am335x-nano.dts
index cecc2afaeff4..960ef1384bbe 100644
--- a/arch/arm/boot/dts/am335x-nano.dts
+++ b/arch/arm/boot/dts/am335x-nano.dts
@@ -230,6 +230,11 @@ tps: tps@24 {
 		reg = <0x24>;
 	};
 
+	temperature-sensor@48 {
+		compatible = "lm75";
+		reg = <0x48>;
+	};
+
 	eeprom@53 {
 		compatible = "microchip,24c02", "atmel,24c02";
 		reg = <0x53>;
-- 
2.34.1

