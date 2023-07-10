Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBD274D4CA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjGJLuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjGJLue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:50:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC6FC4;
        Mon, 10 Jul 2023 04:50:32 -0700 (PDT)
Received: from obbardc-t14.home (unknown [IPv6:2a00:23c8:b70a:ae01:f690:3e44:90e:2421])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F34326606F65;
        Mon, 10 Jul 2023 12:50:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688989830;
        bh=JumdZYtvxLtSAoNuus3Vk18IRLG+75lEolvKS608bXw=;
        h=From:To:Cc:Subject:Date:From;
        b=SyQA4C4YrHxruum9uozCSEyOzdJEYVKhNzUFcSM8smtOmhrKedlIKMkVwUvSQYzEM
         2cs3s6LCDPHuxsgKXrDTyf/UkqYJdegxvqnl0EjYEMmPWIuPZeHyJhmJ1AETF9y9RY
         TF/5UQmADD62eiHbcI8ERhwQsuD74ZBJ/JKAouwlb9h8DVtAQlgIFRqBSO56z6Jc6v
         IcsjbAcvsUYw3aoDmp2sY2beFbmp1kfQKJfxprE4TyHEujQzF4Z2lwOcPbS7F3m/tG
         U1V74jNBgUJH97V9yjk8DMPJYdYhP7oNCPTHf++6XfhjgCdRT8jUt1o+s6ZWt38ldZ
         c+ajVcanpSeqA==
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     linux-rockchip@lists.infradead.org
Cc:     kernel@collabora.com,
        Christopher Obbard <chris.obbard@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>, Andy Yan <andyshrk@163.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        FUKAUMI Naoki <naoki@radxa.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tianling Shen <cnsztl@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add support for Radxa ROCK 4SE
Date:   Mon, 10 Jul 2023 12:50:22 +0100
Message-Id: <20230710115025.507439-1-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the RK3399T-based Radxa ROCK 4SE board. This board offers
similar peripherals and form-factor to the ROCK Pi 4B but uses the
cost-optimised RK3399T processor (which has different a OPP table but
otherwise minimal changes) and some other minor hardware changes between
the Rock Pi 4B (described in the devicetree).

The first patch moves the RK3399 OPP table from the generic Radxa ROCK
Pi 4 dtsi into board-specific devicetree files, in preparation for the
ROCK 4SE devicetree file (in later patches).

The second patch adds the devicetree binding documentation for the Radxa
ROCK 4SE.

The third patch adds the board-specific devicetree file for the Radxa ROCK
4SE.

Changes in v2:
- Add Krzysztof Kozlowski's Acked-by tag.
- Set proper interrupt type for brcmf.

Christopher Obbard (3):
  arm64: dts: rockchip: Move OPP table from ROCK Pi 4 dtsi
  dt-bindings: arm: rockchip: Add Radxa ROCK 4SE
  arm64: dts: rockchip: Add Radxa ROCK 4SE

 .../devicetree/bindings/arm/rockchip.yaml     |  5 ++
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../boot/dts/rockchip/rk3399-rock-4se.dts     | 65 +++++++++++++++++++
 .../boot/dts/rockchip/rk3399-rock-pi-4.dtsi   |  1 -
 .../boot/dts/rockchip/rk3399-rock-pi-4a.dts   |  1 +
 .../boot/dts/rockchip/rk3399-rock-pi-4b.dts   |  1 +
 .../boot/dts/rockchip/rk3399-rock-pi-4c.dts   |  1 +
 7 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-4se.dts

-- 
2.40.1

