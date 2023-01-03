Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4E765C48B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238380AbjACRBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbjACRAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:00:13 -0500
Received: from fx409.security-mail.net (smtpout253.security-mail.net [46.30.205.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0495C13D0F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:00:07 -0800 (PST)
Received: from localhost (fx409.security-mail.net [127.0.0.1])
        by fx409.security-mail.net (Postfix) with ESMTP id EE3313498A3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:44:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1672764274;
        bh=DzXeu3BEVyIXmelFVnSvTvBFVDDYCbNRG/evZhbXXNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZjsJUAjJ3k20F6hlvOMpmZ0bkx1he10mdS3xTfFaQawylNVik38KpBdoMSl8SUtf1
         vy9Nbaosxf5qgdhCsk85Fj6hTTB9hWOt3zlp+gNpnXpVPHvQiCznVLu6kQjzQ2i12P
         T75bgkP19Mif/SKd2bE3kxRRCtQCeO9b5dvPvmN0=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id B67BB34989D; Tue,  3 Jan
 2023 17:44:33 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx409.security-mail.net (Postfix) with ESMTPS id 40C5C349897; Tue,  3 Jan
 2023 17:44:33 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 0616927E03F9; Tue,  3 Jan 2023
 17:44:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id D948327E03FC; Tue,  3 Jan 2023 17:44:32 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 GkAzixqE4AYz; Tue,  3 Jan 2023 17:44:32 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 7316627E03F9; Tue,  3 Jan 2023
 17:44:32 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <794c.63b45b71.3f493.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu D948327E03FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1672764272;
 bh=9dj6eBBuIZWxmAarUNfgaIOaNn3T2tn+nLropZTogOo=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=j4k489ZIRUakeP6YQi9VwnHW4MHLcLQsZkgTcng/5LbjS9m963MPih92fkWz8W5CS
 Se+ijz2V+71tWMwUINnyKRWNH6HwfQ7o4xPuhiwDbBRkUMAZX4vlm2oc/NeqS08xtD
 enLmUbtzUDRHiXj6WeZrQdw5QSPwyCZT+vIw9eHg=
From:   Yann Sionneau <ysionneau@kalray.eu>
Cc:     Yann Sionneau <ysionneau@kalray.eu>, linux-kernel@vger.kernel.org,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Vincent Chardon <vincent.chardon@elsys-design.com>
Subject: [RFC PATCH 18/25] kvx: Add kvx default config file
Date:   Tue,  3 Jan 2023 17:43:52 +0100
Message-ID: <20230103164359.24347-19-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230103164359.24347-1-ysionneau@kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a default config file for kvx based Coolidge SoC.

CC: linux-kernel@vger.kernel.org
Co-developed-by: Ashley Lesdalons <alesdalons@kalray.eu>
Signed-off-by: Ashley Lesdalons <alesdalons@kalray.eu>
Co-developed-by: Benjamin Mugnier <mugnier.benjamin@gmail.com>
Signed-off-by: Benjamin Mugnier <mugnier.benjamin@gmail.com>
Co-developed-by: Clement Leger <clement.leger@bootlin.com>
Signed-off-by: Clement Leger <clement.leger@bootlin.com>
Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Samuel Jones <sjones@kalray.eu>
Signed-off-by: Samuel Jones <sjones@kalray.eu>
Co-developed-by: Thomas Costis <tcostis@kalray.eu>
Signed-off-by: Thomas Costis <tcostis@kalray.eu>
Co-developed-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---
 arch/kvx/configs/default_defconfig | 130 +++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 arch/kvx/configs/default_defconfig

diff --git a/arch/kvx/configs/default_defconfig b/arch/kvx/configs/default_defconfig
new file mode 100644
index 000000000000..d05f1f3ccb8d
--- /dev/null
+++ b/arch/kvx/configs/default_defconfig
@@ -0,0 +1,130 @@
+CONFIG_DEFAULT_HOSTNAME="KVXlinux"
+CONFIG_EMBEDDED=y
+CONFIG_SERIAL_KVX_SCALL_COMM=y
+CONFIG_CONFIGFS_FS=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DWARF4=y
+CONFIG_PRINTK_TIME=y
+CONFIG_CONSOLE_LOGLEVEL_DEFAULT=15
+CONFIG_MESSAGE_LOGLEVEL_DEFAULT=7
+CONFIG_PANIC_TIMEOUT=-1
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_GDB_SCRIPTS=y
+CONFIG_FRAME_POINTER=y
+CONFIG_HZ_100=y
+CONFIG_SERIAL_EARLYCON=y
+CONFIG_HOTPLUG_PCI_PCIE=y
+CONFIG_PCIEAER=y
+CONFIG_PCIE_DPC=y
+CONFIG_HOTPLUG_PCI=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_DW=y
+CONFIG_SERIAL_8250_NR_UARTS=8
+CONFIG_SERIAL_8250_RUNTIME_UARTS=8
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_SINGLE=y
+CONFIG_JUMP_LABEL=y
+CONFIG_POWER_RESET_KVX_SCALL_POWEROFF=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCIE_KVX_NWL=y
+CONFIG_PCIEPORTBUS=y
+# CONFIG_PCIEASPM is not set
+CONFIG_PCIEAER_INJECT=y
+CONFIG_TMPFS=y
+CONFIG_DMADEVICES=y
+CONFIG_KVX_DMA_NOC=m
+CONFIG_KVX_IOMMU=y
+CONFIG_KVX_OTP_NV=y
+CONFIG_PACKET=y
+CONFIG_NET=y
+# CONFIG_WLAN is not set
+CONFIG_INET=y
+CONFIG_IPV6=y
+CONFIG_NETDEVICES=y
+CONFIG_NET_CORE=y
+CONFIG_E1000E=y
+CONFIG_BLK_DEV_NVME=y
+CONFIG_VFAT_FS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_WATCHDOG=y
+CONFIG_KVX_WATCHDOG=y
+CONFIG_HUGETLBFS=y
+CONFIG_MAILBOX=y
+CONFIG_KVX_MBOX=y
+CONFIG_REMOTEPROC=y
+CONFIG_KVX_REMOTEPROC=y
+CONFIG_VIRTIO_NET=y
+CONFIG_VIRTIO_MMIO=y
+CONFIG_RPMSG_VIRTIO=y
+CONFIG_RPMSG_CHAR=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_BLK_DEV=y
+CONFIG_BLK_DEV_LOOP=m
+CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
+CONFIG_EXT4_FS=m
+CONFIG_EXT4_USE_FOR_EXT2=y
+CONFIG_SYSVIPC=y
+CONFIG_UNIX=y
+CONFIG_NET_VENDOR_KALRAY=y
+CONFIG_NET_KVX_SOC=m
+CONFIG_STACKPROTECTOR=y
+CONFIG_TRANSPARENT_HUGEPAGE=y
+CONFIG_GPIO_DWAPB=y
+CONFIG_I2C=y
+CONFIG_I2C_SLAVE=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_DESIGNWARE_PLATFORM=y
+CONFIG_I2C_DESIGNWARE_CORE=y
+CONFIG_I2C_DESIGNWARE_SLAVE=y
+CONFIG_I2C_SLAVE_USPACE=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON=y
+CONFIG_SPI=y
+CONFIG_SPI_DESIGNWARE=y
+CONFIG_SPI_DW_MMIO=y
+CONFIG_SPI_DW_KVX=y
+CONFIG_MTD=y
+CONFIG_MTD_SPI_NOR=y
+# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
+CONFIG_SQUASHFS=m
+CONFIG_USB=y
+CONFIG_USB_CONFIGFS=m
+CONFIG_USB_CONFIGFS_ACM=y
+CONFIG_USB_CONFIGFS_ECM=y
+CONFIG_USB_DWC2=y
+CONFIG_USB_DWC2_DUAL_ROLE=y
+CONFIG_USB_GADGET=y
+CONFIG_U_SERIAL_CONSOLE=y
+CONFIG_USB_USBNET=m
+CONFIG_USB_NET_SMSC95XX=m
+# CONFIG_NOP_USB_XCEIV is not set
+CONFIG_USB_PHY=y
+CONFIG_GENERIC_PHY=y
+CONFIG_GENERIC_PHY_USB=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_OF_DWCMSHC=y
+CONFIG_MDIO_BITBANG=m
+CONFIG_MDIO_GPIO=m
+CONFIG_MARVELL_PHY=m
+CONFIG_GPIO_PCA953X=y
+CONFIG_NETFILTER=y
+CONFIG_NF_CONNTRACK=m
+CONFIG_NF_NAT=m
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_NAT=m
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_NETDEV=y
+CONFIG_LEDS_TRIGGER_PATTERN=y
+CONFIG_DCB=y
-- 
2.37.2





