Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD176BB8F8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjCOQDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjCOQDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:03:24 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C249F769C6;
        Wed, 15 Mar 2023 09:02:52 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id h11so5317253ild.11;
        Wed, 15 Mar 2023 09:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678896172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2aBbm9JNzxZf/5Es771aqwdKA5ulU2AUAgnhTScsKOU=;
        b=JPGLRbfw0oafn4hqfinB+/WmSXcV0r+6HKtrkuWKTdX0HMpqs7eluX/l9vosleBaxe
         c5+gnJzRwQlm97NMXrjv5VuC9OTwZWBjLJttJF7YOyVbKwV1N4GCIJyy1ZiO1h18yJet
         zv5XwngUxFvJz2CDWdp+Ua/2XNJZkA0+E7JiUCATy8kg7yh5y955v5LeQEtgU6Vmh3/5
         5Bc5qFavb/GNE6McR8YcYHvORLXLicVPK8twYgQs0plsyNYu+PImaU4ey5x6gGZiG76n
         IL9TkjuUP28MQ0NWH9zm52q7H2c6sfj2g6+4tWE23Fe67498TEf9046iSuPXCYlSUkrF
         /aVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678896172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2aBbm9JNzxZf/5Es771aqwdKA5ulU2AUAgnhTScsKOU=;
        b=R40grdI8dbPUzgjvfCbSe8KmzJIkfYOHz+xXUgBUgLP+HhPRZTq7v1qG/7MFG8+9of
         AUbRJWWISZvjkZAeDvImFgIApvxcG1X4yQaaF4Y5T7p0Bg1VA8BmB+J6Po+OnAQOf57N
         rVTRLLIloSyUe7NqGqjvgcPgFdE7NkZJ32PnrqhKjUCZppaVQqm0X8EjneJU2E6MP0cN
         m3tRcNUZRr4BLQ/jmJwt3jTwwSW7lOd2w95vdTcN5nAeGGgBAZ6R3D6a676aYgO5sUSK
         nHIjIYqcDt/9nCIOzrMhe0P8nSegmn7TW0H1ybXJyjtMtkUbh5SjgvKwimnWjrydgOA2
         QMsg==
X-Gm-Message-State: AO0yUKVITrXj/Meg6dwTl1hfWilT2hBg8FR0zkCmkU87Fd7j3pPImY5c
        0pGIhNatlYMkO2gQjWqX/Tddi3FDt5OdAQ==
X-Google-Smtp-Source: AK7set+s4R8QTN//+CuBe3wKC8Ujg7F8GXkcQBVQ+aIUzuMvegvUyczAeH/+Jwvl7uY4FGKz8pZ7ig==
X-Received: by 2002:a92:db06:0:b0:323:38b:549b with SMTP id b6-20020a92db06000000b00323038b549bmr5131486iln.31.1678896171989;
        Wed, 15 Mar 2023 09:02:51 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id l2-20020a92d942000000b00313fa733bcasm1730725ilq.25.2023.03.15.09.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 09:02:51 -0700 (PDT)
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
Subject: [PATCH 0/5] arm64: dts: rockchip: improve support for NanoPi R5 series
Date:   Thu, 16 Mar 2023 00:02:23 +0800
Message-Id: <20230315160228.2362-1-cnsztl@gmail.com>
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

- Added NanoPi R5C support
- Enable rk809 support for NanoPi R5 series
- Minor fixes for NanoPi R5S gmac

Tianling Shen (5):
  arm64: dts: rockchip: create common dtsi for NanoPi R5 series
  dt-bindings: Add doc for FriendlyARM NanoPi R5C
  arm64: dts: rockchip: Add FriendlyElec NanoPi R5C
  arm64: dts: rockchip: fix gmac support for NanoPi R5S
  arm64: dts: rockchip: enable rk809 audio codec on the NanoPi R5 series

 .../devicetree/bindings/arm/rockchip.yaml     |   6 +-
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-nanopi-r5c.dts   | 112 ++++
 .../boot/dts/rockchip/rk3568-nanopi-r5s.dts   | 582 +----------------
 .../boot/dts/rockchip/rk3568-nanopi-r5s.dtsi  | 611 ++++++++++++++++++
 5 files changed, 731 insertions(+), 581 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5c.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi

-- 
2.17.1

