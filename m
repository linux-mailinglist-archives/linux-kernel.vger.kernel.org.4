Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2D473F6FA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjF0IYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjF0IYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:24:31 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD44026A5;
        Tue, 27 Jun 2023 01:23:53 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f122ff663eso5708593e87.2;
        Tue, 27 Jun 2023 01:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687854231; x=1690446231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GDNIl3iXFQ1gjAWKdZ7tZ4fSEMXf+XK06wLBhL78YQA=;
        b=ZsG0eKWLD4RrDhszvy0jCNn5SxS8lRq06BUqbDkRPdWd2dpro9AIC3anJvSNMNGVYP
         qqM2TOST/hDRserCkiIqfe5a96DIVS0mZXNk8OLcdtaCKdMOcIyBDWGQWpJl+3Jurm3A
         tqM/xj5WqaSBs1Z8/2g/lTTXame6RxFD0J55lUEo1hleJ71uRiR6ab2BIV15pzGZsH4c
         ED6sXTFn48+46ZZ+EZgqOTPNWrCNm7JxE0I/C1tsFJGLBc6kCOAWvXcTOJFNk87n7sMe
         iIEkLV862i2rBPa19Q7RYWDOVFlv9dmPfWP3IHmbyRqf+8Sgv5FQnhREAcXxrZvELZ4b
         73rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687854231; x=1690446231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GDNIl3iXFQ1gjAWKdZ7tZ4fSEMXf+XK06wLBhL78YQA=;
        b=FHK5BTX+DK6TvLCra4+0q6NBINO+epiXcejvp3FOyqwY2gOtXBn7rnwZSL3+tgtXM9
         cSNjWKODQBGUGF8HAhj6O5iWNEUk8i5ICrT2CyE/UNYe6NQV71mQ10yBMe8hSXo0Lqqb
         XmFf5o5Qz+LtCGAtlxCM51pGPhhc5gULGUoiI3AGsTvMmdjNJfvnJRFHl/XCYxS1CzNO
         Q2tOSFVYXn9R10bFAUx/N68L547C/SJW7Md0BG7a4BNLWuFu+ZnLVv2scX9Z3BfAEOGR
         DRYAfUXmxPbK+7GkamJPWLeoMkQKFsuRgV/lcEGbb28G1j26u28srBs6d4wDy/r0XjAX
         7Fmg==
X-Gm-Message-State: AC+VfDwzS6hn71N53m0o7dOWYAq6YnPG887XkLcF0ztxt7mYxgaiYknV
        7ZAsFRcPadqvJzb7fsZibf0jSuCPDVOhcrc=
X-Google-Smtp-Source: ACHHUZ73/pqlFjvrz0cp867rPg1rxGDDBjPhXGKKuH8Dye21hRqvSYSwI3xGt9P1QHy84HJNYNoHOQ==
X-Received: by 2002:a19:da11:0:b0:4f8:7617:6445 with SMTP id r17-20020a19da11000000b004f876176445mr12607528lfg.48.1687854230312;
        Tue, 27 Jun 2023 01:23:50 -0700 (PDT)
Received: from localhost.localdomain (mail.pulsar-telecom.ru. [94.181.180.60])
        by smtp.gmail.com with ESMTPSA id i12-20020a056512006c00b004eb12329053sm1420673lfo.256.2023.06.27.01.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:23:49 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 0/3] Add support for Allwinner PWM on D1/T113s/R329 SoCs
Date:   Tue, 27 Jun 2023 11:23:23 +0300
Message-Id: <20230627082334.1253020-1-privatesub2@gmail.com>
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

v3:
 - fix dt-bindings
 - fix sunxi-d1s-t113.dtsi

Aleksandr Shubin (3):
  dt-bindings: pwm: Add binding for Allwinner D1/T113-S3/R329 PWM
    controller
  pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
  riscv: dts: allwinner: d1: Add pwm node

 .../bindings/pwm/allwinner,sun20i-pwm.yaml    |  86 +++++
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  11 +
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sun20i.c                      | 322 ++++++++++++++++++
 5 files changed, 430 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
 create mode 100644 drivers/pwm/pwm-sun20i.c

-- 
2.25.1

