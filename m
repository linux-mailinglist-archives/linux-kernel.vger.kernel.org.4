Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FD76C8C3D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 08:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCYHk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 03:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCYHk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 03:40:28 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3355267;
        Sat, 25 Mar 2023 00:40:27 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id n125so4839667ybg.7;
        Sat, 25 Mar 2023 00:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679730026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rYsDanyFIFeDSw0nKRS4qdlqbTjBz25V3/PJAUjnPhI=;
        b=cJ2pOCHq2roMIGE7y56sK4+Y1Ez+n9X9FjvFc4STQcE4BnhdVBB8vN/5gGZwYB5z4T
         n2ueTvW4Qjdv2inJf9st+Wj9r7u4pQAL0vELkFaNfVFuS+KH13hrM69ChquyHgud+wyk
         UZM54S+QjlVUTC1bov2L1EUuEYY1frv7k2sL6LzPpF0OfoAuQJBFtp18iPH9tOBIgVoZ
         JUs53gityYzkL85dAMd/CjHIXi3LJmunY4z2jGXKxfDoQi5FyjC03ngWZ7zmERpjMG3R
         l7910vJbctm4yWM6Oxn+oSD64k1wiY5JqSlIOJE7X/b/eiOfLXPs3hw91GYR5WCbnCEz
         akYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679730026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYsDanyFIFeDSw0nKRS4qdlqbTjBz25V3/PJAUjnPhI=;
        b=CmgNYbGVuPy2oJdPTZFEoOyaeEjzAtMFOUa6P744MAvJ9EG8bIQnOE05mNIw6tCO1z
         wjlkPYsThpP2lMmBohqMDnQV8t/Z93wmEgqUAWnQ0L9NsocvjyBTF+SyyPGW3jUrf2LY
         iEFomsU6Gwr2GqLDeiHc7VVXRqvahowam0M8ZIc0AbQRvi7Mb4CxP8LC0z3c9kyU6pKa
         CjvfNP+Z7yisUSPuGOqLkOqQ4zGRREPFvAX7JQQsgplpD8YETK9nWrJ8N+b8Ze7XObIh
         j4FkoP8eEXdFYg2ZH3X5M7DSNSNfzA67LPKEYOk3NpBk8Jh1HeyaZ5e+JUN2XM9T6WDy
         GI2A==
X-Gm-Message-State: AAQBX9eTHCboxlV2cHUGNCrIZCr44UB3W0JqMWVm55mfAx5F1cmKip6X
        rnIdvYMptL+6LswKmqyRVyU=
X-Google-Smtp-Source: AKy350YBztxmYOrO82qvnRcnyHLBYIfQ+edDVxGjdeutSueof48FJ8pb1sKRae6EsG8leonu3IRT7Q==
X-Received: by 2002:a25:db4b:0:b0:b6a:51c9:d7ba with SMTP id g72-20020a25db4b000000b00b6a51c9d7bamr4845084ybf.20.1679730026306;
        Sat, 25 Mar 2023 00:40:26 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id w20-20020a25c714000000b00b7767ca7498sm969629ybe.53.2023.03.25.00.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 00:40:25 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Tianling Shen <cnsztl@gmail.com>, Andy Yan <andyshrk@163.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Vincent Legoll <vincent.legoll@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Add support for NanoPi R2C and OrangePi R1 Plus LTS
Date:   Sat, 25 Mar 2023 15:40:18 +0800
Message-Id: <20230325074022.9818-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this patchset adds two new boards using the Motorcomm NIC which
got supported/fixed in kernel v6.3:

* FriendlyARM NanoPi R2C - yt8521s
* Xunlong OrangePi R1 Plus LTS - yt8531c

Changes since v1:
* https://lore.kernel.org/linux-rockchip/20230323123807.11882-1-cnsztl@gmail.com/
* Updated dt-binding description for NanoPi R2C

Tianling Shen (4):
  dt-bindings: Add doc for FriendlyARM NanoPi R2C
  arm64: dts: rockchip: Add FriendlyARM NanoPi R2C
  dt-bindings: Add doc for Xunlong OrangePi R1 Plus LTS
  arm64: dts: rockchip: Add Xunlong OrangePi R1 Plus LTS

 .../devicetree/bindings/arm/rockchip.yaml     | 12 ++++--
 arch/arm64/boot/dts/rockchip/Makefile         |  2 +
 .../boot/dts/rockchip/rk3328-nanopi-r2c.dts   | 40 +++++++++++++++++++
 .../rockchip/rk3328-orangepi-r1-plus-lts.dts  | 40 +++++++++++++++++++
 4 files changed, 90 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts

-- 
2.40.0

