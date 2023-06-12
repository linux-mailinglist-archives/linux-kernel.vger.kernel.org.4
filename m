Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8654E72CC2C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbjFLRN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjFLRNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:13:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034D710DA;
        Mon, 12 Jun 2023 10:13:42 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-210-131.ewe-ip-backbone.de [91.248.210.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0FFA76606ECF;
        Mon, 12 Jun 2023 18:13:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686590021;
        bh=Bf6eekQkfS+tNXR2hhMUzuVzPovEGfpI2wuTSi/+qNc=;
        h=From:To:Cc:Subject:Date:From;
        b=NKDg3R0ad4nTEofp9OPAxRwYSdVaJxwT44lcjFXKI4d7Xi+5x+bUQeGodtmYcg7lZ
         CihWkGiV4YQGWK0XibuOsYBhPhKvBq5n2q++XkW34XRUU7hjedZvPWK45C6asQeytv
         7HIznFxvsgFI2iSPYWq2Og73UhKwcKR99m82VmfFF9xtDaK7ErRHrShNnGe3Dv/OLq
         BxYQbL67gBRVTOiG6Ts2iXwQgF5eUKvIU8/JItn9ZnimR5FsMTOqmWhysOgYFujqvh
         Erp6KzRT109vU4ITvW+boUVxDRrWiJ9BODaLFbxN2cl7ZFC/CkhdyMdhf/3wftK5xL
         wqxHgQwAIUznw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id A23304805CC; Mon, 12 Jun 2023 19:13:38 +0200 (CEST)
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
Subject: [PATCH v4 0/5] Add RK3588 SATA support
Date:   Mon, 12 Jun 2023 19:13:32 +0200
Message-Id: <20230612171337.74576-1-sebastian.reichel@collabora.com>
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

Changes since PATCHv3:
 * https://lore.kernel.org/all/20230608162238.50078-1-sebastian.reichel@collabora.com/
 * Add Reviewed-by from Serge and Krzysztof to patch 1
 * Update patch 2
   - Add maxItems to 'clocks' property; without specifying minItems it's
     implied to be the same
   - Keep allOf above the properties in snps,dwc-ahci.yaml
   - Add 'sata-port@0' to list of allowed properties
   - Replace sata-port pattern property, so that it disallows using any
     sata-port nodes besides @0 to override the pattern property from the
     common binding
 * Add Reviewed-by from Krzysztof to patch 3

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

 .../bindings/ata/rockchip,dwc-ahci.yaml       | 124 ++++++++++++++++++
 .../bindings/ata/snps,dwc-ahci-common.yaml    |   8 +-
 .../bindings/ata/snps,dwc-ahci.yaml           |  13 +-
 .../phy/phy-rockchip-naneng-combphy.yaml      |  34 ++++-
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      |  44 +++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |  90 +++++++++++++
 6 files changed, 306 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml

-- 
2.39.2

