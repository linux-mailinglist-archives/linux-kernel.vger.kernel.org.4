Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E8973BB21
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjFWPJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjFWPJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:09:32 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8C52693;
        Fri, 23 Jun 2023 08:09:09 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f86d8a8fd4so1000806e87.3;
        Fri, 23 Jun 2023 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687532948; x=1690124948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KyhSKyzxLiTaX2cHaiVENSWEBc27n/NollVdFdTZL5M=;
        b=HaP8+r9KISVI7nfSmXrI/Dq3qHIobkZcJPoB7bvvpeHg7K4V8muuEU5CjwPF6yz/JJ
         TNWeJFZve0S7yepHqm/kahqRzpEAzlDrzPlWIuWZVGgiE1WJgir+wIZ4zpaKs6yyozxT
         b0R34BOp7MMU8HwBM33r5HaRVufWY/kRaw6XHYa9T7efpI9hoYkAzzOPEKsZK/EjW5RC
         JIWA7ab2IZ/2ZGTSDz6coX0Siuy2GtLIGicw9MtYZ7ZPCGa3O5WJehBpxAL6s6+gB0Wg
         WvFbyVrATONdFafoiUxCU5hEnBLjAi/IPbuXxQ3UHTbxFhAHLlKc4WVUO5ZUu/S+5ehT
         x2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687532948; x=1690124948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KyhSKyzxLiTaX2cHaiVENSWEBc27n/NollVdFdTZL5M=;
        b=OLIj0Qir7ZNM/Gd0kDeFFEMAkUmgsDj/xvEP3QGUqLG7yaL7CSGzVmc2D5qAxShL7P
         iXD0ua3EW9cNHg6u1xMw5Daivfpbxs6rSmDqFuAkDmmnxeXsAmawzriujmjd/Nz7SC9T
         gTsN9QU06bsbcdTQgc07GPICWuD6oxXHXZas7W0eLpoOdI1K7O2eZYadwLiMNW2Q3cdp
         292mYwTNMafohjAect6hlASNg0z714kERD/yfXP8Xim934lRAL/o+yQm0WEWxC6vAmSi
         u7H/14uV8L39uFkLOXXsfY2u10uuMzR02kyzseUkkexz9MT4X30ea7HK18qyvOJmkJLU
         WOaw==
X-Gm-Message-State: AC+VfDzb3tS+WZ4pGMvywRz7h9WbDC67WZ1bd671NP867SHUrJWnQ9Vu
        YwAtemoP15WqeFrcrGa/h0WZJ6BH0j01
X-Google-Smtp-Source: ACHHUZ73xQWanjeo0B3wORGVnreb3HkxQCneLZLTQefVJHXDwD6Tmyy2CwDZIzgnt2dF7FMxNeXrUg==
X-Received: by 2002:a05:6512:2f7:b0:4f8:70d8:2902 with SMTP id m23-20020a05651202f700b004f870d82902mr10711352lfq.18.1687532947042;
        Fri, 23 Jun 2023 08:09:07 -0700 (PDT)
Received: from localhost.localdomain (mail.pulsar-telecom.ru. [94.181.180.60])
        by smtp.gmail.com with ESMTPSA id w25-20020a19c519000000b004f842e58d08sm1465686lfe.84.2023.06.23.08.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 08:09:06 -0700 (PDT)
From:   Aleksandr Shubin <privatesub2@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Aleksandr Shubin <privatesub2@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
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
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/3] Add support for Allwinner PWM on D1/T113s/R329 SoCs
Date:   Fri, 23 Jun 2023 17:59:58 +0300
Message-Id: <20230623150012.1201552-1-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for PWM controller on new
Allwinner's SoCs, such as D1, T113s and R329. The implemented driver
provides basic functionality for control PWM channels.

v2:
 - fix dt-bindings
 - fix a remark in the driver

Aleksandr Shubin (3):
  dt-bindings: pwm: Add binding for Allwinner D1/T113-S3/R329 PWM
    controller
  pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
  riscv: dts: allwinner: d1: Add pwm node

 .../bindings/pwm/allwinner,sun20i-pwm.yaml    |  83 +++++
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  12 +
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sun20i.c                      | 322 ++++++++++++++++++
 5 files changed, 428 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
 create mode 100644 drivers/pwm/pwm-sun20i.c

-- 
2.25.1

