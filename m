Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924ED668995
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 03:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjAMCa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 21:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjAMCaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 21:30:25 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CFE5792D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 18:30:24 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id p24so22054596plw.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 18:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QQfFNObX23nRFgvMolgS2BLErvEkHc3/pg8u1wb3WfA=;
        b=BAJ1luVg89O7aQsrrfyrax3G1mJpE7vfoxwJhRKFblxcsG0wjjfmfYUop26Yz6jVAZ
         AOHm2vRIrqkYh4PVuaRhUMPDEXHJ1p+EkUfcjVOZ7j/FCG3w+x6uKN5Amc9nOyMdCDId
         Y7/H0nxdJeaM4vn9UnWo3LNO9/nG8tP+nz/cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQfFNObX23nRFgvMolgS2BLErvEkHc3/pg8u1wb3WfA=;
        b=v7X8fhYGrY0lZObOuOgbkcSH/khsO/glUcCOXKI+e1MfFeNziIsqipLOExQBuBnCeu
         raE0/kvkQ1T7zrEbwnh7q8r7ln5ECJ8NmmLoV8UPIX/ucE0NRrS5Is6r6JDOTUUGsWny
         solCt4FSFSX83DJQtnshGZroh1+gxGPCrvFkUx9YQXihehsfCREqRpN3+9KoZcMk4lzD
         TPu1pARXgQaMcSSgYjX21BjIGXp6hU3519xCXswCgojz0fFARW9rHbHVdZ3p77lY0TY/
         dA+GpyQ5MwdWQPRd/VVjDXcBqHa+qvB25urIp7XeQzO/ZMvl4Wnispcj68LGqteVkZz2
         huLg==
X-Gm-Message-State: AFqh2kqPANY0fHeEGUG7KS6Wx64u35iWM0aUujtU4V1icj34sx2Trz1Q
        9WeLw85ph9AJA7kb0/xI6XXn8w==
X-Google-Smtp-Source: AMrXdXvipi4l4shvABg1HT3wr+bB85ljuZPI0YibuNZhd5rMpcphNImIBpPGFeLQB0CC73FoNj6PWA==
X-Received: by 2002:a17:902:c50e:b0:194:586a:77ba with SMTP id o14-20020a170902c50e00b00194586a77bamr6311342plx.52.1673577024325;
        Thu, 12 Jan 2023 18:30:24 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:3a37:fd1a:48c:42e5])
        by smtp.gmail.com with UTF8SMTPSA id q1-20020a170902dac100b00185402cfedesm12854409plx.246.2023.01.12.18.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 18:30:23 -0800 (PST)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     linux-mm@kvack.org
Cc:     Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH] mm: fix khugepaged with shmem_enabled=advise
Date:   Fri, 13 Jan 2023 11:30:11 +0900
Message-Id: <20230113023011.1784015-1-stevensd@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Pass vm_flags as a parameter to shmem_is_huge, rather than reading the
flags from the vm_area_struct in question. This allows the updated flags
from hugepage_madvise to be passed to the check, which is necessary
because madvise does not update the vm_area_struct's flags until after
hugepage_madvise returns.

This fixes in issue when shmem_enabled=madvise, where MADV_HUGEPAGE on
shmem was not able to register the mm_struct with khugepaged. Prior to
cd89fb065099, the mm_struct was registered by MADV_HUGEPAGE regardless
of the value of shmem_enabled (which was only checked when scanning
vmas).

Fixes: cd89fb065099 ("mm,thp,shmem: make khugepaged obey tmpfs mount flags")
Signed-off-by: David Stevens <stevensd@chromium.org>
---
 include/linux/shmem_fs.h | 10 ++--------
 mm/huge_memory.c         |  3 ++-
 mm/shmem.c               | 18 +++++++++---------
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index d500ea967dc7..d09d54be4ffd 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -92,14 +92,8 @@ extern struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 extern void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
 int shmem_unuse(unsigned int type);
 
-extern bool shmem_is_huge(struct vm_area_struct *vma, struct inode *inode,
-			  pgoff_t index, bool shmem_huge_force);
-static inline bool shmem_huge_enabled(struct vm_area_struct *vma,
-				      bool shmem_huge_force)
-{
-	return shmem_is_huge(vma, file_inode(vma->vm_file), vma->vm_pgoff,
-			     shmem_huge_force);
-}
+extern bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
+			  struct mm_struct *mm, unsigned long vm_flags);
 extern unsigned long shmem_swap_usage(struct vm_area_struct *vma);
 extern unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 						pgoff_t start, pgoff_t end);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index abe6cfd92ffa..56bbaa931f97 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -119,7 +119,8 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
 	 * own flags.
 	 */
 	if (!in_pf && shmem_file(vma->vm_file))
-		return shmem_huge_enabled(vma, !enforce_sysfs);
+		return shmem_is_huge(file_inode(vma->vm_file), vma->vm_pgoff,
+				     !enforce_sysfs, vma->vm_mm, vm_flags);
 
 	/* Enforce sysfs THP requirements as necessary */
 	if (enforce_sysfs &&
diff --git a/mm/shmem.c b/mm/shmem.c
index c301487be5fb..1e515390b831 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -468,15 +468,14 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 
 static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
 
-bool shmem_is_huge(struct vm_area_struct *vma, struct inode *inode,
-		   pgoff_t index, bool shmem_huge_force)
+bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
+		   struct mm_struct *mm, unsigned long vm_flags)
 {
 	loff_t i_size;
 
 	if (!S_ISREG(inode->i_mode))
 		return false;
-	if (vma && ((vma->vm_flags & VM_NOHUGEPAGE) ||
-	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags)))
+	if (mm && ((vm_flags & VM_NOHUGEPAGE) || test_bit(MMF_DISABLE_THP, &mm->flags)))
 		return false;
 	if (shmem_huge_force)
 		return true;
@@ -495,7 +494,7 @@ bool shmem_is_huge(struct vm_area_struct *vma, struct inode *inode,
 			return true;
 		fallthrough;
 	case SHMEM_HUGE_ADVISE:
-		if (vma && (vma->vm_flags & VM_HUGEPAGE))
+		if (mm && (vm_flags & VM_HUGEPAGE))
 			return true;
 		fallthrough;
 	default:
@@ -678,8 +677,8 @@ static long shmem_unused_huge_count(struct super_block *sb,
 
 #define shmem_huge SHMEM_HUGE_DENY
 
-bool shmem_is_huge(struct vm_area_struct *vma, struct inode *inode,
-		   pgoff_t index, bool shmem_huge_force)
+bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
+		   struct mm_struct *mm, unsigned long vm_flags)
 {
 	return false;
 }
@@ -1070,7 +1069,7 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
 			STATX_ATTR_NODUMP);
 	generic_fillattr(&init_user_ns, inode, stat);
 
-	if (shmem_is_huge(NULL, inode, 0, false))
+	if (shmem_is_huge(inode, 0, false, NULL, 0))
 		stat->blksize = HPAGE_PMD_SIZE;
 
 	if (request_mask & STATX_BTIME) {
@@ -1911,7 +1910,8 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		return 0;
 	}
 
-	if (!shmem_is_huge(vma, inode, index, false))
+	if (!shmem_is_huge(inode, index, false,
+			   vma ? vma->vm_mm : NULL, vma ? vma->vm_flags : 0))
 		goto alloc_nohuge;
 
 	huge_gfp = vma_thp_gfp_mask(vma);
-- 
2.39.0.314.g84b9a713c41-goog

