Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B316F2430
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 12:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjD2Kp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 06:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjD2Kp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 06:45:56 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A5F1FCD;
        Sat, 29 Apr 2023 03:45:55 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-506b2a08877so1150534a12.2;
        Sat, 29 Apr 2023 03:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682765153; x=1685357153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WTQTEbLPt4h9veixLWM+5ZtwRhk8Wsy+ewL1TGUe3D0=;
        b=oH5Kvm5drzQdcOXTiqEwKZhd7EmXTc4PzAK03AaVxM3T9Y3Z4v02nzKRQw+JKmLXDa
         hHfP3cVaROpARK80o9Px6dby16oN8U2ony8aEDqo8HHSJYrw5t9GKqy0MYpUDPsSctle
         CB5SFrTFkL7WFcReoHDaLQ+ZnfqxjD9ApSysyxIZqU9aGCQTW2yGDXSgWl+dwsvJesdi
         o3Ip7JbO0A3s2iZ9i4dUvZ2Whyo6X392jfNqd8+xo4TXHXLJUPAeM5t4MwR6TarTO9Uu
         aTa8+CWtcK4O+7PvC/eVLW87vMxxlDlsx4436E1Hf3iuF1Fbl8XLaxy6kbTgA48kCq1x
         A1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682765153; x=1685357153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTQTEbLPt4h9veixLWM+5ZtwRhk8Wsy+ewL1TGUe3D0=;
        b=KJKcNnQz/K4qo840e0i52cHK5FBN8Fecfg/r38iaC5aQ3ec41FXYatMVJkW7h5Uqef
         pbu+SDVnJCowHLQ2qSRIoayA5f5tP1KP+epa5hqXtGXhS8E0pMpYqOenUJUmxQLaGnM7
         +Te6ogx6Nm6k8Brz346mlf8l4gKNIYAK6rJzkaXDysVtY+IT9Did4WO7qdxUIEVzFW8s
         sBt9Zku8dav7a8BxRtX/nUivEht+t279Np1THpbq3g7dV6p0amHmfJe06VAWsRkFkzOS
         aH4dq+O8zke96l9YJhQCeUsE1vplqIo52nI1h5tzowKOu3Dod6WhgaUx0VyOURM7tN15
         7maQ==
X-Gm-Message-State: AC+VfDyzEAU3nO6bLZynWFVHn/JL7bQid25mB06bP6P25V3U8zra/aWG
        W9HUlDSCE8shR7Cym+COV9E=
X-Google-Smtp-Source: ACHHUZ4x/Gdg5OzSrpmM9phfXhSpLi+EARAapUnJz09J7J4N94Z160t6oxkz+44oNxD3ND2gGUwSvg==
X-Received: by 2002:aa7:d547:0:b0:4fc:709f:7abd with SMTP id u7-20020aa7d547000000b004fc709f7abdmr1241415edr.2.1682765153465;
        Sat, 29 Apr 2023 03:45:53 -0700 (PDT)
Received: from localhost.my.domain (83.8.115.30.ipv4.supernova.orange.pl. [83.8.115.30])
        by smtp.gmail.com with ESMTPSA id b11-20020a056402138b00b004bd6e3ed196sm9952522edv.86.2023.04.29.03.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 03:45:53 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Helge Deller <deller@gmx.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Artur Weber <aweber.kernel@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 0/4] video: backlight: lp855x: modernize bindings
Date:   Sat, 29 Apr 2023 12:45:30 +0200
Message-Id: <20230429104534.28943-1-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert TI LP855X backlight controller bindings from TXT to YAML and,
while we're at it, rework some of the code related to PWM handling.
Also correct existing DTS files to avoid introducing new dtb_check
errors.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

Artur Weber (4):
  dt-bindings: backlight: lp855x: convert to YAML and modernize
  video: backlight: lp855x: get PWM for PWM mode during probe
  ARM: dts: adapt to LP855X bindings changes
  arm64: dts: adapt to LP855X bindings changes

 .../leds/backlight/lp855x-backlight.yaml      | 148 ++++++++++++++++++
 .../bindings/leds/backlight/lp855x.txt        |  72 ---------
 .../dts/qcom-apq8026-samsung-matisse-wifi.dts |   1 -
 ...-msm8974pro-sony-xperia-shinano-castor.dts |  23 +--
 .../boot/dts/nvidia/tegra210-p2371-2180.dts   |   6 +-
 drivers/video/backlight/lp855x_bl.c           |  48 +++---
 6 files changed, 188 insertions(+), 110 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/lp855x-backlight.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/lp855x.txt


base-commit: e154a338e16cc3b3bbd54c891253319d22383746
-- 
2.40.1

