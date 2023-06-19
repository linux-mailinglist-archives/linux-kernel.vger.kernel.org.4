Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89282735B4D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjFSPni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjFSPng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:43:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5AF83;
        Mon, 19 Jun 2023 08:43:35 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f85966b0f2so4031482e87.3;
        Mon, 19 Jun 2023 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687189413; x=1689781413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=By9LviJpFD6M31Xuvf8iRdC/f7qq5558NMtCfn3H0qE=;
        b=IsdcirYiybQ9DgqSQax5rr1IUuYvwIv8sXacQA3PptD5vmSsVvVnua0Yyw0/pIB3E1
         /+5dbWfz5ouAnktDaYJhrRkNVW6mWTnZ7rw8UomJq8jQwTJUjodwJ3XOvnbyQAkM1Hwv
         w6H1RvNeuFcs5lsSFjnaTXW1BVUcG5+BaDtiw2r4UBqeGQtKbevlf9sPYWMGcYmx88mg
         Zfw80n71GUExELHO8yISSdiI61YS+seyOJgr0EgA3yXTwqsjADWuyw0VI3an+rmKSbAE
         aIqCU925PykndGkDQm1Ojm0o/6vQmeXBlc/jSmpYVEUmL6LiC3po0OP19K6Npx/UM9RS
         o0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687189413; x=1689781413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=By9LviJpFD6M31Xuvf8iRdC/f7qq5558NMtCfn3H0qE=;
        b=l7wo1aearfDmCLBH6o/uTJa6Fgk972dEb7EpNYQRGI0FfHqk/f3Uc1TbtsqQrXc8UW
         aes7/m2PYAtil+NBmhltcPYW+JX7H5rjgmEaKTjQM/xmu4dUs2PluaZgTPe1m0rrywAH
         iBNQRd4CJW6SwE/h+k7HwRIH2Sc2QV01MsqixrIfMUY0ZnALRlsLFTq4eV7JrUIkBFEr
         9Cummu52ySIYqIvsIIiIJYUBT1FHC63xZqFrnrxWUi96enAnxWkl3hzZzYJcTR0gSv2t
         54R6RWSxqB7mwKnJ4TteS3lB9lG7XRZsz1Vy5HyYUKDSwWRMZSnDFkigXgk3WFVrpw3H
         ZDfg==
X-Gm-Message-State: AC+VfDxWUnJCJkAZnpuzBHuZCsGIHFnIP5eZc9S6dMbOMJ2aFgQJCTAg
        gPAPg0URfl96tNvtXXNW5wnvqcBJGl4nkUXS
X-Google-Smtp-Source: ACHHUZ7SZr0BfAlnP0I+J+Ztm3YUYwpYJ5m1CVqsbJXoe5r6Dql+Pd7bzmdwb6JD3xJgMILfAb2W3w==
X-Received: by 2002:a19:f201:0:b0:4f4:dd51:aec7 with SMTP id q1-20020a19f201000000b004f4dd51aec7mr4719115lfh.54.1687189412587;
        Mon, 19 Jun 2023 08:43:32 -0700 (PDT)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id f11-20020a19ae0b000000b004f85e53250bsm1207144lfc.191.2023.06.19.08.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:43:32 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v8 1/4] iio: adc: Kconfig change description for Allwinner GPADC
Date:   Mon, 19 Jun 2023 18:42:24 +0300
Message-Id: <20230619154252.3951913-2-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230619154252.3951913-1-bigunclemax@gmail.com>
References: <20230619154252.3951913-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SoCs names to Allwinner GPADC description to
make it more informative.

Fixes: d1caa9905538 ("iio: adc: add support for Allwinner SoCs ADC")
Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index eb2b09ef5d5b..d93868684c7b 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1105,7 +1105,7 @@ config STMPE_ADC
 	  built-in ADC block (stmpe811).
 
 config SUN4I_GPADC
-	tristate "Support for the Allwinner SoCs GPADC"
+	tristate "Allwinner A10/A13/A31 and similar GPADCs driver"
 	depends on IIO
 	depends on MFD_SUN4I_GPADC || MACH_SUN8I
 	depends on THERMAL || !THERMAL_OF
-- 
2.39.2

