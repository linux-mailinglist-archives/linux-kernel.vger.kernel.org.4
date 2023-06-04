Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081037216F9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjFDMe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFDMe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:34:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F283C4;
        Sun,  4 Jun 2023 05:34:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EABBE61119;
        Sun,  4 Jun 2023 12:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EABC4339C;
        Sun,  4 Jun 2023 12:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685882095;
        bh=VPuiAbVXnzzSjUdwZa0/ZBK9EReoHrt56iDrrh2Tl60=;
        h=From:To:Cc:Subject:Date:From;
        b=YOxvSeSF3qei8M2VFy4OYaRY+MFCwPusu/4irw2zK9Po8GO+9zBZ0J9TJMXkYye7g
         2agfQDaDqKVqq58h4YMYHedEY3F2DRQMBuej/aXdqet4M+X4HFhmshF7uGPTBgCXRd
         ZFH5bn40LiGgI99j9aDkYxqP8ZjZIPChJCq4fEa8Gb2vAANYc1VCxgT6U2DKqgDNq6
         WJoSGYhp3IFUUIdycPvqAEY7aOPQim2YVWuE+IVHIgYmonoSUEW0ILzVXuYCGC+9Tu
         gwlOZxKT5ZyDffvAGFSPtrLB16LwkrtpsdgYdSQO5Kd2KqIaDoYtcOSnqrD2Up0sjm
         o7CCHz04u1a5g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q5mww-0001DS-FN; Sun, 04 Jun 2023 14:35:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corey Minyard <minyard@acm.org>
Subject: [PATCH v2 0/3] USB: serial: return errors from break handling
Date:   Sun,  4 Jun 2023 14:35:02 +0200
Message-Id: <20230604123505.4661-1-johan@kernel.org>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series starts returning errors from break handling and also uses
that mechanism to report to user space when break signalling is not
supported (e.g. when device or driver support is missing).

Note that the tty layer currently returns early but without reporting
errors when a tty driver does not support break signalling. The intent
expressed in commit 9e98966c7bb9 ("tty: rework break handling") from
2008 appears to be to allow missing support to be reported to user
space however.

Johan


Changes in v2
 - fix return of potentially uninitialised status variable in
   io_edgeport as reported by kernel test robot <lkp@intel.com> and Dan
   Carpenter:

   https://lore.kernel.org/all/202306031014.qzAY3uQ6-lkp@intel.com/


Johan Hovold (3):
  USB: serial: return errors from break handling
  USB: serial: cp210x: disable break signalling on CP2105 SCI
  USB: serial: report unsupported break signalling

 drivers/usb/serial/ark3116.c          |  7 +++--
 drivers/usb/serial/belkin_sa.c        | 12 ++++++---
 drivers/usb/serial/ch341.c            | 37 +++++++++++++++++----------
 drivers/usb/serial/cp210x.c           | 14 +++++++---
 drivers/usb/serial/digi_acceleport.c  |  7 ++---
 drivers/usb/serial/f81232.c           |  4 ++-
 drivers/usb/serial/f81534.c           |  4 ++-
 drivers/usb/serial/ftdi_sio.c         | 10 +++++---
 drivers/usb/serial/io_edgeport.c      |  6 +++--
 drivers/usb/serial/io_ti.c            |  9 +++++--
 drivers/usb/serial/keyspan.c          |  5 +++-
 drivers/usb/serial/keyspan_pda.c      |  8 ++++--
 drivers/usb/serial/mct_u232.c         |  6 ++---
 drivers/usb/serial/mos7720.c          |  9 ++++---
 drivers/usb/serial/mos7840.c          |  7 ++---
 drivers/usb/serial/mxuport.c          |  6 ++---
 drivers/usb/serial/pl2303.c           | 14 ++++++----
 drivers/usb/serial/quatech2.c         |  8 ++++--
 drivers/usb/serial/ti_usb_3410_5052.c | 10 +++++---
 drivers/usb/serial/upd78f0730.c       |  7 +++--
 drivers/usb/serial/usb-serial.c       |  4 +--
 drivers/usb/serial/usb_debug.c        | 13 +++++++---
 drivers/usb/serial/whiteheat.c        |  7 ++---
 drivers/usb/serial/xr_serial.c        |  4 +--
 include/linux/usb/serial.h            |  2 +-
 25 files changed, 147 insertions(+), 73 deletions(-)

-- 
2.39.3

