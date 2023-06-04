Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4091C72157D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 10:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjFDIEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 04:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFDIEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 04:04:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCA6C1;
        Sun,  4 Jun 2023 01:04:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7127161004;
        Sun,  4 Jun 2023 08:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8387AC433EF;
        Sun,  4 Jun 2023 08:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685865885;
        bh=FD5UZJWbiM66i/2hLXln1xZgVD4iXBzBlTznz/ANaLs=;
        h=Date:From:To:Cc:Subject:From;
        b=2PNGPPkgwvWpMmUjN1adeRjf/elL/7FNYUq+iRXhSclGvg3tAYEDrnhNAj7zom/u0
         6USe2XQYESyIgxPU2mhuyws/mH4QBdya9bhkiRzXgvvtZq9KKI3JpKrsOi70FWNsd1
         8VqV3GJp/fUB9EGItOgeH2t8l4Q07cadY98y92f8=
Date:   Sun, 4 Jun 2023 10:04:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 6.4-rc5
Message-ID: <ZHxFm2rPU9WaxXbL@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 44c026a73be8038f03dbdeef028b642880cf1511:

  Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.4-rc5

for you to fetch changes up to 403e97d6ab2cb6fd0ac1ff968cd7b691771f1613:

  dt-bindings: serial: 8250_omap: add rs485-rts-active-high (2023-06-01 19:04:00 +0100)

----------------------------------------------------------------
TTY/Serial driver fixes for 6.4-rc5

Here are some small tty/serial driver fixes for 6.4-rc5 that have all
been in linux-next this past week with no reported problems.  Included
in here are:
  - 8250_tegra driver bugfix
  - fsl uart driver bugfixes
  - Kconfig fix for dependancy issue
  - dt-bindings fix for the 8250_omap driver

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Christophe JAILLET (1):
      serial: 8250_tegra: Fix an error handling path in tegra_uart_probe()

Francesco Dolcini (1):
      dt-bindings: serial: 8250_omap: add rs485-rts-active-high

Herve Codina (2):
      soc: fsl: cpm1: Fix TSA and QMC dependencies in case of COMPILE_TEST
      serial: cpm_uart: Fix a COMPILE_TEST dependency

Sherry Sun (1):
      tty: serial: fsl_lpuart: use UARTCTRL_TXINV to send break instead of UARTCTRL_SBK

 .../devicetree/bindings/serial/8250_omap.yaml      |  1 +
 drivers/soc/fsl/qe/Kconfig                         |  4 +-
 drivers/tty/serial/8250/8250_tegra.c               |  4 +-
 drivers/tty/serial/Kconfig                         |  2 +-
 drivers/tty/serial/cpm_uart/cpm_uart.h             |  2 -
 drivers/tty/serial/fsl_lpuart.c                    | 44 +++++++++++-----------
 6 files changed, 30 insertions(+), 27 deletions(-)
