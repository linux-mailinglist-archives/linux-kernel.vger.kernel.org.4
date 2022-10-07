Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D425F7B93
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJGQgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiJGQgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:36:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8410B92F4C;
        Fri,  7 Oct 2022 09:36:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0154261DA6;
        Fri,  7 Oct 2022 16:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02A0C43140;
        Fri,  7 Oct 2022 16:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665160559;
        bh=qPGs1xYlFdI7ULhNUtUt9clLfQYPwF6Vg2aQHAMioFo=;
        h=Date:From:To:Cc:Subject:From;
        b=2Rtl2iIGuPTFwAEQuEsbuFNNco+FbpM4QsP+oFhDalFJQ77mJRB13/j1ZDrQ+ubs4
         VSBDApBeBqANhQL2tQdCsRzVhiJxHFkeQ3UoThkoFRMjRP1WmCA2Z0dWB3UASrZfWb
         HF6ofx/a+1ztuslBkdxakBMuGpO0Ro8DNO9nvA8k=
Date:   Fri, 7 Oct 2022 18:36:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt driver changes for 6.1-rc1
Message-ID: <Y0BVmJb6dpD8jrFF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f76349cf41451c5c42a99f18a9163377e4b364ff:

  Linux 6.0-rc7 (2022-09-25 14:01:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.1-rc1

for you to fetch changes up to 00988f70a0763f14c97c4c0df76fb9aa4959e953:

  Merge tag 'usb-serial-6.0-rc8' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next (2022-10-01 18:36:04 +0200)

----------------------------------------------------------------
USB/Thunderbolt changes for 6.1-rc1

Here is the big set of USB and Thunderbolt driver changes for 6.1-rc1.

Nothing major in here, lots of little things with new devices supported
and updates for a few drivers.  Highlights include:
	- thunderbolt/USB4 devices supported a bit better than before,
	  and some new ids to enable new hardware devices
	- USB gadget uvc updates for newer video formats and better v4l
	  integration (the v4l portions were acked by those maintainers)
	- typec updates for tiny issues and more typec drivers for new
	  chips.
	- xhci tiny updates for minor issues
	- big usb-serial ftdi_sio driver update to handle new devices
	  better
	- lots of tiny dwc3 fixes and updates for the IP block that is
	  showing up everywhere these days
	- dts updates for new devices being supported
	- other tiny janitorial and cleanups fixes for lots of different
	  USB drivers.  Full details are in the shortlog.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Albert Briscoe (1):
      usb: gadget: function: fix dangling pnp_string in f_printer.c

Alexander Stein (3):
      dt-bindings: usb: dwc3: Add gfladj-refclk-lpm-sel-quirk
      usb: dwc3: core: add gfladj_refclk_lpm_sel quirk
      arm64: dts: imx8mp: Add snps,gfladj-refclk-lpm-sel quirk to USB nodes

Amireddy mallikarjuna reddy (1):
      USB: serial: ftdi_sio: add support for HP and HA devices

Andy Shevchenko (5):
      thunderbolt: Convert to use sysfs_emit()/sysfs_emit_at() APIs
      thunderbolt: Use dev_err_probe()
      usb: typec: Replace custom implementation of device_match_fwnode()
      Revert "USB: fixup for merge issue with "usb: dwc3: Don't switch OTG -> peripheral if extcon is present""
      Revert "usb: dwc3: Don't switch OTG -> peripheral if extcon is present"

Ard Biesheuvel (2):
      usb: reduce kernel log spam on driver registration
      usb: clean up after dropping driver registration log spam

ChiYuan Huang (2):
      dt-bindings: usb: Add MediaTek MT6370 TCPC
      usb: typec: tcpci_mt6370: Add MediaTek MT6370 tcpci driver

Christophe JAILLET (2):
      usb: common: usb-conn-gpio: Simplify some error message
      usb: dwc2: Remove redundant license text

Chunfeng Yun (1):
      usb: mtu3: fix failed runtime suspend in host only mode

Colin Ian King (4):
      usb: typec: ucsi: stm32g0: Fix spelling mistake "booloader" -> "bootloader"
      thunderbolt: debugfs: Fix spelling mistakes in seq_puts text
      thunderbolt: Fix spelling mistake "simultaneusly" -> "simultaneously"
      USB: omap_udc: Fix spelling mistake: "tranceiver_ctrl" -> "transceiver_ctrl"

Dan Carpenter (2):
      usb: gadget: f_fs: stricter integer overflow checks
      usb: dwc3: core: fix some leaks in probe

Dmitry Torokhov (3):
      usb: phy: tegra: switch to using devm_gpiod_get()
      usb: gadget: udc: at91: switch to using fwnode_gpiod_get_index()
      usb: host: ehci-exynos: switch to using gpiod API

Dongliang Mu (4):
      usb: misc: uss720: fix uninitialized variable rlen
      usb: misc: usb3503: call clk_disable_unprepare in the error handling
      usb: cdns3: remove dead code
      usb: idmouse: fix an uninit-value in idmouse_open

Felipe Balbi (1):
      MAINTAINERS: switch dwc3 to Thinh

Frank Li (2):
      doc: dt-binding: mxs-usb-phy: fix fsl,tx-cal-45-dn-ohms max and min value
      usb: phy: mxs: fix MXS_PHY_TX_CAL45_MIN and MXS_PHY_TX_CAL45_MAX

Frank Wunderlich (1):
      USB: serial: qcserial: add new usb-id for Dell branded EM7455

Gene Chen (7):
      dt-bindings usb: typec: rt1711h: Add binding for Richtek RT1711H
      usb: typec: tcpci_rt1711h: Fix vendor setting when set vconn
      usb: typec: tcpci_rt1711h: Add regulator support when source vbus
      usb: typec: tcpci_rt1711h: Add initial phy setting
      usb: typec: tcpci_rt1711h: Add compatible id with rt1715
      usb: typec: tcpci: Move function "tcpci_to_typec_cc" to common
      usb: typec: tcpci_rt1711h: Fix CC PHY noise filter of voltage level

Greg Kroah-Hartman (7):
      USB: gadget: f_mass_storage: get rid of DEVICE_ATTR() usage
      Merge 6.0-rc4 into usb-next
      USB: xhci: make xhci_get_endpoint_address static
      Merge tag 'usb-serial-6.1-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next
      Merge 6.0-rc7 into usb-next
      Merge tag 'thunderbolt-for-v6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
      Merge tag 'usb-serial-6.0-rc8' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next

Hannu Hartikainen (1):
      USB: add RESET_RESUME quirk for NVIDIA Jetson devices in RCM

Heikki Krogerus (1):
      USB: hcd-pci: Drop the unused id parameter from usb_hcd_pci_probe()

Iskren Chernev (1):
      dt-bindings: usb: qcom,dwc3: Fix SM6115 clocks, irqs

Jack Wang (1):
      usb/hcd: Fix dma_map_sg error check

Jean-Francois Le Fillatre (1):
      usb: add quirks for Lenovo OneLink+ Dock

Jianglei Nie (1):
      usb: host: xhci: Fix potential memory leak in xhci_alloc_stream_info()

Jiasheng Jiang (1):
      USB: serial: ftdi_sio: convert to use dev_groups

Jim Lin (2):
      phy: tegra: xusb: add utmi pad power on/down ops
      usb: gadget: tegra: Reduce pad power

Johan Hovold (20):
      usb: dwc3: qcom: only parse 'maximum-speed' once
      usb: dwc3: qcom: clean up icc init
      USB: serial: ftdi_sio: fix 300 bps rate for SIO
      USB: serial: ftdi_sio: clean up chip type enum
      USB: serial: ftdi_sio: drop redundant chip type comments
      USB: serial: ftdi_sio: rename chip types
      USB: serial: ftdi_sio: include FT2232D in type string
      USB: serial: ftdi_sio: rename channel index
      USB: serial: ftdi_sio: tighten device-type detection
      USB: serial: ftdi_sio: clean up modem-status handling
      USB: serial: ftdi_sio: clean up attribute handling
      USB: serial: ftdi_sio: clean up baudrate request
      USB: serial: ftdi_sio: assume hi-speed type
      USB: serial: ftdi_sio: simplify divisor handling
      USB: serial: ftdi_sio: clean up attribute visibility logic
      USB: serial: ftdi_sio: move driver structure
      USB: serial: ftdi_sio: clean up driver prefix
      media: flexcop-usb: clean up endpoint sanity checks
      media: flexcop-usb: clean up URB initialisation
      media: flexcop-usb: use usb_endpoint_maxp()

Johan Jonker (1):
      dt-bindings: usb: dwc2: rockchip: add rockchip,rk3128-usb

Justin Chen (2):
      usb: host: xhci-plat: suspend and resume clocks
      usb: host: xhci-plat: suspend/resume clks for brcm

Khalid Masum (2):
      usb: ehci: Use endpoint in URB to get maxpacket
      usb: host: Initiate urb ep with udev ep0

Krzysztof Kozlowski (1):
      usb: dwc3: qcom: drop unneeded compatibles

Kushagra Verma (1):
      usb: dwc3: Fix typos in gadget.c

Liang He (2):
      USB: serial: console: move mutex_unlock() before usb_serial_put()
      usb: typec: anx7411: Use of_get_child_by_name() instead of of_find_node_by_name()

Linus Walleij (3):
      USB: FHCI: Switch to GPIO descriptors
      USB/ARM: Switch S3C2410 UDC to GPIO descriptors
      dt-bindings: usb: Convert FOTG210 to dt schema

Liu Shixin (1):
      usb: ulpi: use DEFINE_SHOW_ATTRIBUTE to simplify ulpi_regs

Lukas Bulwahn (1):
      usb: chipidea: make configs for glue drivers visible with EXPERT

Maciej Żenczykowski (1):
      usb: gadget: f_ncm: noop - remove INIT_NDP{16,32}_OPTS macros

Mario Limonciello (2):
      xhci: Don't show warning for reinit on known broken suspend
      thunderbolt: Explicitly enable lane adapter hotplug events at startup

Mathias Nyman (3):
      xhci: show fault reason for a failed enable slot command
      xhci: remove unused command member from struct xhci_hcd struct
      xhci: remove unused lpm_failed_dev member from struct xhci_hcd

Michael Grzeschik (9):
      usb: dwc3: gadget: conditionally remove requests
      usb: dwc3: debug: show events parameters in hex
      usb: dwc3: trace: add Start of Frame Number to trace event
      usb: gadget: uvc: increase worker prio to WQ_HIGHPRI
      media: v4l: move helper functions for fractions from uvc to v4l2-common
      media: uvcvideo: move uvc_format_desc to common header
      usb: gadget: uvc: add v4l2 enumeration api calls
      usb: gadget: uvc: add v4l2 try_format api call
      usb: gadget: uvc: don't put item still in use

Mika Westerberg (8):
      thunderbolt: Add comment where Thunderbolt 4 PCI IDs start
      thunderbolt: Add support for Intel Meteor Lake
      thunderbolt: Move tb_xdomain_parent() to tb.h
      thunderbolt: Move port CL state functions into correct place in switch.c
      thunderbolt: Pass CL state bitmask to tb_port_clx_supported()
      thunderbolt: Add helper to check if CL states are enabled on port
      thunderbolt: Add support for receiver lane margining
      thunderbolt: Provide tb_retimer_nvm_read() analogous to tb_switch_nvm_read()

Nathan Chancellor (1):
      usb: gadget: uvc: Fix argument to sizeof() in uvc_register_video()

Phil Edworthy (2):
      dt-bindings: usb: renesas, usb3-peri: Document RZ/V2M r9a09g011 support
      usb: gadget: udc: renesas_usb3: Add support for RZ/V2M

Piyush Mehta (5):
      usb: chipidea: Add support for VBUS control with PHY
      usb: dwc3: xilinx: add power management ops support
      usb: dwc3: xilinx: fix usb3 non-wakeup source resume failure
      dt-bindings: usb: snps,dwc3: Add 'snps,resume-hs-terminations' quirk
      usb: dwc3: core: Enable GUCTL1 bit 10 for fixing termination error after resume bug

Rafael Mendonca (1):
      xhci: dbc: Fix memory leak in xhci_alloc_dbc()

Randy Dunlap (1):
      usb: chipidea: clarify Documentation/ABI text

Ray Hung (1):
      usb: gadget: rndis: use %u instead of %d to print u32 values

Richard Acayan (2):
      dt-bindings: phy: qcom,qusb2: document sdm670 compatible
      dt-bindings: usb: dwc3: add sdm670 compatible

Rob Herring (1):
      dt-bindings: usb: Add missing (unevaluated|additional)Properties on child nodes

Robin Guo (1):
      usb: musb: Fix musb_gadget.c rxstate overflow bug

Sanjay R Mehta (1):
      thunderbolt: Add DP OUT resource when DP tunnel is discovered

Sergey Shtylyov (1):
      usb: gadget: function: rndis: limit # of RNDIS instances to 1000

Shang XiaoJing (1):
      usb: cdc-wdm: Use skb_put_data() instead of skb_put/memcpy pair

Shaomin Deng (2):
      usb: gadget: net2272: Remove the initialization of statics to 0
      usb: gadget: at91_udc: Fix comments typo

Shruthi Sanil (2):
      usb: dwc3: pci: Update the macro names for USB PCIe device ID's for Alder Lake platforms
      usb: dwc3: pci: Add PCIe device ID for USB3 controller on CPU sub-system for Alder Lake P

Shuah Khan (1):
      usbip: add USBIP_URB_* URB transfer flags

Sing-Han Chen (1):
      usb: typec: ucsi_ccg: Disable UCSI ALT support on Tegra

Szuying Chen (5):
      thunderbolt: Allow NVM upgrade of USB4 host routers
      thunderbolt: Extend NVM version fields to 32-bits
      thunderbolt: Rename and make nvm_read() available for other files
      thunderbolt: Move vendor specific NVM handling into nvm.c
      thunderbolt: Add support for ASMedia NVM image format

Tadeusz Struk (1):
      usb: mon: make mmapped memory read only

Thinh Nguyen (1):
      usb: common: debug: Check non-standard control requests

Tomer Maimon (3):
      usb: host: npcm7xx: remove USB EHCI host reset sequence
      dt-bindings: usb: npcm7xx: Add npcm845 compatible
      USB: host: npcm: Add NPCM8XX support

Wayne Chang (1):
      usb: typec: ucsi: Don't warn on probe deferral

Wesley Cheng (10):
      usb: dwc3: Do not service EP0 and conndone events if soft disconnected
      usb: dwc3: gadget: Force sending delayed status during soft disconnect
      usb: dwc3: gadget: Synchronize IRQ between soft connect/disconnect
      usb: dwc3: gadget: Continue handling EP0 xfercomplete events
      usb: dwc3: Avoid unmapping USB requests if endxfer is not complete
      usb: dwc3: Remove DWC3 locking during gadget suspend/resume
      usb: dwc3: Increase DWC3 controller halt timeout
      usb: dwc3: gadget: Skip waiting for CMDACT cleared during endxfer
      usb: dwc3: gadget: Submit endxfer command if delayed during disconnect
      usb: dwc3: gadget: Do not clear ep delayed stop flag during ep disable

Wolfram Sang (1):
      usb: move from strlcpy with unused retval to strscpy

Xiu Jianfeng (1):
      usb: gadget: add _init/__exit annotations to module init/exit funcs

Yang Yingliang (11):
      usb: usb251xb: Switch to use dev_err_probe() helper
      usb: typec: stusb160x: Switch to use dev_err_probe() helper
      usb: typec: qcom-pmic-typec: Switch to use dev_err_probe() helper
      usb: typec: fusb302: Switch to use dev_err_probe() helper
      usb: musb: core: Switch to use dev_err_probe() helper
      usb: musb: da8xx: Switch to use dev_err_probe() helper
      usb: musb: cppi41: Switch to use dev_err_probe() helper
      usb: musb: jz4740: Switch to use dev_err_probe() helper
      usb: musb: sunxi: Switch to use dev_err_probe() helper
      usb: phy: generic: Switch to use dev_err_probe() helper
      USB: PHY: JZ4770: Switch to use dev_err_probe() helper

Yinbo Zhu (1):
      usb: ohci-platform: fix usb disconnect issue after s4

sunghwan jung (1):
      Revert "usb: storage: Add quirk for Samsung Fit flash"

 Documentation/ABI/testing/sysfs-bus-thunderbolt    |   4 +-
 .../ABI/testing/sysfs-platform-chipidea-usb2       |   6 +-
 .../devicetree/bindings/phy/mxs-usb-phy.txt        |   4 +-
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |   1 +
 .../devicetree/bindings/usb/analogix,anx7411.yaml  |   2 +
 .../devicetree/bindings/usb/aspeed,usb-vhub.yaml   |   2 +
 Documentation/devicetree/bindings/usb/dwc2.yaml    |   1 +
 .../devicetree/bindings/usb/faraday,fotg210.txt    |  35 -
 .../devicetree/bindings/usb/faraday,fotg210.yaml   |  77 ++
 .../bindings/usb/mediatek,mt6370-tcpc.yaml         |  36 +
 .../devicetree/bindings/usb/npcm7xx-usb.txt        |   4 +-
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |   6 +-
 .../devicetree/bindings/usb/renesas,usb3-peri.yaml |  99 ++-
 .../devicetree/bindings/usb/richtek,rt1711h.yaml   | 100 +++
 .../devicetree/bindings/usb/snps,dwc3.yaml         |  12 +
 .../devicetree/bindings/usb/st,stusb160x.yaml      |  12 +-
 .../devicetree/bindings/usb/willsemi,wusb3801.yaml |   1 +
 Documentation/usb/usbip_protocol.rst               |  13 +-
 MAINTAINERS                                        |   3 +-
 arch/arm/mach-s3c/mach-gta02.c                     |  10 +-
 arch/arm/mach-s3c/mach-h1940.c                     |  13 +-
 arch/arm/mach-s3c/mach-jive.c                      |  10 +-
 arch/arm/mach-s3c/mach-mini2440.c                  |   9 +-
 arch/arm/mach-s3c/mach-n30.c                       |  13 +-
 arch/arm/mach-s3c/mach-rx1950.c                    |  13 +-
 arch/arm/mach-s3c/mach-smdk2413.c                  |  12 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |   4 +-
 drivers/media/usb/b2c2/flexcop-usb.c               |  22 +-
 drivers/media/usb/uvc/uvc_ctrl.c                   |   1 +
 drivers/media/usb/uvc/uvc_driver.c                 | 290 +------
 drivers/media/usb/uvc/uvc_v4l2.c                   |  14 +-
 drivers/media/usb/uvc/uvcvideo.h                   | 147 ----
 drivers/media/v4l2-core/v4l2-common.c              |  86 +++
 drivers/phy/tegra/xusb-tegra186.c                  |  19 +-
 drivers/phy/tegra/xusb.c                           |  22 +-
 drivers/phy/tegra/xusb.h                           |   4 +-
 drivers/thunderbolt/Kconfig                        |  10 +
 drivers/thunderbolt/debugfs.c                      | 836 +++++++++++++++++++++
 drivers/thunderbolt/domain.c                       |  10 +-
 drivers/thunderbolt/icm.c                          |   3 +
 drivers/thunderbolt/nhi.c                          |  55 +-
 drivers/thunderbolt/nhi.h                          |   3 +
 drivers/thunderbolt/nvm.c                          | 385 +++++++++-
 drivers/thunderbolt/retimer.c                      | 113 ++-
 drivers/thunderbolt/sb_regs.h                      |  58 ++
 drivers/thunderbolt/switch.c                       | 449 ++++++-----
 drivers/thunderbolt/tb.c                           |  33 +-
 drivers/thunderbolt/tb.h                           |  56 +-
 drivers/thunderbolt/tb_regs.h                      |   3 +
 drivers/thunderbolt/usb4.c                         | 140 ++++
 drivers/thunderbolt/xdomain.c                      |  35 +-
 drivers/usb/atm/usbatm.c                           |   2 +-
 drivers/usb/cdns3/cdns3-plat.c                     |   2 -
 drivers/usb/chipidea/Kconfig                       |  10 +-
 drivers/usb/chipidea/ci_hdrc_usb2.c                |   1 +
 drivers/usb/chipidea/host.c                        |   7 +
 drivers/usb/chipidea/otg_fsm.c                     |   7 +
 drivers/usb/class/cdc-wdm.c                        |   2 +-
 drivers/usb/common/debug.c                         |  96 ++-
 drivers/usb/common/ulpi.c                          |  20 +-
 drivers/usb/common/usb-conn-gpio.c                 |   6 +-
 drivers/usb/core/devio.c                           |   2 +-
 drivers/usb/core/hcd-pci.c                         |   7 +-
 drivers/usb/core/hcd.c                             |  11 +-
 drivers/usb/core/quirks.c                          |  13 +
 drivers/usb/dwc2/core.c                            |  30 -
 drivers/usb/dwc2/core.h                            |  30 -
 drivers/usb/dwc2/core_intr.c                       |  30 -
 drivers/usb/dwc2/hcd.c                             |  30 -
 drivers/usb/dwc2/hcd.h                             |  31 +-
 drivers/usb/dwc2/hcd_ddma.c                        |  30 -
 drivers/usb/dwc2/hcd_intr.c                        |  30 -
 drivers/usb/dwc2/hcd_queue.c                       |  30 -
 drivers/usb/dwc2/hw.h                              |  30 -
 drivers/usb/dwc2/params.c                          |  30 -
 drivers/usb/dwc2/pci.c                             |  30 -
 drivers/usb/dwc2/platform.c                        |  30 -
 drivers/usb/dwc3/core.c                            | 137 ++--
 drivers/usb/dwc3/core.h                            |   7 +
 drivers/usb/dwc3/debug.h                           |   4 +-
 drivers/usb/dwc3/drd.c                             |  50 ++
 drivers/usb/dwc3/dwc3-pci.c                        |  14 +-
 drivers/usb/dwc3/dwc3-qcom.c                       |  22 +-
 drivers/usb/dwc3/dwc3-xilinx.c                     |  63 +-
 drivers/usb/dwc3/ep0.c                             |  11 +-
 drivers/usb/dwc3/gadget.c                          |  73 +-
 drivers/usb/dwc3/trace.h                           |   3 +-
 drivers/usb/gadget/function/f_fs.c                 |   6 +-
 drivers/usb/gadget/function/f_mass_storage.c       |  11 +-
 drivers/usb/gadget/function/f_ncm.c                |  60 +-
 drivers/usb/gadget/function/f_printer.c            |  12 +-
 drivers/usb/gadget/function/f_tcm.c                |   4 +-
 drivers/usb/gadget/function/f_uvc.c                |  37 +-
 drivers/usb/gadget/function/rndis.c                |   4 +-
 drivers/usb/gadget/function/u_ether.c              |   8 +-
 drivers/usb/gadget/function/u_serial.c             |   4 +-
 drivers/usb/gadget/function/uvc.h                  |   3 +
 drivers/usb/gadget/function/uvc_v4l2.c             | 294 +++++++-
 drivers/usb/gadget/function/uvc_video.c            |   9 +-
 drivers/usb/gadget/udc/at91_udc.c                  |  10 +-
 drivers/usb/gadget/udc/net2272.c                   |   4 +-
 drivers/usb/gadget/udc/omap_udc.c                  |   4 +-
 drivers/usb/gadget/udc/renesas_usb3.c              | 131 +++-
 drivers/usb/gadget/udc/s3c2410_udc.c               |  78 +-
 drivers/usb/gadget/udc/s3c2410_udc.h               |   3 +
 drivers/usb/gadget/udc/tegra-xudc.c                |   6 +-
 drivers/usb/host/Kconfig                           |   8 +-
 drivers/usb/host/ehci-atmel.c                      |   3 -
 drivers/usb/host/ehci-exynos.c                     |  19 +-
 drivers/usb/host/ehci-fsl.c                        |   2 -
 drivers/usb/host/ehci-hcd.c                        |   1 -
 drivers/usb/host/ehci-npcm7xx.c                    |  53 --
 drivers/usb/host/ehci-omap.c                       |   2 -
 drivers/usb/host/ehci-orion.c                      |   4 -
 drivers/usb/host/ehci-pci.c                        |   4 +-
 drivers/usb/host/ehci-platform.c                   |   4 -
 drivers/usb/host/ehci-q.c                          |   4 +-
 drivers/usb/host/ehci-spear.c                      |   4 -
 drivers/usb/host/ehci-st.c                         |   4 -
 drivers/usb/host/fhci-hcd.c                        |  63 +-
 drivers/usb/host/fhci-hub.c                        |  15 +-
 drivers/usb/host/fhci.h                            |   4 +-
 drivers/usb/host/fotg210-hcd.c                     |   1 -
 drivers/usb/host/ohci-at91.c                       |   3 -
 drivers/usb/host/ohci-da8xx.c                      |   1 -
 drivers/usb/host/ohci-exynos.c                     |   2 -
 drivers/usb/host/ohci-hcd.c                        |   1 -
 drivers/usb/host/ohci-nxp.c                        |   2 -
 drivers/usb/host/ohci-omap.c                       |   2 -
 drivers/usb/host/ohci-pci.c                        |   4 +-
 drivers/usb/host/ohci-platform.c                   |  32 +-
 drivers/usb/host/ohci-pxa27x.c                     |   4 -
 drivers/usb/host/ohci-s3c2410.c                    |   3 -
 drivers/usb/host/ohci-spear.c                      |   3 -
 drivers/usb/host/ohci-st.c                         |   4 -
 drivers/usb/host/u132-hcd.c                        |   1 -
 drivers/usb/host/uhci-hcd.c                        |   2 -
 drivers/usb/host/uhci-pci.c                        |   2 +-
 drivers/usb/host/xhci-dbgcap.c                     |   2 +-
 drivers/usb/host/xhci-mem.c                        |   7 +-
 drivers/usb/host/xhci-pci.c                        |   2 +-
 drivers/usb/host/xhci-plat.c                       |  18 +-
 drivers/usb/host/xhci.c                            |   8 +-
 drivers/usb/host/xhci.h                            |   5 +-
 drivers/usb/misc/idmouse.c                         |   8 +-
 drivers/usb/misc/usb251xb.c                        |  18 +-
 drivers/usb/misc/usb3503.c                         |  25 +-
 drivers/usb/misc/uss720.c                          |   8 +-
 drivers/usb/mon/mon_bin.c                          |   5 +
 drivers/usb/mtu3/mtu3_core.c                       |   2 -
 drivers/usb/mtu3/mtu3_plat.c                       |   2 +
 drivers/usb/musb/da8xx.c                           |   8 +-
 drivers/usb/musb/jz4740.c                          |  10 +-
 drivers/usb/musb/musb_core.c                       |   4 +-
 drivers/usb/musb/musb_cppi41.c                     |   6 +-
 drivers/usb/musb/musb_gadget.c                     |   3 +
 drivers/usb/musb/sunxi.c                           |  29 +-
 drivers/usb/phy/phy-generic.c                      |   9 +-
 drivers/usb/phy/phy-jz4770.c                       |  25 +-
 drivers/usb/phy/phy-mxs-usb.c                      |   4 +-
 drivers/usb/phy/phy-tegra-usb.c                    |  14 +-
 drivers/usb/serial/console.c                       |   2 +-
 drivers/usb/serial/ftdi_sio.c                      | 485 ++++++------
 drivers/usb/serial/ftdi_sio.h                      |  22 +-
 drivers/usb/serial/ftdi_sio_ids.h                  |   7 +
 drivers/usb/serial/qcserial.c                      |   1 +
 drivers/usb/storage/onetouch.c                     |   2 +-
 drivers/usb/storage/unusual_devs.h                 |   6 -
 drivers/usb/typec/anx7411.c                        |   4 +-
 drivers/usb/typec/mux.c                            |   4 +-
 drivers/usb/typec/qcom-pmic-typec.c                |   5 +-
 drivers/usb/typec/retimer.c                        |   2 +-
 drivers/usb/typec/stusb160x.c                      |   7 +-
 drivers/usb/typec/tcpm/Kconfig                     |  11 +
 drivers/usb/typec/tcpm/Makefile                    |   1 +
 drivers/usb/typec/tcpm/fusb302.c                   |   7 +-
 drivers/usb/typec/tcpm/tcpci.c                     |  22 -
 drivers/usb/typec/tcpm/tcpci_mt6370.c              | 207 +++++
 drivers/usb/typec/tcpm/tcpci_rt1711h.c             | 150 +++-
 drivers/usb/typec/ucsi/ucsi.c                      |   8 +-
 drivers/usb/typec/ucsi/ucsi_ccg.c                  |  12 +
 drivers/usb/typec/ucsi/ucsi_stm32g0.c              |   2 +-
 drivers/usb/usbip/stub_main.c                      |   2 +-
 drivers/usb/usbip/stub_rx.c                        |   4 +-
 drivers/usb/usbip/usbip_common.c                   |  91 ++-
 include/linux/phy/tegra/xusb.h                     |   4 +-
 include/linux/platform_data/usb-s3c2410_udc.h      |   6 -
 include/linux/usb/chipidea.h                       |   1 +
 include/linux/usb/hcd.h                            |   1 -
 include/linux/usb/tcpci.h                          |  22 +
 include/media/v4l2-common.h                        |   4 +
 include/media/v4l2-uvc.h                           | 359 +++++++++
 include/uapi/linux/usbip.h                         |  26 +
 193 files changed, 4605 insertions(+), 2280 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/faraday,fotg210.txt
 create mode 100644 Documentation/devicetree/bindings/usb/faraday,fotg210.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
 create mode 100644 drivers/usb/typec/tcpm/tcpci_mt6370.c
 create mode 100644 include/media/v4l2-uvc.h
