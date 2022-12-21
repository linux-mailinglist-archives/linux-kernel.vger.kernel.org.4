Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C39C6531CC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiLUNbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiLUNa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:30:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DAC617B;
        Wed, 21 Dec 2022 05:30:55 -0800 (PST)
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A1D956602CBE;
        Wed, 21 Dec 2022 13:30:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671629453;
        bh=Dphoi7a4e7uSwycGENJgW6Vw0pbTjwfMZ2OK1vvcJaA=;
        h=From:To:Cc:Subject:Date:From;
        b=MtCq/u4lVL2JN8HbLuHpR4IXgq5Br24sPP9LP6qybFu2Cxu0GVBZmD/UciQAsqhtC
         DvT+qU6QMGfZ8/4OdFzqjT12bOqSxUhKVJl3VpN2Ewi/bRP3PBqW3TTHhsPMqOo0Ro
         W+TyN0WHINLhJ4y7R5m1ij2Cx1sWJyEj0AsHUgQWD/jWi/XzQMPTRqrTOC+kJZrp1K
         7dxq0onqwCUcI9vMUVoCcHs4am79pVbKi1nF0s0K4hMsPOqypF47lclqgh6444fkkv
         ORJYFFPiY0KQz2QSp9+c8xUOz00WH9lnRUIgQ5LhJLbnNI4r40jRz74UiqxcZxmui9
         UdMR5UzH90hHw==
Received: by beast.luon.net (Postfix, from userid 1000)
        id 3AB935EC483D; Wed, 21 Dec 2022 14:30:51 +0100 (CET)
From:   Sjoerd Simons <sjoerd@collabora.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     martyn.welch@collabora.com, Nitin Yadav <n-yadav@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Improve K3-am625-sk support (USB, MMC)
Date:   Wed, 21 Dec 2022 14:30:47 +0100
Message-Id: <20221221133051.1069480-1-sjoerd@collabora.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series picks up a few patches from the TI BSP tree that
unfortunately didn't make it upstream thusfar.

The first patch improve SD card compatibility (allowing U1 class cards
to be used), the remaining ones add USB support.

The type-c connector isn't entirely modelled with these changes as
it goes through a TPS6598 PD controller. Unfortunately the dtb bindings
for that currently require an irq line, which is not connected on E1 and
E2 version boards. The patchese to support this setup unfortunately didn't land
yet[0].. As such the last patch ignored the PD controller and simply
configures usb0 as periphal only rather then mode switch capable, which
at least gives some basic usability of that USB port.

0: https://lore.kernel.org/lkml/f714ee55-ef47-317d-81b9-57020dda064b@ti.com/T/

Changes in v2:
  - Rebase against linux-next 20221220

Aswath Govindraju (2):
  arm64: dts: ti: k3-am62-main: Add support for USB
  arm64: dts: ti: k3-am625-sk: Add support for USB

Nitin Yadav (1):
  arm64: dts: ti: k3-am62-main: Update OTAP and ITAP delay select

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 90 ++++++++++++++++++------
 arch/arm64/boot/dts/ti/k3-am625-sk.dts   | 50 +++++++++++++
 2 files changed, 118 insertions(+), 22 deletions(-)

-- 
2.39.0

