Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC270676723
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 16:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjAUP33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 10:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjAUP31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 10:29:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B962CFDB;
        Sat, 21 Jan 2023 07:29:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D66760B3D;
        Sat, 21 Jan 2023 15:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCB8C433EF;
        Sat, 21 Jan 2023 15:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674314954;
        bh=5bscMmtzS4ZRjroRjKGURyNoErlZmoSg56KVpMFQZSM=;
        h=Date:From:To:Cc:Subject:From;
        b=mXe0uKol6PUWi+6v+ZEwGiSgMSyGViYjsaXWps/jf73Ed0/eYFxEczA3n/PMKiJ5A
         0kmK5xpWrwon3awi7rxzurwJXdsgNCYwxtFeA0abnHOGkLbqEFg+YGezLl74R9dGVo
         t50Onfrr6JIvoPjCvAx5JrMfzgSOjqrrQBa0aEow=
Date:   Sat, 21 Jan 2023 16:29:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 6.2-rc5
Message-ID: <Y8wEx5F+nUsgqj4Z@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5dc4c995db9eb45f6373a956eb1f69460e69e6d4:

  Linux 6.2-rc4 (2023-01-15 09:22:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.2-rc5

for you to fetch changes up to 14ee78d5932afeb710c8305196a676a715bfdea8:

  serial: exar: Add support for Sealevel 7xxxC serial cards (2023-01-20 13:38:38 +0100)

----------------------------------------------------------------
TTY/Serial driver fixes for 6.2-rc5

Here are some small tty and serial driver fixes for 6.2-rc5 that resolve
a number of tiny reported issues and some new device ids.  They include:
  - new device id for the exar serial driver
  - speakup tty driver bugfix
  - atmel serial driver baudrate fixup
  - stm32 serial driver bugfix and then revert as the bugfix broke the
    build.  That will come back in a later pull request once it is all
    worked out properly.
  - amba-pl011 serial driver rs486 mode bugfix
  - qcom_geni serial driver bugfix

Most of these have been in linux-next with no reported problems (well,
other than the build breakage which generated the revert), the new
device id passed 0-day testing.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      tty: serial: qcom_geni: avoid duplicate struct member init

Gaosheng Cui (1):
      tty: fix possible null-ptr-defer in spk_ttyio_release

Greg Kroah-Hartman (1):
      Revert "serial: stm32: Merge hard IRQ and threaded IRQ handling into single IRQ handler"

Ilpo Järvinen (1):
      serial: pch_uart: Pass correct sg to dma_unmap_sg()

Krzysztof Kozlowski (1):
      tty: serial: qcom-geni-serial: fix slab-out-of-bounds on RX FIFO buffer

Lino Sanfilippo (1):
      serial: amba-pl011: fix high priority character transmission in rs486 mode

Marek Vasut (1):
      serial: stm32: Merge hard IRQ and threaded IRQ handling into single IRQ handler

Matthew Howell (1):
      serial: exar: Add support for Sealevel 7xxxC serial cards

Tobias Schramm (1):
      serial: atmel: fix incorrect baudrate setup

 drivers/accessibility/speakup/spk_ttyio.c |  3 +++
 drivers/tty/serial/8250/8250_exar.c       | 14 ++++++++++++++
 drivers/tty/serial/amba-pl011.c           |  8 ++++----
 drivers/tty/serial/atmel_serial.c         |  8 +-------
 drivers/tty/serial/pch_uart.c             |  2 +-
 drivers/tty/serial/qcom_geni_serial.c     | 32 +++++++++++++++++++++++--------
 6 files changed, 47 insertions(+), 20 deletions(-)
