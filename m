Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA03D6968A0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjBNP6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjBNP5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:57:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D4B27D52;
        Tue, 14 Feb 2023 07:57:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC12C61744;
        Tue, 14 Feb 2023 15:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10B93C433D2;
        Tue, 14 Feb 2023 15:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676390262;
        bh=W8XkJNoaiihOtRWm+VY9HVS5fVLKZtL0zeEomIi3nCs=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=CDTX9AItrfb+4lVJwXQ+OrFDRUYWY7x0vmazF8sdMWoV/EwbXKkRa7dkDTql9rIP/
         GMgFXsKfTE516pBd/6wCMjcRLpZj5ALRZFVJoLQipNbSmIGhxyT1R34QgpObzR4AE7
         CEeCWOZQUbTrtjsn0XeexCMCOCO5yHbC1tpkOwDMw3gqmwkUP9pXLVXQ4cXnhNMcBx
         L479J9proNQRNTvGkgOn/0/oNvC4MEEbqeMOmcCJvRl9mxupaa6XEPSRBurvM7+82a
         FOhEC4Z1pqgituikztLpZDSB+PMOhXrzTPDrk5T7BWbord9l7a5lQ4YXsV1Tte0cpg
         vlXFIgaQNpo1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id F0337C61DA4;
        Tue, 14 Feb 2023 15:57:41 +0000 (UTC)
From:   Sasha Finkelstein via B4 Submission Endpoint 
        <devnull+fnkl.kernel.gmail.com@kernel.org>
Subject: [PATCH RESEND 2 v7 0/5] PWM and keyboard backlight driver for ARM
 Macs
Date:   Tue, 14 Feb 2023 16:57:22 +0100
Message-Id: <20230214-fpwm-v7-0-fb0a6bfbd037@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGKv62MC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHUUlJIzE
 vPSU3UzU4B8JSMDI2MDI0MT3bSC8lzdFIs0c7OkZIuUlGRDJaDSpMTiVN2kosS85AyQ4tzE4pL
 UIpBEQVFqWmYF2PxopSDXYFc/FwUjpdjaWgAskuCreQAAAA==
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <asahi@lists.linux.dev>,
        Sasha Finkelstein <fnkl.kernel@gmail.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sasha Finkelstein <7d578vix8hzw@opayq.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676390260; l=1884;
 i=fnkl.kernel@gmail.com; s=20230213; h=from:subject:message-id;
 bh=W8XkJNoaiihOtRWm+VY9HVS5fVLKZtL0zeEomIi3nCs=;
 b=NNzni8bsONdHN+vK075/ukK3vHLt6lXE29h50S9lr03r5LdR0Vz2QqGwkelViFa7HJbypuvD9
 n7xtlxPq2dgCIwU7Y6oGOwsQpiAkHBT7vF5sRq3j/IVAG8gWA9cnby0
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=7LFSAJtxIWAs9LzCIyX0sSvCZy2wQTyEIu1zch6o804=
X-Endpoint-Received: by B4 Submission Endpoint for fnkl.kernel@gmail.com/20230213 with auth_id=28
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: <fnkl.kernel@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the second resend of the v7 of the patch series to add PWM and keyboard
backlight driver for ARM macs. No significant changes this time.

Changes in v1:
Addressing the review comments.

Changes in v2:
Added the reviewed-by and acked-by tags.
Addressing a review comment.

Changes in v3 and v4:
Addressing the review comments.

Changes in v5:
Added t600x device tree changes

v1: https://www.spinics.net/lists/linux-pwm/msg19500.html
v2: https://www.spinics.net/lists/linux-pwm/msg19562.html
v3: https://www.spinics.net/lists/linux-pwm/msg19901.html
v4: https://www.spinics.net/lists/linux-pwm/msg20093.html
v5: https://www.spinics.net/lists/linux-pwm/msg20150.html
v6: https://www.spinics.net/lists/linux-pwm/msg20190.html

---
Sasha Finkelstein (5):
      dt-bindings: pwm: Add Apple PWM controller
      pwm: Add Apple PWM controller
      arm64: dts: apple: t8103: Add PWM controller
      arm64: dts: apple: t600x: Add PWM controller
      MAINTAINERS: Add entries for Apple PWM driver

 .../devicetree/bindings/pwm/apple,s5l-fpwm.yaml    |  51 +++++++
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/apple/t600x-die0.dtsi          |   9 ++
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi     |  18 +++
 arch/arm64/boot/dts/apple/t8103-j293.dts           |  17 +++
 arch/arm64/boot/dts/apple/t8103-j313.dts           |  17 +++
 arch/arm64/boot/dts/apple/t8103.dtsi               |   9 ++
 drivers/pwm/Kconfig                                |  12 ++
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-apple.c                            | 159 +++++++++++++++++++++
 10 files changed, 295 insertions(+)
---
base-commit: ceaa837f96adb69c0df0397937cd74991d5d821a
change-id: 20230214-fpwm-d8f76bc8ddc1

Best regards,
-- 
Sasha Finkelstein <fnkl.kernel@gmail.com>

