Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AC26B5052
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjCJSom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjCJSoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:44:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFC1123CE7;
        Fri, 10 Mar 2023 10:44:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0ABDDCE2A34;
        Fri, 10 Mar 2023 18:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B88BC433D2;
        Fri, 10 Mar 2023 18:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678473850;
        bh=9VDi+rkGZZUEFOqtKV0WoGhoAKQoF41aoKOynoKNy1I=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=pGOD7ll63guptCpU4PUV9EL3fSArAR3eHXjg4qP8BZn2Kz7OuYLf885jT4cJYAFdX
         s9vheZjXZfFaLpsVzut0fwiZ3hG9AHlv9meJocR2CHbG3DLw2WZHyNYsqpZb9yqe3Z
         lAQiWY39okZvKsR3kWrrjgeFUTnUhhr5/q0bz54xtpY2jeWd4Ll0RW4sCd+hMTIaLH
         w36YiZnJzprnpANTvIbax7hxRJWjqdUPDCaW3zVR+PrzmVTXeUDT1WkrhN3LrWqM0Q
         KMhYpYSF6s2UrrVttbkZtqVuNSe556vbpjEnJRkM2JpUl8epdadZqhENw+DVF+p2z6
         Re/PKtaezoozg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8CAC6FD19;
        Fri, 10 Mar 2023 18:44:10 +0000 (UTC)
From:   Sasha Finkelstein via B4 Relay 
        <devnull+fnkl.kernel.gmail.com@kernel.org>
Subject: [PATCH v8 0/5] PWM and keyboard backlight driver for ARM Macs
Date:   Fri, 10 Mar 2023 19:44:06 +0100
Message-Id: <20230214-fpwm-v8-0-65518a0d4944@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHd6C2QC/12Nyw6DIBREf8XcdWkQGyFd9T8aFzwucpOiBgxtY
 /z3ossuz8zJzAYZE2GGe7NBwkKZ5qmCujRgg55GZOQqg+Ci46K9Mb+8I3PKy95Y5ZxtoapGZ2Q
 m6cmGQ446r5iOYkno6XPuP4fKgfI6p+95V+SR/i0XyTjzhuveeON4Jx9j1PS62jnCsO/7Dznun
 7uxAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678473848; l=1982;
 i=fnkl.kernel@gmail.com; s=20230213; h=from:subject:message-id;
 bh=9VDi+rkGZZUEFOqtKV0WoGhoAKQoF41aoKOynoKNy1I=;
 b=j8gEc4haSzTfWjUIbkJAmBECKuP2NdZuJHbm/V0WBmaoqeVu5goVUQ4iQv6PhTytAwDEDJE1N
 x6izkUJvLT2Db7DIafMNJL//cJ5FYVl0j5mhintszd5kZ31Wo+mhT4m
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=7LFSAJtxIWAs9LzCIyX0sSvCZy2wQTyEIu1zch6o804=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20230213 with auth_id=28
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: <fnkl.kernel@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the v8 of the patch series to add PWM and keyboard
backlight driver for ARM macs. 

Changes in v1:
Addressing the review comments.

Changes in v2:
Added the reviewed-by and acked-by tags.
Addressing a review comment.

Changes in v3 and v4:
Addressing the review comments.

Changes in v5:
Added t600x device tree changes

Changes in v8:
Changed the overflow handling to clamp instead of erroring.

v1: https://www.spinics.net/lists/linux-pwm/msg19500.html
v2: https://www.spinics.net/lists/linux-pwm/msg19562.html
v3: https://www.spinics.net/lists/linux-pwm/msg19901.html
v4: https://www.spinics.net/lists/linux-pwm/msg20093.html
v5: https://www.spinics.net/lists/linux-pwm/msg20150.html
v6: https://www.spinics.net/lists/linux-pwm/msg20190.html
v7: https://lore.kernel.org/r/20230214-fpwm-v7-0-fb0a6bfbd037@gmail.com

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
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230214-fpwm-d8f76bc8ddc1

Best regards,
-- 
Sasha Finkelstein <fnkl.kernel@gmail.com>

