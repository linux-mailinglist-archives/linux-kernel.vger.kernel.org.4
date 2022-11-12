Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C23E6269C7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 15:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiKLOLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 09:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLOLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 09:11:41 -0500
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E801510B6D;
        Sat, 12 Nov 2022 06:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
        Content-Description:In-Reply-To:References:X-Debbugs-Cc;
        bh=qDnpKfCINF8AaQCM/kdrtaCelB7JbA9OSxlcTKm9qWQ=; b=pNulBD0gRNWpXF4O08o85Nzx/h
        LZR1zb0kVwNQXbGunQUaplLJIu0Zn1xOZjQJizpv07a/KfEhzHtqnUI7eeWoR/04uxvIMie0y2lxI
        fL1F0gy0GeEJtcmAKt2nn3mUUi/nza8wNegRPq8YW7myY9NgnNSrnt3QmlMD82DZg1H6CKwwKymYG
        t0VTWA6AzJZaCEhqY/1G0T17nkSuSn4Ce6kceqnX6+SmGTS2pDlgdBm5XbDZa+aPaMbQ70gnYUOp5
        oVmvzrFh9yHw5odv4rE+I2ad4X+s+XXu7dIGRcB87nkMJdxxyD+YCz4fYtxeqb/1fG+GGUVzrVpCZ
        0uNOOnSQ==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1otrE5-00AbQy-GS; Sat, 12 Nov 2022 15:11:17 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1otrE4-00FxDe-2G;
        Sat, 12 Nov 2022 15:11:16 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lin Jinhan <troy.lin@rock-chips.com>
Cc:     linux-crypto@vger.kernel.org (open list:HARDWARE RANDOM NUMBER
        GENERATOR CORE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
        linux-kernel@vger.kernel.org (open list),
        Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v1 0/3] hwrng: add hwrng support for Rockchip RK3568
Date:   Sat, 12 Nov 2022 15:10:56 +0100
Message-Id: <20221112141059.3802506-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockchip SoCs used to have a random number generator as part of their
crypto device, and support for it has to be added to the corresponding
driver.

However newer Rockchip SoCs like the RK3568 have an independent True
Random Number Generator device. This patchset adds a driver for it and
enable it in the device tree.

Aurelien Jarno (3):
  dt-bindings: RNG: Add Rockchip RNG bindings
  hwrng: add Rockchip SoC hwrng driver
  arm64: dts: rockchip: add DT entry for RNG to RK356x

 .../devicetree/bindings/rng/rockchip-rng.yaml |  62 +++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |   9 +
 drivers/char/hw_random/Kconfig                |  14 +
 drivers/char/hw_random/Makefile               |   1 +
 drivers/char/hw_random/rockchip-rng.c         | 251 ++++++++++++++++++
 5 files changed, 337 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/rockchip-rng.yaml
 create mode 100644 drivers/char/hw_random/rockchip-rng.c

-- 
2.35.1

