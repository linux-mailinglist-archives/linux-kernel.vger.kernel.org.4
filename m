Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FD4632B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiKURoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiKURom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:44:42 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5452C131;
        Mon, 21 Nov 2022 09:44:40 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id f27so30350832eje.1;
        Mon, 21 Nov 2022 09:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RLnharg7HDG4tuhJcBKXRgEiJmoIlGVpeHO4ji1PupQ=;
        b=QMxs7gt0GdJyUwOlWlUC7k8EYUiuFa2UjgYIVh3FqAjs64LLxkxattfbJ6q9RN1/Xt
         UjgjDR2kn7+E1O5kJc+eIcAE2y5BELiDUH2a5ShKVTlU2XfWFWS8b9U615oGAaOZlu5W
         +zPWFpWn/EWRE8EgId63QukTU3LKvFicXp387MXKZtE87pailleizraUkcGWBTKwCAP2
         jVfbC4J410Qr6kd/PVSo3cLwXm7N5Zg/bADMRrhobWTBlJ6CZV9WQQY/dObzVCwiJ7cZ
         /4xtai8Q71kHnPOjG0zCZtJTbCs07MeXUTmettAKy84z8xbSjOX/O2zHh+BZm0mB4WyV
         UmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLnharg7HDG4tuhJcBKXRgEiJmoIlGVpeHO4ji1PupQ=;
        b=3E2kCkA2nrF5rK9QKcf5AKl+W+6VJzM1Cei5oTHsbNUxPuxwtBKsfREq+oPAflkwf8
         +jQe+KdRcXjiz6ekaf7jriez/bUcmxjiqhGuaL8IlxiEpvAiF7rQGCsw+ldFR8oynHNV
         zdbqGy4QHXWiTLbX58VDTAtbslIPIMK2nXJ28dUjlRvfxip7pifNnyjdTOf/NS8P+/0+
         b9E5CNi+QZEOxwcPXJ4WN3CkqrM+sAto1UJ2kI97N63wTbeoJsrSuiLDF/JPp004T6KC
         5hrTtwq/0+CqK2aM/EHIug3+PovRTxiCbnAwpqFaiHWy5uCGsbZun8QKbuTlr3UOAo1m
         Xeew==
X-Gm-Message-State: ANoB5pkuCkIr+5nAoNfus34wE96VYwS7aunqkifHXRD8aw47B3RfWPSB
        H8XtLuTM8OwG9MkR2SC6zBE=
X-Google-Smtp-Source: AA0mqf5hbgaT1LTR83Rgz0E8eKtIWdVjV/lZPLQv/7DyuZ4ztHtH3rHY0A0ZW3+Vs7MM7VoXiPYOwQ==
X-Received: by 2002:a17:906:85d2:b0:78e:ebd:bf96 with SMTP id i18-20020a17090685d200b0078e0ebdbf96mr16597014ejy.625.1669052678827;
        Mon, 21 Nov 2022 09:44:38 -0800 (PST)
Received: from localhost ([217.131.81.52])
        by smtp.gmail.com with UTF8SMTPSA id 14-20020a170906308e00b007b29a6bec24sm5172485ejv.32.2022.11.21.09.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 09:44:38 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH RESEND v3 0/4] PWM and keyboard backlight driver for ARM Macs
Date:   Mon, 21 Nov 2022 20:42:24 +0300
Message-Id: <20221121174228.93670-1-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.38.1
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

This is a resend of the v3 of the patch series to add PWM and keyboard
backlight driver for ARM macs.

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

