Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F7F676726
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 16:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjAUPa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 10:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjAUPa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 10:30:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5EE2C64D
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 07:30:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21C8460B20
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 15:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C4CC433D2;
        Sat, 21 Jan 2023 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674315025;
        bh=7MO+a3MxSZV3DH1SFVJb13q5c8+5TLoSq8GdGlwU92c=;
        h=Date:From:To:Cc:Subject:From;
        b=JS8iMJWA0MTQI/tVV9eFTiwlmPyhHp0DJNCDEjsWQhV8Bi3F2kCdAo4tieja5+lqR
         hsDi4Wh9LjcgqTjenDq6Jb5GajNwl2HU5WREuyYxkDZfz/mHy+TjfKuq3S5xK8l2X1
         d9cu5tU8yak7ZQKaPHTpPUfwxlF83zCUJ5XRs1kQ=
Date:   Sat, 21 Jan 2023 16:30:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.2-rc5
Message-ID: <Y8wFD5eLWHUzCuNJ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5dc4c995db9eb45f6373a956eb1f69460e69e6d4:

  Linux 6.2-rc4 (2023-01-15 09:22:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.2-rc5

for you to fetch changes up to 3daed6345d5880464f46adab871d208e1baa2f3a:

  VMCI: Use threaded irqs instead of tasklets (2023-01-20 13:24:11 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 6.2-rc5

Here are some small char/misc and other subsystem driver fixes for
6.2-rc5 to resolve a few reported issues.  They include:
  - long time pending fastrpc fixes (should have gone into 6.1, my
    fault.)
  - mei driver/bus fixes and new device ids
  - interconnect driver fixes for reported problems
  - vmci bugfix
  - w1 driver bugfixes for reported problems

Almost all of these have been in linux-next with no reported problems,
the rest have all passed 0-day bot testing in my tree and on the mailing
lists where they have sat too long due to me taking a long time to catch
up on my pending patch queue.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abel Vesa (2):
      misc: fastrpc: Fix use-after-free and race in fastrpc_map_find
      misc: fastrpc: Don't remove map on creater_process and device_release

Alexander Usyskin (2):
      mei: bus: fix unlink on bus in error path
      mei: me: add meteor lake point M DID

Dan Carpenter (1):
      misc: fastrpc: fix error code in fastrpc_req_mmap()

Elliot Berman (1):
      misc: fastrpc: Pass bitfield into qcom_scm_assign_mem

Greg Kroah-Hartman (1):
      Merge tag 'icc-6.2-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-linus

Ian Abbott (1):
      comedi: adv_pci1760: Fix PWM instruction handling

Khazhismel Kumykov (1):
      gsmi: fix null-deref in gsmi_get_variable

Konrad Dybcio (4):
      dt-bindings: interconnect: Add UFS clocks to MSM8996 A2NoC
      interconnect: qcom: msm8996: Provide UFS clocks to A2NoC
      interconnect: qcom: msm8996: Fix regmap max_register values
      interconnect: qcom: rpm: Use _optional func for provider clocks

Ola Jeppsson (1):
      misc: fastrpc: Fix use-after-free race condition for maps

Vishnu Dasa (1):
      VMCI: Use threaded irqs instead of tasklets

Yang Yingliang (2):
      w1: fix deadloop in __w1_remove_master_device()
      w1: fix WARNING after calling w1_process()

 .../devicetree/bindings/interconnect/qcom,rpm.yaml | 24 ++++++-
 drivers/comedi/drivers/adv_pci1760.c               |  2 +-
 drivers/firmware/google/gsmi.c                     |  7 +-
 drivers/interconnect/qcom/icc-rpm.c                |  2 +-
 drivers/interconnect/qcom/msm8996.c                | 19 +++--
 drivers/misc/fastrpc.c                             | 83 +++++++++++-----------
 drivers/misc/mei/bus.c                             | 12 ++--
 drivers/misc/mei/hw-me-regs.h                      |  2 +
 drivers/misc/mei/pci-me.c                          |  2 +
 drivers/misc/vmw_vmci/vmci_guest.c                 | 49 +++++--------
 drivers/w1/w1.c                                    |  6 +-
 drivers/w1/w1_int.c                                |  5 +-
 12 files changed, 122 insertions(+), 91 deletions(-)
