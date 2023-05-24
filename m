Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A675870F0A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240113AbjEXI2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbjEXI17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:27:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FDA12B;
        Wed, 24 May 2023 01:27:58 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f3a873476bso538719e87.1;
        Wed, 24 May 2023 01:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684916876; x=1687508876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yqn5qRBwLcinfNxv6VW9L+IL+2b4SfMx1zWHSgO399s=;
        b=k37Hh7n14UGVGV4NE3zQCYH3l1evQJSVPVb/+G9Fq3cASkwC273FAbYkuSHoClOScS
         yA70k8n8prh1aJmXgtbPAM6tF5BCuA2Y08lsRsHprvLhRH/1coP0RHOdcNoJFQ6XHFCB
         hrgsGRMXtTVQ2JLzKF1XZr7d4E9DL80Lz+afMRbfEv0wvO7NxfPAMu5iSn/3irBjhGbj
         eydEcIzBH1K33G9q2oya4vzq2Q597lx/luBgn80hMPlge5F5MvFydT7TjoCorzMzqiaf
         hWIAysdO/FZy4YQCtGIknBlv8ZvAS8nU+UsUdHXMK81dBH6vhDq3xM0Zr14l367gLMu6
         Z0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684916876; x=1687508876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqn5qRBwLcinfNxv6VW9L+IL+2b4SfMx1zWHSgO399s=;
        b=V18+d39STzr4yvIe6XxsQeidJSf57h4wku4YqnLTJZs3gIP7NwkD+m7w1p54xAQQ7b
         1Mxb2jGIl2dO/fz45fWgxuhhhG9PpRpnRtbqNPOhwfgc7HF/NOfwKoXvqN5Npdl7JRKJ
         zWnXYuNKf+UQWPJBhVAWMdTzCxihggvVUByTD8T7Gzj6EeAT+ezHyo5OQwVivwbb3Bxx
         yoUDQN36Ura1Bq4roIthI6EcHxj48r69gSrTU77YVjhhFWcXsWv1yEKoJkgKnfpi6A4w
         55tZcNI3sCL3D8XPjmbLwhzbowMPi69fpqhxayhmYPy+OuSlZVjkd8cdOJy96UwywX7d
         pF/A==
X-Gm-Message-State: AC+VfDxVD9mBPhez91m9xk3QiW4giQNgW22bk9NmRUQl8DFeBrNtM8p9
        ESvf7p9jeZ7fhPdEAnwn8qCkTgda21s7BSdy
X-Google-Smtp-Source: ACHHUZ51AH1JWC4YEIhLkDzsm1fECjK/PgS5MlDO56x6XPdzEJ3P3CzbjtqR9uT3ruJll6fRYG0ydg==
X-Received: by 2002:ac2:434a:0:b0:4f3:a483:557 with SMTP id o10-20020ac2434a000000b004f3a4830557mr4741266lfl.5.1684916875768;
        Wed, 24 May 2023 01:27:55 -0700 (PDT)
Received: from pc.. (mail.pulsar-telecom.ru. [94.181.180.60])
        by smtp.googlemail.com with ESMTPSA id c18-20020a197612000000b004f378fbb358sm1614049lff.112.2023.05.24.01.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 01:27:55 -0700 (PDT)
From:   Maxim Kiselev <bigunclemax@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Maxim Kiselev <bigunclemax@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [RFC PATCH v1 0/4] Add support for Allwinner GPADC on D1/T113s/R329 SoCs
Date:   Wed, 24 May 2023 11:27:29 +0300
Message-Id: <20230524082744.3215427-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Hi,

This series adds support for general purpose ADC (GPADC) on new
Allwinner's SoCs, such as D1, T113s and R329. The implemented driver
provides basic functionality for getting ADC channels data.

All of the listed SoCs have the same IP. The only difference is the number
of available channels:
     T113 - 1 channel
     D1   - 2 channels
     R329 - 4 channels

This series is just an RFC and I would be glad to see any comments
about it.


Maxim Kiselev (4):
  iio: adc: Add Allwinner D1/T113s/R329 SoCs GPADC
  dt-bindings: iio: adc: Add Allwinner D1/T113s/R329 SoCs GPADC
  ARM: dts: sun8i: t113s: Add GPADC node
  riscv: dts: allwinner: d1: Add GPADC node

 .../iio/adc/allwinner,sun20i-d1-gpadc.yaml    |  52 ++++
 arch/arm/boot/dts/sun8i-t113s.dtsi            |  12 +
 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi  |  10 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/sun20i-gpadc-iio.c            | 275 ++++++++++++++++++
 6 files changed, 360 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
 create mode 100644 drivers/iio/adc/sun20i-gpadc-iio.c

-- 
2.39.2

