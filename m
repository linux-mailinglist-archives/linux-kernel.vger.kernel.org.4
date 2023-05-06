Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CBC6F94E4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 01:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjEFX1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 19:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEFX1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 19:27:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5660B3C10;
        Sat,  6 May 2023 16:27:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3063208beedso2998348f8f.1;
        Sat, 06 May 2023 16:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683415621; x=1686007621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2FeWgpYGVgw05x9NXcehpvxe6YOrGKp5PKb2y+cAxE=;
        b=aclnyCppp/OmsCpCe1DSKh3rn0yYLZ2xnsF55M4+R7iOOYjFgjr53u1m2Z9zIrGbzX
         NlAByOYA2QZ9Jmsqw7IgqtddayGPyJCz6vv9QczyU1B/WEl7NJ+VPYK1yV6h5xgq1SCM
         kHozxKV8JynSHihZodBoR5voiy2okjHCZu6s6/H3QSag40kw+gCfD71GUuAr/pusuYtY
         yVJgaKWGyrKKjG7wiSbQr3z6yjvErhE5veGYqSQ8m05r0xpBjBupIIZjPcn/OzF+I1NQ
         iUhN7u+g2qiSZUfRcvzh31anBjVA2xOcsFp3bmJw/OIQ16IBHFZn+z6tTiK/OG0bNKIp
         3Kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683415621; x=1686007621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y2FeWgpYGVgw05x9NXcehpvxe6YOrGKp5PKb2y+cAxE=;
        b=XegDF3/5McwNKtef7Z1x8v1bciIV1oCVoJSCN0B4l1I8BJslo5UgMoN4oCJULMxkK9
         IH4P2nSny8jOwswY5OgPFP/9LKd8tpNouRchwNZsbO1FIjbATLPEXnl28OHJze5d6H3P
         7h5OReQ6C39wNqyJq74DmxPaAfu08c7RA9PphIo6ShCqkk/mvF68aNU+9XU73Egucfnz
         d51ob6M8ZJezVaUivb7WJUQ0AvjPn6Xp09nJmIOkQT00R4Gpx8WmZsg7gpaNbmsSGqle
         LyIOkZ2YpoXmjHLQTH6k3zJCVDODkP8s05qHHA5bA4TndDfZKLC6CFm8qa1OUAltN4o4
         37LA==
X-Gm-Message-State: AC+VfDzFQbPaeaIIVvYnVgZy9iyQ4iz7zkYf9tY3e3wtTlS06efuTb9Q
        nc/rl+ly6Mn/7/LwvPQvjXg=
X-Google-Smtp-Source: ACHHUZ6aXW+eEEp0ETGPH/k3zEH3JlzcT1+1ZrNspVjJp7yeJW1KVWql3w4Lr8zfryZlzHKsOOYuUg==
X-Received: by 2002:adf:fccb:0:b0:306:3899:ccbf with SMTP id f11-20020adffccb000000b003063899ccbfmr4455889wrs.14.1683415620621;
        Sat, 06 May 2023 16:27:00 -0700 (PDT)
Received: from localhost.localdomain ([176.221.215.212])
        by smtp.gmail.com with ESMTPSA id p4-20020a1c7404000000b003f1739a0116sm12098655wmc.33.2023.05.06.16.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 16:27:00 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 0/5] Allwinner R329/D1/R528/T113s SPI support
Date:   Sun,  7 May 2023 02:26:03 +0300
Message-Id: <20230506232616.1792109-1-bigunclemax@gmail.com>
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

This series is attempt to revive previous work to add support for SPI
controller which is used in newest Allwinner's SOCs R329/D1/R528/T113s
https://lore.kernel.org/lkml/BYAPR20MB2472E8B10BFEF75E7950BBC0BCF79@BYAPR20MB2472.namprd20.prod.outlook.com/

v3:
  - fixed effective_speed_hz setup and added SPI sample mode configuration
  - merged DT bindings for R329 and D1 SPI controllers
  - added SPI_DBI node to sunxi-d1s-t113.dtsi

v2:
  - added DT bindings and node for D1/T113s

Icenowy Zheng (1):
  spi: sun6i: change OF match data to a struct

Maksim Kiselev (4):
  dt-bindings: spi: sun6i: add DT bindings for Allwinner
    R329/D1/R528/T113s SPI
  spi: sun6i: add quirk for in-controller clock divider
  spi: sun6i: add support for R329/D1/R528/T113s SPI controllers
  riscv: dts: allwinner: d1: Add SPI controllers node

 .../bindings/spi/allwinner,sun6i-a31-spi.yaml |   7 +
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  37 +++++
 drivers/spi/spi-sun6i.c                       | 132 ++++++++++++------
 3 files changed, 136 insertions(+), 40 deletions(-)

-- 
2.39.2

