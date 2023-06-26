Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B3273EB35
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 21:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjFZTa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 15:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjFZTaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 15:30:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDD7E74
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 12:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687807852; x=1719343852;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qEzo2K0bbHOwosWcye5uApxGCWDZFso+NzL92l7ysaA=;
  b=OfTmUMquH8vEcGQft0Far+hRW8cXJTGtxYffkKZ3vfMTp552nZpYe/4R
   WYhOiQfbTpiO0moAO8Y2s4Kn3esN5cZkZ8wYnSKGMpmA4kbYuPpqZ7jeR
   8KR6NzZ35RDN152/4DmtC9jjPJ92KP0+AAECWCU3yiwIlGaSOszuCGRSg
   FJ7p3BP+uWGNW6hAfKNZ30xwDHYZaWhwVFPRAjloSuXjyz+4tzA/xvrrc
   0BzlZu1gq/zwfzVk96dsRNnnKZBFwfHnxUfnygsGoQInMyr6dZw7y/YLg
   hFTwceNE9ixOv2a0BJBUNSHccZ1dqJcQ9XGKm2PiepxHye+a8gq+TnwQu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="340954351"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="340954351"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 12:30:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="781572308"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="781572308"
Received: from viggo.jf.intel.com (HELO ray2.intel.com) ([10.54.77.144])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jun 2023 12:30:52 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/tdx for 6.5
Date:   Mon, 26 Jun 2023 12:30:50 -0700
Message-Id: <20230626193050.1532183-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some x86/tdx changes for 6.5.  This includes a very minor
cleanup and a fix for a race.  The race has never been observed in
practice but might allow load_unaligned_zeropad() to catch a TDX page
in the middle of its conversion process which would lead to a fatal
and unrecoverable guest shutdown.

--

The following changes since commit 44c026a73be8038f03dbdeef028b642880cf1511:

  Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.5

for you to fetch changes up to 94142c9d1bdf1c18027a42758ceb6bdd59a92012:

  x86/mm: Fix enc_status_change_finish_noop() (2023-06-06 16:24:27 -0700)

----------------------------------------------------------------
 - Fix a race window where load_unaligned_zeropad() could cause
   a fatal shutdown during TDX private<=>shared conversion
 - Annotate sites where VM "exit reasons" are reused as hypercall
   numbers.

----------------------------------------------------------------
Kirill A. Shutemov (3):
      x86/mm: Allow guest.enc_status_change_prepare() to fail
      x86/tdx: Fix race between set_memory_encrypted() and load_unaligned_zeropad()
      x86/mm: Fix enc_status_change_finish_noop()

Nikolay Borisov (1):
      x86/tdx: Wrap exit reason with hcall_func()

 arch/x86/boot/compressed/tdx.c    |  4 +--
 arch/x86/coco/tdx/tdx.c           | 62 ++++++++++++++++++++++++++++++---------
 arch/x86/include/asm/shared/tdx.h | 11 +++++++
 arch/x86/include/asm/x86_init.h   |  2 +-
 arch/x86/kernel/x86_init.c        |  4 +--
 arch/x86/mm/mem_encrypt_amd.c     |  4 ++-
 arch/x86/mm/pat/set_memory.c      |  3 +-
 7 files changed, 69 insertions(+), 21 deletions(-)
