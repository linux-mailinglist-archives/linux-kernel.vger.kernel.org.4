Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541DB72157B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 10:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjFDIDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 04:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFDIDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 04:03:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AD3C1;
        Sun,  4 Jun 2023 01:03:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D1086023A;
        Sun,  4 Jun 2023 08:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CEFC433EF;
        Sun,  4 Jun 2023 08:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685865813;
        bh=ifrmax7iPS0ThsC2vJ+kbR2JhaMl9gOFtky/NmZGJis=;
        h=Date:From:To:Cc:Subject:From;
        b=QQfvC5a9uZbPV0QhzWp7ywGOLQxbLxBrCHDSowsGgTXOwXaTe7JBuPAFeT8Bhqvh9
         8hsrAku0KPZIcL0Guz2/XorzBMDAPErT321Fr4Ent6uxkADX2AwckZl8Qb5fJx+efh
         vbfT6WNqVLPc8XHTSf8Pjv4FTDOBiKHa2fjIKGX0=
Date:   Sun, 4 Jun 2023 10:03:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.4-rc5
Message-ID: <ZHxFU2gVcgqYpx6m@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.4-rc5

for you to fetch changes up to fcfe84236ec0974fe92f0578d1d58ed805c4b70f:

  usb: typec: tps6598x: Fix broken polling mode after system suspend/resume (2023-05-30 15:29:41 +0100)

----------------------------------------------------------------
USB fixes for 6.4-rc5

Here are some USB driver and core fixes for 6.4-rc5.  Most of these are
tiny driver fixes, including:
  - udc driver bugfix
  - f_fs gadget driver bugfix
  - cdns3 driver bugfix
  - typec bugfixes

But the "big" thing in here is a fix yet-again for how the USB buffers
are handled from userspace when dealing with DMA issues.  The changes
were discussed a lot, and tested a lot, on the list, and acked by the
relevant mm maintainers and have been in linux-next all this past week
with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dan Carpenter (1):
      usb: gadget: udc: fix NULL dereference in remove()

Frank Li (1):
      usb: cdns3: fix NCM gadget RX speed 20x slow than expection at iMX8QM

Marek Vasut (1):
      dt-bindings: usb: snps,dwc3: Fix "snps,hsphy_interface" type

Roger Quadros (1):
      usb: typec: tps6598x: Fix broken polling mode after system suspend/resume

Ruihan Li (4):
      usb: usbfs: Enforce page requirements for mmap
      usb: usbfs: Use consistent mmap functions
      mm: page_table_check: Make it dependent on EXCLUSIVE_SYSTEM_RAM
      mm: page_table_check: Ensure user pages are not slab pages

Uttkarsh Aggarwal (1):
      usb: gadget: f_fs: Add unbind event before functionfs_unbind

 .../devicetree/bindings/usb/snps,dwc3.yaml         |  2 +-
 Documentation/mm/page_table_check.rst              | 19 ++++++++++
 drivers/usb/cdns3/cdns3-gadget.c                   | 13 +++++++
 drivers/usb/core/buffer.c                          | 41 ++++++++++++++++++++++
 drivers/usb/core/devio.c                           | 20 +++++++----
 drivers/usb/gadget/function/f_fs.c                 |  2 +-
 drivers/usb/gadget/udc/amd5536udc_pci.c            |  3 ++
 drivers/usb/typec/tipd/core.c                      |  2 +-
 include/linux/page-flags.h                         |  6 ++++
 include/linux/usb/hcd.h                            |  5 +++
 mm/Kconfig.debug                                   |  1 +
 mm/page_table_check.c                              |  6 ++++
 12 files changed, 111 insertions(+), 9 deletions(-)
