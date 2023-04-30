Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7ED76F2B95
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 01:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjD3Xiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 19:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjD3Xip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 19:38:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36322E52;
        Sun, 30 Apr 2023 16:38:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C41A461519;
        Sun, 30 Apr 2023 23:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F8EC433EF;
        Sun, 30 Apr 2023 23:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682897922;
        bh=sL6MqR+hTOMHGlO2oPWT0FaW6lEAWRYIr5eJ4L3l/BA=;
        h=From:To:Cc:Subject:Date:From;
        b=ksODUJH6/4xq2NoV7pV18eJo5y8uTEyHLYzTY9yDGMnyv1xhQGiNmvR6SbAlxJPfU
         NDlZPi3UqurOuGDa14tJenDv3zbx1P45vmRXmRW2ictM6CgMGhrXDHGXbT9L4ThlUk
         HQrfWyb/Mmhqslp0jxk036V7CE79AKVKm53JUP4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.110
Date:   Mon,  1 May 2023 08:38:39 +0900
Message-Id: <2023050139-ashes-backstab-021f@gregkh>
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

I'm announcing the release of the 5.15.110 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/riscv/vm-layout.rst                           |    2 
 Makefile                                                    |    2 
 arch/arm64/kvm/mmu.c                                        |   47 +++-----
 arch/arm64/kvm/psci.c                                       |    2 
 arch/riscv/include/asm/fixmap.h                             |    8 +
 arch/riscv/include/asm/pgtable.h                            |    8 +
 arch/riscv/kernel/setup.c                                   |    6 -
 arch/riscv/mm/init.c                                        |   68 ++++++------
 drivers/base/dd.c                                           |    7 +
 drivers/gpu/drm/drm_fb_helper.c                             |    3 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |    5 
 drivers/pci/pci.c                                           |    3 
 drivers/pci/pci.h                                           |    2 
 drivers/pci/pcie/aspm.c                                     |   19 ---
 drivers/usb/serial/option.c                                 |    6 +
 net/bluetooth/hci_sock.c                                    |    9 +
 tools/testing/selftests/kselftest/runner.sh                 |   28 +++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh             |    2 
 18 files changed, 123 insertions(+), 104 deletions(-)

Alexandre Ghiti (3):
      riscv: Move early dtb mapping into the fixmap region
      riscv: Do not set initial_boot_params to the linear address of the dtb
      riscv: No need to relocate the dtb as it lies in the fixmap region

Arınç ÜNAL (1):
      USB: serial: option: add UNISOC vendor and TOZED LT70C product

Dan Carpenter (1):
      KVM: arm64: Fix buffer overflow in kvm_arm_set_fw_reg()

Daniel Vetter (1):
      drm/fb-helper: set x/yres_virtual in drm_fb_helper_check_var

David Matlack (1):
      KVM: arm64: Retry fault if vma_lookup() results become invalid

Greg Kroah-Hartman (1):
      Linux 5.15.110

Jisoo Jang (1):
      wifi: brcmfmac: slab-out-of-bounds read in brcmf_get_assoc_ies()

Kai-Heng Feng (1):
      PCI/ASPM: Remove pcie_aspm_pm_state_change()

Matthieu Baerts (1):
      selftests: mptcp: join: fix "invalid address, ADD_ADDR timeout"

Ruihan Li (1):
      bluetooth: Perform careful capability checks in hci_sock_ioctl()

SeongJae Park (1):
      selftests/kselftest/runner/run_one(): allow running non-executable files

Stephen Boyd (1):
      driver core: Don't require dynamic_debug for initcall_debug probe timing

