Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434ED67A17B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjAXSlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjAXSk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:40:58 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C154863D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:40:33 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id q15so13934385qtn.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RYam2i3EKsFNPrchhrU5ikv1n/kTlmFdvF0WCf3work=;
        b=Sj1w9zFP10sFdDa4LxiULiaWru1VLCTMIUbKZ2DDy8c/Qzn7efCDP5jYjOmOaUGAFJ
         0IJwjQYMBk1MN+XESDME+Of3xZfiaKMkHZrR4+zERu0K/5E/kErIJ8cbRzQq7UCJXtfz
         WKOojc3Dc5HdfSN21zsf32NFFJCJyWTxq1CZBTy1+xulpTxJzTdxBStiQGTrEkwkPHwD
         ZVFUli7O9YD5Yx9mvbPK8M6qiUWvectiV2/Z0DbzmtR/c1G4WykT6Vu30wC/JDNTiArV
         GUrX3cy8gHgjpXEaNEa5bmCvfxlvcW5R1QHF8mZrvxdN7949s3Kwl5wnkSb1HK9LXRnV
         OANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RYam2i3EKsFNPrchhrU5ikv1n/kTlmFdvF0WCf3work=;
        b=DW3t4kcvANm/IzhLpgHRO8Z7A1oOJ3hmf7DVtb9z+fsaOheevoMPtF8eqgJLkn/5NW
         srpO9JcXMX3a6jiDQWpGYOOYY7ppEwC0IBdO17+aMLOKHMH9r++iUkR0UZjQ7TGlFjhm
         7PmsFt7NP1WaDJiMVnoN4CMNlkifnfYGd5aa3t/ORJPAmKeoP/CMynI/udr2vU6jgnqp
         /XtvPAB9WehuD0jyPZ+hursYuK9zkQLnnF1e8XMEpMwhp3sAkh7wy9aE2JGW+0s3cjSz
         BnjZUgxdPDpRlYnXnL4eViSb/kllmmluheC8qW8ZzKkeLtscwGbLnWhvSoyjEgIjo6y/
         wPuQ==
X-Gm-Message-State: AFqh2kpyolOTqyztJaqvNbGBsmR8e1QLHkuHxUWQ5itEKNryir6We7dE
        nI6p8tuawCcVK+a7tKBaIjuQbwiUXw==
X-Google-Smtp-Source: AMrXdXsD0oSWyiiY7sAbHAb3ZahBe+K4MC3NFLuF2pDRgZo/eBH3XZxPZ05GuzKKa/sqg1WppfbVdA==
X-Received: by 2002:ac8:58c3:0:b0:3a8:1635:ae5e with SMTP id u3-20020ac858c3000000b003a81635ae5emr57313856qta.39.1674585630724;
        Tue, 24 Jan 2023 10:40:30 -0800 (PST)
Received: from citadel.. (075-134-122-108.res.spectrum.com. [75.134.122.108])
        by smtp.gmail.com with ESMTPSA id a9-20020ac84349000000b003adc7f652a0sm1698423qtn.66.2023.01.24.10.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 10:40:30 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: [PATCH] x86/vdso: Move VDSO image init to vdso2c generated code
Date:   Tue, 24 Jan 2023 13:40:19 -0500
Message-Id: <20230124184019.26850-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generate an init function for each VDSO image, replacing init_vdso() and
sysenter_setup().

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/vdso/vdso2c.h       |  6 ++++++
 arch/x86/entry/vdso/vdso32-setup.c |  9 ---------
 arch/x86/entry/vdso/vma.c          | 19 ++++---------------
 arch/x86/include/asm/processor.h   |  1 -
 arch/x86/include/asm/vdso.h        |  2 +-
 arch/x86/kernel/cpu/common.c       |  1 -
 6 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 5264daa8859f..67b3e37576a6 100644
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
index 43842fade8fa..3b300a773c7e 100644
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
index b8f3f9b9e53c..2738eb28cb2e 100644
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
index a77dee6a2bf2..8d73004e4cac 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -542,7 +542,6 @@ enum idle_boot_override {IDLE_NO_OVERRIDE=0, IDLE_HALT, IDLE_NOMWAIT,
 			 IDLE_POLL};
 
 extern void enable_sep_cpu(void);
-extern int sysenter_setup(void);
 
 
 /* Defined in head.S */
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 2963a2f5dbc4..d7f6592b74a9 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -45,7 +45,7 @@ extern const struct vdso_image vdso_image_x32;
 extern const struct vdso_image vdso_image_32;
 #endif
 
-extern void __init init_vdso_image(const struct vdso_image *image);
+extern int __init init_vdso_image(const struct vdso_image *image);
 
 extern int map_vdso_once(const struct vdso_image *image, unsigned long addr);
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 5fe56f0ec9d7..6aac42902ee0 100644
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
-- 
2.39.1

