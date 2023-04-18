Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6149C6E670B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjDROVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjDROVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:21:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DD313FB0;
        Tue, 18 Apr 2023 07:21:13 -0700 (PDT)
Received: from jupiter.universe (unknown [91.248.213.255])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 592C9660320E;
        Tue, 18 Apr 2023 15:21:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681827671;
        bh=ll23Gil5LaleEG/Y/J2yGHu05FB8zSy5xWoGgPJ7WLU=;
        h=From:To:Cc:Subject:Date:From;
        b=RKWtWzfVtiuLDbkEEiMwaqtjxGFX+pL93U8HTPp38zbBsq5v9fP12PoPCIEgGwgCI
         WF0an6ib9Vip/4hhBI4DlHma92HbJkZpiI7uIOLHyrqQqkllnZ2YfhoGNJGToB3vWK
         FB2o4QOSpgkXkdJ6dWgbECKCDaV0XWp2Kxd8akOrdPjXVlk5ltF9LBwODpIqWW/JsE
         OtPGr8LW/tlQzihEDK4IAkoRrj9gqKELkYbro1emErzXixKRayusjPJ7UQkBBwtQKJ
         vshV4MNT6soQVDtfQAgBLKW9u/g1bDGWJRZjz02Piyn2JDd6n+YQN6Pi9m903OWZBy
         nk6pjGdM5ZVCw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 85AB2480072; Tue, 18 Apr 2023 16:21:09 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Marc Zyngier <maz@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Peter Geis <pgwipeout@gmail.com>,
        XiaoDong Huang <derrick.huang@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 0/2] Add Rockchip RK3588 GIC ITS support
Date:   Tue, 18 Apr 2023 16:21:07 +0200
Message-Id: <20230418142109.49762-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This adds GIC ITS support to Rockchip RK3588, which is affected
by an integration issue effectively breaking shareability support.
PCIe2 support will follow in its own series.

Changelog:
 * Changes since PATCHv3
  - https://lore.kernel.org/lkml/20230417214035.101190-1-sebastian.reichel@collabora.com/
  - Add RB from AngeloGioacchino Del Regno
  - Update patch description
  - Update Kconfig description
  - rename flags from BROKEN_SHAREABILITY to FORCE_NON_SHAREABLE
 * Changes since PATCHv2
  - https://lore.kernel.org/lkml/20230417150038.51698-1-sebastian.reichel@collabora.com/
  - apply changes requested by Marc Zyngier
 * PATCHv1
  - https://lore.kernel.org/lkml/20230227151847.207922-1-lucas.tanure@collabora.com/
  - uses of_dma_is_coherent() instead of providing errata info from kernel
 * RFCv1
  - https://lore.kernel.org/lkml/20230310080518.78054-1-lucas.tanure@collabora.com/
  - uses 0x0201743b IIDR for quirk detection and misses errata #

Greetings,

-- Sebastian


Sebastian Reichel (2):
  irqchip/gic-v3: Add Rockchip 3588001 erratum workaround
  arm64: dts: rockchip: rk3588: add GIC ITS support

 Documentation/arm64/silicon-errata.rst    |  3 ++
 arch/arm64/Kconfig                        | 10 +++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 17 +++++++++++
 drivers/irqchip/irq-gic-v3-its.c          | 35 +++++++++++++++++++++++
 4 files changed, 65 insertions(+)

-- 
2.39.2

