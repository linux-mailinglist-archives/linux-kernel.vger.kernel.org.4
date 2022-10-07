Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A1C5F7B8F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJGQfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJGQff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:35:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8FC7DF6B;
        Fri,  7 Oct 2022 09:35:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39973B82395;
        Fri,  7 Oct 2022 16:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C715C433D6;
        Fri,  7 Oct 2022 16:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665160530;
        bh=GT0RrUnhPFj8j3URsrTAfJAMVFUruilsO15DRyWXvcY=;
        h=Date:From:To:Cc:Subject:From;
        b=hF32v3mMbwrBBHpOz6jFxWUL4PMINbqhfHqZ5uX0Hv2q+JsJvBZW4EYWJs+HhGhFh
         ud/vRAj0Z2MiVVObTmd47iIEb+YIXTcZy66XXMDrdxuCRF/2aUg6ExfOYJfsTwjlPA
         iJpGOLk/35/rBmXgHpmzFxA0Uk4Ev6K8w/ptS+2s=
Date:   Fri, 7 Oct 2022 18:36:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver changes for 6.1-rc1
Message-ID: <Y0BVfL9lPd7jz5/s@kroah.com>
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

The following changes since commit 7e2cd21e02b35483ce8ea88da5732d4d3ec3a6c9:

  Merge tag 'tty-6.0-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty (2022-09-24 08:42:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.1-rc1

for you to fetch changes up to 30963b2f75bfdbbcf1cc5d80bf88fec7aaba808d:

  serial: cpm_uart: Don't request IRQ too early for console port (2022-09-30 14:59:19 +0200)

----------------------------------------------------------------
TTY/Serial driver update for 6.1-rc1

Here is the big set of TTY and Serial driver updates for 6.1-rc1.

Lots of cleanups in here, no real new functionality this time around,
with the diffstat being that we removed more lines than we added!

Included in here are:
	- termios unification cleanups from Al Viro, it's nice to
	  finally get this work done
	- tty serial transmit cleanups in various drivers in preparation
	  for more cleanup and unification in future releases (that work
	  was not ready for this release.)
	- n_gsm fixes and updates
	- ktermios cleanups and code reductions
	- dt bindings json conversions and updates for new devices
	- some serial driver updates for new devices
	- lots of other tiny cleanups and janitorial stuff.  Full
	  details in the shortlog.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Al Viro (9):
      loongarch: remove generic-y += termios.h
      termios: get rid of stray asm/termios.h include in n_hdlc.c
      termios: uninline conversion helpers
      termios: start unifying non-UAPI parts of asm/termios.h
      termios: consolidate values for VDISCARD in INIT_C_CC
      make generic INIT_C_CC a bit more generic
      termios: convert the last (sparc) INIT_C_CC to array
      termios: get rid of non-UAPI asm/termios.h
      termios: kill uapi termios.h that are identical to generic one

Andy Shevchenko (5):
      serial: pic32_uart: Utilize uart_console_enabled()
      serial: pic32_uart: Convert to use GPIO descriptors
      serial: 8250_men_mcb: Remove duplicate UAPI:serial_core inclusion
      serial: 8250_omap: Convert to use uart_xmit_advance()
      serial: 8250_dma: Convert to use uart_xmit_advance()

Christophe JAILLET (1):
      tty: serial: meson: Use devm_clk_get_enabled() helper

Christophe Leroy (1):
      serial: cpm_uart: Don't request IRQ too early for console port

Colin Ian King (1):
      tty: mxser: remove redundant assignment to hwid

Dan Carpenter (1):
      drivers: serial: jsm: fix some leaks in probe

Daniel Starke (6):
      tty: n_gsm: add enumeration for gsm encodings
      tty: n_gsm: name gsm tty device minors
      tty: n_gsm: replace use of gsm_read_ea() with gsm_read_ea_val()
      tty: n_gsm: introduce gsm_control_command() function
      tty: n_gsm: name the debug bits
      tty: n_gsm: add debug bit for user payload

Daniel Vetter (3):
      tty/vt: Remove printable variable
      kernel/panic: Drop unblank_screen call
      tty/vt: Add console_lock check to vt_console_print()

Gaosheng Cui (1):
      tty: serial: cpm_uart: remove unused cpm_uart_nr declaration

Greg Kroah-Hartman (2):
      Merge 6.0-rc4 into tty-next
      Merge 7e2cd21e02b3 ("Merge tag 'tty-6.0-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty") into tty-next

Ilpo Järvinen (19):
      serial: 8250: Add helper for clearing IER
      serial: 8250: Clear dma tx_err unconditionally
      tty: Remove baudrate dead code & make ktermios params const
      tty: Fix comment style in tty_termios_input_baud_rate()
      serial: dz: Assume previous baudrate is valid
      tty: Make tty_termios_copy_hw() old ktermios const
      tty: Make ldisc ->set_termios() old ktermios const
      serial: Make ->set_termios() old ktermios const
      usb: serial: Make ->set_termios() old ktermios const
      tty: Make ->set_termios() old ktermios const
      serial: sh-sci: CIRC_CNT_TO_END() is enough
      serial: sh-sci: tail is already on valid range
      serial: pch_uart: CIRC_CNT_TO_END() is enough
      serial: ucc_uart: Remove custom frame size calculation
      serial: cpm_uart: Remove custom frame size calculation
      serial: fsl_lpuart: Remove custom frame size calculation
      serial: sunsab: Remove frame size calculation dead-code
      serial: tegra: Remove custom frame size calculation
      serial: 8250: Toggle IER bits on only after irq has been set up

Jason Wang (1):
      serial: fsl_lpuart: Fix comment typo

Jindong Yue (1):
      tty: serial: fsl_lpuart: adjust SERIAL_FSL_LPUART_CONSOLE config dependency

Jiri Slaby (12):
      tty: serial: move and cleanup vt8500_tx_empty()
      tty: serial: clean up stop-tx part in altera_uart_tx_chars()
      tty: serial: altera_uart_{r,t}x_chars() need only uart_port
      tty: serial: extract lqasc_tx_ready() from lqasc_tx_chars()
      tty: serial: extract tx_ready() from __serial_lpc32xx_tx()
      tty: serial: switch mpc52xx_uart_int_{r,t}x_chars() to bool
      tty: serial: extract serial_omap_put_char() from transmit_chars()
      tty: serial: allow pxa.c to be COMPILE_TESTed
      tty: serial: extend lqasc_tx_ready() to lqasc_console_putchar()
      tty: serial: use FIELD_GET() in lqasc_tx_ready()
      tty: serial: unify TX space reads under altera_jtaguart_tx_space()
      tty: serial: do unlock on a common path in altera_jtaguart_console_putc()

Johan Jonker (1):
      dt-bindings: serial: rockchip: add rockchip,rk3128-uart

Kewei Xu (1):
      dt-binding: serial: mediatek,uart: update bingding for MT8188

Krzysztof Kozlowski (1):
      dt-bindings: serial: samsung_uart: drop ref from reg-io-width

Lad Prabhakar (1):
      dt-bindings: serial: renesas,scif: Document RZ/Five SoC

Lukas Wunner (4):
      serial: omap: Disallow RS-485 if rts-gpio is not specified
      serial: ar933x: Deassert Transmit Enable on ->rs485_config()
      serial: stm32: Deassert Transmit Enable on ->rs485_config()
      serial: Deassert Transmit Enable on probe in driver-specific way

Maciej W. Rozycki (3):
      serial: 8250: Let drivers request full 16550A feature probing
      serial: 8250: Request full 16550A feature probing for OxSemi PCIe devices
      serial: 8250: Switch UART port flags to using BIT_ULL

Michal Simek (1):
      tty: xilinx_uartps: Update copyright text to correct format

Pali Rohár (1):
      serial: 8250: Fix restoring termios speed after suspend

Ren Zhijie (1):
      serial: stm32: Fix unused-variable warning

Rob Herring (1):
      dt-bindings: serial: samsung: Add 'power-domains' property

Sergiu Moga (9):
      dt-bindings: serial: atmel,at91-usart: convert to json-schema
      dt-bindings: serial: atmel,at91-usart: Add SAM9260 compatibles to SAM9X60
      dt-bindings: serial: atmel,at91-usart: Add gclk as a possible USART clock
      tty: serial: atmel: Separate mode clearing between UART and USART
      tty: serial: atmel: Only divide Clock Divisor if the IP is USART
      tty: serial: atmel: Make the driver aware of the existence of GCLK
      tty: serial: atmel: Use FIELD_PREP/FIELD_GET
      MAINTAINERS: Solve warning regarding inexistent atmel-usart binding
      tty: serial: atmel: Add COMMON_CLK dependency to SERIAL_ATMEL

Shaomin Deng (1):
      serial: Fix double word

Sherry Sun (1):
      tty: serial: fsl_lpuart: disable dma rx/tx use flags in lpuart_dma_shutdown

Shubhrajyoti Datta (8):
      tty: xilinx_uartps: Check clk_enable return value
      tty: xilinx_uartps: Initialise the read_status_mask
      tty: xilinx_uartps: Fix the ignore_status
      tty: xilinx_uartps: Prevent writes when the controller is disabled
      tty: xilinx_uartps: Add timeout waiting for loop
      tty: xilinx_uartps: Check the clk_enable return value
      dt-bindings: serial: pl011: Add a reg-io-width parameter
      serial: pl011: Add reg-io-width parameters

Vijaya Krishna Nivarthi (1):
      tty: serial: qcom-geni-serial: Replace hardcoded icc flags with macros.

Wolfram Sang (1):
      tty: move from strlcpy with unused retval to strscpy

наб (5):
      tty: remove TTY_MAGIC
      tty: remove TTY_DRIVER_MAGIC
      tty: n_hdlc: remove HDLC_MAGIC
      tty: synclink_gt: remove MGSL_MAGIC
      tty: hvc: remove HVC_IUCV_MAGIC

 .../devicetree/bindings/mfd/atmel-usart.txt        |  98 ----------
 .../bindings/serial/atmel,at91-usart.yaml          | 190 +++++++++++++++++++
 .../devicetree/bindings/serial/mediatek,uart.yaml  |   1 +
 .../devicetree/bindings/serial/pl011.yaml          |   6 +
 .../devicetree/bindings/serial/renesas,scif.yaml   |   2 +-
 .../devicetree/bindings/serial/samsung_uart.yaml   |   4 +-
 .../bindings/serial/snps-dw-apb-uart.yaml          |   1 +
 Documentation/process/magic-number.rst             |   4 -
 .../translations/it_IT/process/magic-number.rst    |   4 -
 .../translations/zh_CN/process/magic-number.rst    |   4 -
 .../translations/zh_TW/process/magic-number.rst    |   4 -
 MAINTAINERS                                        |   6 +-
 arch/alpha/include/asm/termios.h                   |  87 ---------
 arch/alpha/kernel/Makefile                         |   2 +-
 arch/alpha/kernel/termios.c                        |  56 ++++++
 arch/arm/mach-ep93xx/core.c                        |   1 +
 arch/arm/mach-versatile/integrator_ap.c            |   1 +
 arch/ia64/include/asm/termios.h                    |  58 ------
 arch/ia64/include/uapi/asm/termios.h               |  51 ------
 arch/loongarch/include/asm/Kbuild                  |   1 -
 arch/mips/include/asm/termios.h                    | 105 -----------
 arch/parisc/include/asm/termios.h                  |  52 ------
 arch/parisc/include/uapi/asm/termios.h             |  44 -----
 arch/powerpc/include/asm/termios.h                 |  18 --
 arch/s390/include/asm/termios.h                    |  26 ---
 arch/s390/include/uapi/asm/termios.h               |  50 -----
 arch/sparc/include/asm/termios.h                   | 147 ---------------
 arch/sparc/kernel/Makefile                         |   4 +-
 arch/sparc/kernel/termios.c                        | 115 ++++++++++++
 drivers/char/pcmcia/synclink_cs.c                  |   3 +-
 drivers/ipack/devices/ipoctal.c                    |   2 +-
 drivers/mmc/core/sdio_uart.c                       |   4 +-
 drivers/net/usb/hso.c                              |   3 +-
 drivers/net/wwan/wwan_core.c                       |   1 +
 drivers/s390/char/tty3270.c                        |   2 +-
 drivers/staging/fwserial/fwserial.c                |   3 +-
 drivers/staging/greybus/uart.c                     |   2 +-
 drivers/tty/amiserial.c                            |   6 +-
 drivers/tty/hvc/hvc_iucv.c                         |  11 +-
 drivers/tty/hvc/hvcs.c                             |   3 +-
 drivers/tty/moxa.c                                 |   9 +-
 drivers/tty/mxser.c                                |   8 +-
 drivers/tty/n_gsm.c                                | 202 ++++++++++++---------
 drivers/tty/n_hdlc.c                               |  28 ---
 drivers/tty/n_tty.c                                |   2 +-
 drivers/tty/pty.c                                  |   2 +-
 drivers/tty/serial/21285.c                         |   2 +-
 drivers/tty/serial/8250/8250_bcm7271.c             |   2 +-
 drivers/tty/serial/8250/8250_core.c                |  16 +-
 drivers/tty/serial/8250/8250_dma.c                 |   7 +-
 drivers/tty/serial/8250/8250_dw.c                  |   2 +-
 drivers/tty/serial/8250/8250_dwlib.c               |   3 +-
 drivers/tty/serial/8250/8250_dwlib.h               |   2 +-
 drivers/tty/serial/8250/8250_fintek.c              |   2 +-
 drivers/tty/serial/8250/8250_lpss.c                |   2 +-
 drivers/tty/serial/8250/8250_men_mcb.c             |   1 -
 drivers/tty/serial/8250/8250_mid.c                 |   5 +-
 drivers/tty/serial/8250/8250_mtk.c                 |   2 +-
 drivers/tty/serial/8250/8250_omap.c                |   9 +-
 drivers/tty/serial/8250/8250_pci.c                 |  14 +-
 drivers/tty/serial/8250/8250_port.c                |  62 ++++---
 drivers/tty/serial/Kconfig                         |   5 +-
 drivers/tty/serial/altera_jtaguart.c               |  36 ++--
 drivers/tty/serial/altera_uart.c                   |  18 +-
 drivers/tty/serial/amba-pl010.c                    |   2 +-
 drivers/tty/serial/amba-pl011.c                    |  20 +-
 drivers/tty/serial/apbuart.c                       |   2 +-
 drivers/tty/serial/ar933x_uart.c                   |   9 +-
 drivers/tty/serial/arc_uart.c                      |   2 +-
 drivers/tty/serial/atmel_serial.c                  |  87 ++++++++-
 drivers/tty/serial/atmel_serial.h                  |  75 ++++----
 drivers/tty/serial/bcm63xx_uart.c                  |   5 +-
 drivers/tty/serial/clps711x.c                      |   2 +-
 drivers/tty/serial/cpm_uart/cpm_uart.h             |   1 -
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |  55 +++---
 drivers/tty/serial/digicolor-usart.c               |   2 +-
 drivers/tty/serial/dz.c                            |  11 +-
 drivers/tty/serial/earlycon.c                      |   6 +-
 drivers/tty/serial/fsl_linflexuart.c               |   2 +-
 drivers/tty/serial/fsl_lpuart.c                    |  27 ++-
 drivers/tty/serial/icom.c                          |   5 +-
 drivers/tty/serial/imx.c                           |  10 +-
 drivers/tty/serial/ip22zilog.c                     |   2 +-
 drivers/tty/serial/jsm/jsm_driver.c                |   3 +-
 drivers/tty/serial/jsm/jsm_tty.c                   |   4 +-
 drivers/tty/serial/lantiq.c                        |  25 +--
 drivers/tty/serial/liteuart.c                      |   2 +-
 drivers/tty/serial/lpc32xx_hs.c                    |  12 +-
 drivers/tty/serial/max3100.c                       |   2 +-
 drivers/tty/serial/max310x.c                       |   2 +-
 drivers/tty/serial/mcf.c                           |   2 +-
 drivers/tty/serial/men_z135_uart.c                 |   4 +-
 drivers/tty/serial/meson_uart.c                    |  31 +---
 drivers/tty/serial/milbeaut_usio.c                 |   3 +-
 drivers/tty/serial/mpc52xx_uart.c                  |  30 +--
 drivers/tty/serial/mps2-uart.c                     |   2 +-
 drivers/tty/serial/msm_serial.c                    |   2 +-
 drivers/tty/serial/mux.c                           |   2 +-
 drivers/tty/serial/mvebu-uart.c                    |   2 +-
 drivers/tty/serial/mxs-auart.c                     |   2 +-
 drivers/tty/serial/omap-serial.c                   |  49 ++---
 drivers/tty/serial/owl-uart.c                      |   2 +-
 drivers/tty/serial/pch_uart.c                      |   7 +-
 drivers/tty/serial/pic32_uart.c                    |  52 ++----
 drivers/tty/serial/pmac_zilog.c                    |   4 +-
 drivers/tty/serial/pxa.c                           |   2 +-
 drivers/tty/serial/qcom_geni_serial.c              |   8 +-
 drivers/tty/serial/rda-uart.c                      |   2 +-
 drivers/tty/serial/rp2.c                           |   5 +-
 drivers/tty/serial/sa1100.c                        |   2 +-
 drivers/tty/serial/samsung_tty.c                   |   2 +-
 drivers/tty/serial/sb1250-duart.c                  |   2 +-
 drivers/tty/serial/sc16is7xx.c                     |   2 +-
 drivers/tty/serial/sccnxp.c                        |   3 +-
 drivers/tty/serial/serial-tegra.c                  |  15 +-
 drivers/tty/serial/serial_core.c                   |  46 ++---
 drivers/tty/serial/serial_txx9.c                   |   2 +-
 drivers/tty/serial/sh-sci.c                        |   8 +-
 drivers/tty/serial/sifive.c                        |   2 +-
 drivers/tty/serial/sprd_serial.c                   |   5 +-
 drivers/tty/serial/st-asc.c                        |   2 +-
 drivers/tty/serial/stm32-usart.c                   | 108 +++++------
 drivers/tty/serial/sunhv.c                         |   2 +-
 drivers/tty/serial/sunplus-uart.c                  |   2 +-
 drivers/tty/serial/sunsab.c                        |  22 +--
 drivers/tty/serial/sunsu.c                         |   8 +-
 drivers/tty/serial/sunzilog.c                      |   8 +-
 drivers/tty/serial/tegra-tcu.c                     |   2 +-
 drivers/tty/serial/timbuart.c                      |   4 +-
 drivers/tty/serial/uartlite.c                      |   5 +-
 drivers/tty/serial/ucc_uart.c                      |  18 +-
 drivers/tty/serial/vt8500_serial.c                 |  17 +-
 drivers/tty/serial/xilinx_uartps.c                 |  62 ++++++-
 drivers/tty/serial/zs.c                            |   2 +-
 drivers/tty/synclink_gt.c                          |  11 +-
 drivers/tty/tty.h                                  |   2 +-
 drivers/tty/tty_baudrate.c                         |  26 +--
 drivers/tty/tty_io.c                               |  11 +-
 drivers/tty/tty_ioctl.c                            |  79 +++++++-
 drivers/tty/tty_mutex.c                            |   6 -
 drivers/tty/vcc.c                                  |   1 +
 drivers/tty/vt/vt.c                                |  11 +-
 drivers/usb/class/cdc-acm.c                        |   4 +-
 drivers/usb/serial/ark3116.c                       |   2 +-
 drivers/usb/serial/belkin_sa.c                     |   6 +-
 drivers/usb/serial/ch341.c                         |   5 +-
 drivers/usb/serial/cp210x.c                        |  13 +-
 drivers/usb/serial/cypress_m8.c                    |   6 +-
 drivers/usb/serial/digi_acceleport.c               |   6 +-
 drivers/usb/serial/f81232.c                        |   3 +-
 drivers/usb/serial/f81534.c                        |   4 +-
 drivers/usb/serial/ftdi_sio.c                      |   6 +-
 drivers/usb/serial/io_edgeport.c                   |   7 +-
 drivers/usb/serial/io_ti.c                         |   8 +-
 drivers/usb/serial/ir-usb.c                        |   6 +-
 drivers/usb/serial/iuu_phoenix.c                   |   3 +-
 drivers/usb/serial/keyspan.c                       |   3 +-
 drivers/usb/serial/keyspan_pda.c                   |   3 +-
 drivers/usb/serial/kl5kusb105.c                    |   5 +-
 drivers/usb/serial/kobil_sct.c                     |   6 +-
 drivers/usb/serial/mct_u232.c                      |   5 +-
 drivers/usb/serial/mos7720.c                       |   5 +-
 drivers/usb/serial/mos7840.c                       |   5 +-
 drivers/usb/serial/mxuport.c                       |   4 +-
 drivers/usb/serial/oti6858.c                       |   6 +-
 drivers/usb/serial/pl2303.c                        |   3 +-
 drivers/usb/serial/quatech2.c                      |   4 +-
 drivers/usb/serial/spcp8x5.c                       |   3 +-
 drivers/usb/serial/ssu100.c                        |   4 +-
 drivers/usb/serial/ti_usb_3410_5052.c              |   6 +-
 drivers/usb/serial/upd78f0730.c                    |   4 +-
 drivers/usb/serial/usb-serial.c                    |   3 +-
 drivers/usb/serial/whiteheat.c                     |   6 +-
 drivers/usb/serial/xr_serial.c                     |  20 +-
 include/asm-generic/termios-base.h                 |  78 --------
 include/asm-generic/termios.h                      | 108 -----------
 include/linux/serdev.h                             |   1 +
 include/linux/serial_8250.h                        |   5 +-
 include/linux/serial_core.h                        |  36 ++--
 include/linux/termios_internal.h                   |  49 +++++
 include/linux/tty.h                                |  10 +-
 include/linux/tty_driver.h                         |  10 +-
 include/linux/tty_ldisc.h                          |   4 +-
 include/linux/usb/serial.h                         |   4 +-
 include/linux/vt_kern.h                            |   1 -
 kernel/panic.c                                     |   3 -
 lib/bust_spinlocks.c                               |   3 -
 net/bluetooth/rfcomm/tty.c                         |   3 +-
 188 files changed, 1432 insertions(+), 1764 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-usart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
 delete mode 100644 arch/alpha/include/asm/termios.h
 create mode 100644 arch/alpha/kernel/termios.c
 delete mode 100644 arch/ia64/include/asm/termios.h
 delete mode 100644 arch/ia64/include/uapi/asm/termios.h
 delete mode 100644 arch/mips/include/asm/termios.h
 delete mode 100644 arch/parisc/include/asm/termios.h
 delete mode 100644 arch/parisc/include/uapi/asm/termios.h
 delete mode 100644 arch/powerpc/include/asm/termios.h
 delete mode 100644 arch/s390/include/asm/termios.h
 delete mode 100644 arch/s390/include/uapi/asm/termios.h
 delete mode 100644 arch/sparc/include/asm/termios.h
 create mode 100644 arch/sparc/kernel/termios.c
 delete mode 100644 include/asm-generic/termios-base.h
 delete mode 100644 include/asm-generic/termios.h
 create mode 100644 include/linux/termios_internal.h
