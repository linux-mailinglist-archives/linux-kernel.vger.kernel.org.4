Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC155FA41C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiJJTYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJJTXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:23:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA7161122
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665429832; x=1696965832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1YbzoiUXSvQWzBUraiDzjfmE9NvY0qFctz1F+7sN7Sw=;
  b=KF/BsLxVUqNcvSh9O6XYW+Dwq9eCiyKu3WSMqda1hQ1eUjSLMCi5pO24
   M7i3KBkGscKVtwEmKGP2nLu65MNHABFxxMh0RSqk1g0TENsOHKzx7Tpga
   Ygyfo2ioNJn/WzcWoxTpPtKAd8mRSGhRXYUwmd+va7eDi3z2VhBoCdnpi
   lPdMszg+NMZt36HSHt2+EPfEn44TgNbvPPIRn/FI2y792rKDYlzl8ZMh/
   UsCBuhqNzfYjwbvl/WrR3NbT2y1AjcOYWFpQvdgdpGhTYuEXK0DGR+ntx
   LvSTgF+VwogvvpsJG7M2pz158Rippc658EgXQ24iTiMIZh4jIJMjTP5bt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="284044533"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="284044533"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 12:23:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="694762692"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="694762692"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga004.fm.intel.com with ESMTP; 10 Oct 2022 12:23:50 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org
Subject: [PATCH v2 3/6] x86/gsseg: make asm_load_gs_index() take an u16
Date:   Mon, 10 Oct 2022 12:01:56 -0700
Message-Id: <20221010190159.11920-4-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221010190159.11920-1-xin3.li@intel.com>
References: <20221010190159.11920-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

