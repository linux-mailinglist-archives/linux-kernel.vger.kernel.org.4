Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256FE6186CC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiKCSAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbiKCR71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:59:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6EC219B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667498359; x=1699034359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0V5W1QoeZ7jgTpO6yb+rrh5iM/UlFsilbmyJNleFWWA=;
  b=ar9go5MU9n8Up/U4gf0nzQpEQzOMzRgdQfWwkvQgxEdfI0JCIxnUUh+y
   ytyrzLsBpQhk+CpOlxZCpfnMOdfZL8rK73Q0Gw4R26s6HWEh9F5KSDbZC
   gZzpY6o2B9fzkNua25EucdxRVJZ3kZHYcIQZOERvCGxmQWXvdl3JHuW9I
   pwr7pzHShrfILTGa5AebMSqo+zoBI5jErx1o86CxaYdSNWaeX46HnPdv4
   n7SVpAzbPRHnU96ILYt6wwN1JHaCeJG6dtQwZRkb1IYts+qHzXf0ZjGa1
   J1J3W28yKBeiEfTFSnMcEZ0ajZMJcK5uKyg34P6sKMLIfPcYZwAexKlD8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="310878483"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="310878483"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:19 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809762571"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="809762571"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:18 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [v2 11/13] x86/microcode/intel: Drop wbinvd() from microcode loading
Date:   Thu,  3 Nov 2022 17:58:59 +0000
Message-Id: <20221103175901.164783-12-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103175901.164783-1-ashok.raj@intel.com>
References: <20221103175901.164783-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some older processors had a bad interaction when updating microcode if the
caches were dirty causing machine checks. The wbinvd() was added to
mitigate that before performing microcode updates. Now that Linux checks
for the minimum version before performing an update, those microcode
revisions can't be loaded. Remove calls to wbinvd().

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 5d2ee76cd36c..7086670da606 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -541,11 +541,6 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 	}
 
 	old_rev = rev;
-	/*
-	 * Writeback and invalidate caches before updating microcode to avoid
-	 * internal issues depending on what the microcode is updating.
-	 */
-	native_wbinvd();
 
 	/* write microcode via MSR 0x79 */
 	native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
@@ -776,12 +771,6 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	if (!prev_rev)
 		prev_rev = rev;
 
-	/*
-	 * Writeback and invalidate caches before updating microcode to avoid
-	 * internal issues depending on what the microcode is updating.
-	 */
-	native_wbinvd();
-
 	/* write microcode via MSR 0x79 */
 	wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
-- 
2.34.1

