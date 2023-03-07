Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D653C6AF926
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjCGWpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjCGWpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:45:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A08136DA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:44:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3E6EB81AB2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 22:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A71CC433D2;
        Tue,  7 Mar 2023 22:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678229085;
        bh=HcbEYAk5/hvYxwMQ1XV4yIwIyUKWjpgb4DPd91dMy6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jsoHgkhIk35zpsQCjEMr3lWiaWSGqUQPSughiqH4A1oDxHRLHX6b/eue0ppdvRdLE
         8h/FNndbDlr48QOyHaeBgGtwHBCoHGbGhxyPMfCpISNlJhUKiMvp5JHZTIB9vcO+H3
         BjdinWjuHagF8Jhf8vGKEolrJuLm45jWf1H/ApZXFRd6MjRCKkzOWollyWRNB91d0s
         R9HtgqT5QZE68tbl/OT7Cl5dcGPVTj2rAKOh7xoF+JrJybpqU7S3d4aWToD4ff7OLz
         YmIiI2eLb/mx6LmD3n8NgxuSdrjn8cQrbOxr6KucT/QomSDWARcsxNU1/raNbdZSFj
         bR94GM5IVdbcA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Eric Biederman <ebiederm@xmission.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        x86@kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 2/2] kexec: Remove unnecessary arch_kexec_kernel_image_load()
Date:   Tue,  7 Mar 2023 16:44:16 -0600
Message-Id: <20230307224416.907040-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307224416.907040-1-helgaas@kernel.org>
References: <20230307224416.907040-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

arch_kexec_kernel_image_load() only calls kexec_image_load_default(), and
there are no arch-specific implementations.

Remove the unnecessary arch_kexec_kernel_image_load() and make
kexec_image_load_default() static.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/kexec.h | 6 ------
 kernel/kexec_file.c   | 6 +++---
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 4746bc9d39c9..22b5cd24f581 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -190,7 +190,6 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 				   void *buf, unsigned int size,
 				   bool get_value);
 void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
-void *kexec_image_load_default(struct kimage *image);
 
 #ifndef arch_kexec_kernel_image_probe
 static inline int
@@ -207,11 +206,6 @@ static inline int arch_kimage_file_post_load_cleanup(struct kimage *image)
 }
 #endif
 
-static inline void *arch_kexec_kernel_image_load(struct kimage *image)
-{
-	return kexec_image_load_default(image);
-}
-
 #ifdef CONFIG_KEXEC_SIG
 #ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
 int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f1a0e4e3fb5c..f989f5f1933b 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -65,7 +65,7 @@ int kexec_image_probe_default(struct kimage *image, void *buf,
 	return ret;
 }
 
-void *kexec_image_load_default(struct kimage *image)
+static void *kexec_image_load_default(struct kimage *image)
 {
 	if (!image->fops || !image->fops->load)
 		return ERR_PTR(-ENOEXEC);
@@ -249,8 +249,8 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	/* IMA needs to pass the measurement list to the next kernel. */
 	ima_add_kexec_buffer(image);
 
-	/* Call arch image load handlers */
-	ldata = arch_kexec_kernel_image_load(image);
+	/* Call image load handler */
+	ldata = kexec_image_load_default(image);
 
 	if (IS_ERR(ldata)) {
 		ret = PTR_ERR(ldata);
-- 
2.25.1

