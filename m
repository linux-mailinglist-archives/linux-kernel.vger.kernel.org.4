Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C336C6759C2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjATQUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjATQTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:19:44 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E13429400
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674231582; x=1705767582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mcr2yb7ZiR1idAR8ZlgAQTtq4p4cCDWrTt1cLCmxsGY=;
  b=h2JSc0SAvWzTDBngDGV9o8YI7DRPqAl4spqq2ulV+9cZPU9d6PExfP9Z
   2lZlH/W0taU09oOIE+BIbOAyWbW3k+Xt+kZ0X1781pUak3jh6F8Q65m0j
   8hRI0jn4RIGm3BjLV1G22hwUqFlhOK4u8UNkjHEa/reCTMa4vLdkNo2hr
   ieZVhf3UXvhrt0C2vSU3drY6Lf7+ZIXbZrtgjHi+siKX1nmlBJmLZy36G
   LcpmITW2smRRyldjdnDtXkQtsJr0ad+prin+SOu8gnNyQitt1M3BmVH6f
   gytBhTgQslOfd2kaM+f3FAWR7hgJmyhc8q1i5/IzkDxC4s5TfVTTs8Vvn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="411846589"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="411846589"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 08:19:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="653836375"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="653836375"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 08:19:37 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Boris Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>
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
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [Patch v5 4/5] x86/microcode/intel: Use a plain revision argument for print_ucode_rev()
Date:   Fri, 20 Jan 2023 08:19:22 -0800
Message-Id: <20230120161923.118882-5-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120161923.118882-1-ashok.raj@intel.com>
References: <20230120161923.118882-1-ashok.raj@intel.com>
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

print_ucode_rev() takes a struct ucode_cpu_info argument. The sole purpose
of it is to print the microcode revision.

The only available ucode_cpu_info always describes the currently loaded
microcode revision. After a microcode update is successful, this is the new
revision, or on failure it is the original revision.

Subsequent changes need to print both the original and new revision, but
the original version will be cached in a plain integer, which makes the
code inconsistent.

Replace the struct ucode_cpu_info argument with a plain integer which
contains the revision number and adjust the call sites accordingly.

No functional change.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
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
---
Changes since v4:
Boris:
 - Removed unused variable mc, and fixed compile error in
   show_ucode_info_early()

Changes since V1:

Thomas:
 - Updated commit log as suggested
 - Remove the line break after static void before print_ucode_info
---
 arch/x86/kernel/cpu/microcode/intel.c | 32 ++++++++-------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 6bebc46ad8b1..146a60a9449a 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -310,13 +310,10 @@ static bool load_builtin_intel_microcode(struct cpio_data *cp)
 /*
  * Print ucode update info.
  */
-static void
-print_ucode_info(struct ucode_cpu_info *uci, unsigned int date)
+static void print_ucode_info(unsigned int new_rev, unsigned int date)
 {
 	pr_info_once("microcode updated early to revision 0x%x, date = %04x-%02x-%02x\n",
-		     uci->cpu_sig.rev,
-		     date & 0xffff,
-		     date >> 24,
+		     new_rev, date & 0xffff, date >> 24,
 		     (date >> 16) & 0xff);
 }
 
@@ -334,7 +331,7 @@ void show_ucode_info_early(void)
 
 	if (delay_ucode_info) {
 		intel_cpu_collect_info(&uci);
-		print_ucode_info(&uci, current_mc_date);
+		print_ucode_info(uci.cpu_sig.rev, current_mc_date);
 		delay_ucode_info = 0;
 	}
 }
@@ -343,33 +340,22 @@ void show_ucode_info_early(void)
  * At this point, we can not call printk() yet. Delay printing microcode info in
  * show_ucode_info_early() until printk() works.
  */
-static void print_ucode(struct ucode_cpu_info *uci)
+static void print_ucode(int new_rev, int date)
 {
-	struct microcode_intel *mc;
 	int *delay_ucode_info_p;
 	int *current_mc_date_p;
 
-	mc = uci->mc;
-	if (!mc)
-		return;
-
 	delay_ucode_info_p = (int *)__pa_nodebug(&delay_ucode_info);
 	current_mc_date_p = (int *)__pa_nodebug(&current_mc_date);
 
 	*delay_ucode_info_p = 1;
-	*current_mc_date_p = mc->hdr.date;
+	*current_mc_date_p = date;
 }
 #else
 
-static inline void print_ucode(struct ucode_cpu_info *uci)
+static inline void print_ucode(int new_rev, int date)
 {
-	struct microcode_intel *mc;
-
-	mc = uci->mc;
-	if (!mc)
-		return;
-
-	print_ucode_info(uci, mc->hdr.date);
+	print_ucode_info(new_rev, date);
 }
 #endif
 
@@ -409,9 +395,9 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 	uci->cpu_sig.rev = rev;
 
 	if (early)
-		print_ucode(uci);
+		print_ucode(uci->cpu_sig.rev, mc->hdr.date);
 	else
-		print_ucode_info(uci, mc->hdr.date);
+		print_ucode_info(uci->cpu_sig.rev, mc->hdr.date);
 
 	return 0;
 }
-- 
2.34.1

