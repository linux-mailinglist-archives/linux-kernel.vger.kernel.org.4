Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D63663CA1D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 22:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbiK2VJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 16:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbiK2VJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:09:08 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8C413F41
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 13:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669756147; x=1701292147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=20JuXfzhAsVCbgdOdNtTvhg8467Iyas3sTDbl4soGRo=;
  b=hadAQMldluMt9tJL7ixJlQtcaB2uBl9ahcRVd0d8TnU/p9c091mXXKBU
   o4D6gOcvQlaYhskVKAimk6vkVRdpTz7g/VGUkPeD5pq5Ggq/S3q8yIaqv
   AAc7SzNXC2X8a2lkDH2hWTXSGvqliJpUL3egB5P4sV0XwspR2qS5cTczB
   ATHPMa7x1AxDADzsO1I2PPINqIukgxGsW1kkjAoaqJJhMs24ABp3/yAjS
   uHhXSawjR4ZHWnMXNsH+Kf0UBsWw+82DO+qutshC6f7PsY2/+aU+Hdqpf
   a4Y0Ys2CJv3NJ79TbpjdE2vsqcDBh5P+wPBjjfD477cm0wrQnNGh0R6B9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="317083148"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="317083148"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 13:09:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="646066222"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="646066222"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 13:09:05 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, alison.schofield@intel.com,
        reinette.chatre@intel.com
Subject: [Patch V1 7/7] x86/microcode/intel: Print when early microcode loading fails
Date:   Tue, 29 Nov 2022 13:08:32 -0800
Message-Id: <20221129210832.107850-8-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221129210832.107850-1-ashok.raj@intel.com>
References: <20221129210832.107850-1-ashok.raj@intel.com>
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

Currently when early microcode loading fails there is no way for user to
know that the update failed.

Store the failed status and pass it to print_ucode_info() to let early
loading failures to captured in console log.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 29 ++++++++++++++++-----------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 3dbcf457f45d..3b299f437e35 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -309,13 +309,14 @@ static bool load_builtin_intel_microcode(struct cpio_data *cp)
  * Print ucode update info.
  */
 static void
-print_ucode_info(int old_rev, int new_rev, unsigned int date)
+print_ucode_info(bool failed, int old_rev, int new_rev, unsigned int date)
 {
-	pr_info_once("early update: 0x%x -> 0x%x, date = %04x-%02x-%02x\n",
+	pr_info_once("early update: 0x%x -> 0x%x, date = %04x-%02x-%02x %s\n",
 		     old_rev, new_rev,
 		     date & 0xffff,
 		     date >> 24,
-		     (date >> 16) & 0xff);
+		     (date >> 16) & 0xff,
+		     failed ? "FAILED" : "");
 }
 
 #ifdef CONFIG_X86_32
@@ -323,6 +324,7 @@ print_ucode_info(int old_rev, int new_rev, unsigned int date)
 static int delay_ucode_info;
 static int current_mc_date;
 static int early_old_rev;
+static bool early_failed;
 
 /*
  * Print early updated ucode info after printk works. This is delayed info dump.
@@ -333,7 +335,7 @@ void show_ucode_info_early(void)
 
 	if (delay_ucode_info) {
 		intel_cpu_collect_info(&uci);
-		print_ucode_info(early_old_rev, uci.cpu_sig.rev, current_mc_date);
+		print_ucode_info(early_failed, early_old_rev, uci.cpu_sig.rev, current_mc_date);
 		delay_ucode_info = 0;
 	}
 }
@@ -342,26 +344,28 @@ void show_ucode_info_early(void)
  * At this point, we can not call printk() yet. Delay printing microcode info in
  * show_ucode_info_early() until printk() works.
  */
-static void print_ucode(int old_rev, int new_rev, int date)
+static void print_ucode(bool failed, int old_rev, int new_rev, int date)
 {
-	struct microcode_intel *mc;
 	int *delay_ucode_info_p;
 	int *current_mc_date_p;
 	int *early_old_rev_p;
+	bool *early_failed_p;
 
 	delay_ucode_info_p = (int *)__pa_nodebug(&delay_ucode_info);
 	current_mc_date_p = (int *)__pa_nodebug(&current_mc_date);
 	early_old_rev_p = (int *)__pa_nodebug(&early_old_rev);
+	early_failed_p = (int *)__pa_nodebug(&early_failed);
 
 	*delay_ucode_info_p = 1;
 	*current_mc_date_p = date;
 	*early_old_rev_p = old_rev;
+	*early_failed_p = failed;
 }
 #else
 
-static inline void print_ucode(int old_rev, int new_rev, int date)
+static inline void print_ucode(bool failed, int old_rev, int new_rev, int date)
 {
-	print_ucode_info(old_rev, new_rev, date);
+	print_ucode_info(failed, old_rev, new_rev, date);
 }
 #endif
 
@@ -369,6 +373,7 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 {
 	struct microcode_intel *mc;
 	u32 rev, old_rev;
+	int retval = 0;
 
 	mc = uci->mc;
 	if (!mc)
@@ -397,16 +402,16 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 	old_rev = rev;
 	rev = intel_get_microcode_revision();
 	if (rev != mc->hdr.rev)
-		return -1;
+		retval = -1;
 
 	uci->cpu_sig.rev = rev;
 
 	if (early)
-		print_ucode(old_rev, uci->cpu_sig.rev, mc->hdr.date);
+		print_ucode(retval, old_rev, mc->hdr.rev, mc->hdr.date);
 	else
-		print_ucode_info(old_rev, uci->cpu_sig.rev, mc->hdr.date);
+		print_ucode_info(retval, old_rev, uci->cpu_sig.rev, mc->hdr.date);
 
-	return 0;
+	return retval;
 }
 
 int __init save_microcode_in_initrd_intel(void)
-- 
2.34.1

