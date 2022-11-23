Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776C96364DF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbiKWPyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbiKWPxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:53:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ACB14D2C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:53:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23A31B82172
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CCBC433D6;
        Wed, 23 Nov 2022 15:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669218797;
        bh=Cf1pPy9spjKZfNQ4bVr0kU8uO6RvN+2GFsVuHB/+4NE=;
        h=Date:From:To:Cc:Subject:From;
        b=DANwlapDRmV9P/Zf2TbvK6mWFw8iU7tqXH0y/2TNLyqCOiYtAbAlC1GsPYWqt+sug
         s9Az3JA1R6oSJkC8T/2AkQOv5XiOlUJcALcjQcnmM+/xhjyKo5D/TvWbkJM5Zhgujg
         GQQxYunySFphu8xd5U1BbwUvXqh/1LIVTb4Q0so4wrzH8HsMijDSyOgnhf5r3lqWiG
         lbr4WzjIRjG+mTEvPV5rylZ3+Ku+oayekjFEEttDtBu1k9Jtuo7ngDeTyc6CdEU7oP
         ApmbChbjsIh6TtP7DBbp4lvEIBzYtVjFqYkEx7LzxGShrODJ72WMtun8qt5+1PxJDS
         DLVkduDB4usMQ==
Date:   Wed, 23 Nov 2022 17:53:13 +0200
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs pull request for kernel 6.2
Message-ID: <20221123155313.GA545312@ogabbay-vm-u20.habana-labs.com>
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

Hi Greg,

This is habanalabs pull request for the merge window of kernel 6.2.

There isn't any fancy stuff to talk about. There are some minor features and
enhancements, but most of the commits are multiple bug fixes, refactors, etc.

Full details are in the tag.

Thanks,
Oded

The following changes since commit 210a671cc30429c7178a332b1feb5ebc2709dcd6:

  Merge 6.1-rc6 into char-misc-next (2022-11-21 10:05:34 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2022-11-23

for you to fetch changes up to 19a17a9fb486b2961dbd7f3fff0d79a144c9a3b6:

  habanalabs: fix VA range calculation (2022-11-23 16:54:10 +0200)

----------------------------------------------------------------
This tag contains habanalabs driver changes for v6.2:

- New feature of graceful hard-reset. Instead of immediately killing the
  user-process when a command submission times out, we wait a bit and give
  the user-process notification and let it try to close things gracefully,
  with the ability to retrieve debug information.

- Enhance the EventFD mechanism. Add new events such as access to illegal
  address (RAZWI), page fault, device unavailable. In addition, change the
  event workqueue to be handled in a single-threaded workqueue.

- Allow the control device to work during reset of the ASIC, to enable
  monitoring applications to continue getting the data.

- Add handling for Gaudi2 with PCI revision 2.

- Reduce severity of prints due to power/thermal events.

- Change how we use the h/w to perform memory scrubbing in Gaudi2.

- Multiple bug fixes, refactors and renames.

----------------------------------------------------------------
Bharat Jauhari (1):
      habanalabs: use lower_32_bits()

Dafna Hirschfeld (2):
      habanalabs: replace 'pf' to 'prefetch'
      habanalabs: add RMWREG32_SHIFTED to set a val within a mask

Dani Liberman (11):
      habanalabs: refactor razwi event notification
      habanalabs: add page fault info uapi
      habanalabs: handle HBM MMU when capturing page fault data
      habanalabs/gaudi2: capture RAZWI information
      habanalabs/gaudi2: capture page fault data
      habanalabs: fix user mappings calculation in case of page fault
      habanalabs/gaudi: add razwi notify event
      habanalabs: use single threaded WQ for event handling
      habanalabs/gaudi: add page fault notify event
      habanalabs/gaudi2: add razwi notify event
      habanalabs/gaudi2: add page fault notify event

Dilip Puri (1):
      habanalabs/gaudi2: unsecure CBU_EARLY_BRESP registers

Koby Elbaz (1):
      habanalabs/gaudi2: remove privileged MME clock configuration

Marco Pagani (2):
      habanalabs: added return value check for hl_fw_dynamic_send_clear_cmd()
      habanalabs/gaudi2: added memset for the cq_size register

Oded Gabbay (3):
      habanalabs: Use simplified API for p2p dist calc
      habanalabs: check schedule_hard_reset correctly
      habanalabs: extend process wait timeout in device fine

Ofir Bitton (7):
      habanalabs: allow control device open during reset
      habanalabs: add warning print upon a PCI error
      habanalabs: remove redundant gaudi2_sec asic type
      habanalabs/gaudi2: add PCI revision 2 support
      habanalabs/gaudi2: implement fp32 not supported event
      habanalabs/gaudi2: classify power/thermal events as info
      habanalabs: fail driver load if EEPROM errors detected

Ohad Sharabi (5):
      habanalabs: fix using freed pointer
      habanalabs: allow setting HBM BAR to other regions
      habanalabs: avoid divide by zero in device utilization
      habanalabs: skip events info ioctl if not supported
      habanalabs: fix VA range calculation

Tal Cohen (3):
      habanalabs/gaudi2: add device unavailable notification
      habanalabs: verify no zero event is sent
      habanalabs: no consecutive err when user context is enabled

Tomer Tayar (22):
      habanalabs/gaudi2: fix module ID for RAZWI handling
      habanalabs: skip idle status check if reset on device release
      habanalabs: allow unregistering eventfd when device non-operational
      habanalabs: move reset workqueue to be under hl_device
      habanalabs/gaudi2: remove configurations to access the MSI-X doorbell
      habanalabs: add support for graceful hard reset
      habanalabs: add an option to control watchdog timeout via debugfs
      habanalabs/gaudi: use graceful hard reset for F/W events
      habanalabs/gaudi2: use graceful hard reset for F/W events
      habanalabs: use graceful hard reset for CS timeouts
      habanalabs: fix PCIe access to SRAM via debugfs
      habanalabs: fix print for out-of-sync and pkt-failure events
      habanalabs/gaudi: fix print for firmware-alive event
      habanalabs/gaudi2: don't enable entries in the MSIX_GW table
      habanalabs/gaudi2: return to reset upon SM SEI BRESP error
      habanalabs: reset device if still in use when released
      habanalabs: increase the size of busy engines mask
      habanalabs: fix rc when new CPUCP opcodes are not supported
      habanalabs: print context refcount value if hard reset fails
      habanalabs: don't put context in hl_encaps_handle_do_release_sob()
      habanalabs: clear non-released encapsulated signals
      habanalabs: make print of engines idle mask more readable

Yang Yingliang (1):
      habanalabs: fix return value check in hl_fw_get_sec_attest_data()

farah kassabri (4):
      habanalabs: zero ts registration buff when allocated
      habanalabs: fix firmware descriptor copy operation
      habanalabs/gaudi2: remove redundant firmware version check
      habanalabs/gaudi2: change memory scrub mechanism

 .../ABI/testing/debugfs-driver-habanalabs          |   7 +
 .../misc/habanalabs/common/command_submission.c    |  62 +-
 drivers/misc/habanalabs/common/context.c           |  54 +-
 drivers/misc/habanalabs/common/debugfs.c           |   5 +
 drivers/misc/habanalabs/common/device.c            | 452 ++++++++++++---
 drivers/misc/habanalabs/common/firmware_if.c       |  54 +-
 drivers/misc/habanalabs/common/habanalabs.h        | 127 ++--
 drivers/misc/habanalabs/common/habanalabs_drv.c    |  42 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |  70 ++-
 drivers/misc/habanalabs/common/memory.c            |  16 +-
 drivers/misc/habanalabs/common/mmu/mmu.c           |  24 +-
 drivers/misc/habanalabs/common/sysfs.c             |   4 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              | 124 ++--
 drivers/misc/habanalabs/gaudi2/gaudi2.c            | 643 ++++++++++++++-------
 drivers/misc/habanalabs/gaudi2/gaudi2P.h           |   2 -
 drivers/misc/habanalabs/gaudi2/gaudi2_security.c   |   1 +
 drivers/misc/habanalabs/goya/goya.c                |   4 +-
 .../include/gaudi2/gaudi2_async_events.h           |   1 +
 .../include/gaudi2/gaudi2_async_ids_map_extended.h |   4 +-
 .../habanalabs/include/hw_ip/pci/pci_general.h     |   7 +
 include/uapi/misc/habanalabs.h                     |  93 ++-
 21 files changed, 1267 insertions(+), 529 deletions(-)
