Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850ED66A0ED
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjAMRn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjAMRnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:43:11 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1736C050
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673630974; x=1705166974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eF7Pboz7JZJBXxVsvwQjcSE5Pxeikn70RVh0Nt52pQs=;
  b=RC0sG3Mfu1d++/NIj3ZTlrlMYeT0RijgHt8mfwqYaaEKPzr+pTnLsgji
   QX9oZlkgCejlklVXhrRU8M1ybbVCoF6R8oOzu/cO5TB7ozHJ0zTemWqj9
   YawweHGpQRJQ5L1W4XzuIjmwoQSHI45bT+PxBD/9nX54LmzB2/XI16jo6
   CiNpFIPmyaJMBoFHLk39tcLYopw9LfRpmvV4yteyxfIlmcJqR5jv54I6d
   uNbRWCJYQJyD8gqmb1HK2y2xiwAZK1/2CY4h0aULjx7dwbUA8xxS3o9WX
   Ldm9eN6yC16WwOIA/tTCWTY8spmDzL26R2kYRAK1BUUR0AL1NwRAgeb8B
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="304430028"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="304430028"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:29:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="766089928"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="766089928"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:29:33 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ashok Raj <ashok.raj@intel.com>, Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: [PATCH v1 Part2 4/5] x86/microcode/intel: Drop wbinvd() from microcode loading
Date:   Fri, 13 Jan 2023 09:29:19 -0800
Message-Id: <20230113172920.113612-5-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113172920.113612-1-ashok.raj@intel.com>
References: <20230113172920.113612-1-ashok.raj@intel.com>
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

Some older processors had a bad interaction when updating microcode if the
caches were dirty causing machine checks. The wbinvd() was added to
mitigate that before performing microcode updates. Now that Linux checks
for the minimum version before performing an update, those microcode
revisions can't be loaded.

Remove calls to wbinvd().

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: x86 <x86@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner (Intel) <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Stefan Talpalaru <stefantalpalaru@yahoo.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Peter Zilstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andrew Cooper <Andrew.Cooper3@citrix.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index eba4f463ef1c..68a3c5569cd2 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -415,12 +415,6 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 		return UCODE_OK;
 	}
 
-	/*
-	 * Writeback and invalidate caches before updating microcode to avoid
-	 * internal issues depending on what the microcode is updating.
-	 */
-	native_wbinvd();
-
 	/* write microcode via MSR 0x79 */
 	native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
@@ -624,12 +618,6 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		goto out;
 	}
 
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

