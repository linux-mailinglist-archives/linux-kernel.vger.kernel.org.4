Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131C872AB71
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 14:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjFJM37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 08:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFJM35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 08:29:57 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AB93596;
        Sat, 10 Jun 2023 05:29:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f7378a74faso19768285e9.0;
        Sat, 10 Jun 2023 05:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686400194; x=1688992194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FK/BTEpi1h8QPadFMEPE8CQ/83P2AbocLoI9C/+A1BY=;
        b=aJ3Eu++PfSnISHhhC4Q9T0cjluUXnOgJlp+cWSALsVAq71T+rU638SgsRY2kiQEj9d
         f0TAdOKcCsLDrd4Rnd5sOT4a47vnhgRFCjJHDrcJQIP1QBb6XPTgg/ORktEKw7iSDB4K
         4/0Ra9AOFtPYJ900Czi/VUG9qsUDSRvGX6PeNqbcrzmodR14eQAx1SOkRTIPTfe+podw
         +njDm/lqk1AKUMMc40PrK5OaWFTo8+QxyX7Sq05SDDJqqbax/PUaN+0K18IIejnSG5jA
         OdLXFzGP78gBuVVeM40uhP4PyWlaFet1+OHmZ8/ynTj4ysc4z4zexGyPmfwA7jGg42RS
         vC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686400194; x=1688992194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FK/BTEpi1h8QPadFMEPE8CQ/83P2AbocLoI9C/+A1BY=;
        b=Lq0IVJQfmx6QGOWQQmoHR4N2wmuY3ZUT4r+wtAhT48I0DuK1cQ9QLlTKZAAbg02MS6
         fnhfzjT6nWXuOgQg9Pc/MGwndOfm0dzd0S9ZPvTsPsgkQJDA2+bmdx+oRIUNQWkDsEXz
         CSj54iHNCj2YzeXbU5aHZhHExfyncpZbFg+kDQ3Njpko6degiEAaYY5EQA2CRBB90Ulp
         XHdsLXXK7YZb7J6eZfJXOwqF6KwLpKQcsXxA3jaXQBvGoNnkYhgSb0qGwYpHYvspxJkp
         ys+YUHrCjw1gOFo/vimL4oM6HbX6Fq3+Mk/v5wGCxxL7zrYebX3RrUTSO/ordw1w03FP
         MwuQ==
X-Gm-Message-State: AC+VfDx2c9d1xK00L/kfmtbzDSXsiykTNylAo/IuupYScnmYkRSBQWPI
        J4xF6PxuLN6+lg2mxKIy5L+rUOl78SctiH34
X-Google-Smtp-Source: ACHHUZ6a32iAuvgt0yTJfQcHaQvVHXnVjIKQ6bUuHQx1QXzyI+6JpnqGHo3g6/SThfeC6Chhpu7lxg==
X-Received: by 2002:a7b:c4c8:0:b0:3f4:239c:f19 with SMTP id g8-20020a7bc4c8000000b003f4239c0f19mr2492715wmk.36.1686400193609;
        Sat, 10 Jun 2023 05:29:53 -0700 (PDT)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id v26-20020a1cf71a000000b003f80e81705asm2310487wmh.45.2023.06.10.05.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 05:29:53 -0700 (PDT)
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Arnd Bergmann <arnd@arndb.de>, Haibo Chen <haibo.chen@nxp.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v4 0/3] Add support for Allwinner GPADC on D1/T113s/R329/T507 SoCs
Date:   Sat, 10 Jun 2023 15:29:06 +0300
Message-Id: <20230610122934.953106-1-bigunclemax@gmail.com>
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

This series adds support for general purpose ADC (GPADC) on new
Allwinner's SoCs, such as D1, T113s, T507 and R329. The implemented driver
provides basic functionality for getting ADC channels data.

Change History:
v4:
- Fixed DT bindings warnings
- Used GENMASK to clear the irq register
- Minor formatting fixes

v3:
- Added DT bindings dual license, fixed property order and example formatting
- Added explanations comments for timeout and mutex
- Dropped unnecessary regmap and used readl/writel instead
- Added error message about getting channel number
- Renamed labels and variables to make them self-explanatory

v2:
- Added lastch flag to avoid addition work for already selected channel
- Added reset assertion on module remove
- Added dynamic channel allocation and dropped iio_chan_spec arrays
- Changed IIO_CHAN_INFO_SCALE type to FRACTIONAL_LOG2
- Dropped separate compatible strings and configs for T113s and R329
- Fixed includes
- Fixed Kconfig description
- Removed duplicate probe error messages
- Used FIELD_PREP for bit setup

v1:
- Initial version
Maxim Kiselev (3):
  iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs GPADC
  dt-bindings: iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs GPADC
  riscv: dts: allwinner: d1: Add GPADC node

 .../iio/adc/allwinner,sun20i-d1-gpadc.yaml    |  91 ++++++
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  10 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/sun20i-gpadc-iio.c            | 281 ++++++++++++++++++
 5 files changed, 393 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
 create mode 100644 drivers/iio/adc/sun20i-gpadc-iio.c

-- 
2.39.2

