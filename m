Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2689C64ECF9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 15:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiLPOge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 09:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiLPOg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 09:36:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24DA554F7;
        Fri, 16 Dec 2022 06:36:28 -0800 (PST)
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5ED516602C94;
        Fri, 16 Dec 2022 14:36:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671201387;
        bh=C+3fmRVNonjirJ0IPyk/rDeiIFZ7HbWPCZDE7f3wJTU=;
        h=From:To:Cc:Subject:Date:From;
        b=RHbR6Wqk1rP9DWsc3019FKPPQjFuhfRqbE/7A4jxaLEnbTYdZIEOWop4ae8j3VXZP
         pTH2FEl4V8Qo2W0Pew+GpiBOtaEzyNmM8bPHd5OlMPXiW02YbZEzZncVKRFywnZIAY
         JziLt7dZU1IsZYrAyDrF/CSfma2BW1o5i65e8Wb8Ws5UMSqu1WIZt+E3mSRAZWcnvy
         wVcL2SyruW3x0Xv3GVhc4xGtPGqS9E8oCxc6k7SDojvqUVGA40DM5PTvByrXC9lYx5
         snGeDy0Xqv+QTGdxZ5zuwZwvSW9pxA6i5PoS1qhEtJoAWL6a/+gc6fkW9CDsrwhv7Y
         3XSErSYN7ROPg==
Received: by beast.luon.net (Postfix, from userid 1000)
        id 7AEB35E33154; Fri, 16 Dec 2022 15:36:24 +0100 (CET)
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
Subject: [PATCH 0/3] Improve K3-am625-sk support (USB, MMC)
Date:   Fri, 16 Dec 2022 15:36:20 +0100
Message-Id: <20221216143624.23708-1-sjoerd@collabora.com>
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


Aswath Govindraju (2):
  arm64: dts: ti: k3-am62-main: Add support for USB
  arm64: dts: ti: k3-am625-sk: Add support for USB

Nitin Yadav (1):
  arm64: dts: ti: k3-am62-main: Update OTAP and ITAP delay select

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 90 ++++++++++++++++++------
 arch/arm64/boot/dts/ti/k3-am625-sk.dts   | 22 ++++++
 2 files changed, 90 insertions(+), 22 deletions(-)

-- 
2.39.0

