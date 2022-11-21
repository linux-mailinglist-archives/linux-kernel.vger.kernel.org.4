Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E123D63191C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 05:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiKUELd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 23:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKUEL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 23:11:27 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63BB13DE6;
        Sun, 20 Nov 2022 20:11:24 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NFv8T3mmpz4x1D;
        Mon, 21 Nov 2022 15:11:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669003882;
        bh=J1tW9mwE/dg4rqvM2llFVGqnuZEYWqLuswRswXV5Vnw=;
        h=Date:From:To:Cc:Subject:From;
        b=g5nBcHoQBXdXjT3zw2rHO38XmfpIgFDZ/Wmh7oDgenrdWQQTw8WJ1LYJs6O05bHrq
         6wgiKm6/WaUn/T0hZsUlZEa7ltAP3DQnsbksr5H6Ke2Vdsa3d+GKIf1LZAeX+4fM3O
         +4duhEWFdd6bjuvu4UIKtcJPPUNx49TqHrwRodtQUFGRgtBCUhkhJrQxxsLfQdDHE5
         PsanvOjpsQM2iSrhjQikrrM98ajc/cN+d0RVCdHh0gZCdvmnGAv2Ol3IkD4EM5prhU
         fTt+23eAarz++vVeUQ+f8CnsnZTWn4VQj2iZFEs7mzQuOqXmeHaeetQMvGtLuYDwj2
         kzOywIvgk7ppA==
Date:   Mon, 21 Nov 2022 15:11:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tip tree with the pci tree
Message-ID: <20221121151120.6acfda14@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B7rX0XxF_gTOJiBB+U75ADe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B7rX0XxF_gTOJiBB+U75ADe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got conflicts in:

  drivers/pci/controller/Kconfig
  drivers/pci/controller/dwc/Kconfig
  drivers/pci/controller/mobiveil/Kconfig

between commit:

  19cb0749bae1 ("PCI: Allow building CONFIG_OF drivers with COMPILE_TEST")

from the pci tree and commit:

  a474d3fbe287 ("PCI/MSI: Get rid of PCI_MSI_IRQ_DOMAIN")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/pci/controller/Kconfig
index a62e9fbb69ca,1569d9a3ada0..000000000000
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@@ -18,8 -18,8 +18,8 @@@ config PCI_MVEB
  config PCI_AARDVARK
  	tristate "Aardvark PCIe controller"
  	depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
 -	depends on OF
 +	depends on OF || COMPILE_TEST
- 	depends on PCI_MSI_IRQ_DOMAIN
+ 	depends on PCI_MSI
  	select PCI_BRIDGE_EMUL
  	help
  	 Add support for Aardvark 64bit PCIe Host Controller. This
@@@ -215,8 -214,8 +215,8 @@@ config PCIE_ROCKCHI
  config PCIE_ROCKCHIP_HOST
  	tristate "Rockchip PCIe host controller"
  	depends on ARCH_ROCKCHIP || COMPILE_TEST
 -	depends on OF
 +	depends on OF || COMPILE_TEST
- 	depends on PCI_MSI_IRQ_DOMAIN
+ 	depends on PCI_MSI
  	select MFD_SYSCON
  	select PCIE_ROCKCHIP
  	help
@@@ -239,8 -238,8 +239,8 @@@ config PCIE_ROCKCHIP_E
  config PCIE_MEDIATEK
  	tristate "MediaTek PCIe controller"
  	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
 -	depends on OF
 +	depends on OF || COMPILE_TEST
- 	depends on PCI_MSI_IRQ_DOMAIN
+ 	depends on PCI_MSI
  	help
  	  Say Y here if you want to enable PCIe controller support on
  	  MediaTek SoCs.
@@@ -277,8 -276,8 +277,8 @@@ config PCIE_BRCMST
  	tristate "Broadcom Brcmstb PCIe host controller"
  	depends on ARCH_BRCMSTB || ARCH_BCM2835 || ARCH_BCMBCA || \
  		   BMIPS_GENERIC || COMPILE_TEST
 -	depends on OF
 +	depends on OF || COMPILE_TEST
- 	depends on PCI_MSI_IRQ_DOMAIN
+ 	depends on PCI_MSI
  	default ARCH_BRCMSTB || BMIPS_GENERIC
  	help
  	  Say Y here to enable PCIe host controller support for
@@@ -303,10 -302,7 +303,8 @@@ config PCI_LOONGSO
 =20
  config PCIE_MICROCHIP_HOST
  	bool "Microchip AXI PCIe host bridge support"
 -	depends on PCI_MSI && OF
 +	depends on OF || COMPILE_TEST
 +	depends on PCI_MSI
- 	select PCI_MSI_IRQ_DOMAIN
- 	select GENERIC_MSI_IRQ_DOMAIN
  	select PCI_HOST_COMMON
  	help
  	  Say Y here if you want kernel to support the Microchip AXI PCIe
@@@ -327,8 -323,8 +325,8 @@@ config PCIE_APPLE_MSI_DOORBELL_ADD
  config PCIE_APPLE
  	tristate "Apple PCIe controller"
  	depends on ARCH_APPLE || COMPILE_TEST
 -	depends on OF
 +	depends on OF || COMPILE_TEST
- 	depends on PCI_MSI_IRQ_DOMAIN
+ 	depends on PCI_MSI
  	select PCI_HOST_COMMON
  	help
  	  Say Y here if you want to enable PCIe controller support on Apple
diff --cc drivers/pci/controller/dwc/Kconfig
index aa0a2fcd41f1,f3c462130627..000000000000
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@@ -20,9 -20,8 +20,9 @@@ config PCI_DRA7X
  config PCI_DRA7XX_HOST
  	tristate "TI DRA7xx PCIe controller Host Mode"
  	depends on SOC_DRA7XX || COMPILE_TEST
 -	depends on OF && HAS_IOMEM && TI_PIPE3
 +	depends on OF || COMPILE_TEST
 +	depends on HAS_IOMEM && TI_PIPE3
- 	depends on PCI_MSI_IRQ_DOMAIN
+ 	depends on PCI_MSI
  	select PCIE_DW_HOST
  	select PCI_DRA7XX
  	default y if SOC_DRA7XX
@@@ -136,9 -134,8 +136,9 @@@ config PCI_KEYSTONE_E
 =20
  config PCI_LAYERSCAPE
  	bool "Freescale Layerscape PCIe controller - Host mode"
 -	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
 +	depends on ARM || ARCH_LAYERSCAPE || COMPILE_TEST
 +	depends on OF || COMPILE_TEST
- 	depends on PCI_MSI_IRQ_DOMAIN
+ 	depends on PCI_MSI
  	select PCIE_DW_HOST
  	select MFD_SYSCON
  	help
@@@ -162,10 -158,9 +162,10 @@@ config PCI_LAYERSCAPE_E
  	  controller works in RC mode.
 =20
  config PCI_HISI
 -	depends on OF && (ARM64 || COMPILE_TEST)
  	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
 +	depends on ARM64 || COMPILE_TEST
 +	depends on OF || COMPILE_TEST
- 	depends on PCI_MSI_IRQ_DOMAIN
+ 	depends on PCI_MSI
  	select PCIE_DW_HOST
  	select PCI_HOST_COMMON
  	help
@@@ -174,9 -169,8 +174,9 @@@
 =20
  config PCIE_QCOM
  	bool "Qualcomm PCIe controller"
 -	depends on OF && (ARCH_QCOM || COMPILE_TEST)
 +	depends on ARCH_QCOM || COMPILE_TEST
 +	depends on OF || COMPILE_TEST
- 	depends on PCI_MSI_IRQ_DOMAIN
+ 	depends on PCI_MSI
  	select PCIE_DW_HOST
  	select CRC8
  	help
@@@ -233,18 -226,17 +233,18 @@@ config PCIE_ROCKCHIP_DW_HOS
  	bool "Rockchip DesignWare PCIe controller"
  	select PCIE_DW
  	select PCIE_DW_HOST
 -	depends on PCI_MSI
  	depends on ARCH_ROCKCHIP || COMPILE_TEST
 -	depends on OF
 +	depends on OF || COMPILE_TEST
- 	depends on PCI_MSI_IRQ_DOMAIN
++	depends on PCI_MSI
  	help
  	  Enables support for the DesignWare PCIe controller in the
  	  Rockchip SoC except RK3399.
 =20
  config PCIE_INTEL_GW
  	bool "Intel Gateway PCIe host controller support"
 -	depends on OF && (X86 || COMPILE_TEST)
 +	depends on X86 || COMPILE_TEST
 +	depends on OF || COMPILE_TEST
- 	depends on PCI_MSI_IRQ_DOMAIN
+ 	depends on PCI_MSI
  	select PCIE_DW_HOST
  	help
  	  Say 'Y' here to enable PCIe Host controller support on Intel
@@@ -281,10 -273,9 +281,10 @@@ config PCIE_KEEMBAY_E
  	  DesignWare core functions.
 =20
  config PCIE_KIRIN
 -	depends on OF && (ARM64 || COMPILE_TEST)
  	tristate "HiSilicon Kirin series SoCs PCIe controllers"
 +	depends on ARM64 || COMPILE_TEST
 +	depends on OF || COMPILE_TEST
- 	depends on PCI_MSI_IRQ_DOMAIN
+ 	depends on PCI_MSI
  	select PCIE_DW_HOST
  	help
  	  Say Y here if you want PCIe controller support
@@@ -354,9 -345,8 +354,9 @@@ config PCIE_VISCONTI_HOS
  config PCIE_UNIPHIER
  	bool "Socionext UniPhier PCIe host controllers"
  	depends on ARCH_UNIPHIER || COMPILE_TEST
 -	depends on OF && HAS_IOMEM
 +	depends on OF || COMPILE_TEST
 +	depends on HAS_IOMEM
- 	depends on PCI_MSI_IRQ_DOMAIN
+ 	depends on PCI_MSI
  	select PCIE_DW_HOST
  	help
  	  Say Y here if you want PCIe host controller support on UniPhier SoCs.
@@@ -375,9 -364,8 +375,9 @@@ config PCIE_UNIPHIER_E
 =20
  config PCIE_AL
  	bool "Amazon Annapurna Labs PCIe controller"
 -	depends on OF && (ARM64 || COMPILE_TEST)
 +	depends on ARM64 || COMPILE_TEST
 +	depends on OF || COMPILE_TEST
- 	depends on PCI_MSI_IRQ_DOMAIN
+ 	depends on PCI_MSI
  	select PCIE_DW_HOST
  	select PCI_ECAM
  	help
diff --cc drivers/pci/controller/mobiveil/Kconfig
index 24ea35927185,1d7a07ba9ccd..000000000000
--- a/drivers/pci/controller/mobiveil/Kconfig
+++ b/drivers/pci/controller/mobiveil/Kconfig
@@@ -14,8 -14,8 +14,8 @@@ config PCIE_MOBIVEIL_HOS
  config PCIE_MOBIVEIL_PLAT
  	bool "Mobiveil AXI PCIe controller"
  	depends on ARCH_ZYNQMP || COMPILE_TEST
 -	depends on OF
 +	depends on OF || COMPILE_TEST
- 	depends on PCI_MSI_IRQ_DOMAIN
+ 	depends on PCI_MSI
  	select PCIE_MOBIVEIL_HOST
  	help
  	  Say Y here if you want to enable support for the Mobiveil AXI PCIe

--Sig_/B7rX0XxF_gTOJiBB+U75ADe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN6+mgACgkQAVBC80lX
0GyPogf+JHFKVju6MmOMqvk62HaskD15eWB9zhnATUId4t203Y0zYM/r00Qc/tER
FmEfOS0nA3LZfKftRWmOY+tTxizT6/iggl5B9djU5yFFBOumVUkUfoJ+N2MQeilz
VJb631MC2BHztXY7xXzDoHsuBK0XLBdiPXKvFGl8fOCuNNlrVkKRzcVAzY/Yw47d
XCjVubkd3vz+jqy0Ni6TXZFv5DdGJeFaX0taehD3W8FVIqJ1xM65e/FYAsnaaXlh
+VaIQvnD/DeyE8C6tRjMNi/xRCg3y9PjiTrMj0nW89tndqdhxnwWvf94LTkfrwgw
KgwDsh4SKl5OKZT+he7U1YVbyJDQtA==
=hKiv
-----END PGP SIGNATURE-----

--Sig_/B7rX0XxF_gTOJiBB+U75ADe--
