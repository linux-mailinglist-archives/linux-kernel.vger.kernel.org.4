Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DD86EC815
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjDXIsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjDXIsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:48:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003EF131;
        Mon, 24 Apr 2023 01:47:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 894071FD7D;
        Mon, 24 Apr 2023 08:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682326073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Ms5T3XZYu1VTvsowncWRC+NA0acUncB1fOJ3TJZ4Grs=;
        b=0SZ3+YX8QlYHS0KNQPHDeKSfu8S6mCc0r66paFPRDggLXgUsYdSUxuokv3EW+pXh1I9mRz
        yjcEy9AxTKcImaxu3BFClOXJbKjOnHoGjhqe0OnkFNhPWt/H7ubdutz2ikRrfwHNDTAzGZ
        Z9NEW1IjVo9lk+JWGC0DybCNUVis1SU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682326073;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Ms5T3XZYu1VTvsowncWRC+NA0acUncB1fOJ3TJZ4Grs=;
        b=pOQ5+SklUdE0ENCPlrMvulDfFnW2H8CmSyb3dKLdJdxZ1MAOdJ5y/xL+BZnTeVXaCWcx+D
        rVReR/NhZosJS7Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A7C213780;
        Mon, 24 Apr 2023 08:47:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RahFDTlCRmRDcwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 24 Apr 2023 08:47:53 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        deller@gmx.de, arnd@arndb.de, daniel.vetter@ffwll.ch,
        javierm@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] arch/x86: Include <asm/fb.h> in fbdev source file
Date:   Mon, 24 Apr 2023 10:47:51 +0200
Message-Id: <20230424084751.14641-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the implementation of fb_pgprotect() to fbdev.c and include
<asm/fb.h>. Fixes the following warning:

  ../arch/x86/video/fbdev.c:14:5: warning: no previous prototype for 'fb_is_primary_device' [-Wmissing-prototypes]
     14 | int fb_is_primary_device(struct fb_info *info)
        |     ^~~~~~~~~~~~~~~~~~~~

Just including <asm/fb.h> results in a number of built-in errors
about undefined function. Moving fb_pgprotect() to the source file
avoids the required include statements in the header. The function
is only called occasionally from fb_mmap(), so having it as static
inline had no benefit.

While at it, fix the codying style in fbdev.c.

Link: https://elixir.bootlin.com/linux/v6.3-rc7/source/drivers/video/fbdev/core/fbmem.c#L1404
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/x86/include/asm/fb.h | 14 ++------------
 arch/x86/video/fbdev.c    | 17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/fb.h b/arch/x86/include/asm/fb.h
index a3fb801f12f1..23873da8fb77 100644
--- a/arch/x86/include/asm/fb.h
+++ b/arch/x86/include/asm/fb.h
@@ -2,21 +2,11 @@
 #ifndef _ASM_X86_FB_H
 #define _ASM_X86_FB_H
 
-#include <asm/page.h>
-
 struct fb_info;
 struct file;
+struct vm_area_struct;
 
-static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
-				unsigned long off)
-{
-	unsigned long prot;
-
-	prot = pgprot_val(vma->vm_page_prot) & ~_PAGE_CACHE_MASK;
-	if (boot_cpu_data.x86 > 3)
-		pgprot_val(vma->vm_page_prot) =
-			prot | cachemode2protval(_PAGE_CACHE_MODE_UC_MINUS);
-}
+void fb_pgprotect(struct file *file, struct vm_area_struct *vma, unsigned long off);
 #define fb_pgprotect fb_pgprotect
 
 int fb_is_primary_device(struct fb_info *info);
diff --git a/arch/x86/video/fbdev.c b/arch/x86/video/fbdev.c
index 5ec4eafbb981..57ee3c158f97 100644
--- a/arch/x86/video/fbdev.c
+++ b/arch/x86/video/fbdev.c
@@ -6,11 +6,25 @@
  * for more details.
  *
  */
+
+#include <asm/fb.h>
+
 #include <linux/fb.h>
-#include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <linux/vgaarb.h>
 
+void fb_pgprotect(struct file *file, struct vm_area_struct *vma, unsigned long off)
+{
+	unsigned long prot;
+
+	prot = pgprot_val(vma->vm_page_prot) & ~_PAGE_CACHE_MASK;
+	if (boot_cpu_data.x86 > 3)
+		pgprot_val(vma->vm_page_prot) =
+			prot | cachemode2protval(_PAGE_CACHE_MODE_UC_MINUS);
+}
+EXPORT_SYMBOL(fb_pgprotect);
+
 int fb_is_primary_device(struct fb_info *info)
 {
 	struct device *device = info->device;
@@ -26,4 +40,5 @@ int fb_is_primary_device(struct fb_info *info)
 	return 0;
 }
 EXPORT_SYMBOL(fb_is_primary_device);
+
 MODULE_LICENSE("GPL");

base-commit: d2639bb054c42db5ff15c56902d1113303f5b655
prerequisite-patch-id: 0aa359f6144c4015c140c8a6750be19099c676fb
prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
prerequisite-patch-id: cbc453ee02fae02af22fbfdce56ab732c7a88c36
-- 
2.40.0

