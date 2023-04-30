Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692B26F2BA0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 01:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjD3Xl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 19:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjD3XlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 19:41:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2C2E5C;
        Sun, 30 Apr 2023 16:41:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87B2C60B4C;
        Sun, 30 Apr 2023 23:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA05C4339B;
        Sun, 30 Apr 2023 23:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682898084;
        bh=bMcH9D+Nz5vyKnodK9f5UNa8aKODK02EODiIpibRzxc=;
        h=From:To:Cc:Subject:Date:From;
        b=mKYDeYXrGwIRfNQCwRnc/J6rYv++Qoj+lqChedc1LbfMggmGwbW+m5xGHywE/KyLk
         8ppCdj+B+VqAWtR7cunxeE/2367EThxhf/OTD2k6wl9UgyLzK30SI/fmNKUYZN3cVT
         aTHAQqjKu14iTdqgVKDw7ttkEzFsm43vC57X5YxI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.2.14
Date:   Mon,  1 May 2023 08:41:20 +0900
Message-Id: <2023050120-coma-rift-e24b@gregkh>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.2.14 kernel.

All users of the 6.2 kernel series must upgrade.

The updated 6.2.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.2.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/riscv/vm-layout.rst                           |    6 
 Makefile                                                    |    2 
 arch/riscv/include/asm/fixmap.h                             |    8 
 arch/riscv/include/asm/pgtable.h                            |    8 
 arch/riscv/kernel/setup.c                                   |    6 
 arch/riscv/mm/init.c                                        |   82 +++-----
 arch/x86/Makefile.um                                        |   11 +
 drivers/base/dd.c                                           |    7 
 drivers/gpio/gpiolib-acpi.c                                 |   13 +
 drivers/gpu/drm/drm_fb_helper.c                             |    3 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c   |    9 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |    5 
 drivers/usb/serial/option.c                                 |    6 
 fs/btrfs/send.c                                             |    2 
 fs/btrfs/volumes.c                                          |    2 
 include/linux/mmc/sdio_ids.h                                |    5 
 kernel/rcu/tree.c                                           |   27 +-
 mm/mempolicy.c                                              |  115 +++++-------
 net/bluetooth/hci_sock.c                                    |    9 
 19 files changed, 193 insertions(+), 133 deletions(-)

Alexandre Ghiti (3):
      riscv: Move early dtb mapping into the fixmap region
      riscv: Do not set initial_boot_params to the linear address of the dtb
      riscv: No need to relocate the dtb as it lies in the fixmap region

Arınç ÜNAL (1):
      USB: serial: option: add UNISOC vendor and TOZED LT70C product

Daniel Vetter (1):
      drm/fb-helper: set x/yres_virtual in drm_fb_helper_check_var

David Gow (2):
      rust: arch/um: Disable FP/SIMD instruction to match x86
      um: Only disable SSE on clang to work around old GCC bugs

Genjian Zhang (1):
      btrfs: fix uninitialized variable warnings

Greg Kroah-Hartman (1):
      Linux 6.2.14

Jisoo Jang (1):
      wifi: brcmfmac: slab-out-of-bounds read in brcmf_get_assoc_ies()

Liam R. Howlett (1):
      mm/mempolicy: fix use-after-free of VMA iterator

Marek Vasut (1):
      wifi: brcmfmac: add Cypress 43439 SDIO ids

Ruihan Li (1):
      bluetooth: Perform careful capability checks in hci_sock_ioctl()

Stephen Boyd (1):
      driver core: Don't require dynamic_debug for initcall_debug probe timing

Werner Sembach (1):
      gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xNU

Ziwei Dai (1):
      rcu/kvfree: Avoid freeing new kfree_rcu() memory after old grace period

