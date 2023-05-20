Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E296770A96D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 19:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjETRHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 13:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjETRH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 13:07:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEF713D;
        Sat, 20 May 2023 10:07:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 683226009E;
        Sat, 20 May 2023 17:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81614C433EF;
        Sat, 20 May 2023 17:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684602445;
        bh=wphMWIeArtEsSvlb8OAF/hjXa+qd9hNZT35tlKvo6ro=;
        h=Date:From:To:Cc:Subject:From;
        b=r5aDMt6DknXGaviLKge92fgS3pD/Hmb27zUeMozitoVV5yBBJegshSy+sWls8FsBY
         eNRNXCE4pT8AsBbD/tIi+YWIp6YRJaZYc0sl7JK3GS3znV8ma+bZoSnxfWST3o2hXV
         2XAZ+0SrdC3wzWREuZ3X4D3m6G0EZigGxolaRZo0=
Date:   Sat, 20 May 2023 18:07:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 6.4-rc3
Message-ID: <ZGj-S_GkMqxVBlDe@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.4-rc3

for you to fetch changes up to 8fb9ea65c9d1338b0d2bb0a9122dc942cdd32357:

  vc_screen: reload load of struct vc_data pointer in vcs_write() to avoid UAF (2023-05-13 20:01:13 +0900)

----------------------------------------------------------------
TTY/Serial fixes for 6.4-rc3

Here are some small tty and serial driver fixes for 6.4-rc3 to resolve
some reported problems, and add some new device ids.  These include:
  - termios documentation updates
  - vc_screen use-after-free fix
  - memory leak fix in arc_uart driver
  - new 8250 driver ids
  - other small serial driver fixes

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andrew Davis (1):
      serial: 8250_exar: Add support for USR298x PCI Modems

Doug Berger (2):
      serial: 8250_bcm7271: balance clk_enable calls
      serial: 8250_bcm7271: fix leak in `brcmuart_probe`

Geert Uytterhoeven (1):
      serial: 8250: Document termios parameter of serial8250_em485_config()

George Kennedy (1):
      vc_screen: reload load of struct vc_data pointer in vcs_write() to avoid UAF

Ke Zhang (1):
      serial: arc_uart: fix of_iomap leak in `arc_serial_probe`

Krzysztof Kozlowski (1):
      serial: qcom-geni: fix enabling deactivated interrupt

Vitaliy Tomin (1):
      serial: Add support for Advantech PCI-1611U card

 drivers/tty/serial/8250/8250_bcm7271.c |  7 +++++--
 drivers/tty/serial/8250/8250_exar.c    | 17 +++++++++++++++++
 drivers/tty/serial/8250/8250_pci.c     |  5 +++++
 drivers/tty/serial/8250/8250_port.c    |  1 +
 drivers/tty/serial/arc_uart.c          |  7 ++++---
 drivers/tty/serial/qcom_geni_serial.c  |  9 ++++-----
 drivers/tty/vt/vc_screen.c             | 11 +++++++++--
 7 files changed, 45 insertions(+), 12 deletions(-)
