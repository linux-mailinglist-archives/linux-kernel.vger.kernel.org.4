Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834185B3BE5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiIIPaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiIIP3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:29:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E887AB5326
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662737325; x=1694273325;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RuBa4e3QmLHKQ2j7H+ky5v61IXa2A+iP22YYziucdtU=;
  b=XrbQMOQXu0Vps2P9+lbUSIP0B///STxzn8vh0aEGct+AaXMW6FFiL5iA
   5XfKWmLGv/lQmXsrCybEbtTwzGIKTmylK9BFsINlVtuYTCcX/LCoeGUfN
   nBvHZsKPR40xCMKu+3sosYwNwlCaxm+cRGbndILUYbyV1QmX2cKh0Llb2
   Y2fdP4bjxUyTULiZEbSZWHJsLw2RUHw6SwbFi1OKXbO1Qgwvs3iSrTK4X
   hq5TCvvzfBqDLDUGLr4VfnPsen+mrv9slbnxFpyi5EeTnaFY19MuYUkp4
   cPjxL8hMpb7t+31mGg/3iRiIv78deODujxATtVFyUFtgvWEaeMSz/BhrS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="296236316"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="296236316"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 08:27:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="615303870"
Received: from viggo.jf.intel.com (HELO ray2.amr.corp.intel.com) ([10.54.77.144])
  by orsmga002.jf.intel.com with ESMTP; 09 Sep 2022 08:27:29 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        kernel test robot <yujie.liu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/mm: Set NX bit when making pages present
Date:   Fri,  9 Sep 2022 08:27:21 -0700
Message-Id: <20220909152721.1685334-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The x86 mm code now actively refuses to create writable, executable
mappings and warns when there is an attempt to create one.

0day ran across a case triggered by module unloading, but that looks
to be a generic problem.  It presumably goes like this:

	1. Load module with direct map, P=1,W=1,NX=1
	2. Map module executable, set P=1,W=0,NX=0
	3. Free module, land in vfree()->vm_remove_mappings()
	4. Set P=0 during alias processing, P=0,W=0,NX=0
	5. Restore kernel mapping via set_direct_map_default_noflush(),
	   set P=1,W=1, resulting in P=1,W=1,NX=0

That's clearly a writable, executable mapping which is a no-no.  The
new W^X code is clearly doing its job.

Fix it by actively setting _PAGE_NX when creating writable mappings.

One concern: I haven't been able to actually reproduce this, even by
loading and unloading the module that 0day hit it with.  I'd like to
be able to reproduce this before committing a fix.

Reported-by: kernel test robot <yujie.liu@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/all/fcf89147-440b-e478-40c9-228c9fe56691@intel.com/

--

0day folks, please do share these as they come up.  We want to keep
fixing them.
---
 arch/x86/mm/pat/set_memory.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 1a2d6376251c..5fb5874ea2c6 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2247,6 +2247,12 @@ static int __set_pages_p(struct page *page, int numpages)
 				.mask_clr = __pgprot(0),
 				.flags = 0};
 
+	/*
+	 * Avoid W^X mappings that occur if the old
+	 * mapping was !_PAGE_RW and !_PAGE_NX.
+	 */
+	pgprot_val(cpa.mask_set) |= __supported_pte_mask & _PAGE_NX;
+
 	/*
 	 * No alias checking needed for setting present flag. otherwise,
 	 * we may need to break large pages for 64-bit kernel text
-- 
2.34.1

