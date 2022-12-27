Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60C1656E41
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiL0TX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiL0TXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:23:55 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1644AD4C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672169035; x=1703705035;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uZ7JbsKph7sD9LTR4/Td2R9JUEkQAzXI3DkidxgRKrA=;
  b=HFM+OTMjJ4ti5ndArZFq6v+q2IVbA7MyM2u/mmn7YNbZio/EM9Niuki6
   mX+X66vx41BeFAGL7dfN3jXazTGcbjsc+bFQtMFpO3FhRbDjzH07+rd0D
   /6zTb0Roq58HnNqkWI4YWt58e0/nq7Q47I00rqXg5++AUV770zd9QdTiA
   TMfj3PpIZUbcB0/jOSssYG1Xv7nXyhdrBydKlskQtHRu/SvhS/cuzMTRQ
   bpUY/WSISYD6/6eY1hrEci0MAS/cbFjOW9MV7G7relfiwXxkfK2c9cyiY
   6mGnGhkEU2FdXXVc2MozWz28zaISpX6tDQuTSr+YQdcAW0Sd1nDxNuvC7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="407011163"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="407011163"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 11:23:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="777234191"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="777234191"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 11:23:54 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 0/6] Some fixes and cleanups for microcode
Date:   Tue, 27 Dec 2022 11:23:34 -0800
Message-Id: <20221227192340.8358-1-ashok.raj@intel.com>
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

This is a followup after earlier post [1]
First 2 patches have been merged, sending the rest of the patches after
addressing comments and adding Thomas's reviewed by.

Please review and consider applying.

Changes since last post.

v2:
 - Updated commit logs as suggested by Thomas and Boris
 - Added Reviewed-by Thomas, and Tony

[1]https://lore.kernel.org/lkml/20221129210832.107850-1-ashok.raj@intel.com/

Cheers,
Ashok

Ashok Raj (6):
  x86/microcode/core: Move microcode_check() to cpu/microcode/core.c
  x86/microcode/core: Take a snapshot before and after applying
    microcode
  x86/microcode: Display revisions only when update is successful
  x86/microcode/intel: Use a plain revision argument for
    print_ucode_rev()
  x86/microcode/intel: Print old and new rev during early boot
  x86/microcode/intel: Print when early microcode loading fails

 arch/x86/include/asm/processor.h      |  3 +-
 arch/x86/kernel/cpu/cpu.h             |  1 -
 arch/x86/kernel/cpu/common.c          | 32 --------------
 arch/x86/kernel/cpu/microcode/core.c  | 62 +++++++++++++++++++++++++--
 arch/x86/kernel/cpu/microcode/intel.c | 52 +++++++++++-----------
 5 files changed, 83 insertions(+), 67 deletions(-)


base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.34.1

