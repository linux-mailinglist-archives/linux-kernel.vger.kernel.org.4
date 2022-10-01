Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F005F1DA2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJAQa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiJAQaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:30:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04DB252A3;
        Sat,  1 Oct 2022 09:30:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10A9B60C09;
        Sat,  1 Oct 2022 16:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C24EC433C1;
        Sat,  1 Oct 2022 16:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664641853;
        bh=6f+csY7OZYNwM7fcRJBVOOgsLox7bEazXJNpl71dCO4=;
        h=Date:From:To:Cc:Subject:From;
        b=uLrMfrsEq1yQ/k6qqZtRydpBsFkpktOEiba9JJb0ukLH6A+Cz/r+dur+zVESOWExA
         jtjmDLYJOa88FKH44FxAhjAPONyozP5e0KIgrV+H+UEeyZBSw28IoLuuC8TSiKuuzj
         BWGJfwqCNviLZy2O6FGddnqxDJ9zpWsIePmcBf1Y=
Date:   Sat, 1 Oct 2022 18:30:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt driver fixes for 6.0-final
Message-ID: <YzhrOlp3MwJzVpCh@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f76349cf41451c5c42a99f18a9163377e4b364ff:

  Linux 6.0-rc7 (2022-09-25 14:01:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.0-final

for you to fetch changes up to 0fb9703a3eade0bb84c635705d9c795345e55053:

  uas: ignore UAS for Thinkplus chips (2022-09-27 10:50:29 +0200)

----------------------------------------------------------------
USB/Thunderbolt fixes for 6.0-final

Here are some tiny USB and Thunderbolt driver fixes and quirks, for
6.0-final.

Included in here are:
	- 3 uas/usb-storage driver quirks to get the devices working
	  properly due to broken firmware images in them (they can not
	  run at high data rates, and are also throttled on other
	  operating systems because of this.)
	- thunderbolt bugfix for plug event delays
	- typec runtime warning removal
	- dwc3 st driver bugfix.  Note, a follow-on fix for this will
	  end up coming in for 6.1-rc1 as the developers are still
	  arguing over what the final solution will be, but this should
	  be sufficient for now.

All of these have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      Merge tag 'thunderbolt-for-v6.0' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus

Heikki Krogerus (1):
      usb: typec: ucsi: Remove incorrect warning

Hongling Zeng (3):
      uas: add no-uas quirk for Hiksemi usb_disk
      usb-storage: Add Hiksemi USB3-FW to IGNORE_UAS
      uas: ignore UAS for Thinkplus chips

Mario Limonciello (1):
      thunderbolt: Explicitly reset plug events delay back to USB4 spec value

Patrice Chotard (1):
      usb: dwc3: st: Fix node's child name

 drivers/thunderbolt/switch.c      |  1 +
 drivers/usb/dwc3/dwc3-st.c        |  2 +-
 drivers/usb/storage/unusual_uas.h | 21 +++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.c     |  2 --
 4 files changed, 23 insertions(+), 3 deletions(-)
