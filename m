Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAA96A1C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjBXMvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjBXMu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:50:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D747A53EC3;
        Fri, 24 Feb 2023 04:50:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66BAF618CA;
        Fri, 24 Feb 2023 12:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFFAC433EF;
        Fri, 24 Feb 2023 12:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677243054;
        bh=aJ5CqmZD6XcsGH5hodxsSekV2txslPQ3b+xjMwoyttg=;
        h=Date:From:To:Cc:Subject:From;
        b=Y0fFNy0rIQD0BXuEhvP/FYITDnER6eqXBDIV6OsBaE+KSnRUoShjdz0EM0b3rcboV
         Woo3N/xakwVh6AZbZ8zTsZUa5O6wGVFWQxPScejhZ01y9kgq1siMuhWyQEcmPRvRMU
         oYq2YP6Bm4wPlAGJpKHcN8YKL4AYR8ZLrdGhfj18=
Date:   Fri, 24 Feb 2023 13:50:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt driver changes for 6.3-rc1
Message-ID: <Y/iyrFP2wO97XvjD@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ceaa837f96adb69c0df0397937cd74991d5d821a:

  Linux 6.2-rc8 (2023-02-12 14:10:17 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.3-rc1

for you to fetch changes up to 1243741f6b02b5f2c06bca910f894c333838f994:

  Merge tag 'usb-serial-6.3-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next (2023-02-16 15:28:28 +0100)

----------------------------------------------------------------
USB / Thunderbolt driver changes for 6.3-rc1

Here is the big set of USB and Thunderbolt driver changes for 6.3-rc1.

Nothing major in here, just lots of good development, including:
  - Thunderbolt additions for new device support and features
  - xhci driver updates and cleanups
  - USB gadget media driver updates (includes media core changes that
    were acked by the v4l2 maintainers)
  - lots of other USB gadget driver updates for new features
  - dwc3 driver updates and fixes
  - minor debugfs leak fixes
  - typec driver updates and additions
  - dt-bindings conversions to yaml
  - other small bugfixes and driver updates

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (2):
      USB: core: Don't hold device lock while reading the "descriptors" sysfs file
      net: USB: Fix wrong-direction WARNING in plusb.c

Alexander Stein (5):
      usb: host: ehci-fsl: Use DRV_NAME
      usb: chipidea: ci_hdrc_imx: use dev_err_probe
      of: device: Ignore modalias of reused nodes
      of: device: Do not ignore error code in of_device_uevent_modalias
      usb: host: fsl-mph-dr-of: reuse device_set_of_node_from_dev

Anand Moon (10):
      dt-bindings: usb: Add device id for Genesys Logic hub controller
      ARM: dts: amlogic: Used onboard usb hub reset to enable usb hub
      arm64: dts: amlogic: Used onboard usb hub reset on odroid c2
      usb: misc: onboard_usb_hub: add Genesys Logic GL852G hub support
      vendor-prefixes: Add VIA Labs, Inc.
      dt-bindings: usb: Add binding for Via lab VL817 hub controller
      arm64: dts: amlogic: Used onboard usb hub reset on odroid c4
      usb: misc: onboard_usb_hub: add VIA LAB VL817 hub support
      arm64: defconfig: Enable USB onboard HUB driver
      dt-bindings: usb: vialab,vl817: Cleanup compatible, reset-gpios and required

Andre Przywara (1):
      usb: musb: sunxi: Introduce config struct

Andy Shevchenko (17):
      thunderbolt: Refactor tb_acpi_add_link()
      i915: Move list_count() to list.h as list_count_nodes() for broader use
      usb: gadget: hid: Convert to use list_count_nodes()
      usb: gadget: udc: bcm63xx: Convert to use list_count_nodes()
      xhci: Convert to use list_count_nodes()
      usb: typec: intel_pmc_mux: Don't leak the ACPI device reference count
      usb: typec: intel_pmc_mux: Deduplicate ACPI matching in probe
      usb: fotg210-hcd: use sysfs_emit() to instead of scnprintf()
      usb: fotg210-hcd: Don't shadow error codes in store()
      usb: fotg210-udc: remove redundant error logging
      usb: fotg210: Switch to use dev_err_probe()
      usb: fotg210: use devm_platform_get_and_ioremap_resource()
      usb: gadget: Move kstrtox() out of lock
      usb: gadget: Use correct APIs and data types for UUID handling
      usg: gadget: Move validation out of lock in webusb_bcdVersion_store()
      usb: gadget: configfs: Use memcpy_and_pad()
      usb: dwc3: xilinx: Remove unused of_gpio,h

Arnd Bergmann (1):
      xhci: split out rcar/rz support from xhci-plat.c

Badhri Jagan Sridharan (4):
      usb: typec: altmodes/displayport: Add hpd sysfs attribute
      usb: typec: tcpm: Add callbacks to mitigate wakeups due to contaminant
      usb: typec: tcpci: Add callback for evaluating contaminant presence
      usb: typec: maxim_contaminant: Implement check_contaminant callback

Biju Das (11):
      dt-bindings: usb: ti,hd3ss3220: Update interrupt property as optional
      usb: typec: hd3ss3220: Add polling support
      dt-bindings: usb: renesas,usb-xhci: Document RZ/V2M support
      dt-bindings: usb: renesas,usb3-peri: Update reset, clock-name and interrupts properties
      dt-bindings: usb: renesas,usb3-peri: Document RZ/V2MA bindings
      dt-bindings: usb: Add RZ/V2M USB3DRD binding
      usb: gadget: Add support for RZ/V2M USB3DRD driver
      usb: gadget: udc: renesas_usb3: Add role switch support for RZ/V2M
      usb: host: xhci-plat: Improve clock handling in probe()
      usb: host: xhci-plat: Add reset support
      xhci: host: Add Renesas RZ/V2M SoC support

Bjorn Andersson (2):
      dt-bindings: usb: Introduce GPIO-based SBU mux
      usb: typec: mux: Introduce GPIO-based SBU mux

Christoph Hellwig (1):
      usb: remove the dead USB_OHCI_SH option

Christophe JAILLET (3):
      usb: early: xhci-dbc: Fix a potential out-of-bound memory access
      usb: early: xhci-dbc: Optimize early_xdbc_write()
      usb: early: xhci-dbc: Use memcpy_and_pad()

Chunfeng Yun (1):
      usb: mtu3: fix the failure of qmu stop

Dan Carpenter (2):
      usb: musb: mediatek: don't unregister something that wasn't registered
      xhci: host: potential NULL dereference in xhci_generic_plat_probe()

Daniel Scally (23):
      usb: gadget: usb: Remove "default" from color matching attributes
      usb: gadget: uvc: Rename uvc_control_ep
      usb: gadget: uvc: Add new enable_interrupt_ep attribute
      usb: gadget: uvc: Disable interrupt endpoint by default
      usb: uvc: Enumerate valid values for color matching
      usb: gadget: uvc: Add struct for color matching in configs
      usb: gadget: uvc: Copy color matching descriptor for each frame
      usb: gadget: uvc: Remove the hardcoded default color matching
      usb: gadget: uvc: Make color matching attributes read/write
      usb: gadget: uvc: Allow creating new color matching descriptors
      usb: gadget: uvc: Correct documentation formatting
      usb: gadget: uvc: Make bSourceID read/write
      usb: gadget: uvc: Generalise helper functions for reuse
      usb: gadget: uvc: Allow definition of XUs in configfs
      usb: gadget: uvc: Copy XU descriptors during .bind()
      usb: gadget: configfs: Rename struct gadget_strings
      usb: gadget: configfs: Support arbitrary string descriptors
      usb: gadget: configfs: Attach arbitrary strings to cdev
      usb: gadget: uvc: Allow linking XUs to string descriptors
      usb: gadget: uvc: Pick up custom string descriptor IDs
      usb: gadget: uvc: Allow linking function to string descs
      usb: gadget: uvc: Use custom strings if available
      usb: gadget: configfs: Fix set but not used variable warning

Fabian Vogt (3):
      fotg210-udc: Add missing completion handler
      fotg210-udc: Introduce and use a fotg210_ack_int function
      fotg210-udc: Improve device initialization

Fabien Parent (2):
      dt-bindings: usb: mediatek,mtu3: add MT8365 SoC bindings
      dt-bindings: usb: mediatek,mtk-xhci: add MT8365 SoC bindings

Florian Zumbiehl (1):
      USB: serial: option: add support for VW/Skoda "Carstick LTE"

Gaosheng Cui (1):
      usb: gadget: fusb300_udc: free irq on the error path in fusb300_probe()

Greg Kroah-Hartman (23):
      Merge 6.2-rc3 into usb-next
      USB: fix memory leak with using debugfs_lookup()
      Revert "arm64: tegra: Enable XUSB host function on Jetson AGX Orin"
      Merge 6.2-rc5 into usb-next
      Merge tag 'media-uvc-next-20230115' of git://git.kernel.org/pub/scm/linux/kernel/git/pinchartl/linux into usb-next
      Merge 6.2-rc7 into usb-next
      drm/i915: fix up merge with usb-next branch
      USB: dwc3: fix memory leak with using debugfs_lookup()
      USB: chipidea: fix memory leak with using debugfs_lookup()
      USB: ULPI: fix memory leak with using debugfs_lookup()
      USB: uhci: fix memory leak with using debugfs_lookup()
      USB: sl811: fix memory leak with using debugfs_lookup()
      USB: fotg210: fix memory leak with using debugfs_lookup()
      USB: isp116x: fix memory leak with using debugfs_lookup()
      USB: isp1362: fix memory leak with using debugfs_lookup()
      USB: gadget: gr_udc: fix memory leak with using debugfs_lookup()
      USB: gadget: bcm63xx_udc: fix memory leak with using debugfs_lookup()
      USB: gadget: lpc32xx_udc: fix memory leak with using debugfs_lookup()
      USB: gadget: pxa25x_udc: fix memory leak with using debugfs_lookup()
      USB: gadget: pxa27x_udc: fix memory leak with using debugfs_lookup()
      Merge tag 'thunderbolt-for-v6.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
      Merge 6.2-rc8 into usb-next
      Merge tag 'usb-serial-6.3-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next

Guenter Roeck (1):
      media: uvcvideo: Handle errors from calls to usb_string

Hans Verkuil (2):
      media: uvcvideo: Check for INACTIVE in uvc_ctrl_is_accessible()
      media: uvcvideo: Improve error logging in uvc_query_ctrl()

Heikki Krogerus (1):
      usb: dwc3: pci: add support for the Intel Meteor Lake-M

Herve Codina (5):
      dt-bindings: usb: add the Renesas RZ/N1 USBF controller
      soc: renesas: r9a06g032-sysctrl: Handle h2mode setting based on USBF presence
      usb: gadget: udc: add Renesas RZ/N1 USBF controller support
      ARM: dts: r9a06g032: Add the USBF controller node
      MAINTAINERS: add the Renesas RZ/N1 USBF controller entry

Icenowy Zheng (2):
      dt-bindings: usb: sunxi-musb: add F1C100s MUSB compatible string
      usb: musb: sunxi: add support for the F1C100s MUSB controller

Jim Lin (2):
      xhci: Add hub_control to xhci_driver_overrides
      xhci: hub: export symbol on xhci_hub_control

Jiri Slaby (SUSE) (1):
      thunderbolt: Use correct type in tb_port_is_clx_enabled() prototype

John Keeping (1):
      usb: gadget: f_fs: use io_data->status consistently

Jon Hunter (4):
      dt-bindings: usb: tegra-xudc: Add dma-coherent for Tegra194
      arm64: defconfig: Enable UCSI support
      usb: gadget: u_ether: Convert prints to device prints
      usb: gadget: u_ether: Don't warn in gether_setup_name_default()

Jonathan Neuschäfer (1):
      dt-bindings: usb: phy: nop: Fix a typo ("specifiy")

Jun Nie (2):
      dt-bindings: usb: tps6598x: Add wakeup property
      usb: typec: tipd: Support wakeup

Jó Ágila Bitsch (2):
      usb: gadget: add WebUSB landing page support
      usb: gadget: add doc to struct usb_composite_dev

Kees Cook (3):
      media: uvcvideo: Silence memcpy() run-time false positive warnings
      usb: host: xhci: mvebu: Iterate over array indexes instead of using pointer math
      USB: ene_usb6250: Allocate enough memory for full object

Konrad Dybcio (1):
      dt-bindings: usb: fsa4480: Use generic node name

Krzysztof Kozlowski (2):
      dt-bindings: usb: qcom,dwc3: allow required-opps
      dt-bindings: usb: samsung,exynos-dwc3: allow unit address in DTS

Laurent Pinchart (2):
      media: uvcvideo: Remove format descriptions
      media: uvcvideo: Factor out usb_string() calls

Linus Walleij (7):
      dt-bindings: usb: Correct and extend FOTG210 schema
      usb: fotg210: List different variants
      usb: fotg210: Acquire memory resource in core
      usb: fotg210: Move clock handling to core
      usb: fotg210: Check role register in core
      usb: fotg210-udc: Assign of_node and speed on start
      usb: fotg210-udc: Implement VBUS session

Lucas Stach (1):
      dt-bindings: usb: dwc3-imx8mp: add power domain property

Marek Vasut (1):
      media: uvcvideo: Add GUID for BGRA/X 8:8:8:8

Mark Tomlinson (2):
      USB: MAX3421: Handle USB NAK correctly
      usb: max-3421: Fix setting of I/O pins

Mathias Nyman (11):
      xhci: fix event ring segment table related masks and variables in header
      xhci: remove xhci_test_trb_in_td_math early development check
      xhci: Refactor interrupter code for initial multi interrupter support.
      xhci: add helpers for enabling and disabling interrupters
      xhci: cleanup xhci_hub_control port references
      xhci: pass port pointer as parameter to xhci_set_port_power()
      xhci: move port specific items such as state completions to port structure
      xhci: Pass port structure as parameter to xhci_disable_port().
      xhci: rename resume_done to resume_timestamp
      xhci: clear usb2 resume related variables in one place.
      xhci: decouple usb2 port resume and get_port_status request handling

Michael Grzeschik (4):
      usb: uvc: move media/v4l2-uvc.h to usb/uvc.h
      usb: uvc: move uvc_fmts and uvc_format_by_guid to own compile unit
      usb: uvc: make uvc_format_desc table const
      usb: uvc: use v4l2_fill_fmtdesc instead of open coded format name

Mika Westerberg (10):
      thunderbolt: Use decimal port number in control and tunnel logs too
      thunderbolt: Log DP adapter type
      thunderbolt: Improve debug logging in tb_available_bandwidth()
      thunderbolt: Take CL states into account when waiting for link to come up
      thunderbolt: Increase timeout of DP OUT adapter handshake
      thunderbolt: Add functions to support DisplayPort bandwidth allocation mode
      thunderbolt: Include the additional DP IN double word in debugfs dump
      thunderbolt: Add support for DisplayPort bandwidth allocation mode
      thunderbolt: Handle bandwidth allocation mode enablement notification
      thunderbolt: Add missing kernel-doc comment to tb_tunnel_maximum_bandwidth()

Neil Armstrong (1):
      dt-bindings: usb: amlogic,meson-g12a-usb-ctrl: make G12A usb3-phy0 optional

Pawel Laszczak (1):
      usb: cdnsp: : add scatter gather support for ISOC endpoint

Pedro Guilherme Siqueira Moreira (3):
      media: uvcvideo: Fix missing newline after declarations
      media: uvcvideo: Fix assignment inside if condition
      media: uvcvideo: Fix usage of symbolic permissions to octal

Peng Fan (2):
      dt-bindings: usb: ci-hdrc-usb2: add i.MX8MM compatible
      dt-bindings: usb: usbmisc-imx: add i.MX8MM usbmisc

Petlozu Pravareshwar (1):
      xhci: tegra: USB2 pad power controls

Prashant Malani (5):
      usb: typec: Add retimer handle to port altmode
      usb: typec: Add wrapper for bus switch set code
      usb: typec: Make bus switch code retimer-aware
      usb: typec: altmodes/displayport: Update active state
      usb: typec: tcpm: Remove altmode active state updates

Prashanth K (1):
      usb: gadget: u_serial: Add null pointer check in gserial_resume

Randy Dunlap (2):
      usb: fotg210: fix a Kconfig spelling mistake
      Documentation: usb: correct spelling

Ricardo Ribalda (19):
      media: uvcvideo: Handle cameras with invalid descriptors
      media: uvcvideo: Only create input devs if hw supports it
      media: uvcvideo: Remove void casting for the status endpoint
      media: uvcvideo: Recover stalled ElGato devices
      media: uvcvideo: Limit power line control for Acer EasyCamera
      media: uvcvideo: Return -EACCES for Wrong state error
      media: uvcvideo: Do not return positive errors in uvc_query_ctrl()
      media: uvcvideo: Fix handling on Bitmask controls
      media: uvcvideo: Refactor __uvc_ctrl_add_mapping
      media: uvcvideo: Limit power line control for Acer EasyCamera
      media: uvcvideo: Extend documentation of uvc_video_clock_decode()
      media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU
      media: uvcvideo: Refactor uvc_ctrl_mappings_uvcXX
      media: uvcvideo: Refactor power_line_frequency_controls_limited
      media: uvcvideo: Fix power line control for Lenovo Integrated Camera
      media: uvcvideo: Use standard names for menus
      media: uvcvideo: Fix race condition with usb_kill_urb
      media: uvcvideo: Quirk for autosuspend in Logitech B910 and C910
      USB: Improve usb_fill_* documentation

Rob Herring (7):
      dt-bindings: usb: snps,dwc3: Allow power-domains property
      dt-bindings: usb: rockchip,dwc3: Move RK3399 to its own schema
      dt-bindings: usb: Remove obsolete brcm,bcm3384-usb.txt
      dt-bindings: usb: Convert multiple "usb-ohci" bindings to DT schema
      dt-bindings: usb: Convert OMAP OHCI/EHCI bindings to schema
      dt-bindings: usb: Convert Marvell Orion EHCI to DT schema
      dt-bindings: usb: Convert Nuvoton EHCI to DT schema

Saranya Gopal (3):
      usb: typec: ucsi: Register USB Power Delivery Capabilities
      usb: typec: pd: Remove usb_suspend_supported sysfs from sink PDO
      usb: typec: pd: Add higher capability sysfs for sink PDO

Sing-Han Chen (3):
      phy: tegra: xusb: Add Tegra234 support
      usb: host: xhci-tegra: Add Tegra234 XHCI support
      usb: gadget: tegra-xudc: Add Tegra234 support

Udipto Goswami (1):
      usb: gadget: configfs: Restrict symlink creation is UDC already binded

Uwe Kleine-König (1):
      usb: chipidea: imx: Drop empty platform remove function

Wang Yufen (1):
      usb: musb: fix error return code in da8xx_musb_init()

Wayne Chang (9):
      usb: gadget: xudc: Refactor update data role work
      dt-bindings: usb: Add NVIDIA Tegra234 XUSB host controller binding
      arm64: tegra: Enable XUSB host function on Jetson AGX Orin
      phy: tegra: xusb: Disable trk clk when not in use
      dt-bindings: usb: tegra-xudc: Add Tegra234 XUDC support
      dt-bindings: usb: Add Cypress cypd4226 Type-C controller
      i2c: nvidia-gpu: Add ACPI property to align with device-tree
      usb: typec: ucsi_ccg: Add OF support
      i2c: nvidia-gpu: Remove ccgx,firmware-build property

Xu Yang (1):
      usb: typec: tcpci: Request IRQ with IRQF_SHARED

Yang Yingliang (2):
      usb: fotg210: fix return value check in fotg210_probe()
      usb: gadget: uvc: fix missing mutex_unlock() if kstrtou8() fails

 Documentation/ABI/testing/configfs-usb-gadget      |   13 +
 Documentation/ABI/testing/configfs-usb-gadget-uvc  |   57 +-
 .../ABI/testing/sysfs-class-usb_power_delivery     |   11 +-
 .../ABI/testing/sysfs-driver-typec-displayport     |   15 +
 .../devicetree/bindings/mfd/omap-usb-host.txt      |    8 +-
 .../devicetree/bindings/powerpc/nintendo/wii.txt   |   10 -
 .../bindings/usb/allwinner,sun4i-a10-musb.yaml     |   10 +-
 .../bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml  |    1 +
 .../devicetree/bindings/usb/brcm,bcm3384-usb.txt   |   11 -
 .../devicetree/bindings/usb/ci-hdrc-usb2.txt       |    1 +
 .../devicetree/bindings/usb/cypress,cypd4226.yaml  |   98 +
 .../devicetree/bindings/usb/ehci-omap.txt          |   31 -
 .../devicetree/bindings/usb/ehci-orion.txt         |   22 -
 .../devicetree/bindings/usb/faraday,fotg210.yaml   |    7 +-
 .../devicetree/bindings/usb/fcs,fsa4480.yaml       |    2 +-
 .../devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml   |    6 +
 .../devicetree/bindings/usb/generic-ehci.yaml      |    5 +
 .../devicetree/bindings/usb/generic-ohci.yaml      |   32 +-
 .../devicetree/bindings/usb/genesys,gl850g.yaml    |    1 +
 .../devicetree/bindings/usb/gpio-sbu-mux.yaml      |  110 +
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml |    1 +
 .../devicetree/bindings/usb/mediatek,mtu3.yaml     |    1 +
 .../devicetree/bindings/usb/npcm7xx-usb.txt        |   20 -
 .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml |   15 +
 .../bindings/usb/nvidia,tegra234-xusb.yaml         |  159 +
 Documentation/devicetree/bindings/usb/ohci-nxp.txt |   24 -
 .../devicetree/bindings/usb/ohci-omap3.txt         |   15 -
 Documentation/devicetree/bindings/usb/pxa-usb.txt  |    2 +-
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |    3 +
 .../devicetree/bindings/usb/renesas,rzn1-usbf.yaml |   68 +
 .../bindings/usb/renesas,rzv2m-usb3drd.yaml        |  129 +
 .../devicetree/bindings/usb/renesas,usb-xhci.yaml  |   41 +-
 .../devicetree/bindings/usb/renesas,usb3-peri.yaml |   40 +-
 .../devicetree/bindings/usb/rockchip,dwc3.yaml     |   10 +-
 .../bindings/usb/rockchip,rk3399-dwc3.yaml         |  115 +
 .../bindings/usb/samsung,exynos-dwc3.yaml          |    8 +-
 .../devicetree/bindings/usb/snps,dwc3.yaml         |   10 +
 .../devicetree/bindings/usb/spear-usb.txt          |   35 -
 .../devicetree/bindings/usb/ti,hd3ss3220.yaml      |    1 -
 .../devicetree/bindings/usb/ti,tps6598x.yaml       |    3 +
 .../devicetree/bindings/usb/usb-nop-xceiv.yaml     |    2 +-
 .../devicetree/bindings/usb/usbmisc-imx.txt        |    1 +
 .../devicetree/bindings/usb/vialab,vl817.yaml      |   71 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 Documentation/usb/chipidea.rst                     |   19 +-
 Documentation/usb/gadget-testing.rst               |    2 +-
 Documentation/usb/gadget_configfs.rst              |   10 +
 Documentation/usb/mass-storage.rst                 |    2 +-
 MAINTAINERS                                        |    8 +
 arch/arm/boot/dts/meson8b-odroidc1.dts             |   24 +-
 arch/arm/boot/dts/r9a06g032.dtsi                   |   12 +
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |   26 +-
 .../arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts |   36 +-
 arch/arm64/configs/defconfig                       |    3 +
 drivers/clk/renesas/r9a06g032-clocks.c             |   28 +
 .../gpu/drm/i915/gt/intel_execlists_submission.c   |   15 +-
 drivers/i2c/busses/i2c-nvidia-gpu.c                |    4 +-
 drivers/media/common/Kconfig                       |    3 +
 drivers/media/common/Makefile                      |    1 +
 drivers/media/common/uvc.c                         |  183 ++
 drivers/media/usb/uvc/Kconfig                      |    1 +
 drivers/media/usb/uvc/uvc_ctrl.c                   |  342 +-
 drivers/media/usb/uvc/uvc_driver.c                 |  185 +-
 drivers/media/usb/uvc/uvc_entity.c                 |    2 +-
 drivers/media/usb/uvc/uvc_status.c                 |  125 +-
 drivers/media/usb/uvc/uvc_v4l2.c                   |  111 +-
 drivers/media/usb/uvc/uvc_video.c                  |   58 +-
 drivers/media/usb/uvc/uvcvideo.h                   |   39 +-
 drivers/of/device.c                                |    6 +-
 drivers/phy/tegra/Makefile                         |    1 +
 drivers/phy/tegra/xusb-tegra186.c                  |   64 +-
 drivers/phy/tegra/xusb.c                           |    6 +
 drivers/phy/tegra/xusb.h                           |   23 +
 drivers/thunderbolt/acpi.c                         |   13 +-
 drivers/thunderbolt/ctl.c                          |   52 +-
 drivers/thunderbolt/ctl.h                          |    2 +
 drivers/thunderbolt/debugfs.c                      |    5 +-
 drivers/thunderbolt/switch.c                       |   42 +-
 drivers/thunderbolt/tb.c                           |  508 ++-
 drivers/thunderbolt/tb.h                           |   39 +-
 drivers/thunderbolt/tb_msgs.h                      |   11 +-
 drivers/thunderbolt/tb_regs.h                      |   36 +
 drivers/thunderbolt/tunnel.c                       |  506 ++-
 drivers/thunderbolt/tunnel.h                       |   18 +
 drivers/thunderbolt/usb4.c                         |  572 ++++
 drivers/usb/cdns3/cdnsp-gadget.c                   |    2 +-
 drivers/usb/cdns3/cdnsp-gadget.h                   |    4 +-
 drivers/usb/cdns3/cdnsp-ring.c                     |  110 +-
 drivers/usb/chipidea/ci_hdrc_imx.c                 |   10 +-
 drivers/usb/chipidea/debug.c                       |    2 +-
 drivers/usb/chipidea/usbmisc_imx.c                 |    6 -
 drivers/usb/common/ulpi.c                          |   14 +-
 drivers/usb/core/hub.c                             |    5 +-
 drivers/usb/core/sysfs.c                           |    5 -
 drivers/usb/core/usb.c                             |    2 +-
 drivers/usb/dwc3/core.h                            |    2 +
 drivers/usb/dwc3/debug.h                           |    3 +
 drivers/usb/dwc3/debugfs.c                         |   19 +-
 drivers/usb/dwc3/dwc3-pci.c                        |    4 +
 drivers/usb/dwc3/dwc3-xilinx.c                     |    1 -
 drivers/usb/dwc3/gadget.c                          |    4 +-
 drivers/usb/early/xhci-dbc.c                       |    8 +-
 drivers/usb/fotg210/Kconfig                        |    2 +-
 drivers/usb/fotg210/fotg210-core.c                 |   83 +-
 drivers/usb/fotg210/fotg210-hcd.c                  |   69 +-
 drivers/usb/fotg210/fotg210-hcd.h                  |    1 +
 drivers/usb/fotg210/fotg210-udc.c                  |  161 +-
 drivers/usb/fotg210/fotg210-udc.h                  |    4 +-
 drivers/usb/fotg210/fotg210.h                      |   27 +-
 drivers/usb/gadget/Kconfig                         |    1 +
 drivers/usb/gadget/composite.c                     |  102 +-
 drivers/usb/gadget/configfs.c                      |  500 ++-
 drivers/usb/gadget/function/f_fs.c                 |    8 +-
 drivers/usb/gadget/function/f_uvc.c                |  150 +-
 drivers/usb/gadget/function/u_ether.c              |   38 +-
 drivers/usb/gadget/function/u_serial.c             |   23 +-
 drivers/usb/gadget/function/u_uvc.h                |   18 +-
 drivers/usb/gadget/function/uvc.h                  |    4 +-
 drivers/usb/gadget/function/uvc_configfs.c         | 1154 ++++++-
 drivers/usb/gadget/function/uvc_configfs.h         |   52 +-
 drivers/usb/gadget/function/uvc_v4l2.c             |   16 +-
 drivers/usb/gadget/legacy/hid.c                    |    7 +-
 drivers/usb/gadget/udc/Kconfig                     |   22 +
 drivers/usb/gadget/udc/Makefile                    |    2 +
 drivers/usb/gadget/udc/bcm63xx_udc.c               |   13 +-
 drivers/usb/gadget/udc/fusb300_udc.c               |   10 +-
 drivers/usb/gadget/udc/gr_udc.c                    |    2 +-
 drivers/usb/gadget/udc/lpc32xx_udc.c               |    2 +-
 drivers/usb/gadget/udc/pxa25x_udc.c                |    2 +-
 drivers/usb/gadget/udc/pxa27x_udc.c                |    2 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |  136 +-
 drivers/usb/gadget/udc/renesas_usbf.c              | 3406 ++++++++++++++++++++
 drivers/usb/gadget/udc/rzv2m_usb3drd.c             |  139 +
 drivers/usb/gadget/udc/tegra-xudc.c                |   50 +-
 drivers/usb/host/Kconfig                           |   22 +-
 drivers/usb/host/Makefile                          |    8 +-
 drivers/usb/host/ehci-fsl.c                        |    2 +-
 drivers/usb/host/fsl-mph-dr-of.c                   |    3 +-
 drivers/usb/host/isp116x-hcd.c                     |    2 +-
 drivers/usb/host/isp1362-hcd.c                     |    2 +-
 drivers/usb/host/max3421-hcd.c                     |   15 +-
 drivers/usb/host/sl811-hcd.c                       |    2 +-
 drivers/usb/host/uhci-hcd.c                        |    6 +-
 drivers/usb/host/xhci-debugfs.c                    |    2 +-
 drivers/usb/host/xhci-hub.c                        |  257 +-
 drivers/usb/host/xhci-mem.c                        |  338 +-
 drivers/usb/host/xhci-mvebu.c                      |    2 +-
 drivers/usb/host/xhci-plat.c                       |  144 +-
 drivers/usb/host/xhci-plat.h                       |    7 +
 drivers/usb/host/xhci-rcar.c                       |  102 +-
 drivers/usb/host/xhci-rcar.h                       |   55 -
 drivers/usb/host/xhci-ring.c                       |   88 +-
 drivers/usb/host/xhci-rzv2m.c                      |   38 +
 drivers/usb/host/xhci-rzv2m.h                      |   16 +
 drivers/usb/host/xhci-tegra.c                      |  392 ++-
 drivers/usb/host/xhci.c                            |   81 +-
 drivers/usb/host/xhci.h                            |   40 +-
 drivers/usb/misc/onboard_usb_hub.c                 |    4 +
 drivers/usb/misc/onboard_usb_hub.h                 |   11 +
 drivers/usb/mtu3/mtu3_gadget.c                     |    3 +-
 drivers/usb/mtu3/mtu3_hw_regs.h                    |    1 +
 drivers/usb/mtu3/mtu3_qmu.c                        |    7 +
 drivers/usb/musb/da8xx.c                           |    4 +-
 drivers/usb/musb/mediatek.c                        |    3 +-
 drivers/usb/musb/sunxi.c                           |   99 +-
 drivers/usb/serial/option.c                        |    4 +
 drivers/usb/storage/ene_ub6250.c                   |    2 +-
 drivers/usb/typec/altmodes/displayport.c           |   12 +
 drivers/usb/typec/bus.c                            |   33 +-
 drivers/usb/typec/bus.h                            |    2 +
 drivers/usb/typec/class.c                          |   15 +-
 drivers/usb/typec/hd3ss3220.c                      |   29 +
 drivers/usb/typec/mux/Kconfig                      |    6 +
 drivers/usb/typec/mux/Makefile                     |    1 +
 drivers/usb/typec/mux/gpio-sbu-mux.c               |  172 +
 drivers/usb/typec/mux/intel_pmc_mux.c              |   13 +-
 drivers/usb/typec/pd.c                             |    9 +-
 drivers/usb/typec/retimer.h                        |    2 +-
 drivers/usb/typec/tcpm/Makefile                    |    1 +
 drivers/usb/typec/tcpm/maxim_contaminant.c         |  387 +++
 drivers/usb/typec/tcpm/tcpci.c                     |   19 +-
 drivers/usb/typec/tcpm/tcpci_maxim.h               |   89 +
 .../tcpm/{tcpci_maxim.c => tcpci_maxim_core.c}     |   53 +-
 drivers/usb/typec/tcpm/tcpm.c                      |   60 +-
 drivers/usb/typec/tipd/core.c                      |   38 +
 drivers/usb/typec/ucsi/ucsi.c                      |  164 +-
 drivers/usb/typec/ucsi/ucsi.h                      |    8 +
 drivers/usb/typec/ucsi/ucsi_ccg.c                  |   22 +-
 include/linux/list.h                               |   15 +
 include/linux/usb.h                                |   27 +-
 include/linux/usb/composite.h                      |   12 +
 include/linux/usb/gadget.h                         |   11 +
 include/linux/usb/rzv2m_usb3drd.h                  |   20 +
 include/linux/usb/tcpci.h                          |    7 +
 include/linux/usb/tcpm.h                           |    8 +
 include/{media/v4l2-uvc.h => linux/usb/uvc.h}      |  209 +-
 include/linux/usb/webusb.h                         |   80 +
 include/uapi/linux/usb/ch9.h                       |   16 +
 include/uapi/linux/usb/video.h                     |   30 +
 include/uapi/linux/uvcvideo.h                      |    6 +-
 200 files changed, 11883 insertions(+), 2232 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm3384-usb.txt
 create mode 100644 Documentation/devicetree/bindings/usb/cypress,cypd4226.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/ehci-omap.txt
 delete mode 100644 Documentation/devicetree/bindings/usb/ehci-orion.txt
 create mode 100644 Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/npcm7xx-usb.txt
 create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra234-xusb.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/ohci-nxp.txt
 delete mode 100644 Documentation/devicetree/bindings/usb/ohci-omap3.txt
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,rzv2m-usb3drd.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/rockchip,rk3399-dwc3.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/spear-usb.txt
 create mode 100644 Documentation/devicetree/bindings/usb/vialab,vl817.yaml
 create mode 100644 drivers/media/common/uvc.c
 create mode 100644 drivers/usb/gadget/udc/renesas_usbf.c
 create mode 100644 drivers/usb/gadget/udc/rzv2m_usb3drd.c
 delete mode 100644 drivers/usb/host/xhci-rcar.h
 create mode 100644 drivers/usb/host/xhci-rzv2m.c
 create mode 100644 drivers/usb/host/xhci-rzv2m.h
 create mode 100644 drivers/usb/typec/mux/gpio-sbu-mux.c
 create mode 100644 drivers/usb/typec/tcpm/maxim_contaminant.c
 create mode 100644 drivers/usb/typec/tcpm/tcpci_maxim.h
 rename drivers/usb/typec/tcpm/{tcpci_maxim.c => tcpci_maxim_core.c} (93%)
 create mode 100644 include/linux/usb/rzv2m_usb3drd.h
 rename include/{media/v4l2-uvc.h => linux/usb/uvc.h} (59%)
 create mode 100644 include/linux/usb/webusb.h
