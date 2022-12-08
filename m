Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101DB647719
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiLHUQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiLHUQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:16:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC663C6CD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:16:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8FE4CCE244B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 20:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77710C433D2;
        Thu,  8 Dec 2022 20:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670530560;
        bh=r9HpB/mmg7ZftwCJizYWJ7Mosc/Pfu5PxDDbosk1GEE=;
        h=Date:From:To:cc:Subject:From;
        b=t2Zn0jqM8mCoj4Db2FjfdE0a+phsHsOT8J7XtdClDCjY4mlMbel7z88bEF1+bnkc+
         QKiUVPfZnIHEYF3CpFuk1jqAWdudf8+W4WVzxL/JhufoL60M7DdtjM7rPzNT5y4boS
         EDlWXMdEYy32f6AAvdAP0f6+tpXu0Hmo2ckymaPtBqIKdhr/1kHA1Hi3YYhsK5uQ6B
         FZXKE8hFZX0KqklajEAe3ARkGuJZTuMRPc7/2oWKSra14TRXnFEkXCq36HFs1hOA7K
         +EpQKFF05bMzJTUUeJwrtb8oBCbD0VCIxHjYCpLRmw/19ThZQffokK0gnIght3Ijo0
         dO1CS75UCSANw==
Date:   Thu, 8 Dec 2022 21:16:00 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID regression fix for 6.1
Message-ID: <nycvar.YFH.7.76.2212082109060.9000@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022120801

It contains a regression fix for handling Logitech HID++ devices and 
memory corruption fixes. More specifically:

=====
- regression fix (revert) for catch-all handling of Logitech HID++ 
  Bluetooth devices; there are devices that turn out not to work
  with this, and the root cause is yet to be properly understood. So we
  are dropping it for now, and it will be revisited for 6.2 or 6.3
  (Benjamin Tissoires)
- memory corruption fix in HID core (ZhangPeng)
- memory corruption fix in hid-lg4ff (Anastasia Belova)
- Kconfig fix for I2C_HID (Benjamin Tissoires)
- a few device-id specific quirks that piggy-back on top of the
  important fixes above
=====

Thanks.

----------------------------------------------------------------
Anastasia Belova (1):
      HID: hid-lg4ff: Add check for empty lbuf

Ankit Patel (1):
      HID: usbhid: Add ALWAYS_POLL quirk for some mice

Benjamin Tissoires (3):
      HID: fix I2C_HID not selected when I2C_HID_OF_ELAN is
      Revert "HID: logitech-hidpp: Remove special-casing of Bluetooth devices"
      Revert "HID: logitech-hidpp: Enable HID++ for all the Logitech Bluetooth devices"

Hans de Goede (1):
      HID: ite: Enable QUIRK_TOUCHPAD_ON_OFF_REPORT on Acer Aspire Switch V 10

José Expósito (2):
      HID: uclogic: Fix frame templates for big endian architectures
      HID: uclogic: Add HID_QUIRK_HIDINPUT_FORCE quirk

ZhangPeng (1):
      HID: core: fix shift-out-of-bounds in hid_report_raw_event

 drivers/hid/hid-core.c           |  3 +++
 drivers/hid/hid-ids.h            |  4 ++++
 drivers/hid/hid-ite.c            |  5 +++++
 drivers/hid/hid-lg4ff.c          |  6 ++++++
 drivers/hid/hid-logitech-hidpp.c | 28 +++++++++-------------------
 drivers/hid/hid-quirks.c         |  3 +++
 drivers/hid/hid-uclogic-core.c   |  1 +
 drivers/hid/hid-uclogic-rdesc.c  |  2 +-
 drivers/hid/i2c-hid/Kconfig      |  4 ++--
 9 files changed, 34 insertions(+), 22 deletions(-)

-- 
Jiri Kosina
SUSE Labs

