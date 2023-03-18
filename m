Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82DA6BF90A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 09:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCRIiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 04:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCRIiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:38:04 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85626AA70D;
        Sat, 18 Mar 2023 01:37:49 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id bf15so3320494iob.7;
        Sat, 18 Mar 2023 01:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679128669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uj5y3Q4bbaamaIyxx6XTYPdTTmcpPBcLA68lxFuK26s=;
        b=eqsU7mQnCU1oCif1caT2y8sIPcuMf0EDImnoZXbeye6yPxrfwiGnbEjzrczpFxXA27
         vCH8RdmkPzEdtdRNadxPzuS9ljOda0vH/AvAlvM5JciF01m+7dUMJceZLjmYm+1T6zTg
         Hn+Oeq7BkpYN7tih24v8HUwUBfQpUjQK1I2Hqs2bKPC9teKYHk5qNs4mPpMFpJFlHyyo
         gRd8Vts13+DyNRfy66MIAsX3NfizOcVgW7zRgkUG8Eoi9m7RVUA0NkBYxBZsHqU1pUNO
         p/7IofjzS9NyLIoyditHN9RhXjb82GWMxfX9OXvlvO0GHpjiUw1uptk9AVe9o9TYEGGe
         YYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679128669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uj5y3Q4bbaamaIyxx6XTYPdTTmcpPBcLA68lxFuK26s=;
        b=R4NTLwoBgLVoWVxeXCkAu/EeOkIckxK+M2WKYRfyIJ4jp+I2HSw2fJF0Z2AtddqcBQ
         m4sWJmhs+NPkAhrxdQTFWK8u4L3/yoHbMp0ED+IGsgLg+0pcYOfn3W4oYBTtZcTNbH/j
         JPPViMNVFzmiuph3cmFsPo2lRgSvaPAla7JWpdAWfmk4KUKp6It7pOyDab5q/y/4HKuk
         HJUH7SPRknmJjPv8Qwc1l3DXn0OF+VhM2IENNldNkYykvv86DJWXCMNSOVVBWV9CMOgI
         stDf02WzcyEpk8Su5N65qpDoTLIf8DUCLnihfA0ioqweJTHsgWZMkGStjPRcYEfELt9S
         oY3g==
X-Gm-Message-State: AO0yUKULXOJlQGvuStZyv/zUIjMRt0rl2cF0jBCt+lTmyEtYY4w5XlQL
        AEmsIN4/xgb69FG2aHIcWKk=
X-Google-Smtp-Source: AK7set/4EcmtmNA4FIZASjWPhDetnke0wB4EEkQW/9c3Re/qzQHjJSrKhIOwnrev5Kn5CdG91I38uQ==
X-Received: by 2002:a6b:441a:0:b0:752:ed8f:2e9f with SMTP id r26-20020a6b441a000000b00752ed8f2e9fmr941373ioa.13.1679128668822;
        Sat, 18 Mar 2023 01:37:48 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id h8-20020a6b7a08000000b00746041ecbf9sm1174834iom.39.2023.03.18.01.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 01:37:48 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Peter Geis <pgwipeout@gmail.com>, Andy Yan <andyshrk@163.com>,
        Tianling Shen <cnsztl@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Andrew Powers-Holmes <aholmes@omnom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] arm64: dts: rockchip: improve support for NanoPi R5 series
Date:   Sat, 18 Mar 2023 16:37:40 +0800
Message-Id: <20230318083745.6181-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
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

Hi, this patchset added new device NanoPi R5C and some minor fixes
(gmac, i2s1) for the NanoPi R5S.

Changes since v1:
- https://lore.kernel.org/linux-rockchip/20230315160228.2362-1-cnsztl@gmail.com/
- Added Fixes tag
- Collected Acked-by tag
- Fixed a typo error in dt-bindings (board -> boards)
- Removed non-existent audio node for NanoPi R5 series
- Updated my E-mail in NanoPi R5C dts

Tianling Shen (5):
  arm64: dts: rockchip: create common dtsi for NanoPi R5 series
  dt-bindings: Add doc for FriendlyARM NanoPi R5C
  arm64: dts: rockchip: Add FriendlyARM NanoPi R5C
  arm64: dts: rockchip: fix gmac support for NanoPi R5S
  arm64: dts: rockchip: remove I2S1 TDM node for the NanoPi R5 series

 .../devicetree/bindings/arm/rockchip.yaml     |   6 +-
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-nanopi-r5c.dts   | 112 ++++
 .../boot/dts/rockchip/rk3568-nanopi-r5s.dts   | 582 +----------------
 .../boot/dts/rockchip/rk3568-nanopi-r5s.dtsi  | 590 ++++++++++++++++++
 5 files changed, 710 insertions(+), 581 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5c.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi

-- 
2.40.0

