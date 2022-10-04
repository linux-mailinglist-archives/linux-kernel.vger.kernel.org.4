Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322125F4105
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJDKti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJDKtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:49:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3B151A01;
        Tue,  4 Oct 2022 03:49:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 428166134B;
        Tue,  4 Oct 2022 10:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCED1C433D6;
        Tue,  4 Oct 2022 10:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664880571;
        bh=WZx3AhQrruYVU5EgWjYJvAbXRAVCAsaIDGGDmZIucpo=;
        h=From:To:Cc:Subject:Date:From;
        b=VAjkUhgd3x8zs1ewkJYK7XyeNOLa/ggmf8wTXTot8aHUbgaQ/NkjBzxQ3ZaDYv3Aq
         sXvkNSp0PkoA6E03p51EliEiVi1wYOr5dUOdTFevFv56MQ2dfju5ZVrHr2T3LSPj6a
         4ULiAeqU/04Cs5ofOvjB6DaWbMOP0EHLX/Coig89y7iflAWfBi9NSFdqEybZuyMM/L
         3Mkr7abpplpF4c4jB8l423gmgHw2G2fHc5QI6uXIx06bGZ7orqA918R4xDOiKIE0Kc
         rqdIBW4/EyIFBz5tlgeytCJQWqiS9fa1EIhgQSoO5cNN7posgzM8COa/EL2RcuNyKQ
         VZ8AqE/50xroA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Johan Hovold <johan@kernel.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 0/3] tty: TX helpers
Date:   Tue,  4 Oct 2022 12:49:24 +0200
Message-Id: <20221004104927.14361-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces uart_port_tx() + uart_port_tx_limited() TX
helpers. See PATCH 1/3 for the details.

The preparatory cleanups were already merged, so only the helpers above
and the switch: first, to uart_port_tx() in 2/3 and then
uart_port_tx_limited() in 3/3.

I know it's pre-rc1 time now. But there is no rush. Maybe
non-maintainers can take time to review now ;).

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Johan Hovold <johan@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Jiri Slaby (SUSE) (3):
  tty: serial: introduce transmit helpers
  tty: serial: use uart_port_tx() helper
  tty: serial: use uart_port_tx_limited()

 Documentation/driver-api/serial/driver.rst |  3 +
 drivers/tty/serial/21285.c                 | 32 ++-------
 drivers/tty/serial/altera_jtaguart.c       | 36 ++--------
 drivers/tty/serial/altera_uart.c           | 29 ++------
 drivers/tty/serial/amba-pl010.c            | 32 ++-------
 drivers/tty/serial/apbuart.c               | 34 ++-------
 drivers/tty/serial/atmel_serial.c          | 28 ++------
 drivers/tty/serial/bcm63xx_uart.c          | 47 +++----------
 drivers/tty/serial/fsl_lpuart.c            | 30 ++------
 drivers/tty/serial/lantiq.c                | 36 ++--------
 drivers/tty/serial/lpc32xx_hs.c            | 33 ++-------
 drivers/tty/serial/mcf.c                   | 34 +++------
 drivers/tty/serial/mpc52xx_uart.c          | 39 ++---------
 drivers/tty/serial/mps2-uart.c             | 26 ++-----
 drivers/tty/serial/mux.c                   | 45 ++++--------
 drivers/tty/serial/mvebu-uart.c            | 38 ++--------
 drivers/tty/serial/mxs-auart.c             | 32 +++------
 drivers/tty/serial/omap-serial.c           | 32 ++-------
 drivers/tty/serial/owl-uart.c              | 32 ++-------
 drivers/tty/serial/pxa.c                   | 33 ++-------
 drivers/tty/serial/rp2.c                   | 31 ++-------
 drivers/tty/serial/sa1100.c                | 34 ++-------
 drivers/tty/serial/serial_txx9.c           | 32 ++-------
 drivers/tty/serial/sifive.c                | 31 ++-------
 drivers/tty/serial/sprd_serial.c           | 33 ++-------
 drivers/tty/serial/st-asc.c                | 48 ++-----------
 drivers/tty/serial/vt8500_serial.c         | 30 ++------
 include/linux/serial_core.h                | 80 ++++++++++++++++++++++
 28 files changed, 228 insertions(+), 742 deletions(-)

-- 
2.37.3

