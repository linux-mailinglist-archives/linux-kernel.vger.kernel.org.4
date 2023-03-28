Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7AA6CBC58
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjC1KPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjC1KP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:15:29 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D17B619E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:15:22 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j11so15055989lfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679998521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X88qJMuybuDG/DdfVsPonRD1rXJpjEmcdOesR2x9t6U=;
        b=AB9I7MC3E6mjUudJSg6hpMMurrZH02ci4PI4lN6vJxwsKh5y0zjuwyFOOLLGhLXWTS
         84yPQ0fQX9XB/yp57zsxYhrDMwFOfubjwtwqSlm3nLDPiZ5FUx6r50LqpwQgrFEWRrQr
         kib7QI1r/+rdGF/m/sxCf7c0TTzUc80Sj3CWwrVr3oIyFTmz7t2qIc16ChsFY36XsQfC
         x4hZUkTJN8X9MHMpCs4RrlzPWwufFL7GQWSybYyyCejiYguQroPGvYHCeBVweKWgq3zW
         O6JQ5YIMhNP6KHro1vsALFLjFg9SV4NnCbsAS9WM7hjmkfzb+zQ9vbesGDEEbqEqCHfI
         BwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679998521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X88qJMuybuDG/DdfVsPonRD1rXJpjEmcdOesR2x9t6U=;
        b=bfy8wi6ucMsbZDmt3nfuqFHKXEZZm1yITzjBjRdsZsEZ9GCU1Jaw+KTwOpg45vEN8T
         QROmPpvwPUE8L/ncskBzThr+4wJeag9CEgIhT51T9S9+tOrgUSJOoyg2gEAT05jhXato
         ndpd9xrFJnU4IO7zvPNef2JfHpbsHd0ASCJSPnORzveRLVHkp0UtCqusXy1s48BG/tB0
         JJTKc2SqLE3uGxCEOxqsyvLnEl+guGZ5/n1dFBC+S/I2OpI5ETCAU9E+cOXG0OjlkcPA
         xvFUlMLomN1wFek0Z68i6VQVpoMtjWS1W55OLhBfJOB94Cl1nKUuYV/JbH/TLhsMvDU2
         W8Og==
X-Gm-Message-State: AAQBX9eUtjDY0Hld1N8YQSBP33FdpMbap8ofb55SFWg5lDP8SzHYJxY/
        hSZtEVSUAtMZaC6mG8HjUM5AOw==
X-Google-Smtp-Source: AKy350aT0sNUpbJxDY33ty2a86va5X5lR74uqhOp1UWtl1kecGv+30GwCQ+ZPJ0mxl++EaduDVyf4w==
X-Received: by 2002:ac2:4f8c:0:b0:4dd:ad4b:efd with SMTP id z12-20020ac24f8c000000b004ddad4b0efdmr4975999lfs.52.1679998521030;
        Tue, 28 Mar 2023 03:15:21 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id o25-20020ac24959000000b004e84d64ab51sm5061405lfi.58.2023.03.28.03.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 03:15:20 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     nicolas.ferre@microchip.com, claudiu.beznea@microchip.com
Cc:     alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tudor.ambarus@linaro.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 1/4] ARM: dts: at91-sama5d27_wlsom1: Set sst26vf064b SPI NOR flash at its maximum frequency
Date:   Tue, 28 Mar 2023 10:15:14 +0000
Message-Id: <20230328101517.1595738-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230328101517.1595738-1-tudor.ambarus@linaro.org>
References: <20230328101517.1595738-1-tudor.ambarus@linaro.org>
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

sama5d27-wlsom1 populates an sst26vf064b SPI NOR flash. Its maximum
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

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
index 83bcf9fe0152..4617805c7748 100644
--- a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
@@ -220,7 +220,8 @@ qspi1_flash: flash@0 {
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <80000000>;
+		spi-max-frequency = <104000000>;
+		spi-cs-setup-ns = <7>;
 		spi-rx-bus-width = <4>;
 		spi-tx-bus-width = <4>;
 		m25p,fast-read;
-- 
2.40.0.348.gf938b09366-goog

