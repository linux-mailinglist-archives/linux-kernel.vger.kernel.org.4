Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFC264E842
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 09:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiLPInr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 03:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLPInq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 03:43:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA4F37209;
        Fri, 16 Dec 2022 00:43:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 149FB61CFF;
        Fri, 16 Dec 2022 08:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9EDC433EF;
        Fri, 16 Dec 2022 08:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671180223;
        bh=Yp2wfQuq6b42j2Cw+q5cMw1sNl+rSndGW331mgoM+/Q=;
        h=Date:From:To:Cc:Subject:From;
        b=BpGbLSXzc+8+BZ39ybKk66s8AQdwWcoKD6IqBDpG7g9nqhgvUZakWNpxMwuQPjbMi
         9J/L9nVg3XWBLpWMC7yxuvt7+/rcS4dLNGG8p+GdwR6WLiHsNKL3ws1R1tG2vlD5QD
         RmHQ+4aFXosEdFfGASy/ad9L29I1ExdJS1To3mOg=
Date:   Fri, 16 Dec 2022 09:43:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt driver changes for 6.2-rc1
Message-ID: <Y5wvvK08gUxb7feH@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

The following changes since commit b7b275e60bcd5f89771e865a8239325f86d9927d:

  Linux 6.1-rc7 (2022-11-27 13:31:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.2-rc1

for you to fetch changes up to 81c25247a2a03a0f97e4805d7aff7541ccff6baa:

  usb: gadget: uvc: Rename bmInterfaceFlags -> bmInterlaceFlags (2022-12-08 16:53:47 +0100)

----------------------------------------------------------------
USB/Thunderbolt driver changes for 6.2-rc1

Here is the large set of USB and Thunderbolt driver changes for 6.2-rc1.
Overall, thanks to the removal of a driver, more lines were removed than
added, a nice change.  Highlights include:
  - removal of the sisusbvga driver that was not used by anyone anymore
  - minor thunderbolt driver changes and tweaks
  - chipidea driver updates
  - usual set of typec driver features and hardware support added
  - musb minor driver fixes
  - fotg210 driver fixes, bringing that hardware back from the "dead"
  - minor dwc3 driver updates
  - addition, and then removal, of a list.h helper function for many USB
    and other subsystem drivers, that ended up breaking the build.  That
    will come back for 6.3-rc1, it missed this merge window.
  - usual xhci updates and enhancements
  - usb-serial driver updates and support for new devices
  - other minor USB driver updates

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: usb: dwc3: Add SM8550 compatible

Alan Stern (1):
      USB: core: Change configuration warnings to notices

Allen-KH Cheng (1):
      dt-bindings: usb: mtu3: add compatible for mt8186

Andrzej Pietrasiewicz (1):
      usb: gadget: function: Simplify diagnostic messaging in printer

Andy Shevchenko (5):
      thunderbolt: Use str_enabled_disabled() helper
      i915: Move list_count() to list.h for broader use
      usb: gadget: hid: Convert to use list_count()
      usb: gadget: udc: bcm63xx: Convert to use list_count()
      xhci: Convert to use list_count()

Arnd Bergmann (1):
      usb: musb: remove unused davinci support

Bhupesh Sharma (1):
      tools: usb: ffs-aio-example: Fix build error with aarch64-*-gnu-gcc toolchain(s)

Brian Norris (2):
      usb: ehci-pci: Set PROBE_PREFER_ASYNCHRONOUS
      usb: xhci-pci: Set PROBE_PREFER_ASYNCHRONOUS

Bruno Thomsen (1):
      USB: serial: cp210x: add Kamstrup RF sniffer PIDs

Christophe JAILLET (3):
      usb: core: Use kstrtobool() instead of strtobool()
      usb: gadget: Use kstrtobool() instead of strtobool()
      usb: fotg210-udc: Remove a useless assignment

Christophe Leroy (1):
      usb: Check !irq instead of irq == NO_IRQ

Chunfeng Yun (2):
      usb: host: xhci-mtk: omit shared hcd if either root hub has no ports
      usb: xhci-mtk: fix leakage of shared hcd when fail to set wakeup irq

Colin Ian King (4):
      usb: ftdi-elan: remove variable err_count
      USB: host: Kconfig: Fix spelling mistake "firwmare" -> "firmware"
      thunderbolt: Remove redundant assignment to variable len
      usb: ftdi-elan: remove variable l

Daniel Scally (1):
      usb: gadget: uvc: Rename bmInterfaceFlags -> bmInterlaceFlags

Dongliang Mu (1):
      usb: cdns3: adjust the partial logic of cdnsp_pci_remove

Duke Xin (1):
      USB: serial: option: add Quectel EM05-G modem

Ferry Toth (2):
      usb: ulpi: defer ulpi_register on ulpi_read_id timeout
      usb: dwc3: core: defer probe on ulpi_read_id timeout

Frank Wunderlich (1):
      dt-bindings: usb: mtk-xhci: add support for mt7986

Geert Uytterhoeven (1):
      usb: USB_FOTG210 should depend on ARCH_GEMINI

Greg Kroah-Hartman (10):
      Merge 6.1-rc3 into usb-next
      Merge 6.1-rc6 into usb-next
      Merge 6.1-rc7 into usb-next
      Merge tag 'thunderbolt-for-v6.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
      Revert "xhci: Convert to use list_count()"
      Revert "usb: gadget: udc: bcm63xx: Convert to use list_count()"
      Revert "usb: gadget: hid: Convert to use list_count()"
      Revert "i915: Move list_count() to list.h for broader use"
      Merge tag 'usb-serial-6.1-rc8' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next
      Merge tag 'usb-serial-6.2-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next

Heikki Krogerus (3):
      usb: typec: retimer: Use device type for matching
      thunderbolt: ACPI: Use the helper fwnode_find_reference()
      usb: typec: ucsi: Resume in separate work

Henry Tian (1):
      usb: gadget: aspeed: fix buffer overflow

Icenowy Zheng (3):
      dt-bindings: vendor-prefixes: add Genesys Logic
      dt-bindings: usb: Add binding for Genesys Logic GL850G hub controller
      usb: misc: onboard_usb_hub: add Genesys Logic GL850G hub support

Ivaylo Dimitrov (1):
      usb: musb: remove extra check in musb_gadget_vbus_draw

Jean Delvare (2):
      usb: misc: onboard_usb_hub: Drop obsolete dependency on COMPILE_TEST
      usb: gadget: udc: drop obsolete dependencies on COMPILE_TEST

Jiantao Zhang (1):
      USB: gadget: Fix use-after-free during usb config switch

Jiasheng Jiang (1):
      usb: storage: Add check for kcalloc

Jiri Slaby (SUSE) (3):
      USB: sisusbvga: remove console support
      USB: sisusbvga: rename sisusb.c to sisusbvga.c
      USB: sisusbvga: use module_usb_driver()

Johan Hovold (4):
      USB: serial: cp210x: add support for B0 hangup
      USB: serial: f81232: fix division by zero on line-speed change
      USB: serial: f81534: fix division by zero on line-speed change
      USB: serial: xr: avoid requesting zero DTE rate

John Keeping (3):
      usb: gadget: f_hid: fix f_hidg lifetime vs cdev
      usb: gadget: f_hid: fix refcount leak on error path
      usb: gadget: f_hid: tidy error handling in hidg_alloc

Jonathan Neuschäfer (1):
      usb: chipidea: ci_hdrc_imx: Fix a typo ("regualator")

Jose Ignacio Tornos Martinez (1):
      USB: usbip: missing lock in stub down

Jules Irenge (1):
      usbip: vudc: Convert snprintf() to sysfs_emit()

Li Jun (6):
      usb: chipidea: usbmisc: group usbmisc operations for PM
      usb: chipidea: usbmisc: add power lost check for imx6sx
      usb: chipidea: usbmisc: add power lost check for imx7d
      usb: chipidea: usbmisc: add power lost check for imx7ulp
      dt-bindings: usb: usb-nop-xceiv: add wakeup-source property
      usb: phy: generic: Add wakeup capability

Linus Walleij (12):
      dt-bindings: usb: dwc2: Add some missing Lantiq variants
      usb: phy: phy-gpio-vbus-usb: Add device tree probing
      usb: fotg210: Collect pieces of dual mode controller
      usb: fotg210: Compile into one module
      usb: fotg210: Select subdriver by mode
      usb: fotg2: add Gemini-specific handling
      usb: fotg210-udc: Fix ages old endianness issues
      usb: fotg210: Fix Kconfig for USB host modules
      fotg210-udc: Use dev pointer in probe and dev_messages
      fotg210-udc: Support optional external PHY
      fotg210-udc: Handle PCLK
      fotg210-udc: Get IRQ using platform_get_irq()

Longfang Liu (1):
      xhci: print warning when HCE was set

Lukas Bulwahn (3):
      usb: musb: remove left-over after USB_TI_CPPI_DMA removal
      MAINTAINERS: rectify entry for MICROCHIP USB251XB DRIVER
      usb: dwc3: improve the config dependency of USB_DWC3_XILINX

Marek Vasut (2):
      dt-bindings: usb: usb251xb: Convert to YAML schema
      extcon: usbc-tusb320: Update state on probe even if no IRQ pending

Mathias Nyman (4):
      xhci: export two xhci_hub functions for xhci-pci module usage
      xhci: disable U3 suspended ports in S4 hibernate poweroff_late stage
      xhci: Prevent infinite loop in transaction errors recovery for streams
      xhci: remove unused stream_id parameter from xhci_handle_halted_endpoint()

Miaoqian Lin (1):
      usb: dwc3: qcom: Fix memory leak in dwc3_qcom_interconnect_init

Michael Grzeschik (2):
      usb: gadget: uvc: default the ctrl request interface offsets
      usb: gadget: at91-udc: simplify at91rm9200_udc_pullup callback

Paul Cercueil (7):
      usb: musb: Add and use inline functions musb_{get,set}_state
      usb: musb: Add and use inline function musb_otg_state_string
      usb: musb: Allow running without CONFIG_USB_PHY
      usb: musb: Support setting OTG mode using generic PHY
      usb: musb: jz4740: Don't disable external hubs
      usb: musb: jz4740: Support the generic PHY framework
      usb: phy: jz4770: Remove driver

Pawel Laszczak (1):
      usb: cdnsp: fix lack of ZLP for ep0

Peng Fan (1):
      dt-bindings: phy: imx8mq-usb: add power-domains property

Prashant Malani (2):
      usb: typec: Add partner PD object wrapper
      platform/chrome: cros_ec_typec: Set parent of partner PD object

Quentin Schulz (2):
      usb: dwc2: disable lpm feature on Rockchip SoCs
      usb: dwc2: power on/off phy for peripheral mode in dual-role mode

Rajat Khandelwal (1):
      thunderbolt: Add wake on connect/disconnect on USB4 ports

Ray Chi (1):
      usb: core: stop USB enumeration if too many retries

Reka Norman (1):
      xhci: Apply XHCI_RESET_TO_DEFAULT quirk to ADL-N

Sascha Hauer (3):
      usb: phy: generic: make vcc regulator optional
      usb: gadget: u_ether: Do not make UDC parent of the net device
      usb: gadget: f_ecm: Always set current gadget in ecm_bind()

Shruthi Sanil (1):
      usb: dwc3: pci: Update PCIe device ID for USB3 controller on CPU sub-system for Raptor Lake

Shuah Khan (1):
      usb/usbip: Fix v_recv_cmd_submit() to use PIPE_BULK define

Sven Peter (7):
      usb: typec: Check for ops->exit instead of ops->enter in altmode_exit
      usb: typec: tipd: Cleanup resources if devm_tps6598_psy_register fails
      usb: typec: tipd: Fix spurious fwnode_handle_put in error path
      usb: typec: tipd: Fix typec_unregister_port error paths
      usb: typec: tipd: Move tps6598x_disconnect error path to its own label
      usb: dwc3: Fix race between dwc3_set_mode and __dwc3_set_mode
      usb: typec: tipd: Set mode of operation for USB Type-C connector

Szymon Heidrich (1):
      usb: gadget: uvc: Prevent buffer overflow in setup handler

Thierry Reding (1):
      dt-bindings: usb: usb-drd: Describe default dual-role mode

Thinh Nguyen (1):
      usb: dwc3: gadget: Reduce TRB IOC settings

Tony Lindgren (2):
      usb: musb: omap2430: Fix probe regression for missing resources
      usb: musb: Drop old unused am35x glue layer

Uwe Kleine-König (14):
      usb: dwc2: platform: Improve error reporting for problems during .remove()
      usb: typec: ucsi: stm32g0: Convert to i2c's .probe_new()
      usb: typec: ucsi/ucsi_ccg: Convert to i2c's .probe_new()
      usb: typec: tcpm/tcpci_rt1711h: Convert to i2c's .probe_new()
      usb: typec: tcpm/tcpci_maxim: Convert to i2c's .probe_new()
      usb: typec: tcpm/tcpci: Convert to i2c's .probe_new()
      usb: typec: tcpm/fusb302: Convert to i2c's .probe_new()
      usb: typec: hd3ss3220: Convert to i2c's .probe_new()
      usb: typec: anx7411: Convert to i2c's .probe_new()
      usb: phy: isp1301: Convert to i2c's .probe_new()
      usb: isp1301-omap: Convert to i2c's .probe_new()
      usb: usb4604: Convert to i2c's .probe_new()
      usb: misc: usb3503: Convert to i2c's .probe_new()
      usb: usb251xb: Convert to i2c's .probe_new()

Vincent Mailhol (1):
      usb: add usb_set_intfdata() documentation

Xu Yang (7):
      usb: chipidea: core: handle usb role switch in a common way
      usb: chipidea: core: add controller resume support when controller is powered off
      usb: chipidea: core: handle suspend/resume for each role
      usb: chipidea: host: add suspend/resume support for host controller
      usb: chipidea: udc: add suspend/resume support for device controller
      usb: chipidea: core: wrap ci_handle_power_lost() with CONFIG_PM_SLEEP
      usb: host: fix a typo in ehci.h

Xuezhi Zhang (1):
      usbip: convert sysfs snprintf to sysfs_emit

Yang Yingliang (5):
      Documentation: devres: add missing PHY helpers
      usb: typec: tcpci: fix of node refcount leak in tcpci_register_port()
      usb: roles: fix of node refcount leak in usb_role_switch_is_parent()
      usb: core: hcd: Fix return value check in usb_hcd_setup_local_mem()
      usb: typec: wusb3801: fix fwnode refcount leak in wusb3801_probe()

Yi Yang (1):
      usb: fotg210-udc: fix potential memory leak in fotg210_udc_probe()

 Documentation/ABI/testing/configfs-usb-gadget-uvc  |    4 +-
 Documentation/ABI/testing/sysfs-bus-usb            |   11 +
 .../bindings/phy/fsl,imx8mq-usb-phy.yaml           |    3 +
 Documentation/devicetree/bindings/usb/dwc2.yaml    |    3 +
 .../devicetree/bindings/usb/genesys,gl850g.yaml    |   48 +
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml |    1 +
 .../devicetree/bindings/usb/mediatek,mtu3.yaml     |    1 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |    3 +
 Documentation/devicetree/bindings/usb/usb-drd.yaml |    1 +
 .../devicetree/bindings/usb/usb-nop-xceiv.yaml     |    5 +
 Documentation/devicetree/bindings/usb/usb251xb.txt |   89 --
 .../devicetree/bindings/usb/usb251xb.yaml          |  271 ++++
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 Documentation/driver-api/driver-model/devres.rst   |    2 +
 MAINTAINERS                                        |    8 +-
 arch/powerpc/configs/ppc6xx_defconfig              |    1 -
 arch/sh/configs/landisk_defconfig                  |    1 -
 drivers/extcon/extcon-usbc-tusb320.c               |   17 +-
 drivers/platform/chrome/cros_ec_typec.c            |    2 +-
 drivers/thunderbolt/acpi.c                         |   12 +-
 drivers/thunderbolt/switch.c                       |    5 +-
 drivers/thunderbolt/tb_regs.h                      |    2 +
 drivers/thunderbolt/usb4.c                         |   33 +-
 drivers/thunderbolt/usb4_port.c                    |    3 +
 drivers/thunderbolt/xdomain.c                      |    4 +-
 drivers/usb/Kconfig                                |    4 +
 drivers/usb/Makefile                               |    2 +
 drivers/usb/cdns3/cdnsp-pci.c                      |    8 +-
 drivers/usb/cdns3/cdnsp-ring.c                     |   42 +-
 drivers/usb/chipidea/ci.h                          |    4 +
 drivers/usb/chipidea/ci_hdrc_imx.c                 |   51 +-
 drivers/usb/chipidea/ci_hdrc_imx.h                 |    4 +-
 drivers/usb/chipidea/core.c                        |  143 +-
 drivers/usb/chipidea/host.c                        |   16 +
 drivers/usb/chipidea/otg.c                         |    2 +-
 drivers/usb/chipidea/otg.h                         |    1 +
 drivers/usb/chipidea/udc.c                         |   32 +
 drivers/usb/chipidea/usbmisc_imx.c                 |  160 +-
 drivers/usb/common/ulpi.c                          |    2 +-
 drivers/usb/core/config.c                          |   82 +-
 drivers/usb/core/hcd-pci.c                         |   13 +
 drivers/usb/core/hcd.c                             |    6 +-
 drivers/usb/core/hub.c                             |   60 +
 drivers/usb/core/hub.h                             |    4 +
 drivers/usb/core/port.c                            |   30 +-
 drivers/usb/core/sysfs.c                           |    7 +-
 drivers/usb/dwc2/gadget.c                          |    6 +-
 drivers/usb/dwc2/params.c                          |    4 +
 drivers/usb/dwc2/platform.c                        |    5 +-
 drivers/usb/dwc3/Kconfig                           |    4 +-
 drivers/usb/dwc3/core.c                            |   23 +-
 drivers/usb/dwc3/dwc3-pci.c                        |    2 +-
 drivers/usb/dwc3/dwc3-qcom.c                       |   13 +-
 drivers/usb/dwc3/gadget.c                          |   14 +-
 drivers/usb/fotg210/Kconfig                        |   38 +
 drivers/usb/fotg210/Makefile                       |   10 +
 drivers/usb/fotg210/fotg210-core.c                 |  166 +++
 drivers/usb/{host => fotg210}/fotg210-hcd.c        |   51 +-
 .../usb/{host/fotg210.h => fotg210/fotg210-hcd.h}  |    0
 drivers/usb/{gadget/udc => fotg210}/fotg210-udc.c  |  164 ++-
 .../udc/fotg210.h => fotg210/fotg210-udc.h}        |    3 +
 drivers/usb/fotg210/fotg210.h                      |   42 +
 drivers/usb/gadget/configfs.c                      |    3 +-
 drivers/usb/gadget/function/f_ecm.c                |   22 +-
 drivers/usb/gadget/function/f_hid.c                |   60 +-
 drivers/usb/gadget/function/f_mass_storage.c       |    3 +-
 drivers/usb/gadget/function/f_printer.c            |    9 +-
 drivers/usb/gadget/function/f_uvc.c                |   20 +-
 drivers/usb/gadget/function/storage_common.c       |    9 +-
 drivers/usb/gadget/function/u_ether.c              |    4 -
 drivers/usb/gadget/function/u_serial.c             |    3 +-
 drivers/usb/gadget/function/uvc_configfs.c         |   12 +-
 drivers/usb/gadget/legacy/serial.c                 |    3 +-
 drivers/usb/gadget/legacy/webcam.c                 |    4 +-
 drivers/usb/gadget/udc/Kconfig                     |   15 +-
 drivers/usb/gadget/udc/Makefile                    |    1 -
 drivers/usb/gadget/udc/aspeed-vhub/core.c          |    2 +-
 drivers/usb/gadget/udc/aspeed-vhub/epn.c           |   16 +-
 drivers/usb/gadget/udc/at91_udc.c                  |    5 +-
 drivers/usb/gadget/udc/core.c                      |   12 +-
 drivers/usb/host/Kconfig                           |   13 +-
 drivers/usb/host/Makefile                          |    1 -
 drivers/usb/host/ehci-grlib.c                      |    2 +-
 drivers/usb/host/ehci-pci.c                        |    7 +-
 drivers/usb/host/ehci-ppc-of.c                     |    2 +-
 drivers/usb/host/ehci.h                            |    2 +-
 drivers/usb/host/fhci-hcd.c                        |    2 +-
 drivers/usb/host/ohci-ppc-of.c                     |    2 +-
 drivers/usb/host/uhci-grlib.c                      |    2 +-
 drivers/usb/host/xhci-hub.c                        |   22 +-
 drivers/usb/host/xhci-mtk.c                        |   73 +-
 drivers/usb/host/xhci-pci.c                        |   63 +-
 drivers/usb/host/xhci-ring.c                       |   42 +-
 drivers/usb/host/xhci.h                            |    2 +-
 drivers/usb/misc/Kconfig                           |    2 +-
 drivers/usb/misc/ftdi-elan.c                       |    4 -
 drivers/usb/misc/onboard_usb_hub.c                 |    2 +
 drivers/usb/misc/onboard_usb_hub.h                 |    5 +
 drivers/usb/misc/sisusbvga/Kconfig                 |   34 -
 drivers/usb/misc/sisusbvga/Makefile                |    3 -
 drivers/usb/misc/sisusbvga/sisusb.h                |   21 -
 drivers/usb/misc/sisusbvga/sisusb_con.c            | 1496 -------------------
 drivers/usb/misc/sisusbvga/sisusb_init.c           |  955 ------------
 drivers/usb/misc/sisusbvga/sisusb_init.h           |  180 ---
 .../usb/misc/sisusbvga/{sisusb.c => sisusbvga.c}   |  289 +---
 drivers/usb/misc/usb251xb.c                        |    5 +-
 drivers/usb/misc/usb3503.c                         |    5 +-
 drivers/usb/misc/usb4604.c                         |    5 +-
 drivers/usb/musb/Kconfig                           |   18 -
 drivers/usb/musb/Makefile                          |    3 -
 drivers/usb/musb/am35x.c                           |  610 --------
 drivers/usb/musb/cppi_dma.c                        | 1547 --------------------
 drivers/usb/musb/davinci.c                         |  606 --------
 drivers/usb/musb/davinci.h                         |  103 --
 drivers/usb/musb/jz4740.c                          |   62 +-
 drivers/usb/musb/musb_core.c                       |  107 +-
 drivers/usb/musb/musb_core.h                       |   24 +
 drivers/usb/musb/musb_debugfs.c                    |    6 +-
 drivers/usb/musb/musb_dma.h                        |   13 +-
 drivers/usb/musb/musb_gadget.c                     |   61 +-
 drivers/usb/musb/musb_host.c                       |   18 +-
 drivers/usb/musb/musb_virthub.c                    |   33 +-
 drivers/usb/musb/omap2430.c                        |   54 +
 drivers/usb/phy/Kconfig                            |   14 +-
 drivers/usb/phy/Makefile                           |    1 -
 drivers/usb/phy/phy-generic.c                      |   18 +-
 drivers/usb/phy/phy-gpio-vbus-usb.c                |   12 +
 drivers/usb/phy/phy-isp1301-omap.c                 |    4 +-
 drivers/usb/phy/phy-isp1301.c                      |    5 +-
 drivers/usb/phy/phy-jz4770.c                       |  353 -----
 drivers/usb/roles/class.c                          |    5 +-
 drivers/usb/serial/cp210x.c                        |   21 +-
 drivers/usb/serial/f81232.c                        |   12 +-
 drivers/usb/serial/f81534.c                        |   12 +-
 drivers/usb/serial/option.c                        |    3 +
 drivers/usb/serial/xr_serial.c                     |    2 -
 drivers/usb/storage/alauda.c                       |    2 +
 drivers/usb/typec/anx7411.c                        |    5 +-
 drivers/usb/typec/bus.c                            |    2 +-
 drivers/usb/typec/class.c                          |   19 +
 drivers/usb/typec/hd3ss3220.c                      |    5 +-
 drivers/usb/typec/retimer.c                        |   16 +-
 drivers/usb/typec/retimer.h                        |    4 +
 drivers/usb/typec/tcpm/fusb302.c                   |    5 +-
 drivers/usb/typec/tcpm/tcpci.c                     |   10 +-
 drivers/usb/typec/tcpm/tcpci_maxim.c               |    4 +-
 drivers/usb/typec/tcpm/tcpci_rt1711h.c             |    5 +-
 drivers/usb/typec/tipd/core.c                      |   20 +-
 drivers/usb/typec/ucsi/ucsi.c                      |   17 +-
 drivers/usb/typec/ucsi/ucsi.h                      |    1 +
 drivers/usb/typec/ucsi/ucsi_ccg.c                  |    5 +-
 drivers/usb/typec/ucsi/ucsi_stm32g0.c              |    4 +-
 drivers/usb/typec/wusb3801.c                       |    2 +-
 drivers/usb/usb-skeleton.c                         |    1 -
 drivers/usb/usbip/stub_dev.c                       |    4 +-
 drivers/usb/usbip/vudc_rx.c                        |    4 +-
 drivers/usb/usbip/vudc_sysfs.c                     |    2 +-
 include/linux/usb.h                                |   12 +
 include/linux/usb/hcd.h                            |    3 +
 include/linux/usb/typec.h                          |    4 +
 include/uapi/linux/usb/g_uvc.h                     |    3 +
 include/uapi/linux/usb/video.h                     |    4 +-
 .../ffs-aio-example/simple/device_app/aio_simple.c |   44 +-
 163 files changed, 2079 insertions(+), 7049 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/usb251xb.txt
 create mode 100644 Documentation/devicetree/bindings/usb/usb251xb.yaml
 create mode 100644 drivers/usb/fotg210/Kconfig
 create mode 100644 drivers/usb/fotg210/Makefile
 create mode 100644 drivers/usb/fotg210/fotg210-core.c
 rename drivers/usb/{host => fotg210}/fotg210-hcd.c (99%)
 rename drivers/usb/{host/fotg210.h => fotg210/fotg210-hcd.h} (100%)
 rename drivers/usb/{gadget/udc => fotg210}/fotg210-udc.c (89%)
 rename drivers/usb/{gadget/udc/fotg210.h => fotg210/fotg210-udc.h} (99%)
 create mode 100644 drivers/usb/fotg210/fotg210.h
 delete mode 100644 drivers/usb/misc/sisusbvga/sisusb_con.c
 delete mode 100644 drivers/usb/misc/sisusbvga/sisusb_init.c
 delete mode 100644 drivers/usb/misc/sisusbvga/sisusb_init.h
 rename drivers/usb/misc/sisusbvga/{sisusb.c => sisusbvga.c} (91%)
 delete mode 100644 drivers/usb/musb/am35x.c
 delete mode 100644 drivers/usb/musb/cppi_dma.c
 delete mode 100644 drivers/usb/musb/davinci.c
 delete mode 100644 drivers/usb/musb/davinci.h
 delete mode 100644 drivers/usb/phy/phy-jz4770.c
