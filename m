Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7F96CBBE5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjC1KIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjC1KIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:08:02 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B1D65B0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:07:34 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id br6so15035253lfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679998049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrY1OuDR/+qlCoUvp7xD7ZWzVOeNYJFtAbaI7JDwTWM=;
        b=hAAal796U+HxnwWZF/jbseBG2s/J6J6okTwD6RMngnFNxbPF0DsSb8oeNgsAerlpW3
         JtINISEkpC+k003xcvTYpBjP1OMQ3+P+RQI90SUJBJmDOfd6dGCMZIEbRIHh4QoKa8rL
         p7/1MZ0o5jRVz0unDAXst3BPondXBd7VIRLVHXz4UYdIZLkCey1xsZtZjVH39vb0AS7N
         vfPrd5FhdOKv8Ig4Dy3lfBEOYVQUYvhQOEomu4GiX3WVT+cugSf7ZEuPK9+16xwLUZOw
         IZdrRSIxpkNCnMd72yU4lgZanRw+9oubgeA+Gaw68eTPDNtxD9STdWKh1tQ6sEuYKawV
         SA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679998049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrY1OuDR/+qlCoUvp7xD7ZWzVOeNYJFtAbaI7JDwTWM=;
        b=oMuvcTOwvT5w022zIiy3P4JIMyhHcstMtSA9MISt699H7tJD4tdkqRq1F+1aYRgKBn
         8OwRp3a8QtGLHE04AqBKFqspsDkC5Ffi4gTASntraDldB3gQEcMf2wOQdY5K9Vtpj3gN
         t9nxmCWS5flSEQN64asHA1mEA0QvBkTgnsUmrHntig8FpnFaXgIoTGgQv/iiin1AFpIP
         BoEmFUwvWvV6lFW5ZH/SFcitnfKoyzYWHe1jHUciRVq8XeyZXca0Fe4MVzug3AI4wjbs
         1DH3EDO1Nv6rS7jTogCUTKNYzHvtsXL6PzWMGBUbg5brPNj03BMTX42oEvT3aMa+9gPC
         NgQA==
X-Gm-Message-State: AAQBX9cpd+4BD1wIYf7mGDETCBzA6SeAhcxCxBKHzP3ybM5E4OQJFsiC
        jSeozMxmZzMT1ygP5IXbvpjv5A==
X-Google-Smtp-Source: AKy350ZsZw5YeU9rZZh2ZArIM673HB9SUzeWWISkt7rVHV+uwIedYI2WgTUkMLtoUghFlPgLUBKaeQ==
X-Received: by 2002:ac2:52af:0:b0:4dd:b766:37ae with SMTP id r15-20020ac252af000000b004ddb76637aemr4088978lfm.13.1679998049213;
        Tue, 28 Mar 2023 03:07:29 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651203c900b004db2ac3a522sm5039572lfp.62.2023.03.28.03.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 03:07:28 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     nicolas.ferre@microchip.com, claudiu.beznea@microchip.com
Cc:     alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 2/4] ARM: dts: at91-sama5d27_som1: Set sst26vf064b SPI NOR flash at its maximum frequency
Date:   Tue, 28 Mar 2023 10:07:21 +0000
Message-Id: <20230328100723.1593864-3-tudor.ambarus@linaro.org>
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

sama5d27-som1 populates an sst26vf064b SPI NOR flash. Its maximum
operating frequency for 2.7-3.6V is 104 MHz. As the flash is operated
at 3.3V, increase its maximum supported frequency to 104MHz. The
increasing of the spi-max-frequency value requires the setting of the
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
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
index 8aa9e8dea337..95ecb7d040a8 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
@@ -43,7 +43,8 @@ flash@0 {
 					#size-cells = <1>;
 					compatible = "jedec,spi-nor";
 					reg = <0>;
-					spi-max-frequency = <80000000>;
+					spi-max-frequency = <104000000>;
+					spi-cs-setup-ns = <7>;
 					spi-tx-bus-width = <4>;
 					spi-rx-bus-width = <4>;
 					m25p,fast-read;
-- 
2.40.0.348.gf938b09366-goog

