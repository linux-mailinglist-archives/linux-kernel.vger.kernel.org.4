Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B425F6B84
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiJFQXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJFQXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:23:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F8EA4B83
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 09:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665073419; x=1696609419;
  h=message-id:date:mime-version:from:to:subject:
   content-transfer-encoding;
  bh=4RHoqnlVO18S5RSifl3ytEVYHd+wpvwKV+XKQeCs98U=;
  b=CXKbCw/weKrZ8RBvqQPsLN4njznE2PzddwRsaAIWYBmN2FTIYKMW80TP
   Dcn2V/9rzfR5j/feN8hW+2kdojLMwpEMvoAKDObXEUVPLqk0fFc18N2fo
   37T+xGHjZHEyBXQT9FEy0mUWYFQJXEGjko7Cod8t+S/k60E1V/Xg7OSUW
   XV3AcSaDkPh5Ya+hoRoiYhEBNOnjtWE0ecV07AncAcayH9b/GDPAdT9po
   vW032miyLmYhHZWbaBE3EolV/EKR6FUmMXWqzPOAYMBOJbZiWNwAWWDa4
   CZQ5I274UfGSy3py0WSOiMAltjMPrkUgiSdC2NfsIhx7e6ptMkfg+0mjw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="365433862"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="365433862"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 09:23:38 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="624783842"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="624783842"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO [10.212.128.129]) ([10.212.128.129])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 09:23:37 -0700
Message-ID: <f42d43fd-30b0-e661-4b47-61ab15ef76ab@intel.com>
Date:   Thu, 6 Oct 2022 09:23:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
From:   Dave Hansen <dave.hansen@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/mm for 6.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some x86/mm changes for v6.1.  There are some small things
here, plus one big one.  The big one detected and refused to create W+X
kernel mappings.  This caused a bit of trouble and it is entirely
disabled on 32-bit due to known unfixable EFI issues.  It also oopsed
on some systemd eBPF use, which kept some users from booting.

The eBPF issue is fixed, but those troubles were caught relatively
recently which made me nervous that there are more lurking.  The final
commit in x86_mm_for_v6.1_rc1 retains the warnings, but doesn't
actually refuse to create W+X mappings.

--

The following changes since commit 42e66b1cc3a070671001f8a1e933a80818a192bf:

  Merge tag 'net-6.0-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2022-09-01 09:20:42 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_v6.1_rc1

for you to fetch changes up to c5129ecc12a3101555d8922b1e0aa90f91247ab6:

  x86/mm: Ease W^X enforcement back to just a warning (2022-10-04 12:53:52 -0700)

----------------------------------------------------------------

 * Detect insecure W+X mappings and warn about them, including a
   few bug fixes and relaxing the enforcement
 * Do a long-overdue defconfig update and enabling W+X boot-time
   detection
 * Cleanup _PAGE_PSE handling (follow-up on an earlier bug)
 * Rename a change_page_attr function

----------------------------------------------------------------
Borislav Petkov (1):
      x86/mm: Rename set_memory_present() to set_memory_p()

Dave Hansen (3):
      x86/mm/32: Fix W^X detection when page tables do not support NX
      x86/mm: Disable W^X detection and enforcement on 32-bit
      x86/mm: Ease W^X enforcement back to just a warning

Ingo Molnar (3):
      Merge branch 'linus' into x86/mm, to refresh the branch
      x86/defconfig: Refresh the defconfigs
      x86/defconfig: Enable CONFIG_DEBUG_WX=y

Linus Torvalds (1):
      x86/mm: Add prot_sethuge() helper to abstract out _PAGE_PSE handling

Peter Zijlstra (1):
      x86/mm: Refuse W^X violations

 arch/x86/configs/i386_defconfig   |  6 ++++--
 arch/x86/configs/x86_64_defconfig |  5 +++--
 arch/x86/mm/init_64.c             | 19 ++++++++++---------
 arch/x86/mm/pat/set_memory.c      | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 64 insertions(+), 15 deletions(-)

