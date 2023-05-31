Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0067C7188CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjEaRtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjEaRtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:49:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E94138;
        Wed, 31 May 2023 10:49:04 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A25531EC042D;
        Wed, 31 May 2023 19:49:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685555343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4awF7ihropMIeuORHFj3RY30SkzPrI4h/Pp4BMpmeAM=;
        b=K9yTaQIvSiqB2B4WfU+Jnili6hYPgH7rfjnOVXpv22taysYxHx7NknW6idh/cKrzOEESRm
        honBMfa3yHiNwpH1DYMfqa/pm75xafqAeoWWnLiBkKjxzPW54I1xQLxuNntaI1yRNYsM4P
        ezsvY7SMHGs6rokaZ8atyMo6m83ReoA=
Date:   Wed, 31 May 2023 19:48:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org,
        mikelley@microsoft.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without MTRR
Message-ID: <20230531174857.GDZHeIib57h5lT5Vh1@fat_crate.local>
References: <20230509201437.GFZFqprc6otRejDPUt@fat_crate.local>
 <20230509233641.GGZFrZCTDH7VwUMp5R@fat_crate.local>
 <20230510133024.GBZFuccC1FxIZNKL+8@fat_crate.local>
 <4c47a11c-0565-678d-3467-e01c5ec16600@suse.com>
 <20230511163208.GDZF0YiOfxQhSo4RDm@fat_crate.local>
 <0cd3899b-cf3b-61c1-14ae-60b6b49d14ab@suse.com>
 <20230530152825.GAZHYWGXAp8PHgN/w0@fat_crate.local>
 <888f860d-4307-54eb-01da-11f9adf65559@suse.com>
 <20230531083508.GAZHcGvB68PUAH7f+a@fat_crate.local>
 <efe79c9e-1e31-adb9-8f93-962249bf01bb@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <efe79c9e-1e31-adb9-8f93-962249bf01bb@suse.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 04:20:08PM +0200, Juergen Gross wrote:
> One other note: why does mtrr_cleanup() think that using 8 instead of 6
> variable MTRRs would be an "optimal setting"?

Maybe the more extensive debug output below would help answer that...

> IMO it should replace the original setup only in case it is using _less_
> MTRRs than before.

Right.

> Additionally I believe mtrr_cleanup() would make much more sense if it
> wouldn't be __init, but being usable when trying to add additional MTRRs
> in the running system in case we run out of MTRRs.
> 
> It should probably be based on the new MTRR map anyway...

So I'm not really sure we really care about adding additional MTRRs.
There probably is a use case which does that but I haven't seen one yet
- MTRRs are all legacy crap to me.

Btw, one more patch ontop:

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Wed, 31 May 2023 19:23:34 +0200
Subject: [PATCH] x86/mtrr: Unify debugging printing

Put all the debugging output behind "mtrr=debug" and get rid of
"mtrr_cleanup_debug" which wasn't even documented anywhere.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/mtrr/cleanup.c | 59 ++++++++++++------------------
 arch/x86/kernel/cpu/mtrr/generic.c |  2 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c    |  5 +--
 arch/x86/kernel/cpu/mtrr/mtrr.h    |  3 ++
 4 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index ed5f84c20ac2..18cf79d6e2c5 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -55,9 +55,6 @@ static int __initdata				nr_range;
 
 static struct var_mtrr_range_state __initdata	range_state[RANGE_NUM];
 
-static int __initdata debug_print;
-#define Dprintk(x...) do { if (debug_print) pr_debug(x); } while (0)
-
 #define BIOS_BUG_MSG \
 	"WARNING: BIOS bug: VAR MTRR %d contains strange UC entry under 1M, check with your system vendor!\n"
 
@@ -79,12 +76,11 @@ x86_get_mtrr_mem_range(struct range *range, int nr_range,
 		nr_range = add_range_with_merge(range, RANGE_NUM, nr_range,
 						base, base + size);
 	}
-	if (debug_print) {
-		pr_debug("After WB checking\n");
-		for (i = 0; i < nr_range; i++)
-			pr_debug("MTRR MAP PFN: %016llx - %016llx\n",
-				 range[i].start, range[i].end);
-	}
+
+	Dprintk("After WB checking\n");
+	for (i = 0; i < nr_range; i++)
+		Dprintk("MTRR MAP PFN: %016llx - %016llx\n",
+			 range[i].start, range[i].end);
 
 	/* Take out UC ranges: */
 	for (i = 0; i < num_var_ranges; i++) {
@@ -112,24 +108,22 @@ x86_get_mtrr_mem_range(struct range *range, int nr_range,
 		subtract_range(range, RANGE_NUM, extra_remove_base,
 				 extra_remove_base + extra_remove_size);
 
-	if  (debug_print) {
-		pr_debug("After UC checking\n");
-		for (i = 0; i < RANGE_NUM; i++) {
-			if (!range[i].end)
-				continue;
-			pr_debug("MTRR MAP PFN: %016llx - %016llx\n",
-				 range[i].start, range[i].end);
-		}
+	Dprintk("After UC checking\n");
+	for (i = 0; i < RANGE_NUM; i++) {
+		if (!range[i].end)
+			continue;
+
+		Dprintk("MTRR MAP PFN: %016llx - %016llx\n",
+			 range[i].start, range[i].end);
 	}
 
 	/* sort the ranges */
 	nr_range = clean_sort_range(range, RANGE_NUM);
-	if  (debug_print) {
-		pr_debug("After sorting\n");
-		for (i = 0; i < nr_range; i++)
-			pr_debug("MTRR MAP PFN: %016llx - %016llx\n",
-				 range[i].start, range[i].end);
-	}
+
+	Dprintk("After sorting\n");
+	for (i = 0; i < nr_range; i++)
+		Dprintk("MTRR MAP PFN: %016llx - %016llx\n",
+			range[i].start, range[i].end);
 
 	return nr_range;
 }
@@ -164,13 +158,6 @@ static int __init enable_mtrr_cleanup_setup(char *str)
 }
 early_param("enable_mtrr_cleanup", enable_mtrr_cleanup_setup);
 
-static int __init mtrr_cleanup_debug_setup(char *str)
-{
-	debug_print = 1;
-	return 0;
-}
-early_param("mtrr_cleanup_debug", mtrr_cleanup_debug_setup);
-
 static void __init
 set_var_mtrr(unsigned int reg, unsigned long basek, unsigned long sizek,
 	     unsigned char type)
@@ -267,7 +254,7 @@ range_to_mtrr(unsigned int reg, unsigned long range_startk,
 			align = max_align;
 
 		sizek = 1UL << align;
-		if (debug_print) {
+		if (mtrr_debug) {
 			char start_factor = 'K', size_factor = 'K';
 			unsigned long start_base, size_base;
 
@@ -542,7 +529,7 @@ static void __init print_out_mtrr_range_state(void)
 		start_base = to_size_factor(start_base, &start_factor);
 		type = range_state[i].type;
 
-		pr_debug("reg %d, base: %ld%cB, range: %ld%cB, type %s\n",
+		Dprintk("reg %d, base: %ld%cB, range: %ld%cB, type %s\n",
 			i, start_base, start_factor,
 			size_base, size_factor,
 			(type == MTRR_TYPE_UNCACHABLE) ? "UC" :
@@ -714,7 +701,7 @@ int __init mtrr_cleanup(void)
 		return 0;
 
 	/* Print original var MTRRs at first, for debugging: */
-	pr_debug("original variable MTRRs\n");
+	Dprintk("original variable MTRRs\n");
 	print_out_mtrr_range_state();
 
 	memset(range, 0, sizeof(range));
@@ -746,7 +733,7 @@ int __init mtrr_cleanup(void)
 
 		if (!result[i].bad) {
 			set_var_mtrr_all();
-			pr_debug("New variable MTRRs\n");
+			Dprintk("New variable MTRRs\n");
 			print_out_mtrr_range_state();
 			return 1;
 		}
@@ -766,7 +753,7 @@ int __init mtrr_cleanup(void)
 
 			mtrr_calc_range_state(chunk_size, gran_size,
 				      x_remove_base, x_remove_size, i);
-			if (debug_print) {
+			if (mtrr_debug) {
 				mtrr_print_out_one_result(i);
 				pr_info("\n");
 			}
@@ -790,7 +777,7 @@ int __init mtrr_cleanup(void)
 		gran_size <<= 10;
 		x86_setup_var_mtrrs(range, nr_range, chunk_size, gran_size);
 		set_var_mtrr_all();
-		pr_debug("New variable MTRRs\n");
+		Dprintk("New variable MTRRs\n");
 		print_out_mtrr_range_state();
 		return 1;
 	} else {
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index e5c5192d8a28..58a3848435c4 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -41,7 +41,7 @@ struct cache_map {
 	u64 fixed:1;
 };
 
-static bool mtrr_debug;
+bool mtrr_debug;
 
 static int __init mtrr_param_setup(char *str)
 {
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index ec8670bb5d88..767bf1c71aad 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -332,7 +332,7 @@ static int mtrr_check(unsigned long base, unsigned long size)
 {
 	if ((base & (PAGE_SIZE - 1)) || (size & (PAGE_SIZE - 1))) {
 		pr_warn("size and base must be multiples of 4 kiB\n");
-		pr_debug("size: 0x%lx  base: 0x%lx\n", size, base);
+		Dprintk("size: 0x%lx  base: 0x%lx\n", size, base);
 		dump_stack();
 		return -1;
 	}
@@ -423,8 +423,7 @@ int mtrr_del_page(int reg, unsigned long base, unsigned long size)
 			}
 		}
 		if (reg < 0) {
-			pr_debug("no MTRR for %lx000,%lx000 found\n",
-				 base, size);
+			Dprintk("no MTRR for %lx000,%lx000 found\n", base, size);
 			goto out;
 		}
 	}
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index 8385d7d3a865..5655f253d929 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -10,6 +10,9 @@
 #define MTRR_CHANGE_MASK_VARIABLE  0x02
 #define MTRR_CHANGE_MASK_DEFTYPE   0x04
 
+extern bool mtrr_debug;
+#define Dprintk(x...) do { if (mtrr_debug) pr_info(x); } while (0)
+
 extern unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
 
 struct mtrr_ops {
-- 
2.35.1


[    0.000000] microcode: updated early: 0x710 -> 0x718, date = 2019-05-21
[    0.000000] Linux version 6.4.0-rc1+ (root@gondor) (gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1) #1 SMP PREEMPT_DYNAMIC Wed May 31 13:45:34 CEST 2023
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.4.0-rc1+ root=/dev/sda7 ro earlyprintk=ttyS0,115200 console=ttyS0,115200 console=tty0 ras=cec_disable root=/dev/sda7 log_buf_len=10M resume=/dev/sda5 no_console_suspend ignore_loglevel mtrr=debug
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] signal: max sigframe size: 1776
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000018ebafff] usable
[    0.000000] BIOS-e820: [mem 0x0000000018ebb000-0x0000000018fe7fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000018fe8000-0x0000000018fe8fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000018fe9000-0x0000000018ffffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000019000000-0x000000001dffcfff] usable
[    0.000000] BIOS-e820: [mem 0x000000001dffd000-0x000000001dffffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000001e000000-0x00000000ac77cfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ac77d000-0x00000000ac77ffff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000ac780000-0x00000000ac780fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ac781000-0x00000000ac782fff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000ac783000-0x00000000ac7d9fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ac7da000-0x00000000ac7dafff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000ac7db000-0x00000000ac7dcfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ac7dd000-0x00000000ac7e7fff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000ac7e8000-0x00000000ac7f1fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ac7f2000-0x00000000ac7f5fff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000ac7f6000-0x00000000ac7f9fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ac7fa000-0x00000000ac7fafff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000ac7fb000-0x00000000ac803fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ac804000-0x00000000ac810fff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000ac811000-0x00000000ac813fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ac814000-0x00000000ad7fffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000b0000000-0x00000000b3ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed3ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed50000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffa00000-0x00000000ffa3ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000044fffffff] usable
[    0.000000] printk: bootconsole [earlyser0] enabled
[    0.000000] printk: debug: ignoring loglevel setting.
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.0 by American Megatrends
[    0.000000] efi: ACPI 2.0=0x1dffff98 SMBIOS=0xac811018 
[    0.000000] efi: Remove mem57: MMIO range=[0xb0000000-0xb3ffffff] (64MB) from e820 map
[    0.000000] e820: remove [mem 0xb0000000-0xb3ffffff] reserved
[    0.000000] efi: Not removing mem58: MMIO range=[0xfed20000-0xfed3ffff] (128KB) from e820 map
[    0.000000] efi: Remove mem59: MMIO range=[0xfed50000-0xfed8ffff] (0MB) from e820 map
[    0.000000] e820: remove [mem 0xfed50000-0xfed8ffff] reserved
[    0.000000] efi: Remove mem60: MMIO range=[0xffa00000-0xffa3ffff] (0MB) from e820 map
[    0.000000] e820: remove [mem 0xffa00000-0xffa3ffff] reserved
[    0.000000] SMBIOS 2.6 present.
[    0.000000] DMI: Dell Inc. Precision T3600/0PTTT9, BIOS A13 05/11/2014
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3591.179 MHz processor
[    0.000747] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.007211] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.012717] last_pfn = 0x450000 max_arch_pfn = 0x400000000
[    0.018124] MTRR default type: uncachable
[    0.022074] MTRR fixed ranges enabled:
[    0.025768]   00000-9FFFF write-back
[    0.029290]   A0000-BFFFF uncachable
[    0.032812]   C0000-FFFFF write-protect
[    0.036592] MTRR variable ranges enabled:
[    0.040543]   0 base 000000000000000 mask 0003FFC00000000 write-back
[    0.046814]   1 base 000000400000000 mask 0003FFFC0000000 write-back
[    0.053086]   2 base 000000440000000 mask 0003FFFF0000000 write-back
[    0.059357]   3 base 0000000AE000000 mask 0003FFFFE000000 uncachable
[    0.065629]   4 base 0000000B0000000 mask 0003FFFF0000000 uncachable
[    0.071899]   5 base 0000000C0000000 mask 0003FFFC0000000 uncachable
[    0.078172]   6 disabled
[    0.080664]   7 disabled
[    0.083155]   8 disabled
[    0.085645]   9 disabled
[    0.088140] original variable MTRRs
[    0.091574] reg 0, base: 0GB, range: 16GB, type WB
[    0.096299] reg 1, base: 16GB, range: 1GB, type WB
[    0.101026] reg 2, base: 17GB, range: 256MB, type WB
[    0.105923] reg 3, base: 2784MB, range: 32MB, type UC
[    0.110906] reg 4, base: 2816MB, range: 256MB, type UC
[    0.115975] reg 5, base: 3GB, range: 1GB, type UC
[    0.120617] After WB checking
[    0.123536] MTRR MAP PFN: 0000000000000000 - 0000000000450000
[    0.129208] After UC checking
[    0.132127] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.137798] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.143468] After sorting
[    0.146044] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.151714] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.157385] total RAM covered: 16352M
[    0.160994] rangeX: 0000000000000000 - 00000000ae000000
[    0.166148] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    0.172332] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    0.178690] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    0.185305] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    0.191835] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    0.198363] rangeX: 0000000100000000 - 0000000450000000
[    0.203518] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    0.209703] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    0.215887] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    0.222159] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    0.228603] After WB checking
[    0.231522] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.237193] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.242864] After UC checking
[    0.245784] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.251455] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.257126] After sorting
[    0.259702] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.265371] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.271042]  gran_size: 64K 	chunk_size: 64K 	num_reg: 9  	lose cover RAM: 0G

[    0.279545] rangeX: 0000000000000000 - 00000000ae000000
[    0.284700] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    0.290886] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    0.297243] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    0.303857] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    0.310386] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    0.316915] rangeX: 0000000100000000 - 0000000450000000
[    0.322069] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    0.328254] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    0.334440] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    0.340712] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    0.347155] After WB checking
[    0.350076] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.355745] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.361414] After UC checking
[    0.364335] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.370005] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.375675] After sorting
[    0.378253] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.383922] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.389593]  gran_size: 64K 	chunk_size: 128K 	num_reg: 9  	lose cover RAM: 0G

[    0.398184] rangeX: 0000000000000000 - 00000000ae000000
[    0.403338] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    0.409524] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    0.415881] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    0.422497] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    0.429027] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    0.435555] rangeX: 0000000100000000 - 0000000450000000
[    0.440710] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    0.446897] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    0.453083] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    0.459355] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    0.465798] After WB checking
[    0.468719] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.474442] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.480114] After UC checking
[    0.483034] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.488705] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.494377] After sorting
[    0.496954] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.502626] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.508297]  gran_size: 64K 	chunk_size: 256K 	num_reg: 9  	lose cover RAM: 0G

[    0.516888] rangeX: 0000000000000000 - 00000000ae000000
[    0.522044] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    0.528230] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    0.534588] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    0.541206] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    0.547736] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    0.554266] rangeX: 0000000100000000 - 0000000450000000
[    0.559420] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    0.565605] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    0.571791] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    0.578062] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    0.584506] After WB checking
[    0.587427] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.593097] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.598768] After UC checking
[    0.601690] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.607360] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.613031] After sorting
[    0.615607] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.621278] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.626949]  gran_size: 64K 	chunk_size: 512K 	num_reg: 9  	lose cover RAM: 0G

[    0.635541] rangeX: 0000000000000000 - 00000000ae000000
[    0.640695] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    0.646882] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    0.653240] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    0.659856] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    0.666386] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    0.672916] rangeX: 0000000100000000 - 0000000450000000
[    0.678073] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    0.684260] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    0.690447] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    0.696719] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    0.703164] After WB checking
[    0.706085] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.711754] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.717425] After UC checking
[    0.720347] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.726018] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.731689] After sorting
[    0.734266] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.739937] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.745608]  gran_size: 64K 	chunk_size: 1M 	num_reg: 9  	lose cover RAM: 0G

[    0.754027] rangeX: 0000000000000000 - 00000000ae000000
[    0.759182] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    0.765368] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    0.771726] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    0.778342] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    0.784872] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    0.791402] rangeX: 0000000100000000 - 0000000450000000
[    0.796558] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    0.802745] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    0.808931] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    0.815204] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    0.821648] After WB checking
[    0.824569] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.830240] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.835910] After UC checking
[    0.838831] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.844503] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.850173] After sorting
[    0.852752] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.858422] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.864093]  gran_size: 64K 	chunk_size: 2M 	num_reg: 9  	lose cover RAM: 0G

[    0.872514] rangeX: 0000000000000000 - 00000000ae000000
[    0.877668] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    0.883855] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    0.890212] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    0.896827] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    0.903357] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    0.909885] rangeX: 0000000100000000 - 0000000450000000
[    0.915040] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    0.921226] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    0.927411] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    0.933682] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    0.940126] After WB checking
[    0.943047] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.948717] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.954387] After UC checking
[    0.957308] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.962978] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.968648] After sorting
[    0.971225] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    0.976895] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    0.982565]  gran_size: 64K 	chunk_size: 4M 	num_reg: 9  	lose cover RAM: 0G

[    0.990985] rangeX: 0000000000000000 - 00000000ae000000
[    0.996139] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    1.002324] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    1.008682] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    1.015297] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    1.021826] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    1.028356] rangeX: 0000000100000000 - 0000000450000000
[    1.033512] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    1.039699] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    1.045884] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    1.052156] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    1.058599] After WB checking
[    1.061520] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    1.067189] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    1.072859] After UC checking
[    1.075781] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    1.081451] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    1.087122] After sorting
[    1.089700] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    1.095371] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    1.101041]  gran_size: 64K 	chunk_size: 8M 	num_reg: 9  	lose cover RAM: 0G

[    1.109462] rangeX: 0000000000000000 - 00000000ae000000
[    1.114616] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    1.120803] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    1.127160] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    1.133775] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    1.140304] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    1.146834] rangeX: 0000000100000000 - 0000000450000000
[    1.151989] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    1.158175] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    1.164361] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    1.170634] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    1.177078] After WB checking
[    1.179998] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    1.185668] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    1.191339] After UC checking
[    1.194259] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    1.199930] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    1.205601] After sorting
[    1.208178] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    1.213848] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    1.219517]  gran_size: 64K 	chunk_size: 16M 	num_reg: 9  	lose cover RAM: 0G

[    1.228021] rangeX: 0000000000000000 - 00000000ae000000
[    1.233177] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    1.239362] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    1.245720] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    1.252336] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    1.258864] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    1.265393] rangeX: 0000000100000000 - 0000000450000000
[    1.270547] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    1.276732] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    1.282917] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    1.289189] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    1.295632] After WB checking
[    1.298552] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    1.304221] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    1.309892] After UC checking
[    1.312812] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    1.318483] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    1.324151] After sorting
[    1.326728] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    1.332399] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    1.338070]  gran_size: 64K 	chunk_size: 32M 	num_reg: 9  	lose cover RAM: 0G

[    1.346574] range0: 0000000000000000 - 00000000b0000000
[    1.351728] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    1.357914] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    1.364273] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[    1.370888] hole: 00000000ae000000 - 00000000b0000000
[    1.375872] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[    1.382401] rangeX: 0000000100000000 - 0000000450000000
[    1.387557] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    1.393742] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    1.399929] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    1.406200] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[    1.412643] After WB checking
[    1.415564] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[    1.421234] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    1.426904] After UC checking
[    1.429825] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    1.435494] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    1.441165] After sorting
[    1.443742] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    1.449412] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    1.455084]  gran_size: 64K 	chunk_size: 64M 	num_reg: 8  	lose cover RAM: 0G

[    1.463591] range0: 0000000000000000 - 00000000b0000000
[    1.468746] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    1.474932] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    1.481290] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[    1.487906] hole: 00000000ae000000 - 00000000b0000000
[    1.492889] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[    1.499513] rangeX: 0000000100000000 - 0000000450000000
[    1.504669] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    1.510855] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    1.517041] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    1.523312] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[    1.529757] After WB checking
[    1.532676] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[    1.538347] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    1.544018] After UC checking
[    1.546939] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    1.552610] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    1.558280] After sorting
[    1.560858] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    1.566529] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    1.572199]  gran_size: 64K 	chunk_size: 128M 	num_reg: 8  	lose cover RAM: 0G

[    1.580791] range0: 0000000000000000 - 00000000b0000000
[    1.585945] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    1.592131] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    1.598489] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[    1.605103] hole: 00000000ae000000 - 00000000b0000000
[    1.610086] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[    1.616615] rangeX: 0000000100000000 - 0000000450000000
[    1.621770] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    1.627957] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    1.634142] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    1.640413] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[    1.646858] After WB checking
[    1.649777] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[    1.655449] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    1.661120] After UC checking
[    1.664041] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    1.669711] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    1.675382] After sorting
[    1.677959] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    1.683631] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    1.689301]  gran_size: 64K 	chunk_size: 256M 	num_reg: 8  	lose cover RAM: 0G

[    1.697894] range0: 0000000000000000 - 00000000c0000000
[    1.703049] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    1.709235] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[    1.715421] hole: 00000000ae000000 - 00000000c0000000
[    1.720405] Setting variable MTRR 2, base: 2784MB, range: 32MB, type UC
[    1.726935] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[    1.733550] range0: 0000000100000000 - 0000000460000000
[    1.738705] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    1.744891] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    1.751078] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    1.757351] Setting variable MTRR 7, base: 17GB, range: 512MB, type WB
[    1.763797] hole: 0000000450000000 - 0000000460000000
[    1.768781] Setting variable MTRR 8, base: 17664MB, range: 256MB, type UC
[    1.775483] After WB checking
[    1.778404] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[    1.784076] MTRR MAP PFN: 0000000000100000 - 0000000000460000
[    1.789747] After UC checking
[    1.792668] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    1.798339] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    1.804010] After sorting
[    1.806587] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    1.812258] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    1.817929]  gran_size: 64K 	chunk_size: 512M 	num_reg: 9  	lose cover RAM: 0G

[    1.826522] range0: 0000000000000000 - 00000000c0000000
[    1.831678] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    1.837864] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[    1.844052] hole: 00000000ae000000 - 00000000c0000000
[    1.849035] Setting variable MTRR 2, base: 2784MB, range: 32MB, type UC
[    1.855565] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[    1.862183] range0: 0000000100000000 - 0000000480000000
[    1.867338] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    1.873525] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    1.879711] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[    1.885985] hole: 0000000450000000 - 0000000480000000
[    1.890968] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[    1.897670] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[    1.904372] After WB checking
[    1.907294] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[    1.912965] MTRR MAP PFN: 0000000000100000 - 0000000000480000
[    1.918636] After UC checking
[    1.921557] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    1.927228] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    1.932899] After sorting
[    1.935476] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    1.941147] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    1.946820]  gran_size: 64K 	chunk_size: 1G 	num_reg: 9  	lose cover RAM: 0G

[    1.955239] range0: 0000000000000000 - 0000000100000000
[    1.960394] Setting variable MTRR 0, base: 0GB, range: 4GB, type WB
[    1.966580] hole: 00000000ae000000 - 0000000100000000
[    1.971564] Setting variable MTRR 1, base: 2784MB, range: 32MB, type UC
[    1.978094] Setting variable MTRR 2, base: 2816MB, range: 256MB, type UC
[    1.984710] Setting variable MTRR 3, base: 3GB, range: 1GB, type UC
[    1.990896] range0: 0000000100000000 - 0000000480000000
[    1.996051] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    2.002237] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    2.008423] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[    2.014694] hole: 0000000450000000 - 0000000480000000
[    2.019677] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[    2.026378] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[    2.033078] After WB checking
[    2.036000] MTRR MAP PFN: 0000000000000000 - 0000000000480000
[    2.041672] After UC checking
[    2.044591] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.050261] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.055931] After sorting
[    2.058508] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.064178] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.069849]  gran_size: 64K 	chunk_size: 2G 	num_reg: 9  	lose cover RAM: 0G

[    2.078268] rangeX: 0000000000000000 - 00000000ae000000
[    2.083422] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    2.089608] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    2.095965] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    2.102581] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    2.109109] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    2.115640] rangeX: 0000000100000000 - 0000000450000000
[    2.120795] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    2.126982] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    2.133168] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    2.139441] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    2.145884] After WB checking
[    2.148805] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.154476] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.160147] After UC checking
[    2.163068] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.168739] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.174409] After sorting
[    2.176986] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.182657] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.188327]  gran_size: 128K 	chunk_size: 128K 	num_reg: 9  	lose cover RAM: 0G

[    2.197003] rangeX: 0000000000000000 - 00000000ae000000
[    2.202158] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    2.208342] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    2.214699] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    2.221315] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    2.227845] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    2.234373] rangeX: 0000000100000000 - 0000000450000000
[    2.239528] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    2.245714] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    2.251901] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    2.258173] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    2.264617] After WB checking
[    2.267537] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.273207] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.278877] After UC checking
[    2.281798] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.287470] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.293140] After sorting
[    2.295716] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.301387] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.307058]  gran_size: 128K 	chunk_size: 256K 	num_reg: 9  	lose cover RAM: 0G

[    2.315734] rangeX: 0000000000000000 - 00000000ae000000
[    2.320889] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    2.327075] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    2.333431] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    2.340047] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    2.346574] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    2.353104] rangeX: 0000000100000000 - 0000000450000000
[    2.358258] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    2.364443] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    2.370628] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    2.376900] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    2.383343] After WB checking
[    2.386264] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.391934] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.397604] After UC checking
[    2.400525] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.406195] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.411865] After sorting
[    2.414442] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.420112] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.425783]  gran_size: 128K 	chunk_size: 512K 	num_reg: 9  	lose cover RAM: 0G

[    2.434458] rangeX: 0000000000000000 - 00000000ae000000
[    2.439613] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    2.445797] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    2.452154] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    2.458769] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    2.465298] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    2.471828] rangeX: 0000000100000000 - 0000000450000000
[    2.476982] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    2.483168] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    2.489352] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    2.495623] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    2.502067] After WB checking
[    2.504987] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.510656] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.516327] After UC checking
[    2.519247] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.525022] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.530692] After sorting
[    2.533268] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.538938] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.544607]  gran_size: 128K 	chunk_size: 1M 	num_reg: 9  	lose cover RAM: 0G

[    2.553112] rangeX: 0000000000000000 - 00000000ae000000
[    2.558265] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    2.564450] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    2.570808] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    2.577424] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    2.583952] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    2.590482] rangeX: 0000000100000000 - 0000000450000000
[    2.595637] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    2.601824] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    2.608009] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    2.614281] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    2.620725] After WB checking
[    2.623646] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.629318] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.634987] After UC checking
[    2.637909] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.643578] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.649251] After sorting
[    2.651827] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.657498] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.663168]  gran_size: 128K 	chunk_size: 2M 	num_reg: 9  	lose cover RAM: 0G

[    2.671674] rangeX: 0000000000000000 - 00000000ae000000
[    2.676828] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    2.683014] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    2.689374] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    2.695990] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    2.702520] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    2.709050] rangeX: 0000000100000000 - 0000000450000000
[    2.714205] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    2.720391] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    2.726578] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    2.732851] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    2.739295] After WB checking
[    2.742217] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.747888] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.753558] After UC checking
[    2.756481] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.762152] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.767823] After sorting
[    2.770401] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.776071] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.781742]  gran_size: 128K 	chunk_size: 4M 	num_reg: 9  	lose cover RAM: 0G

[    2.790250] rangeX: 0000000000000000 - 00000000ae000000
[    2.795404] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    2.801592] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    2.807950] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    2.814566] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    2.821096] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    2.827626] rangeX: 0000000100000000 - 0000000450000000
[    2.832781] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    2.838969] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    2.845154] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    2.851427] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    2.857871] After WB checking
[    2.860792] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.866462] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.872133] After UC checking
[    2.875053] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.880723] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.886394] After sorting
[    2.888971] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.894642] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.900312]  gran_size: 128K 	chunk_size: 8M 	num_reg: 9  	lose cover RAM: 0G

[    2.908816] rangeX: 0000000000000000 - 00000000ae000000
[    2.913972] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    2.920157] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    2.926515] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    2.933131] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    2.939660] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    2.946189] rangeX: 0000000100000000 - 0000000450000000
[    2.951344] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    2.957530] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    2.963717] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    2.969988] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    2.976433] After WB checking
[    2.979354] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.985025] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    2.990695] After UC checking
[    2.993617] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    2.999289] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.004960] After sorting
[    3.007536] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    3.013206] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.018877]  gran_size: 128K 	chunk_size: 16M 	num_reg: 9  	lose cover RAM: 0G

[    3.027470] rangeX: 0000000000000000 - 00000000ae000000
[    3.032624] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    3.038811] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    3.045169] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    3.051786] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    3.058316] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    3.064846] rangeX: 0000000100000000 - 0000000450000000
[    3.070001] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    3.076188] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    3.082375] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    3.088646] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    3.095090] After WB checking
[    3.098011] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    3.103681] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.109352] After UC checking
[    3.112274] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    3.117944] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.123615] After sorting
[    3.126193] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    3.131864] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.137534]  gran_size: 128K 	chunk_size: 32M 	num_reg: 9  	lose cover RAM: 0G

[    3.146126] range0: 0000000000000000 - 00000000b0000000
[    3.151280] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    3.157467] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    3.163823] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[    3.170439] hole: 00000000ae000000 - 00000000b0000000
[    3.175422] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[    3.181950] rangeX: 0000000100000000 - 0000000450000000
[    3.187105] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    3.193291] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    3.199476] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    3.205748] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[    3.212191] After WB checking
[    3.215112] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[    3.220782] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.226451] After UC checking
[    3.229372] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    3.235042] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.240714] After sorting
[    3.243291] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    3.248961] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.254633]  gran_size: 128K 	chunk_size: 64M 	num_reg: 8  	lose cover RAM: 0G

[    3.263224] range0: 0000000000000000 - 00000000b0000000
[    3.268379] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    3.274565] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    3.280925] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[    3.287541] hole: 00000000ae000000 - 00000000b0000000
[    3.292524] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[    3.299054] rangeX: 0000000100000000 - 0000000450000000
[    3.304209] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    3.310395] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    3.316581] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    3.322853] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[    3.329298] After WB checking
[    3.332219] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[    3.337889] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.343561] After UC checking
[    3.346481] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    3.352152] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.357824] After sorting
[    3.360401] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    3.366071] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.371742]  gran_size: 128K 	chunk_size: 128M 	num_reg: 8  	lose cover RAM: 0G

[    3.380419] range0: 0000000000000000 - 00000000b0000000
[    3.385575] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    3.391762] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    3.398120] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[    3.404736] hole: 00000000ae000000 - 00000000b0000000
[    3.409719] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[    3.416250] rangeX: 0000000100000000 - 0000000450000000
[    3.421405] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    3.427591] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    3.433778] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    3.440050] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[    3.446493] After WB checking
[    3.449414] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[    3.455084] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.460756] After UC checking
[    3.463676] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    3.469348] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.475019] After sorting
[    3.477595] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    3.483266] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.488937]  gran_size: 128K 	chunk_size: 256M 	num_reg: 8  	lose cover RAM: 0G

[    3.497614] range0: 0000000000000000 - 00000000c0000000
[    3.502768] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    3.508955] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[    3.515139] hole: 00000000ae000000 - 00000000c0000000
[    3.520122] Setting variable MTRR 2, base: 2784MB, range: 32MB, type UC
[    3.526652] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[    3.533267] range0: 0000000100000000 - 0000000460000000
[    3.538422] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    3.544609] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    3.550875] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    3.557146] Setting variable MTRR 7, base: 17GB, range: 512MB, type WB
[    3.563588] hole: 0000000450000000 - 0000000460000000
[    3.568571] Setting variable MTRR 8, base: 17664MB, range: 256MB, type UC
[    3.575273] After WB checking
[    3.578193] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[    3.583864] MTRR MAP PFN: 0000000000100000 - 0000000000460000
[    3.589535] After UC checking
[    3.592455] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    3.598126] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.603797] After sorting
[    3.606374] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    3.612045] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.617716]  gran_size: 128K 	chunk_size: 512M 	num_reg: 9  	lose cover RAM: 0G

[    3.626392] range0: 0000000000000000 - 00000000c0000000
[    3.631546] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    3.637732] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[    3.643917] hole: 00000000ae000000 - 00000000c0000000
[    3.648900] Setting variable MTRR 2, base: 2784MB, range: 32MB, type UC
[    3.655430] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[    3.662045] range0: 0000000100000000 - 0000000480000000
[    3.667201] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    3.673387] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    3.679573] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[    3.685842] hole: 0000000450000000 - 0000000480000000
[    3.690826] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[    3.697527] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[    3.704228] After WB checking
[    3.707149] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[    3.712819] MTRR MAP PFN: 0000000000100000 - 0000000000480000
[    3.718490] After UC checking
[    3.721409] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    3.727080] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.732750] After sorting
[    3.735327] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    3.740997] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.746667]  gran_size: 128K 	chunk_size: 1G 	num_reg: 9  	lose cover RAM: 0G

[    3.755173] range0: 0000000000000000 - 0000000100000000
[    3.760328] Setting variable MTRR 0, base: 0GB, range: 4GB, type WB
[    3.766513] hole: 00000000ae000000 - 0000000100000000
[    3.771497] Setting variable MTRR 1, base: 2784MB, range: 32MB, type UC
[    3.778026] Setting variable MTRR 2, base: 2816MB, range: 256MB, type UC
[    3.784642] Setting variable MTRR 3, base: 3GB, range: 1GB, type UC
[    3.790827] range0: 0000000100000000 - 0000000480000000
[    3.795982] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    3.802168] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    3.808354] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[    3.814625] hole: 0000000450000000 - 0000000480000000
[    3.819608] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[    3.826310] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[    3.833012] After WB checking
[    3.835933] MTRR MAP PFN: 0000000000000000 - 0000000000480000
[    3.841604] After UC checking
[    3.844525] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    3.850195] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.855865] After sorting
[    3.858443] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    3.864113] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.869784]  gran_size: 128K 	chunk_size: 2G 	num_reg: 9  	lose cover RAM: 0G

[    3.878289] rangeX: 0000000000000000 - 00000000ae000000
[    3.883444] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    3.889630] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    3.895988] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    3.902603] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    3.909131] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    3.915660] rangeX: 0000000100000000 - 0000000450000000
[    3.920814] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    3.927000] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    3.933187] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    3.939457] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    3.945902] After WB checking
[    3.948823] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    3.954492] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.960164] After UC checking
[    3.963085] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    3.968754] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.974425] After sorting
[    3.977001] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    3.982672] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    3.988341]  gran_size: 256K 	chunk_size: 256K 	num_reg: 9  	lose cover RAM: 0G

[    3.997018] rangeX: 0000000000000000 - 00000000ae000000
[    4.002173] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    4.008357] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    4.014715] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    4.021329] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    4.027860] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    4.034388] rangeX: 0000000100000000 - 0000000450000000
[    4.039542] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    4.045728] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    4.051913] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    4.058184] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    4.064626] After WB checking
[    4.067547] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.073217] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.078887] After UC checking
[    4.081808] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.087477] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.093149] After sorting
[    4.095725] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.101396] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.107066]  gran_size: 256K 	chunk_size: 512K 	num_reg: 9  	lose cover RAM: 0G

[    4.115742] rangeX: 0000000000000000 - 00000000ae000000
[    4.120898] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    4.127085] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    4.133443] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    4.140059] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    4.146589] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    4.153119] rangeX: 0000000100000000 - 0000000450000000
[    4.158273] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    4.164460] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    4.170645] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    4.176916] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    4.183361] After WB checking
[    4.186281] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.191951] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.197621] After UC checking
[    4.200543] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.206212] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.211883] After sorting
[    4.214460] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.220131] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.225802]  gran_size: 256K 	chunk_size: 1M 	num_reg: 9  	lose cover RAM: 0G

[    4.234307] rangeX: 0000000000000000 - 00000000ae000000
[    4.239462] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    4.245648] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    4.252004] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    4.258620] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    4.265149] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    4.271679] rangeX: 0000000100000000 - 0000000450000000
[    4.276834] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    4.283020] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    4.289205] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    4.295477] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    4.301918] After WB checking
[    4.304839] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.310509] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.316179] After UC checking
[    4.319100] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.324771] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.330441] After sorting
[    4.333018] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.338688] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.344361]  gran_size: 256K 	chunk_size: 2M 	num_reg: 9  	lose cover RAM: 0G

[    4.352866] rangeX: 0000000000000000 - 00000000ae000000
[    4.358021] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    4.364207] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    4.370566] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    4.377180] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    4.383712] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    4.390242] rangeX: 0000000100000000 - 0000000450000000
[    4.395397] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    4.401584] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    4.407771] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    4.414043] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    4.420488] After WB checking
[    4.423408] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.429079] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.434749] After UC checking
[    4.437670] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.443342] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.449012] After sorting
[    4.451591] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.457261] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.462932]  gran_size: 256K 	chunk_size: 4M 	num_reg: 9  	lose cover RAM: 0G

[    4.471436] rangeX: 0000000000000000 - 00000000ae000000
[    4.476591] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    4.482776] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    4.489133] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    4.495749] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    4.502278] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    4.508807] rangeX: 0000000100000000 - 0000000450000000
[    4.513962] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    4.520148] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    4.526335] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    4.532606] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    4.539051] After WB checking
[    4.541973] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.547644] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.553314] After UC checking
[    4.556235] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.561905] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.567576] After sorting
[    4.570197] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.575867] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.581538]  gran_size: 256K 	chunk_size: 8M 	num_reg: 9  	lose cover RAM: 0G

[    4.590043] rangeX: 0000000000000000 - 00000000ae000000
[    4.595197] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    4.601384] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    4.607741] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    4.614358] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    4.620887] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    4.627418] rangeX: 0000000100000000 - 0000000450000000
[    4.632573] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    4.638759] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    4.644946] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    4.651219] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    4.657663] After WB checking
[    4.660583] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.666254] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.671924] After UC checking
[    4.674846] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.680518] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.686189] After sorting
[    4.688766] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.694437] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.700109]  gran_size: 256K 	chunk_size: 16M 	num_reg: 9  	lose cover RAM: 0G

[    4.708701] rangeX: 0000000000000000 - 00000000ae000000
[    4.713857] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    4.720043] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    4.726400] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    4.733016] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    4.739546] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    4.746076] rangeX: 0000000100000000 - 0000000450000000
[    4.751231] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    4.757417] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    4.763602] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    4.769872] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    4.776315] After WB checking
[    4.779236] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.784906] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.790576] After UC checking
[    4.793497] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.799169] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.804840] After sorting
[    4.807416] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.813087] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.818758]  gran_size: 256K 	chunk_size: 32M 	num_reg: 9  	lose cover RAM: 0G

[    4.827348] range0: 0000000000000000 - 00000000b0000000
[    4.832502] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    4.838688] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    4.845045] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[    4.851659] hole: 00000000ae000000 - 00000000b0000000
[    4.856642] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[    4.863172] rangeX: 0000000100000000 - 0000000450000000
[    4.868327] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    4.874512] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    4.880698] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    4.886970] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[    4.893414] After WB checking
[    4.896335] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[    4.902005] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.907675] After UC checking
[    4.910596] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.916267] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.921936] After sorting
[    4.924514] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    4.930185] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    4.935856]  gran_size: 256K 	chunk_size: 64M 	num_reg: 8  	lose cover RAM: 0G

[    4.944447] range0: 0000000000000000 - 00000000b0000000
[    4.949603] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    4.955789] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    4.962147] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[    4.968763] hole: 00000000ae000000 - 00000000b0000000
[    4.973746] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[    4.980276] rangeX: 0000000100000000 - 0000000450000000
[    4.985431] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    4.991617] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    4.997804] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    5.004074] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[    5.010518] After WB checking
[    5.013439] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[    5.019110] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    5.024779] After UC checking
[    5.027700] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    5.033370] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    5.039040] After sorting
[    5.041618] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    5.047287] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    5.052958]  gran_size: 256K 	chunk_size: 128M 	num_reg: 8  	lose cover RAM: 0G

[    5.061635] range0: 0000000000000000 - 00000000b0000000
[    5.066790] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    5.072975] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    5.079333] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[    5.085950] hole: 00000000ae000000 - 00000000b0000000
[    5.090933] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[    5.097462] rangeX: 0000000100000000 - 0000000450000000
[    5.102616] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    5.108802] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    5.114988] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    5.121261] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[    5.127705] After WB checking
[    5.130625] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[    5.136295] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    5.141967] After UC checking
[    5.144886] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    5.150558] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    5.156227] After sorting
[    5.158806] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    5.164475] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    5.170146]  gran_size: 256K 	chunk_size: 256M 	num_reg: 8  	lose cover RAM: 0G

[    5.178825] range0: 0000000000000000 - 00000000c0000000
[    5.183981] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    5.190167] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[    5.196352] hole: 00000000ae000000 - 00000000c0000000
[    5.201336] Setting variable MTRR 2, base: 2784MB, range: 32MB, type UC
[    5.207865] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[    5.214479] range0: 0000000100000000 - 0000000460000000
[    5.219634] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    5.225819] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    5.232005] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    5.238277] Setting variable MTRR 7, base: 17GB, range: 512MB, type WB
[    5.244720] hole: 0000000450000000 - 0000000460000000
[    5.249703] Setting variable MTRR 8, base: 17664MB, range: 256MB, type UC
[    5.256405] After WB checking
[    5.259326] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[    5.264995] MTRR MAP PFN: 0000000000100000 - 0000000000460000
[    5.270667] After UC checking
[    5.273586] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    5.279256] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    5.284926] After sorting
[    5.287505] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    5.293175] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    5.298846]  gran_size: 256K 	chunk_size: 512M 	num_reg: 9  	lose cover RAM: 0G

[    5.307523] range0: 0000000000000000 - 00000000c0000000
[    5.312678] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    5.318864] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[    5.325050] hole: 00000000ae000000 - 00000000c0000000
[    5.330033] Setting variable MTRR 2, base: 2784MB, range: 32MB, type UC
[    5.336564] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[    5.343179] range0: 0000000100000000 - 0000000480000000
[    5.348334] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    5.354520] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    5.360706] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[    5.366978] hole: 0000000450000000 - 0000000480000000
[    5.371961] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[    5.378662] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[    5.385364] After WB checking
[    5.388284] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[    5.393955] MTRR MAP PFN: 0000000000100000 - 0000000000480000
[    5.399626] After UC checking
[    5.402545] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    5.408216] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    5.413887] After sorting
[    5.416463] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    5.422134] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    5.427805]  gran_size: 256K 	chunk_size: 1G 	num_reg: 9  	lose cover RAM: 0G

[    5.436311] range0: 0000000000000000 - 0000000100000000
[    5.441465] Setting variable MTRR 0, base: 0GB, range: 4GB, type WB
[    5.447651] hole: 00000000ae000000 - 0000000100000000
[    5.452634] Setting variable MTRR 1, base: 2784MB, range: 32MB, type UC
[    5.459164] Setting variable MTRR 2, base: 2816MB, range: 256MB, type UC
[    5.465782] Setting variable MTRR 3, base: 3GB, range: 1GB, type UC
[    5.471966] range0: 0000000100000000 - 0000000480000000
[    5.477122] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    5.483309] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    5.489495] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[    5.495767] hole: 0000000450000000 - 0000000480000000
[    5.500750] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[    5.507454] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[    5.514156] After WB checking
[    5.517078] MTRR MAP PFN: 0000000000000000 - 0000000000480000
[    5.522749] After UC checking
[    5.525670] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    5.531339] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    5.537011] After sorting
[    5.539589] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    5.545259] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    5.550931]  gran_size: 256K 	chunk_size: 2G 	num_reg: 9  	lose cover RAM: 0G

[    5.559437] rangeX: 0000000000000000 - 00000000ae000000
[    5.564592] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    5.570778] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    5.577137] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    5.583751] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    5.590281] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    5.596907] rangeX: 0000000100000000 - 0000000450000000
[    5.602063] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    5.608249] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    5.614435] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    5.620709] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    5.627152] After WB checking
[    5.630073] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    5.635744] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    5.641414] After UC checking
[    5.644337] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    5.650007] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    5.655678] After sorting
[    5.658255] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    5.663925] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    5.669596]  gran_size: 512K 	chunk_size: 512K 	num_reg: 9  	lose cover RAM: 0G

[    5.678275] rangeX: 0000000000000000 - 00000000ae000000
[    5.683429] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    5.689615] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    5.695973] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    5.702589] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    5.709119] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    5.715649] rangeX: 0000000100000000 - 0000000450000000
[    5.720806] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    5.726992] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    5.733178] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    5.739451] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    5.745895] After WB checking
[    5.748815] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    5.754486] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    5.760157] After UC checking
[    5.763078] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    5.768748] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    5.774420] After sorting
[    5.776997] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    5.782668] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    5.788339]  gran_size: 512K 	chunk_size: 1M 	num_reg: 9  	lose cover RAM: 0G

[    5.796844] rangeX: 0000000000000000 - 00000000ae000000
[    5.801998] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    5.808185] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    5.814543] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    5.821158] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    5.827689] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    5.834218] rangeX: 0000000100000000 - 0000000450000000
[    5.839374] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    5.845560] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    5.851745] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    5.858017] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    5.864460] After WB checking
[    5.867381] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    5.873052] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    5.878723] After UC checking
[    5.881644] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    5.887314] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    5.892986] After sorting
[    5.895563] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    5.901233] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    5.906906]  gran_size: 512K 	chunk_size: 2M 	num_reg: 9  	lose cover RAM: 0G

[    5.915411] rangeX: 0000000000000000 - 00000000ae000000
[    5.920565] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    5.926751] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    5.933110] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    5.939725] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    5.946255] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    5.952785] rangeX: 0000000100000000 - 0000000450000000
[    5.957940] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    5.964126] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    5.970311] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    5.976583] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    5.983028] After WB checking
[    5.985949] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    5.991620] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    5.997292] After UC checking
[    6.000213] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    6.005883] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.011556] After sorting
[    6.014132] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    6.019803] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.025473]  gran_size: 512K 	chunk_size: 4M 	num_reg: 9  	lose cover RAM: 0G

[    6.033980] rangeX: 0000000000000000 - 00000000ae000000
[    6.039134] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    6.045321] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    6.051679] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    6.058295] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    6.064825] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    6.071353] rangeX: 0000000100000000 - 0000000450000000
[    6.076508] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    6.082693] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    6.088879] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    6.095152] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    6.101594] After WB checking
[    6.104516] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    6.110187] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.115856] After UC checking
[    6.118778] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    6.124446] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.130116] After sorting
[    6.132693] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    6.138363] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.144033]  gran_size: 512K 	chunk_size: 8M 	num_reg: 9  	lose cover RAM: 0G

[    6.152537] rangeX: 0000000000000000 - 00000000ae000000
[    6.157692] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    6.163877] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    6.170234] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    6.176848] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    6.183376] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    6.189904] rangeX: 0000000100000000 - 0000000450000000
[    6.195059] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    6.201244] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    6.207429] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    6.213699] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    6.220142] After WB checking
[    6.223062] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    6.228732] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.234402] After UC checking
[    6.237322] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    6.242993] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.248662] After sorting
[    6.251240] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    6.256909] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.262580]  gran_size: 512K 	chunk_size: 16M 	num_reg: 9  	lose cover RAM: 0G

[    6.271173] rangeX: 0000000000000000 - 00000000ae000000
[    6.276327] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    6.282515] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    6.288873] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    6.295489] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    6.302018] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    6.308549] rangeX: 0000000100000000 - 0000000450000000
[    6.313704] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    6.319890] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    6.326076] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    6.332348] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    6.338793] After WB checking
[    6.341712] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    6.347382] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.353054] After UC checking
[    6.355975] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    6.361645] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.367315] After sorting
[    6.369892] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    6.375563] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.381233]  gran_size: 512K 	chunk_size: 32M 	num_reg: 9  	lose cover RAM: 0G

[    6.389825] range0: 0000000000000000 - 00000000b0000000
[    6.394980] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    6.401166] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    6.407524] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[    6.414140] hole: 00000000ae000000 - 00000000b0000000
[    6.419123] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[    6.425653] rangeX: 0000000100000000 - 0000000450000000
[    6.430809] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    6.436996] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    6.443182] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    6.449453] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[    6.455898] After WB checking
[    6.458818] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[    6.464489] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.470160] After UC checking
[    6.473081] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    6.478751] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.484421] After sorting
[    6.486999] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    6.492670] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.498342]  gran_size: 512K 	chunk_size: 64M 	num_reg: 8  	lose cover RAM: 0G

[    6.506933] range0: 0000000000000000 - 00000000b0000000
[    6.512088] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    6.518276] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    6.524634] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[    6.531249] hole: 00000000ae000000 - 00000000b0000000
[    6.536231] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[    6.542761] rangeX: 0000000100000000 - 0000000450000000
[    6.547916] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    6.554103] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    6.560290] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    6.566562] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[    6.573005] After WB checking
[    6.575927] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[    6.581598] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.587268] After UC checking
[    6.590188] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    6.595859] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.601530] After sorting
[    6.604108] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    6.609779] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.615449]  gran_size: 512K 	chunk_size: 128M 	num_reg: 8  	lose cover RAM: 0G

[    6.624220] range0: 0000000000000000 - 00000000b0000000
[    6.629376] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    6.635561] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    6.641919] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[    6.648535] hole: 00000000ae000000 - 00000000b0000000
[    6.653518] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[    6.660048] rangeX: 0000000100000000 - 0000000450000000
[    6.665202] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    6.671388] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    6.677574] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    6.683844] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[    6.690290] After WB checking
[    6.693211] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[    6.698880] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.704552] After UC checking
[    6.707473] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    6.713143] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.718814] After sorting
[    6.721391] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    6.727062] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.732733]  gran_size: 512K 	chunk_size: 256M 	num_reg: 8  	lose cover RAM: 0G

[    6.741410] range0: 0000000000000000 - 00000000c0000000
[    6.746566] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    6.752751] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[    6.758937] hole: 00000000ae000000 - 00000000c0000000
[    6.763920] Setting variable MTRR 2, base: 2784MB, range: 32MB, type UC
[    6.770449] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[    6.777064] range0: 0000000100000000 - 0000000460000000
[    6.782219] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    6.788405] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    6.794593] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    6.800866] Setting variable MTRR 7, base: 17GB, range: 512MB, type WB
[    6.807310] hole: 0000000450000000 - 0000000460000000
[    6.812294] Setting variable MTRR 8, base: 17664MB, range: 256MB, type UC
[    6.818997] After WB checking
[    6.821918] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[    6.827589] MTRR MAP PFN: 0000000000100000 - 0000000000460000
[    6.833261] After UC checking
[    6.836181] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    6.841853] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.847523] After sorting
[    6.850100] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    6.855771] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.861444]  gran_size: 512K 	chunk_size: 512M 	num_reg: 9  	lose cover RAM: 0G

[    6.870120] range0: 0000000000000000 - 00000000c0000000
[    6.875277] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    6.881463] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[    6.887651] hole: 00000000ae000000 - 00000000c0000000
[    6.892634] Setting variable MTRR 2, base: 2784MB, range: 32MB, type UC
[    6.899165] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[    6.905783] range0: 0000000100000000 - 0000000480000000
[    6.910938] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    6.917125] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    6.923312] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[    6.929584] hole: 0000000450000000 - 0000000480000000
[    6.934568] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[    6.941270] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[    6.947974] After WB checking
[    6.950894] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[    6.956565] MTRR MAP PFN: 0000000000100000 - 0000000000480000
[    6.962236] After UC checking
[    6.965157] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    6.970827] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.976499] After sorting
[    6.979076] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    6.984747] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    6.990418]  gran_size: 512K 	chunk_size: 1G 	num_reg: 9  	lose cover RAM: 0G

[    6.998925] range0: 0000000000000000 - 0000000100000000
[    7.004080] Setting variable MTRR 0, base: 0GB, range: 4GB, type WB
[    7.010267] hole: 00000000ae000000 - 0000000100000000
[    7.015251] Setting variable MTRR 1, base: 2784MB, range: 32MB, type UC
[    7.021781] Setting variable MTRR 2, base: 2816MB, range: 256MB, type UC
[    7.028398] Setting variable MTRR 3, base: 3GB, range: 1GB, type UC
[    7.034583] range0: 0000000100000000 - 0000000480000000
[    7.039739] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    7.045923] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    7.052110] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[    7.058382] hole: 0000000450000000 - 0000000480000000
[    7.063365] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[    7.070067] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[    7.076768] After WB checking
[    7.079690] MTRR MAP PFN: 0000000000000000 - 0000000000480000
[    7.085361] After UC checking
[    7.088280] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    7.093952] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.099623] After sorting
[    7.102200] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    7.107871] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.113541]  gran_size: 512K 	chunk_size: 2G 	num_reg: 9  	lose cover RAM: 0G

[    7.122048] rangeX: 0000000000000000 - 00000000ae000000
[    7.127203] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    7.133388] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    7.139747] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    7.146364] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    7.152895] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    7.159426] rangeX: 0000000100000000 - 0000000450000000
[    7.164580] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    7.170767] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    7.176955] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    7.183225] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    7.189670] After WB checking
[    7.192590] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    7.198261] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.203933] After UC checking
[    7.206853] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    7.212524] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.218195] After sorting
[    7.220772] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    7.226443] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.232114]  gran_size: 1M 	chunk_size: 1M 	num_reg: 9  	lose cover RAM: 0G

[    7.240447] rangeX: 0000000000000000 - 00000000ae000000
[    7.245602] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    7.251788] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    7.258146] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    7.264762] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    7.271292] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    7.277822] rangeX: 0000000100000000 - 0000000450000000
[    7.282978] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    7.289165] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    7.295352] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    7.301625] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    7.308069] After WB checking
[    7.310990] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    7.316663] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.322335] After UC checking
[    7.325257] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    7.330929] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.336602] After sorting
[    7.339179] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    7.344850] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.350522]  gran_size: 1M 	chunk_size: 2M 	num_reg: 9  	lose cover RAM: 0G

[    7.358859] rangeX: 0000000000000000 - 00000000ae000000
[    7.364014] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    7.370201] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    7.376561] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    7.383178] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    7.389708] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    7.396239] rangeX: 0000000100000000 - 0000000450000000
[    7.401393] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    7.407581] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    7.413769] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    7.420042] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    7.426487] After WB checking
[    7.429409] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    7.435081] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.440752] After UC checking
[    7.443673] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    7.449345] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.455017] After sorting
[    7.457594] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    7.463265] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.468936]  gran_size: 1M 	chunk_size: 4M 	num_reg: 9  	lose cover RAM: 0G

[    7.477270] rangeX: 0000000000000000 - 00000000ae000000
[    7.482425] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    7.488612] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    7.494971] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    7.501587] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    7.508119] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    7.514650] rangeX: 0000000100000000 - 0000000450000000
[    7.519805] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    7.525993] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    7.532178] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    7.538451] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    7.544896] After WB checking
[    7.547817] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    7.553490] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.559160] After UC checking
[    7.562081] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    7.567753] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.573424] After sorting
[    7.576001] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    7.581672] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.587343]  gran_size: 1M 	chunk_size: 8M 	num_reg: 9  	lose cover RAM: 0G

[    7.595678] rangeX: 0000000000000000 - 00000000ae000000
[    7.600832] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    7.607018] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    7.613377] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    7.619993] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    7.626523] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    7.633053] rangeX: 0000000100000000 - 0000000450000000
[    7.638207] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    7.644488] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    7.650672] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    7.656944] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    7.663389] After WB checking
[    7.666311] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    7.671981] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.677652] After UC checking
[    7.680573] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    7.686243] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.691915] After sorting
[    7.694491] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    7.700162] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.705834]  gran_size: 1M 	chunk_size: 16M 	num_reg: 9  	lose cover RAM: 0G

[    7.714254] rangeX: 0000000000000000 - 00000000ae000000
[    7.719408] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    7.725595] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    7.731953] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    7.738568] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    7.745099] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    7.751628] rangeX: 0000000100000000 - 0000000450000000
[    7.756782] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    7.762969] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    7.769154] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    7.775428] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    7.781872] After WB checking
[    7.784793] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    7.790463] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.796134] After UC checking
[    7.799056] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    7.804726] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.810397] After sorting
[    7.812975] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    7.818646] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.824317]  gran_size: 1M 	chunk_size: 32M 	num_reg: 9  	lose cover RAM: 0G

[    7.832737] range0: 0000000000000000 - 00000000b0000000
[    7.837892] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    7.844078] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    7.850436] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[    7.857052] hole: 00000000ae000000 - 00000000b0000000
[    7.862036] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[    7.868566] rangeX: 0000000100000000 - 0000000450000000
[    7.873720] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    7.879906] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    7.886094] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    7.892365] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[    7.898809] After WB checking
[    7.901730] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[    7.907401] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.913071] After UC checking
[    7.915992] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    7.921663] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.927334] After sorting
[    7.929911] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    7.935582] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    7.941252]  gran_size: 1M 	chunk_size: 64M 	num_reg: 8  	lose cover RAM: 0G

[    7.949671] range0: 0000000000000000 - 00000000b0000000
[    7.954826] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    7.961011] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    7.967368] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[    7.973984] hole: 00000000ae000000 - 00000000b0000000
[    7.978967] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[    7.985496] rangeX: 0000000100000000 - 0000000450000000
[    7.990650] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    7.996837] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    8.003023] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    8.009295] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[    8.015739] After WB checking
[    8.018662] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[    8.024332] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    8.030004] After UC checking
[    8.032925] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    8.038595] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    8.044267] After sorting
[    8.046844] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    8.052516] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    8.058187]  gran_size: 1M 	chunk_size: 128M 	num_reg: 8  	lose cover RAM: 0G

[    8.066694] range0: 0000000000000000 - 00000000b0000000
[    8.071850] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    8.078036] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    8.084394] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[    8.091010] hole: 00000000ae000000 - 00000000b0000000
[    8.095994] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[    8.102525] rangeX: 0000000100000000 - 0000000450000000
[    8.107681] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    8.113867] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    8.120055] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    8.126327] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[    8.132772] After WB checking
[    8.135693] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[    8.141362] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    8.147033] After UC checking
[    8.149955] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    8.155625] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    8.161297] After sorting
[    8.163874] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    8.169545] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    8.175217]  gran_size: 1M 	chunk_size: 256M 	num_reg: 8  	lose cover RAM: 0G

[    8.183723] range0: 0000000000000000 - 00000000c0000000
[    8.188877] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    8.195063] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[    8.201249] hole: 00000000ae000000 - 00000000c0000000
[    8.206232] Setting variable MTRR 2, base: 2784MB, range: 32MB, type UC
[    8.212762] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[    8.219378] range0: 0000000100000000 - 0000000460000000
[    8.224532] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    8.230720] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    8.236907] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    8.243180] Setting variable MTRR 7, base: 17GB, range: 512MB, type WB
[    8.249624] hole: 0000000450000000 - 0000000460000000
[    8.254607] Setting variable MTRR 8, base: 17664MB, range: 256MB, type UC
[    8.261307] After WB checking
[    8.264229] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[    8.269898] MTRR MAP PFN: 0000000000100000 - 0000000000460000
[    8.275569] After UC checking
[    8.278489] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    8.284160] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    8.289829] After sorting
[    8.292407] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    8.298077] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    8.303747]  gran_size: 1M 	chunk_size: 512M 	num_reg: 9  	lose cover RAM: 0G

[    8.312252] range0: 0000000000000000 - 00000000c0000000
[    8.317407] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    8.323593] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[    8.329779] hole: 00000000ae000000 - 00000000c0000000
[    8.334763] Setting variable MTRR 2, base: 2784MB, range: 32MB, type UC
[    8.341294] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[    8.347909] range0: 0000000100000000 - 0000000480000000
[    8.353064] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    8.359252] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    8.365438] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[    8.371711] hole: 0000000450000000 - 0000000480000000
[    8.376693] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[    8.383395] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[    8.390099] After WB checking
[    8.393019] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[    8.398692] MTRR MAP PFN: 0000000000100000 - 0000000000480000
[    8.404363] After UC checking
[    8.407284] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    8.412955] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    8.418625] After sorting
[    8.421203] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    8.426874] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    8.432547]  gran_size: 1M 	chunk_size: 1G 	num_reg: 9  	lose cover RAM: 0G

[    8.440881] range0: 0000000000000000 - 0000000100000000
[    8.446036] Setting variable MTRR 0, base: 0GB, range: 4GB, type WB
[    8.452222] hole: 00000000ae000000 - 0000000100000000
[    8.457205] Setting variable MTRR 1, base: 2784MB, range: 32MB, type UC
[    8.463737] Setting variable MTRR 2, base: 2816MB, range: 256MB, type UC
[    8.470351] Setting variable MTRR 3, base: 3GB, range: 1GB, type UC
[    8.476537] range0: 0000000100000000 - 0000000480000000
[    8.481693] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    8.487880] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    8.494066] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[    8.500340] hole: 0000000450000000 - 0000000480000000
[    8.505323] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[    8.512025] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[    8.518727] After WB checking
[    8.521649] MTRR MAP PFN: 0000000000000000 - 0000000000480000
[    8.527320] After UC checking
[    8.530240] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    8.535911] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    8.541581] After sorting
[    8.544160] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    8.549830] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    8.555501]  gran_size: 1M 	chunk_size: 2G 	num_reg: 9  	lose cover RAM: 0G

[    8.563835] rangeX: 0000000000000000 - 00000000ae000000
[    8.568990] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    8.575176] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    8.581532] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    8.588149] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    8.594679] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    8.601209] rangeX: 0000000100000000 - 0000000450000000
[    8.606365] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    8.612551] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    8.618738] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    8.625010] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    8.631454] After WB checking
[    8.634376] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    8.640046] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    8.645717] After UC checking
[    8.648638] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    8.654308] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    8.659979] After sorting
[    8.662556] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    8.668278] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    8.673948]  gran_size: 2M 	chunk_size: 2M 	num_reg: 9  	lose cover RAM: 0G

[    8.682282] rangeX: 0000000000000000 - 00000000ae000000
[    8.687436] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    8.693624] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    8.699982] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    8.706598] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    8.713127] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    8.719658] rangeX: 0000000100000000 - 0000000450000000
[    8.724815] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    8.731001] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    8.737188] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    8.743463] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    8.749908] After WB checking
[    8.752830] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    8.758502] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    8.764174] After UC checking
[    8.767095] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    8.772766] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    8.778439] After sorting
[    8.781017] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    8.786688] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    8.792359]  gran_size: 2M 	chunk_size: 4M 	num_reg: 9  	lose cover RAM: 0G

[    8.800695] rangeX: 0000000000000000 - 00000000ae000000
[    8.805850] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    8.812037] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    8.818397] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    8.825013] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    8.831544] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    8.838076] rangeX: 0000000100000000 - 0000000450000000
[    8.843231] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    8.849418] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    8.855605] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    8.861879] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    8.868323] After WB checking
[    8.871244] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    8.876917] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    8.882588] After UC checking
[    8.885509] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    8.891180] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    8.896850] After sorting
[    8.899429] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    8.905101] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    8.910772]  gran_size: 2M 	chunk_size: 8M 	num_reg: 9  	lose cover RAM: 0G

[    8.919108] rangeX: 0000000000000000 - 00000000ae000000
[    8.924264] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    8.930451] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    8.936809] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    8.943425] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    8.949955] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    8.956486] rangeX: 0000000100000000 - 0000000450000000
[    8.961642] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    8.967829] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    8.974017] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    8.980290] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    8.986735] After WB checking
[    8.989656] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    8.995329] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.001000] After UC checking
[    9.003923] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    9.009594] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.015266] After sorting
[    9.017843] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    9.023514] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.029187]  gran_size: 2M 	chunk_size: 16M 	num_reg: 9  	lose cover RAM: 0G

[    9.037607] rangeX: 0000000000000000 - 00000000ae000000
[    9.042764] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    9.048951] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    9.055310] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    9.061927] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    9.068458] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    9.074989] rangeX: 0000000100000000 - 0000000450000000
[    9.080145] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    9.086331] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    9.092518] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    9.098791] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    9.105237] After WB checking
[    9.108157] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    9.113829] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.119501] After UC checking
[    9.122422] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    9.128094] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.133765] After sorting
[    9.136342] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    9.142014] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.147685]  gran_size: 2M 	chunk_size: 32M 	num_reg: 9  	lose cover RAM: 0G

[    9.156105] range0: 0000000000000000 - 00000000b0000000
[    9.161261] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    9.167447] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    9.173807] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[    9.180423] hole: 00000000ae000000 - 00000000b0000000
[    9.185406] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[    9.191936] rangeX: 0000000100000000 - 0000000450000000
[    9.197091] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    9.203279] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    9.209465] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    9.215737] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[    9.222181] After WB checking
[    9.225103] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[    9.230774] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.236446] After UC checking
[    9.239367] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    9.245038] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.250709] After sorting
[    9.253287] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    9.258960] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.264631]  gran_size: 2M 	chunk_size: 64M 	num_reg: 8  	lose cover RAM: 0G

[    9.273053] range0: 0000000000000000 - 00000000b0000000
[    9.278207] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    9.284394] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    9.290752] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[    9.297369] hole: 00000000ae000000 - 00000000b0000000
[    9.302352] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[    9.308882] rangeX: 0000000100000000 - 0000000450000000
[    9.314038] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    9.320227] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    9.326413] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    9.332686] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[    9.339132] After WB checking
[    9.342054] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[    9.347726] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.353397] After UC checking
[    9.356318] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    9.361991] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.367663] After sorting
[    9.370241] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    9.375913] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.381585]  gran_size: 2M 	chunk_size: 128M 	num_reg: 8  	lose cover RAM: 0G

[    9.390093] range0: 0000000000000000 - 00000000b0000000
[    9.395249] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    9.401437] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    9.407796] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[    9.414414] hole: 00000000ae000000 - 00000000b0000000
[    9.419398] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[    9.425928] rangeX: 0000000100000000 - 0000000450000000
[    9.431085] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    9.437273] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    9.443459] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    9.449732] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[    9.456177] After WB checking
[    9.459098] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[    9.464770] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.470442] After UC checking
[    9.473364] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    9.479036] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.484708] After sorting
[    9.487286] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    9.492957] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.498628]  gran_size: 2M 	chunk_size: 256M 	num_reg: 8  	lose cover RAM: 0G

[    9.507136] range0: 0000000000000000 - 00000000c0000000
[    9.512292] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    9.518480] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[    9.524667] hole: 00000000ae000000 - 00000000c0000000
[    9.529651] Setting variable MTRR 2, base: 2784MB, range: 32MB, type UC
[    9.536182] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[    9.542798] range0: 0000000100000000 - 0000000460000000
[    9.547953] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    9.554141] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    9.560328] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[    9.566602] Setting variable MTRR 7, base: 17GB, range: 512MB, type WB
[    9.573048] hole: 0000000450000000 - 0000000460000000
[    9.578032] Setting variable MTRR 8, base: 17664MB, range: 256MB, type UC
[    9.584736] After WB checking
[    9.587658] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[    9.593330] MTRR MAP PFN: 0000000000100000 - 0000000000460000
[    9.599003] After UC checking
[    9.601924] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    9.607596] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.613269] After sorting
[    9.615846] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    9.621517] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.627191]  gran_size: 2M 	chunk_size: 512M 	num_reg: 9  	lose cover RAM: 0G

[    9.635698] range0: 0000000000000000 - 00000000c0000000
[    9.640854] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    9.647040] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[    9.653228] hole: 00000000ae000000 - 00000000c0000000
[    9.658212] Setting variable MTRR 2, base: 2784MB, range: 32MB, type UC
[    9.664743] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[    9.671360] range0: 0000000100000000 - 0000000480000000
[    9.676516] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    9.682701] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    9.688889] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[    9.695246] hole: 0000000450000000 - 0000000480000000
[    9.700230] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[    9.706934] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[    9.713636] After WB checking
[    9.716557] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[    9.722228] MTRR MAP PFN: 0000000000100000 - 0000000000480000
[    9.727901] After UC checking
[    9.730820] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    9.736493] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.742163] After sorting
[    9.744742] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    9.750414] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.756085]  gran_size: 2M 	chunk_size: 1G 	num_reg: 9  	lose cover RAM: 0G

[    9.764419] range0: 0000000000000000 - 0000000100000000
[    9.769576] Setting variable MTRR 0, base: 0GB, range: 4GB, type WB
[    9.775763] hole: 00000000ae000000 - 0000000100000000
[    9.780748] Setting variable MTRR 1, base: 2784MB, range: 32MB, type UC
[    9.787277] Setting variable MTRR 2, base: 2816MB, range: 256MB, type UC
[    9.793894] Setting variable MTRR 3, base: 3GB, range: 1GB, type UC
[    9.800081] range0: 0000000100000000 - 0000000480000000
[    9.805237] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[    9.811425] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[    9.817612] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[    9.823885] hole: 0000000450000000 - 0000000480000000
[    9.828869] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[    9.835571] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[    9.842273] After WB checking
[    9.845196] MTRR MAP PFN: 0000000000000000 - 0000000000480000
[    9.850868] After UC checking
[    9.853789] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    9.859461] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.865132] After sorting
[    9.867710] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    9.873380] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.879052]  gran_size: 2M 	chunk_size: 2G 	num_reg: 9  	lose cover RAM: 0G

[    9.887388] rangeX: 0000000000000000 - 00000000ae000000
[    9.892544] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[    9.898730] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[    9.905090] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[    9.911707] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[    9.918238] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[    9.924769] rangeX: 0000000100000000 - 0000000450000000
[    9.929925] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[    9.936111] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[    9.942300] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[    9.948571] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[    9.955017] After WB checking
[    9.957938] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    9.963610] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.969282] After UC checking
[    9.972204] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    9.977874] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.983547] After sorting
[    9.986124] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[    9.991795] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[    9.997468]  gran_size: 4M 	chunk_size: 4M 	num_reg: 9  	lose cover RAM: 0G

[   10.005803] rangeX: 0000000000000000 - 00000000ae000000
[   10.010959] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   10.017146] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   10.023505] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[   10.030121] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[   10.036651] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[   10.043182] rangeX: 0000000100000000 - 0000000450000000
[   10.048337] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[   10.054522] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[   10.060708] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[   10.066981] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[   10.073424] After WB checking
[   10.076346] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   10.082016] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   10.087687] After UC checking
[   10.090610] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   10.096280] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   10.101951] After sorting
[   10.104528] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   10.110199] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   10.115871]  gran_size: 4M 	chunk_size: 8M 	num_reg: 9  	lose cover RAM: 0G

[   10.124205] rangeX: 0000000000000000 - 00000000ae000000
[   10.129361] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   10.135547] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   10.141905] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[   10.148523] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[   10.155054] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[   10.161584] rangeX: 0000000100000000 - 0000000450000000
[   10.166740] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[   10.172927] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[   10.179115] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[   10.185387] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[   10.191832] After WB checking
[   10.194753] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   10.200425] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   10.206097] After UC checking
[   10.209018] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   10.214690] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   10.220363] After sorting
[   10.222939] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   10.228611] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   10.234282]  gran_size: 4M 	chunk_size: 16M 	num_reg: 9  	lose cover RAM: 0G

[   10.242703] rangeX: 0000000000000000 - 00000000ae000000
[   10.247858] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   10.254044] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   10.260403] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[   10.267019] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[   10.273550] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[   10.280079] rangeX: 0000000100000000 - 0000000450000000
[   10.285235] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[   10.291422] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[   10.297608] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[   10.303880] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[   10.310326] After WB checking
[   10.313248] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   10.318917] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   10.324587] After UC checking
[   10.327509] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   10.333179] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   10.338851] After sorting
[   10.341429] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   10.347099] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   10.352770]  gran_size: 4M 	chunk_size: 32M 	num_reg: 9  	lose cover RAM: 0G

[   10.361191] range0: 0000000000000000 - 00000000b0000000
[   10.366347] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   10.372533] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   10.378892] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[   10.385509] hole: 00000000ae000000 - 00000000b0000000
[   10.390492] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[   10.397024] rangeX: 0000000100000000 - 0000000450000000
[   10.402179] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   10.408365] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   10.414551] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   10.420823] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[   10.427267] After WB checking
[   10.430190] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[   10.435860] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   10.441532] After UC checking
[   10.444452] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   10.450124] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   10.455795] After sorting
[   10.458374] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   10.464043] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   10.469715]  gran_size: 4M 	chunk_size: 64M 	num_reg: 8  	lose cover RAM: 0G

[   10.478136] range0: 0000000000000000 - 00000000b0000000
[   10.483292] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   10.489478] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   10.495834] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[   10.502450] hole: 00000000ae000000 - 00000000b0000000
[   10.507435] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[   10.513964] rangeX: 0000000100000000 - 0000000450000000
[   10.519120] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   10.525308] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   10.531494] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   10.537766] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[   10.544212] After WB checking
[   10.547133] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[   10.552804] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   10.558475] After UC checking
[   10.561398] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   10.567069] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   10.572740] After sorting
[   10.575319] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   10.580988] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   10.586661]  gran_size: 4M 	chunk_size: 128M 	num_reg: 8  	lose cover RAM: 0G

[   10.595167] range0: 0000000000000000 - 00000000b0000000
[   10.600323] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   10.606510] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   10.612869] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[   10.619486] hole: 00000000ae000000 - 00000000b0000000
[   10.624468] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[   10.630999] rangeX: 0000000100000000 - 0000000450000000
[   10.636155] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   10.642343] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   10.648529] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   10.654801] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[   10.661247] After WB checking
[   10.664169] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[   10.669839] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   10.675512] After UC checking
[   10.678432] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   10.684104] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   10.689777] After sorting
[   10.692354] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   10.698026] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   10.703698]  gran_size: 4M 	chunk_size: 256M 	num_reg: 8  	lose cover RAM: 0G

[   10.712205] range0: 0000000000000000 - 00000000c0000000
[   10.717406] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   10.723593] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[   10.729780] hole: 00000000ae000000 - 00000000c0000000
[   10.734764] Setting variable MTRR 2, base: 2784MB, range: 32MB, type UC
[   10.741296] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[   10.747913] range0: 0000000100000000 - 0000000460000000
[   10.753070] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   10.759258] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   10.765445] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   10.771718] Setting variable MTRR 7, base: 17GB, range: 512MB, type WB
[   10.778163] hole: 0000000450000000 - 0000000460000000
[   10.783146] Setting variable MTRR 8, base: 17664MB, range: 256MB, type UC
[   10.789850] After WB checking
[   10.792771] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[   10.798443] MTRR MAP PFN: 0000000000100000 - 0000000000460000
[   10.804115] After UC checking
[   10.807036] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   10.812708] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   10.818381] After sorting
[   10.820959] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   10.826629] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   10.832302]  gran_size: 4M 	chunk_size: 512M 	num_reg: 9  	lose cover RAM: 0G

[   10.840809] range0: 0000000000000000 - 00000000c0000000
[   10.845965] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   10.852153] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[   10.858340] hole: 00000000ae000000 - 00000000c0000000
[   10.863324] Setting variable MTRR 2, base: 2784MB, range: 32MB, type UC
[   10.869857] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[   10.876474] range0: 0000000100000000 - 0000000480000000
[   10.881629] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   10.887816] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   10.894003] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[   10.900277] hole: 0000000450000000 - 0000000480000000
[   10.905261] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[   10.911964] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[   10.918667] After WB checking
[   10.921589] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[   10.927260] MTRR MAP PFN: 0000000000100000 - 0000000000480000
[   10.932933] After UC checking
[   10.935853] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   10.941525] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   10.947198] After sorting
[   10.949775] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   10.955448] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   10.961120]  gran_size: 4M 	chunk_size: 1G 	num_reg: 9  	lose cover RAM: 0G

[   10.969456] range0: 0000000000000000 - 0000000100000000
[   10.974611] Setting variable MTRR 0, base: 0GB, range: 4GB, type WB
[   10.980799] hole: 00000000ae000000 - 0000000100000000
[   10.985782] Setting variable MTRR 1, base: 2784MB, range: 32MB, type UC
[   10.992314] Setting variable MTRR 2, base: 2816MB, range: 256MB, type UC
[   10.998930] Setting variable MTRR 3, base: 3GB, range: 1GB, type UC
[   11.005118] range0: 0000000100000000 - 0000000480000000
[   11.010273] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   11.016461] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   11.022648] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[   11.028922] hole: 0000000450000000 - 0000000480000000
[   11.033906] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[   11.040608] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[   11.047310] After WB checking
[   11.050231] MTRR MAP PFN: 0000000000000000 - 0000000000480000
[   11.055902] After UC checking
[   11.058822] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   11.064493] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   11.070166] After sorting
[   11.072744] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   11.078416] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   11.084089]  gran_size: 4M 	chunk_size: 2G 	num_reg: 9  	lose cover RAM: 0G

[   11.092423] rangeX: 0000000000000000 - 00000000ae000000
[   11.097579] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   11.103767] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   11.110126] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[   11.116743] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[   11.123273] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[   11.129804] rangeX: 0000000100000000 - 0000000450000000
[   11.134961] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[   11.141147] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[   11.147335] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[   11.153609] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[   11.160054] After WB checking
[   11.162975] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   11.168647] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   11.174319] After UC checking
[   11.177241] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   11.182913] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   11.188584] After sorting
[   11.191163] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   11.196834] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   11.202506]  gran_size: 8M 	chunk_size: 8M 	num_reg: 9  	lose cover RAM: 0G

[   11.210843] rangeX: 0000000000000000 - 00000000ae000000
[   11.215999] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   11.222185] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   11.228545] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[   11.235161] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[   11.241692] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[   11.248224] rangeX: 0000000100000000 - 0000000450000000
[   11.253380] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[   11.259568] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[   11.265756] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[   11.272030] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[   11.278476] After WB checking
[   11.281397] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   11.287068] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   11.292740] After UC checking
[   11.295662] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   11.301333] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   11.307004] After sorting
[   11.309581] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   11.315252] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   11.320923]  gran_size: 8M 	chunk_size: 16M 	num_reg: 9  	lose cover RAM: 0G

[   11.329344] rangeX: 0000000000000000 - 00000000ae000000
[   11.334500] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   11.340686] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   11.347046] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[   11.353662] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[   11.360193] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[   11.366725] rangeX: 0000000100000000 - 0000000450000000
[   11.371880] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[   11.378067] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[   11.384256] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[   11.390529] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[   11.396973] After WB checking
[   11.399895] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   11.405566] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   11.411237] After UC checking
[   11.414158] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   11.419829] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   11.425501] After sorting
[   11.428079] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   11.433750] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   11.439421]  gran_size: 8M 	chunk_size: 32M 	num_reg: 9  	lose cover RAM: 0G

[   11.447843] range0: 0000000000000000 - 00000000b0000000
[   11.452998] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   11.459185] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   11.465542] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[   11.472158] hole: 00000000ae000000 - 00000000b0000000
[   11.477142] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[   11.483671] rangeX: 0000000100000000 - 0000000450000000
[   11.488826] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   11.495012] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   11.501197] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   11.507469] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[   11.513913] After WB checking
[   11.516834] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[   11.522504] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   11.528176] After UC checking
[   11.531097] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   11.536767] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   11.542438] After sorting
[   11.545015] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   11.550686] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   11.556357]  gran_size: 8M 	chunk_size: 64M 	num_reg: 8  	lose cover RAM: 0G

[   11.564777] range0: 0000000000000000 - 00000000b0000000
[   11.569931] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   11.576117] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   11.582475] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[   11.589091] hole: 00000000ae000000 - 00000000b0000000
[   11.594075] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[   11.600604] rangeX: 0000000100000000 - 0000000450000000
[   11.605760] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   11.611947] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   11.618133] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   11.624406] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[   11.630850] After WB checking
[   11.633772] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[   11.639441] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   11.645113] After UC checking
[   11.648035] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   11.653705] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   11.659376] After sorting
[   11.661953] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   11.667623] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   11.673294]  gran_size: 8M 	chunk_size: 128M 	num_reg: 8  	lose cover RAM: 0G

[   11.681799] range0: 0000000000000000 - 00000000b0000000
[   11.686954] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   11.693139] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   11.699498] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[   11.706114] hole: 00000000ae000000 - 00000000b0000000
[   11.711098] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[   11.717629] rangeX: 0000000100000000 - 0000000450000000
[   11.722784] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   11.728968] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   11.735154] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   11.741452] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[   11.747895] After WB checking
[   11.750816] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[   11.756485] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   11.762156] After UC checking
[   11.765076] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   11.770747] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   11.776418] After sorting
[   11.778995] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   11.784666] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   11.790337]  gran_size: 8M 	chunk_size: 256M 	num_reg: 8  	lose cover RAM: 0G

[   11.798844] range0: 0000000000000000 - 00000000c0000000
[   11.804000] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   11.810186] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[   11.816372] hole: 00000000ae000000 - 00000000c0000000
[   11.821357] Setting variable MTRR 2, base: 2784MB, range: 32MB, type UC
[   11.827889] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[   11.834504] range0: 0000000100000000 - 0000000460000000
[   11.839661] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   11.845849] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   11.852037] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   11.858309] Setting variable MTRR 7, base: 17GB, range: 512MB, type WB
[   11.864754] hole: 0000000450000000 - 0000000460000000
[   11.869739] Setting variable MTRR 8, base: 17664MB, range: 256MB, type UC
[   11.876443] After WB checking
[   11.879364] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[   11.885035] MTRR MAP PFN: 0000000000100000 - 0000000000460000
[   11.890709] After UC checking
[   11.893629] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   11.899301] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   11.904972] After sorting
[   11.907550] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   11.913221] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   11.918892]  gran_size: 8M 	chunk_size: 512M 	num_reg: 9  	lose cover RAM: 0G

[   11.927399] range0: 0000000000000000 - 00000000c0000000
[   11.932553] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   11.938740] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[   11.944927] hole: 00000000ae000000 - 00000000c0000000
[   11.949910] Setting variable MTRR 2, base: 2784MB, range: 32MB, type UC
[   11.956440] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[   11.963056] range0: 0000000100000000 - 0000000480000000
[   11.968211] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   11.974398] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   11.980585] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[   11.986855] hole: 0000000450000000 - 0000000480000000
[   11.991840] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[   11.998542] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[   12.005244] After WB checking
[   12.008166] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[   12.013836] MTRR MAP PFN: 0000000000100000 - 0000000000480000
[   12.019507] After UC checking
[   12.022429] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   12.028100] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   12.033771] After sorting
[   12.036348] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   12.042021] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   12.047692]  gran_size: 8M 	chunk_size: 1G 	num_reg: 9  	lose cover RAM: 0G

[   12.056028] range0: 0000000000000000 - 0000000100000000
[   12.061184] Setting variable MTRR 0, base: 0GB, range: 4GB, type WB
[   12.067369] hole: 00000000ae000000 - 0000000100000000
[   12.072353] Setting variable MTRR 1, base: 2784MB, range: 32MB, type UC
[   12.078883] Setting variable MTRR 2, base: 2816MB, range: 256MB, type UC
[   12.085499] Setting variable MTRR 3, base: 3GB, range: 1GB, type UC
[   12.091687] range0: 0000000100000000 - 0000000480000000
[   12.096842] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   12.103029] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   12.109216] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[   12.115488] hole: 0000000450000000 - 0000000480000000
[   12.120471] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[   12.127174] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[   12.133876] After WB checking
[   12.136797] MTRR MAP PFN: 0000000000000000 - 0000000000480000
[   12.142469] After UC checking
[   12.145389] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   12.151061] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   12.156734] After sorting
[   12.159310] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   12.164982] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   12.170653]  gran_size: 8M 	chunk_size: 2G 	num_reg: 9  	lose cover RAM: 0G

[   12.178988] rangeX: 0000000000000000 - 00000000ae000000
[   12.184141] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   12.190326] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   12.196684] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[   12.203299] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[   12.209830] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[   12.216360] rangeX: 0000000100000000 - 0000000450000000
[   12.221515] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[   12.227701] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[   12.233889] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[   12.240159] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[   12.246604] After WB checking
[   12.249525] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   12.255196] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   12.260867] After UC checking
[   12.263789] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   12.269459] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   12.275131] After sorting
[   12.277708] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   12.283379] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   12.289049]  gran_size: 16M 	chunk_size: 16M 	num_reg: 9  	lose cover RAM: 0G

[   12.297556] rangeX: 0000000000000000 - 00000000ae000000
[   12.302711] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   12.308897] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   12.315255] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[   12.321871] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[   12.328401] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[   12.334931] rangeX: 0000000100000000 - 0000000450000000
[   12.340087] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[   12.346273] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[   12.352458] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[   12.358731] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[   12.365175] After WB checking
[   12.368096] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   12.373766] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   12.379437] After UC checking
[   12.382358] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   12.388028] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   12.393700] After sorting
[   12.396277] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   12.401948] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   12.407620]  gran_size: 16M 	chunk_size: 32M 	num_reg: 9  	lose cover RAM: 0G

[   12.416126] range0: 0000000000000000 - 00000000b0000000
[   12.421280] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   12.427466] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   12.433825] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[   12.440440] hole: 00000000ae000000 - 00000000b0000000
[   12.445422] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[   12.451952] rangeX: 0000000100000000 - 0000000450000000
[   12.457107] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   12.463291] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   12.469477] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   12.475748] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[   12.482191] After WB checking
[   12.485113] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[   12.490782] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   12.496452] After UC checking
[   12.499373] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   12.505043] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   12.510713] After sorting
[   12.513289] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   12.518960] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   12.524631]  gran_size: 16M 	chunk_size: 64M 	num_reg: 8  	lose cover RAM: 0G

[   12.533136] range0: 0000000000000000 - 00000000b0000000
[   12.538290] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   12.544477] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   12.550835] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[   12.557451] hole: 00000000ae000000 - 00000000b0000000
[   12.562433] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[   12.568964] rangeX: 0000000100000000 - 0000000450000000
[   12.574118] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   12.580305] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   12.586491] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   12.592763] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[   12.599207] After WB checking
[   12.602128] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[   12.607800] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   12.613469] After UC checking
[   12.616391] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   12.622061] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   12.627733] After sorting
[   12.630310] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   12.635981] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   12.641653]  gran_size: 16M 	chunk_size: 128M 	num_reg: 8  	lose cover RAM: 0G

[   12.650245] range0: 0000000000000000 - 00000000b0000000
[   12.655401] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   12.661587] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   12.667945] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[   12.674559] hole: 00000000ae000000 - 00000000b0000000
[   12.679542] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[   12.686071] rangeX: 0000000100000000 - 0000000450000000
[   12.691226] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   12.697413] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   12.703598] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   12.709869] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[   12.716313] After WB checking
[   12.719234] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[   12.724904] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   12.730575] After UC checking
[   12.733496] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   12.739167] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   12.744838] After sorting
[   12.747414] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   12.753084] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   12.758756]  gran_size: 16M 	chunk_size: 256M 	num_reg: 8  	lose cover RAM: 0G

[   12.767388] range0: 0000000000000000 - 00000000c0000000
[   12.772542] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   12.778728] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[   12.784913] hole: 00000000ae000000 - 00000000c0000000
[   12.789896] Setting variable MTRR 2, base: 2784MB, range: 32MB, type UC
[   12.796424] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[   12.803040] range0: 0000000100000000 - 0000000460000000
[   12.808193] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   12.814380] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   12.820564] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   12.826836] Setting variable MTRR 7, base: 17GB, range: 512MB, type WB
[   12.833279] hole: 0000000450000000 - 0000000460000000
[   12.838262] Setting variable MTRR 8, base: 17664MB, range: 256MB, type UC
[   12.844964] After WB checking
[   12.847887] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[   12.853556] MTRR MAP PFN: 0000000000100000 - 0000000000460000
[   12.859228] After UC checking
[   12.862149] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   12.867819] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   12.873491] After sorting
[   12.876067] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   12.881738] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   12.887408]  gran_size: 16M 	chunk_size: 512M 	num_reg: 9  	lose cover RAM: 0G

[   12.895999] range0: 0000000000000000 - 00000000c0000000
[   12.901154] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   12.907340] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[   12.913526] hole: 00000000ae000000 - 00000000c0000000
[   12.918510] Setting variable MTRR 2, base: 2784MB, range: 32MB, type UC
[   12.925040] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[   12.931656] range0: 0000000100000000 - 0000000480000000
[   12.936810] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   12.942997] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   12.949183] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[   12.955455] hole: 0000000450000000 - 0000000480000000
[   12.960440] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[   12.967142] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[   12.973844] After WB checking
[   12.976765] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[   12.982436] MTRR MAP PFN: 0000000000100000 - 0000000000480000
[   12.988109] After UC checking
[   12.991030] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   12.996701] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   13.002373] After sorting
[   13.004951] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   13.010623] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   13.016296]  gran_size: 16M 	chunk_size: 1G 	num_reg: 9  	lose cover RAM: 0G

[   13.024717] range0: 0000000000000000 - 0000000100000000
[   13.029872] Setting variable MTRR 0, base: 0GB, range: 4GB, type WB
[   13.036060] hole: 00000000ae000000 - 0000000100000000
[   13.041044] Setting variable MTRR 1, base: 2784MB, range: 32MB, type UC
[   13.047575] Setting variable MTRR 2, base: 2816MB, range: 256MB, type UC
[   13.054191] Setting variable MTRR 3, base: 3GB, range: 1GB, type UC
[   13.060379] range0: 0000000100000000 - 0000000480000000
[   13.065534] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   13.071722] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   13.077909] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[   13.084183] hole: 0000000450000000 - 0000000480000000
[   13.089166] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[   13.095868] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[   13.102570] After WB checking
[   13.105491] MTRR MAP PFN: 0000000000000000 - 0000000000480000
[   13.111164] After UC checking
[   13.114085] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   13.119757] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   13.125427] After sorting
[   13.128005] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   13.133675] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   13.139347]  gran_size: 16M 	chunk_size: 2G 	num_reg: 9  	lose cover RAM: 0G

[   13.147769] rangeX: 0000000000000000 - 00000000ae000000
[   13.152925] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   13.159111] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   13.165471] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[   13.172088] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[   13.178618] Setting variable MTRR 4, base: 2752MB, range: 32MB, type WB
[   13.185149] rangeX: 0000000100000000 - 0000000450000000
[   13.190305] Setting variable MTRR 5, base: 4GB, range: 4GB, type WB
[   13.196493] Setting variable MTRR 6, base: 8GB, range: 8GB, type WB
[   13.202681] Setting variable MTRR 7, base: 16GB, range: 1GB, type WB
[   13.208956] Setting variable MTRR 8, base: 17GB, range: 256MB, type WB
[   13.215400] After WB checking
[   13.218322] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   13.223994] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   13.229666] After UC checking
[   13.232588] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   13.238260] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   13.243931] After sorting
[   13.246509] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   13.252181] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   13.257854]  gran_size: 32M 	chunk_size: 32M 	num_reg: 9  	lose cover RAM: 0G

[   13.266361] range0: 0000000000000000 - 00000000b0000000
[   13.271517] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   13.277704] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   13.284064] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[   13.290682] hole: 00000000ae000000 - 00000000b0000000
[   13.295666] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[   13.302196] rangeX: 0000000100000000 - 0000000450000000
[   13.307351] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   13.313539] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   13.319725] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   13.325998] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[   13.332443] After WB checking
[   13.335365] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[   13.341037] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   13.346708] After UC checking
[   13.349629] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   13.355300] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   13.360973] After sorting
[   13.363550] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   13.369221] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   13.374893]  gran_size: 32M 	chunk_size: 64M 	num_reg: 8  	lose cover RAM: 0G

[   13.383400] range0: 0000000000000000 - 00000000b0000000
[   13.388555] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   13.394743] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   13.401100] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[   13.407717] hole: 00000000ae000000 - 00000000b0000000
[   13.412701] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[   13.419232] rangeX: 0000000100000000 - 0000000450000000
[   13.424387] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   13.430574] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   13.436760] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   13.443033] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[   13.449477] After WB checking
[   13.452398] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[   13.458068] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   13.463740] After UC checking
[   13.466660] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   13.472331] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   13.478003] After sorting
[   13.480580] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   13.486252] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   13.491922]  gran_size: 32M 	chunk_size: 128M 	num_reg: 8  	lose cover RAM: 0G

[   13.500516] range0: 0000000000000000 - 00000000b0000000
[   13.505671] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   13.511859] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   13.518217] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[   13.524833] hole: 00000000ae000000 - 00000000b0000000
[   13.529817] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[   13.536348] rangeX: 0000000100000000 - 0000000450000000
[   13.541503] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   13.547689] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   13.553876] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   13.560149] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[   13.566593] After WB checking
[   13.569515] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[   13.575185] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   13.580856] After UC checking
[   13.583778] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   13.589448] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   13.595120] After sorting
[   13.597698] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   13.603370] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   13.609040]  gran_size: 32M 	chunk_size: 256M 	num_reg: 8  	lose cover RAM: 0G

[   13.617633] range0: 0000000000000000 - 00000000c0000000
[   13.622789] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   13.628974] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[   13.635161] hole: 00000000ae000000 - 00000000c0000000
[   13.640145] Setting variable MTRR 2, base: 2784MB, range: 32MB, type UC
[   13.646676] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[   13.653294] range0: 0000000100000000 - 0000000460000000
[   13.658450] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   13.664637] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   13.670824] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   13.677098] Setting variable MTRR 7, base: 17GB, range: 512MB, type WB
[   13.683542] hole: 0000000450000000 - 0000000460000000
[   13.688525] Setting variable MTRR 8, base: 17664MB, range: 256MB, type UC
[   13.695227] After WB checking
[   13.698149] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[   13.703820] MTRR MAP PFN: 0000000000100000 - 0000000000460000
[   13.709492] After UC checking
[   13.712414] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   13.718086] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   13.723757] After sorting
[   13.726334] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   13.732007] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   13.737678]  gran_size: 32M 	chunk_size: 512M 	num_reg: 9  	lose cover RAM: 0G

[   13.746271] range0: 0000000000000000 - 00000000c0000000
[   13.751427] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   13.757613] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[   13.763799] hole: 00000000ae000000 - 00000000c0000000
[   13.768784] Setting variable MTRR 2, base: 2784MB, range: 32MB, type UC
[   13.775314] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[   13.781931] range0: 0000000100000000 - 0000000480000000
[   13.787142] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   13.793328] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   13.799516] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[   13.805790] hole: 0000000450000000 - 0000000480000000
[   13.810774] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[   13.817477] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[   13.824179] After WB checking
[   13.827100] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[   13.832772] MTRR MAP PFN: 0000000000100000 - 0000000000480000
[   13.838443] After UC checking
[   13.841364] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   13.847035] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   13.852707] After sorting
[   13.855284] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   13.860955] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   13.866627]  gran_size: 32M 	chunk_size: 1G 	num_reg: 9  	lose cover RAM: 0G

[   13.875048] range0: 0000000000000000 - 0000000100000000
[   13.880203] Setting variable MTRR 0, base: 0GB, range: 4GB, type WB
[   13.886391] hole: 00000000ae000000 - 0000000100000000
[   13.891374] Setting variable MTRR 1, base: 2784MB, range: 32MB, type UC
[   13.897905] Setting variable MTRR 2, base: 2816MB, range: 256MB, type UC
[   13.904521] Setting variable MTRR 3, base: 3GB, range: 1GB, type UC
[   13.910707] range0: 0000000100000000 - 0000000480000000
[   13.915864] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   13.922050] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   13.928238] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[   13.934510] hole: 0000000450000000 - 0000000480000000
[   13.939495] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[   13.946198] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[   13.952900] After WB checking
[   13.955822] MTRR MAP PFN: 0000000000000000 - 0000000000480000
[   13.961493] After UC checking
[   13.964414] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   13.970087] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   13.975757] After sorting
[   13.978336] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   13.984007] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   13.989678]  gran_size: 32M 	chunk_size: 2G 	num_reg: 9  	lose cover RAM: 0G

[   13.998100] rangeX: 0000000000000000 - 00000000ac000000
[   14.003256] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   14.009443] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   14.015803] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[   14.022419] Setting variable MTRR 3, base: 2688MB, range: 64MB, type WB
[   14.028952] rangeX: 0000000100000000 - 0000000450000000
[   14.034107] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   14.040294] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   14.046483] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   14.052756] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[   14.059202] After WB checking
[   14.062123] MTRR MAP PFN: 0000000000000000 - 00000000000ac000
[   14.067795] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   14.073468] After UC checking
[   14.076389] MTRR MAP PFN: 0000000000000000 - 00000000000ac000
[   14.082059] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   14.087730] After sorting
[   14.090308] MTRR MAP PFN: 0000000000000000 - 00000000000ac000
[   14.095979] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   14.101649]  gran_size: 64M 	chunk_size: 64M 	num_reg: 8  	lose cover RAM: 32M

[   14.110241] range0: 0000000000000000 - 00000000b0000000
[   14.115395] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   14.121581] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   14.127940] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[   14.134555] hole: 00000000ac000000 - 00000000b0000000
[   14.139538] Setting variable MTRR 3, base: 2752MB, range: 64MB, type UC
[   14.146068] rangeX: 0000000100000000 - 0000000450000000
[   14.151223] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   14.157410] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   14.163596] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   14.169868] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[   14.176312] After WB checking
[   14.179233] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[   14.184904] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   14.190575] After UC checking
[   14.193496] MTRR MAP PFN: 0000000000000000 - 00000000000ac000
[   14.199166] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   14.204837] After sorting
[   14.207413] MTRR MAP PFN: 0000000000000000 - 00000000000ac000
[   14.213084] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   14.218755]  gran_size: 64M 	chunk_size: 128M 	num_reg: 8  	lose cover RAM: 32M

[   14.227432] range0: 0000000000000000 - 00000000b0000000
[   14.232588] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   14.238774] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   14.245132] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[   14.251748] hole: 00000000ac000000 - 00000000b0000000
[   14.256732] Setting variable MTRR 3, base: 2752MB, range: 64MB, type UC
[   14.263263] rangeX: 0000000100000000 - 0000000450000000
[   14.268418] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   14.274604] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   14.280790] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   14.287062] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[   14.293506] After WB checking
[   14.296428] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[   14.302099] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   14.307768] After UC checking
[   14.310690] MTRR MAP PFN: 0000000000000000 - 00000000000ac000
[   14.316362] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   14.322033] After sorting
[   14.324611] MTRR MAP PFN: 0000000000000000 - 00000000000ac000
[   14.330282] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   14.335953]  gran_size: 64M 	chunk_size: 256M 	num_reg: 8  	lose cover RAM: 32M

[   14.344631] range0: 0000000000000000 - 00000000c0000000
[   14.349787] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   14.355974] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[   14.362160] hole: 00000000ac000000 - 00000000c0000000
[   14.367142] Setting variable MTRR 2, base: 2752MB, range: 64MB, type UC
[   14.373671] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[   14.380289] range0: 0000000100000000 - 0000000460000000
[   14.385443] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   14.391629] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   14.397817] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   14.404090] Setting variable MTRR 7, base: 17GB, range: 512MB, type WB
[   14.410534] hole: 0000000450000000 - 0000000460000000
[   14.415516] Setting variable MTRR 8, base: 17664MB, range: 256MB, type UC
[   14.422217] After WB checking
[   14.425139] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[   14.430810] MTRR MAP PFN: 0000000000100000 - 0000000000460000
[   14.436480] After UC checking
[   14.439400] MTRR MAP PFN: 0000000000000000 - 00000000000ac000
[   14.445071] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   14.450742] After sorting
[   14.453318] MTRR MAP PFN: 0000000000000000 - 00000000000ac000
[   14.458989] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   14.464660]  gran_size: 64M 	chunk_size: 512M 	num_reg: 9  	lose cover RAM: 32M

[   14.473337] range0: 0000000000000000 - 00000000c0000000
[   14.478493] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   14.484679] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[   14.490865] hole: 00000000ac000000 - 00000000c0000000
[   14.495849] Setting variable MTRR 2, base: 2752MB, range: 64MB, type UC
[   14.502380] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[   14.508998] range0: 0000000100000000 - 0000000480000000
[   14.514153] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   14.520339] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   14.526526] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[   14.532799] hole: 0000000450000000 - 0000000480000000
[   14.537782] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[   14.544484] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[   14.551186] After WB checking
[   14.554107] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[   14.559777] MTRR MAP PFN: 0000000000100000 - 0000000000480000
[   14.565448] After UC checking
[   14.568367] MTRR MAP PFN: 0000000000000000 - 00000000000ac000
[   14.574038] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   14.579709] After sorting
[   14.582287] MTRR MAP PFN: 0000000000000000 - 00000000000ac000
[   14.587956] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   14.593626]  gran_size: 64M 	chunk_size: 1G 	num_reg: 9  	lose cover RAM: 32M

[   14.602132] range0: 0000000000000000 - 0000000100000000
[   14.607287] Setting variable MTRR 0, base: 0GB, range: 4GB, type WB
[   14.613474] hole: 00000000ac000000 - 0000000100000000
[   14.618458] Setting variable MTRR 1, base: 2752MB, range: 64MB, type UC
[   14.624988] Setting variable MTRR 2, base: 2816MB, range: 256MB, type UC
[   14.631603] Setting variable MTRR 3, base: 3GB, range: 1GB, type UC
[   14.637788] range0: 0000000100000000 - 0000000480000000
[   14.642944] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   14.649129] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   14.655315] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[   14.661588] hole: 0000000450000000 - 0000000480000000
[   14.666569] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[   14.673271] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[   14.679972] After WB checking
[   14.682892] MTRR MAP PFN: 0000000000000000 - 0000000000480000
[   14.688563] After UC checking
[   14.691483] MTRR MAP PFN: 0000000000000000 - 00000000000ac000
[   14.697153] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   14.702823] After sorting
[   14.705400] MTRR MAP PFN: 0000000000000000 - 00000000000ac000
[   14.711071] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   14.716741]  gran_size: 64M 	chunk_size: 2G 	num_reg: 9  	lose cover RAM: 32M

[   14.725246] rangeX: 0000000000000000 - 00000000a8000000
[   14.730402] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   14.736587] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   14.742944] Setting variable MTRR 2, base: 2560MB, range: 128MB, type WB
[   14.749559] rangeX: 0000000100000000 - 0000000450000000
[   14.754714] Setting variable MTRR 3, base: 4GB, range: 4GB, type WB
[   14.760900] Setting variable MTRR 4, base: 8GB, range: 8GB, type WB
[   14.767085] Setting variable MTRR 5, base: 16GB, range: 1GB, type WB
[   14.773357] Setting variable MTRR 6, base: 17GB, range: 256MB, type WB
[   14.779799] After WB checking
[   14.782720] MTRR MAP PFN: 0000000000000000 - 00000000000a8000
[   14.788389] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   14.794059] After UC checking
[   14.796980] MTRR MAP PFN: 0000000000000000 - 00000000000a8000
[   14.802650] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   14.808321] After sorting
[   14.810932] MTRR MAP PFN: 0000000000000000 - 00000000000a8000
[   14.816601] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   14.822271]  gran_size: 128M 	chunk_size: 128M 	num_reg: 7  	lose cover RAM: 96M

[   14.831033] range0: 0000000000000000 - 00000000b0000000
[   14.836188] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   14.842374] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   14.848732] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[   14.855348] hole: 00000000a8000000 - 00000000b0000000
[   14.860331] Setting variable MTRR 3, base: 2688MB, range: 128MB, type UC
[   14.866946] rangeX: 0000000100000000 - 0000000450000000
[   14.872100] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   14.878287] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   14.884473] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   14.890745] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[   14.897189] After WB checking
[   14.900110] MTRR MAP PFN: 0000000000000000 - 00000000000b0000
[   14.905780] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   14.911451] After UC checking
[   14.914372] MTRR MAP PFN: 0000000000000000 - 00000000000a8000
[   14.920042] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   14.925713] After sorting
[   14.928290] MTRR MAP PFN: 0000000000000000 - 00000000000a8000
[   14.933960] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   14.939631]  gran_size: 128M 	chunk_size: 256M 	num_reg: 8  	lose cover RAM: 96M

[   14.948394] range0: 0000000000000000 - 00000000c0000000
[   14.953548] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   14.959733] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[   14.965919] hole: 00000000a8000000 - 00000000c0000000
[   14.970902] Setting variable MTRR 2, base: 2688MB, range: 128MB, type UC
[   14.977516] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[   14.984132] range0: 0000000100000000 - 0000000460000000
[   14.989287] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   14.995472] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   15.001658] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   15.007929] Setting variable MTRR 7, base: 17GB, range: 512MB, type WB
[   15.014373] hole: 0000000450000000 - 0000000460000000
[   15.019356] Setting variable MTRR 8, base: 17664MB, range: 256MB, type UC
[   15.026058] After WB checking
[   15.028979] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[   15.034649] MTRR MAP PFN: 0000000000100000 - 0000000000460000
[   15.040318] After UC checking
[   15.043240] MTRR MAP PFN: 0000000000000000 - 00000000000a8000
[   15.048910] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   15.054580] After sorting
[   15.057158] MTRR MAP PFN: 0000000000000000 - 00000000000a8000
[   15.062826] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   15.068496]  gran_size: 128M 	chunk_size: 512M 	num_reg: 9  	lose cover RAM: 96M

[   15.077261] range0: 0000000000000000 - 00000000c0000000
[   15.082415] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   15.088603] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[   15.094789] hole: 00000000a8000000 - 00000000c0000000
[   15.099772] Setting variable MTRR 2, base: 2688MB, range: 128MB, type UC
[   15.106388] Setting variable MTRR 3, base: 2816MB, range: 256MB, type UC
[   15.113004] range0: 0000000100000000 - 0000000480000000
[   15.118159] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   15.124344] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   15.130530] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[   15.136802] hole: 0000000450000000 - 0000000480000000
[   15.141785] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[   15.148485] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[   15.155187] After WB checking
[   15.158109] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[   15.163778] MTRR MAP PFN: 0000000000100000 - 0000000000480000
[   15.169451] After UC checking
[   15.172370] MTRR MAP PFN: 0000000000000000 - 00000000000a8000
[   15.178041] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   15.183712] After sorting
[   15.186289] MTRR MAP PFN: 0000000000000000 - 00000000000a8000
[   15.191961] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   15.197630]  gran_size: 128M 	chunk_size: 1G 	num_reg: 9  	lose cover RAM: 96M

[   15.206221] range0: 0000000000000000 - 0000000100000000
[   15.211376] Setting variable MTRR 0, base: 0GB, range: 4GB, type WB
[   15.217562] hole: 00000000a8000000 - 0000000100000000
[   15.222545] Setting variable MTRR 1, base: 2688MB, range: 128MB, type UC
[   15.229160] Setting variable MTRR 2, base: 2816MB, range: 256MB, type UC
[   15.235775] Setting variable MTRR 3, base: 3GB, range: 1GB, type UC
[   15.241962] range0: 0000000100000000 - 0000000480000000
[   15.247117] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   15.253303] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   15.259488] Setting variable MTRR 6, base: 16GB, range: 2GB, type WB
[   15.265760] hole: 0000000450000000 - 0000000480000000
[   15.270743] Setting variable MTRR 7, base: 17664MB, range: 256MB, type UC
[   15.277444] Setting variable MTRR 8, base: 17920MB, range: 512MB, type UC
[   15.284148] After WB checking
[   15.287069] MTRR MAP PFN: 0000000000000000 - 0000000000480000
[   15.292740] After UC checking
[   15.295659] MTRR MAP PFN: 0000000000000000 - 00000000000a8000
[   15.301330] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   15.306999] After sorting
[   15.309577] MTRR MAP PFN: 0000000000000000 - 00000000000a8000
[   15.315246] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   15.320917]  gran_size: 128M 	chunk_size: 2G 	num_reg: 9  	lose cover RAM: 96M

[   15.329507] rangeX: 0000000000000000 - 00000000a0000000
[   15.334661] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   15.340847] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   15.347205] rangeX: 0000000100000000 - 0000000450000000
[   15.352359] Setting variable MTRR 2, base: 4GB, range: 4GB, type WB
[   15.358545] Setting variable MTRR 3, base: 8GB, range: 8GB, type WB
[   15.364730] Setting variable MTRR 4, base: 16GB, range: 1GB, type WB
[   15.371002] Setting variable MTRR 5, base: 17GB, range: 256MB, type WB
[   15.377447] After WB checking
[   15.380368] MTRR MAP PFN: 0000000000000000 - 00000000000a0000
[   15.386039] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   15.391709] After UC checking
[   15.394630] MTRR MAP PFN: 0000000000000000 - 00000000000a0000
[   15.400302] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   15.405971] After sorting
[   15.408548] MTRR MAP PFN: 0000000000000000 - 00000000000a0000
[   15.414220] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   15.419890]  gran_size: 256M 	chunk_size: 256M 	num_reg: 6  	lose cover RAM: 224M

[   15.428738] rangeX: 0000000000000000 - 00000000a0000000
[   15.433891] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   15.440077] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   15.446433] range0: 0000000100000000 - 0000000460000000
[   15.451587] Setting variable MTRR 2, base: 4GB, range: 4GB, type WB
[   15.457773] Setting variable MTRR 3, base: 8GB, range: 8GB, type WB
[   15.463958] Setting variable MTRR 4, base: 16GB, range: 1GB, type WB
[   15.470228] Setting variable MTRR 5, base: 17GB, range: 512MB, type WB
[   15.476672] hole: 0000000450000000 - 0000000460000000
[   15.481654] Setting variable MTRR 6, base: 17664MB, range: 256MB, type UC
[   15.488354] After WB checking
[   15.491276] MTRR MAP PFN: 0000000000000000 - 00000000000a0000
[   15.496945] MTRR MAP PFN: 0000000000100000 - 0000000000460000
[   15.502614] After UC checking
[   15.505535] MTRR MAP PFN: 0000000000000000 - 00000000000a0000
[   15.511205] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   15.516876] After sorting
[   15.519454] MTRR MAP PFN: 0000000000000000 - 00000000000a0000
[   15.525123] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   15.530794]  gran_size: 256M 	chunk_size: 512M 	num_reg: 7  	lose cover RAM: 224M

[   15.539642] range0: 0000000000000000 - 00000000c0000000
[   15.544796] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   15.550982] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[   15.557169] hole: 00000000a0000000 - 00000000c0000000
[   15.562151] Setting variable MTRR 2, base: 2560MB, range: 512MB, type UC
[   15.568767] range0: 0000000100000000 - 0000000480000000
[   15.573922] Setting variable MTRR 3, base: 4GB, range: 4GB, type WB
[   15.580107] Setting variable MTRR 4, base: 8GB, range: 8GB, type WB
[   15.586293] Setting variable MTRR 5, base: 16GB, range: 2GB, type WB
[   15.592565] hole: 0000000450000000 - 0000000480000000
[   15.597548] Setting variable MTRR 6, base: 17664MB, range: 256MB, type UC
[   15.604249] Setting variable MTRR 7, base: 17920MB, range: 512MB, type UC
[   15.610951] After WB checking
[   15.613872] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[   15.619542] MTRR MAP PFN: 0000000000100000 - 0000000000480000
[   15.625213] After UC checking
[   15.628132] MTRR MAP PFN: 0000000000000000 - 00000000000a0000
[   15.633803] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   15.639474] After sorting
[   15.642051] MTRR MAP PFN: 0000000000000000 - 00000000000a0000
[   15.647721] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   15.653393]  gran_size: 256M 	chunk_size: 1G 	num_reg: 8  	lose cover RAM: 224M

[   15.662071] range0: 0000000000000000 - 0000000100000000
[   15.667226] Setting variable MTRR 0, base: 0GB, range: 4GB, type WB
[   15.673413] hole: 00000000a0000000 - 0000000100000000
[   15.678396] Setting variable MTRR 1, base: 2560MB, range: 512MB, type UC
[   15.685012] Setting variable MTRR 2, base: 3GB, range: 1GB, type UC
[   15.691199] range0: 0000000100000000 - 0000000480000000
[   15.696355] Setting variable MTRR 3, base: 4GB, range: 4GB, type WB
[   15.702541] Setting variable MTRR 4, base: 8GB, range: 8GB, type WB
[   15.708727] Setting variable MTRR 5, base: 16GB, range: 2GB, type WB
[   15.714999] hole: 0000000450000000 - 0000000480000000
[   15.719982] Setting variable MTRR 6, base: 17664MB, range: 256MB, type UC
[   15.726684] Setting variable MTRR 7, base: 17920MB, range: 512MB, type UC
[   15.733386] After WB checking
[   15.736307] MTRR MAP PFN: 0000000000000000 - 0000000000480000
[   15.741979] After UC checking
[   15.744899] MTRR MAP PFN: 0000000000000000 - 00000000000a0000
[   15.750570] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   15.756239] After sorting
[   15.758816] MTRR MAP PFN: 0000000000000000 - 00000000000a0000
[   15.764487] MTRR MAP PFN: 0000000000100000 - 0000000000450000
[   15.770158]  gran_size: 256M 	chunk_size: 2G 	num_reg: 8  	lose cover RAM: 224M

[   15.778835] rangeX: 0000000000000000 - 00000000a0000000
[   15.783991] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   15.790178] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   15.796537] rangeX: 0000000100000000 - 0000000440000000
[   15.801692] Setting variable MTRR 2, base: 4GB, range: 4GB, type WB
[   15.807879] Setting variable MTRR 3, base: 8GB, range: 8GB, type WB
[   15.814065] Setting variable MTRR 4, base: 16GB, range: 1GB, type WB
[   15.820339] After WB checking
[   15.823260] MTRR MAP PFN: 0000000000000000 - 00000000000a0000
[   15.828931] MTRR MAP PFN: 0000000000100000 - 0000000000440000
[   15.834711] After UC checking
[   15.837556] MTRR MAP PFN: 0000000000000000 - 00000000000a0000
[   15.843229] MTRR MAP PFN: 0000000000100000 - 0000000000440000
[   15.848899] After sorting
[   15.851477] MTRR MAP PFN: 0000000000000000 - 00000000000a0000
[   15.857150] MTRR MAP PFN: 0000000000100000 - 0000000000440000
[   15.862820]  gran_size: 512M 	chunk_size: 512M 	num_reg: 5  	lose cover RAM: 480M

[   15.871671] range0: 0000000000000000 - 00000000c0000000
[   15.876826] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   15.883013] Setting variable MTRR 1, base: 2GB, range: 1GB, type WB
[   15.889199] hole: 00000000a0000000 - 00000000c0000000
[   15.894183] Setting variable MTRR 2, base: 2560MB, range: 512MB, type UC
[   15.900799] rangeX: 0000000100000000 - 0000000440000000
[   15.905953] Setting variable MTRR 3, base: 4GB, range: 4GB, type WB
[   15.912139] Setting variable MTRR 4, base: 8GB, range: 8GB, type WB
[   15.918326] Setting variable MTRR 5, base: 16GB, range: 1GB, type WB
[   15.924598] After WB checking
[   15.927520] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[   15.933191] MTRR MAP PFN: 0000000000100000 - 0000000000440000
[   15.938863] After UC checking
[   15.941783] MTRR MAP PFN: 0000000000000000 - 00000000000a0000
[   15.947454] MTRR MAP PFN: 0000000000100000 - 0000000000440000
[   15.953125] After sorting
[   15.955702] MTRR MAP PFN: 0000000000000000 - 00000000000a0000
[   15.961373] MTRR MAP PFN: 0000000000100000 - 0000000000440000
[   15.967045]  gran_size: 512M 	chunk_size: 1G 	num_reg: 6  	lose cover RAM: 480M

[   15.975722] range0: 0000000000000000 - 0000000100000000
[   15.980877] Setting variable MTRR 0, base: 0GB, range: 4GB, type WB
[   15.987063] hole: 00000000a0000000 - 0000000100000000
[   15.992047] Setting variable MTRR 1, base: 2560MB, range: 512MB, type UC
[   15.998662] Setting variable MTRR 2, base: 3GB, range: 1GB, type UC
[   16.004850] range0: 0000000100000000 - 0000000480000000
[   16.010005] Setting variable MTRR 3, base: 4GB, range: 4GB, type WB
[   16.016191] Setting variable MTRR 4, base: 8GB, range: 8GB, type WB
[   16.022379] Setting variable MTRR 5, base: 16GB, range: 2GB, type WB
[   16.028652] hole: 0000000440000000 - 0000000480000000
[   16.033636] Setting variable MTRR 6, base: 17GB, range: 1GB, type UC
[   16.039908] After WB checking
[   16.042830] MTRR MAP PFN: 0000000000000000 - 0000000000480000
[   16.048502] After UC checking
[   16.051423] MTRR MAP PFN: 0000000000000000 - 00000000000a0000
[   16.057093] MTRR MAP PFN: 0000000000100000 - 0000000000440000
[   16.062764] After sorting
[   16.065340] MTRR MAP PFN: 0000000000000000 - 00000000000a0000
[   16.071011] MTRR MAP PFN: 0000000000100000 - 0000000000440000
[   16.076679]  gran_size: 512M 	chunk_size: 2G 	num_reg: 7  	lose cover RAM: 480M

[   16.085356] rangeX: 0000000000000000 - 0000000080000000
[   16.090512] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   16.096698] rangeX: 0000000100000000 - 0000000440000000
[   16.101853] Setting variable MTRR 1, base: 4GB, range: 4GB, type WB
[   16.108039] Setting variable MTRR 2, base: 8GB, range: 8GB, type WB
[   16.114227] Setting variable MTRR 3, base: 16GB, range: 1GB, type WB
[   16.120500] After WB checking
[   16.123421] MTRR MAP PFN: 0000000000000000 - 0000000000080000
[   16.129093] MTRR MAP PFN: 0000000000100000 - 0000000000440000
[   16.134766] After UC checking
[   16.137687] MTRR MAP PFN: 0000000000000000 - 0000000000080000
[   16.143358] MTRR MAP PFN: 0000000000100000 - 0000000000440000
[   16.149030] After sorting
[   16.151607] MTRR MAP PFN: 0000000000000000 - 0000000000080000
[   16.157279] MTRR MAP PFN: 0000000000100000 - 0000000000440000
[   16.162950]  gran_size: 1G 	chunk_size: 1G 	num_reg: 4  	lose cover RAM: 992M

[   16.171458] rangeX: 0000000000000000 - 0000000080000000
[   16.176613] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   16.182800] range0: 0000000100000000 - 0000000480000000
[   16.187956] Setting variable MTRR 1, base: 4GB, range: 4GB, type WB
[   16.194143] Setting variable MTRR 2, base: 8GB, range: 8GB, type WB
[   16.200331] Setting variable MTRR 3, base: 16GB, range: 2GB, type WB
[   16.206603] hole: 0000000440000000 - 0000000480000000
[   16.211589] Setting variable MTRR 4, base: 17GB, range: 1GB, type UC
[   16.217862] After WB checking
[   16.220783] MTRR MAP PFN: 0000000000000000 - 0000000000080000
[   16.226454] MTRR MAP PFN: 0000000000100000 - 0000000000480000
[   16.232127] After UC checking
[   16.235048] MTRR MAP PFN: 0000000000000000 - 0000000000080000
[   16.240720] MTRR MAP PFN: 0000000000100000 - 0000000000440000
[   16.246391] After sorting
[   16.248970] MTRR MAP PFN: 0000000000000000 - 0000000000080000
[   16.254641] MTRR MAP PFN: 0000000000100000 - 0000000000440000
[   16.260312]  gran_size: 1G 	chunk_size: 2G 	num_reg: 5  	lose cover RAM: 992M

[   16.268820] rangeX: 0000000000000000 - 0000000080000000
[   16.273975] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   16.280163] rangeX: 0000000100000000 - 0000000400000000
[   16.285318] Setting variable MTRR 1, base: 4GB, range: 4GB, type WB
[   16.291506] Setting variable MTRR 2, base: 8GB, range: 8GB, type WB
[   16.297694] After WB checking
[   16.300615] MTRR MAP PFN: 0000000000000000 - 0000000000080000
[   16.306288] MTRR MAP PFN: 0000000000100000 - 0000000000400000
[   16.311960] After UC checking
[   16.314882] MTRR MAP PFN: 0000000000000000 - 0000000000080000
[   16.320554] MTRR MAP PFN: 0000000000100000 - 0000000000400000
[   16.326225] After sorting
[   16.328804] MTRR MAP PFN: 0000000000000000 - 0000000000080000
[   16.334475] MTRR MAP PFN: 0000000000100000 - 0000000000400000
[   16.340147]  gran_size: 2G 	chunk_size: 2G 	num_reg: 3  	lose cover RAM: 2016M

[   16.348740] Found optimal setting for mtrr clean up
[   16.353552]  gran_size: 64K 	chunk_size: 64M 	num_reg: 8  	lose cover RAM: 0G
[   16.360598] range0: 0000000000000000 - 00000000b0000000
[   16.365754] Setting variable MTRR 0, base: 0GB, range: 2GB, type WB
[   16.371942] Setting variable MTRR 1, base: 2GB, range: 512MB, type WB
[   16.378301] Setting variable MTRR 2, base: 2560MB, range: 256MB, type WB
[   16.384918] hole: 00000000ae000000 - 00000000b0000000
[   16.389902] Setting variable MTRR 3, base: 2784MB, range: 32MB, type UC
[   16.396433] rangeX: 0000000100000000 - 0000000450000000
[   16.401587] Setting variable MTRR 4, base: 4GB, range: 4GB, type WB
[   16.407773] Setting variable MTRR 5, base: 8GB, range: 8GB, type WB
[   16.413959] Setting variable MTRR 6, base: 16GB, range: 1GB, type WB
[   16.420232] Setting variable MTRR 7, base: 17GB, range: 256MB, type WB
[   16.426676] New variable MTRRs
[   16.429684] reg 0, base: 0GB, range: 2GB, type WB
[   16.434324] reg 1, base: 2GB, range: 512MB, type WB
[   16.439136] reg 2, base: 2560MB, range: 256MB, type WB
[   16.444205] reg 3, base: 2784MB, range: 32MB, type UC
[   16.449189] reg 4, base: 4GB, range: 4GB, type WB
[   16.453829] reg 5, base: 8GB, range: 8GB, type WB
[   16.458468] reg 6, base: 16GB, range: 1GB, type WB
[   16.463195] reg 7, base: 17GB, range: 256MB, type WB
[   16.468094] MTRR map: 6 entries (3 fixed + 3 variable; max 23), built from 10 variable MTRRs
[   16.476427]   0: 0000000000000000-000000000009ffff write-back
[   16.482098]   1: 00000000000a0000-00000000000bffff uncachable
[   16.487769]   2: 00000000000c0000-00000000000fffff write-protect
[   16.493698]   3: 0000000000100000-00000000adffffff write-back
[   16.499369]   4: 00000000ae000000-00000000afffffff uncachable
[   16.505041]   5: 0000000100000000-000000044fffffff write-back
[   16.510712] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[   16.517781] After WB checking
[   16.520546] MTRR MAP PFN: 0000000000000000 - 00000000000c0000
[   16.526218] MTRR MAP PFN: 0000000000100000 - 0000000000110000
[   16.531889] MTRR MAP PFN: 0000000000200000 - 0000000000450000
[   16.537560] After UC checking
[   16.540481] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   16.546152] MTRR MAP PFN: 0000000000100000 - 0000000000110000
[   16.551823] MTRR MAP PFN: 0000000000200000 - 0000000000450000
[   16.557493] MTRR MAP PFN: 00000000000b0000 - 00000000000c0000
[   16.563164] After sorting
[   16.565742] MTRR MAP PFN: 0000000000000000 - 00000000000ae000
[   16.571414] MTRR MAP PFN: 00000000000b0000 - 00000000000c0000
[   16.577085] MTRR MAP PFN: 0000000000100000 - 0000000000110000
[   16.582755] MTRR MAP PFN: 0000000000200000 - 0000000000450000
[   16.588427] e820: update [mem 0xae000000-0xafffffff] usable ==> reserved
[   16.595042] e820: update [mem 0xc0000000-0xffffffff] usable ==> reserved
[   16.601659] e820: update [mem 0x110000000-0x1ffffffff] usable ==> reserved
[   16.608447] WARNING: BIOS bug: CPU MTRRs don't cover all of memory, losing 3840MB of RAM.
[   16.616524] update e820 for mtrr
[   16.619710] modified physical RAM map:
[   16.623397] modified: [mem 0x0000000000000000-0x0000000000000fff] reserved
[   16.630184] modified: [mem 0x0000000000001000-0x000000000009ffff] usable
[   16.636800] modified: [mem 0x0000000000100000-0x0000000018ebafff] usable
[   16.643416] modified: [mem 0x0000000018ebb000-0x0000000018fe7fff] ACPI NVS
[   16.650202] modified: [mem 0x0000000018fe8000-0x0000000018fe8fff] usable
[   16.656818] modified: [mem 0x0000000018fe9000-0x0000000018ffffff] ACPI NVS
[   16.663606] modified: [mem 0x0000000019000000-0x000000001dffcfff] usable
[   16.670222] modified: [mem 0x000000001dffd000-0x000000001dffffff] ACPI data
[   16.677096] modified: [mem 0x000000001e000000-0x00000000ac77cfff] usable
[   16.683712] modified: [mem 0x00000000ac77d000-0x00000000ac77ffff] type 20
[   16.690415] modified: [mem 0x00000000ac780000-0x00000000ac780fff] reserved
[   16.697202] modified: [mem 0x00000000ac781000-0x00000000ac782fff] type 20
[   16.703904] modified: [mem 0x00000000ac783000-0x00000000ac7d9fff] reserved
[   16.710694] modified: [mem 0x00000000ac7da000-0x00000000ac7dafff] type 20
[   16.717397] modified: [mem 0x00000000ac7db000-0x00000000ac7dcfff] reserved
[   16.724185] modified: [mem 0x00000000ac7dd000-0x00000000ac7e7fff] type 20
[   16.730889] modified: [mem 0x00000000ac7e8000-0x00000000ac7f1fff] reserved
[   16.737678] modified: [mem 0x00000000ac7f2000-0x00000000ac7f5fff] type 20
[   16.744380] modified: [mem 0x00000000ac7f6000-0x00000000ac7f9fff] reserved
[   16.751169] modified: [mem 0x00000000ac7fa000-0x00000000ac7fafff] type 20
[   16.757871] modified: [mem 0x00000000ac7fb000-0x00000000ac803fff] reserved
[   16.764661] modified: [mem 0x00000000ac804000-0x00000000ac810fff] type 20
[   16.771363] modified: [mem 0x00000000ac811000-0x00000000ac813fff] reserved
[   16.778152] modified: [mem 0x00000000ac814000-0x00000000ad7fffff] usable
[   16.784768] modified: [mem 0x00000000fed20000-0x00000000fed3ffff] reserved
[   16.791557] modified: [mem 0x0000000100000000-0x000000010fffffff] usable
[   16.798173] modified: [mem 0x0000000110000000-0x00000001ffffffff] reserved
[   16.804962] modified: [mem 0x0000000200000000-0x000000044fffffff] usable
[   16.811579] last_pfn = 0x450000 max_arch_pfn = 0x400000000
[   16.816992] last_pfn = 0xad800 max_arch_pfn = 0x400000000
[   16.823948] found SMP MP-table at [mem 0x000f1dd0-0x000f1ddf]
[   16.829484] Using GB pages for direct mapping
[   16.846482] printk: log_buf_len: 16777216 bytes
[   16.850803] printk: early log buf free: 77040(29%)
[   16.855528] Secure boot could not be determined
[   16.860169] RAMDISK: [mem 0x36ff3000-0x377f0fff]
[   16.864724] ACPI: Early table checksum verification disabled
[   16.870310] ACPI: RSDP 0x000000001DFFFF98 000024 (v02 DELL  )
[   16.875978] ACPI: XSDT 0x000000001DFFEE18 00006C (v01 DELL   CBX3     06222004 MSFT 00010013)
[   16.884401] ACPI: FACP 0x0000000018FF0C18 0000F4 (v04 DELL   CBX3     06222004 MSFT 00010013)
[   16.892820] ACPI: DSDT 0x0000000018FA9018 006373 (v01 DELL   CBX3     00000000 INTL 20091112)
[   16.901239] ACPI: FACS 0x0000000018FFDF40 000040
[   16.905791] ACPI: FACS 0x0000000018FF1F40 000040
[   16.910344] ACPI: APIC 0x000000001DFFDC18 000158 (v02 DELL   CBX3     06222004 MSFT 00010013)
[   16.918764] ACPI: MCFG 0x0000000018FFED18 00003C (v01 A M I  OEMMCFG. 06222004 MSFT 00000097)
[   16.927185] ACPI: TCPA 0x0000000018FFEC98 000032 (v02                 00000000      00000000)
[   16.935607] ACPI: SSDT 0x0000000018FEFA98 000306 (v01 DELLTP TPM      00003000 INTL 20091112)
[   16.944028] ACPI: HPET 0x0000000018FFEC18 000038 (v01 A M I   PCHHPET 06222004 AMI. 00000003)
[   16.952448] ACPI: BOOT 0x0000000018FFEB98 000028 (v01 DELL   CBX3     06222004 AMI  00010013)
[   16.960869] ACPI: SSDT 0x0000000018FB0018 037106 (v02 INTEL  CpuPm    00004000 INTL 20091112)
[   16.969290] ACPI: SLIC 0x0000000018FEEC18 000176 (v03 DELL   CBX3     06222004 MSFT 00010013)
[   16.977711] ACPI: Reserving FACP table memory at [mem 0x18ff0c18-0x18ff0d0b]
[   16.984671] ACPI: Reserving DSDT table memory at [mem 0x18fa9018-0x18faf38a]
[   16.991631] ACPI: Reserving FACS table memory at [mem 0x18ffdf40-0x18ffdf7f]
[   16.998592] ACPI: Reserving FACS table memory at [mem 0x18ff1f40-0x18ff1f7f]
[   17.005553] ACPI: Reserving APIC table memory at [mem 0x1dffdc18-0x1dffdd6f]
[   17.012515] ACPI: Reserving MCFG table memory at [mem 0x18ffed18-0x18ffed53]
[   17.019474] ACPI: Reserving TCPA table memory at [mem 0x18ffec98-0x18ffecc9]
[   17.026434] ACPI: Reserving SSDT table memory at [mem 0x18fefa98-0x18fefd9d]
[   17.033394] ACPI: Reserving HPET table memory at [mem 0x18ffec18-0x18ffec4f]
[   17.040355] ACPI: Reserving BOOT table memory at [mem 0x18ffeb98-0x18ffebbf]
[   17.047314] ACPI: Reserving SSDT table memory at [mem 0x18fb0018-0x18fe711d]
[   17.054275] ACPI: Reserving SLIC table memory at [mem 0x18feec18-0x18feed8d]
[   17.061280] No NUMA configuration found
[   17.065015] Faking a node at [mem 0x0000000000000000-0x000000044fffffff]
[   17.071634] NODE_DATA(0) allocated [mem 0x44b7f8000-0x44b7fbfff]
[   17.077601] Zone ranges:
[   17.080054]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[   17.086154]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[   17.092256]   Normal   [mem 0x0000000100000000-0x000000044fffffff]
[   17.098357] Movable zone start for each node
[   17.102567] Early memory node ranges
[   17.106091]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[   17.112277]   node   0: [mem 0x0000000000100000-0x0000000018ebafff]
[   17.118465]   node   0: [mem 0x0000000018fe8000-0x0000000018fe8fff]
[   17.124651]   node   0: [mem 0x0000000019000000-0x000000001dffcfff]
[   17.130838]   node   0: [mem 0x000000001e000000-0x00000000ac77cfff]
[   17.137025]   node   0: [mem 0x00000000ac814000-0x00000000ad7fffff]
[   17.143214]   node   0: [mem 0x0000000100000000-0x000000010fffffff]
[   17.149401]   node   0: [mem 0x0000000200000000-0x000000044fffffff]
[   17.155589] Initmem setup node 0 [mem 0x0000000000001000-0x000000044fffffff]
[   17.162551] On node 0, zone DMA: 1 pages in unavailable ranges
[   17.162574] On node 0, zone DMA: 96 pages in unavailable ranges
[   17.168833] On node 0, zone DMA32: 301 pages in unavailable ranges
[   17.174628] On node 0, zone DMA32: 23 pages in unavailable ranges
[   17.183711] On node 0, zone DMA32: 3 pages in unavailable ranges
[   17.189602] On node 0, zone DMA32: 151 pages in unavailable ranges
[   17.195922] On node 0, zone Normal: 10240 pages in unavailable ranges
[   17.214913] ACPI: PM-Timer IO Port: 0x408
[   17.225104] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
[   17.231871] IOAPIC[1]: apic_id 2, version 32, address 0xfec3f000, GSI 24-47
[   17.238744] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[   17.245016] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[   17.251548] ACPI: Using ACPI (MADT) for SMP configuration information
[   17.257903] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[   17.262976] TSC deadline timer available
[   17.266839] smpboot: Allowing 32 CPUs, 24 hotplug CPUs
[   17.271938] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[   17.279387] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[   17.286862] PM: hibernation: Registered nosave memory: [mem 0x18ebb000-0x18fe7fff]
[   17.294339] PM: hibernation: Registered nosave memory: [mem 0x18fe9000-0x18ffffff]
[   17.301815] PM: hibernation: Registered nosave memory: [mem 0x1dffd000-0x1dffffff]
[   17.309292] PM: hibernation: Registered nosave memory: [mem 0xac77d000-0xac77ffff]
[   17.316768] PM: hibernation: Registered nosave memory: [mem 0xac780000-0xac780fff]
[   17.324243] PM: hibernation: Registered nosave memory: [mem 0xac781000-0xac782fff]
[   17.331718] PM: hibernation: Registered nosave memory: [mem 0xac783000-0xac7d9fff]
[   17.339194] PM: hibernation: Registered nosave memory: [mem 0xac7da000-0xac7dafff]
[   17.346669] PM: hibernation: Registered nosave memory: [mem 0xac7db000-0xac7dcfff]
[   17.354146] PM: hibernation: Registered nosave memory: [mem 0xac7dd000-0xac7e7fff]
[   17.361621] PM: hibernation: Registered nosave memory: [mem 0xac7e8000-0xac7f1fff]
[   17.369098] PM: hibernation: Registered nosave memory: [mem 0xac7f2000-0xac7f5fff]
[   17.376575] PM: hibernation: Registered nosave memory: [mem 0xac7f6000-0xac7f9fff]
[   17.384052] PM: hibernation: Registered nosave memory: [mem 0xac7fa000-0xac7fafff]
[   17.391527] PM: hibernation: Registered nosave memory: [mem 0xac7fb000-0xac803fff]
[   17.399004] PM: hibernation: Registered nosave memory: [mem 0xac804000-0xac810fff]
[   17.406481] PM: hibernation: Registered nosave memory: [mem 0xac811000-0xac813fff]
[   17.413957] PM: hibernation: Registered nosave memory: [mem 0xad800000-0xfed1ffff]
[   17.421433] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfed3ffff]
[   17.428910] PM: hibernation: Registered nosave memory: [mem 0xfed40000-0xffffffff]
[   17.436388] PM: hibernation: Registered nosave memory: [mem 0x110000000-0x1ffffffff]
[   17.444037] [mem 0xad800000-0xfed1ffff] available for PCI devices
[   17.450051] Booting paravirtualized kernel on bare hardware
[   17.455553] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[   17.470292] setup_percpu: NR_CPUS:256 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:1
[   17.480176] percpu: Embedded 78 pages/cpu s282624 r8192 d28672 u524288
[   17.486483] pcpu-alloc: s282624 r8192 d28672 u524288 alloc=1*2097152
[   17.492748] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
[   17.497989] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15 
[   17.503231] pcpu-alloc: [0] 16 17 18 19 [0] 20 21 22 23 
[   17.508472] pcpu-alloc: [0] 24 25 26 27 [0] 28 29 30 31 
[   17.513733] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-6.4.0-rc1+ root=/dev/sda7 ro earlyprintk=ttyS0,115200 console=ttyS0,115200 console=tty0 ras=cec_disable root=/dev/sda7 log_buf_len=10M resume=/dev/sda5 no_console_suspend ignore_loglevel mtrr=debug
[   17.536134] Unknown kernel command line parameters "BOOT_IMAGE=/boot/vmlinuz-6.4.0-rc1+", will be passed to user space.
[   17.548193] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[   17.556753] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[   17.564724] Fallback order for Node 0: 0 
[   17.564730] Built 1 zonelists, mobility grouping on.  Total pages: 3150281
[   17.575317] Policy zone: Normal
[   17.578420] mem auto-init: stack:off, heap alloc:off, heap free:off
[   17.584606] software IO TLB: area num 32.
[   17.624396] Memory: 12307176K/12801796K available (14336K kernel code, 2459K rwdata, 5720K rodata, 3056K init, 14580K bss, 494364K reserved, 0K cma-reserved)
[   17.638296] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=1
[   17.644723] Kernel/User page tables isolation: enabled
[   17.649865] ftrace: allocating 40212 entries in 158 pages
[   17.661197] ftrace: allocated 158 pages with 5 groups
[   17.666159] Dynamic Preempt: full
[   17.669489] Running RCU self tests
[   17.672684] Running RCU synchronous self tests
[   17.677078] rcu: Preemptible hierarchical RCU implementation.
[   17.682738] rcu: 	RCU lockdep checking is enabled.
[   17.687465] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=32.
[   17.694167] 	Trampoline variant of Tasks RCU enabled.
[   17.699150] 	Rude variant of Tasks RCU enabled.
[   17.703617] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[   17.711178] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=32
[   17.717947] Running RCU synchronous self tests
[   17.725299] NR_IRQS: 16640, nr_irqs: 1088, preallocated irqs: 16
[   17.731287] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[   17.738091] Console: colour dummy device 80x25
[   17.742330] printk: console [tty0] enabled
[   17.746360] printk: bootconsole [earlyser0] disabled
[   17.751300] printk: console [ttyS0] enabled
[   35.841161] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[   35.848843] ... MAX_LOCKDEP_SUBCLASSES:  8
[   35.852903] ... MAX_LOCK_DEPTH:          48
[   35.857050] ... MAX_LOCKDEP_KEYS:        8192
[   35.861371] ... CLASSHASH_SIZE:          4096
[   35.865690] ... MAX_LOCKDEP_ENTRIES:     32768
[   35.870096] ... MAX_LOCKDEP_CHAINS:      65536
[   35.874504] ... CHAINHASH_SIZE:          32768
[   35.878910]  memory used by lock dependency info: 6365 kB
[   35.884264]  memory used for stack traces: 4224 kB
[   35.889015]  per task-struct memory footprint: 1920 bytes
[   35.894404] ACPI: Core revision 20230331
[   35.898530] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[   35.907626] APIC: Switch to symmetric I/O mode setup
[   35.912767] x2apic: IRQ remapping doesn't support X2APIC mode
[   35.918524] Switched APIC routing to physical flat.
[   35.923934] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[   35.934621] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x33c3c65886c, max_idle_ns: 440795268982 ns
[   35.945081] Calibrating delay loop (skipped), value calculated using timer frequency.. 7182.35 BogoMIPS (lpj=3591179)
[   35.946070] pid_max: default: 32768 minimum: 301
[   35.955171] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[   35.956095] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[   35.957631] CPU0: Thermal monitoring enabled (TM1)
[   35.958118] process: using mwait in idle threads
[   35.959077] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[   35.960069] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[   35.961073] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[   35.962071] Spectre V2 : Mitigation: Retpolines
[   35.963069] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[   35.964069] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[   35.965069] Spectre V2 : Enabling Restricted Speculation for firmware calls
[   35.966071] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[   35.967069] Spectre V2 : User space: Mitigation: STIBP via prctl
[   35.968070] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[   35.969073] MDS: Mitigation: Clear CPU buffers
[   35.970069] MMIO Stale Data: Unknown: No mitigations
[   35.985005] Freeing SMP alternatives memory: 36K
[   35.985483] Running RCU synchronous self tests
[   35.986078] Running RCU synchronous self tests
[   35.987264] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-1620 0 @ 3.60GHz (family: 0x6, model: 0x2d, stepping: 0x7)
[   35.997096] cblist_init_generic: Setting adjustable number of callback queues.
[   35.998069] cblist_init_generic: Setting shift to 5 and lim to 1.
[   36.000095] cblist_init_generic: Setting shift to 5 and lim to 1.
[   36.002081] Running RCU-tasks wait API self tests
[   36.114073] Performance Events: PEBS fmt1+, SandyBridge events, 16-deep LBR, full-width counters, Intel PMU driver.
[   36.116088] ... version:                3
[   36.117069] ... bit width:              48
[   36.118081] ... generic registers:      4
[   36.119069] ... value mask:             0000ffffffffffff
[   36.120069] ... max period:             00007fffffffffff
[   36.121069] ... fixed-purpose events:   3
[   36.122074] ... event mask:             000000070000000f
[   36.129109] Estimated ratio of average max frequency by base frequency (times 1024): 1052
[   36.133070] rcu: Hierarchical SRCU implementation.
[   36.134069] rcu: 	Max phase no-delay instances is 400.
[   36.177103] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[   36.195085] smp: Bringing up secondary CPUs ...
[   36.204077] x86: Booting SMP configuration:
[   36.205077] .... node  #0, CPUs:        #1
[   36.248070] Callback from call_rcu_tasks_rude() invoked.
[   36.256079]   #2  #3
[   36.320090] Callback from call_rcu_tasks() invoked.
[   36.330080]   #4
[   36.345078] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[   36.355090]   #5  #6  #7
[   36.413081] smp: Brought up 1 node, 8 CPUs
[   36.415070] smpboot: Max logical packages: 4
[   36.416101] smpboot: Total of 8 processors activated (57458.86 BogoMIPS)
[   36.442109] devtmpfs: initialized
[   36.459083] ACPI: PM: Registering ACPI NVS region [mem 0x18ebb000-0x18fe7fff] (1232896 bytes)
[   36.463097] ACPI: PM: Registering ACPI NVS region [mem 0x18fe9000-0x18ffffff] (94208 bytes)
[   36.469079] Running RCU synchronous self tests
[   36.470102] Running RCU synchronous self tests
[   36.478092] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[   36.480079] futex hash table entries: 8192 (order: 8, 1048576 bytes, linear)
[   36.506096] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[   36.517094] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
[   36.519076] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[   36.520082] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[   36.527080] thermal_sys: Registered thermal governor 'step_wise'
[   36.527084] thermal_sys: Registered thermal governor 'user_space'
[   36.529100] cpuidle: using governor ladder
[   36.532107] cpuidle: using governor menu
[   36.535081] Simple Boot Flag at 0xf3 set to 0x1
[   36.536115] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[   36.541091] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xb0000000-0xb3ffffff] (base 0xb0000000)
[   36.543086] PCI: not using MMCONFIG
[   36.544084] PCI: Using configuration type 1 for base access
[   36.546073] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[   36.568093] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[   36.582129] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[   36.713123] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[   36.844117] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[   36.977118] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[   37.128097] ACPI: Added _OSI(Module Device)
[   37.129071] ACPI: Added _OSI(Processor Device)
[   37.130075] ACPI: Added _OSI(3.0 _SCP Extensions)
[   37.131070] ACPI: Added _OSI(Processor Aggregator Device)
[   39.056108] ACPI: 3 ACPI AML tables successfully acquired and loaded
[   39.481075] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[   39.570093] ACPI: Interpreter enabled
[   39.572104] ACPI: PM: (supports S0 S1 S3 S4 S5)
[   39.574088] ACPI: Using IOAPIC for interrupt routing
[   39.576093] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xb0000000-0xb3ffffff] (base 0xb0000000)
[   39.632085] [Firmware Info]: PCI: MMCONFIG at [mem 0xb0000000-0xb3ffffff] not reserved in ACPI motherboard resources
[   39.634091] PCI: MMCONFIG at [mem 0xb0000000-0xb3ffffff] reserved as EfiMemoryMappedIO
[   39.635103] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[   39.637069] PCI: Using E820 reservations for host bridge windows
[   39.650117] ACPI: Enabled 7 GPEs in block 00 to 3F
[   40.231098] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-1f])
[   40.233089] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[   40.239112] acpi PNP0A08:00: _OSC: platform does not support [AER PCIeCapability LTR]
[   40.245091] acpi PNP0A08:00: _OSC: not requesting control; platform does not support [PCIeCapability]
[   40.247084] acpi PNP0A08:00: _OSC: OS requested [PME AER PCIeCapability LTR]
[   40.248070] acpi PNP0A08:00: _OSC: platform willing to grant [PME]
[   40.249070] acpi PNP0A08:00: _OSC: platform retains control of PCIe features (AE_SUPPORT)
[   40.271080] PCI host bridge to bus 0000:00
[   40.272078] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[   40.273074] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[   40.274077] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[   40.275070] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[   40.276070] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff window]
[   40.277070] pci_bus 0000:00: root bus resource [mem 0xb0000000-0xfbffffff window]
[   40.278078] pci_bus 0000:00: root bus resource [bus 00-1f]
[   40.280111] pci 0000:00:00.0: [8086:3c00] type 00 class 0x060000
[   40.284110] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[   40.291090] pci 0000:00:01.0: [8086:3c02] type 01 class 0x060400
[   40.294089] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[   40.305075] pci 0000:00:01.1: [8086:3c03] type 01 class 0x060400
[   40.308090] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[   40.316106] pci 0000:00:02.0: [8086:3c04] type 01 class 0x060400
[   40.320089] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[   40.328097] pci 0000:00:03.0: [8086:3c08] type 01 class 0x060400
[   40.331070] pci 0000:00:03.0: enabling Extended Tags
[   40.333101] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[   40.342086] pci 0000:00:05.0: [8086:3c28] type 00 class 0x088000
[   40.347094] pci 0000:00:05.2: [8086:3c2a] type 00 class 0x088000
[   40.352089] pci 0000:00:05.4: [8086:3c2c] type 00 class 0x080020
[   40.353102] pci 0000:00:05.4: reg 0x10: [mem 0xf332d000-0xf332dfff]
[   40.359090] pci 0000:00:11.0: [8086:1d3e] type 01 class 0x060400
[   40.362112] pci 0000:00:11.0: PME# supported from D0 D3hot D3cold
[   40.370108] pci 0000:00:16.0: [8086:1d3a] type 00 class 0x078000
[   40.372097] pci 0000:00:16.0: reg 0x10: [mem 0xf332c000-0xf332c00f 64bit]
[   40.376069] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[   40.380079] pci 0000:00:16.3: [8086:1d3d] type 00 class 0x070002
[   40.381090] pci 0000:00:16.3: reg 0x10: [io  0xf0a0-0xf0a7]
[   40.382082] pci 0000:00:16.3: reg 0x14: [mem 0xf332a000-0xf332afff]
[   40.387106] pci 0000:00:19.0: [8086:1502] type 00 class 0x020000
[   40.389090] pci 0000:00:19.0: reg 0x10: [mem 0xf3300000-0xf331ffff]
[   40.391083] pci 0000:00:19.0: reg 0x14: [mem 0xf3329000-0xf3329fff]
[   40.392083] pci 0000:00:19.0: reg 0x18: [io  0xf040-0xf05f]
[   40.394100] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[   40.401103] pci 0000:00:1a.0: [8086:1d2d] type 00 class 0x0c0320
[   40.403086] pci 0000:00:1a.0: reg 0x10: [mem 0xf3328000-0xf33283ff]
[   40.406074] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[   40.413083] pci 0000:00:1b.0: [8086:1d20] type 00 class 0x040300
[   40.414094] pci 0000:00:1b.0: reg 0x10: [mem 0xf3320000-0xf3323fff 64bit]
[   40.418076] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[   40.425088] pci 0000:00:1c.0: [8086:1d16] type 01 class 0x060400
[   40.428089] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[   40.435092] pci 0000:00:1c.2: [8086:1d14] type 01 class 0x060400
[   40.438089] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[   40.445111] pci 0000:00:1d.0: [8086:1d26] type 00 class 0x0c0320
[   40.447105] pci 0000:00:1d.0: reg 0x10: [mem 0xf3327000-0xf33273ff]
[   40.451081] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[   40.458085] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[   40.465114] pci 0000:00:1f.0: [8086:1d41] type 00 class 0x060100
[   40.476078] pci 0000:00:1f.2: [8086:1d02] type 00 class 0x010601
[   40.477089] pci 0000:00:1f.2: reg 0x10: [io  0xf090-0xf097]
[   40.478083] pci 0000:00:1f.2: reg 0x14: [io  0xf080-0xf083]
[   40.479077] pci 0000:00:1f.2: reg 0x18: [io  0xf070-0xf077]
[   40.480077] pci 0000:00:1f.2: reg 0x1c: [io  0xf060-0xf063]
[   40.481077] pci 0000:00:1f.2: reg 0x20: [io  0xf020-0xf03f]
[   40.482077] pci 0000:00:1f.2: reg 0x24: [mem 0xf3326000-0xf33267ff]
[   40.484073] pci 0000:00:1f.2: PME# supported from D3hot
[   40.490091] pci 0000:00:1f.3: [8086:1d22] type 00 class 0x0c0500
[   40.491092] pci 0000:00:1f.3: reg 0x10: [mem 0xf3325000-0xf33250ff 64bit]
[   40.492091] pci 0000:00:1f.3: reg 0x20: [io  0xf000-0xf01f]
[   40.499091] pci 0000:00:01.0: PCI bridge to [bus 01]
[   40.501110] pci 0000:00:01.1: PCI bridge to [bus 02]
[   40.505084] pci 0000:03:00.0: [10de:10d8] type 00 class 0x030000
[   40.506086] pci 0000:03:00.0: reg 0x10: [mem 0xf2000000-0xf2ffffff]
[   40.507084] pci 0000:03:00.0: reg 0x14: [mem 0xf4000000-0xf7ffffff 64bit pref]
[   40.508085] pci 0000:03:00.0: reg 0x1c: [mem 0xf8000000-0xf9ffffff 64bit pref]
[   40.509075] pci 0000:03:00.0: reg 0x24: [io  0xe000-0xe07f]
[   40.510075] pci 0000:03:00.0: reg 0x30: [mem 0xf3000000-0xf307ffff pref]
[   40.511085] pci 0000:03:00.0: enabling Extended Tags
[   40.512102] pci 0000:03:00.0: BAR 3: assigned to efifb
[   40.514087] pci 0000:03:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[   40.519088] pci 0000:03:00.1: [10de:0be3] type 00 class 0x040300
[   40.520085] pci 0000:03:00.1: reg 0x10: [mem 0xf3080000-0xf3083fff]
[   40.521105] pci 0000:03:00.1: enabling Extended Tags
[   40.527108] pci 0000:00:02.0: PCI bridge to [bus 03]
[   40.529078] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[   40.530078] pci 0000:00:02.0:   bridge window [mem 0xf2000000-0xf30fffff]
[   40.531080] pci 0000:00:02.0:   bridge window [mem 0xf4000000-0xf9ffffff 64bit pref]
[   40.533107] pci 0000:00:03.0: PCI bridge to [bus 04]
[   40.537097] pci 0000:05:00.0: [8086:1d6b] type 00 class 0x010700
[   40.539099] pci 0000:05:00.0: reg 0x10: [mem 0xfa800000-0xfa803fff 64bit pref]
[   40.541090] pci 0000:05:00.0: reg 0x18: [mem 0xfa400000-0xfa7fffff 64bit pref]
[   40.542084] pci 0000:05:00.0: reg 0x20: [io  0xd000-0xd0ff]
[   40.543096] pci 0000:05:00.0: enabling Extended Tags
[   40.546099] pci 0000:05:00.0: reg 0x164: [mem 0x00000000-0x00003fff 64bit pref]
[   40.548070] pci 0000:05:00.0: VF(n) BAR0 space: [mem 0x00000000-0x0007bfff 64bit pref] (contains BAR0 for 31 VFs)
[   40.556093] pci 0000:00:11.0: PCI bridge to [bus 05]
[   40.557079] pci 0000:00:11.0:   bridge window [io  0xd000-0xdfff]
[   40.558079] pci 0000:00:11.0:   bridge window [mem 0xf3200000-0xf32fffff]
[   40.559082] pci 0000:00:11.0:   bridge window [mem 0xfa400000-0xfa8fffff 64bit pref]
[   40.561105] pci 0000:00:1c.0: PCI bridge to [bus 06]
[   40.565103] pci 0000:07:00.0: [1033:0194] type 00 class 0x0c0330
[   40.567104] pci 0000:07:00.0: reg 0x10: [mem 0xf3100000-0xf3101fff 64bit]
[   40.572102] pci 0000:07:00.0: PME# supported from D0 D3hot D3cold
[   40.581106] pci 0000:00:1c.2: PCI bridge to [bus 07]
[   40.583081] pci 0000:00:1c.2:   bridge window [mem 0xf3100000-0xf31fffff]
[   40.584103] pci_bus 0000:08: extended config space not accessible
[   40.588078] pci 0000:00:1e.0: PCI bridge to [bus 08] (subtractive decode)
[   40.589079] pci 0000:00:1e.0:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[   40.590070] pci 0000:00:1e.0:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
[   40.591070] pci 0000:00:1e.0:   bridge window [io  0x03b0-0x03df window] (subtractive decode)
[   40.592070] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[   40.593077] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000dffff window] (subtractive decode)
[   40.594070] pci 0000:00:1e.0:   bridge window [mem 0xb0000000-0xfbffffff window] (subtractive decode)
[   40.621105] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
[   40.626076] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[   40.630077] ACPI: PCI: Interrupt link LNKC configured for IRQ 5
[   40.634072] ACPI: PCI: Interrupt link LNKD configured for IRQ 10
[   40.638072] ACPI: PCI: Interrupt link LNKE configured for IRQ 3
[   40.642072] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[   40.643070] ACPI: PCI: Interrupt link LNKF disabled
[   40.647072] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
[   40.651076] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[   40.652070] ACPI: PCI: Interrupt link LNKH disabled
[   40.661092] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 20-ff])
[   40.662073] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[   40.667103] acpi PNP0A08:01: _OSC: platform does not support [AER PCIeCapability LTR]
[   40.673083] acpi PNP0A08:01: _OSC: not requesting control; platform does not support [PCIeCapability]
[   40.674071] acpi PNP0A08:01: _OSC: OS requested [PME AER PCIeCapability LTR]
[   40.675070] acpi PNP0A08:01: _OSC: platform willing to grant [PME]
[   40.676070] acpi PNP0A08:01: _OSC: platform retains control of PCIe features (AE_SUPPORT)
[   40.677094] acpi PNP0A08:01: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
[   40.689082] PCI host bridge to bus 0000:20
[   40.690071] pci_bus 0000:20: root bus resource [io  0x03b0-0x03df window]
[   40.691070] pci_bus 0000:20: root bus resource [mem 0x000a0000-0x000bffff window]
[   40.692070] pci_bus 0000:20: root bus resource [bus 20-ff]
[   40.704098] iommu: Default domain type: Translated 
[   40.705070] iommu: DMA domain TLB invalidation policy: lazy mode 
[   40.712082] SCSI subsystem initialized
[   40.717070] libata version 3.00 loaded.
[   40.718103] ACPI: bus type USB registered
[   40.720113] usbcore: registered new interface driver usbfs
[   40.723072] usbcore: registered new interface driver hub
[   40.725075] usbcore: registered new device driver usb
[   40.727079] pps_core: LinuxPPS API ver. 1 registered
[   40.728070] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[   40.729092] PTP clock support registered
[   40.738111] efivars: Registered efivars operations
[   40.751104] PCI: Using ACPI for IRQ routing
[   40.786096] PCI: Discovered peer bus 3f
[   40.787075] PCI: root bus 3f: using default resources
[   40.788077] PCI: Probing PCI hardware (bus 3f)
[   40.790095] PCI host bridge to bus 0000:3f
[   40.791071] pci_bus 0000:3f: root bus resource [io  0x0000-0xffff]
[   40.792070] pci_bus 0000:3f: root bus resource [mem 0x00000000-0x3fffffffffff]
[   40.793076] pci_bus 0000:3f: No busn resource found for root bus, will use [bus 3f-ff]
[   40.794077] pci_bus 0000:3f: busn_res: can not insert [bus 3f-ff] under domain [bus 00-ff] (conflicts with (null) [bus 20-ff])
[   40.795095] pci 0000:3f:08.0: [8086:3c80] type 00 class 0x088000
[   40.799071] pci 0000:3f:08.3: [8086:3c83] type 00 class 0x088000
[   40.803083] pci 0000:3f:08.4: [8086:3c84] type 00 class 0x088000
[   40.807085] pci 0000:3f:09.0: [8086:3c90] type 00 class 0x088000
[   40.810101] pci 0000:3f:09.3: [8086:3c93] type 00 class 0x088000
[   40.815077] pci 0000:3f:09.4: [8086:3c94] type 00 class 0x088000
[   40.819089] pci 0000:3f:0a.0: [8086:3cc0] type 00 class 0x088000
[   40.822087] pci 0000:3f:0a.1: [8086:3cc1] type 00 class 0x088000
[   40.825088] pci 0000:3f:0a.2: [8086:3cc2] type 00 class 0x088000
[   40.828091] pci 0000:3f:0a.3: [8086:3cd0] type 00 class 0x088000
[   40.831091] pci 0000:3f:0b.0: [8086:3ce0] type 00 class 0x088000
[   40.834085] pci 0000:3f:0b.3: [8086:3ce3] type 00 class 0x088000
[   40.837088] pci 0000:3f:0c.0: [8086:3ce8] type 00 class 0x088000
[   40.840084] pci 0000:3f:0c.1: [8086:3ce8] type 00 class 0x088000
[   40.843089] pci 0000:3f:0c.6: [8086:3cf4] type 00 class 0x088000
[   40.846084] pci 0000:3f:0c.7: [8086:3cf6] type 00 class 0x088000
[   40.849084] pci 0000:3f:0d.0: [8086:3ce8] type 00 class 0x088000
[   40.852090] pci 0000:3f:0d.1: [8086:3ce8] type 00 class 0x088000
[   40.855088] pci 0000:3f:0d.6: [8086:3cf5] type 00 class 0x088000
[   40.858091] pci 0000:3f:0e.0: [8086:3ca0] type 00 class 0x088000
[   40.861086] pci 0000:3f:0e.1: [8086:3c46] type 00 class 0x110100
[   40.864099] pci 0000:3f:0f.0: [8086:3ca8] type 00 class 0x088000
[   40.868115] pci 0000:3f:0f.1: [8086:3c71] type 00 class 0x088000
[   40.872115] pci 0000:3f:0f.2: [8086:3caa] type 00 class 0x088000
[   40.877074] pci 0000:3f:0f.3: [8086:3cab] type 00 class 0x088000
[   40.881072] pci 0000:3f:0f.4: [8086:3cac] type 00 class 0x088000
[   40.884115] pci 0000:3f:0f.5: [8086:3cad] type 00 class 0x088000
[   40.888111] pci 0000:3f:0f.6: [8086:3cae] type 00 class 0x088000
[   40.892098] pci 0000:3f:10.0: [8086:3cb0] type 00 class 0x088000
[   40.897070] pci 0000:3f:10.1: [8086:3cb1] type 00 class 0x088000
[   40.900114] pci 0000:3f:10.2: [8086:3cb2] type 00 class 0x088000
[   40.904114] pci 0000:3f:10.3: [8086:3cb3] type 00 class 0x088000
[   40.908113] pci 0000:3f:10.4: [8086:3cb4] type 00 class 0x088000
[   40.913073] pci 0000:3f:10.5: [8086:3cb5] type 00 class 0x088000
[   40.917069] pci 0000:3f:10.6: [8086:3cb6] type 00 class 0x088000
[   40.920113] pci 0000:3f:10.7: [8086:3cb7] type 00 class 0x088000
[   40.924111] pci 0000:3f:11.0: [8086:3cb8] type 00 class 0x088000
[   40.928098] pci 0000:3f:13.0: [8086:3ce4] type 00 class 0x088000
[   40.932089] pci 0000:3f:13.1: [8086:3c43] type 00 class 0x110100
[   40.935086] pci 0000:3f:13.4: [8086:3ce6] type 00 class 0x110100
[   40.938087] pci 0000:3f:13.5: [8086:3c44] type 00 class 0x110100
[   40.941087] pci 0000:3f:13.6: [8086:3c45] type 00 class 0x088000
[   40.944094] pci_bus 0000:3f: busn_res: [bus 3f-ff] end is updated to 3f
[   40.945070] pci_bus 0000:3f: busn_res: can not insert [bus 3f] under domain [bus 00-ff] (conflicts with (null) [bus 20-ff])
[   40.947101] PCI: pci_cache_line_size set to 64 bytes
[   40.951091] e820: reserve RAM buffer [mem 0x18ebb000-0x1bffffff]
[   40.952084] e820: reserve RAM buffer [mem 0x18fe9000-0x1bffffff]
[   40.953077] e820: reserve RAM buffer [mem 0x1dffd000-0x1fffffff]
[   40.954070] e820: reserve RAM buffer [mem 0xac77d000-0xafffffff]
[   40.955082] e820: reserve RAM buffer [mem 0xad800000-0xafffffff]
[   40.967107] pci 0000:03:00.0: vgaarb: setting as boot VGA device
[   40.968067] pci 0000:03:00.0: vgaarb: bridge control possible
[   40.968067] pci 0000:03:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[   40.968100] vgaarb: loaded
[   40.974090] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[   40.976070] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[   40.982099] clocksource: Switched to clocksource tsc-early
[   40.988240] pnp: PnP ACPI init
[   40.991521] system 00:00: [mem 0xfc000000-0xfcffffff] has been reserved
[   40.998103] system 00:00: [mem 0xfd000000-0xfdffffff] has been reserved
[   41.004680] system 00:00: [mem 0xfe000000-0xfeafffff] has been reserved
[   41.011255] system 00:00: [mem 0xfeb00000-0xfebfffff] has been reserved
[   41.017829] system 00:00: [mem 0xfed00400-0xfed3ffff] could not be reserved
[   41.024751] system 00:00: [mem 0xfed45000-0xfedfffff] has been reserved
[   41.031728] system 00:01: [io  0x0680-0x069f] has been reserved
[   41.037622] system 00:01: [io  0x0800-0x080f] has been reserved
[   41.043502] system 00:01: [io  0xffff] has been reserved
[   41.048782] system 00:01: [io  0xffff] has been reserved
[   41.054071] system 00:01: [io  0x0400-0x0453] has been reserved
[   41.059957] system 00:01: [io  0x0458-0x047f] has been reserved
[   41.065852] system 00:01: [io  0x0500-0x057f] has been reserved
[   41.071736] system 00:01: [io  0x164e-0x164f] has been reserved
[   41.077906] system 00:03: [io  0x0454-0x0457] has been reserved
[   41.085021] pnp: PnP ACPI: found 8 devices
[   41.098764] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[   41.107647] NET: Registered PF_INET protocol family
[   41.112764] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[   41.123763] tcp_listen_portaddr_hash hash table entries: 8192 (order: 7, 589824 bytes, linear)
[   41.132498] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[   41.140210] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[   41.148382] TCP bind hash table entries: 65536 (order: 11, 9437184 bytes, vmalloc hugepage)
[   41.159219] TCP: Hash tables configured (established 131072 bind 65536)
[   41.166013] UDP hash table entries: 8192 (order: 8, 1310720 bytes, linear)
[   41.173258] UDP-Lite hash table entries: 8192 (order: 8, 1310720 bytes, linear)
[   41.180980] NET: Registered PF_UNIX/PF_LOCAL protocol family
[   41.186659] pci 0000:00:01.0: PCI bridge to [bus 01]
[   41.191608] pci 0000:00:01.1: PCI bridge to [bus 02]
[   41.196553] pci 0000:00:02.0: PCI bridge to [bus 03]
[   41.201486] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[   41.207543] pci 0000:00:02.0:   bridge window [mem 0xf2000000-0xf30fffff]
[   41.214285] pci 0000:00:02.0:   bridge window [mem 0xf4000000-0xf9ffffff 64bit pref]
[   41.221982] pci 0000:00:03.0: PCI bridge to [bus 04]
[   41.226931] pci 0000:05:00.0: BAR 7: assigned [mem 0xfa804000-0xfa87ffff 64bit pref]
[   41.234647] pci 0000:00:11.0: PCI bridge to [bus 05]
[   41.239585] pci 0000:00:11.0:   bridge window [io  0xd000-0xdfff]
[   41.245639] pci 0000:00:11.0:   bridge window [mem 0xf3200000-0xf32fffff]
[   41.252386] pci 0000:00:11.0:   bridge window [mem 0xfa400000-0xfa8fffff 64bit pref]
[   41.260079] pci 0000:00:1c.0: PCI bridge to [bus 06]
[   41.265023] pci 0000:00:1c.2: PCI bridge to [bus 07]
[   41.269960] pci 0000:00:1c.2:   bridge window [mem 0xf3100000-0xf31fffff]
[   41.276711] pci 0000:00:1e.0: PCI bridge to [bus 08]
[   41.281652] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[   41.287796] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[   41.293936] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[   41.300074] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[   41.306214] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff window]
[   41.313041] pci_bus 0000:00: resource 9 [mem 0xb0000000-0xfbffffff window]
[   41.319872] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
[   41.325410] pci_bus 0000:03: resource 1 [mem 0xf2000000-0xf30fffff]
[   41.331630] pci_bus 0000:03: resource 2 [mem 0xf4000000-0xf9ffffff 64bit pref]
[   41.338804] pci_bus 0000:05: resource 0 [io  0xd000-0xdfff]
[   41.344341] pci_bus 0000:05: resource 1 [mem 0xf3200000-0xf32fffff]
[   41.350568] pci_bus 0000:05: resource 2 [mem 0xfa400000-0xfa8fffff 64bit pref]
[   41.357746] pci_bus 0000:07: resource 1 [mem 0xf3100000-0xf31fffff]
[   41.363973] pci_bus 0000:08: resource 4 [io  0x0000-0x03af window]
[   41.370109] pci_bus 0000:08: resource 5 [io  0x03e0-0x0cf7 window]
[   41.376252] pci_bus 0000:08: resource 6 [io  0x03b0-0x03df window]
[   41.382391] pci_bus 0000:08: resource 7 [io  0x0d00-0xffff window]
[   41.388533] pci_bus 0000:08: resource 8 [mem 0x000a0000-0x000dffff window]
[   41.395363] pci_bus 0000:08: resource 9 [mem 0xb0000000-0xfbffffff window]
[   41.402341] pci_bus 0000:20: resource 4 [io  0x03b0-0x03df window]
[   41.408484] pci_bus 0000:20: resource 5 [mem 0x000a0000-0x000bffff window]
[   41.415369] pci_bus 0000:3f: resource 4 [io  0x0000-0xffff]
[   41.420902] pci_bus 0000:3f: resource 5 [mem 0x00000000-0x3fffffffffff]
[   41.427523] pci 0000:00:05.0: disabled boot interrupts on device [8086:3c28]
[   41.436046] pci 0000:03:00.1: extending delay after power-on from D3hot to 20 msec
[   41.443731] pci 0000:03:00.1: D0 power state depends on 0000:03:00.0
[   41.450516] pci 0000:07:00.0: enabling device (0000 -> 0002)
[   41.456378] PCI: CLS 64 bytes, default 64
[   41.460417] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[   41.460652] Unpacking initramfs...
[   41.466819] software IO TLB: mapped [mem 0x00000000a877d000-0x00000000ac77d000] (64MB)
[   41.468717] Initialise system trusted keyrings
[   41.482767] workingset: timestamp_bits=56 max_order=22 bucket_order=0
[   41.489466] ntfs: driver 2.1.32 [Flags: R/W].
[   41.493806] fuse: init (API version 7.38)
[   41.498164] 9p: Installing v9fs 9p2000 file system support
[   41.503767] Key type asymmetric registered
[   41.507860] Asymmetric key parser 'x509' registered
[   41.512741] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[   41.527502] ACPI: \_PR_.CP00: Found 4 idle states
[   41.532304] ACPI: \_PR_.CP01: Found 4 idle states
[   41.537103] ACPI: \_PR_.CP02: Found 4 idle states
[   41.541902] ACPI: \_PR_.CP03: Found 4 idle states
[   41.546698] ACPI: \_PR_.CP04: Found 4 idle states
[   41.551499] ACPI: \_PR_.CP05: Found 4 idle states
[   41.556296] ACPI: \_PR_.CP06: Found 4 idle states
[   41.561095] ACPI: \_PR_.CP07: Found 4 idle states
[   41.597891] Freeing initrd memory: 8184K
[   41.619224] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   41.625632] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[   41.633871] serial 0000:00:16.3: enabling device (0000 -> 0003)
[   41.640546] 0000:00:16.3: ttyS1 at I/O 0xf0a0 (irq = 17, base_baud = 115200) is a 16550A
[   41.649256] Linux agpgart interface v0.103
[   41.653478] ACPI: bus type drm_connector registered
[   41.658694] nouveau 0000:03:00.0: vgaarb: deactivate vga console
[   41.664805] nouveau 0000:03:00.0: NVIDIA GT218 (0a8c00b1)
[   41.783852] nouveau 0000:03:00.0: bios: version 70.18.83.00.08
[   41.791350] nouveau 0000:03:00.0: fb: 512 MiB DDR3
[   41.947445] nouveau 0000:03:00.0: DRM: VRAM: 512 MiB
[   41.952387] nouveau 0000:03:00.0: DRM: GART: 1048576 MiB
[   41.957685] nouveau 0000:03:00.0: DRM: TMDS table version 2.0
[   41.963399] nouveau 0000:03:00.0: DRM: DCB version 4.0
[   41.968518] nouveau 0000:03:00.0: DRM: DCB outp 00: 02000360 00000000
[   41.974925] nouveau 0000:03:00.0: DRM: DCB outp 01: 02000362 00020010
[   41.981329] nouveau 0000:03:00.0: DRM: DCB outp 02: 028003a6 0f220010
[   41.987733] nouveau 0000:03:00.0: DRM: DCB outp 03: 01011380 00000000
[   41.994136] nouveau 0000:03:00.0: DRM: DCB outp 04: 08011382 00020010
[   42.000534] nouveau 0000:03:00.0: DRM: DCB outp 05: 088113c6 0f220010
[   42.006939] nouveau 0000:03:00.0: DRM: DCB conn 00: 00101064
[   42.012569] nouveau 0000:03:00.0: DRM: DCB conn 01: 00202165
[   42.020740] nouveau 0000:03:00.0: DRM: MM: using COPY for buffer copies
[   42.027341] stackdepot: allocating hash table of 1048576 entries via kvcalloc
[   42.038133] [drm] Initialized nouveau 1.3.1 20120801 for 0000:03:00.0 on minor 0
[   42.089491] fbcon: nouveaudrmfb (fb0) is primary device
[   42.222287] Console: switching to colour frame buffer device 210x65
[   42.237704] nouveau 0000:03:00.0: [drm] fb0: nouveaudrmfb frame buffer device
[   42.267022] megasas: 07.725.01.00-rc1
[   42.270935] st: Version 20160209, fixed bufsize 32768, s/g segs 256
[   42.277457] ahci 0000:00:1f.2: version 3.0
[   42.282257] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x3 impl SATA mode
[   42.290465] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ems apst 
[   42.303392] scsi host0: ahci
[   42.307226] scsi host1: ahci
[   42.311111] scsi host2: ahci
[   42.314950] scsi host3: ahci
[   42.318743] scsi host4: ahci
[   42.322567] scsi host5: ahci
[   42.325740] ata1: SATA max UDMA/133 abar m2048@0xf3326000 port 0xf3326100 irq 32
[   42.333262] ata2: SATA max UDMA/133 abar m2048@0xf3326000 port 0xf3326180 irq 32
[   42.340762] ata3: DUMMY
[   42.343325] ata4: DUMMY
[   42.345880] ata5: DUMMY
[   42.348442] ata6: DUMMY
[   42.351205] e1000e: Intel(R) PRO/1000 Network Driver
[   42.356285] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   42.362803] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[   42.455510] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized): registered PHC clock
[   42.494241] tsc: Refined TSC clocksource calibration: 3591.345 MHz
[   42.500474] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x33c4635c383, max_idle_ns: 440795314831 ns
[   42.510514] clocksource: Switched to clocksource tsc
[   42.552496] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) 90:b1:1c:7b:da:e7
[   42.560820] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
[   42.568045] e1000e 0000:00:19.0 eth0: MAC: 10, PHY: 11, PBA No: 7041FF-0FF
[   42.576375] xhci_hcd 0000:07:00.0: xHCI Host Controller
[   42.582333] xhci_hcd 0000:07:00.0: new USB bus registered, assigned bus number 1
[   42.590349] xhci_hcd 0000:07:00.0: hcc params 0x014042cb hci version 0x96 quirks 0x0000000000000004
[   42.602536] xhci_hcd 0000:07:00.0: xHCI Host Controller
[   42.602647] ehci-pci 0000:00:1a.0: EHCI Host Controller
[   42.608342] xhci_hcd 0000:07:00.0: new USB bus registered, assigned bus number 2
[   42.613250] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 3
[   42.621064] xhci_hcd 0000:07:00.0: Host supports USB 3.0 SuperSpeed
[   42.628018] ehci-pci 0000:00:1a.0: debug port 2
[   42.629138] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.04
[   42.638445] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf3328000
[   42.639756] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   42.647241] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[   42.650658] usb usb1: Product: xHCI Host Controller
[   42.650665] usb usb1: Manufacturer: Linux 6.4.0-rc1+ xhci-hcd
[   42.650669] usb usb1: SerialNumber: 0000:07:00.0
[   42.652419] hub 1-0:1.0: USB hub found
[   42.660282] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   42.665620] hub 1-0:1.0: 2 ports detected
[   42.667343] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   42.669920] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[   42.675530] ata1.00: ATA-8: ST2000DM001-1CH164, CC24, max UDMA/133
[   42.678188] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.04
[   42.682908] ata2.00: ATAPI: PLDS DVD+/-RW DS-8A9SH, ED11, max UDMA/100
[   42.684161] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   42.694439] ata2.00: configured for UDMA/100
[   42.697217] usb usb2: Product: xHCI Host Controller
[   42.765158] usb usb2: Manufacturer: Linux 6.4.0-rc1+ xhci-hcd
[   42.771427] usb usb2: SerialNumber: 0000:07:00.0
[   42.778718] hub 2-0:1.0: USB hub found
[   42.783042] hub 2-0:1.0: 2 ports detected
[   42.788048] usbcore: registered new interface driver usb-storage
[   42.788444] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.04
[   42.789304] usbcore: registered new interface driver usbserial_generic
[   42.795156] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   42.795165] usb usb3: Product: EHCI Host Controller
[   42.797255] usbserial: USB Serial support registered for generic
[   42.797531] usb usb3: Manufacturer: Linux 6.4.0-rc1+ ehci_hcd
[   42.798172] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[   42.798587] usb usb3: SerialNumber: 0000:00:1a.0
[   42.799069] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[   42.800360] hub 3-0:1.0: USB hub found
[   42.808768] i8042: Warning: Keylock active
[   42.809209] hub 3-0:1.0: 3 ports detected
[   42.809779] serio: i8042 KBD port at 0x60,0x64 irq 1
[   42.811128] ehci-pci 0000:00:1d.0: EHCI Host Controller
[   42.817677] mousedev: PS/2 mouse device common for all mice
[   42.817762] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 4
[   42.818566] usbcore: registered new interface driver synaptics_usb
[   42.819135] ehci-pci 0000:00:1d.0: debug port 2
[   42.819757] input: PC Speaker as /devices/platform/pcspkr/input/input1
[   42.824537] ehci-pci 0000:00:1d.0: irq 17, io mem 0xf3327000
[   42.828478] rtc_cmos 00:02: RTC can wake from S4
[   42.836151] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[   42.841430] rtc_cmos 00:02: registered as rtc0
[   42.847709] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.04
[   42.854387] rtc_cmos 00:02: setting system clock to 2023-05-31T17:20:58 UTC (1685553658)
[   42.858159] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   42.860212] rtc_cmos 00:02: alarms up to one year, y3k, 242 bytes nvram, hpet irqs
[   42.860700] usb usb4: Product: EHCI Host Controller
[   42.861280] fail to initialize ptp_kvm
[   42.861830] usb usb4: Manufacturer: Linux 6.4.0-rc1+ ehci_hcd
[   42.874856] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[   42.878162] usb usb4: SerialNumber: 0000:00:1d.0
[   42.886364] intel_pstate: Intel P-state driver initializing
[   42.887690] hub 4-0:1.0: USB hub found
[   42.888386] ata1.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[   42.893302] hub 4-0:1.0: 3 ports detected
[   42.895483] ata1.00: configured for UDMA/133
[   42.899361] hid: raw HID events driver (C) Jiri Kosina
[   42.903588] scsi 0:0:0:0: Direct-Access     ATA      ST2000DM001-1CH1 CC24 PQ: 0 ANSI: 5
[   42.903975] NET: Registered PF_INET6 protocol family
[   42.905834] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   42.905836] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
[   42.905844] sd 0:0:0:0: [sda] 4096-byte physical blocks
[   42.905863] sd 0:0:0:0: [sda] Write Protect is off
[   42.905865] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   42.905894] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   42.905935] sd 0:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
[   42.911734] Segment Routing with IPv6
[   42.924083] scsi 1:0:0:0: CD-ROM            PLDS     DVD+-RW DS-8A9SH ED11 PQ: 0 ANSI: 5
[   42.925549] In-situ OAM (IOAM) with IPv6
[   43.036891]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 sda14 sda15 >
[   43.037046] mip6: Mobile IPv6
[   43.040321] sd 0:0:0:0: [sda] Attached SCSI disk
[   43.042199] NET: Registered PF_PACKET protocol family
[   43.059171] usb 3-1: new high-speed USB device number 2 using ehci-pci
[   43.060717] 9pnet: Installing 9P2000 support
[   43.138146] usb 4-1: new high-speed USB device number 2 using ehci-pci
[   43.168224] microcode: Microcode Update Driver: v2.2.
[   43.168245] IPI shorthand broadcast: enabled
[   43.185467] sr 1:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[   43.185909] sched_clock: Marking stable (24988003896, 18197114398)->(40270383848, 2914734446)
[   43.186161] cdrom: Uniform CD-ROM driver Revision: 3.20
[   43.196244] registered taskstats version 1
[   43.196667] usb 3-1: New USB device found, idVendor=8087, idProduct=0024, bcdDevice= 0.00
[   43.196677] usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   43.197524] hub 3-1:1.0: USB hub found
[   43.197636] hub 3-1:1.0: 6 ports detected
[   43.240176] Loading compiled-in X.509 certificates
[   43.259441] sr 1:0:0:0: Attached scsi CD-ROM sr0
[   43.264879] sr 1:0:0:0: Attached scsi generic sg1 type 5
[   43.265646] printk: console [netcon0] enabled
[   43.276045] netconsole: network logging started
[   43.282842] clk: Disabling unused clocks
[   43.291169] Freeing unused decrypted memory: 2036K
[   43.298182] Freeing unused kernel image (initmem) memory: 3056K
[   43.301540] usb 4-1: New USB device found, idVendor=8087, idProduct=0024, bcdDevice= 0.00
[   43.313352] usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   43.324184] Write protecting the kernel read-only data: 20480k
[   43.328613] hub 4-1:1.0: USB hub found
[   43.335408] Freeing unused kernel image (rodata/data gap) memory: 424K
[   43.340672] hub 4-1:1.0: 8 ports detected
[   43.347007] Run /init as init process
[   43.351180]   with arguments:
[   43.354643]     /init
[   43.357428]   with environment:
[   43.361060]     HOME=/
[   43.363920]     TERM=linux
[   43.367134]     BOOT_IMAGE=/boot/vmlinuz-6.4.0-rc1+
[   44.634498] random: crng init done
[   45.164347] process '/usr/bin/fstype' started with executable stack
[   45.434574] EXT4-fs (sda7): mounted filesystem 6aef0462-c7e4-45ca-9a68-4e435300595e with ordered data mode. Quota mode: disabled.
[   47.352248] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input2
[   47.361715] ACPI: button: Power Button [PWRB]
[   47.367255] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[   47.379434] ACPI: button: Power Button [PWRF]
[   47.449607] acpi-cpufreq: probe of acpi-cpufreq failed with error -17
[   47.617916] i801_smbus 0000:00:1f.3: enabling device (0000 -> 0003)
[   47.626336] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[   47.639363] i2c i2c-14: 4/4 memory slots populated (from DMI)
[   47.658951] iTCO_vendor_support: vendor-support=0
[   47.719940] iTCO_wdt iTCO_wdt.1.auto: Found a Patsburg TCO device (Version=2, TCOBASE=0x0460)
[   47.733500] iTCO_wdt iTCO_wdt.1.auto: initialized. heartbeat=30 sec (nowayout=0)
[   47.746305] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 163840 ms ovfl timer
[   47.755374] RAPL PMU: hw unit of domain pp0-core 2^-16 Joules
[   47.762241] RAPL PMU: hw unit of domain package 2^-16 Joules
[   47.813203] cryptd: max_cpu_qlen set to 1000
[   47.881441] AVX version of gcm_enc/dec engaged.
[   47.887212] AES CTR mode by8 optimization enabled
[   50.016398] EDAC MC: Ver: 3.0.0
[   50.022299] EDAC DEBUG: edac_mc_sysfs_init: device mc created
[   50.092319] EDAC DEBUG: sbridge_init: 
[   50.097607] EDAC sbridge: Seeking for: PCI ID 8086:3ca0
[   50.104497] EDAC DEBUG: sbridge_get_onedevice: Detected 8086:3ca0
[   50.113044] EDAC sbridge: Seeking for: PCI ID 8086:3ca0
[   50.121202] EDAC sbridge: Seeking for: PCI ID 8086:3ca8
[   50.127596] EDAC DEBUG: sbridge_get_onedevice: Detected 8086:3ca8
[   50.134472] EDAC sbridge: Seeking for: PCI ID 8086:3ca8
[   50.141058] EDAC sbridge: Seeking for: PCI ID 8086:3c71
[   50.147247] EDAC DEBUG: sbridge_get_onedevice: Detected 8086:3c71
[   50.154406] EDAC sbridge: Seeking for: PCI ID 8086:3c71
[   50.161081] EDAC sbridge: Seeking for: PCI ID 8086:3caa
[   50.167359] EDAC DEBUG: sbridge_get_onedevice: Detected 8086:3caa
[   50.174411] EDAC sbridge: Seeking for: PCI ID 8086:3caa
[   50.180169] EDAC sbridge: Seeking for: PCI ID 8086:3cab
[   50.185916] EDAC DEBUG: sbridge_get_onedevice: Detected 8086:3cab
[   50.192971] EDAC sbridge: Seeking for: PCI ID 8086:3cab
[   50.198676] EDAC sbridge: Seeking for: PCI ID 8086:3cac
[   50.205154] EDAC DEBUG: sbridge_get_onedevice: Detected 8086:3cac
[   50.211707] EDAC sbridge: Seeking for: PCI ID 8086:3cac
[   50.218146] EDAC sbridge: Seeking for: PCI ID 8086:3cad
[   50.224107] EDAC DEBUG: sbridge_get_onedevice: Detected 8086:3cad
[   50.230940] EDAC sbridge: Seeking for: PCI ID 8086:3cad
[   50.236631] EDAC sbridge: Seeking for: PCI ID 8086:3cb8
[   50.243107] EDAC DEBUG: sbridge_get_onedevice: Detected 8086:3cb8
[   50.249656] EDAC sbridge: Seeking for: PCI ID 8086:3cb8
[   50.255337] EDAC sbridge: Seeking for: PCI ID 8086:3cf4
[   50.261334] EDAC DEBUG: sbridge_get_onedevice: Detected 8086:3cf4
[   50.267899] EDAC sbridge: Seeking for: PCI ID 8086:3cf4
[   50.273587] EDAC sbridge: Seeking for: PCI ID 8086:3cf6
[   50.279279] EDAC DEBUG: sbridge_get_onedevice: Detected 8086:3cf6
[   50.285880] EDAC sbridge: Seeking for: PCI ID 8086:3cf6
[   50.291823] EDAC sbridge: Seeking for: PCI ID 8086:3cf5
[   50.297918] EDAC DEBUG: sbridge_get_onedevice: Detected 8086:3cf5
[   50.304453] EDAC sbridge: Seeking for: PCI ID 8086:3cf5
[   50.310169] EDAC DEBUG: sbridge_probe: Registering MC#0 (1 of 1)
[   50.316914] EDAC DEBUG: sbridge_register_mci: MC: mci = 00000000fc1d5f67, dev = 00000000b83d72de
[   50.326137] EDAC DEBUG: sbridge_mci_bind_devs: Associated PCI 8086:3ca0, bus 63 with dev = 000000006237880f
[   50.336538] EDAC DEBUG: sbridge_mci_bind_devs: Associated PCI 8086:3ca8, bus 63 with dev = 00000000feac8781
[   50.346671] EDAC DEBUG: sbridge_mci_bind_devs: Associated PCI 8086:3c71, bus 63 with dev = 0000000049e1a2e9
[   50.356802] EDAC DEBUG: sbridge_mci_bind_devs: Associated PCI 8086:3caa, bus 63 with dev = 00000000050d2144
[   50.367137] EDAC DEBUG: sbridge_mci_bind_devs: Associated PCI 8086:3cab, bus 63 with dev = 00000000816523e1
[   50.377506] EDAC DEBUG: sbridge_mci_bind_devs: Associated PCI 8086:3cac, bus 63 with dev = 0000000021323927
[   50.388133] EDAC DEBUG: sbridge_mci_bind_devs: Associated PCI 8086:3cad, bus 63 with dev = 00000000c918e29b
[   50.398223] EDAC DEBUG: sbridge_mci_bind_devs: Associated PCI 8086:3cb8, bus 63 with dev = 0000000082a365be
[   50.408321] EDAC DEBUG: sbridge_mci_bind_devs: Associated PCI 8086:3cf4, bus 63 with dev = 0000000024e1afac
[   50.418676] EDAC DEBUG: sbridge_mci_bind_devs: Associated PCI 8086:3cf6, bus 63 with dev = 00000000b24847b5
[   50.428820] EDAC DEBUG: sbridge_mci_bind_devs: Associated PCI 8086:3cf5, bus 63 with dev = 0000000097fcc79e
[   50.438952] EDAC DEBUG: get_dimm_config: mc#0: Node ID: 0, source ID: 0
[   50.446162] EDAC DEBUG: get_dimm_config: Memory mirroring is disabled
[   50.453181] EDAC DEBUG: get_dimm_config: Lockstep is disabled
[   50.459837] EDAC DEBUG: get_dimm_config: address map is on open page mode
[   50.466986] EDAC DEBUG: __populate_dimms: Memory is registered
[   50.473817] EDAC DEBUG: __populate_dimms: mc#0: ha 0 channel 0, dimm 0, 4096 MiB (1048576 pages) bank: 8, rank: 2, row: 0x8000, col: 0x400
[   50.486836] EDAC DEBUG: __populate_dimms: mc#0: ha 0 channel 1, dimm 0, 4096 MiB (1048576 pages) bank: 8, rank: 2, row: 0x8000, col: 0x400
[   50.499636] EDAC DEBUG: __populate_dimms: mc#0: ha 0 channel 2, dimm 0, 4096 MiB (1048576 pages) bank: 8, rank: 2, row: 0x8000, col: 0x400
[   50.512389] EDAC DEBUG: __populate_dimms: mc#0: ha 0 channel 3, dimm 0, 4096 MiB (1048576 pages) bank: 8, rank: 2, row: 0x8000, col: 0x400
[   50.525149] EDAC DEBUG: get_memory_layout: TOLM: 2.812 GB (0x00000000b3ffffff)
[   50.532968] EDAC DEBUG: get_memory_layout: TOHM: 17.312 GB (0x0000000453ffffff)
[   50.540626] EDAC DEBUG: get_memory_layout: SAD#0 DRAM up to 17.250 GB (0x0000000450000000) Interleave: [8:6] reg=0x000044c3
[   50.552318] EDAC DEBUG: get_memory_layout: SAD#0, interleave #0: 0
[   50.559608] EDAC DEBUG: get_memory_layout: TAD#0: up to 2.750 GB (0x00000000b0000000), socket interleave 1, memory interleave 4, TGT: 0, 1, 2, 3, reg=0x0002b3e4
[   50.574277] EDAC DEBUG: get_memory_layout: TAD#1: up to 17.250 GB (0x0000000450000000), socket interleave 1, memory interleave 4, TGT: 0, 1, 2, 3, reg=0x001133e4
[   50.589045] EDAC DEBUG: get_memory_layout: TAD CH#0, offset #0: 0.000 GB (0x0000000000000000), reg=0x00000000
[   50.599583] EDAC DEBUG: get_memory_layout: TAD CH#0, offset #1: 1.250 GB (0x0000000050000000), reg=0x00000500
[   50.609863] EDAC DEBUG: get_memory_layout: TAD CH#1, offset #0: 0.000 GB (0x0000000000000000), reg=0x00000000
[   50.620382] EDAC DEBUG: get_memory_layout: TAD CH#1, offset #1: 1.250 GB (0x0000000050000000), reg=0x00000500
[   50.630651] EDAC DEBUG: get_memory_layout: TAD CH#2, offset #0: 0.000 GB (0x0000000000000000), reg=0x00000000
[   50.641173] EDAC DEBUG: get_memory_layout: TAD CH#2, offset #1: 1.250 GB (0x0000000050000000), reg=0x00000500
[   50.652138] EDAC DEBUG: get_memory_layout: TAD CH#3, offset #0: 0.000 GB (0x0000000000000000), reg=0x00000000
[   50.662616] EDAC DEBUG: get_memory_layout: TAD CH#3, offset #1: 1.250 GB (0x0000000050000000), reg=0x00000500
[   50.668122] raid6: sse2x4   gen() 16567 MB/s
[   50.672887] EDAC DEBUG: get_memory_layout: CH#0 RIR#0, limit: 3.999 GB (0x00000000fff00000), way: 2, reg=0x9000000e
[   50.688328] EDAC DEBUG: get_memory_layout: CH#0 RIR#0 INTL#0, offset 0.000 GB (0x0000000000000000), tgt: 0, reg=0x00000000
[   50.695132] raid6: sse2x2   gen() 18515 MB/s
[   50.699738] EDAC DEBUG: get_memory_layout: CH#0 RIR#0 INTL#1, offset 0.000 GB (0x0000000000000000), tgt: 1, reg=0x00010000
[   50.716064] EDAC DEBUG: get_memory_layout: CH#1 RIR#0, limit: 3.999 GB (0x00000000fff00000), way: 2, reg=0x9000000e
[   50.717125] raid6: sse2x1   gen() 13790 MB/s
[   50.727383] EDAC DEBUG: get_memory_layout: CH#1 RIR#0 INTL#0, offset 0.000 GB (0x0000000000000000), tgt: 0, reg=0x00000000
[   50.731584] raid6: using algorithm sse2x2 gen() 18515 MB/s
[   50.732073] EDAC DEBUG: get_memory_layout: CH#1 RIR#0 INTL#1, offset 0.000 GB (0x0000000000000000), tgt: 1, reg=0x00010000
[   50.749122] raid6: .... xor() 9361 MB/s, rmw enabled
[   50.749425] EDAC DEBUG: get_memory_layout: CH#2 RIR#0, limit: 3.999 GB (0x00000000fff00000), way: 2, reg=0x9000000e
[   50.750140] raid6: using ssse3x2 recovery algorithm
[   50.750512] EDAC DEBUG: get_memory_layout: CH#2 RIR#0 INTL#0, offset 0.000 GB (0x0000000000000000), tgt: 0, reg=0x00000000
[   50.793914] EDAC DEBUG: get_memory_layout: CH#2 RIR#0 INTL#1, offset 0.000 GB (0x0000000000000000), tgt: 1, reg=0x00010000
[   50.805528] EDAC DEBUG: get_memory_layout: CH#3 RIR#0, limit: 3.999 GB (0x00000000fff00000), way: 2, reg=0x9000000e
[   50.805651] xor: automatically using best checksumming function   avx       
[   50.806070] EDAC DEBUG: get_memory_layout: CH#3 RIR#0 INTL#0, offset 0.000 GB (0x0000000000000000), tgt: 0, reg=0x00000000
[   50.835451] EDAC DEBUG: get_memory_layout: CH#3 RIR#0 INTL#1, offset 0.000 GB (0x0000000000000000), tgt: 1, reg=0x00010000
[   50.846975] EDAC DEBUG: edac_mc_add_mc_with_groups: 
[   50.852997] EDAC DEBUG: edac_create_sysfs_mci_device: device mc0 created
[   50.860424] EDAC DEBUG: edac_create_dimm_object: device dimm0 created at location channel 0 slot 0 
[   50.870348] EDAC DEBUG: edac_create_dimm_object: device dimm3 created at location channel 1 slot 0 
[   50.879983] EDAC DEBUG: edac_create_dimm_object: device dimm6 created at location channel 2 slot 0 
[   50.889619] EDAC DEBUG: edac_create_dimm_object: device dimm9 created at location channel 3 slot 0 
[   50.899294] EDAC DEBUG: edac_create_csrow_object: device csrow0 created
[   50.906987] EDAC MC0: Giving out device to module sb_edac controller Sandy Bridge SrcID#0_Ha#0: DEV 0000:3f:0e.0 (INTERRUPT)
[   50.918737] EDAC sbridge:  Ver: 1.1.2 
[   51.219795] Btrfs loaded, zoned=no, fsverity=no
[   51.242568] BTRFS: device label leap42.1 devid 1 transid 970 /dev/sda12 scanned by systemd-udevd (400)
[   51.365772] BTRFS: device label leap15 devid 1 transid 673 /dev/sda15 scanned by systemd-udevd (387)
[   51.388483] BTRFS: device label 12sp2 devid 1 transid 345 /dev/sda13 scanned by systemd-udevd (376)
[   51.414242] BTRFS: device label SLE12SP3 devid 1 transid 47084 /dev/sda9 scanned by systemd-udevd (394)
[   51.447800] BTRFS: device label 12sp1 devid 1 transid 268 /dev/sda14 scanned by systemd-udevd (386)
[   51.996348] e1000e 0000:00:19.0 eth0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   52.010023] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   52.273823] Adding 33554428k swap on /dev/sda5.  Priority:-2 extents:1 across:33554428k 
[   52.388663] EXT4-fs (sda7): re-mounted 6aef0462-c7e4-45ca-9a68-4e435300595e. Quota mode: disabled.
[   53.583074] EXT4-fs (sda6): mounting ext3 file system using the ext4 subsystem
[   53.869852] EXT4-fs (sda6): mounted filesystem 6b02369b-7362-4920-b703-8ba36125139f with ordered data mode. Quota mode: disabled.
[   53.940759] FAT-fs (sda1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[   53.969227] BTRFS info (device sda9): using crc32c (crc32c-intel) checksum algorithm
[   53.980221] BTRFS info (device sda9): disk space caching is enabled
[   54.715670] SGI XFS with ACLs, security attributes, quota, no debug enabled
[   54.751050] XFS (sda10): Deprecated V4 format (crc=0) will not be supported after September 2030.
[   54.780009] XFS (sda10): Mounting V4 Filesystem b62c870e-d204-498e-999b-5a0ea7c560cd
[   54.913313] XFS (sda10): Ending clean mount
[   54.920531] xfs filesystem being mounted at /mnt/kernel supports timestamps until 2038-01-19 (0x7fffffff)
[   55.121930] EXT4-fs (sda11): mounted filesystem a1428eb4-29da-4a1f-bbde-e9dc1081fb27 with ordered data mode. Quota mode: disabled.






-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
