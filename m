Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2165264A800
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbiLLTPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiLLTP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:15:27 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAADD2D9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 11:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670872526; x=1702408526;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9aV9k8Blcc29JT0AD+oLbtKXYEbR3OZEG5vAyX9UFfY=;
  b=fz9DIAB+BJRG5+renoTYYi8sh5XtpV8Nptur8QkS/2vBlgwCGNE2PDFF
   ebFYDzjjgY0MrorCmUAjo0Flt45CKc0uv2fldJpgbELTRq7qndXS/w61n
   5AM7QsT3qtGhHgVIO05pzotGLZO8erlRLimZpQdgAI/YxQCZtbOrkGWZd
   SoqF+kFvHtdHba4j3fA42LhsWZ48hfZHAo9bodAvrOThOLS7Z8ZUKs2tF
   XN9CymT8Ty1uuKpmQqxitEY6n/9K04cJzcgs/2aMVMJkozbb4TYD/AnOG
   IqzayRbzREsJsT0dEPCPkxAtroGoDt+blzjvrcl0IR6xwiKvya5hYr2Oh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="319800688"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="319800688"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 11:15:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="641842094"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="641842094"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by orsmga007.jf.intel.com with ESMTP; 12 Dec 2022 11:15:25 -0800
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT PULL] x86/sgx for 6.2
Date:   Mon, 12 Dec 2022 11:15:25 -0800
Message-Id: <20221212191525.553277-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some x86/sgx changes for v6.2.

The biggest deal in this series is support for a new hardware feature
that allows enclaves to detect and mitigate single-stepping attacks.

There's also a minor performance tweak and a little piece of the
kmap_atomic()=>kmap_local() transition.

--

The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:

  Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_6.2

for you to fetch changes up to 89e927bbcd45d507e5612ef72fda04182e544a38:

  x86/sgx: Replace kmap/kunmap_atomic() calls (2022-12-02 14:59:56 +0100)

----------------------------------------------------------------
 * Introduce a new SGX feature (Asynchrounous Exit Notification)
   for bare-metal enclaves and KVM guests to mitigate single-step
   attacks
 * Increase batching to speed up enclave release
 * Replace kmap/kunmap_atomic() calls

----------------------------------------------------------------
Dave Hansen (1):
      x86/sgx: Allow enclaves to use Asynchrounous Exit Notification

Kai Huang (1):
      KVM/VMX: Allow exposing EDECCSSA user leaf function to KVM guest

Kristen Carlson Accardi (1):
      x86/sgx: Replace kmap/kunmap_atomic() calls

Reinette Chatre (1):
      x86/sgx: Reduce delay and interference of enclave release

 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/sgx.h         | 33 ++++++++++++++++++++++++++-------
 arch/x86/kernel/cpu/cpuid-deps.c   |  1 +
 arch/x86/kernel/cpu/scattered.c    |  1 +
 arch/x86/kernel/cpu/sgx/encl.c     | 35 +++++++++++++++++++++++++----------
 arch/x86/kernel/cpu/sgx/ioctl.c    |  6 +++---
 arch/x86/kernel/cpu/sgx/main.c     |  8 ++++----
 arch/x86/kvm/cpuid.c               |  6 ++----
 arch/x86/kvm/reverse_cpuid.h       |  3 +++
 9 files changed, 66 insertions(+), 28 deletions(-)
