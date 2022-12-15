Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3B864E0A2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiLOSX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLOSXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:23:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546B94731C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:23:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3F0461EA7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 18:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0C2C433EF;
        Thu, 15 Dec 2022 18:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671128628;
        bh=EzpeGu7n5zTSaE1MJ3GyQVMhUoUmeNkelZBjZU+Lqgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4jObftwCzhu9BbVq2qRzfBiVdRpA1YZBwORx0UiCJXPN4LlDTw3G3ccC6W8rrSpx
         N//3en4df78W/YWsp/VLnlfLBn4VdD3V9IEdxM/C0myOxIYlQ0c0bkSYXrerfwq19z
         tiyAKB4Hs7zgfe2Tw5nrGWrkVpYSqFkYlziL9SHoWVXJMq1rPwjnJeV8wfXPFMAKn0
         mNoK4WfcHKWoFPG03j5SjAxu3s6q8KO/c6qgdQgWAWxDRLkWUpRu+ZQ/isN949U7gO
         FY2x1wxoZEiUlx5ygL5wQxnoLf4+IYH7cvOaMPDZj7qaRVFtj39Fet5BFhRCefAAdo
         Hz+niQwNZaDkA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] kexec: Remove unnecessary arch_kexec_kernel_image_load()
Date:   Thu, 15 Dec 2022 12:23:39 -0600
Message-Id: <20221215182339.129803-3-helgaas@kernel.org>
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

arch_kexec_kernel_image_load() only calls kexec_image_load_default(), and
there are no arch-specific implementations.

Remove the unnecessary arch_kexec_kernel_image_load() and make
kexec_image_load_default() static .

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

kexec: make static

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/kexec.h | 6 ------
 kernel/kexec_file.c   | 6 +++---
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index c08d5d52223a..8844e7debfa4 100644
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
index dd5983010b7b..39ddf09ab573 100644
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

