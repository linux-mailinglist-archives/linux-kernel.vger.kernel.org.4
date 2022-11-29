Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4497B63CA15
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 22:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbiK2VJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 16:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbiK2VJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:09:01 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F982736
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 13:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669756140; x=1701292140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7tuAWLRdz0/2lENrf/P+AEpsaJQQPuE6XYNFGrl2k3o=;
  b=NL0mjAPVCKXN4sY/QEnHlYfbGCDYwYhLYagMnjs5FGjzVLA8+CFIKs+s
   WniqRT7whijVuba7Jz9IsTv+7+3jCVlo6kkRcl20blkMzdNhq2NHFEqxG
   Dhy+3vLC+OpudiXby4Yy43EYoVd+FXbFzQ7zwGYKETVDvEyaw7ojKGCLD
   N4uOkhOcYqyBjevkVxRFUA0+4DuulA++Z4TXuM/qcfFve6ZD0Ts4ZQoH0
   o+FBwq3S+/URBk9OUqGcbP6kkUKFVeX2IjiIVrd3cVpqRY5ZJ2Ne3qi14
   nc+xqAvAQVTOYRnvWxg9M8jBixk0BVfCzLyW0kLVg2tcjarzQ86LXlL48
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="317083122"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="317083122"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 13:09:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="646066168"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="646066168"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 13:08:59 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, alison.schofield@intel.com,
        reinette.chatre@intel.com
Subject: [Patch V1 0/7] x86/microcode: Some cleanups and fixes for microcode
Date:   Tue, 29 Nov 2022 13:08:25 -0800
Message-Id: <20221129210832.107850-1-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris

These are based on tip/x86/microcode after the recent IFS merge. 

As discussed in IRC, feel free to massage/rework/re-organize them in a way
that you intend to see them. 

Patch1: Fixes a minor race in pr_info due to a recent change in
	microcode_init() sequence.

Patch2: Remove microcode apply retries that cause a hang when loading
	fails.

Patch3: Prep patch for patch4, since its only used in core.c make it local
	there.

Patch4: Take a snapshot of x86 features before and after microcode update,
	instead of using the one from boot_cpu already cached.

Patch5: prepare early print to simplify patch 6 and 7.

Patch6: Print old and new rev after early loading. Its useful to know what
	BIOS version of the patchrev was.

Patch7: Print a message when early loading fails. Currently there is no
	message to user.

Ashok Raj (7):
  x86/microcode/intel: Remove redundant microcode rev pr_info()s
  x86/microcode/intel: Remove retries on early microcode load
  x86/microcode/core: Move microcode_check() to cpu/microcode/core.c
  x86/microcode/core: Take a snapshot before and after applying
    microcode
  x86/microcode/intel: Prepare the print_ucode_rev to simply take a rev
    to print
  x86/microcode/intel: Print old and new rev during early boot
  x86/microcode/intel: Print when early microcode loading fails

 arch/x86/include/asm/processor.h      |  3 +-
 arch/x86/kernel/cpu/cpu.h             |  1 -
 arch/x86/kernel/cpu/common.c          | 32 -------------
 arch/x86/kernel/cpu/microcode/core.c  | 49 +++++++++++++++++++-
 arch/x86/kernel/cpu/microcode/intel.c | 67 +++++++++++----------------
 5 files changed, 75 insertions(+), 77 deletions(-)


base-commit: 1a63b58082869273bfbab1b945007193f7bd3a78
-- 
2.34.1

