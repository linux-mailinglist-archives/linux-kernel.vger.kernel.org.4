Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FB367B1A6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbjAYLju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235597AbjAYLjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:39:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B8093D0;
        Wed, 25 Jan 2023 03:39:34 -0800 (PST)
Date:   Wed, 25 Jan 2023 11:39:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674646773;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JxhCGxMvdLa+0WXtDH9qfNnCD3UABqFwwGYEf+V+huU=;
        b=TcpxGEw4PDjnHbORQrsdhWYqpDU00q6gEV3hZW5IUaVqVcVHjg0RV2AlYBlxERZ72lKFoE
        szJzdOS1bgdabreLgqzjHFWJpveyfM2JwHHj2NJYky3AmPjro4d3QxIPTsyU/UY2XEe3WV
        zaBFIlRpRIKwelccHVHJdhWv+ixr5cMNNcAUsbLB7521KLluER7Ul/kzvQCXcuXXv4QtxO
        lpo3scGCQ4KtptH+wjQ6q6X094da0ofMLlSTA2BID36ikBFbrjkMlU6PH7YtasUQdmAmo2
        ipdGqciorgWZKShPYa3iQGyCl8xV85OBTU5tAwAqtD3Kjs6wx+a7iRbpcvNuOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674646773;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JxhCGxMvdLa+0WXtDH9qfNnCD3UABqFwwGYEf+V+huU=;
        b=2GelqKaOl18Xp5jdCW7WNLFJSzMdDAKcZlqErnZNMHZYqioFCkYLPkYp6ePP0afunvp7ax
        2Yb+eyalpEyBqEDQ==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vdso] x86/vdso: Move VDSO image init to vdso2c generated code
Cc:     Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230124184019.26850-1-brgerst@gmail.com>
References: <20230124184019.26850-1-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <167464677321.4906.10647012897510355541.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/vdso branch of tip:

Commit-ID:     4c382d723edce1b3c72b55b1b505cf5526a56afc
Gitweb:        https://git.kernel.org/tip/4c382d723edce1b3c72b55b1b505cf5526a56afc
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Tue, 24 Jan 2023 13:40:19 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Jan 2023 12:33:40 +01:00

x86/vdso: Move VDSO image init to vdso2c generated code

Generate an init function for each VDSO image, replacing init_vdso() and
sysenter_setup().

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230124184019.26850-1-brgerst@gmail.com
---
 arch/x86/entry/vdso/vdso2c.h       |  6 ++++++
 arch/x86/entry/vdso/vdso32-setup.c |  9 ---------
 arch/x86/entry/vdso/vma.c          | 19 ++++---------------
 arch/x86/include/asm/processor.h   |  1 -
 arch/x86/include/asm/vdso.h        |  2 +-
 arch/x86/kernel/cpu/common.c       |  1 -
 6 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 5264daa..67b3e37 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -179,6 +179,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 
 	fprintf(outfile, "/* AUTOMATICALLY GENERATED -- DO NOT EDIT */\n\n");
 	fprintf(outfile, "#include <linux/linkage.h>\n");
+	fprintf(outfile, "#include <linux/init.h>\n");
 	fprintf(outfile, "#include <asm/page_types.h>\n");
 	fprintf(outfile, "#include <asm/vdso.h>\n");
 	fprintf(outfile, "\n");
@@ -218,5 +219,10 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 			fprintf(outfile, "\t.sym_%s = %" PRIi64 ",\n",
 				required_syms[i].name, (int64_t)syms[i]);
 	}
+	fprintf(outfile, "};\n\n");
+	fprintf(outfile, "static __init int init_%s(void) {\n", image_name);
+	fprintf(outfile, "\treturn init_vdso_image(&%s);\n", image_name);
 	fprintf(outfile, "};\n");
+	fprintf(outfile, "subsys_initcall(init_%s);\n", image_name);
+
 }
diff --git a/arch/x86/entry/vdso/vdso32-setup.c b/arch/x86/entry/vdso/vdso32-setup.c
index 43842fa..3b300a7 100644
--- a/arch/x86/entry/vdso/vdso32-setup.c
+++ b/arch/x86/entry/vdso/vdso32-setup.c
@@ -51,17 +51,8 @@ __setup("vdso32=", vdso32_setup);
 __setup_param("vdso=", vdso_setup, vdso32_setup, 0);
 #endif
 
-int __init sysenter_setup(void)
-{
-	init_vdso_image(&vdso_image_32);
-
-	return 0;
-}
-
 #ifdef CONFIG_X86_64
 
-subsys_initcall(sysenter_setup);
-
 #ifdef CONFIG_SYSCTL
 /* Register vsyscall32 into the ABI table */
 #include <linux/sysctl.h>
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index b8f3f9b..2738eb2 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -44,13 +44,16 @@ unsigned int vclocks_used __read_mostly;
 unsigned int __read_mostly vdso64_enabled = 1;
 #endif
 
-void __init init_vdso_image(const struct vdso_image *image)
+int __init init_vdso_image(const struct vdso_image *image)
 {
+	BUILD_BUG_ON(VDSO_CLOCKMODE_MAX >= 32);
 	BUG_ON(image->size % PAGE_SIZE != 0);
 
 	apply_alternatives((struct alt_instr *)(image->data + image->alt),
 			   (struct alt_instr *)(image->data + image->alt +
 						image->alt_len));
+
+	return 0;
 }
 
 static const struct vm_special_mapping vvar_mapping;
@@ -418,18 +421,4 @@ static __init int vdso_setup(char *s)
 	return 1;
 }
 __setup("vdso=", vdso_setup);
-
-static int __init init_vdso(void)
-{
-	BUILD_BUG_ON(VDSO_CLOCKMODE_MAX >= 32);
-
-	init_vdso_image(&vdso_image_64);
-
-#ifdef CONFIG_X86_X32_ABI
-	init_vdso_image(&vdso_image_x32);
-#endif
-
-	return 0;
-}
-subsys_initcall(init_vdso);
 #endif /* CONFIG_X86_64 */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4e35c66..2dd0c8a 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -542,7 +542,6 @@ enum idle_boot_override {IDLE_NO_OVERRIDE=0, IDLE_HALT, IDLE_NOMWAIT,
 			 IDLE_POLL};
 
 extern void enable_sep_cpu(void);
-extern int sysenter_setup(void);
 
 
 /* Defined in head.S */
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 2963a2f..d7f6592 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -45,7 +45,7 @@ extern const struct vdso_image vdso_image_x32;
 extern const struct vdso_image vdso_image_32;
 #endif
 
-extern void __init init_vdso_image(const struct vdso_image *image);
+extern int __init init_vdso_image(const struct vdso_image *image);
 
 extern int map_vdso_once(const struct vdso_image *image, unsigned long addr);
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9cfca3d..3a9043e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1953,7 +1953,6 @@ void __init identify_boot_cpu(void)
 	if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
 		pr_info("CET detected: Indirect Branch Tracking enabled\n");
 #ifdef CONFIG_X86_32
-	sysenter_setup();
 	enable_sep_cpu();
 #endif
 	cpu_detect_tlb(&boot_cpu_data);
