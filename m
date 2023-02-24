Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD516A1C71
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjBXMvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjBXMvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:51:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE8067E33;
        Fri, 24 Feb 2023 04:51:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42D13618CF;
        Fri, 24 Feb 2023 12:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5373AC433EF;
        Fri, 24 Feb 2023 12:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677243075;
        bh=ocwngAEf5PTicddOIGKnJl7NnMzPbVEc+3C5ogPZkjI=;
        h=Date:From:To:Cc:Subject:From;
        b=v1gHmnmR90srI51H0NkQHWdAg3yBIvO38HuHYD7kLD9DTNnyo26JwXJfGeDS+Li5H
         dtmjtg33jWry+TJISDXa5I0KQ6iN622U42tNaRDvd7PtbHNs4m2EdxZtGLaZEQgGHe
         2tBrHdyJP701DxGHDr/SWKZTv+4gXDMkcZpF21lw=
Date:   Fri, 24 Feb 2023 13:51:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver updates for 6.3-rc1
Message-ID: <Y/iywbFbiUAA6ZD3@kroah.com>
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

The following changes since commit 4ec5183ec48656cec489c49f989c508b68b518e3:

  Linux 6.2-rc7 (2023-02-05 13:13:28 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.3-rc1

for you to fetch changes up to 72206cc730b5c9208e9a99ace1c619f542035312:

  tty: n_gsm: add keep alive support (2023-02-16 13:50:50 +0100)

----------------------------------------------------------------
TTY/Serial driver updates for 6.3-rc1

Here is the big set of serial and tty driver updates for 6.3-rc1.

Once again, Jiri and Ilpo have done a number of core vt and tty/serial
layer cleanups that were much needed and appreciated.  Other than that,
it's just a bunch of little tty/serial driver updates:
  - qcom-geni-serial driver updates
  - liteuart driver updates
  - hvcs driver cleanups
  - n_gsm updates and additions for new features
  - more 8250 device support added
  - fpga/dfl update and additions
  - imx serial driver updates
  - fsl_lpuart updates
  - other tiny fixes and updates for serial drivers

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (2):
      serial: liteuart: Don't mix devm_*() with non-devm_*() calls
      serial: liteuart: Remove a copy of UART id in private structure

Bartosz Golaszewski (14):
      tty: serial: qcom-geni-serial: stop operations in progress at shutdown
      tty: serial: qcom-geni-serial: drop unneeded forward definitions
      tty: serial: qcom-geni-serial: remove unused symbols
      tty: serial: qcom-geni-serial: align #define values
      tty: serial: qcom-geni-serial: improve the to_dev_port() macro
      tty: serial: qcom-geni-serial: remove stray newlines
      tty: serial: qcom-geni-serial: refactor qcom_geni_serial_isr()
      tty: serial: qcom-geni-serial: remove unneeded tabs
      tty: serial: qcom-geni-serial: split out the FIFO tx code
      tty: serial: qcom-geni-serial: refactor qcom_geni_serial_send_chunk_fifo()
      tty: serial: qcom-geni-serial: drop the return value from handle_rx
      tty: serial: qcom-geni-serial: use of_device_id data
      soc: qcom-geni-se: add more symbol definitions
      tty: serial: qcom-geni-serial: add support for serial engine DMA

Basheer Ahmed Muddebihal (1):
      fpga: dfl: Add DFHv1 Register Definitions

Bin Meng (3):
      serial: earlycon-arm-semihost: Move smh_putc() variants in respective arch's semihost.h
      riscv: Implement semihost.h for earlycon semihost driver
      serial: Rename earlycon semihost driver

Brian King (6):
      hvcs: Fix hvcs port reference counting
      hvcs: Use dev_groups to manage hvcs device attributes
      hvcs: Use driver groups to manage driver attributes
      hvcs: Get reference to tty in remove
      hvcs: Use vhangup in hotplug remove
      hvcs: Synchronize hotplug remove with port free

Christoph Niedermaier (4):
      dt-bindings: serial: rs485: Add GPIO controlling RX enable during TX
      serial: core: Add option to output RS485 RX_DURING_TX state via GPIO
      serial: imx: Add support for RS485 RX_DURING_TX output GPIO
      serial: stm32: Add support for rs485 RX_DURING_TX output GPIO

Christophe JAILLET (1):
      serial: sccnxp: Use devm_clk_get_enabled() helper

Conor Dooley (1):
      dt-bindings: serial: snps-dw-apb-uart: add dma & dma-names properties

Daniel Starke (4):
      tty: n_gsm: mark unusable ioctl structure fields accordingly
      tty: n_gsm: add RING/CD control support
      tty: n_gsm: add TIOCMIWAIT support
      tty: n_gsm: add keep alive support

Elliot Berman (1):
      soc: qcom: geni-se: Move qcom-geni-se.h to linux/soc/qcom/geni-se.h

Gabriel Somlo (14):
      serial: liteuart: use KBUILD_MODNAME as driver name
      serial: liteuart: use bit number macros
      serial: liteuart: remove unused uart_ops stubs
      serial: liteuart: don't set unused port fields
      serial: liteuart: minor style fix in liteuart_init()
      serial: liteuart: move tty_flip_buffer_push() out of rx loop
      serial: liteuart: rx loop should only ack rx events
      serial: liteuart: simplify passing of uart_insert_char() flag
      serial: liteuart: clean up rx loop variables
      serial: liteuart: separate rx loop from poll timer
      serial: liteuart: move function definitions
      serial: liteuart: add IRQ support for the RX path
      serial: liteuart: add IRQ support for the TX path
      serial: liteuart: move polling putchar() function

Greg Kroah-Hartman (3):
      Merge 6.2-rc5 into tty-next
      Merge 6.2-rc7 into tty-next
      tty: pcn_uart: fix memory leak with using debugfs_lookup()

Ilpo Järvinen (20):
      serial: 8250: Use defined IER bits
      serial: 8250: Name MSR literals
      serial: 8250: Cleanup MCR literals
      serial: 8250: Add IIR FIFOs enabled field properly
      serial: 8250: Define IIR 64 byte bit & cleanup related code
      serial: 8250_early: Convert literals to use defines
      tty: Cleanup tty_port_set_initialized() bool parameter
      tty: Cleamup tty_port_set_suspended() bool parameter
      tty: Cleanup tty_port_set_active() bool parameter
      tty: moxa: Make local var storing tty_port_initialized() bool
      serial: Convert uart_{,port_}startup() init_hw param to bool
      tty: Convert ->carrier_raised() and callchains to bool
      tty: Convert ->dtr_rts() to take bool argument
      tty/serial: Make ->dcd_change()+uart_handle_dcd_change() status bool active
      serial: Make uart_handle_cts_change() status param bool active
      tty: Return bool from tty_termios_hw_change()
      tty: Call ->dtr_rts() parameter active consistently
      tty: moxa: Rename dtr/rts parameters/variables to active
      serial: qcom_geni: Fix variable naming
      serial: liteuart: Correct error rollback

Isaac True (1):
      serial: sc16is7xx: setup GPIO controller later in probe

Jean Delvare (1):
      serial: liteuart: drop obsolete dependency on COMPILE_TEST

Jiri Slaby (SUSE) (11):
      tty: vt: remove vc_uniscr_debug_check()
      tty: vt: drop get_vc_uniscr()
      tty: vt: remove reference to undefined NO_VC_UNI_SCREEN
      tty: vt: use sizeof(*variable) where possible
      tty: vt: remove char32_t typedef
      tty: vt: remove struct uni_screen
      tty: vt: replace BUG_ON() by WARN_ON_ONCE()
      tty: vt: simplify some unicode conditions
      tty: vt: separate array juggling to juggle_array()
      tty: vt: saner names for more scroll variables
      tty: vt: cache row count in con_scroll()

Krzysztof Kozlowski (14):
      dt-bindings: serial: qcom,msm-uart: Convert to DT schema
      serial: msm: add lock annotation to msm_set_baud_rate()
      dt-bindings: serial: amlogic,meson-uart: allow other serial properties
      dt-bindings: serial: 8250: correct Nuvoton NPCM850 compatible
      dt-bindings: serial: pl011: allow ARM Primecell properties
      dt-bindings: serial: correct ref to serial.yaml
      dt-bindings: serial: cdsn,uart: add power-domains
      dt-bindings: serial: 8250_omap: drop rs485 properties
      dt-bindings: serial: fsl-imx-uart: drop common properties
      dt-bindings: serial: fsl-lpuart: drop rs485 properties
      dt-bindings: serial: fsl-lpuart: allow other serial properties
      dt-bindings: serial: st,stm32-uart: drop common properties
      dt-bindings: serial: drop unneeded quotes
      dt-bindings: serial: example cleanup

Kumaravel Thiagarajan (4):
      serial: 8250_pci: Add serial8250_pci_setup_port definition in 8250_pcilib.c
      serial: 8250_pci1xxxx: Add driver for quad-uart support
      serial: 8250_pci1xxxx: Add RS485 support to quad-uart driver
      serial: 8250_pci1xxxx: Add power management functions to quad-uart driver

Liang He (1):
      serial: ucc_uart: Add of_node_put() in ucc_uart_remove()

Matthew Gerlach (3):
      Documentation: fpga: dfl: Add documentation for DFHv1
      fpga: dfl: add basic support for DFHv1
      tty: serial: 8250: add DFL bus driver for Altera 16550.

Nate Drude (1):
      tty: serial: fsl_lpuart: increase maximum uart_nr to eight

Peng Fan (1):
      tty: serial: imx: disable Ageing Timer interrupt request irq

Ricardo Ribalda (2):
      earlycon: Let users set the clock frequency
      earlycon: Increase options size

Rob Herring (1):
      dt-bindings: serial: 8250: Fix 'aspeed,lpc-io-reg' differing types

Samuel Thibault (3):
      VT: Add height parameter to con_font_get/set consw operations
      VT: Add KD_FONT_OP_SET/GET_TALL operations
      VT: Bump font size limitation to 64x128 pixels

Sergey Organov (8):
      serial: imx: factor-out common code to imx_uart_soft_reset()
      serial: imx: work-around for hardware RX flood
      serial: imx: do not sysrq broken chars
      serial: imx: do not break from FIFO reading loop prematurely
      serial: imx: remove redundant USR2 read from FIFO reading loop
      serial: imx: stop using USR2 in FIFO reading loop
      serial: imx: refine local variables in rxint()
      serial: imx: get rid of registers shadowing

Shenwei Wang (1):
      serial: fsl_lpuart: fix RS485 RTS polariy inverse issue

Sherry Sun (13):
      tty: serial: fsl_lpuart: only enable Idle Line Interrupt for non-dma case
      tty: serial: fsl_lpuart: disable Rx/Tx DMA in lpuart32_shutdown()
      tty: serial: fsl_lpuart: clear LPUART Status Register in lpuart32_shutdown()
      tty: serial: fsl_lpuart: disable the CTS when send break signal
      tty: serial: fsl_lpuart: disable the break condition when shutdown the uart port
      tty: serial: imx: disable the break condition when shutdown the uart port
      tty: serial: fsl_lpuart: don't enable receiver/transmitter before rx/tx dma ready
      tty: serial: fsl_lpuart: make rx_watermark configurable for different platforms
      tty: serial: fsl_lpuart: set receive watermark for imx8qxp platform
      tty: serial: fsl_lpuart: Fix the wrong RXWATER setting for rx dma case
      tty: serial: fsl_lpuart: Enable Receiver Idle Empty function for LPUART
      tty: serial: fsl_lpuart: set RTS watermark for lpuart
      tty: serial: fsl_lpuart: add imx8ulp support

Sven Schnelle (2):
      tty: fix out-of-bounds access in tty_driver_lookup_tty()
      tty/vt: prevent registration of console with invalid number

Tom Rix (1):
      serial: imx: remove a redundant check

Uwe Kleine-König (1):
      serial: 8250: Fix mismerge regarding serial_lsr_in()

Yi Yang (1):
      serial: tegra: Add missing clk_disable_unprepare() in tegra_uart_hw_init()

Yuan Can (1):
      serial: pic32: Add checks for devm_clk_get() in pic32_uart_probe()

 Documentation/admin-guide/kernel-parameters.txt    |  12 +-
 Documentation/devicetree/bindings/serial/8250.yaml |  10 +-
 .../devicetree/bindings/serial/8250_omap.yaml      |  23 +-
 .../bindings/serial/amlogic,meson-uart.yaml        |  15 +-
 .../devicetree/bindings/serial/cdns,uart.yaml      |  27 +-
 .../bindings/serial/fsl,s32-linflexuart.yaml       |   2 +-
 .../devicetree/bindings/serial/fsl-imx-uart.yaml   |  11 +-
 .../devicetree/bindings/serial/fsl-lpuart.yaml     |   6 +-
 .../devicetree/bindings/serial/fsl-mxs-auart.yaml  |   2 +-
 .../devicetree/bindings/serial/pl011.yaml          |   1 +
 .../devicetree/bindings/serial/qcom,msm-uart.txt   |  25 -
 .../devicetree/bindings/serial/qcom,msm-uart.yaml  |  56 ++
 .../bindings/serial/renesas,em-uart.yaml           |  10 +-
 .../devicetree/bindings/serial/renesas,hscif.yaml  |  26 +-
 .../devicetree/bindings/serial/renesas,sci.yaml    |  24 +-
 .../devicetree/bindings/serial/renesas,scif.yaml   |  24 +-
 .../devicetree/bindings/serial/renesas,scifa.yaml  |  22 +-
 .../devicetree/bindings/serial/renesas,scifb.yaml  |  12 +-
 .../devicetree/bindings/serial/rs485.yaml          |   6 +
 .../devicetree/bindings/serial/serial.yaml         |  18 +-
 .../devicetree/bindings/serial/sifive-serial.yaml  |   6 +-
 .../bindings/serial/snps-dw-apb-uart.yaml          |   8 +
 .../devicetree/bindings/serial/st,stm32-uart.yaml  |   7 -
 .../bindings/serial/xlnx,opb-uartlite.yaml         |   6 +-
 Documentation/driver-api/tty/n_gsm.rst             |  19 +
 Documentation/fpga/dfl.rst                         | 119 ++++
 MAINTAINERS                                        |   7 +
 arch/arm/include/asm/semihost.h                    |  30 +
 arch/arm64/include/asm/semihost.h                  |  24 +
 arch/riscv/include/asm/semihost.h                  |  26 +
 drivers/char/pcmcia/synclink_cs.c                  |  18 +-
 drivers/fpga/dfl.c                                 | 245 ++++++--
 drivers/fpga/dfl.h                                 |  43 ++
 drivers/i2c/busses/i2c-qcom-geni.c                 |   2 +-
 drivers/ipack/devices/ipoctal.c                    |   4 +-
 drivers/mmc/core/sdio_uart.c                       |  13 +-
 drivers/pps/clients/pps-ldisc.c                    |   6 +-
 drivers/s390/char/con3215.c                        |   4 +-
 drivers/soc/qcom/qcom-geni-se.c                    |   2 +-
 drivers/spi/spi-geni-qcom.c                        |   2 +-
 drivers/staging/greybus/uart.c                     |   4 +-
 drivers/tty/amiserial.c                            |  12 +-
 drivers/tty/hvc/hvc_console.c                      |   4 +-
 drivers/tty/hvc/hvc_console.h                      |   2 +-
 drivers/tty/hvc/hvc_iucv.c                         |   6 +-
 drivers/tty/hvc/hvcs.c                             |  91 ++-
 drivers/tty/moxa.c                                 |  82 +--
 drivers/tty/mxser.c                                |  11 +-
 drivers/tty/n_gsm.c                                | 160 +++++-
 drivers/tty/serial/8250/8250_dfl.c                 | 167 ++++++
 drivers/tty/serial/8250/8250_early.c               |   4 +-
 drivers/tty/serial/8250/8250_pci.c                 |  25 +-
 drivers/tty/serial/8250/8250_pci1xxxx.c            | 494 ++++++++++++++++
 drivers/tty/serial/8250/8250_pcilib.c              |  40 ++
 drivers/tty/serial/8250/8250_pcilib.h              |  15 +
 drivers/tty/serial/8250/8250_port.c                |  57 +-
 drivers/tty/serial/8250/Kconfig                    |  27 +
 drivers/tty/serial/8250/Makefile                   |   3 +
 drivers/tty/serial/Kconfig                         |  16 +-
 drivers/tty/serial/Makefile                        |   2 +-
 ...earlycon-arm-semihost.c => earlycon-semihost.c} |  25 +-
 drivers/tty/serial/earlycon.c                      |   9 +-
 drivers/tty/serial/fsl_lpuart.c                    | 119 +++-
 drivers/tty/serial/imx.c                           | 308 +++++-----
 drivers/tty/serial/liteuart.c                      | 241 ++++----
 drivers/tty/serial/max3100.c                       |   2 +-
 drivers/tty/serial/max310x.c                       |   3 +-
 drivers/tty/serial/msm_serial.c                    |   1 +
 drivers/tty/serial/pch_uart.c                      |   2 +-
 drivers/tty/serial/pic32_uart.c                    |   2 +
 drivers/tty/serial/qcom_geni_serial.c              | 638 ++++++++++++++-------
 drivers/tty/serial/sc16is7xx.c                     |  51 +-
 drivers/tty/serial/sccnxp.c                        |  12 +-
 drivers/tty/serial/serial-tegra.c                  |   7 +-
 drivers/tty/serial/serial_core.c                   |  77 +--
 drivers/tty/serial/stm32-usart.c                   |   6 +-
 drivers/tty/serial/sunhv.c                         |   8 +-
 drivers/tty/serial/ucc_uart.c                      |   2 +
 drivers/tty/synclink_gt.c                          |  21 +-
 drivers/tty/tty_io.c                               |   8 +-
 drivers/tty/tty_ioctl.c                            |   8 +-
 drivers/tty/tty_port.c                             |  22 +-
 drivers/tty/vt/vt.c                                | 310 +++++-----
 drivers/usb/class/cdc-acm.c                        |   4 +-
 drivers/usb/serial/console.c                       |   2 +-
 drivers/usb/serial/usb-serial.c                    |   6 +-
 drivers/video/console/newport_con.c                |   9 +-
 drivers/video/console/sticon.c                     |   9 +-
 drivers/video/console/vgacon.c                     |   8 +-
 drivers/video/fbdev/core/fbcon.c                   |  35 +-
 include/linux/console.h                            |   5 +-
 include/linux/console_struct.h                     |   3 +-
 include/linux/dfl.h                                |   8 +
 include/linux/serial.h                             |  10 +
 include/linux/serial_core.h                        |   9 +-
 .../linux/{qcom-geni-se.h => soc/qcom/geni-se.h}   |   3 +
 include/linux/tty.h                                |   2 +-
 include/linux/tty_ldisc.h                          |   4 +-
 include/linux/tty_port.h                           |  10 +-
 include/uapi/linux/gsmmux.h                        |  17 +-
 include/uapi/linux/kd.h                            |  10 +-
 include/uapi/linux/serial_core.h                   |   3 +
 include/uapi/linux/serial_reg.h                    |   5 +
 net/bluetooth/rfcomm/tty.c                         |   2 +-
 104 files changed, 2908 insertions(+), 1283 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/qcom,msm-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/qcom,msm-uart.yaml
 create mode 100644 arch/arm/include/asm/semihost.h
 create mode 100644 arch/arm64/include/asm/semihost.h
 create mode 100644 arch/riscv/include/asm/semihost.h
 create mode 100644 drivers/tty/serial/8250/8250_dfl.c
 create mode 100644 drivers/tty/serial/8250/8250_pci1xxxx.c
 create mode 100644 drivers/tty/serial/8250/8250_pcilib.c
 create mode 100644 drivers/tty/serial/8250/8250_pcilib.h
 rename drivers/tty/serial/{earlycon-arm-semihost.c => earlycon-semihost.c} (57%)
 rename include/linux/{qcom-geni-se.h => soc/qcom/geni-se.h} (99%)
