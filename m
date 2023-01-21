Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA836769A1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 22:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjAUVfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 16:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjAUVf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 16:35:26 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A359E23C5A
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 13:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674336925; x=1705872925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=12y1YL1Y5qoTxYyqexFumwpishfssucSyiNGL/AKPlc=;
  b=deYoGTeW1fwQHBc/ySetJ/irV8ODII2Vmoc9eZ4r3bJ7eY+azMTuNV8w
   YXAQYNOlqu/sKLinhmSHzocdVsX1CGHJnCFzocy30pHgYdwuiZ2M7/kyF
   I0/jIyRcnM1tULq3h+OG7e+KyZl9rv9A25GhT9J4nRMMhWt0mrHGcGUOC
   mLwpmhmJVuQP3f9VBWWRwd00EfZvBEpLc1wUWe1243DFDDhcH0nWTojS4
   8KbI9pb8eAOEk+8NcvsmGynXRFG3RZD4AC24xqI8YIie1o8fq+070jFEi
   +HmP5m/ESK/1A8uMISciiz1TMlWgwdOrM35VmittSzW/htTvbdE0eTb5l
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="412066337"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="412066337"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 13:35:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="784946318"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="784946318"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 13:35:21 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
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
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>
Subject: [Part 2 v2[cleanup] 4/4] x86/microcode: Do not call apply_microde() on sibling threads
Date:   Sat, 21 Jan 2023 13:35:12 -0800
Message-Id: <20230121213512.251578-5-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230121213512.251578-1-ashok.raj@intel.com>
References: <87y1pygiyf.ffs@tglx>
 <20230121213512.251578-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microcode updates are applied at the core, and both threads of HT siblings
will notice the update.

During late-load, after the primary has updated the microcode, it also
reflects that in the per-cpu structure (cpuinfo_x86) holding the current
revision.

Since the sibling hasn't had a chance to update the per-cpu revision,
the current code calls apply_microcode() just as a way to verify and also
update the per-cpu revision number.

But in the odd case when primary returned with an error, the secondary will
try to perform a patchload and the primary has already been released to the
system. This could be problematic.

Replace apply_microcode() with a call to collect_cpu_info() and let that
call also update the per-cpu structure instead of returning the previously
cached values.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
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
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Martin Pohlack <mpohlack@amazon.de>
---
 arch/x86/kernel/cpu/microcode/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 6ade3d59c404..089636b1643f 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -386,6 +386,7 @@ static int __wait_for_cpus(atomic_t *t, long long timeout)
  */
 static int __reload_late(void *info)
 {
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	int cpu = smp_processor_id();
 	enum ucode_state err;
 	int ret = 0;
@@ -422,12 +423,11 @@ static int __reload_late(void *info)
 
 	/*
 	 * At least one thread has completed update on each core.
-	 * For others, simply call the update to make sure the
-	 * per-cpu cpuinfo can be updated with right microcode
-	 * revision.
+	 * For siblings, collect the cpuinfo and update the
+	 * per-cpu cpuinfo with the current microcode revision.
 	 */
 	if (cpumask_first(topology_sibling_cpumask(cpu)) != cpu)
-		err = microcode_ops->apply_microcode(cpu);
+		microcode_ops->collect_cpu_info(cpu, &uci->cpu_sig);
 
 	return ret;
 }
-- 
2.34.1

