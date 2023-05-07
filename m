Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BD26F9920
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjEGPF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEGPFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:05:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDC17EF5;
        Sun,  7 May 2023 08:05:23 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d4so10763605e9.1;
        Sun, 07 May 2023 08:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683471922; x=1686063922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u1gOIjKe06QTC2zFJd76oybW6RyS2NvpPacxfKSj0+o=;
        b=qfI8xnweP237OM6kO0nttjGF/sPZ1FyaqS37OyLfJUkMl26Q8P/D7/t3H2ZUcN+3hY
         NkzI4xWQibUtdLJgaN5pg5zu7cRkiZEUvqa0h6FeInj2IY1hyiHec/2nwhEvsHJKdx36
         D7c80OfSJf2jRa5fbHjAA+WpN00egLzqo4IYONlqPEKs+JjBlJeQPQKAS3qInBf0o6N/
         JBCJBkr4ReYTtOXXRHdGdGEpbdENxHw4DDIm6IWg9mPt4uNNtly92dbbrPscfT4rqJar
         +0IJz67j9SsHNBDAa1DxACr0LJUZSSWGtdsEmz8m6xxik9MUl7PC9xZawXL4BN/51PC5
         4/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683471922; x=1686063922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1gOIjKe06QTC2zFJd76oybW6RyS2NvpPacxfKSj0+o=;
        b=W/gdKyXq1/5dq9ljVu3Ja06HlRPa/i6hW/2E8jgV9mocy9/Q043S++ObGaZa4BbQ9d
         ikNATF+ArOAHAnroJhxPj2aGcW5MpXus/7rU4z86QsH1IZa2RXSsAY3eVvckAh3jjL2m
         IVzH7Uwq0e9WnSM9PNl8NJiWmjsaelVD2BifIaH8Li4JrhqWhZkStHkEYM6+QvvHfL+G
         lPgAewiPngrzEUEM7UQISgS7RvHjHpJvt6pCPrTPHlHshjS3SQmjy0bsJSYP//ztGNLP
         UZAYwtMGYqd7G5eqqU0JcTzI+1tlfiQXhkhkZdrdwVn8UDmBcZHGdIa5r3Ml3C07jVCG
         BpKA==
X-Gm-Message-State: AC+VfDxq4unru/E/a4Htn1VQJf2AxHNv0C98ZNgeVhxu14ZexcpxJyju
        GjHSQ8qjuEhDVtKXp2vysY8=
X-Google-Smtp-Source: ACHHUZ49sAKwYQSdkkwmMAeCU56EtVFg4Uecv9K3y8A0Pd7XH4negQYK2N3mKJ+yafcQ5q+Af0p9lw==
X-Received: by 2002:a5d:53c7:0:b0:306:2db9:a33a with SMTP id a7-20020a5d53c7000000b003062db9a33amr5647820wrw.33.1683471922170;
        Sun, 07 May 2023 08:05:22 -0700 (PDT)
Received: from localhost.localdomain ([176.221.215.212])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d594f000000b0030771c6e443sm8437998wri.42.2023.05.07.08.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 08:05:21 -0700 (PDT)
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
Subject: [PATCH v4 0/5] Allwinner R329/D1/R528/T113s SPI support
Date:   Sun,  7 May 2023 18:03:32 +0300
Message-Id: <20230507150345.1971083-1-bigunclemax@gmail.com>
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

v4:
  - fixed SPI sample mode configuration
  - sorted DT bindings list

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
 drivers/spi/spi-sun6i.c                       | 131 ++++++++++++------
 3 files changed, 135 insertions(+), 40 deletions(-)

-- 
2.39.2

