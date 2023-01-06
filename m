Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84CC660328
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbjAFP3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbjAFP3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:29:02 -0500
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515668CD09;
        Fri,  6 Jan 2023 07:29:00 -0800 (PST)
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
        by mxout3.routing.net (Postfix) with ESMTP id 4ECAD603D5;
        Fri,  6 Jan 2023 15:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1673018938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VlzESD4AMk00u+w+7MAyrnnGklzWyK8ppGmGNp+UR0Y=;
        b=iYOKjdIBw69DVeQTSxdvEfTa7z0YG38I7Ud2d/IR7ypZSET8zzgJzAupernvaoSNLmYa4x
        dy74jzsitVgCZLYhwVVSrQxgLosWCzdl0RqwV+1osYdy3N5ejdkyCsiNFecezcUo5ciYTC
        J3JrHT+WwEbdm/hBGjFjuZ8tev0hKM8=
Received: from frank-G5.. (fttx-pool-217.61.159.6.bambit.de [217.61.159.6])
        by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 977C31226D4;
        Fri,  6 Jan 2023 15:28:57 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/5] Add BananaPi R3
Date:   Fri,  6 Jan 2023 16:28:40 +0100
Message-Id: <20230106152845.88717-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This Series adds some Nodes to mt7986 devicetree and the BananaPi R3

This version is rebased on linux 6.2-rc1 and i dropped already applied
Patches from v7.

i had run full dtbs-check but i end up with some strange warnings in
ethernet-node that should not come up as phy-handle and sfp/managed
properties are already defined. These errors also came up for mt7986a-rfb.

phy-handle made optional
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/mediatek,net.yaml#n265

property sfp/managed (which is included for mac subnode in yaml above):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/ethernet-controller.yaml#n137

changes:
v9:
- drop model string override in sd-dtso

v8:
- drop model string override in emmc-dtso
- drop cs-gpios from spi-nodes
- add interrupt-settings for mt7531 switch

v7:
- rebase on next so dropped already applied patches
- squashed overlay-patch into the bpi-r3 base support
- moved regulators from mmc-dts to common dtsi
- changed dtsi to dts (as board base dtb) and mmc-dts to overlays
- renamed overlays to dtso
- removed angelos RB because of changes in bpi-r3 patch

v6:
- dropped regulators from usb-patch as suggested by chunfeng yun
- moved 3v3 regulator to mmc-patch as it is needed for emmc to work
  rfbs were tested by sam shih, r3 by me
- dropped RB from AngeloGioacchino from mmc-patch due to this change
- fixed links in coverletter which were broken in v5
- i hope this series is sent without errors now (my mailprovider limited
  mails last 2 times while sending part 10)

v5:
- changed usb ranges/reg/unit-adress
- added reviewd-by's except usb-part due to changes

v4:
- dropped RFC prefix
- rebase on matthias' mtk dts-next (for 6.2) branch
- added author information to overlays
- fixed sfp binding error
- added fix for moving wed_pcie node
- readded missing compatible patches

v3:
- changed mmc pull-ups
- added patch for board binding (sent separately before)
- added pcie node in mt7986 (not yet again in r3)
- added dt overlays

Frank Wunderlich (2):
  dt-bindings: phy: mediatek,tphy: add support for mt7986
  arm64: dts: mt7986: add Bananapi R3

Sam Shih (3):
  arm64: dts: mt7986: add usb related device nodes
  arm64: dts: mt7986: add mmc related device nodes
  arm64: dts: mt7986: add pcie related device nodes

 .../bindings/phy/mediatek,tphy.yaml           |   1 +
 arch/arm64/boot/dts/mediatek/Makefile         |   5 +
 .../mt7986a-bananapi-bpi-r3-emmc.dtso         |  29 ++
 .../mt7986a-bananapi-bpi-r3-nand.dtso         |  55 +++
 .../mediatek/mt7986a-bananapi-bpi-r3-nor.dtso |  68 +++
 .../mediatek/mt7986a-bananapi-bpi-r3-sd.dtso  |  23 +
 .../dts/mediatek/mt7986a-bananapi-bpi-r3.dts  | 450 ++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts  | 120 +++++
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi     | 122 +++++
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts  |   8 +
 10 files changed, 881 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dtso
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dtso
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts

-- 
2.34.1

