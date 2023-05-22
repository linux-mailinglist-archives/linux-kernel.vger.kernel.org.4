Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B8770C3E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjEVRDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjEVRDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:03:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC57FA;
        Mon, 22 May 2023 10:03:44 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-208-162.ewe-ip-backbone.de [91.248.208.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CC430660574E;
        Mon, 22 May 2023 18:03:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684775022;
        bh=P4c4yqe0e18spr+hpAbUp22X4HYV0KWO766Aol9DUW4=;
        h=From:To:Cc:Subject:Date:From;
        b=EBmJWqi/ZLk9ozgXn3Uk8niKTpQ9V6r1b5yUvuAEHIZfVcgBR9MLUw621uHTb7kqR
         Jt91M7bpXMWa+ony0ysg/jxABWQYuEXogIRo6nxlXMwSIK0Wv2ocAxWzCHCWZ4X2pA
         9ZkhzKbjiSLv6R8hazEJCng+YDQ2FyGf1E//l/UYJzj9kLS9ESQLRO6wWUBpVzlq/H
         bYPQh7NHywsvdXULZda6ROIVjTREsOP7Mq5kfp6UWYU6+Ba/6Y3+VvJfD+D5UFgOT8
         cGoE+dBQ+pbVzcYyRnog/O9nQVnOZNVgIZOzd0p1qvOdE2hbZCCgklgoT1aUirNmNV
         QVXXOIlgmK7rg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 77AAB4805CC; Mon, 22 May 2023 19:03:40 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 0/7] phy-rockchip-inno-usb2: add RK3588 support
Date:   Mon, 22 May 2023 19:03:17 +0200
Message-Id: <20230522170324.61349-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This adds RK3588 to the Rockchip Inno USB2 PHY driver. The RK3588 has four of
them. Two are used for USB2 and two are used by USB3 controllers (for USB2
fallback mode). All of them can be used with this patchset.

Changes since PATCHv2:
 * https://lore.kernel.org/linux-phy/20230403202307.120562-1-sebastian.reichel@collabora.com/
 * Dropped patch adding the syscon compatible to the DT binding (applied by Heiko)
 * Collected Reviewed-by from Rob Herring for DT binding patch (DT binding)
 * Rebased to v6.4-rc1
 * Removed superfluous init found by Vinod Koul
 * Added one additional patch improving the error message for missing phy-config
 * Fixed address_cells=2 code to not break the PHY at offset 0. I didn't notice it with the
   previous versions, since that PHY is used for USB3 on Rockchip evaluation board and I
   only started working on that recently.

Changes since PATCHv1:
 * https://lore.kernel.org/all/20230331163812.6124-1-sebastian.reichel@collabora.com/
 * Added patch simplifying phyclk handling
 * Added patch simplifying matchdata handling
 * Added patches for reset handling and PHY tuning; after doing more
   testing I noticed my previous patchset does not support hotplug and
   USB devices need to be plugged in at boot time (more specifically
   in PATCHv1 it had to be plugged before the PHY is suspended). This
   fixes the issue.

-- Sebastian

Sebastian Reichel (7):
  dt-bindings: phy: rockchip,inno-usb2phy: add rk3588
  phy: phy-rockchip-inno-usb2: add rk3588 support
  phy: phy-rockchip-inno-usb2: add reset support
  phy: phy-rockchip-inno-usb2: add rk3588 phy tuning support
  phy: phy-rockchip-inno-usb2: simplify phy clock handling
  phy: phy-rockchip-inno-usb2: simplify getting match data
  phy: phy-rockchip-inno-usb2: improve error message

 .../bindings/phy/rockchip,inno-usb2phy.yaml   |  21 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 357 ++++++++++++++++--
 2 files changed, 339 insertions(+), 39 deletions(-)

-- 
2.39.2

