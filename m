Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2D0600050
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJPPDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiJPPDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:03:14 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB3641989;
        Sun, 16 Oct 2022 08:03:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id d26so19862088ejc.8;
        Sun, 16 Oct 2022 08:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pa9OicZOXvfwTJ5K7w80SaAGBxmpRr9ol3hi7NLwDPw=;
        b=GpbDbMOV0xT629x7gQAHpYE4Imi3mIMnFeRqNcn8CTfiPVfBW/4WUMV3DZofA23jB8
         9U9Ndz2tnxiH0TgrzmhJDlVYUtPjxgaxpX1QU8H5LSgcpjxkDgYpOMTVGcdsfnbthF49
         ULjVZkx83D0kY/uxibqjtqVzTAQIpL2NNEqhZnLImwDDF+RluVPU98yse3O72E30w/oX
         QSbX1ZXCL9ORWZFO/B9mLVYvpTRvlclCgEJ8o5bcXuktKqJcT1xKdf5V0j8fzzmpJYJN
         Vq32dSmM/En4nPwg7JPwgNmR9Aj/uHa81U8BaQw7vMpLQfTbN20smGk5JAnvWQvrgaZE
         OeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pa9OicZOXvfwTJ5K7w80SaAGBxmpRr9ol3hi7NLwDPw=;
        b=d+pRQ5G4Eaoa5FZMKnOQbkxRnX8egy1xpxtthoFBfHm91T6GfoHwalHl6x34s5CPSn
         NxUGXQxXpAGXS7RHjVL4qVlarwdf51MXNGvrIPdtt7pDf9qJOHkJDT69zghMONvlckoW
         c/NQPWNiTpERAb4l27GVifdYlQ8ar2PUeTnS5KgFcRW0RHsHZaJfMRwm6oZLIfSUJZOQ
         uoqSJr2rcRsdvtN5o/uPO5QEqjN5OhkQzXIPkKLAiUQjGzMkwOmm0rLPiGaPEFrMF56/
         6hQS92e7JJ0zzg2B7K1GqD40k+znBNS+11ceGvkvAQobKLyWxnuL1D05S0yoZe8DrIBq
         3Hbg==
X-Gm-Message-State: ACrzQf0G71tvwmme9fzpStiq0k4P9tYhqFEfRVYaaHKcCltMscw19U/m
        K5mq4vBUG96R2kVVsbWqe8+6GJcosEqREw==
X-Google-Smtp-Source: AMsMyM7Gja52fyXmLbTFjDBDXkt2Q/kQqHlb/yHbD1WtIipdSAAaCRyV2ekXZhhLq08F2hxW2s0lXA==
X-Received: by 2002:a17:907:c25:b0:78e:1a4:132 with SMTP id ga37-20020a1709070c2500b0078e01a40132mr5378461ejc.521.1665932587166;
        Sun, 16 Oct 2022 08:03:07 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-39-7-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.7.39])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090657c800b0078c1e174e11sm4645699ejr.136.2022.10.16.08.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 08:03:06 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v2 0/4] Add Ingenic JZ4755 CGU driver
Date:   Sun, 16 Oct 2022 18:01:05 +0300
Message-Id: <20221016150110.3020451-1-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch serie adds a new JZ4755 machine type and the
Clock Generation Unit (CGU) driver for the JZ4755 SoC.

Diffs from 1-st patchset:
 - CGU patches splitted into its own patchset
 - dual license for dt-bindings header
 - acks collected

Siarhei Volkau (4):
  MIPS: ingenic: add new machine type MACH_JZ4755
  dt-bindings: ingenic: Add support for the JZ4755 CGU
  dt-bindings: clock: Add Ingenic JZ4755 CGU header
  clk: Add Ingenic JZ4755 CGU driver

 .../bindings/clock/ingenic,cgu.yaml           |   2 +
 arch/mips/ingenic/Kconfig                     |   5 +
 drivers/clk/ingenic/Kconfig                   |  10 +
 drivers/clk/ingenic/Makefile                  |   1 +
 drivers/clk/ingenic/jz4755-cgu.c              | 350 ++++++++++++++++++
 .../dt-bindings/clock/ingenic,jz4755-cgu.h    |  49 +++
 6 files changed, 417 insertions(+)
 create mode 100644 drivers/clk/ingenic/jz4755-cgu.c
 create mode 100644 include/dt-bindings/clock/ingenic,jz4755-cgu.h

-- 
2.36.1

