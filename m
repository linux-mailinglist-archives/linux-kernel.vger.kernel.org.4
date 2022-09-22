Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358BD5E6E51
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiIVVUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiIVVUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:20:09 -0400
Received: from mailserv1.kapsi.fi (mailserv1.kapsi.fi [IPv6:2001:67c:1be8::25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B247961D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 14:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=ext.kapsi.fi; s=20161220; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yVy+nR6iXhD6u+bbxJixDExEhHFsLTq2CFI0hZ7hb5w=; b=cpPjoiN8iUl4ZISRGpUPapQbYb
        Ti2jVM3R0mM8YAPGi1PIx7TL80RAkQvuhnSGSYcHcJ8G3VQZp+oXAbFHdoQ0keFWKnMek5QtZAjyi
        4ihtse90ir/SPzHlzkq7Eh2kgyo7iBxZyY+0rQtpnudYk7JufE3HzUHXFiDeMAnfewNZLCCS0OXUX
        lTFMB5JL7+sWu3cZNHdmi5NvL3BqVuahSSAdn4xAsoChegJGVHuQiraP9V09Y+6oqCZxGkv4Dg3of
        NERZHzsQNFosHYyLSi4TFiUNls/oN3e30slne0nAI4zSFZyAlMuhNDQ6XnByjmLGW0s93W/GYSyOn
        kQuDDusQ==;
Received: from a88-85-156-139.mpynet.fi ([88.85.156.139]:50261 helo=localhost)
        by mailserv1.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maukka@ext.kapsi.fi>)
        id 1obSlS-008pZ9-OO; Thu, 22 Sep 2022 23:25:44 +0300
Received: by localhost (sSMTP sendmail emulation); Thu, 22 Sep 2022 23:25:39 +0300
From:   Mauri Sandberg <maukka@ext.kapsi.fi>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux@armlinux.org.uk
Cc:     pali@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mauri Sandberg <maukka@ext.kapsi.fi>
Date:   Thu, 22 Sep 2022 23:24:55 +0300
Message-Id: <20220922202458.7592-1-maukka@ext.kapsi.fi>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427162123.110458-1-maukka@ext.kapsi.fi>
References: <20220427162123.110458-1-maukka@ext.kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 88.85.156.139
X-SA-Exim-Mail-From: maukka@ext.kapsi.fi
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
Subject: [PATCH v2 0/3] ARM: orion5x: add D-Link DNS323 based on device treee
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mailserv1.kapsi.fi)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This is the second iteration of my series to add D-Link DNS323 devices,
which are based on a device tree. It adds the bindings, the device tree
source files and a new board file to take care of initialising what little
remains that cannot be done via device tree. The initialisation of MAC address
will be neater once method for passing ASCII string based address is agreed on.

Functionally this series has a dependency to Pali's mvebu pci series, which
adds support for Orion PCIe and which should be scheduled for a merge window
any time soon:
https://lore.kernel.org/linux-pci/20220905192310.22786-1-pali@kernel.org/

What currently is tested and works in rev A1
 - leds
 - keys
 - fan
 - temperature sensor
 - shutdown
 - reboot
 - mtd partitions
 - ethernet
 - PCIe and with that sata_mv

And the variants B1 and C1 need testing still.

Thanks,
Mauri

Mauri Sandberg (3):
  dt-bindings: arm: add DT binding for D-Link DNS-323
  ARM: dts: orion5x: Add D-Link DNS-323 Device Tree
  ARM: orion5x: Add D-Link DNS-323 based on Device Tree

 .../bindings/arm/marvell/marvell,orion5x.txt  |  12 +
 arch/arm/boot/dts/Makefile                    |   3 +
 arch/arm/boot/dts/orion5x-dlink-dns323.dtsi   | 215 ++++++++++++++++++
 arch/arm/boot/dts/orion5x-dlink-dns323a1.dts  |  44 ++++
 arch/arm/boot/dts/orion5x-dlink-dns323b1.dts  |  39 ++++
 arch/arm/boot/dts/orion5x-dlink-dns323c1.dts  |  81 +++++++
 arch/arm/mach-orion5x/Kconfig                 |   7 +
 arch/arm/mach-orion5x/Makefile                |   1 +
 arch/arm/mach-orion5x/board-dns323.c          | 208 +++++++++++++++++
 arch/arm/mach-orion5x/board-dt.c              |   3 +
 arch/arm/mach-orion5x/common.h                |   6 +
 11 files changed, 619 insertions(+)
 create mode 100644 arch/arm/boot/dts/orion5x-dlink-dns323.dtsi
 create mode 100644 arch/arm/boot/dts/orion5x-dlink-dns323a1.dts
 create mode 100644 arch/arm/boot/dts/orion5x-dlink-dns323b1.dts
 create mode 100644 arch/arm/boot/dts/orion5x-dlink-dns323c1.dts
 create mode 100644 arch/arm/mach-orion5x/board-dns323.c


base-commit: c69cf88cda5faca0e411babb67ac0d8bfd8b4646
--
2.25.1
