Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EB272A267
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjFIShK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjFIShD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:37:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03893A81
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686335821; x=1717871821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Proxdl6OP+ssiJM42L+/0ZzD/+N45NVfmnXriOx5xto=;
  b=GdcwdBO2MszjDYqGJ7Lp3/i6ecGtP+G0GvT1FTBSzTtBqfDvuj6mRV6g
   obelZYy8t2OndJ11yJQJtk4pPQZYvFXpsQBEOBIa7NBFrSPSGbGOzU20u
   /BC44OuSJgyRNwE7P9rIOAxSaXYjzS5L0UK1hGIhVYzpgRSNJT4zY8u19
   dSwb8mXi/QUZkUO7CpPHhRr3fy2mauD6/KFsdLUGLjOKV8VPlWZX+uaYw
   wByqvFDFO8hMJLwRzpsi/uQOoRJRvwIjVe7oCBG9LzDs+SE05dVxI+SJo
   TaxfLLWXGkQNBRK+yB4dBPO7LDmeyrQtB5sK4rIp/b1RRizNEU8yZXePl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="338022090"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="338022090"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 11:37:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="710443967"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="710443967"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 09 Jun 2023 11:36:58 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v3 03/12] x86/alternatives: Disable LASS when patching kernel alternatives
Date:   Fri,  9 Jun 2023 21:36:23 +0300
Message-Id: <20230609183632.48706-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230609183632.48706-1-alexander.shishkin@linux.intel.com>
References: <20230609183632.48706-1-alexander.shishkin@linux.intel.com>
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

From: Sohil Mehta <sohil.mehta@intel.com>

For patching, the kernel initializes a temporary mm area in the lower
half of the address range. See commit 4fc19708b165 ("x86/alternatives:
Initialize temporary mm for patching").

Disable LASS enforcement during patching using the stac()/clac()
instructions to avoid triggering a #GP fault.

The objtool warns due to a call to a non-allowed function that exists
outside of the stac/clac guard, or references to any function with a
dynamic function pointer inside the guard. See the Objtool warnings
section #9 in the document tools/objtool/Documentation/objtool.txt.

Considering that patching is usually small, replace the memcpy and
memset functions in the text poking functions with their inline versions
respectively.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/kernel/alternative.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index f615e0cb6d93..eac6a5406d39 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1526,16 +1526,24 @@ static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
 __ro_after_init struct mm_struct *poking_mm;
 __ro_after_init unsigned long poking_addr;
 
+/*
+ * poking_init() initializes the text poking address from the lower half of the
+ * address space. Relax LASS enforcement when accessing the poking address.
+ */
 static void text_poke_memcpy(void *dst, const void *src, size_t len)
 {
-	memcpy(dst, src, len);
+	stac();
+	__inline_memcpy(dst, src, len);
+	clac();
 }
 
 static void text_poke_memset(void *dst, const void *src, size_t len)
 {
 	int c = *(const int *)src;
 
-	memset(dst, c, len);
+	stac();
+	__inline_memset(dst, c, len);
+	clac();
 }
 
 typedef void text_poke_f(void *dst, const void *src, size_t len);
-- 
2.39.2

