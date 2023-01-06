Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484C66601A8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 14:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbjAFN7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 08:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjAFN7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 08:59:25 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521EA77D1C;
        Fri,  6 Jan 2023 05:59:24 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso3581366wmb.3;
        Fri, 06 Jan 2023 05:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1mlyc9DQTAJ+skih8MrYLJL8eGML7Mctz40JHiQZ9T4=;
        b=WXntHq7o6JZkKaK/EHu8eMAmXERVNZ5Tjuf3Pl7X7skPpV8x+QFuAVf5LbNzV6oFRW
         mOKPS5o7cG1kEkMtY0tl9FCHRI0PL2ceGR1cYjweygxUMlQ0ftuF7aKf7gWj1dwTaG5x
         cCbvDhXPvXeytmGxIVGsJq0inXkhUMwHdgC109jzRttRlyRhf2kNqEXdUZMp6+wj5vJw
         o/gC1hrWliliSHWHJD3PIbLY5sR0yZLr7HVptfjCh0bgqirHWhSTzVLYlq1whLYhYJBu
         6cqKntesBYw9DQH+ZU5wSY6fGDkTuQ0SwV3gKmYpEeIFEzsYEiCueGJzijl8kVhFiNWo
         mgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1mlyc9DQTAJ+skih8MrYLJL8eGML7Mctz40JHiQZ9T4=;
        b=2jz8LGtgRewkbbIcaxs05byYiueTff5aMnEbjmZ7wXW5xUymYP3gtomIF5j/SOwiYh
         kPC/WtJBFjwVX3yiS3mXgSTgL6DNFCAlTMEbj5z3DMTO8cTgd4k2EGbRv7weyHlblafl
         nmmkvp6vZHyIxjFtccHT+fYLEMAsyh0nHd/79DVUo9Gbds1Jy6tOisuOvfZ72G/hZjAF
         h8t70e5VDGdvMTV166uF1g0In6LK3AP2Z+tzBG+rjs9fkPuWpEmt8msTXLnFeiFUxygk
         eqdo5osH5ypv7Si181PFNite8hz3jX9YUdOD/A6i77KunD/D3SN1ozpxI8MuN+WAJT4J
         nNgw==
X-Gm-Message-State: AFqh2krG+Zloy/EFiPRKiaa2LfBaqa4TlVcGRbqHNAH1q3qaC3S24qbn
        3gz+iVwE1/6KmhMWj1Sg9YE=
X-Google-Smtp-Source: AMrXdXuHgyEpDEDjZdAZuSHCf26rChlqT+0fQVHZrgeNnuYZffHhKAABwdxhZ3V9jhzxidbnKL1q0Q==
X-Received: by 2002:a05:600c:1c21:b0:3d2:2043:9cb7 with SMTP id j33-20020a05600c1c2100b003d220439cb7mr38463441wms.5.1673013562697;
        Fri, 06 Jan 2023 05:59:22 -0800 (PST)
Received: from localhost ([212.253.112.114])
        by smtp.gmail.com with UTF8SMTPSA id c7-20020a05600c0a4700b003c6bbe910fdsm7386690wmq.9.2023.01.06.05.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 05:59:22 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH v6 0/5] PWM and keyboard backlight driver for ARM Macs
Date:   Fri,  6 Jan 2023 16:58:35 +0300
Message-Id: <20230106135839.18676-1-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
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

This is the v6 of the patch series to add PWM and keyboard backlight
driver for ARM macs. This time the changes are a bit more substantial
and include the changes to the t600x (M1 Pro/Max) device trees.

Here is hoping that this time, the paint on this shed is up
to everyone's standards.

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

Sasha Finkelstein (5):
  dt-bindings: pwm: Add Apple PWM controller
  pwm: Add Apple PWM controller
  arm64: dts: apple: t8103: Add PWM controller
  arm64: dts: apple: t600x: Add PWM controller
  MAINTAINERS: Add entries for Apple PWM driver

 .../bindings/pwm/apple,s5l-fpwm.yaml          |  51 ++++++
 MAINTAINERS                                   |   2 +
 arch/arm64/boot/dts/apple/t600x-die0.dtsi     |   9 +
 .../arm64/boot/dts/apple/t600x-j314-j316.dtsi |  18 ++
 arch/arm64/boot/dts/apple/t8103-j293.dts      |  17 ++
 arch/arm64/boot/dts/apple/t8103-j313.dts      |  17 ++
 arch/arm64/boot/dts/apple/t8103.dtsi          |   9 +
 drivers/pwm/Kconfig                           |  12 ++
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-apple.c                       | 156 ++++++++++++++++++
 10 files changed, 292 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
 create mode 100644 drivers/pwm/pwm-apple.c

-- 
2.37.1 (Apple Git-137.1)

