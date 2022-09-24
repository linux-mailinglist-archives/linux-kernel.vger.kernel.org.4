Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8065E8A23
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiIXIXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiIXIXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:23:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2C325DE;
        Sat, 24 Sep 2022 01:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5123FB80ECF;
        Sat, 24 Sep 2022 08:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BE4C433C1;
        Sat, 24 Sep 2022 08:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664007824;
        bh=MJucUiBD2uBtXMibzIy7JKisKwfId+DiTuUh8qZjI2E=;
        h=Date:From:To:Cc:Subject:From;
        b=Lb7TDI122JO7DngyDuWU3FBPJ2q8itUYHEXjundcOdurEiGRpExcGwGHz/1WnAEwU
         r/zjYXQsYzFlDYN3buwjT9OajQWLElY2bLgOXXcb/J0+G+sFFCbqQN8h9HWrIrRGRR
         5UhTx5iqieOdQmMjdGvZJw5GRUbVbITnhXUWeTrw=
Date:   Sat, 24 Sep 2022 10:23:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 6.0-rc7
Message-ID: <Yy6+jsGstABsKP1X@kroah.com>
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

The following changes since commit 7e18e42e4b280c85b76967a9106a13ca61c16179:

  Linux 6.0-rc4 (2022-09-04 13:10:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.0-rc7

for you to fetch changes up to 643792048ee84b199052e9c8f89253649ca78922:

  serial: sifive: enable clocks for UART when probed (2022-09-22 16:38:18 +0200)

----------------------------------------------------------------
TTY/Serial driver fixes for 6.0-rc7

Here are some small, and late, serial driver fixes for 6.0-rc7 to
resolve some reported problems.

Included in here are:
	- tegra icount accounting fixes, including a framework function
	  that other drivers will be converted over to using in 6.1-rc1.
	- fsl_lpuart reset bugfix
	- 8250 omap 485 bugfix
	- sifive serial clock bugfix

The last 3 patches have not shown up in linux-next due to them being
added to my tree only 2 days ago, but they are tiny and self-contained
and the developers say they resolve issues that they have with 6.0-rc.
The other 3 have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ilpo Järvinen (3):
      serial: Create uart_xmit_advance()
      serial: tegra: Use uart_xmit_advance(), fixes icount.tx accounting
      serial: tegra-tcu: Use uart_xmit_advance(), fixes icount.tx accounting

Lukas Wunner (1):
      serial: fsl_lpuart: Reset prior to registration

Matthias Schiffer (1):
      serial: 8250: omap: Use serial8250_em485_supported

Olof Johansson (1):
      serial: sifive: enable clocks for UART when probed

 drivers/tty/serial/8250/8250_omap.c |  1 +
 drivers/tty/serial/fsl_lpuart.c     |  9 +++++----
 drivers/tty/serial/serial-tegra.c   |  5 ++---
 drivers/tty/serial/sifive.c         |  2 +-
 drivers/tty/serial/tegra-tcu.c      |  2 +-
 include/linux/serial_core.h         | 17 +++++++++++++++++
 6 files changed, 27 insertions(+), 9 deletions(-)
