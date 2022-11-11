Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE36626075
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiKKReH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiKKReF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:34:05 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D3761B91;
        Fri, 11 Nov 2022 09:34:04 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id f7so8538168edc.6;
        Fri, 11 Nov 2022 09:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VcLz+JLectl4eq76JetIRN2RIxjnki5yQTvjxWRfAgM=;
        b=D9eruaRgsUTg63mWpBsgzufnU+S1W0EcOItzcOWKFcDN4Fj99yc9qisypftFtx/Ou1
         12/wvgaiKsjgrVniAsiC5abbCGEaX2luQRIC3lz8eStkPcrWtowlAkXozzcYRAPAyKJ7
         zl6V0DJKSeAGwM1v+S3fJCR0XUpxoyoVqncMj+mtLB0oDajxjVwy1H4VB6MUHx1Aa2lx
         WUHFNwp6siYTeAIINk2BhlHRA+446txsPaIN8KMo0fN5GYnDMMMtJRqKZao7/iRT7KoS
         5vg49szXKtScm8SjxfDxNDIXk9Tw5v2gN9wVXSEoqVin7PwGFaWTCR3IviOZQZYQKSxM
         DHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcLz+JLectl4eq76JetIRN2RIxjnki5yQTvjxWRfAgM=;
        b=lCSbjdBaH2SW4L6I2orjC0eqWY0xuFrlO0TEs6KtRGrtraNLR+Flea4lGVgw3POr/v
         Y5CCmtKY4qSXckr6kbKDHNksp+fU0WR1LuG+Ud+Kp7xtX1moilEiATGWnaxhdVQogqSB
         Tj8j1dm8itpjNl3P0+GOcoN6v8MUQCVeEIKZRVLFBbBOGihTJtoMrwv30GCN6oBVw8Zr
         8o68U+fRGO3nwrgNFSZ5Wnjoqrqa2OZvhctzDvH9UihkDYp4ye6zNfp8p0tOv8SDgw+X
         Q4xFR7boHL6u6fHPOgpGtneQFtm4l7TJcr9Y4VNqjheeqca+3a6Z11ZqhRKhgVlxwuyq
         surg==
X-Gm-Message-State: ANoB5pnrmkOoPPySAoQwIJcuqioHUxQrvcDpdx2ZtQgcmk2wV29NCUGv
        /rYNEDQJvbIYA3c3yXWDhPM=
X-Google-Smtp-Source: AA0mqf4ckoin6dGD/x5XJtdvqAL0YTD5HKpohCb+EetbuAAk3yn/kZAu0w6RnZJIPV0/UUtoMLBHRA==
X-Received: by 2002:a05:6402:1bdc:b0:463:7312:a94 with SMTP id ch28-20020a0564021bdc00b0046373120a94mr2496485edb.178.1668188042536;
        Fri, 11 Nov 2022 09:34:02 -0800 (PST)
Received: from localhost ([85.153.204.139])
        by smtp.gmail.com with UTF8SMTPSA id ku21-20020a170907789500b007ae1ab8f887sm1138089ejc.14.2022.11.11.09.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 09:34:01 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH v3 0/4] PWM and keyboard backlight driver for ARM Macs
Date:   Fri, 11 Nov 2022 20:33:44 +0300
Message-Id: <20221111173348.6537-1-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the v3 of the patch series to add PWM and keyboard backlight
driver for ARM macs.

Changes in v1:
Addressing the review comments.

Changes in v2:
Added the reviewed-by and acked-by tags.
Addressing a review comment.

v1: https://www.spinics.net/lists/linux-pwm/msg19500.html
v2: https://www.spinics.net/lists/linux-pwm/msg19562.html

Sasha Finkelstein (4):
  dt-bindings: pwm: Add Apple PWM controller
  pwm: Add Apple PWM controller
  arm64: dts: apple: t8103: Add PWM controller
  MAINTAINERS: Add entries for Apple PWM driver

 .../bindings/pwm/apple,s5l-fpwm.yaml          |  51 +++++++
 MAINTAINERS                                   |   2 +
 arch/arm64/boot/dts/apple/t8103-j293.dts      |  20 +++
 arch/arm64/boot/dts/apple/t8103-j313.dts      |  20 +++
 arch/arm64/boot/dts/apple/t8103.dtsi          |   9 ++
 drivers/pwm/Kconfig                           |  12 ++
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-apple.c                       | 127 ++++++++++++++++++
 8 files changed, 242 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
 create mode 100644 drivers/pwm/pwm-apple.c

-- 
2.38.1

