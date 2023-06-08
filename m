Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394527284C3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbjFHQWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjFHQWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:22:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4582119;
        Thu,  8 Jun 2023 09:22:43 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-189-092.ewe-ip-backbone.de [91.248.189.92])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D5F2C6606F20;
        Thu,  8 Jun 2023 17:22:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686241362;
        bh=FUovyx4uZxMWc91RhE6Xo+afuqEOehrwcyAViHLU/HU=;
        h=From:To:Cc:Subject:Date:From;
        b=Yk8lAERkgxCLZNAqSBy1hIwruaRpomWHSkmnjueVD2xRurgWIKlFfR7MklkAJzcql
         l/ccXmgzN9Ovua+guJXIfaUt9fz9BUw8i8oZF4aXiQyESB5kicYSy3xxwViHRB70iR
         hVyVyVl4D2fuoWnJpk5THwUNvwWmEkfF5EhIcuy65zcZZBczmxWW8AfTlWcZj6ZYsi
         emshVIjAMw6ZtlfvRvpQM45eaVaB38Nlbda/0by76tuN1QJDflWDGpK/X5RghUWZ7r
         3Hm15WPlVce2dtRRxx8tVXorV8KQ1W4r+I2fNfwq0p0DFyqjat51PH69g/5rkz2OfH
         ZyXjyuX98gWKQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id C848F4805CC; Thu,  8 Jun 2023 18:22:39 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 0/5] Add RK3588 SATA support
Date:   Thu,  8 Jun 2023 18:22:33 +0200
Message-Id: <20230608162238.50078-1-sebastian.reichel@collabora.com>
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

This enables SATA support for RK3588.

Changes since PATCHv2:
 * https://lore.kernel.org/all/20230522173423.64691-1-sebastian.reichel@collabora.com/
 * Drop patch 1 (applied by Heiko)
 * Update SATA DT binding to split Rockchip into its own file
 * Enforce correct resets numbers for the rk3568/rk3588 combo PHY

Changes since PATCHv1:
 * https://lore.kernel.org/all/20230413182345.92557-1-sebastian.reichel@collabora.com/
 * Rebase to v6.4-rc1
 * Collect Acked-by for syscon DT binding update
 * Use ASIC clock description suggested by Serge Semin
 * Also add RBC clock (not used by RK3588)
 * Add extra patch narrowing down the allowed clocks for RK356x and RK3588

-- Sebastian

Sebastian Reichel (5):
  dt-bindings: ata: dwc-ahci: add PHY clocks
  dt-bindings: ata: dwc-ahci: add Rockchip RK3588
  dt-bindings: phy: rockchip: rk3588 has two reset lines
  arm64: dts: rockchip: rk3588: add combo PHYs
  arm64: dts: rockchip: rk3588: add SATA support

 .../bindings/ata/rockchip,dwc-ahci.yaml       | 114 ++++++++++++++++++
 .../bindings/ata/snps,dwc-ahci-common.yaml    |   8 +-
 .../bindings/ata/snps,dwc-ahci.yaml           |  17 ++-
 .../phy/phy-rockchip-naneng-combphy.yaml      |  34 +++++-
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      |  44 +++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |  90 ++++++++++++++
 6 files changed, 298 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml

-- 
2.39.2

