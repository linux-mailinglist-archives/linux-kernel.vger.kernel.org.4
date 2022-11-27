Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C433639B37
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 15:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiK0OER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 09:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiK0OEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 09:04:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2F81004E;
        Sun, 27 Nov 2022 06:04:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66572B80ADD;
        Sun, 27 Nov 2022 14:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E44C433C1;
        Sun, 27 Nov 2022 14:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669557852;
        bh=4bNVTJbFt80mnttNYrDImWd2gZShvy6+XtKhN9ZvMj4=;
        h=Date:From:To:Cc:Subject:From;
        b=vRmswTbkv1OQ45SGk7Bw7JE4FBQh0T2lGw4KzDLaxC450U4bGg0FTQ6ZFRxLnXOhD
         OUpzhJkODJpmbfH7t+2ac/dUgNrXiTzRUITlPsfrCspBsWM0e5c7khVDXWaVrQv+VE
         b7y0f27oNidgRB8zjLWFiBBb5OHceIOgB4SREFq8=
Date:   Sun, 27 Nov 2022 15:01:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.1-rc7
Message-ID: <Y4Nt1l1L+kuOTEfO@kroah.com>
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

The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.1-rc7

for you to fetch changes up to 7a21b27aafa3edead79ed97e6f22236be6b9f447:

  usb: cdnsp: fix issue with ZLP - added TD_SIZE = 1 (2022-11-22 16:52:05 +0100)

----------------------------------------------------------------
USB fixes for 6.1-rc7

Here are some small USB fixes for 6.1-rc7 that resolve some reported
problems:
	- cdnsp driver fixes for reported problems
	- dwc3 fixes for some small reported problems
	- uvc gadget driver fix for reported regression due to changes
	  in 6.1-rc1.

All of these have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Marek Szyprowski (1):
      usb: dwc3: exynos: Fix remove() function

Michael Grzeschik (1):
      usb: gadget: uvc: also use try_format in set_format

Pawel Laszczak (2):
      usb: cdnsp: Fix issue with Clear Feature Halt Endpoint
      usb: cdnsp: fix issue with ZLP - added TD_SIZE = 1

Thinh Nguyen (2):
      usb: dwc3: gadget: Disable GUSB2PHYCFG.SUSPHY for End Transfer
      usb: dwc3: gadget: Clear ep descriptor last

 drivers/usb/cdns3/cdnsp-gadget.c       | 12 ++----
 drivers/usb/cdns3/cdnsp-ring.c         | 17 +++++---
 drivers/usb/dwc3/dwc3-exynos.c         | 11 +-----
 drivers/usb/dwc3/gadget.c              | 15 +++----
 drivers/usb/gadget/function/uvc_v4l2.c | 72 ++++++++++------------------------
 5 files changed, 46 insertions(+), 81 deletions(-)
