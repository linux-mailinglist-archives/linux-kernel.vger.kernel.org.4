Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E3A62FC2E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242312AbiKRSHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbiKRSHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:07:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD557A34E;
        Fri, 18 Nov 2022 10:07:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78525B824E8;
        Fri, 18 Nov 2022 18:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED03DC433C1;
        Fri, 18 Nov 2022 18:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668794830;
        bh=JRgQbEpZ0RMwp2uvvwWa6pDC/KPMoVxtfGmsL0D4kqw=;
        h=Date:From:To:Cc:Subject:From;
        b=E27fsi49wTCfdVZwbEGB1YdksFqgHCF6a7kDMML0Ct+fjdR1Gp51qEDSdadJLrR5K
         DBfA0svoOx/IrdnvRAIvQPUl6om9hJzQuBjgC81y8J63k4pamBZLD1d1cFHJHO26PZ
         NOMeBh4TetcaUhdkyY3PnXLBXHAlJJak3L4FrkDM=
Date:   Fri, 18 Nov 2022 19:07:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 6.1-rc6
Message-ID: <Y3fJy1m1WHFAO05t@kroah.com>
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

The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:

  Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.1-rc6

for you to fetch changes up to 3ec17cb325ac731c2211e13f7eaa4b812694e218:

  docs/driver-api/miscellaneous: Remove kernel-doc of serial_core.c (2022-11-09 14:56:05 +0100)

----------------------------------------------------------------
TTY/Serial driver fixes for 6.1-rc6

Here are a number of small tty and serial driver fixes for 6.1-rc6.
They all resolve reported problems:
	- kernel doc build problems with the -rc1 serial driver
	  documentation update
	- n_gsm reported problems
	- imx serial driver missing callback
	- lots of tiny 8250 driver fixes for reported issues.

All of these have been in linux-next for over a week with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Akira Yokosawa (1):
      docs/driver-api/miscellaneous: Remove kernel-doc of serial_core.c

Duoming Zhou (1):
      tty: n_gsm: fix sleep-in-atomic-context bug in gsm_control_send

Fedor Pchelkin (2):
      Revert "tty: n_gsm: avoid call of sleeping functions from atomic context"
      Revert "tty: n_gsm: replace kicktimer with delayed_work"

Ilpo Järvinen (4):
      serial: 8250: Fall back to non-DMA Rx if IIR_RDI occurs
      serial: 8250_lpss: Configure DMA also w/o DMA filter
      serial: 8250_lpss: Use 16B DMA burst with Elkhart Lake
      serial: 8250: Flush DMA Rx on RLSI

Lukas Wunner (1):
      serial: 8250: 8250_omap: Avoid RS485 RTS glitch on ->set_termios()

Matthias Schiffer (1):
      serial: 8250_omap: remove wait loop from Errata i202 workaround

Shawn Guo (1):
      serial: imx: Add missing .thaw_noirq hook

Sherry Sun (1):
      tty: serial: fsl_lpuart: don't break the on-going transfer when global reset

Tony Lindgren (3):
      serial: 8250: omap: Fix missing PM runtime calls for omap8250_set_mctrl()
      serial: 8250: omap: Fix unpaired pm_runtime_put_sync() in omap8250_remove()
      serial: 8250: omap: Flush PM QOS work on remove

 Documentation/driver-api/miscellaneous.rst |  5 +-
 drivers/tty/n_gsm.c                        | 71 +++++++++++++++-------------
 drivers/tty/serial/8250/8250_lpss.c        | 17 +++++--
 drivers/tty/serial/8250/8250_omap.c        | 52 +++++++++++---------
 drivers/tty/serial/8250/8250_port.c        |  7 ++-
 drivers/tty/serial/fsl_lpuart.c            | 76 +++++++++++++++++++-----------
 drivers/tty/serial/imx.c                   |  1 +
 7 files changed, 138 insertions(+), 91 deletions(-)
