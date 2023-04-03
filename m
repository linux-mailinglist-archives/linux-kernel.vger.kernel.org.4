Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3866D4310
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjDCLLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjDCLLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:11:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E605423C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680520233; x=1712056233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=txlqjFMOsvS5xVXf0Recvi0uKBTdvCldZTwjgTHY5/8=;
  b=kGMAzK0fLwFaTBtjjpMyhYe16k38+9jX4V4UzF5f121T2w9NNcFQlBTK
   ltNEWE8aRNX/7fxBL+a2LwMtWACWwM1rlTzrU1isW/H3FYAiaMuBiTDx3
   AP/JxLLI+v51Wj9gTnb6ytfeVeaUN0HsjBH2CH1uwM66coByZN3C47mjZ
   cV1kbaRizUsJt56XTPAxfPV7G5zzvIP9Rr+scxr9yDTi1jkIodi/Y7w1F
   AYVqyKQM8Kbi/rBl1PwxNNnXL7e744DQkidpPYooBFcQt0ypYakvOVUdM
   591XatCXscfwHhUUn0ZR8NK0Yms2nskSOLcMiUhb8dbYinal0Cg8Q89mo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="330440411"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="330440411"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 04:10:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="860164460"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="860164460"
Received: from amomin-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.210.227])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 04:10:26 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E86BE10DFD1; Mon,  3 Apr 2023 14:10:23 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 1/2] x86/mm/iommu/sva: Fix error code for LAM enabling failure due to SVA
Date:   Mon,  3 Apr 2023 14:10:19 +0300
Message-Id: <20230403111020.3136-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230403111020.3136-1-kirill.shutemov@linux.intel.com>
References: <20230403111020.3136-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally, LAM and SVA are mutually exclusive. LAM enabling will fail if
SVA is already in use.

Correct error code for the failure. EINTR is nonsensical there.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 23e5d9ec2bab ("x86/mm/iommu/sva: Make LAM and SVA mutually exclusive")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
---
 arch/x86/kernel/process_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 74c7e84a94d8..c7dfd727c9ec 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -760,7 +760,7 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 
 	if (mm_valid_pasid(mm) &&
 	    !test_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &mm->context.flags))
-		return -EINTR;
+		return -EINVAL;
 
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
-- 
2.39.2

