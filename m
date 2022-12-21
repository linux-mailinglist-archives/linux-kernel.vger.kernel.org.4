Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D153C6537F3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 22:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbiLUVG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 16:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiLUVGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 16:06:53 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3A01DF3D;
        Wed, 21 Dec 2022 13:06:52 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id z10so5609351wrh.10;
        Wed, 21 Dec 2022 13:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2bwrI59T94fzkfq8d28nKla53blkWkmWXnyfefXmHsg=;
        b=E9uukfAZHE+E67zgpsr57HjEUJ79bri/r1FyXrhoAMz9Lhc/PqLg3SiklmOcgHdgxf
         2aP7KvX0BJBzY78eoyTeggx9dGgrEoYkCOm9UGNjennt7rkGwJI9QbG1ZrxiqfO3a0L4
         CxWlydj8dSot23Oof6HxgvX2lNMcNqck2beEq+M3kAAMDkeFjJnInSQn1kA6P5d58Txm
         QGeQo9DUPnVO/lBHr89/Br53k3+XW5NW3OqoZc2cG+PkH70o3lTWhJbLDjsedqZ0eSJZ
         ovvaDSSgs05mC8yqxPR8MkPap35lGYZMgbQSxdyKgoLzQPVqGGlorne2R0cA3Id3kmAb
         PBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2bwrI59T94fzkfq8d28nKla53blkWkmWXnyfefXmHsg=;
        b=Xaln5yRJgyN3UeW0j1ibKwbL5CIzQUjxzBdCuhqlYaqaaJjJVIEkihijZdjXbFDW+0
         QcuaYhR12YytoFbHLiTR430zQUa9BhsexK8LQqEo3hIAOi05xW+M8cbrkYjRAYw3Q1ZZ
         2537XuPetANZ7mvaXEeUZ9BbyKG/C2b4b2uIhcvcYfidZ4NMNbTkOaVM2fel3453bkEM
         fAzq1Jsn6zcG9qDVPcupVyoM/ooCd11wlBmGUesVurtbgdJUX2G3jo4/9VtG7fkg9bCA
         Hs1lIg9HNnJMwevYU/6DY/7Xx24FDd55caZ03ATLqKM7aaBLVJ5TB6EPj9YQx5KwcFmF
         Eljg==
X-Gm-Message-State: AFqh2koB5WdXCfWCLROC808C9xz/lwIR+e+S9+7enIa489isC34Y0c08
        DDH+9R6yx8Wq+jwG4uureNA=
X-Google-Smtp-Source: AMrXdXuTHUNni9l5hklOCGjcYZF++SrJzb7h3GZMyyzCXcjjbMX7j4sycj/NFFi0b/h+qtbyEN8tzQ==
X-Received: by 2002:adf:e38e:0:b0:242:137d:9ce8 with SMTP id e14-20020adfe38e000000b00242137d9ce8mr2094071wrm.9.1671656811305;
        Wed, 21 Dec 2022 13:06:51 -0800 (PST)
Received: from localhost ([176.234.10.188])
        by smtp.gmail.com with UTF8SMTPSA id w12-20020a05600018cc00b002423edd7e50sm15851984wrq.32.2022.12.21.13.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 13:06:50 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH v5 0/4] PWM and keyboard backlight driver for ARM Macs
Date:   Thu, 22 Dec 2022 00:06:44 +0300
Message-Id: <20221221210648.2735-1-fnkl.kernel@gmail.com>
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

This is the v5 of the patch series to add PWM and keyboard
backlight driver for ARM macs.

Changes in v1:
Addressing the review comments.

Changes in v2:
Added the reviewed-by and acked-by tags.
Addressing a review comment.

Changes in v3 and v4:
Addressing the review comments.

v1: https://www.spinics.net/lists/linux-pwm/msg19500.html
v2: https://www.spinics.net/lists/linux-pwm/msg19562.html
v3: https://www.spinics.net/lists/linux-pwm/msg19901.html
v4: https://www.spinics.net/lists/linux-pwm/msg20093.html

Sasha Finkelstein (4):
  dt-bindings: pwm: Add Apple PWM controller
  pwm: Add Apple PWM controller
  arm64: dts: apple: t8103: Add PWM controller
  MAINTAINERS: Add entries for Apple PWM driver

 .../bindings/pwm/apple,s5l-fpwm.yaml          |  51 ++++++
 MAINTAINERS                                   |   2 +
 arch/arm64/boot/dts/apple/t8103-j293.dts      |  19 +++
 arch/arm64/boot/dts/apple/t8103-j313.dts      |  19 +++
 arch/arm64/boot/dts/apple/t8103.dtsi          |   9 +
 drivers/pwm/Kconfig                           |  12 ++
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-apple.c                       | 154 ++++++++++++++++++
 8 files changed, 267 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
 create mode 100644 drivers/pwm/pwm-apple.c

-- 
2.37.1 (Apple Git-137.1)

