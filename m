Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06B664A7FF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiLLTQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiLLTPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:15:52 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0473714037
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 11:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670872543; x=1702408543;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yEHR0I6eITON7CTY8pY+SLLOzeWsZG+6wjqUP2S+NJQ=;
  b=MqRc4a/zfj/I/XqlOm2cRYrgM5HMJMmvz+Rb/HDiwBQwafh4c9f43Xab
   vcU3nRIPtVHqFlbBgjAzTklf4UEFlqJg/V1kFT2c+BeicmdkNJ6li0xYr
   t6C9JXeYSbDzzsQcSCU/pIcLbO/iR/8mcVL+JxeMM7TxFy8nfrkfHNhMr
   0Nr7gsURpTuvER3uRkdQb8CSr9jrX0i0pHoZXPVK23VblMJuYbph0/4Qa
   qb0SjyeKZiT6+kG4ejsh+2bN5lIbgDcZnOLLx/tufdTl59o9LCT06IdcW
   qYOP0lXmfk8HKuvBgcWWZfVa+GV5lPqPwe2z6vhQXnqxnL4+0PDGGX8OK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="317973436"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="317973436"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 11:15:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="716911546"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="716911546"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2022 11:15:24 -0800
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT PULL] x86/fpu for 6.2
Date:   Mon, 12 Dec 2022 11:15:24 -0800
Message-Id: <20221212191524.553255-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some x86/fpu changes for v6.2.  There are two little fixes
in here, one to give better XSAVE warnings and another to address
some undefined behavior in offsetof().

There is also a collection of patches to fix some issues with ptrace
and the protection keys register (PKRU).  PKRU is a real oddity because
it is exposed in the XSAVE-related ABIs, but it is generally managed
without using XSAVE in the kernel.  This fix thankfully came with a
selftest to ward off future regressions.

--

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fpu_for_6.2

for you to fetch changes up to 55228db2697c09abddcb9487c3d9fa5854a932cd:

  x86/fpu: Use _Alignof to avoid undefined behavior in TYPE_ALIGN (2022-11-22 17:13:03 +0100)

----------------------------------------------------------------
 * Clarify XSAVE consistency warnings
 * Fix up ptrace interface to protection keys register (PKRU)
 * Avoid undefined compiler behavior with TYPE_ALIGN

----------------------------------------------------------------
Andrew Cooper (1):
      x86/fpu/xstate: Fix XSTATE_WARN_ON() to emit relevant diagnostics

Kyle Huey (6):
      x86/fpu: Take task_struct* in copy_sigframe_from_user_to_xstate()
      x86/fpu: Add a pkru argument to copy_uabi_from_kernel_to_xstate().
      x86/fpu: Add a pkru argument to copy_uabi_to_xstate()
      x86/fpu: Allow PKRU to be (once again) written by ptrace.
      x86/fpu: Emulate XRSTOR's behavior if the xfeatures PKRU bit is not set
      selftests/vm/pkeys: Add a regression test for setting PKRU through ptrace

YingChi Long (1):
      x86/fpu: Use _Alignof to avoid undefined behavior in TYPE_ALIGN

 arch/x86/kernel/fpu/core.c                   |  19 ++--
 arch/x86/kernel/fpu/init.c                   |   7 +-
 arch/x86/kernel/fpu/regset.c                 |   2 +-
 arch/x86/kernel/fpu/signal.c                 |   2 +-
 arch/x86/kernel/fpu/xstate.c                 |  64 ++++++++++---
 arch/x86/kernel/fpu/xstate.h                 |   4 +-
 tools/testing/selftests/vm/pkey-x86.h        |  12 +++
 tools/testing/selftests/vm/protection_keys.c | 131 ++++++++++++++++++++++++++-
 8 files changed, 208 insertions(+), 33 deletions(-)
