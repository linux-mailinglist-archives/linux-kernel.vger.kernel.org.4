Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280056DBAA3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 13:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjDHLuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 07:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjDHLuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 07:50:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4B1C65D;
        Sat,  8 Apr 2023 04:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5509660FB7;
        Sat,  8 Apr 2023 11:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C116C433D2;
        Sat,  8 Apr 2023 11:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680954584;
        bh=Yrxvd0UlYGBdP4AtBD9aFi6NhioiLpPtfkRJKygJKHM=;
        h=Date:From:To:Cc:Subject:From;
        b=Xu113TmKGYm2z1Rf7rxDDtpn6JuKMEo8LoTyyMybYcFHbWGUnWjFEH1Dg1v2kQtTd
         uYLlACKQNUwqK2XhKbsiOBuYa68Y9mak9hItzsq2+XP7SvTwRIXstNF6dkG/DxCbUB
         0bmy3+NmGsVzUh8T/nMkE647GOOqInZa/aSFovkU=
Date:   Sat, 8 Apr 2023 13:49:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 6.3-rc6
Message-ID: <ZDFU1R-GyuE-Gb4e@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.3-rc6

for you to fetch changes up to f92ed0cd9328aed918ebb0ebb64d259eccbcc6e7:

  tty: serial: sh-sci: Fix Rx on RZ/G2L SCI (2023-03-29 11:00:37 +0200)

----------------------------------------------------------------
TTY/Serial driver fixes for 6.3-rc6

Here are some small tty and serial driver fixes for some reported
problems:
  - fsl_uart driver bugfixes
  - sh-sci serial driver bugfixes
  - renesas serial driver DT binding bugfixes
  - 8250 DMA bugfix

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Biju Das (2):
      tty: serial: sh-sci: Fix transmit end interrupt handler
      tty: serial: sh-sci: Fix Rx on RZ/G2L SCI

Geert Uytterhoeven (1):
      dt-bindings: serial: renesas,scif: Fix 4th IRQ for 4-IRQ SCIFs

Ilpo Järvinen (1):
      serial: 8250: Prevent starting up DMA Rx on THRI interrupt

Sherry Sun (2):
      tty: serial: fsl_lpuart: avoid checking for transfer complete when UARTCTRL_SBK is asserted in lpuart32_tx_empty
      tty: serial: fsl_lpuart: fix crash in lpuart_uport_is_active

 Documentation/devicetree/bindings/serial/renesas,scif.yaml |  4 ++--
 drivers/tty/serial/8250/8250_port.c                        | 11 +++++++++++
 drivers/tty/serial/fsl_lpuart.c                            | 10 ++++++++--
 drivers/tty/serial/sh-sci.c                                | 10 +++++++++-
 4 files changed, 30 insertions(+), 5 deletions(-)
