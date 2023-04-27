Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1043A6F0721
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243276AbjD0OT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243957AbjD0OTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:19:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDCF199B;
        Thu, 27 Apr 2023 07:19:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C1ED63D84;
        Thu, 27 Apr 2023 14:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9ACC433D2;
        Thu, 27 Apr 2023 14:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682605187;
        bh=W8hVdZwO7pCouED6Z/NUDJz2nXRIwtvclXLkbvqRajk=;
        h=Date:From:To:Cc:Subject:From;
        b=QiOgGMavsj4KDIQI4M5SMTSNQuSU+Upw0vKcsc+VCfexOO8XtuXrZ1kSD+aezuiYI
         WSDYsqQ5V20f5xR21RY4eSPPUEq4XYIMNl2UGP74a3IRszhb9ONjOasu2F3QarVpsX
         fexWR6H3MdDR0w39EzeQBp/o5XhF5nVTXqvlICHw=
Date:   Thu, 27 Apr 2023 16:19:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt driver updates for 6.4-rc1
Message-ID: <ZEqEgbLPb-ItUfdE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d:

  Linux 6.3-rc6 (2023-04-09 11:15:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.4-rc1

for you to fetch changes up to 8f40fc0808137c157dd408d2632e63bfca2aecdb:

  usb: dwc3: gadget: Refactor EP0 forced stall/restart into a separate API (2023-04-21 07:07:44 +0200)

----------------------------------------------------------------
USB / Thunderbolt changes for 6.4-rc1

Here is the large set of USB and Thunderbolt changes for 6.4-rc1.

"biggest" thing in here is the removal of two obsolete drivers, u132-hcd
and ftdi-elan, making this a net-removal of code overall.

Other than the driver removals, included in here are:
  - Thunderbolt updates for new hardware and features
  - xhci driver updates and fixes
  - dwc3 driver updates and fixes
  - gadget core and driver updates and features added
  - mtu3 driver updates
  - dwc2 driver fixes and updates
  - usb-serial driver updates
  - typec driver updates and fixes
  - platform remove callback changes
  - dts updates and conversions
  - other small changes

All have been in linux-next for a while with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (3):
      USB: core: Add routines for endpoint checks in old drivers
      USB: sisusbvga: Add endpoint checks
      media: radio-shark: Add endpoint checks

Andy Shevchenko (13):
      usb: acpi: Switch to use acpi_evaluate_dsm_typed()
      usb: gadget: aspeed: Rectify a bit a random header inclusion
      xhci: mem: Carefully calculate size for memory allocations
      xhci: mem: Use dma_poll_zalloc() instead of explicit memset()
      xhci: mem: Get rid of redundant 'else'
      xhci: mem: Drop useless return:s
      xhci: mem: Use while (i--) pattern to clean up
      xhci: mem: Replace explicit castings with appropriate specifiers
      xhci: mem: Join string literals back
      thunderbolt: Get rid of redundant 'else'
      thunderbolt: Make use of SI units from units.h
      thunderbolt: Introduce usb4_port_sb_opcode_err_to_errno() helper
      usb: dwc3: pci: Change PCI device macros

Arnd Bergmann (1):
      xhci: use pm_ptr() instead of #ifdef for CONFIG_PM conditionals

Arınç ÜNAL (1):
      USB: serial: option: add UNISOC vendor and TOZED LT70C product

Aswath Govindraju (2):
      usb: dwc3-am62: Add support for system wakeup based on USB events
      usb: typec: tps6598x: Add support for polling interrupts status

Badhri Jagan Sridharan (2):
      usb: gadget: udc: core: Invoke usb_gadget_connect only when started
      usb: gadget: udc: core: Prevent redundant calls to pullup

Christophe JAILLET (1):
      usb: pci-quirks: Reduce the length of a spinlock section in usb_amd_find_chipset_info()

Chunfeng Yun (9):
      dt-bindings: usb: mtk-xhci: add an optional frame count clock
      usb: xhci-mtk: add optional frame count clock
      usb: mtu3: give back request when rx error happens
      usb: mtu3: use boolean return value
      usb: mtu3: fix kernel panic at qmu transfer done irq handler
      usb: mtu3: unlock @mtu->lock just before giving back request
      usb: mtu3: expose role-switch control to userspace
      dt-bindings: usb: mtu3: add two optional clocks
      usb: mtu3: add optional clock xhci_ck and frmcnt_ck

Conor Dooley (1):
      usb: musb: mpfs: convert SOC_MICROCHIP_POLARFIRE to ARCH_MICROCHIP_POLARFIRE

Daniel Scally (1):
      usb: gadget: uvc: Make bmControls attr read/write

Deming Wang (1):
      usb: dwc2: Fix spelling mistake "schduler" -> "scheduler"

Elson Roy Serrao (6):
      usb: gadget: Properly configure the device for remote wakeup
      usb: dwc3: Add remote wakeup handling
      usb: gadget: Add function wakeup support
      usb: dwc3: Add function suspend and function wakeup support
      usb: gadget: Handle function suspend feature selector
      usb: gadget: f_ecm: Add suspend/resume and remote wakeup support

Emanuele Ghidoli (3):
      dt-bindings: usb: smsc,usb3503: Add usb3803
      usb: misc: usb3503: refactor code to prepare for usb3803 addition
      usb: misc: usb3503: support usb3803 and bypass mode

Fabrice Gasnier (5):
      usb: dwc2: improve error handling in __dwc2_lowlevel_hw_enable
      dt-bindings: usb: dwc2: add utmi optional clock
      usb: dwc2: platform: add support for utmi optional clock
      ARM: dts: stm32: add USB OTG UTMI clock on stm32mp151
      usb: typec: ucsi: don't print PPM init deferred errors

Frank Wang (1):
      usb: typec: tcpm: fix multiple times discover svids error

Greg Kroah-Hartman (4):
      Merge 6.3-rc4 into usb-next
      Merge 6.3-rc6 into usb-next
      Merge tag 'thunderbolt-for-v6.4-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
      Merge tag 'usb-serial-6.4-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next

Gustavo A. R. Silva (1):
      usb: host: oxu210hp-hcd: Replace fake flex-array with flexible-array member

Johan Hovold (12):
      xhci: fix debugfs register accesses while suspended
      USB: dwc3: fix runtime pm imbalance on probe errors
      USB: dwc3: fix runtime pm imbalance on unbind
      USB: dwc3: disable autosuspend on unbind
      USB: dwc3: gadget: drop dead hibernation code
      USB: dwc3: drop dead hibernation code
      USB: dwc3: clean up probe error labels
      USB: dwc3: clean up phy init error handling
      USB: dwc3: clean up core init error handling
      USB: dwc3: refactor phy handling
      USB: dwc3: refactor clock lookups
      USB: dwc3: clean up probe declarations

Jon Hunter (2):
      usb: gadget: tegra-xudc: Fix crash in vbus_draw
      usb: gadget: tegra-xudc: Remove unneeded return variable

Josue David Hernandez Gutierrez (6):
      xhci: Avoid PCI MSI/MSIX interrupt reinitialization at resume
      xhci: Move functions to setup msi to xhci-pci
      xhci: move PCI specific MSI/MSIX cleanup away from generic xhci functions
      xhci: Move functions to cleanup MSI to xhci-pci
      xhci: Call MSI sync function from xhci-pci instead of generic xhci code
      xhci: Move xhci MSI sync function to to xhci-pci

Kang Chen (2):
      usb: gadget: udc: add return value check of kzalloc in mv_udc_probe
      usb: gadget: udc: replace kzalloc with devm_kzalloc in mv_udc_probe

Konrad Dybcio (1):
      dt-bindings: usb: dwc3: Add QCM2290 compatible

Krzysztof Kozlowski (14):
      dt-bindings: usb: snps,dwc3: document extcon property
      usb: host: xhci-rcar: drop of_match_ptr for ID table
      usb: host: max3421-hcd: drop of_match_ptr for ID table
      usb: renesas_usbhs: drop of_match_ptr for ID table
      usb: gadget: rzv2m_usb3drd: drop of_match_ptr for ID table
      usb: gadget: renesas_usb3: drop of_match_ptr for ID table
      usb: gadget: max3420_udc: drop of_match_ptr for ID table
      usb: misc: usb251xb: drop of_match_ptr for ID table
      usb: typec: hd3ss3220: Drop of_match_ptr for ID table
      usb: typec: fusb302: mark OF related data as maybe unused
      dt-bindings: usb: mediatek,mtk-xhci: drop assigned-clocks
      dt-bindings: usb: ti,j721e-usb: drop assigned-clocks
      dt-bindings: usb: ti,keystone-dwc3: drop assigned-clocks
      dt-bindings: usb: ci-hdrc-usb2: allow multiple PHYs

Li Jun (2):
      usb: dwc3: add several registers dump for debugfs
      usb: typec: tcpm: try to get role switch from tcpc fwnode

Linyu Yuan (5):
      usb: cdns3: change trace event cdns3_ring() operation
      usb: cdns3: change some trace event __dynamic_array() to __get_buf()
      usb: dwc3: change some trace event __dynamic_array() to __get_buf()
      usb: xhci: change some trace event __dynamic_array() to __get_buf()
      usb: gadget: ffs: remove ENTER() macro

Lukas Bulwahn (1):
      usb: move config USB_USS720 to usb's misc Kconfig

Mario Limonciello (2):
      thunderbolt: use `tb_eeprom_get_drom_offset` to discover DROM offset
      thunderbolt: Refactor DROM reading

Mathias Nyman (1):
      xhci: dbc: Provide sysfs option to configure dbc descriptors

Mingxuan Xiang (1):
      usb: dwc3: host: remove dead code in dwc3_host_get_irq()

Neil Armstrong (2):
      usb: typec: ucsi: add PMIC Glink UCSI driver
      dt-bindings: usb: snps,dwc3: document HS & SS OF graph ports

Nobuhiro Iwamatsu (1):
      usb: host: xhci-plat: Use dev_is_pci() helper

Peng Fan (13):
      dt-bindings: usb: snps,dwc3: support i.MX8MQ
      dt-bindings: usb: snps,dwc3: correct i.MX8MQ support
      arm64: dts: imx8mq: drop usb3-resume-missing-cas from usb
      dt-bindings: usb: usbmisc-imx: convert to DT schema
      dt-bindings: usb: ci-hdrc-usb2: convert to DT schema format
      dt-bindings: usb: usb-nop-xceiv: add power-domains property
      arm64: dts: imx8mn: update usb compatible
      arm64: dts: imx8mm: update usb compatible
      arm64: dts: imx8: update usb compatible
      arm64: dts: imx8dxl: update usb compatible
      arm64: dts: imx8dxl: drop #stream-id-cells for usb node
      ARM64: dts: imx7ulp: update usb compatible
      dt-bindings: usb: typec-tcpci: convert to DT schema format

Piyush Mehta (2):
      dt-bindings: usb: dwc3: Add snps,ulpi-ext-vbus-drv quirk
      usb: dwc3: core: add external vBus supply support for ulpi phy

Prashanth K (2):
      usb: dwc3: gadget: Change condition for processing suspend event
      usb: gadget: composite: Draw 100mA current if not configured

Rafał Miłecki (2):
      dt-bindings: usb: usb-device: make "compatible" optional
      dt-bindings: usb: allow evaluated properties in OHCI controllers

Rob Herring (5):
      usb: host: xhci-tegra: Drop using of_irq_parse_one()
      usb: Use of_property_present() for testing DT property presence
      usb: Use of_property_read_bool() for boolean properties
      dt-bindings: usb: Drop unneeded quotes
      usb: Add explicit of.h of_platform.h include

Roger Quadros (3):
      usb: dwc3-am62: Enable as a wakeup source by default
      usb: dwc3-am62: Fix up wake-up configuration and spurious wake up
      dt-bindings: usb: tps6598x: make interrupts optional

Samuel Čavoj (1):
      usb: typec: ucsi: acpi: add quirk for ASUS Zenbook UM325

Stanley Chang (3):
      usb: xhci: plat: Add USB 3.0 phy support
      usb: dwc3: core: add support for disabling High-speed park mode
      dt-bindings: usb: snps,dwc3: Add 'snps,parkmode-disable-hs-quirk' quirk

Thomas Ballasi (1):
      usb: chipidea: imx: avoid unnecessary probe defer

Tom Rix (5):
      usb: gadget: udc: remove unused usbf_ep_dma_reg_clrset function
      usb: typec: tcpci_mt6360: remove unused mt6360_tcpc_read16 function
      usb: typec: tipd: remove unused tps6598x_write16,32 functions
      USB: serial: quatech2: remove unused qt2_setdevice function
      USB: serial: quatech2: remove unused qt2_setdevice function

Uwe Kleine-König (25):
      usb: host: u132-hcd: Various style improvements
      usb: host: u132-hcd: Drop if with an always true condition
      usb: host: u132-hcd: Delete driver
      usb: ftdi-elan: Delete driver
      usb: phy: ab8500: Convert to platform remove callback returning void
      usb: phy: am335x: Convert to platform remove callback returning void
      usb: phy: fsl: Convert to platform remove callback returning void
      usb: phy: generic: Convert to platform remove callback returning void
      usb: phy: gpio-vbus: Convert to platform remove callback returning void
      usb: phy: keystone: Convert to platform remove callback returning void
      usb: phy: mv: Convert to platform remove callback returning void
      usb: phy: mxs: Convert to platform remove callback returning void
      usb: phy: tahvo: Convert to platform remove callback returning void
      usb: phy: tegra: Convert to platform remove callback returning void
      usb: phy: twl6030: Convert to platform remove callback returning void
      usb: musb: da8xx: Convert to platform remove callback returning void
      usb: musb: jz4740: Convert to platform remove callback returning void
      usb: musb: mediatek: Convert to platform remove callback returning void
      usb: musb: mpfs: Convert to platform remove callback returning void
      usb: musb: musb_core: Convert to platform remove callback returning void
      usb: musb: musb_dsps: Convert to platform remove callback returning void
      usb: musb: omap2430: Convert to platform remove callback returning void
      usb: musb: sunxi: Convert to platform remove callback returning void
      usb: musb: tusb6010: Convert to platform remove callback returning void
      usb: musb: ux500: Convert to platform remove callback returning void

Wesley Cheng (3):
      usb: dwc3: gadget: Stall and restart EP0 if host is unresponsive
      usb: dwc3: gadget: Execute gadget stop after halting the controller
      usb: dwc3: gadget: Refactor EP0 forced stall/restart into a separate API

Wolfram Sang (3):
      usb: host: xhci-rcar: remove leftover quirk handling
      usb: host: xhci-rcar: remove R-Car H3 ES1.* handling
      usb: gadget: udc: renesas_usb3: remove R-Car H3 ES1.* handling

Xu Yang (1):
      usb: chipidea: debug: remove redundant 'role' debug file

Yalong Zou (1):
      usb: remove dead code in dwc3_gadget_get_irq

Yinhao Hu (1):
      usb: chipidea: fix missing goto in `ci_hdrc_probe`

Yu Zhe (1):
      usb: typec: tcpm: remove unnecessary (void*) conversions

Yuta Hayama (1):
      usb: gadget: f_fs: Fix incorrect version checking of OS descs

Zheng Wang (1):
      usb: gadget: udc: renesas_usb3: Fix use after free bug in renesas_usb3_remove due to race condition

 Documentation/ABI/testing/configfs-usb-gadget-uvc  |    4 +-
 .../ABI/testing/sysfs-bus-pci-drivers-xhci_hcd     |   52 +
 .../bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml  |    4 +-
 .../devicetree/bindings/usb/brcm,bcm7445-ehci.yaml |    2 +-
 .../devicetree/bindings/usb/ci-hdrc-usb2.txt       |  159 -
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml      |  448 +++
 Documentation/devicetree/bindings/usb/dwc2.yaml    |    5 +-
 .../devicetree/bindings/usb/fcs,fsa4480.yaml       |    4 +-
 .../devicetree/bindings/usb/fsl,imx8mq-dwc3.yaml   |   48 +
 .../devicetree/bindings/usb/fsl,usbmisc.yaml       |   68 +
 .../devicetree/bindings/usb/generic-ehci.yaml      |    2 +-
 .../devicetree/bindings/usb/generic-ohci.yaml      |    2 +-
 .../devicetree/bindings/usb/generic-xhci.yaml      |    2 +-
 .../devicetree/bindings/usb/gpio-sbu-mux.yaml      |    4 +-
 .../devicetree/bindings/usb/maxim,max33359.yaml    |    4 +-
 .../bindings/usb/mediatek,mt6360-tcpc.yaml         |    4 +-
 .../bindings/usb/mediatek,mt6370-tcpc.yaml         |    4 +-
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml |   12 +-
 .../devicetree/bindings/usb/mediatek,mtu3.yaml     |   12 +-
 .../devicetree/bindings/usb/mediatek,musb.yaml     |    4 +-
 .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml |    4 +-
 .../devicetree/bindings/usb/nxp,ptn5110.yaml       |   72 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |    2 +
 .../devicetree/bindings/usb/realtek,rts5411.yaml   |    2 +-
 .../devicetree/bindings/usb/richtek,rt1711h.yaml   |    4 +-
 .../devicetree/bindings/usb/richtek,rt1719.yaml    |    4 +-
 .../devicetree/bindings/usb/smsc,usb3503.yaml      |   54 +-
 .../devicetree/bindings/usb/snps,dwc3.yaml         |   33 +
 .../devicetree/bindings/usb/st,stusb160x.yaml      |    4 +-
 .../devicetree/bindings/usb/ti,j721e-usb.yaml      |   10 +-
 .../devicetree/bindings/usb/ti,keystone-dwc3.yaml  |    8 -
 .../devicetree/bindings/usb/ti,tps6598x.yaml       |    6 +-
 .../devicetree/bindings/usb/typec-tcpci.txt        |   49 -
 .../devicetree/bindings/usb/usb-device.yaml        |    1 -
 .../devicetree/bindings/usb/usb-nop-xceiv.yaml     |    3 +
 .../devicetree/bindings/usb/usb-xhci.yaml          |    2 +-
 .../devicetree/bindings/usb/usbmisc-imx.txt        |   19 -
 Documentation/usb/gadget_uvc.rst                   |   28 +
 arch/arm/boot/dts/imx7ulp.dtsi                     |    5 +-
 arch/arm/boot/dts/stm32mp151.dtsi                  |    4 +-
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi    |    4 +-
 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi |    5 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi          |   10 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi          |    5 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |    2 -
 arch/mips/configs/mtx1_defconfig                   |    2 -
 arch/powerpc/configs/ppc6xx_defconfig              |    2 -
 drivers/media/radio/radio-shark.c                  |   10 +
 drivers/media/radio/radio-shark2.c                 |   10 +
 drivers/thunderbolt/acpi.c                         |    2 +-
 drivers/thunderbolt/ctl.c                          |    2 +-
 drivers/thunderbolt/eeprom.c                       |  204 +-
 drivers/thunderbolt/nhi.c                          |    3 +-
 drivers/thunderbolt/switch.c                       |    4 +-
 drivers/thunderbolt/usb4.c                         |   52 +-
 drivers/thunderbolt/xdomain.c                      |   24 +-
 drivers/usb/Kconfig                                |   29 -
 drivers/usb/Makefile                               |    1 -
 drivers/usb/cdns3/cdns3-debug.h                    |    8 +-
 drivers/usb/cdns3/cdns3-trace.h                    |   28 +-
 drivers/usb/cdns3/cdnsp-trace.h                    |   12 +-
 drivers/usb/chipidea/Makefile                      |    2 +-
 drivers/usb/chipidea/ci_hdrc_imx.c                 |    6 +-
 drivers/usb/chipidea/core.c                        |    4 +-
 drivers/usb/chipidea/debug.c                       |   55 -
 drivers/usb/core/usb-acpi.c                        |   12 +-
 drivers/usb/core/usb.c                             |   76 +
 drivers/usb/dwc2/core.h                            |    2 +
 drivers/usb/dwc2/hcd_queue.c                       |    2 +-
 drivers/usb/dwc2/params.c                          |    3 +-
 drivers/usb/dwc2/platform.c                        |   37 +-
 drivers/usb/dwc3/core.c                            |  443 ++-
 drivers/usb/dwc3/core.h                            |   21 +-
 drivers/usb/dwc3/debug.h                           |    2 +
 drivers/usb/dwc3/debugfs.c                         |    5 +
 drivers/usb/dwc3/dwc3-am62.c                       |   52 +-
 drivers/usb/dwc3/dwc3-pci.c                        |  136 +-
 drivers/usb/dwc3/ep0.c                             |   19 +-
 drivers/usb/dwc3/gadget.c                          |  279 +-
 drivers/usb/dwc3/host.c                            |    7 +-
 drivers/usb/dwc3/trace.h                           |    6 +-
 drivers/usb/gadget/composite.c                     |  127 +-
 drivers/usb/gadget/configfs.c                      |    3 +
 drivers/usb/gadget/function/f_ecm.c                |   22 +
 drivers/usb/gadget/function/f_fs.c                 |  101 +-
 drivers/usb/gadget/function/u_ether.c              |   63 +
 drivers/usb/gadget/function/u_ether.h              |    4 +
 drivers/usb/gadget/function/u_fs.h                 |    2 -
 drivers/usb/gadget/function/uvc_configfs.c         |  121 +-
 drivers/usb/gadget/legacy/g_ffs.c                  |    9 -
 drivers/usb/gadget/udc/aspeed-vhub/core.c          |    1 -
 drivers/usb/gadget/udc/aspeed-vhub/dev.c           |    1 -
 drivers/usb/gadget/udc/aspeed-vhub/ep0.c           |    1 -
 drivers/usb/gadget/udc/aspeed-vhub/epn.c           |    1 -
 drivers/usb/gadget/udc/aspeed-vhub/hub.c           |    1 -
 drivers/usb/gadget/udc/core.c                      |  178 +-
 drivers/usb/gadget/udc/max3420_udc.c               |    2 +-
 drivers/usb/gadget/udc/mv_udc_core.c               |    6 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |   26 +-
 drivers/usb/gadget/udc/renesas_usbf.c              |   11 -
 drivers/usb/gadget/udc/rzv2m_usb3drd.c             |    4 +-
 drivers/usb/gadget/udc/snps_udc_plat.c             |    2 +-
 drivers/usb/gadget/udc/tegra-xudc.c                |    7 +-
 drivers/usb/gadget/udc/trace.h                     |    5 +
 drivers/usb/host/Kconfig                           |   27 -
 drivers/usb/host/Makefile                          |    1 -
 drivers/usb/host/ehci-ppc-of.c                     |    6 +-
 drivers/usb/host/fsl-mph-dr-of.c                   |   11 +-
 drivers/usb/host/max3421-hcd.c                     |    2 +-
 drivers/usb/host/oxu210hp-hcd.c                    |    2 +-
 drivers/usb/host/pci-quirks.c                      |    4 +-
 drivers/usb/host/u132-hcd.c                        | 3219 --------------------
 drivers/usb/host/xhci-dbgcap.c                     |  191 +-
 drivers/usb/host/xhci-dbgcap.h                     |    4 +
 drivers/usb/host/xhci-debugfs.c                    |    1 +
 drivers/usb/host/xhci-mem.c                        |   83 +-
 drivers/usb/host/xhci-mtk.c                        |    1 +
 drivers/usb/host/xhci-mtk.h                        |    2 +-
 drivers/usb/host/xhci-pci.c                        |  215 +-
 drivers/usb/host/xhci-plat.c                       |   19 +-
 drivers/usb/host/xhci-rcar.c                       |   36 +-
 drivers/usb/host/xhci-ring.c                       |    1 +
 drivers/usb/host/xhci-tegra.c                      |   17 +-
 drivers/usb/host/xhci-trace.c                      |    1 +
 drivers/usb/host/xhci-trace.h                      |   20 +-
 drivers/usb/host/xhci.c                            |  202 +-
 drivers/usb/host/xhci.h                            |    1 +
 drivers/usb/misc/Kconfig                           |   51 +-
 drivers/usb/misc/Makefile                          |    1 -
 drivers/usb/misc/ftdi-elan.c                       | 2780 -----------------
 drivers/usb/misc/sisusbvga/sisusbvga.c             |   14 +
 drivers/usb/misc/usb251xb.c                        |   43 +-
 drivers/usb/misc/usb3503.c                         |   64 +-
 drivers/usb/mtu3/mtu3.h                            |    2 +-
 drivers/usb/mtu3/mtu3_dr.c                         |    1 +
 drivers/usb/mtu3/mtu3_gadget.c                     |    2 +-
 drivers/usb/mtu3/mtu3_host.c                       |    2 +-
 drivers/usb/mtu3/mtu3_plat.c                       |    2 +
 drivers/usb/mtu3/mtu3_qmu.c                        |   44 +-
 drivers/usb/musb/Kconfig                           |    2 +-
 drivers/usb/musb/da8xx.c                           |    6 +-
 drivers/usb/musb/jz4740.c                          |    6 +-
 drivers/usb/musb/mediatek.c                        |    6 +-
 drivers/usb/musb/mpfs.c                            |    6 +-
 drivers/usb/musb/musb_core.c                       |    5 +-
 drivers/usb/musb/musb_dsps.c                       |    6 +-
 drivers/usb/musb/omap2430.c                        |    8 +-
 drivers/usb/musb/sunxi.c                           |    6 +-
 drivers/usb/musb/tusb6010.c                        |    6 +-
 drivers/usb/musb/ux500.c                           |    6 +-
 drivers/usb/phy/phy-ab8500-usb.c                   |    6 +-
 drivers/usb/phy/phy-am335x.c                       |    5 +-
 drivers/usb/phy/phy-fsl-usb.c                      |    6 +-
 drivers/usb/phy/phy-generic.c                      |    6 +-
 drivers/usb/phy/phy-gpio-vbus-usb.c                |    6 +-
 drivers/usb/phy/phy-keystone.c                     |    6 +-
 drivers/usb/phy/phy-mv-usb.c                       |    6 +-
 drivers/usb/phy/phy-mxs-usb.c                      |    8 +-
 drivers/usb/phy/phy-tahvo.c                        |    6 +-
 drivers/usb/phy/phy-tegra-usb.c                    |    8 +-
 drivers/usb/phy/phy-twl6030-usb.c                  |    6 +-
 drivers/usb/renesas_usbhs/common.c                 |    2 +-
 drivers/usb/serial/option.c                        |    6 +
 drivers/usb/serial/quatech2.c                      |    8 -
 drivers/usb/typec/hd3ss3220.c                      |    2 +-
 drivers/usb/typec/tcpm/fusb302.c                   |    4 +-
 drivers/usb/typec/tcpm/tcpci_mt6360.c              |    6 -
 drivers/usb/typec/tcpm/tcpm.c                      |   20 +-
 drivers/usb/typec/tipd/core.c                      |   51 +-
 drivers/usb/typec/ucsi/Kconfig                     |   10 +
 drivers/usb/typec/ucsi/Makefile                    |    1 +
 drivers/usb/typec/ucsi/ucsi.c                      |    6 +-
 drivers/usb/typec/ucsi/ucsi_acpi.c                 |   44 +-
 drivers/usb/typec/ucsi/ucsi_glink.c                |  345 +++
 include/linux/platform_data/usb3503.h              |    1 +
 include/linux/usb.h                                |    8 +-
 include/linux/usb/composite.h                      |    8 +
 include/linux/usb/gadget.h                         |    9 +
 include/linux/usb/hcd.h                            |    2 -
 179 files changed, 3323 insertions(+), 7858 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,imx8mq-dwc3.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/typec-tcpci.txt
 delete mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt
 delete mode 100644 drivers/usb/host/u132-hcd.c
 delete mode 100644 drivers/usb/misc/ftdi-elan.c
 create mode 100644 drivers/usb/typec/ucsi/ucsi_glink.c
