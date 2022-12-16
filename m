Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4F664E846
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 09:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLPIow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 03:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiLPIou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 03:44:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8972F37216;
        Fri, 16 Dec 2022 00:44:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27E5161DD8;
        Fri, 16 Dec 2022 08:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18269C433EF;
        Fri, 16 Dec 2022 08:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671180287;
        bh=8gubuTuDKOiSC/NokdtvgaE//sUJgrUvENGpRDFT0rw=;
        h=Date:From:To:Cc:Subject:From;
        b=E2XqzpxZkYYIYns5ii145D2HPfLUX20tIYkFBGWOPnFdlY3rOQ+hQ19qQ2g28DuB+
         zezvhd7/BiXbYDz2SDLI8sDHjb959iU2HAmGQfSkNzHX2t+YAYDBntv3G4xDJO27O9
         2tUCNxgyvmJ2xGaHXsmN4pWCfsDdx4ThBsS2MWJE=
Date:   Fri, 16 Dec 2022 09:44:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver changes for 6.2-rc1
Message-ID: <Y5wv/NvQl6MfRTSu@kroah.com>
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

The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.2-rc1

for you to fetch changes up to 6373ab4dfee731deec62b4452ea641611feff9b3:

  serial: atmel: don't stop the transmitter when doing PIO (2022-11-23 09:39:24 +0100)

----------------------------------------------------------------
TTY/Serial driver changes for 6.2-rc1

Here is the "big" set of tty/serial driver changes for 6.2-rc1.

As in previous kernel releases, nothing big here at all, just some small
incremental serial/tty layer cleanups and some individual driver
additions and fixes.  Highlights are:
  - serial helper macros from Jiri Slaby to reduce the amount of
    duplicated code in serial drivers
  - api cleanups and consolidations from Ilpo Järvinen in lots of serial
    drivers
  - the usual set of n_gsm fixes from Daniel Starke as that code gets
    exercised more
  - TIOCSTI is finally able to be disabled if requested (security
    hardening feature from Kees Cook)
  - fsl_lpuart driver fixes and features added
  - other small serial driver additions and fixes

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (2):
      serial: 8250_core: Use str_enabled_disabled() helper
      serdev: Replace poll loop by readx_poll_timeout() macro

Aniket Randive (1):
      tty: serial: qcom-geni-serial: Add support for Hibernation feature

Christophe Leroy (1):
      tty: evh_bytechan: Replace NO_IRQ by 0

Conor Dooley (2):
      serial: sifive: select by default if SOC_SIFIVE
      serial: sifive: select by default if SOC_CANAAN

Daniel Starke (3):
      tty: n_gsm: introduce macro for minimal unit size
      tty: n_gsm: add parameters used with parameter negotiation
      tty: n_gsm: add parameter negotiation support

Gabriel Somlo (1):
      serial: altera_uart: fix locking in polling mode

Geert Uytterhoeven (1):
      dt-bindings: serial: renesas,scif: Document r8a779g0 support

Greg Kroah-Hartman (1):
      Merge 6.1-rc6 into tty-next

Ilpo Järvinen (53):
      serial: dz: Use uart_xmit_advance()
      serial: men_z135_uart: Use uart_xmit_advance()
      serial: msm: Use uart_xmit_advance()
      serial: pch_uart: Use uart_xmit_advance()
      serial: sc16is7xx: Use uart_xmit_advance()
      serial: 8250_bcm7271: Use uart_xmit_advance()
      serial: 8250: Use uart_xmit_advance()
      serial: pl011: Use uart_xmit_advance()
      serial: ar933x: Use uart_xmit_advance()
      serial: arc: Use uart_xmit_advance()
      serial: atmel: Use uart_xmit_advance()
      serial: clps711x: Use uart_xmit_advance()
      serial: cpm_uart: Use uart_xmit_advance()
      serial: digicolor: Use uart_xmit_advance()
      serial: linflexuart: Use uart_xmit_advance()
      serial: fsl_lpuart: Use uart_xmit_advance()
      serial: imx: Use uart_xmit_advance()
      serial: ip22zilog: Use uart_xmit_advance()
      serial: liteuart: Use uart_xmit_advance()
      serial: max3100: Use uart_xmit_advance()
      serial: max310x: Use uart_xmit_advance()
      serial: meson: Use uart_xmit_advance()
      serial: milbeaut_usio: Use uart_xmit_advance()
      serial: mvebu-uart: Use uart_xmit_advance()
      serial: pic32: Use uart_xmit_advance()
      serial: pmac_zilog: Use uart_xmit_advance()
      serial: rda: Use uart_xmit_advance()
      serial: samsung_tty: Use uart_xmit_advance()
      serial: sb1250-duart: Use uart_xmit_advance()
      serial: sccnxp: Use uart_xmit_advance()
      serial: tegra: Use uart_xmit_advance()
      serial: sh-sci: Use uart_xmit_advance()
      serial: sprd: Use uart_xmit_advance()
      serial: stm32: Use uart_xmit_advance()
      serial: sunhv: Use uart_xmit_advance()
      serial: sunplus-uart: Use uart_xmit_advance()
      serial: sunsab: Use uart_xmit_advance()
      serial: sunsu: Use uart_xmit_advance()
      serial: sunzilog: Use uart_xmit_advance()
      serial: timbuart: Use uart_xmit_advance()
      serial: uartlite: Use uart_xmit_advance()
      serial: ucc_uart: Use uart_xmit_advance()
      serial: xuartps: Use uart_xmit_advance()
      serial: zs: Use uart_xmit_advance()
      serial: Convert serial_rs485 to kernel doc
      Documentation: rs485: Link reference properly
      Documentation: rs485: Mention uart_get_rs485_mode()
      Documentation: rs485: Fix struct referencing
      Documentation: Make formatting consistent for rs485 docs
      tty: Cleanup tty buffer align mask
      tty: Convert tty_buffer flags to bool
      serial: 8250_dma: Rearm DMA Rx if more data is pending
      n_tty: Rename tail to old_tail in n_tty_read()

Jiamei Xie (1):
      serial: amba-pl011: avoid SBSA UART accessing DMACR register

Jiri Slaby (SUSE) (9):
      tty: serial: introduce transmit helpers
      tty: serial: use uart_port_tx() helper
      tty: serial: use uart_port_tx_limited()
      tty: serial: altera_jtaguart: remove flag from altera_jtaguart_rx_chars()
      tty: serial: altera_jtaguart: remove unused altera_jtaguart::sigs
      tty: serial: altera_jtaguart: use uart_port::read_status_mask
      tty: serial: altera_jtaguart: remove struct altera_jtaguart
      serial: atmel: cleanup atmel_start+stop_tx()
      serial: atmel: don't stop the transmitter when doing PIO

Jonathan Neuschäfer (1):
      serial: Fix a typo ("ignorning")

Kartik (1):
      serial: tegra: Read DMA status before terminating

Kees Cook (3):
      tty: Move sysctl setup into "core" tty logic
      tty: Allow TIOCSTI to be disabled
      tty: Move TIOCSTI toggle variable before kerndoc

Lukas Wunner (2):
      serial: 8250: 8250_omap: Support native RS485
      serial: 8250: 8250_omap: Fix calculation of RS485 delays

Marek Vasut (1):
      tty: serial: imx: Handle RS485 DE signal active high

Paul Fulghum (1):
      tty: synclink_gt: unwind actions in error path of net device open

Rob Herring (1):
      dt-bindings: serial: xlnx,opb-uartlite: Drop 'contains' from 'xlnx,use-parity'

Shaomin Deng (1):
      tty: n_gsm: Delete unneeded semicolon

Sherry Sun (4):
      tty: serial: fsl_lpuart: enable wakeup source for lpuart
      tty: serial: fsl_lpuart: Add runtime pm support
      tty: serial: fsl_lpuart: Use pm_ptr() to avoid need to make pm __maybe_unused
      tty: serial: fsl_lpuart: switch to new dmaengine_terminate_* API

Siarhei Volkau (2):
      dt-bindings: serial: ingenic: Add support for the JZ4750/55 SoCs
      serial: 8250/ingenic: Add support for the JZ4750/JZ4755

Valentin Caron (1):
      serial: stm32: move dma_request_chan() before clk_prepare_enable()

Xiongfeng Wang (1):
      serial: pch: Fix PCI device refcount leak in pch_request_dma()

Yuan Can (2):
      serial: 8250_bcm7271: Fix error handling in brcmuart_init()
      serial: sunsab: Fix error handling in sunsab_init()

delisun (1):
      serial: pl011: Do not clear RX FIFO & RX interrupt in unthrottle.

ruanjinjie (1):
      tty: hvc: make hvc_rtas_dev static

 .../devicetree/bindings/serial/ingenic,uart.yaml   |   4 +
 .../devicetree/bindings/serial/renesas,scif.yaml   |   1 +
 .../bindings/serial/xlnx,opb-uartlite.yaml         |   3 +-
 Documentation/driver-api/serial/driver.rst         |   3 +
 Documentation/driver-api/serial/serial-rs485.rst   |  56 +--
 drivers/tty/Kconfig                                |  19 +
 drivers/tty/ehv_bytechan.c                         |   4 +-
 drivers/tty/hvc/hvc_rtas.c                         |   2 +-
 drivers/tty/n_gsm.c                                | 402 +++++++++++++++++++--
 drivers/tty/n_tty.c                                |   6 +-
 drivers/tty/serial/21285.c                         |  32 +-
 drivers/tty/serial/8250/8250_bcm7271.c             |  14 +-
 drivers/tty/serial/8250/8250_core.c                |   5 +-
 drivers/tty/serial/8250/8250_dma.c                 |  19 +-
 drivers/tty/serial/8250/8250_ingenic.c             |  32 +-
 drivers/tty/serial/8250/8250_omap.c                |  85 ++++-
 drivers/tty/serial/8250/8250_port.c                |   3 +-
 drivers/tty/serial/Kconfig                         |   2 +
 drivers/tty/serial/altera_jtaguart.c               | 112 ++----
 drivers/tty/serial/altera_uart.c                   |  34 +-
 drivers/tty/serial/amba-pl010.c                    |  32 +-
 drivers/tty/serial/amba-pl011.c                    |  17 +-
 drivers/tty/serial/apbuart.c                       |  34 +-
 drivers/tty/serial/ar933x_uart.c                   |   3 +-
 drivers/tty/serial/arc_uart.c                      |   3 +-
 drivers/tty/serial/atmel_serial.c                  |  80 ++--
 drivers/tty/serial/bcm63xx_uart.c                  |  47 +--
 drivers/tty/serial/clps711x.c                      |   3 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |   3 +-
 drivers/tty/serial/digicolor-usart.c               |   3 +-
 drivers/tty/serial/dz.c                            |   3 +-
 drivers/tty/serial/fsl_linflexuart.c               |   3 +-
 drivers/tty/serial/fsl_lpuart.c                    | 386 ++++++++++++++------
 drivers/tty/serial/imx.c                           |  71 +++-
 drivers/tty/serial/ip22zilog.c                     |   6 +-
 drivers/tty/serial/lantiq.c                        |  36 +-
 drivers/tty/serial/liteuart.c                      |   3 +-
 drivers/tty/serial/lpc32xx_hs.c                    |  33 +-
 drivers/tty/serial/max3100.c                       |   4 +-
 drivers/tty/serial/max310x.c                       |   5 +-
 drivers/tty/serial/mcf.c                           |  34 +-
 drivers/tty/serial/men_z135_uart.c                 |   5 +-
 drivers/tty/serial/meson_uart.c                    |   3 +-
 drivers/tty/serial/milbeaut_usio.c                 |   3 +-
 drivers/tty/serial/mpc52xx_uart.c                  |  39 +-
 drivers/tty/serial/mps2-uart.c                     |  26 +-
 drivers/tty/serial/msm_serial.c                    |  13 +-
 drivers/tty/serial/mux.c                           |  45 +--
 drivers/tty/serial/mvebu-uart.c                    |  41 +--
 drivers/tty/serial/mxs-auart.c                     |  32 +-
 drivers/tty/serial/omap-serial.c                   |  32 +-
 drivers/tty/serial/owl-uart.c                      |  32 +-
 drivers/tty/serial/pch_uart.c                      |  16 +-
 drivers/tty/serial/pic32_uart.c                    |   3 +-
 drivers/tty/serial/pmac_zilog.c                    |   6 +-
 drivers/tty/serial/pxa.c                           |  33 +-
 drivers/tty/serial/qcom_geni_serial.c              |  35 ++
 drivers/tty/serial/rda-uart.c                      |   3 +-
 drivers/tty/serial/rp2.c                           |  31 +-
 drivers/tty/serial/sa1100.c                        |  34 +-
 drivers/tty/serial/samsung_tty.c                   |  10 +-
 drivers/tty/serial/sb1250-duart.c                  |   3 +-
 drivers/tty/serial/sc16is7xx.c                     |   5 +-
 drivers/tty/serial/sccnxp.c                        |   3 +-
 drivers/tty/serial/serial-tegra.c                  |   9 +-
 drivers/tty/serial/serial_txx9.c                   |  32 +-
 drivers/tty/serial/sh-sci.c                        |   5 +-
 drivers/tty/serial/sifive.c                        |  31 +-
 drivers/tty/serial/sprd_serial.c                   |  40 +-
 drivers/tty/serial/st-asc.c                        |  48 +--
 drivers/tty/serial/stm32-usart.c                   |  54 ++-
 drivers/tty/serial/sunhv.c                         |   6 +-
 drivers/tty/serial/sunplus-uart.c                  |   4 +-
 drivers/tty/serial/sunsab.c                        |  14 +-
 drivers/tty/serial/sunsu.c                         |   3 +-
 drivers/tty/serial/sunzilog.c                      |   6 +-
 drivers/tty/serial/timbuart.c                      |   3 +-
 drivers/tty/serial/uartlite.c                      |   3 +-
 drivers/tty/serial/ucc_uart.c                      |   3 +-
 drivers/tty/serial/vt8500_serial.c                 |  32 +-
 drivers/tty/serial/xilinx_uartps.c                 |   4 +-
 drivers/tty/serial/zs.c                            |   3 +-
 drivers/tty/synclink_gt.c                          |  19 +-
 drivers/tty/tty.h                                  |   2 +-
 drivers/tty/tty_buffer.c                           |  32 +-
 drivers/tty/tty_io.c                               |  45 ++-
 drivers/tty/tty_ldisc.c                            |  38 +-
 include/linux/serdev.h                             |  13 +-
 include/linux/serial_core.h                        |  80 ++++
 include/linux/tty_buffer.h                         |   5 +-
 include/linux/tty_flip.h                           |   4 +-
 include/uapi/linux/serial.h                        |  55 ++-
 92 files changed, 1447 insertions(+), 1246 deletions(-)
