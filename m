Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF7964E0A1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiLOSX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLOSXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:23:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB5046675
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:23:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE20BB81C37
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 18:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AA7C433D2;
        Thu, 15 Dec 2022 18:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671128626;
        bh=b2movO2QDbJENwvsGD8QiYwsUZPp0zsJc8kXD8M/tfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hpSboetvljJzT63/IrlGiNOoqueazi0K6h+vUaIhfAanjtpjBAkBTKVgJJG/2RWQc
         hiLxABCFF8bWCWPfpJPqwLg7hb258NlP2t951bgnQWjs5C5EtyGqiIoJKdq6glnQjO
         aoyTTVFxNQdiMpaXRYuoMGBlBxcDDoKsqxmKXrWrPRnXy7PCGYffORUVHfCo/GrueN
         5yDYYcD1RPbhUTVekdJBe/9+c4aCtRDItoFN8EjGv/xz8kt9V61Tsqy38PVNfj4JXk
         l7xuVmhzhHHkm86E8wFqTwgZSMt4n9paAa/oivBrIw/6P6MKOj9IxhYINqy9n/KysN
         P87CCcvHMoE8A==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] x86/kexec: Remove unnecessary arch_kexec_kernel_image_load()
Date:   Thu, 15 Dec 2022 12:23:38 -0600
Message-Id: <20221215182339.129803-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221215182339.129803-1-helgaas@kernel.org>
References: <20221215182339.129803-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The x86 implementation of arch_kexec_kernel_image_load() is functionally
identical to the generic arch_kexec_kernel_image_load().

Remove it and use the generic arch_kexec_kernel_image_load().  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/include/asm/kexec.h       |  3 ---
 arch/x86/kernel/machine_kexec_64.c | 11 -----------
 include/linux/kexec.h              |  2 --
 3 files changed, 16 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index a3760ca796aa..5b77bbc28f96 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -200,9 +200,6 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 				     const Elf_Shdr *symtab);
 #define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
 
-void *arch_kexec_kernel_image_load(struct kimage *image);
-#define arch_kexec_kernel_image_load arch_kexec_kernel_image_load
-
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
 #endif
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 0611fd83858e..1a3e2c05a8a5 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -374,17 +374,6 @@ void machine_kexec(struct kimage *image)
 /* arch-dependent functionality related to kexec file-based syscall */
 
 #ifdef CONFIG_KEXEC_FILE
-void *arch_kexec_kernel_image_load(struct kimage *image)
-{
-	if (!image->fops || !image->fops->load)
-		return ERR_PTR(-ENOEXEC);
-
-	return image->fops->load(image, image->kernel_buf,
-				 image->kernel_buf_len, image->initrd_buf,
-				 image->initrd_buf_len, image->cmdline_buf,
-				 image->cmdline_buf_len);
-}
-
 /*
  * Apply purgatory relocations.
  *
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 5dd4343c1bbe..c08d5d52223a 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -207,12 +207,10 @@ static inline int arch_kimage_file_post_load_cleanup(struct kimage *image)
 }
 #endif
 
-#ifndef arch_kexec_kernel_image_load
 static inline void *arch_kexec_kernel_image_load(struct kimage *image)
 {
 	return kexec_image_load_default(image);
 }
-#endif
 
 #ifdef CONFIG_KEXEC_SIG
 #ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
-- 
2.25.1

