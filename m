Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4850770A96B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 19:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjETRHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 13:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjETRHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 13:07:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D3D102;
        Sat, 20 May 2023 10:07:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C48B6009E;
        Sat, 20 May 2023 17:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BA1C433D2;
        Sat, 20 May 2023 17:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684602429;
        bh=dYwxFiHj7VpZzw4iuAW8YC1n/ifus0o7CunucL8QZUc=;
        h=Date:From:To:Cc:Subject:From;
        b=q//94LiIo/GU++SBwZPoY0NvF8FTjJNpVvTvIpPUxrUn0Y9/VfM/vZAvx/8lKlQH/
         4BEenl12CbSqJFv8oPLhPoS6HMj65h1ycw447ENllrU/m/PSHKoTuW+Hj3zvddZ4yT
         BIIxM3I43kJOOkA/yNiafYDnkQzeHgjsjq5KwVrI=
Date:   Sat, 20 May 2023 18:07:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt driver fixes for 6.4-rc3
Message-ID: <ZGj-OwflJxwZafmq@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.4-rc3

for you to fetch changes up to ddaf098ea779b3c1302c7843f6ff01e89b1fd380:

  driver core: class: properly reference count class_dev_iter() (2023-05-19 11:03:36 +0100)

----------------------------------------------------------------
USB/Thunderbolt fixes for 6.4-rc3

Here are some USB fixes for 6.4-rc3, as well as a driver core fix that
resolves a memory leak that shows up in USB devices easier than other
subsystems.

Included in here are:
  - driver core memory leak as reported and tested by syzbot and
    developers
  - dwc3 driver fixes for reported problems
  - xhci driver fixes for reported problems
  - USB gadget driver reverts to resolve regressions
  - usbtmc driver fix for syzbot reported problem
  - thunderbolt driver fixes for reported issues
  - other small USB fixes

All of these, except for the driver core fix, have been in linux-next
with no reported problems.  The driver core fix was tested and verified
to solve the issue by syzbot and the original reporter.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: usbtmc: Fix direction for 0-length ioctl control messages

Badhri Jagan Sridharan (1):
      usb: typec: altmodes/displayport: fix pin_assignment_show

Dan Carpenter (1):
      usb: dwc3: fix a test for error in dwc3_core_init()

Francesco Dolcini (2):
      Revert "usb: gadget: udc: core: Prevent redundant calls to pullup"
      Revert "usb: gadget: udc: core: Invoke usb_gadget_connect only when started"

Greg Kroah-Hartman (2):
      Merge tag 'thunderbolt-for-v6.4-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus
      driver core: class: properly reference count class_dev_iter()

Jó Ágila Bitsch (1):
      usb: gadget: drop superfluous ':' in doc string

Konrad Gräfe (1):
      usb: gadget: u_ether: Fix host MAC address case

Linyu Yuan (1):
      usb: dwc3: fix gadget mode suspend interrupt handler issue

Mario Limonciello (2):
      thunderbolt: Clear registers properly when auto clear isn't in use
      xhci-pci: Only run d3cold avoidance quirk for s2idle

Mathias Nyman (1):
      xhci: Fix incorrect tracking of free space on transfer rings

Maxime Bizon (1):
      usb-storage: fix deadlock when a scsi command timeouts more than once

Roger Quadros (2):
      usb: dwc3: gadget: Improve dwc3_gadget_suspend() and dwc3_gadget_resume()
      usb: typec: tps6598x: Fix fault at module removal

Udipto Goswami (1):
      usb: dwc3: debugfs: Resume dwc3 before accessing registers

Weitao Wang (1):
      USB: UHCI: adjust zhaoxin UHCI controllers OverCurrent bit value

 drivers/base/class.c                     |   2 +
 drivers/thunderbolt/nhi.c                |  29 +++++-
 drivers/thunderbolt/nhi_regs.h           |   2 +
 drivers/usb/class/usbtmc.c               |   2 +
 drivers/usb/dwc3/core.c                  |   2 +-
 drivers/usb/dwc3/core.h                  |   2 +
 drivers/usb/dwc3/debugfs.c               | 109 ++++++++++++++++++++++
 drivers/usb/dwc3/gadget.c                |  79 +++++++++-------
 drivers/usb/gadget/function/u_ether.c    |   3 +
 drivers/usb/gadget/udc/core.c            | 151 +++++++++----------------------
 drivers/usb/host/uhci-pci.c              |  10 +-
 drivers/usb/host/xhci-pci.c              |  12 ++-
 drivers/usb/host/xhci-ring.c             |  29 +++++-
 drivers/usb/host/xhci.h                  |   2 +-
 drivers/usb/storage/scsiglue.c           |  28 ++++--
 drivers/usb/typec/altmodes/displayport.c |   4 +
 drivers/usb/typec/tipd/core.c            |   3 +
 include/linux/device/class.h             |   1 +
 include/linux/usb/composite.h            |   2 +-
 19 files changed, 309 insertions(+), 163 deletions(-)
