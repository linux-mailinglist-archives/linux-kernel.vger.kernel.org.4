Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BFF681CF9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjA3Vka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjA3VkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:40:17 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3616A61
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675114815; x=1706650815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ribreiqlw4yvFYe7h9+NZncTm/1TctmT/8aknEK0LI=;
  b=OzKVkUvVnKeg3UpOE7lkzX6YYuk9bYTzvOPhiI62JK7ADrPzk5AAscOG
   tDeNwm1Y1SyBjGxiLswsMvFjlXIokpN84w9UQAB4WUaiSDOL+SA2wrVLj
   2gvJDu+G1MY0z38YOqeupWKzizGdJ1WJcN2GxkJYvjJcgcS0pykFUTTQj
   44xV6MPI8ZHcExcvGdj4JcohvJnj3sez+iMgbD56Y+/idHB7L+RUkJU8Z
   pMt1X2jYi6ET1dgm47ityTx043TE64Lg+wkDugmUt23DAEMO/D8OFz3JC
   XvF+fUI+d7N5ZWcNI9BfA7NYc9AtfKi1EraX7bR0i9ydOoofHjTCAZFqB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="328955504"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="328955504"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:40:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="696571863"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="696571863"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:40:12 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
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
Subject: [Patch v3 Part2 3/9] x86/microcode/intel: Fix collect_cpu_info() to reflect current microcode
Date:   Mon, 30 Jan 2023 13:39:49 -0800
Message-Id: <20230130213955.6046-4-ashok.raj@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230130213955.6046-1-ashok.raj@intel.com>
References: <20230130213955.6046-1-ashok.raj@intel.com>
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

Currently collect_cpu_info() is only returning what was cached earlier
instead of reading the current revision from the proper MSR.

Collect the current revision and report that value instead of reflecting
what was cached in the past.

[TBD:
    Need to change microcode/amd.c. I didn't quite follow the logic since
    it reports the revision from the patch file, instead of reporting the
    real PATCH_LEVEL MSR.

    Untested on AMD.
]

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
 arch/x86/kernel/cpu/microcode/intel.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 467cf37ea90a..de8e591c42cd 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -542,6 +542,13 @@ static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu_num);
 	unsigned int val[2];
+	int rev;
+
+	/*
+	 * intel_get_microcode_revision() reads a per-core MSR
+	 * to read the revision (MSR_IA32_UCODE_REV).
+	 */
+	WARN_ON_ONCE(cpu_num != smp_processor_id());
 
 	memset(csig, 0, sizeof(*csig));
 
@@ -553,7 +560,9 @@ static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
 		csig->pf = 1 << ((val[1] >> 18) & 7);
 	}
 
-	csig->rev = c->microcode;
+	rev = intel_get_microcode_revision();
+	c->microcode = rev;
+	csig->rev = rev;
 
 	return 0;
 }
-- 
2.37.2

