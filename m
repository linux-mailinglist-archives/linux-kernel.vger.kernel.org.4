Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535FC68AF9E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 12:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjBELxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 06:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBELxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 06:53:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6722128A;
        Sun,  5 Feb 2023 03:53:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3A12B80B7C;
        Sun,  5 Feb 2023 11:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B07BC433EF;
        Sun,  5 Feb 2023 11:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675598018;
        bh=8uKoyJmBWvFr8Ye1clEqrh8+DypoYZR3LS7emY5Aerg=;
        h=Date:From:To:Cc:Subject:From;
        b=q8VnEvYcYzz2IqRolwBhWKp76T3uAG7yZm4J7rkZVQfv1srvAvq4Okw/SvFADBkt5
         az8U2CV4jZVitcNK/MRUpXGm8KrhWEXksf+dSQVsxq56+h8rgr3k8BxTVfnqwrRL/g
         5V1EXtmschuNKuIqSTxrowiIcochxf/lKCtFO/E0=
Date:   Sun, 5 Feb 2023 12:53:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 6.2-rc7
Message-ID: <Y9+Yv1CQKNP0Bwqq@kroah.com>
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

The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:

  Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.2-rc7

for you to fetch changes up to 226fae124b2dac217ea5436060d623ff3385bc34:

  vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF (2023-01-31 15:51:52 +0100)

----------------------------------------------------------------
TTY/Serial driver fixes for 6.2-rc7

Here are some small serial and vt fixes for 6.2-rc7.  These include:
  - 8250 driver fixes relating to dma issues
  - stm32 serial driver fix for threaded irqs
  - vc_screen bugfix for reported problems.

All have been in linux-next for a while with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
George Kennedy (1):
      vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF

Ilpo Järvinen (2):
      serial: 8250_dma: Fix DMA Rx completion race
      serial: 8250_dma: Fix DMA Rx rearm race

Marek Vasut (1):
      serial: stm32: Merge hard IRQ and threaded IRQ handling into single IRQ handler

 drivers/tty/serial/8250/8250_dma.c | 21 +++++++++++++++++----
 drivers/tty/serial/stm32-usart.c   | 33 +++++----------------------------
 drivers/tty/vt/vc_screen.c         |  9 +++++----
 3 files changed, 27 insertions(+), 36 deletions(-)
