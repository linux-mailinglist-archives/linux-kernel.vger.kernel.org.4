Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D546C027E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 15:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjCSO6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 10:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCSO6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 10:58:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38E79015;
        Sun, 19 Mar 2023 07:57:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E1DEB80B98;
        Sun, 19 Mar 2023 14:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E16C433EF;
        Sun, 19 Mar 2023 14:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679237877;
        bh=/83qcz18iITYSV8KY0Fu99uA55rhPgy2+8j370P3gqY=;
        h=Date:From:To:Cc:Subject:From;
        b=2gLRlU8I9P82AAaktRXXd6BMhutpRip0KKUHvbKeScBOlfNIwR7CPLZCizEmNmMa5
         fL4Oz+AglEEWjIA5yWiESokaxT8wu2KuOUxgrUhi3ZfRUkEvIAaSs4G0wxXlxFRHPz
         PJTPj/xrxpBUdKJD5O+Eta61H0TQF0i/++S0ghuY=
Date:   Sun, 19 Mar 2023 15:57:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 6.3-rc3
Message-ID: <ZBci7jg5l9X82rhf@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.3-rc3

for you to fetch changes up to 18365ebf23f3e713e5dd8e295c9a639295250f3c:

  tty: vt: protect KD_FONT_OP_GET_TALL from unbound access (2023-03-09 17:56:56 +0100)

----------------------------------------------------------------
TTY/Serial driver fixes for 6.3-rc3

Here are some small tty and serial driver fixes for 6.3-rc3 to resolve
some reported issues.

They include:
  - 8250 driver Kconfig issue pointed out by you that showed up in -rc1
  - qcom-geni serial driver fixes
  - various 8250 driver fixes for reported problems
  - fsl_lpuart driver fixes
  - serdev fix for regression in -rc1
  - vt.c bugfix

All have been in linux-next for over a week with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Sverdlin (1):
      tty: serial: fsl_lpuart: fix race on RX DMA shutdown

Biju Das (1):
      serial: 8250_em: Fix UART port type

Johan Hovold (5):
      serial: 8250_fsl: fix handle_irq locking
      serial: qcom-geni: fix console shutdown hang
      serial: qcom-geni: fix DMA mapping leak on shutdown
      serial: qcom-geni: fix mapping of empty DMA buffer
      serial: qcom-geni: drop bogus uart_write_wakeup()

Kumaravel Thiagarajan (1):
      serial: 8250_pci1xxxx: Disable SERIAL_8250_PCI1XXXX config by default

Randy Dunlap (1):
      serial: 8250: ASPEED_VUART: select REGMAP instead of depending on it

Samuel Thibault (1):
      tty: vt: protect KD_FONT_OP_GET_TALL from unbound access

Saravana Kannan (1):
      serdev: Set fwnode for serdev devices

Sherry Sun (1):
      tty: serial: fsl_lpuart: skip waiting for transmission complete when UARTCTRL_SBK is asserted

Tom Rix (1):
      Revert "tty: serial: fsl_lpuart: adjust SERIAL_FSL_LPUART_CONSOLE config dependency"

 drivers/tty/serdev/core.c             |  2 +-
 drivers/tty/serial/8250/8250_em.c     |  4 ++--
 drivers/tty/serial/8250/8250_fsl.c    |  4 ++--
 drivers/tty/serial/8250/Kconfig       |  4 ++--
 drivers/tty/serial/Kconfig            |  2 +-
 drivers/tty/serial/fsl_lpuart.c       | 23 ++++++++++++-----------
 drivers/tty/serial/qcom_geni_serial.c | 11 +++++++----
 drivers/tty/vt/vt.c                   |  3 +++
 8 files changed, 30 insertions(+), 23 deletions(-)
