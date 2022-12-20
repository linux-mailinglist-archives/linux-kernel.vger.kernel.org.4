Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5AF651C15
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 09:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbiLTICO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 03:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbiLTIBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 03:01:49 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267F7F5A6;
        Tue, 20 Dec 2022 00:01:47 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u7so3302543plq.11;
        Tue, 20 Dec 2022 00:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wy1qx/0Za3zU/0a34WdVh8eP80ZwdH8mGSZrNJRldY8=;
        b=HLRPvp/3RgzawnVYgVjubCWKwiwtfAHW7vZG5AQP9ZS64ljLVhYqZwE9ni9kwJkAUw
         ZfY5GFIb14k77B9q9rFGAa9emtAbGtc3PWkXIKxPLt4IdnG/Wyk+WmMzcYH4XUYCjoEf
         T7LFzbS9G2BTsTnA+tlxytOmjD3E1+/S+NJDO7U1+AFGvhjnUjsnnTVEzGXOUwAEzbxU
         ePgwJMSvkCpUQ47LHDO7nO2HMRcXbGlqpanpBChmhKp2VJtkjR0DXfb1XcWm9aGsZYVu
         o3MkOX3Ko5ctMThawLz+HtnCXEBsO7HRIYrMcs8d2RfxJTIfmm7NR9LZOLG35w9otKww
         3lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wy1qx/0Za3zU/0a34WdVh8eP80ZwdH8mGSZrNJRldY8=;
        b=1XacmI+W9Mqa/LTB52ALf0P6WIOBhlBW0odpJIk9Kq6QYPBeasj1Arnuhxw+P93r4I
         x+wLfQXbPdRTiX0mjgOy+fFDchTWd7DtlKTve/xGGSFXQpIxV1bbaai5WAeA1vR0QRbp
         yab5iqmA0OrjSAkrKDlzL6RLRvAkV5yhwX7PUQeWifyJ9jwj7zplBQJMXT9gX++ngpmy
         gIPHpVc0iTAU0zaXFgPuLDBgUgtu6PKSUgxyWV9Xxdke2ClRZXGI6c3eho53oq+g5sYa
         6bgX79RH1nAe20yt1n78P0PODMcjhhGDvzbjucGkvC7ZQ/4LLSQF3wKlgpU/AgDCE9he
         BV6g==
X-Gm-Message-State: ANoB5plA5VbkvuZSTorC4O4U1CS5z4oNynx757pm3uNrwm67RkoZOa2J
        hzO1VRGr53N0s0wUKlQXxes=
X-Google-Smtp-Source: AA0mqf7M2k9C9yQQxaYaahkxKrjsrZJcfD1plTnFpz5Fd75VxSuzk3Xr/OWQKGyMZRerzs7992hpRg==
X-Received: by 2002:a05:6a20:6f08:b0:a2:df6d:e56b with SMTP id gt8-20020a056a206f0800b000a2df6de56bmr35561907pzb.14.1671523306671;
        Tue, 20 Dec 2022 00:01:46 -0800 (PST)
Received: from localhost.localdomain ([180.217.146.214])
        by smtp.gmail.com with ESMTPSA id u15-20020a65670f000000b00476d1385265sm7559179pgf.25.2022.12.20.00.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 00:01:46 -0800 (PST)
From:   Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, jim.t90615@gmail.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v3 0/3] Add Nuvoton NPCM7xx SGPIO feature
Date:   Tue, 20 Dec 2022 16:01:36 +0800
Message-Id: <20221220080139.1803-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This SGPIO controller is for NUVOTON NPCM7xx and NPCM8xx SoC.
Nuvoton NPCM7xx SGPIO module is combine serial to parallel IC (HC595)
and parallel to serial IC (HC165), and use APB3 clock to control it.
This interface has 4 pins  (D_out , D_in, S_CLK, LDSH).
NPCM7xx/NPCM8xx have two sgpio module each module can support up
to 64 output pins,and up to 64 input pin, the pin is only for gpi or gpo.
GPIO pins have sequential, First half is gpo and second half is gpi.

Jim Liu (3):
  gpio: nuvoton: Add Nuvoton NPCM7xx sgpio driver
  arm: dts: nuvoton: npcm7xx: Add sgpio feature
  dt-bindings: gpio: add npcm7xx sgpio driver bindings

 .../bindings/gpio/nuvoton,sgpio.yaml          |  83 +++
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |  30 +
 drivers/gpio/Kconfig                          |   8 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-npcm-sgpio.c                | 639 ++++++++++++++++++
 5 files changed, 761 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
 create mode 100644 drivers/gpio/gpio-npcm-sgpio.c

-- 
2.17.1

