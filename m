Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E7F66100A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 16:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjAGPkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 10:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjAGPkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 10:40:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698B743D88;
        Sat,  7 Jan 2023 07:40:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DC71B81C25;
        Sat,  7 Jan 2023 15:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5805DC433D2;
        Sat,  7 Jan 2023 15:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673106018;
        bh=Lax4i1DBEu9IdmILnpLlQn/9dqPnK8vFctmNyrvcfJs=;
        h=Date:From:To:Cc:Subject:From;
        b=ovsEQv6kkDjActPtld+QWotM77yXqNXGKufTCgb0pdsib/Ehmtt+JfgcAtOwcNypd
         zDWvc+HYN3LIZX55AQX6x5Ye8foaYzCnG9d1yNi2+4unInjjfPUopdnXGtEYqm0Nbz
         bp4mLW+iSlRQAnyYRdmw+yfBPpvPt1/oC9ZLOM5w=
Date:   Sat, 7 Jan 2023 16:40:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.2-rc3
Message-ID: <Y7mSX5PfJ/2wEere@kroah.com>
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

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.2-rc3

for you to fetch changes up to c4e3ef5685393c5051b52cf1e94b8891d49793ab:

  usb: dwc3: gadget: Ignore End Transfer delay on teardown (2023-01-06 16:32:10 +0100)

----------------------------------------------------------------
USB fixes for 6.2-rc3

Here are some small USB driver fixes for 6.2-rc3 that resolve some
reported issues.  They include:
 - of-reported ulpi problem, so the offending commit is reverted
 - dwc3 driver bugfixes for recent changes
 - fotg210 fixes

Most of these have been in linux-next for a while, the last few were on
the mailing list for a long time and passed all the 0-day bot testing
so all should be fine with them as well.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (2):
      usb: fotg210: fix OTG-only build
      usb: dwc3: xilinx: include linux/gpio/consumer.h

Ferry Toth (1):
      Revert "usb: ulpi: defer ulpi_register on ulpi_read_id timeout"

Thinh Nguyen (1):
      usb: dwc3: gadget: Ignore End Transfer delay on teardown

Yang Yingliang (1):
      usb: fotg210-udc: fix error return code in fotg210_udc_probe()

 drivers/usb/common/ulpi.c          | 2 +-
 drivers/usb/dwc3/dwc3-xilinx.c     | 1 +
 drivers/usb/dwc3/gadget.c          | 5 ++++-
 drivers/usb/fotg210/fotg210-core.c | 5 +----
 drivers/usb/fotg210/fotg210-udc.c  | 2 ++
 5 files changed, 9 insertions(+), 6 deletions(-)
