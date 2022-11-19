Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4BB630F72
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbiKSQYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbiKSQYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:24:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CC84046D;
        Sat, 19 Nov 2022 08:24:09 -0800 (PST)
Date:   Sat, 19 Nov 2022 16:24:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668875048;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eErEkh93FZmJw0rBRHpoCgoEnGvqJ6kmfJH8tC4qlQQ=;
        b=oTuRkHGbcDuigmJ4aQxJ15Ma0OpvSRlVEqk9LnuQBgnUqrH7Diaq7c5LSqOqc2mT1v0Kip
        +H3etFfUmx+2fcQea+4ztg8xxCq8MqE+p4pXw49+wh61XXejXyEqsoK0tiPtZUxSsRbIIx
        BPuHl6bg55UtAsrU/gU4r1AG090sf7EcvucVNH6E2TV9E6c5BI3PJjxFDwl6nHCUnmEa5u
        L9JN7A1hjcxi6WksJXsKK4bq8MGMrZz+Q8xoqjj5zajmrYT3mZz/9JL5XXzH+N+pdkyTtx
        6amRR/biU9wvDxpV8ooEMNGDYGucmLafmQsnugmJqgoa387T/2of0sut7xLWxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668875048;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eErEkh93FZmJw0rBRHpoCgoEnGvqJ6kmfJH8tC4qlQQ=;
        b=C8AaoHhpzx73CK2Jh+QZ1F4bNaHkKFJ9esqR3VtKpNtfxZnD7UqqZZbJeRX7LBzZyoamq5
        loeDFWNeGqV9olCw==
From:   "tip-bot2 for Jithu Joseph" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Add hdr_type to
 intel_microcode_sanity_check()
Cc:     Jithu Joseph <jithu.joseph@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117035935.4136738-9-jithu.joseph@intel.com>
References: <20221117035935.4136738-9-jithu.joseph@intel.com>
MIME-Version: 1.0
Message-ID: <166887504663.4906.2663978541913631750.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     e0788c3281a72386e75b53a010de4bfbac7e80db
Gitweb:        https://git.kernel.org/tip/e0788c3281a72386e75b53a010de4bfbac7e80db
Author:        Jithu Joseph <jithu.joseph@intel.com>
AuthorDate:    Wed, 16 Nov 2022 19:59:27 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Nov 2022 22:08:19 +01:00

x86/microcode/intel: Add hdr_type to intel_microcode_sanity_check()

IFS test images and microcode blobs use the same header format.
Microcode blobs use header type of 1, whereas IFS test images
will use header type of 2.

In preparation for IFS reusing intel_microcode_sanity_check(),
add header type as a parameter for sanity check.

  [ bp: Touchups. ]

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Link: https://lore.kernel.org/r/20221117035935.4136738-9-jithu.joseph@intel.com
---
 arch/x86/include/asm/cpu.h             |  2 +-
 arch/x86/include/asm/microcode_intel.h |  1 +
 arch/x86/kernel/cpu/intel.c            | 21 ++++++++++++++++++---
 arch/x86/kernel/cpu/microcode/intel.c  |  4 ++--
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 9e3ac95..78796b9 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -96,6 +96,6 @@ static inline bool intel_cpu_signatures_match(unsigned int s1, unsigned int p1,
 
 extern u64 x86_read_arch_cap_msr(void);
 int intel_find_matching_signature(void *mc, unsigned int csig, int cpf);
-int intel_microcode_sanity_check(void *mc, bool print_err);
+int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type);
 
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
index 4c92cea..2a999bf 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -41,6 +41,7 @@ struct extended_sigtable {
 #define DEFAULT_UCODE_TOTALSIZE (DEFAULT_UCODE_DATASIZE + MC_HEADER_SIZE)
 #define EXT_HEADER_SIZE		(sizeof(struct extended_sigtable))
 #define EXT_SIGNATURE_SIZE	(sizeof(struct extended_signature))
+#define MC_HEADER_TYPE_MICROCODE	1
 
 #define get_totalsize(mc) \
 	(((struct microcode_intel *)mc)->hdr.datasize ? \
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index bef06a1..b6997eb 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -244,7 +244,21 @@ int intel_find_matching_signature(void *mc, unsigned int csig, int cpf)
 }
 EXPORT_SYMBOL_GPL(intel_find_matching_signature);
 
-int intel_microcode_sanity_check(void *mc, bool print_err)
+/**
+ * intel_microcode_sanity_check() - Sanity check microcode file.
+ * @mc: Pointer to the microcode file contents.
+ * @print_err: Display failure reason if true, silent if false.
+ * @hdr_type: Type of file, i.e. normal microcode file or In Field Scan file.
+ *            Validate if the microcode header type matches with the type
+ *            specified here.
+ *
+ * Validate certain header fields and verify if computed checksum matches
+ * with the one specified in the header.
+ *
+ * Return: 0 if the file passes all the checks, -EINVAL if any of the checks
+ * fail.
+ */
+int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type)
 {
 	unsigned long total_size, data_size, ext_table_size;
 	struct microcode_header_intel *mc_header = mc;
@@ -261,9 +275,10 @@ int intel_microcode_sanity_check(void *mc, bool print_err)
 		return -EINVAL;
 	}
 
-	if (mc_header->ldrver != 1 || mc_header->hdrver != 1) {
+	if (mc_header->ldrver != 1 || mc_header->hdrver != hdr_type) {
 		if (print_err)
-			pr_err("Error: invalid/unknown microcode update format.\n");
+			pr_err("Error: invalid/unknown microcode update format. Header type %d\n",
+			       mc_header->hdrver);
 		return -EINVAL;
 	}
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index fb6ff71..c4a00fb 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -155,7 +155,7 @@ scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
 		mc_size = get_totalsize(mc_header);
 		if (!mc_size ||
 		    mc_size > size ||
-		    intel_microcode_sanity_check(data, false) < 0)
+		    intel_microcode_sanity_check(data, false, MC_HEADER_TYPE_MICROCODE) < 0)
 			break;
 
 		size -= mc_size;
@@ -694,7 +694,7 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 		memcpy(mc, &mc_header, sizeof(mc_header));
 		data = mc + sizeof(mc_header);
 		if (!copy_from_iter_full(data, data_size, iter) ||
-		    intel_microcode_sanity_check(mc, true) < 0) {
+		    intel_microcode_sanity_check(mc, true, MC_HEADER_TYPE_MICROCODE) < 0) {
 			break;
 		}
 
