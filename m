Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F015F6B29
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiJFQEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiJFQDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:03:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12895B2749
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 09:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665072227; x=1696608227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1YbzoiUXSvQWzBUraiDzjfmE9NvY0qFctz1F+7sN7Sw=;
  b=mdItGj5/ZlUGLztKQ4SN94mHK8pnNDvRGRwHfDW4BlB5uh2Y+2+nU0FL
   8VcHdRDuC+tKqvx6FDg2eF1eC7oHP97s/GyaFAVthSc1J2BLPoVtfpJC0
   JNfdzv/jMTUKGYSrCJCMIIGvJkjC8rjs0NaG1bJYtVwBJ8Mo8JHO13z9c
   4XuT096EDmbsJp+7aboFJZlJTASlcW6WmIJT7oYS0d3VzNzFfIuZ9sdk3
   nij9g9RztbJpHd5ufOY0kJZoQ5B96KMQUnyLmoFx9v1jUQd41BGWpYpKu
   ecUvmZg45mkJNPjNDZ54b48Awv9t0aNFYMcyAW1CeODXH/naj4CpU/g6Q
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="304480708"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="304480708"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 09:02:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="687486227"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="687486227"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga008.fm.intel.com with ESMTP; 06 Oct 2022 09:02:35 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Subject: [PATCH 3/6] x86/gsseg: make asm_load_gs_index() take an u16
Date:   Thu,  6 Oct 2022 08:40:38 -0700
Message-Id: <20221006154041.13001-4-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006154041.13001-1-xin3.li@intel.com>
References: <20221006154041.13001-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Let gcc know that only the low 16 bits of load_gs_index() argument
actually matter. It might allow it to create slightly better
code. However, do not propagate this into the prototypes of functions
that end up being paravirtualized, to avoid unnecessary changes.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/entry/entry_64.S            | 2 +-
 arch/x86/include/asm/special_insns.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9953d966d124..e0c48998d2fb 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -779,7 +779,7 @@ _ASM_NOKPROBE(common_interrupt_return)
 
 /*
  * Reload gs selector with exception handling
- * edi:  new selector
+ *  di:  new selector
  *
  * Is in entry.text as it shouldn't be instrumented.
  */
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 35f709f619fb..a71d0e8d4684 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -120,7 +120,7 @@ static inline void native_wbinvd(void)
 	asm volatile("wbinvd": : :"memory");
 }
 
-extern asmlinkage void asm_load_gs_index(unsigned int selector);
+extern asmlinkage void asm_load_gs_index(u16 selector);
 
 static inline void native_load_gs_index(unsigned int selector)
 {
-- 
2.34.1

