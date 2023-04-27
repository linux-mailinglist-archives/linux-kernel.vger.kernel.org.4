Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F5B6F0729
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243880AbjD0OUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243960AbjD0OUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:20:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEB959DA;
        Thu, 27 Apr 2023 07:20:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 980A663DB4;
        Thu, 27 Apr 2023 14:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52ADC43442;
        Thu, 27 Apr 2023 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682605207;
        bh=3cotmKeBNpcsqr+AZR48rcvBaKaMgQCrM6TWw/l6Yc0=;
        h=Date:From:To:Cc:Subject:From;
        b=HJtJOhNbhkUIqAUDOfw+wpC3bwTQjJOvpijyVtUzFrAi70TAFBPhAwItRaIX7yx0+
         wq8wnSbj8FbNWqD3+jOUyC3FiJDNDTCKJ0gyL3M1JwjCDp+7kWBd9u7pVO9tALEeJh
         kSq8rH6VsxwZ1WVJeAoFgWKSRKUiSsvH4sIAyckw=
Date:   Thu, 27 Apr 2023 16:20:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver changes for 6.4-rc1
Message-ID: <ZEqElASSM07hTjHH@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.4-rc1

for you to fetch changes up to 2b3174c96696cde676393474f0e01d0d108462f5:

  n_gsm: Use array_index_nospec() with index that comes from userspace (2023-04-20 14:11:33 +0200)

----------------------------------------------------------------
TTY/Serial changes for 6.4-rc1

Here is the big set of tty/serial driver updates for 6.4-rc1.

Nothing major, just lots of tiny, constant, forward development.  This
includes:
  - obligatory n_gsm updates and feature additions
  - 8250_em driver updates
  - sh-sci driver updates
  - dts cleanups and updates
  - general cleanups and improvements by Ilpo and Jiri
  - other small serial driver core fixes and driver updates

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arend van Spriel (1):
      serial: bcm63xx-uart: add polling support

Bernhard Rosenkränzer (1):
      dt-bindings: serial: mediatek,uart: add MT8365

Biju Das (13):
      serial: 8250_em: Fix UART port type
      serial: 8250_em: Simplify probe()
      serial: 8250_em: Drop unused header file
      serial: 8250_em: Add missing break statement
      serial: 8250_em: Use devm_clk_get_enabled()
      serial: 8250_em: Use pseudo offset for UART_FCR
      serial: 8250_em: Add serial8250_em_{reg_update(),out_helper()}
      tty: serial: sh-sci: Remove setting {src,dst}_{addr,addr_width} based on DMA direction
      tty: serial: sh-sci: Add RZ/G2L SCIFA DMA tx support
      tty: serial: sh-sci: Add RZ/G2L SCIFA DMA rx support
      tty: serial: sh-sci: Fix TE setting on SCI IP
      tty: serial: sh-sci: Add support for tx end interrupt handling
      tty: serial: sh-sci: Fix end of transmission on SCI

Christophe JAILLET (1):
      serial: 8250: Reorder fields in 'struct plat_serial8250_port'

Conor Dooley (1):
      serial: make SiFive serial drivers depend on ARCH_ symbols

Cristian Ciocaltea (6):
      dt-bindings: serial: snps-dw-apb-uart: Switch dma-names order
      ARM: dts: sun6i: a31: Switch dma-names order for snps,dw-apb-uart nodes
      ARM: dts: sun8i: a23/a33: Switch dma-names order for snps,dw-apb-uart nodes
      ARM: dts: sun8i: v3s: Switch dma-names order for snps,dw-apb-uart nodes
      ARM: dts: sunxi: h3/h5: Switch dma-names order for snps,dw-apb-uart nodes
      riscv: dts: allwinner: d1: Switch dma-names order for snps,dw-apb-uart nodes

Daniel Starke (4):
      tty: n_gsm: add ioctl for DLC specific parameter configuration
      tty: n_gsm: allow window size configuration
      tty: n_gsm: add ioctl for DLC config via ldisc handle
      tty: n_gsm: fix redundant assignment of gsm->encoding

Doug Berger (1):
      serial: 8250_bcm7271: Fix arbitration handling

Douglas Anderson (2):
      serial: uart_poll_init() should power on the UART
      tty: serial: qcom-geni-serial: Add a poll_init() function

Florian Fainelli (1):
      serial: 8250: Add missing wakeup event reporting

Greg Kroah-Hartman (2):
      Merge 6.3-rc3 into tty-next
      Merge 6.3-rc6 into tty-next

Hanno Böck (1):
      tty: Fix typo in LEGACY_TIOCSTI Kconfig description

Ilpo Järvinen (21):
      serial: Use ARRAY_SIZE() with iso7816 reserved array
      serial: Use B0 instead of implicit zero assumption
      serial: Remove extern from func prototypes in headers
      serial: Move uart_change_speed() earlier
      serial: Rename uart_change_speed() to uart_change_line_settings()
      serial: Make hw_stopped bool
      serial: Rename hw_stopped to old_hw_stopped & improve logic
      serial: Remove uart_wait_until_sent() forward declaration
      n_tty: Convert no_space_left to space_left boolean
      tty_ioctl: Use BIT() for internal flags
      Bluetooth: hci_ldisc: Fix tty_set_termios() return value assumptions
      n_tty: Sort includes alphabetically
      n_tty: Use DIV_ROUND_UP() in room calculation
      n_tty: Cleanup includes
      n_tty: Reindent if condition
      tty: Convert hw_stopped in tty_struct to bool
      serial: ucc_uart: Use uart_circ_empty()
      serial: cpm_uart: Use uart_circ_empty()
      tty: Prevent writing chars during tcsetattr TCSADRAIN/FLUSH
      serial: 8250: Fix serial8250_tx_empty() race with DMA Tx
      n_gsm: Use array_index_nospec() with index that comes from userspace

Jan Kundrát (1):
      serial: max310x: fix IO data corruption in batched operations

Jiri Slaby (SUSE) (6):
      tty: serial: simplify qcom_geni_serial_send_chunk_fifo()
      tty: synclink_gt: don't allocate and pass dummy flags
      tty: vt: reformat tioclinux()
      tty: vt: simplify some cases in tioclinux()
      tty: vt: distribute EXPORT_SYMBOL()
      tty: vt: drop checks for undefined VT_SINGLE_DRIVER

Johan Hovold (1):
      serial: fix TIOCSRS485 locking

Krzysztof Kozlowski (3):
      serial: sh-sci: mark OF related data as maybe unused
      serial: sprd: Drop of_match_ptr for ID table
      dt-bindings: serial: snps-dw-apb-uart: correct number of DMAs

Li zeming (1):
      tty: tty_ldisc: Remove the ret variable

Luis Chamberlain (1):
      tty: simplify sysctl registration

Lukas Bulwahn (2):
      tty: serial: remove obsolete config SERIAL_SAMSUNG_UARTS_4
      serial: sb1250-duart: clean up after SIBYTE_BCM1x55 removal

Marek Vasut (4):
      dt-bindings: serial: imx: Document optional DMA properties
      dt-bindings: serial: imx: Document mandatory clock properties
      serial: stm32: Remove unused struct stm32_port txdone element
      serial: stm32: Re-assert RTS/DE GPIO in RS485 mode only if more data are transmitted

Martin Blumenstingl (3):
      dt-bindings: serial: amlogic,meson-uart: Add compatible string for G12A
      tty: serial: meson: Add a new compatible string for the G12A SoC
      arm64: dts: meson-g12-common: Use the G12A UART compatible string

Peng Fan (1):
      dt-bindings: serial: fsl-lpuart: add optional power-domains property

Petr Mladek (1):
      Documentation/serial-console: Document the behavior when the last console= parameter is not used

Randy Dunlap (1):
      linux/vt_buffer.h: allow either builtin or modular for macros

Rob Herring (3):
      serial: Use of_property_present() for testing DT property presence
      serial: Use of_property_read_bool() for boolean properties
      dt-bindings: serial: Drop unneeded quotes

Shenwei Wang (1):
      tty: serial: fsl_lpuart: adjust buffer length to the intended size

Sherry Sun (1):
      tty: serial: fsl_lpuart: use UARTMODIR register bits for lpuart32 platform

Tom Rix (1):
      serial: imx: remove unused imx_uart_is_imx* functions

Tony Lindgren (2):
      serial: 8250: Reinit port->pm on port specific driver unbind
      serial: core: Disable uart_start() on uart_remove_one_port()

Uwe Kleine-König (1):
      serial: imx: Drop a few unneeded casts

 Documentation/admin-guide/serial-console.rst       |  36 +++-
 .../bindings/serial/amlogic,meson-uart.yaml        |  13 +-
 .../devicetree/bindings/serial/fsl-imx-uart.yaml   |  27 +++
 .../devicetree/bindings/serial/fsl-lpuart.yaml     |   3 +
 .../devicetree/bindings/serial/mediatek,uart.yaml  |   1 +
 .../bindings/serial/qcom,serial-geni-qcom.yaml     |   4 +-
 .../bindings/serial/renesas,em-uart.yaml           |   4 +-
 .../devicetree/bindings/serial/renesas,hscif.yaml  |   4 +-
 .../devicetree/bindings/serial/renesas,sci.yaml    |   4 +-
 .../devicetree/bindings/serial/renesas,scif.yaml   |   4 +-
 .../devicetree/bindings/serial/renesas,scifa.yaml  |   4 +-
 .../devicetree/bindings/serial/renesas,scifb.yaml  |   4 +-
 .../devicetree/bindings/serial/serial.yaml         |   4 +-
 .../bindings/serial/snps-dw-apb-uart.yaml          |   4 +-
 .../devicetree/bindings/serial/sprd-uart.yaml      |   4 +-
 .../bindings/serial/sunplus,sp7021-uart.yaml       |   4 +-
 Documentation/driver-api/tty/n_gsm.rst             |  20 ++
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  12 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |  10 +-
 arch/arm/boot/dts/sun8i-v3s.dtsi                   |   6 +-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |   8 +-
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  |  15 +-
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi  |  12 +-
 drivers/bluetooth/hci_ldisc.c                      |   8 +-
 drivers/char/pcmcia/synclink_cs.c                  |   6 +-
 drivers/mmc/core/sdio_uart.c                       |  10 +-
 drivers/tty/Kconfig                                |   2 +-
 drivers/tty/amiserial.c                            |   6 +-
 drivers/tty/mxser.c                                |   6 +-
 drivers/tty/n_gsm.c                                | 231 ++++++++++++++++++++-
 drivers/tty/n_tty.c                                |  43 ++--
 drivers/tty/serial/8250/8250.h                     |  12 ++
 drivers/tty/serial/8250/8250_bcm7271.c             |  18 +-
 drivers/tty/serial/8250/8250_core.c                |   1 +
 drivers/tty/serial/8250/8250_em.c                  | 113 ++++++++--
 drivers/tty/serial/8250/8250_port.c                |  11 +-
 drivers/tty/serial/Kconfig                         |  11 +-
 drivers/tty/serial/bcm63xx_uart.c                  |  38 ++++
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |   5 +-
 drivers/tty/serial/fsl_lpuart.c                    |  10 +-
 drivers/tty/serial/imx.c                           |  48 ++---
 drivers/tty/serial/max310x.c                       |  17 +-
 drivers/tty/serial/meson_uart.c                    |   8 +-
 drivers/tty/serial/mxs-auart.c                     |   4 +-
 drivers/tty/serial/qcom_geni_serial.c              |  11 +-
 drivers/tty/serial/sb1250-duart.c                  |   2 +-
 drivers/tty/serial/serial_core.c                   | 125 +++++------
 drivers/tty/serial/sh-sci.c                        | 115 +++++++---
 drivers/tty/serial/sh-sci.h                        |   3 +
 drivers/tty/serial/sprd_serial.c                   |   2 +-
 drivers/tty/serial/stm32-usart.c                   |   6 +-
 drivers/tty/serial/stm32-usart.h                   |   1 -
 drivers/tty/serial/sunzilog.c                      |   4 +-
 drivers/tty/serial/ucc_uart.c                      |   7 +-
 drivers/tty/synclink_gt.c                          |  24 +--
 drivers/tty/tty.h                                  |   2 +
 drivers/tty/tty_io.c                               |  24 +--
 drivers/tty/tty_ioctl.c                            |  54 +++--
 drivers/tty/tty_ldisc.c                            |   3 +-
 drivers/tty/vt/vt.c                                | 205 ++++++++----------
 include/linux/serial_8250.h                        |  45 ++--
 include/linux/serial_core.h                        |  15 +-
 include/linux/tty.h                                |   2 +-
 include/linux/vt_buffer.h                          |   2 +-
 include/uapi/linux/gsmmux.h                        |  17 +-
 65 files changed, 979 insertions(+), 505 deletions(-)
