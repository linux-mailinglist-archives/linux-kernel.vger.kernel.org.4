Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CDE74F0E9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjGKN7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjGKN7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:59:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8979E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:59:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08AB3614B0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64757C433C8;
        Tue, 11 Jul 2023 13:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689083980;
        bh=5Q/cLr//pqln6ZugD704AId3Sfa4ngej6SeKYBdfsnQ=;
        h=Date:From:To:Cc:Subject:From;
        b=bTkfJdZ/s5bVjkQYNS7XkXZgQ7Cn9okNmIzoTZ4I1UQH5iQJYJ244jzj0Sa5YB1Nx
         PZzaoK9nx8FojSjoDt/G80CVKuTARzI7v6U9wRMK9sa0uaCeklrsBEubxulrQI5UUs
         vI19mqOj4eLpadOdSMUBGhWTln3oXL9ip93o78sevaaMkEZiQZR/w9CgO+SSn3jrGZ
         RNeMLtV/PSMROZW/r/BzAzrqSDAI8j4e0yeIWk/3oCO8hzPuTpPS+x9FA6LQ9Fywy9
         IpaLvnt2ExrtqCY0i8GV9w+PXCem+2hzAPh3gIFh1SOSy/bNk9a/GSkNHbRjqXU/UP
         iOwEubhuvJ/LQ==
Date:   Tue, 11 Jul 2023 15:59:36 +0200
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <2baquyj3auwty3plwz5eazzs4nvpe2phzpatlqblsxxuf4scrr@2ouxku4kw5el>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023071101

to receive HID subsystem fixes, most importantly:

=====
- AMD SFH shift-out-of-bounds fix (Basavaraj Natikar)
- avoid struct memcpy overrun warning in the hid-hyperv module (Arnd Bergmann)
- a quick HID kselftests script fix for our CI to be happy (Benjamin Tissoires)
- various fixes and additions of device IDs
=====

Thanks.

----------------------------------------------------------------
Arnd Bergmann (1):
      HID: hyperv: avoid struct memcpy overrun warning

Basavaraj Natikar (2):
      HID: amd_sfh: Rename the float32 variable
      HID: amd_sfh: Fix for shift-out-of-bounds

Benjamin Tissoires (1):
      selftests: hid: fix vmtests.sh not running make headers

Dmitry Torokhov (1):
      HID: input: fix mapping for camera access keys

Rahul Rameshbabu (1):
      HID: nvidia-shield: Pack inner/related declarations in HOSTCMD reports

Stuart Hayhurst (1):
      HID: logitech-hidpp: Add wired USB id for Logitech G502 Lightspeed

 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c | 30 +++++++++++++++++++++++-------
 drivers/hid/hid-hyperv.c                      | 10 ++++------
 drivers/hid/hid-input.c                       |  7 ++++---
 drivers/hid/hid-logitech-hidpp.c              |  2 ++
 drivers/hid/hid-nvidia-shield.c               | 12 ++++++------
 tools/testing/selftests/hid/vmtest.sh         |  1 +
 6 files changed, 40 insertions(+), 22 deletions(-)

