Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6005712628
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjEZMCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjEZMCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:02:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995B1198
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685102556; x=1716638556;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=otODm6fSyIq8c7+AJZ8asrN95Nkj2f3RcyBVXfKvSn4=;
  b=H9gOZfyJWutHlG4Rme4O5Q4y3pfs/tFt3YSHcF51SGYoV2zavaMnb0lZ
   LJe/4cK7hoHdPSOgKpb4uxdpnSgT64FR+M9yN9V+voGjfqnvBpwFgnk6P
   LR3mULUr2CKYfzHvK8lMhgB4ceKR4O2xIz2qkpQkO2AWpKPDj+WzGLsvA
   apasVk3H5UhdLLcwMwl+q9RFzNcHViCRRm9heEyxWBKnFjBjkrFPo9tof
   27sOpZdoN7sQwWeZcjeKhxN04wZ8LuG3nbj0ghQgMKJPtJySrNJWGyL3a
   sp8/WN9+zx8ShOZoBPhjn3j3q+k5ZJSBkp8Tp5Hyc/YRX9E2Iw44FgdJ+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="354201692"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="354201692"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 05:02:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="735987411"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="735987411"
Received: from fgarrona-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.208.169])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 05:02:32 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 150AC10C61D; Fri, 26 May 2023 15:02:30 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     decui@microsoft.com, rick.p.edgecombe@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 0/3] x86/tdx: Fix one more load_unaligned_zeropad() issue
Date:   Fri, 26 May 2023 15:02:22 +0300
Message-Id: <20230526120225.31936-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During review of TDX guests on Hyper-V patchset Dave pointed to the
potential race between changing page private/shared status and
load_unaligned_zeropad().

Fix the issue.

v2:
 - Add more info in commit message of the first patch.
 - Move enc_status_change_finish_noop() into a separate patch.
 - Fix typo in commit message and comment.

Kirill A. Shutemov (3):
  x86/mm: Allow guest.enc_status_change_prepare() to fail
  x86/tdx: Fix race between set_memory_encrypted() and
    load_unaligned_zeropad()
  x86/mm: Fix enc_status_change_finish_noop()

 arch/x86/coco/tdx/tdx.c         | 56 +++++++++++++++++++++++++++++++--
 arch/x86/include/asm/x86_init.h |  2 +-
 arch/x86/kernel/x86_init.c      |  4 +--
 arch/x86/mm/mem_encrypt_amd.c   |  4 ++-
 arch/x86/mm/pat/set_memory.c    |  3 +-
 5 files changed, 61 insertions(+), 8 deletions(-)

-- 
2.39.3

