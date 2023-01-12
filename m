Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0A0666BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbjALHoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238542AbjALHoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:44:24 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6542540868
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 23:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673509463; x=1705045463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OY4mJD00oqqr2RtKHljKwaZ/6wONtTTVjhA0Ev1fnaU=;
  b=gc/JXR5ld2zLsbie2G+7xlg9QHANKReSHrb58iuWOZWXq5ROfqNJuAGn
   MexNFnCMACaODP5QL+1hm0FzwSYeWdvgiZEtVPeG6z6o0JaWONAHCn6/a
   wDdHwFQ5jZVE/yD8jhHVt5+W0HoaRfwxaeH5zFGeEW4xfyBRZcCjG/CF8
   uBenFzEa4JTKgWiZEbIfiSX4zjiTZjHHWBys4xk0l8kLCb0rXKT05qtQv
   UMNsxPukwCKBO9V/EzE1ATLsRbTSGQp3hBWdAXeeUjiSRUF0FlTgLA9/i
   fJW++FJ5IuxJho1hrHKUT6718jOyVhRRoTcMi73nxpSb/uajc97k0oRrZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="321328696"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="321328696"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 23:44:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="635283951"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="635283951"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orsmga006.jf.intel.com with ESMTP; 11 Jan 2023 23:44:22 -0800
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        brgerst@gmail.com, chang.seok.bae@intel.com, jgross@suse.com
Subject: [PATCH v6 3/5] x86/gsseg: make asm_load_gs_index() take an u16
Date:   Wed, 11 Jan 2023 23:20:30 -0800
Message-Id: <20230112072032.35626-4-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112072032.35626-1-xin3.li@intel.com>
References: <20230112072032.35626-1-xin3.li@intel.com>
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
index 15739a2c0983..7ecd2aeeeffc 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -782,7 +782,7 @@ _ASM_NOKPROBE(common_interrupt_return)
 
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

