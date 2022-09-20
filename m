Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451705BDC39
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiITFU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiITFUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:20:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6494D4DD;
        Mon, 19 Sep 2022 22:20:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5090A1F8A4;
        Tue, 20 Sep 2022 05:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663651250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=d2A5fMQmjms2Sx4O1XUaS8Jg2w3M2p6OWk5+8JtwhCY=;
        b=wIP71jWXyPCFcpry5mSTPJ/0aRk0njEx940wGlzSXAL1DdmbKLnhxKpnCbeLRzL7FT13RS
        cBqHjaGujJ8MfM5PtmGtGKSQhCN3/A09PKHBDgt2A22nlFExJVzO3a1FhcnvvWIq2JFL92
        V7YdqY1/OGvLm9jiB4eMnmVnhNPyhxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663651250;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=d2A5fMQmjms2Sx4O1XUaS8Jg2w3M2p6OWk5+8JtwhCY=;
        b=fmFLmsti1LRRV06uzM8TSQpu/k7+mtCJdz5QJ+zO/Xl3YzTYxNnYMKJR03r+vGWZeZ6yl6
        n8LKpgz1HUG377Cg==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B559A2C141;
        Tue, 20 Sep 2022 05:20:49 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        Johan Hovold <johan@kernel.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: [PATCH v4 00/10] tty: TX helpers
Date:   Tue, 20 Sep 2022 07:20:40 +0200
Message-Id: <20220920052049.20507-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces uart_port_tx() + uart_port_tx_limited() TX
helpers. See PATCH 8/10 for the details. Comments welcome.

First the series performs simple cleanups, so that the later patches are
easier to follow.

Then it switches drivers to use them. First, to uart_port_tx() in 9/10
and then uart_port_tx_limited() in 10/10.

The diffstat of patches 9+10 is as follows:
 26 files changed, 145 insertions(+), 740 deletions(-)
which appears to be nice.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Johan Hovold <johan@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Jiri Slaby (10):
  tty: serial: move and cleanup vt8500_tx_empty()
  tty: serial: clean up stop-tx part in altera_uart_tx_chars()
  tty: serial: altera_uart_{r,t}x_chars() need only uart_port
  tty: serial: extract lqasc_tx_ready() from lqasc_tx_chars()
  tty: serial: extract tx_ready() from __serial_lpc32xx_tx()
  tty: serial: switch mpc52xx_uart_int_{r,t}x_chars() to bool
  tty: serial: extract serial_omap_put_char() from transmit_chars()
  tty: serial: introduce transmit helpers
  tty: serial: use uart_port_tx() helper
  tty: serial: use uart_port_tx_limited()

 Documentation/driver-api/serial/driver.rst |  3 +
 drivers/tty/serial/21285.c                 | 32 ++-------
 drivers/tty/serial/altera_jtaguart.c       | 40 +++--------
 drivers/tty/serial/altera_uart.c           | 41 +++--------
 drivers/tty/serial/amba-pl010.c            | 32 ++-------
 drivers/tty/serial/apbuart.c               | 34 ++-------
 drivers/tty/serial/atmel_serial.c          | 28 ++------
 drivers/tty/serial/bcm63xx_uart.c          | 47 +++----------
 drivers/tty/serial/fsl_lpuart.c            | 30 ++------
 drivers/tty/serial/lantiq.c                | 44 +++---------
 drivers/tty/serial/lpc32xx_hs.c            | 39 +++--------
 drivers/tty/serial/mcf.c                   | 28 ++------
 drivers/tty/serial/mpc52xx_uart.c          | 49 +++----------
 drivers/tty/serial/mps2-uart.c             | 26 ++-----
 drivers/tty/serial/mux.c                   | 45 ++++--------
 drivers/tty/serial/mvebu-uart.c            | 38 ++--------
 drivers/tty/serial/mxs-auart.c             | 32 +++------
 drivers/tty/serial/omap-serial.c           | 46 ++++---------
 drivers/tty/serial/owl-uart.c              | 32 ++-------
 drivers/tty/serial/pxa.c                   | 33 ++-------
 drivers/tty/serial/rp2.c                   | 31 ++-------
 drivers/tty/serial/sa1100.c                | 34 ++-------
 drivers/tty/serial/serial_txx9.c           | 32 ++-------
 drivers/tty/serial/sifive.c                | 31 ++-------
 drivers/tty/serial/sprd_serial.c           | 33 ++-------
 drivers/tty/serial/st-asc.c                | 48 ++-----------
 drivers/tty/serial/vt8500_serial.c         | 41 +++--------
 include/linux/serial_core.h                | 80 ++++++++++++++++++++++
 28 files changed, 264 insertions(+), 765 deletions(-)

-- 
2.37.3

