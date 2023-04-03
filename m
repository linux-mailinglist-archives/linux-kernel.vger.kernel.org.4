Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FD46D523A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjDCUXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDCUXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:23:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF78198E;
        Mon,  3 Apr 2023 13:23:13 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-212-192.ewe-ip-backbone.de [91.248.212.192])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A86EB660312D;
        Mon,  3 Apr 2023 21:23:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680553391;
        bh=sQ6dRJmgA+DiW2bmxGnApVDBaMlLaTvrDqylSpALvFc=;
        h=From:To:Cc:Subject:Date:From;
        b=EoITfGwZIX9Zfs4sZSAl39HzDrn0fzFHU1fHHb9y5O114oaC5djzz+xfH0OUjtuBb
         KOfM5zPFjgtv0nSq7KmJn7wXHcEGev33Whs72/o8cL+EauuQ/EAlOYA+HN0f8U37oJ
         vgVR0jPlMFfmB3M5lgJRcwZ5kzUgNhlrazeBDTEdX2CrpycNRoIzO3LzlC0ZahvHxO
         llifpkvFfN5PQbLHgpNC19Nco+HTyHFqKcHkUX9hMl4gZC5+WmmhkKWKYdM+xmTW1g
         wnUgdmEnNzj+Y955LL85RhYAnCyuQYVXS+A1JQxs05oDBu1mvybT+GJ9H9h6gCozRL
         TRV8zIyaCeePg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 08AF74807E1; Mon,  3 Apr 2023 22:23:09 +0200 (CEST)
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
Subject: [PATCHv2 0/7] phy-rockchip-inno-usb2: add RK3588 support
Date:   Mon,  3 Apr 2023 22:23:00 +0200
Message-Id: <20230403202307.120562-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This adds RK3588 to the Rockchip Inno USB2 PHY driver. I have tested this
with USB2_0 and USB2_1.

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
  dt-bindings: soc: rockchip: add rk3588 usb2phy syscon
  dt-bindings: phy: rockchip,inno-usb2phy: add rk3588
  phy: phy-rockchip-inno-usb2: add rk3588 support
  phy: phy-rockchip-inno-usb2: add reset support
  phy: phy-rockchip-inno-usb2: add rk3588 phy tuning support
  phy: phy-rockchip-inno-usb2: simplify phy clock handling
  phy: phy-rockchip-inno-usb2: simplify getting match data

 .../bindings/phy/rockchip,inno-usb2phy.yaml   |  21 +-
 .../devicetree/bindings/soc/rockchip/grf.yaml |   2 +
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 352 ++++++++++++++++--
 3 files changed, 339 insertions(+), 36 deletions(-)

-- 
2.39.2

