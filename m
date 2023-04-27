Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B046F072F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243833AbjD0OWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243863AbjD0OWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:22:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC455FD5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:21:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0D7F63D84
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 14:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB32C433EF;
        Thu, 27 Apr 2023 14:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682605286;
        bh=J/x5cRtrnCQs7EmHOVMwibAP1DboFSp2tjHEuCnk9g4=;
        h=Date:From:To:Cc:Subject:From;
        b=0CChFyXMLr/DYIxJO4n80sh7Jp4GOsb5+qdM8IC5N0D3ldlo6jRQHT53ymc3wv4vQ
         LXQporZUj6g+861o39og7XQfz8BzYBTP4+7gEFrUjzBpj2+AxcJ3atJxu2gasGeC5r
         XBTYXJOVq+Z7JY9u0bxCp63mEVcpElxKX/x9O0v8=
Date:   Thu, 27 Apr 2023 16:21:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver updates for 6.4-rc1
Message-ID: <ZEqE4wCJDnMJbJRU@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.4-rc1

for you to fetch changes up to 2025b2ca8004c04861903d076c67a73a0ec6dfca:

  mcb-lpc: Reallocate memory region to avoid memory overlapping (2023-04-20 14:24:01 +0200)

----------------------------------------------------------------
Char/Misc drivers for 6.4-rc1

Here is the "big" set of char/misc and other driver subsystems for
6.4-rc1.

It's pretty big, but due to the removal of pcmcia drivers, almost breaks
even for number of lines added vs. removed, a nice change.

Included in here are:
  - removal of unused PCMCIA drivers (finally!)
  - Interconnect driver updates and additions
  - Lots of IIO driver updates and additions
  - MHI driver updates
  - Coresight driver updates
  - NVMEM driver updates, which required some OF updates
  - W1 driver updates and a new maintainer to manage the subsystem
  - FPGA driver updates
  - New driver subsystem, CDX, for AMD systems
  - lots of other small driver updates and additions

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aidan MacDonald (2):
      iio: adc: axp20x_adc: Minor code cleanups
      iio: adc: axp20x_adc: Replace adc_en2 flag with adc_en2_mask field

Andy Shevchenko (1):
      mei: Move uuid.h to the MEI namespace

Angel Iglesias (7):
      iio: pressure: bmp280: Use chip_info pointers for each chip as driver data
      iio: pressure: bmp280: Add preinit callback
      iio: pressure: bmp280: Make read calibration callback optional
      iio: pressure: Kconfig: Delete misleading I2C reference on bmp280 title
      iio: pressure: bmp280: Add support for new sensor BMP580
      dt-bindings: iio: pressure: bmp085: Add BMP580 compatible string
      iio: pressure: bmp280: Add nvmem operations for BMP580

AngeloGioacchino Del Regno (1):
      nvmem: mtk-efuse: Support postprocessing for GPU speed binning data

Antoniu Miclaus (1):
      drivers: iio: dac: ad5592r: add gpio_chip names

Bjorn Helgaas (3):
      bus: mhi: host: pci_generic: Drop redundant pci_enable_pcie_error_reporting()
      misc: alcor_pci: Use PCI core to manage ASPM instead of open-coding
      misc: genwqe: Drop redundant pci_enable_pcie_error_reporting()

Cheng Ziqiu (1):
      iio: adc: at91-sama5d2_adc: remove dead code in at91_adc_probe()

Colin Ian King (1):
      dt-bindings: nvmem: Fix spelling mistake "platforn" -> "platform"

Dae R. Jeong (1):
      vmci_host: fix a race condition in vmci_host_poll() causing GPF

Dan Carpenter (2):
      iio: adc: ti-ads1100: fix error code in probe()
      firmware: stratix10-svc: Fix an NULL vs IS_ERR() bug in probe

Deming Wang (1):
      virt: acrn: Replace obsolete memalign() with posix_memalign()

Dmitry Baryshkov (2):
      interconnect: qcom: drop obsolete OSM_L3/EPSS defines
      interconnect: qcom: osm-l3: drop unuserd header inclusion

Geert Uytterhoeven (1):
      dt-bindings: iio: adc: renesas,rcar-gyroadc: Miscellaneous improvements

Greg Kroah-Hartman (7):
      Merge 6.3-rc3 into char-misc-next
      Merge 6.3-rc6 into char-misc-next
      Merge tag 'iio-for-6.4a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'iio-for-6.4b' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'mhi-for-v6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-misc-next
      Merge tag 'icc-6.4-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next
      Merge tag 'coresight-next-v6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-next

Gwendal Grignou (1):
      iio: proximity: sx_common: Add old register mapping

Jean Delvare (1):
      interconnect: qcom: Drop obsolete dependency on COMPILE_TEST

Jeffrey Hugo (4):
      bus: mhi: host: Range check CHDBOFF and ERDBOFF
      bus: mhi: host: Use ERANGE for BHIOFF/BHIEOFF range check
      bus: mhi: host: Remove duplicate ee check for syserr
      bus: mhi: host: Use mhi_tryset_pm_state() for setting fw error state

Jiri Slaby (2):
      tty: ipwireless: move Kconfig entry to tty
      char: pcmcia: remove all the drivers

Jishnu Prakash (1):
      spmi: Add a check for remove callback when removing a SPMI driver

Johan Hovold (4):
      interconnect: drop racy registration API
      interconnect: drop unused icc_link_destroy() interface
      interconnect: qcom: rpm: drop bogus pm domain attach
      dt-bindings: nvmem: qcom,spmi-sdam: fix example 'reg' property

John Stultz (1):
      kernel/configs: Drop Android config fragments

Jonathan Cameron (5):
      iio: proximity: sx_common: Drop documentation of non existent struct element.
      staging: iio: meter: Drop ade7854 driver
      iio: imu: lsm6dsx: Support SMO8B30 ACPI ID for LSM6DS3TR-C
      iio: imu: lsm6dsx: Add ACPI mount matrix retrieval
      iio: adc: palmas: Take probe fully device managed.

Jonathan Neuschäfer (1):
      iio: chemical: sps030: Reformat comment in a more readable way

Kasumov Ruslan (1):
      iio: adc: qcom-pm8xxx-xoadc: Remove useless condition in pm8xxx_xoadc_parse_channel()

Konrad Dybcio (7):
      interconnect: qcom: rpm: make QoS INVALID default
      interconnect: qcom: rpm: Add support for specifying channel num
      interconnect: qcom: Sort kerneldoc entries
      dt-bindings: interconnect: OSM L3: Add SM6375 CPUCP compatible
      dt-bindings: interconnect: qcom,msm8998-bwmon: Resolve MSM8998 support
      dt-bindings: nvmem: Add compatible for SM6350
      dt-bindings: nvmem: Add compatible for SM6375

Krzysztof Kozlowski (21):
      iio: adc: rcar-gyroadc: mark OF related data as maybe unused
      iio: light: max44009: add missing OF device matching
      iio: proximity: sx9500: Reference ACPI and OF ID data
      nvmem: stm32-romem: mark OF related data as maybe unused
      MAINTAINERS: w1: add Krzysztof Kozlowski as maintainer
      w1: ds2408: drop kerneldoc annotation
      w1: ds2433: correct kerneldoc annotation
      w1: ds28e04: correct kerneldoc annotation
      w1: minor white-space and code style fixes
      w1: use octal for file permissions
      w1: ds2433: do not use assignment in if condition
      w1: ds2482: drop unnecessary header
      w1: ds2482: do not use assignment in if condition
      w1: matrox: switch from asm to linux header
      w1: matrox: use inline over __inline__
      w1: matrox: remove unnecessary ENOMEM messages
      w1: omap-hdq: allow compile testing
      w1: omap-hdq: add SPDX tag
      w1: omap-hdq: remove unnecessary ENOMEM messages
      w1: gpio: remove unnecessary ENOMEM messages
      spmi: mtk-pmif: Drop of_match_ptr for ID table

Linus Walleij (2):
      misc: microchip: pci1xxxx: Convert to immutable irqchip
      dt-bindings: iio: st-sensors: Fix repeated text

Lorenzo Bianconi (3):
      iio: imu: st_lsm6dsx: discard samples during filters settling time
      iio: imu: st_lsm6dsx: add support to ASM330LHB
      dt-bindings: iio: imu: st_lsm6dsx: add asm330lhb

Luis Chamberlain (1):
      sgi-xp: simplify sysctl registration

Manivannan Sadhasivam (2):
      bus: mhi: host: Remove mhi_poll() API
      bus: mhi: ep: Demote unsupported channel error log to debug

Marco Felsch (5):
      dt-bindings: iio: ti,tmp117: fix documentation link
      iio: temperature: tmp117: improve fallback capabilities
      dt-bindings: iio: ti,tmp117: add binding for the TMP116
      iio: temperature: tmp117: add TI TMP116 support
      iio: temperature: tmp117: cosmetic alignment cleanup

Marco Pagani (1):
      fpga: bridge: fix kernel-doc parameter description

Matti Vaittinen (6):
      doc: Make sysfs-bus-iio doc more exact
      iio: light: Add gain-time-scale helpers
      MAINTAINERS: Add IIO gain-time-scale helpers
      dt-bindings: iio: light: Support ROHM BU27034
      iio: light: ROHM BU27034 Ambient Light Sensor
      MAINTAINERS: Add ROHM BU27034

Mehdi Djait (3):
      iio: accel: kionix-kx022a: Remove the unused member g_range
      iio: Improve the kernel-doc of iio_trigger_poll
      iio: Rename iio_trigger_poll_chained and add kernel-doc

Michael Walle (8):
      nvmem: core: introduce NVMEM layouts
      nvmem: core: add per-cell post processing
      nvmem: core: allow to modify a cell before adding it
      nvmem: imx-ocotp: replace global post processing with layouts
      nvmem: cell: drop global cell_post_process
      nvmem: core: provide own priv pointer in post process callback
      nvmem: layouts: sl28vpd: Add new layout driver
      MAINTAINERS: add myself as sl28vpd nvmem layout driver

Mike Looijmans (2):
      dt-bindings: iio: adc: Add TI ADS1100 and ADS1000
      iio: adc: Add TI ADS1100 and ADS1000

Miquel Raynal (15):
      of: Fix modalias string generation
      of: Update of_device_get_modalias()
      of: Rename of_modalias_node()
      of: Move of_modalias() to module.c
      of: Move the request module helper logic to module.c
      usb: ulpi: Use of_request_module()
      of: device: Kill of_device_request_module()
      nvmem: core: handle the absence of expected layouts
      nvmem: core: request layout modules loading
      nvmem: layouts: onie-tlv: Add new layout driver
      MAINTAINERS: Add myself as ONIE tlv NVMEM layout maintainer
      nvmem: Add macro to register nvmem layout drivers
      nvmem: layouts: sl28vpd: Use module_nvmem_layout_driver()
      nvmem: layouts: onie-tlv: Use module_nvmem_layout_driver()
      nvmem: layouts: onie-tlv: Drop wrong module alias

Nava kishore Manne (2):
      firmware: xilinx: Add pm api function for PL config reg readback
      fpga: zynqmp-fpga: Adds status interface

Neil Armstrong (2):
      dt-bindings: nvmem: convert amlogic-meson-mx-efuse.txt to dt-schema
      dt-bindings: nvmem: convert amlogic-efuse.txt to dt-schema

Nick Alcock (1):
      nvmem: xilinx: zynqmp: make modular

Nipun Gupta (7):
      cdx: add the cdx bus driver
      iommu: Add iommu probe for CDX bus
      dt-bindings: bus: add CDX bus controller for versal net
      cdx: add MCDI protocol interface for firmware interaction
      cdx: add cdx controller
      cdx: add rpmsg communication channel for CDX
      cdx: add device attributes

Nuno Sá (2):
      iio: imu: adis16475: correct copy paste mistake in comment block
      staging: iio: resolver: ads1210: fix config mode

Patrik Dahlström (7):
      iio: adc: palmas: remove adc_wakeupX_data
      iio: adc: palmas: replace "wakeup" with "event"
      iio: adc: palmas: use iio_event_direction for threshold polarity
      iio: adc: palmas: move eventX_enable into palmas_adc_event
      iio: adc: palmas: always reset events on unload
      iio: adc: palmas: add support for iio threshold events
      iio: adc: palmas: don't alter event config on suspend/resume

Quan Nguyen (2):
      misc: smpro-errmon: Add DIMM 2x Refresh rate event
      misc: smpro-errmon: Add dimm training failure syndrome

Rafał Miłecki (3):
      dt-bindings: nvmem: u-boot,env: add MAC's #nvmem-cell-cells
      nvmem: core: support specifying both: cell raw data & post read lengths
      nvmem: u-boot-env: post-process "ethaddr" env variable

Randy Dunlap (1):
      spmi: fix W=1 kernel-doc warnings

Rasmus Villemoes (3):
      dt-bindings: iio: ad74413r: allow setting sink current for digital input
      iio: ad74413r: wire up support for drive-strength-microamp property
      iio: addac: ad74413r: fix Current Input, Loop Powered Mode

Rob Herring (7):
      misc/sram: Use of_property_read_bool() for boolean properties
      misc: lis3lv02d: Use of_property_read_bool() for boolean properties
      misc: lis3lv02d: Fix reading 'st,default-rate' property
      interconnect: Use of_property_present() for testing DT property presence
      dt-bindings: nvmem: Drop unneeded quotes
      dt-bindings: iio: temperature: ltc2983: Fix child node unevaluated properties
      dt-bindings: iio: temperature: ltc2983: Make 'adi,custom-thermocouple' signed

Rodríguez Barbarin, José Javier (3):
      mcb: Return actual parsed size when reading chameleon table
      mcb-pci: Reallocate memory region to avoid memory overlapping
      mcb-lpc: Reallocate memory region to avoid memory overlapping

Slark Xiao (2):
      bus: mhi: host: pci_generic: Revert "Add a secondary AT port to Telit FN990"
      bus: mhi: pci_generic: Add Foxconn T99W510

Stefan Wahren (4):
      dt-bindings: iio: st-sensors: Add IIS328DQ accelerometer
      iio: accel: add support for IIS328DQ variant
      dt-bindings: w1: Add DS2482/DS2484 I2C to 1-W bridges
      w1: ds2482: add i2c id for DS2484

Suzuki K Poulose (2):
      MAINTAINERS: Remove Mathieu Poirier as coresight maintainer
      coresight: etm_pmu: Set the module field

Thomas Weißschuh (2):
      firmware: dmi-sysfs: make kobj_type structures constant
      edd: make kobj_type structure constant

Tom Rix (5):
      iio: adc: stm32-adc: set some stm32-adc.c variables storage-class-specifier to static
      misc: hpilo: remove unused is_device_reset function
      misc: alcor_pci: remove unused alcor functions
      nvmem: layouts: sl28vpd: set varaiable sl28vpd_layout storage-class-specifier to static
      iio: dac: set variable max5522_channels storage-class-specifier to static

Uwe Kleine-König (6):
      misc: sram: Improve and simplify clk handling
      iio: adc: meson_saradc: Better handle BL30 not releasing the hardware
      iio: frequency: admv1013: Benefit from devm_clk_get_enabled() to simplify
      spmi: hisi-spmi-controller: Convert to platform remove callback returning void
      spmi: mtk-pmif: Convert to platform remove callback returning void
      spmi: pmic-arb: Convert to platform remove callback returning void

Vivek Aknurwar (1):
      interconnect: Skip call into provider if initial bw is zero

Vivek Pernamitta (1):
      bus: mhi: host: Avoid ringing EV DB if there are no elements to process

William Breathitt Gray (9):
      iio: dac: cio-dac: Fix typo in comment listing supported devices
      iio: dac: cio-dac: Migrate to the regmap API
      iio: addac: stx104: Replace bitops.h header inclusion with bits.h
      iio: addac: stx104: Fix race condition for stx104_write_raw()
      iio: addac: stx104: Fix race condition when converting analog-to-digital
      iio: addac: stx104: Use define rather than hardcoded limit for write val
      iio: addac: stx104: Improve indentation in stx104_write_raw()
      iio: addac: stx104: Migrate to the regmap API
      iio: addac: stx104: Use regmap_read_poll_timeout() for conversion poll

Yang Li (3):
      nvmem: bcm-ocotp: Use devm_platform_ioremap_resource()
      nvmem: nintendo-otp: Use devm_platform_ioremap_resource()
      nvmem: vf610-ocotp: Use devm_platform_get_and_ioremap_resource()

 CREDITS                                            |    5 +
 Documentation/ABI/testing/sysfs-bus-cdx            |   56 +
 Documentation/ABI/testing/sysfs-bus-iio            |   13 +-
 .../sysfs-bus-platform-devices-ampere-smpro        |   19 +-
 Documentation/ABI/testing/sysfs-driver-zynqmp-fpga |   73 +
 .../bindings/bus/xlnx,versal-net-cdx.yaml          |   82 +
 .../bindings/iio/adc/renesas,rcar-gyroadc.yaml     |   60 +-
 .../devicetree/bindings/iio/adc/ti,ads1100.yaml    |   46 +
 .../bindings/iio/addac/adi,ad74413r.yaml           |    9 +
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |    3 +
 .../bindings/iio/light/rohm,bu27034.yaml           |   46 +
 .../devicetree/bindings/iio/pressure/bmp085.yaml   |    2 +
 .../devicetree/bindings/iio/st,st-sensors.yaml     |    6 +-
 .../bindings/iio/temperature/adi,ltc2983.yaml      |   67 +-
 .../bindings/iio/temperature/ti,tmp117.yaml        |    8 +-
 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |   41 +-
 .../bindings/interconnect/qcom,osm-l3.yaml         |    1 +
 .../bindings/nvmem/allwinner,sun4i-a10-sid.yaml    |    2 +-
 .../bindings/nvmem/amlogic,meson-gxbb-efuse.yaml   |   57 +
 .../bindings/nvmem/amlogic,meson6-efuse.yaml       |   57 +
 .../devicetree/bindings/nvmem/amlogic-efuse.txt    |   48 -
 .../bindings/nvmem/amlogic-meson-mx-efuse.txt      |   22 -
 .../devicetree/bindings/nvmem/apple,efuses.yaml    |    2 +-
 .../devicetree/bindings/nvmem/brcm,nvram.yaml      |    2 +-
 .../bindings/nvmem/fsl,layerscape-sfp.yaml         |    2 +-
 .../devicetree/bindings/nvmem/imx-iim.yaml         |    2 +-
 .../devicetree/bindings/nvmem/imx-ocotp.yaml       |    2 +-
 .../bindings/nvmem/ingenic,jz4780-efuse.yaml       |    2 +-
 .../bindings/nvmem/layouts/onie,tlv-layout.yaml    |    2 +-
 .../devicetree/bindings/nvmem/mediatek,efuse.yaml  |    2 +-
 .../bindings/nvmem/microchip,sama7g5-otpc.yaml     |    2 +-
 .../devicetree/bindings/nvmem/mxs-ocotp.yaml       |    2 +-
 .../devicetree/bindings/nvmem/nintendo-otp.yaml    |    2 +-
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |    4 +-
 .../devicetree/bindings/nvmem/qcom,spmi-sdam.yaml  |   33 +-
 Documentation/devicetree/bindings/nvmem/rmem.yaml  |    2 +-
 .../devicetree/bindings/nvmem/rockchip-efuse.yaml  |    2 +-
 .../bindings/nvmem/socionext,uniphier-efuse.yaml   |    2 +-
 .../devicetree/bindings/nvmem/st,stm32-romem.yaml  |    2 +-
 .../bindings/nvmem/sunplus,sp7021-ocotp.yaml       |    2 +-
 .../devicetree/bindings/nvmem/u-boot,env.yaml      |    7 +-
 .../devicetree/bindings/w1/maxim,ds2482.yaml       |   44 +
 Documentation/driver-api/nvmem.rst                 |   15 +
 Documentation/process/magic-number.rst             |    1 -
 .../translations/it_IT/process/magic-number.rst    |    1 -
 .../translations/sp_SP/process/magic-number.rst    |    1 -
 .../translations/zh_CN/process/magic-number.rst    |    1 -
 .../translations/zh_TW/process/magic-number.rst    |    1 -
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 -
 MAINTAINERS                                        |   59 +-
 arch/powerpc/configs/ppc6xx_defconfig              |    2 -
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    1 +
 drivers/acpi/bus.c                                 |    7 +-
 drivers/bus/mhi/ep/main.c                          |    4 +-
 drivers/bus/mhi/host/boot.c                        |   16 +-
 drivers/bus/mhi/host/init.c                        |   16 +-
 drivers/bus/mhi/host/main.c                        |   25 +-
 drivers/bus/mhi/host/pci_generic.c                 |   28 +-
 drivers/cdx/Kconfig                                |   19 +
 drivers/cdx/Makefile                               |    8 +
 drivers/cdx/cdx.c                                  |  535 +++
 drivers/cdx/cdx.h                                  |   62 +
 drivers/cdx/controller/Kconfig                     |   31 +
 drivers/cdx/controller/Makefile                    |    9 +
 drivers/cdx/controller/bitfield.h                  |   90 +
 drivers/cdx/controller/cdx_controller.c            |  230 ++
 drivers/cdx/controller/cdx_controller.h            |   30 +
 drivers/cdx/controller/cdx_rpmsg.c                 |  202 +
 drivers/cdx/controller/mc_cdx_pcol.h               |  590 +++
 drivers/cdx/controller/mcdi.c                      |  903 ++++
 drivers/cdx/controller/mcdi.h                      |  248 ++
 drivers/cdx/controller/mcdi_functions.c            |  139 +
 drivers/cdx/controller/mcdi_functions.h            |   61 +
 drivers/char/Kconfig                               |    2 -
 drivers/char/Makefile                              |    1 -
 drivers/char/pcmcia/Kconfig                        |   68 -
 drivers/char/pcmcia/Makefile                       |   11 -
 drivers/char/pcmcia/cm4000_cs.c                    | 1912 ---------
 drivers/char/pcmcia/cm4040_cs.c                    |  684 ----
 drivers/char/pcmcia/cm4040_cs.h                    |   48 -
 drivers/char/pcmcia/scr24x_cs.c                    |  359 --
 drivers/char/pcmcia/synclink_cs.c                  | 4290 --------------------
 drivers/firmware/dmi-sysfs.c                       |    4 +-
 drivers/firmware/edd.c                             |    2 +-
 drivers/firmware/stratix10-svc.c                   |    4 +-
 drivers/firmware/xilinx/zynqmp.c                   |   33 +
 drivers/fpga/fpga-bridge.c                         |    2 +-
 drivers/fpga/zynqmp-fpga.c                         |   21 +
 drivers/gpu/drm/drm_mipi_dsi.c                     |    2 +-
 drivers/hsi/hsi_core.c                             |    2 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |    1 +
 drivers/i2c/busses/i2c-powermac.c                  |    2 +-
 drivers/i2c/i2c-core-of.c                          |    2 +-
 drivers/iio/Kconfig                                |    3 +
 drivers/iio/Makefile                               |    1 +
 drivers/iio/accel/bma400_core.c                    |    2 +-
 drivers/iio/accel/kionix-kx022a.c                  |    3 +-
 drivers/iio/accel/mma8452.c                        |    2 +-
 drivers/iio/accel/msa311.c                         |    2 +-
 drivers/iio/accel/st_accel.h                       |    1 +
 drivers/iio/accel/st_accel_core.c                  |    1 +
 drivers/iio/accel/st_accel_i2c.c                   |    5 +
 drivers/iio/accel/st_accel_spi.c                   |    5 +
 drivers/iio/adc/Kconfig                            |   10 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad7606.c                           |    2 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |    8 +-
 drivers/iio/adc/axp20x_adc.c                       |   77 +-
 drivers/iio/adc/max11410.c                         |    2 +-
 drivers/iio/adc/meson_saradc.c                     |   21 +-
 drivers/iio/adc/palmas_gpadc.c                     |  615 ++-
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                |    2 +-
 drivers/iio/adc/rcar-gyroadc.c                     |    2 +-
 drivers/iio/adc/stm32-adc.c                        |    6 +-
 drivers/iio/adc/ti-ads1100.c                       |  445 ++
 drivers/iio/addac/Kconfig                          |    2 +
 drivers/iio/addac/ad74413r.c                       |   44 +-
 drivers/iio/addac/stx104.c                         |  462 ++-
 drivers/iio/chemical/sps30_i2c.c                   |    6 +-
 drivers/iio/common/st_sensors/st_sensors_trigger.c |    4 +-
 drivers/iio/dac/Kconfig                            |    1 +
 drivers/iio/dac/ad5592r-base.c                     |    5 +
 drivers/iio/dac/cio-dac.c                          |   68 +-
 drivers/iio/dac/max5522.c                          |    2 +-
 drivers/iio/frequency/admv1013.c                   |   21 +-
 drivers/iio/gyro/fxas21002c_core.c                 |    2 +-
 drivers/iio/gyro/mpu3050-core.c                    |    2 +-
 drivers/iio/humidity/hts221_buffer.c               |    2 +-
 drivers/iio/imu/adis16475.c                        |    6 +-
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |    4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   15 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |   59 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   99 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |   21 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |    5 +
 drivers/iio/industrialio-gts-helper.c              | 1077 +++++
 drivers/iio/industrialio-trigger.c                 |   17 +-
 drivers/iio/light/Kconfig                          |   14 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/acpi-als.c                       |    2 +-
 drivers/iio/light/max44009.c                       |   13 +-
 drivers/iio/light/rohm-bu27034.c                   | 1497 +++++++
 drivers/iio/light/rpr0521.c                        |    2 +-
 drivers/iio/light/st_uvis25_core.c                 |    2 +-
 drivers/iio/light/vcnl4000.c                       |    2 +-
 drivers/iio/light/vcnl4035.c                       |    2 +-
 drivers/iio/potentiostat/lmp91000.c                |    2 +-
 drivers/iio/pressure/Kconfig                       |    6 +-
 drivers/iio/pressure/bmp280-core.c                 |  765 +++-
 drivers/iio/pressure/bmp280-i2c.c                  |   45 +-
 drivers/iio/pressure/bmp280-regmap.c               |   60 +
 drivers/iio/pressure/bmp280-spi.c                  |   47 +-
 drivers/iio/pressure/bmp280.h                      |  273 +-
 drivers/iio/pressure/zpa2326.c                     |    2 +-
 drivers/iio/proximity/as3935.c                     |    2 +-
 drivers/iio/proximity/sx9324.c                     |   96 +-
 drivers/iio/proximity/sx9360.c                     |   32 +-
 drivers/iio/proximity/sx9500.c                     |    4 +-
 drivers/iio/proximity/sx_common.c                  |   21 +
 drivers/iio/proximity/sx_common.h                  |    6 +-
 drivers/iio/temperature/tmp117.c                   |   80 +-
 drivers/iio/trigger/iio-trig-loop.c                |    2 +-
 drivers/interconnect/core.c                        |   81 +-
 drivers/interconnect/qcom/Kconfig                  |    2 +-
 drivers/interconnect/qcom/icc-rpm.c                |   38 +-
 drivers/interconnect/qcom/icc-rpm.h                |   17 +-
 drivers/interconnect/qcom/msm8996.c                |    1 -
 drivers/interconnect/qcom/osm-l3.c                 |    7 -
 drivers/interconnect/qcom/sc7180.h                 |    2 -
 drivers/interconnect/qcom/sc7280.h                 |    2 -
 drivers/interconnect/qcom/sc8180x.h                |    2 -
 drivers/interconnect/qcom/sdm845.h                 |    2 -
 drivers/interconnect/qcom/sm8150.h                 |    2 -
 drivers/interconnect/qcom/sm8250.h                 |    2 -
 drivers/iommu/iommu.c                              |    4 +
 drivers/mcb/mcb-lpc.c                              |   35 +-
 drivers/mcb/mcb-parse.c                            |   15 +-
 drivers/mcb/mcb-pci.c                              |   27 +-
 drivers/misc/cardreader/alcor_pci.c                |  167 +-
 drivers/misc/genwqe/card_base.c                    |    2 -
 drivers/misc/hpilo.c                               |    6 -
 drivers/misc/lis3lv02d/lis3lv02d.c                 |   66 +-
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c    |   10 +-
 drivers/misc/mei/bus-fixup.c                       |    2 +-
 drivers/misc/mei/hdcp/mei_hdcp.c                   |    2 +-
 drivers/misc/mei/hw.h                              |    2 +-
 drivers/misc/mei/main.c                            |    1 -
 drivers/misc/mei/pxp/mei_pxp.c                     |    2 +-
 drivers/misc/sgi-xp/xpc_main.c                     |   24 +-
 drivers/misc/smpro-errmon.c                        |   82 +
 drivers/misc/sram.c                                |   28 +-
 drivers/misc/sram.h                                |    1 -
 drivers/misc/vmw_vmci/vmci_host.c                  |    8 +-
 drivers/nvmem/Kconfig                              |    7 +-
 drivers/nvmem/Makefile                             |    1 +
 drivers/nvmem/bcm-ocotp.c                          |    4 +-
 drivers/nvmem/core.c                               |  169 +-
 drivers/nvmem/imx-ocotp.c                          |   30 +-
 drivers/nvmem/layouts/Kconfig                      |   23 +
 drivers/nvmem/layouts/Makefile                     |    7 +
 drivers/nvmem/layouts/onie-tlv.c                   |  244 ++
 drivers/nvmem/layouts/sl28vpd.c                    |  153 +
 drivers/nvmem/mtk-efuse.c                          |   53 +-
 drivers/nvmem/nintendo-otp.c                       |    4 +-
 drivers/nvmem/stm32-romem.c                        |    2 +-
 drivers/nvmem/u-boot-env.c                         |   26 +
 drivers/nvmem/vf610-ocotp.c                        |    3 +-
 drivers/of/Makefile                                |    2 +-
 drivers/of/base.c                                  |   18 +-
 drivers/of/device.c                                |   75 +-
 drivers/of/module.c                                |   74 +
 drivers/spi/spi.c                                  |    4 +-
 drivers/spmi/hisi-spmi-controller.c                |    5 +-
 drivers/spmi/spmi-mtk-pmif.c                       |    7 +-
 drivers/spmi/spmi-pmic-arb.c                       |    9 +-
 drivers/spmi/spmi.c                                |    8 +-
 drivers/staging/iio/Kconfig                        |    1 -
 drivers/staging/iio/Makefile                       |    1 -
 drivers/staging/iio/meter/Kconfig                  |   37 -
 drivers/staging/iio/meter/Makefile                 |    8 -
 drivers/staging/iio/meter/ade7854-i2c.c            |  153 -
 drivers/staging/iio/meter/ade7854-spi.c            |  160 -
 drivers/staging/iio/meter/ade7854.c                |  556 ---
 drivers/staging/iio/meter/ade7854.h                |  173 -
 drivers/staging/iio/meter/meter.h                  |  398 --
 drivers/staging/iio/resolver/ad2s1210.c            |    2 +-
 drivers/tty/Kconfig                                |    9 +
 drivers/usb/common/ulpi.c                          |    2 +-
 drivers/w1/masters/Kconfig                         |    2 +-
 drivers/w1/masters/ds2482.c                        |   13 +-
 drivers/w1/masters/ds2490.c                        |   13 +-
 drivers/w1/masters/matrox_w1.c                     |   16 +-
 drivers/w1/masters/omap_hdq.c                      |   14 +-
 drivers/w1/masters/w1-gpio.c                       |    4 +-
 drivers/w1/slaves/w1_ds2406.c                      |   35 +-
 drivers/w1/slaves/w1_ds2408.c                      |   12 +-
 drivers/w1/slaves/w1_ds2413.c                      |    8 +-
 drivers/w1/slaves/w1_ds2433.c                      |   23 +-
 drivers/w1/slaves/w1_ds2780.c                      |    1 +
 drivers/w1/slaves/w1_ds2781.c                      |    1 +
 drivers/w1/slaves/w1_ds2805.c                      |    2 +-
 drivers/w1/slaves/w1_ds28e04.c                     |   21 +-
 drivers/w1/slaves/w1_ds28e17.c                     |    6 +-
 include/linux/alcor_pci.h                          |    7 -
 include/linux/cdx/cdx_bus.h                        |  174 +
 include/linux/cm4000_cs.h                          |   11 -
 include/linux/firmware/xlnx-zynqmp.h               |   11 +
 include/linux/iio/iio-gts-helper.h                 |  206 +
 include/linux/iio/trigger.h                        |    8 +-
 include/linux/interconnect-provider.h              |   17 -
 include/linux/mfd/palmas.h                         |    8 -
 include/linux/mhi.h                                |    7 -
 include/linux/mod_devicetable.h                    |   16 +
 include/linux/nvmem-consumer.h                     |    7 +
 include/linux/nvmem-provider.h                     |   74 +-
 include/linux/of.h                                 |   18 +-
 include/linux/of_device.h                          |    6 -
 include/linux/uuid.h                               |    3 -
 include/uapi/linux/cm4000_cs.h                     |   64 -
 include/uapi/linux/mei.h                           |    2 +-
 include/uapi/linux/mei_uuid.h                      |   29 +
 include/uapi/linux/uuid.h                          |   31 +-
 kernel/configs/android-base.config                 |  159 -
 kernel/configs/android-recommended.config          |  127 -
 samples/acrn/vm-sample.c                           |    5 +-
 scripts/mod/devicetable-offsets.c                  |    4 +
 scripts/mod/file2alias.c                           |   12 +
 268 files changed, 11014 insertions(+), 10982 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-cdx
 create mode 100644 Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
 create mode 100644 Documentation/devicetree/bindings/bus/xlnx,versal-net-cdx.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
 delete mode 100644 Documentation/devicetree/bindings/nvmem/amlogic-meson-mx-efuse.txt
 create mode 100644 Documentation/devicetree/bindings/w1/maxim,ds2482.yaml
 create mode 100644 drivers/cdx/Kconfig
 create mode 100644 drivers/cdx/Makefile
 create mode 100644 drivers/cdx/cdx.c
 create mode 100644 drivers/cdx/cdx.h
 create mode 100644 drivers/cdx/controller/Kconfig
 create mode 100644 drivers/cdx/controller/Makefile
 create mode 100644 drivers/cdx/controller/bitfield.h
 create mode 100644 drivers/cdx/controller/cdx_controller.c
 create mode 100644 drivers/cdx/controller/cdx_controller.h
 create mode 100644 drivers/cdx/controller/cdx_rpmsg.c
 create mode 100644 drivers/cdx/controller/mc_cdx_pcol.h
 create mode 100644 drivers/cdx/controller/mcdi.c
 create mode 100644 drivers/cdx/controller/mcdi.h
 create mode 100644 drivers/cdx/controller/mcdi_functions.c
 create mode 100644 drivers/cdx/controller/mcdi_functions.h
 delete mode 100644 drivers/char/pcmcia/Kconfig
 delete mode 100644 drivers/char/pcmcia/Makefile
 delete mode 100644 drivers/char/pcmcia/cm4000_cs.c
 delete mode 100644 drivers/char/pcmcia/cm4040_cs.c
 delete mode 100644 drivers/char/pcmcia/cm4040_cs.h
 delete mode 100644 drivers/char/pcmcia/scr24x_cs.c
 delete mode 100644 drivers/char/pcmcia/synclink_cs.c
 create mode 100644 drivers/iio/adc/ti-ads1100.c
 create mode 100644 drivers/iio/industrialio-gts-helper.c
 create mode 100644 drivers/iio/light/rohm-bu27034.c
 create mode 100644 drivers/nvmem/layouts/Kconfig
 create mode 100644 drivers/nvmem/layouts/Makefile
 create mode 100644 drivers/nvmem/layouts/onie-tlv.c
 create mode 100644 drivers/nvmem/layouts/sl28vpd.c
 create mode 100644 drivers/of/module.c
 delete mode 100644 drivers/staging/iio/meter/Kconfig
 delete mode 100644 drivers/staging/iio/meter/Makefile
 delete mode 100644 drivers/staging/iio/meter/ade7854-i2c.c
 delete mode 100644 drivers/staging/iio/meter/ade7854-spi.c
 delete mode 100644 drivers/staging/iio/meter/ade7854.c
 delete mode 100644 drivers/staging/iio/meter/ade7854.h
 delete mode 100644 drivers/staging/iio/meter/meter.h
 create mode 100644 include/linux/cdx/cdx_bus.h
 delete mode 100644 include/linux/cm4000_cs.h
 create mode 100644 include/linux/iio/iio-gts-helper.h
 delete mode 100644 include/uapi/linux/cm4000_cs.h
 create mode 100644 include/uapi/linux/mei_uuid.h
 delete mode 100644 kernel/configs/android-base.config
 delete mode 100644 kernel/configs/android-recommended.config
