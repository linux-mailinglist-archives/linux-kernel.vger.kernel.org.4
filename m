Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DC9611830
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiJ1QxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiJ1Qwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:52:55 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9461ABA08;
        Fri, 28 Oct 2022 09:52:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kt23so14261520ejc.7;
        Fri, 28 Oct 2022 09:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TRbtjzgGY79KT/za/x8o0WGQEAKstEUc6+ZUvLa/3WE=;
        b=Rm1QgOjAFiI7XmFUhmPEZeVtIvOd4SWpfjF8UQiJEDSDLZL7F2M6r9ByqbGV/JByp4
         Gv+fkWsQJ88UVp2YtPZeQqKxuaVRxYmvpr30scl035igGDXPVadrzYMtHmEdSv4lgSnq
         vm1cQURGqu5jG05rh321S9jyPgK1mI/l2VZM9FPwNqay2EfePWJDExQClNkSqrI6KBQp
         +hVA6dgfE2iRfo3JkqkWF9HBGcLA2Qm+v6n3eJLHLuWfuttfiILkbnPESeUi+fZwJtno
         SvVb60STbZAD5X2utynPoFPNFvBtl2VmtWBDWcD/7tARz8FbcSVwSnt+I2dVgP4qUxg1
         WZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRbtjzgGY79KT/za/x8o0WGQEAKstEUc6+ZUvLa/3WE=;
        b=7OjOERQa65WheDdsT4Yw9DlSexjYyBGzZnjIOhqlRzrAcjWOdpQywfH9zWkoym5PWj
         AZ83YxmHQhYdjc9UuXr7JIKOf5wgZk5P0VNqapYNgECCi0lpqAMO0q7bNAX0sQzhgIL7
         XaC+ypQUpSx9l2QmcuimTq2depsrDZ170kbwjOXDcH4CdxqatKiMadb1RaGVtuGul0V7
         ax35klmkzw/SWwHHqdJrldAUHDGxht4++j9M30ZF99GII0csXt+/1ADYLE2bTip0NgzV
         kcIDJ418fwnNSNDIxvADpR76MOwwkMP3ItA1pmpSUNpX+B4ktVgAboDBH00YUyFjVtXB
         WcVA==
X-Gm-Message-State: ACrzQf0rbg/r8DC7FplbVeQH2SQny0105QAcyBeEPlg76AHXkG6jewQI
        NfKIF9XmkhUn7jTQxacAd+7HgCd8JO/lAA==
X-Google-Smtp-Source: AMsMyM7gsqxktKkco3+PcK41044g4dHIYIHKTgAqQdmLcpGgPUnZd0RVuxuYWimJn9kPdH4HvFGBLA==
X-Received: by 2002:a17:906:3111:b0:7ad:a7fc:f3e8 with SMTP id 17-20020a170906311100b007ada7fcf3e8mr243112ejx.518.1666975972737;
        Fri, 28 Oct 2022 09:52:52 -0700 (PDT)
Received: from localhost ([88.227.58.131])
        by smtp.gmail.com with UTF8SMTPSA id x9-20020a056402414900b004589da5e5cesm2952990eda.41.2022.10.28.09.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 09:52:52 -0700 (PDT)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] PWM and keyboard backlight driver for ARM Macs
Date:   Fri, 28 Oct 2022 19:52:11 +0300
Message-Id: <20221028165215.43662-1-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for the PWM controller present on ARM Macs and used
among other things for the keyboard backlight on those laptops.

The included device tree patch also hooks up the keyboard backlight using
the pwm-leds binding.

Best Regards.

Sasha Finkelstein (4):
 dt-bindings: pwm: Add Apple PWM controller
 pwm: Add Apple PWM controller
 arm64: dts: apple: t8103: Add PWM controller
 MAINTAINERS: Add entries for Apple PWM driver

 Documentation/devicetree/bindings/pwm/pwm-apple.yaml |  51 +++++++++++++
 MAINTAINERS                                          |   2 ++
 arch/arm64/boot/dts/apple/t8103-j293.dts             |  20 ++++++++
 arch/arm64/boot/dts/apple/t8103-j313.dts             |  20 ++++++++
 arch/arm64/boot/dts/apple/t8103.dtsi                 |   9 ++++
 drivers/pwm/Kconfig                                  |  12 ++++
 drivers/pwm/Makefile                                 |   1 +
 drivers/pwm/pwm-apple.c                              | 124 +++++++++++++++++++
 8 files changed, 239 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-apple.yaml
 create mode 100644 drivers/pwm/pwm-apple.c




