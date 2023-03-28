Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7F06CBBE6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjC1KIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjC1KIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:08:04 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E407A93
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:07:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j11so15032050lfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679998050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWHba6Uu0Ek+kYjlRBQm3S5zfLvA96w4h84b04kVQ3w=;
        b=gmEA9eVDLVEuSqY30iZ244dRPsGlbiyB2DELO2i4s5GtSoDMUM9hV+PSHoPzWy5SxJ
         g0RX4lC/YKWIHmAdN8RM3L0vVy5D+vLeinmSa2x24NM9NJ212Ta8hkX9GMvCyYuoyM1d
         DMivUm02j3CSGcX+2HDicI7kbDXNi39vCbYdSvY+DiDRyRjO9xqBmDXklc5N+qmLQVyk
         oG6icfSSoW2HuxANWejAi+MAj77T8TZBKRaqfvRVbgUhkfhP/+rUoxVomddaez/EsA0r
         VAL+fGHgaGPAVA92cIcy06G5vIqXzSsTmw8fxXk533Bttky56f6uL+bRsNS3TQ3uq/3/
         +/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679998050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWHba6Uu0Ek+kYjlRBQm3S5zfLvA96w4h84b04kVQ3w=;
        b=CNl7JZlxZljCXFzzavo71HEC5xyZQUKwg5DuvavAoApJIY277e9aLPVfjMAviVOvYg
         E+J6hw+709qpQuJVUCovOXzXvp6P+nuIElx4/2FX9a75lJSXLqjcKf1oKqGHfe4rxGEc
         n4treJUBOX5pAf4+1PLcekHKUKd8Mg0OjaqHc8BrUfnVKnOK6SVjkunlqtB64pF9gb0p
         SLs4r7hO47rH71M+3TUN5ToAFrmvyz3zMQP1Yk5HlJASTqh1iXYO598YPCJooIV32WqZ
         6s+AMZxtxM9jxL9I1+MH+ErhBE6BI9rVdChxKHTjRuRuO+3eYPkwzjiQYXWt1CfMdstK
         asjQ==
X-Gm-Message-State: AAQBX9ey4Nar0bYGS6QR2tlE4nNXg5a52pWJJdYBBOpIA/23vwRu9rDJ
        Ey0TVh1xPB4bmbbPIQjKi2NZ1w==
X-Google-Smtp-Source: AKy350ZtrujPPVXU4pT+yrqtYxfFvHNujl2xHI00jKUIXRYA9J1Z/6lIUWJ6l23l4tHUvBkykVs6YA==
X-Received: by 2002:ac2:4434:0:b0:4eb:dd2:f3d2 with SMTP id w20-20020ac24434000000b004eb0dd2f3d2mr2271129lfl.43.1679998050106;
        Tue, 28 Mar 2023 03:07:30 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651203c900b004db2ac3a522sm5039572lfp.62.2023.03.28.03.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 03:07:29 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     nicolas.ferre@microchip.com, claudiu.beznea@microchip.com
Cc:     alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 3/4] ARM: dts: at91: sama5d2_icp: Set sst26vf064b SPI NOR flash at its maximum frequency
Date:   Tue, 28 Mar 2023 10:07:22 +0000
Message-Id: <20230328100723.1593864-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230328100723.1593864-1-tudor.ambarus@linaro.org>
References: <20230328100723.1593864-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

sama5d2_icp populates an sst26vf064b SPI NOR flash. Its maximum operating
frequency for 2.7-3.6V is 104 MHz. As the flash is operated at 3.3V,
increase its maximum supported frequency to 104MHz. The increasing of the
spi-max-frequency value requires the setting of the
"CE# Not Active Hold Time", thus set the spi-cs-setup-ns to a value of 7.

The sst26vf064b datasheet specifies just a minimum value for the
"CE# Not Active Hold Time" and it advertises it to 5 ns. There's no
maximum time specified. I determined experimentally that 5 ns for the
spi-cs-setup-ns is not enough when the flash is operated close to its
maximum frequency and tests showed that 7 ns is just fine, so set the
spi-cs-setup-ns dt property to 7.

With the increase of frequency the reads are now faster with ~37%.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_icp.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at91-sama5d2_icp.dts
index 1346b8f2b259..999adeca6f33 100644
--- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
@@ -669,7 +669,8 @@ flash@0 {
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <80000000>;
+		spi-max-frequency = <104000000>;
+		spi-cs-setup-ns = <7>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		m25p,fast-read;
-- 
2.40.0.348.gf938b09366-goog

