Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30C165C59C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbjACSCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238552AbjACSC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:02:28 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A9511A27
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672768945; x=1704304945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lzIse4ZWwsUKwU2q15GNya0zg7eYgzn0naky1H7IqGc=;
  b=XHA/9oB618gKmvBx60b4494Zj9KfRJbKcHAhn3oH8gfivSDYrSvFGxzl
   2CMa3U72aH7Pp1yn6HxLMQ9HpeCMufrP6yXD7CkmfYJP56RbkzAE71FVr
   H2Olc6eeIRRqWe3WcMKvB0AB+rCjquibgYOejI/Y9tdWIYdW7MVcc00l/
   pv/Uh4jE4DBE+1xxxCrfui8XyIVt0Z7aB3lV6lk3bkTLdo5qNM1QJc0o0
   oOIjdBISWsJ4BglBP85rkNm6MKoGg0UiIlJGwSAnQqAAFqe61IFcDRwWp
   zXx08o58neZwHEURNQbm8pvhyTh6soHTP3EQloF4OOPj9bMx8gFpr5wHP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="384010652"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="384010652"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 10:02:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="654876888"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="654876888"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 10:02:24 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v3 4/6] x86/microcode/intel: Use a plain revision argument for print_ucode_rev()
Date:   Tue,  3 Jan 2023 10:02:10 -0800
Message-Id: <20230103180212.333496-5-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103180212.333496-1-ashok.raj@intel.com>
References: <20230103180212.333496-1-ashok.raj@intel.com>
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
Cc: Tony Luck <tony.luck@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
---
Changes since earlier post.

Thomas:
 - Updated commit log as suggested
 - Remove the line break after static void before print_ucode_info
---
 arch/x86/kernel/cpu/microcode/intel.c | 31 ++++++++-------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 6bebc46ad8b1..1d709b72cfd0 100644
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
+		print_ucode_info(uci.cpu_sig.rev. current_mc_date);
 		delay_ucode_info = 0;
 	}
 }
@@ -343,33 +340,23 @@ void show_ucode_info_early(void)
  * At this point, we can not call printk() yet. Delay printing microcode info in
  * show_ucode_info_early() until printk() works.
  */
-static void print_ucode(struct ucode_cpu_info *uci)
+static void print_ucode(int new_rev, int date)
 {
 	struct microcode_intel *mc;
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
 
@@ -409,9 +396,9 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
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

