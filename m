Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA7660DE3F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 11:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbiJZJhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 05:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiJZJhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:37:04 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8A8BC617;
        Wed, 26 Oct 2022 02:37:01 -0700 (PDT)
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
        by mxout3.routing.net (Postfix) with ESMTP id C653F626A8;
        Wed, 26 Oct 2022 09:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666777019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Bc6cQwclXRXDwOqWgeEjn61RmTobdHqJkYLEj/iLtpo=;
        b=ia30a0U6EGjaqLmgGc7lXw/Gd0gDOGVekvdvCEexd7p50Xxw1gkKl8FPPjF5DxtpEE1Keh
        hxtGBbp3tHlkACKE6+6TyfgrYBjn2rJb18jWF/7iUmS2FWDFgLwadjRdWKXPs13Xfn8qKU
        dcqQ8sc7kAvaFiqfCe9i1r+N+D8Jg0w=
Received: from frank-G5.. (fttx-pool-80.245.72.174.bambit.de [80.245.72.174])
        by mxbox4.masterlogin.de (Postfix) with ESMTPSA id 062D68026C;
        Wed, 26 Oct 2022 09:36:58 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 0/7] Add BananaPi R3
Date:   Wed, 26 Oct 2022 11:36:43 +0200
Message-Id: <20221026093650.110290-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 34114509-b48f-4b6e-a4e7-fd466745400a
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This Series adds some Nodes to mt7986 devicetree and the BananaPi R3

i included sams series for mt7986 DTS with small changes
https://patchwork.kernel.org/project/linux-mediatek/cover/20220427124741.18245-1-sam.shih@mediatek.com/

this series need these Patches:

i2c-support:
https://patchwork.kernel.org/project/linux-mediatek/cover/20221009101631.82380-1-linux@fw-web.de/

mmc bindings:
https://patchwork.kernel.org/project/linux-mediatek/list/?series=688675

update pinctrl-bindings:
https://patchwork.kernel.org/project/linux-mediatek/patch/20221024074349.7777-1-linux@fw-web.de/
https://patchwork.kernel.org/project/linux-mediatek/patch/20221025070255.14407-1-linux@fw-web.de/

hwrng and pinctrl (uart splitting) are already applied to next

v2 do not include PCIe as there is still a discussion on bindings.

i had run full dtbs-check but i end up with some strange warnings in
ethernet-node that should not come up as phy-handle and sfp/managed
properties are already defined.

phy-handle made optional
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/mediatek,net.yaml#n265

property sfp/managed (which is included for mac subnode in yaml above):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/ethernet-controller.yaml#n137

Frank Wunderlich (2):
  arm64: dts: mt7986: add i2c node
  arm64: dts: mt7986: add Bananapi R3

Sam Shih (5):
  arm64: dts: mt7986: harmonize device node order
  arm64: dts: mt7986: add spi related device nodes
  arm64: dts: mt7986: add usb related device nodes
  arm64: dts: mt7986: add crypto related device nodes
  arm64: dts: mt7986: add mmc related device nodes

 arch/arm64/boot/dts/mediatek/Makefile         |   2 +
 .../mediatek/mt7986a-bananapi-bpi-r3-emmc.dts |  34 +
 .../mediatek/mt7986a-bananapi-bpi-r3-sd.dts   |  29 +
 .../dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi | 593 ++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts  | 246 ++++++--
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi     | 127 ++++
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts  |  83 ++-
 7 files changed, 1059 insertions(+), 55 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi

-- 
2.34.1

