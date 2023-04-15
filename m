Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC126E2FE7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 11:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDOJIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 05:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjDOJIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 05:08:45 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4545B8F
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 02:08:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f09df54430so1972465e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 02:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681549722; x=1684141722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3KXMf3LCMhF+M2dvABgEBrAeCcDHD/N5/gKopMor18=;
        b=SYa2oo+tbd38XlYtz/d6/e4pzQ6P9G6OsJ4dhx3B8+SYR/d9O8tSkD2RPu9kJexrpZ
         i26FJrReB1ZKb/fpTLOOe4FKafPWtUANQys34PP6Hnve60y2Edj85EK6A8FT939vLW7t
         o6ImUDfeJQnyy7P8bgYoVtDkMFNfwWzWzKnP/Wz49VshkCfOapwdRglzz4DIe/Plmpod
         LFm6mrdZ0ZmnCmhhSbSkELW3VN2PopBHBPlJyrHZEdjrruFmqrfV9Kpe6V2rBm5oVmdm
         St4ps/8jKsHniSU28kM6ig2cNONUd5+UmdF5K+kJ4vQvz5Am44dTz2FexI5QiejlF0Tb
         tCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681549722; x=1684141722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3KXMf3LCMhF+M2dvABgEBrAeCcDHD/N5/gKopMor18=;
        b=Z5D/iM8s/YGmVCJVKScKMNuhTKWumH9aTllqbZc6DJz99DalMtsBSQvR2+vQxWlTyy
         OWDQGcbpTgYDO9et1SLMDirZMhSX+hNl5qitmqyLghEiovF4W48rg4OSfyY66I8O139y
         iDFO1hoiX0dZetl0u5Esho6i7eKlcI8BQli7ixP4zDbHMgD0ZeirnTGdm49CELlZrdSq
         NAesyBGVuBQkNZoGrlliqqO7m2TBtUl0DtxC5AXJl84s8/UVevEKmhn7ipqgXL69vgyz
         d7fXVmEIAEh+Xfhr+AY260cAPCM1Fvh7vMUcntsjXRAzEjYOzDKZwjNlEIMdz/gHiuu0
         O3/g==
X-Gm-Message-State: AAQBX9dDUud4fQ/rlKsU/jivohga7I0+qrOHsOGGJFrehwdS6TgbZ+xk
        T/wcBkdyzGo57TR4Vdq9j6E=
X-Google-Smtp-Source: AKy350YaMFKbNrifL4gowACdl7mWvuAicO7Q3u/ayqigKnCZIONTCLQFkFKBA27JxTqB3gMFabKuyA==
X-Received: by 2002:a5d:4c4d:0:b0:2cf:e67c:8245 with SMTP id n13-20020a5d4c4d000000b002cfe67c8245mr1122023wrt.44.1681549722284;
        Sat, 15 Apr 2023 02:08:42 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id r16-20020a056000015000b002f21a96c161sm5364756wrx.70.2023.04.15.02.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 02:08:41 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 4/7] mm/gup: introduce the FOLL_SAME_FILE GUP flag
Date:   Sat, 15 Apr 2023 10:08:39 +0100
Message-Id: <45702c7b87c8487455783b482b67dfcf2d24e6a9.1681547405.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681547405.git.lstoakes@gmail.com>
References: <cover.1681547405.git.lstoakes@gmail.com>
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

This flag causes GUP to assert that all VMAs within the input range possess
the same vma->vm_file. If not, the operation fails.

This is part of a patch series which eliminates the vmas parameter from the
GUP API, implementing the one remaining assertion within the entire kernel
that requires access to the VMAs associated with a GUP range.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/mm_types.h |  2 ++
 mm/gup.c                 | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3fc9e680f174..84d1aec9dbab 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1185,6 +1185,8 @@ enum {
 	FOLL_PCI_P2PDMA = 1 << 10,
 	/* allow interrupts from generic signals */
 	FOLL_INTERRUPTIBLE = 1 << 11,
+	/* assert that the range spans VMAs with the same vma->vm_file */
+	FOLL_SAME_FILE = 1 << 12,
 
 	/* See also internal only FOLL flags in mm/internal.h */
 };
diff --git a/mm/gup.c b/mm/gup.c
index 9440aa54c741..3954ce499a4a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -959,7 +959,8 @@ static int faultin_page(struct vm_area_struct *vma,
 	return 0;
 }
 
-static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
+static int check_vma_flags(struct vm_area_struct *vma, struct file *file,
+			   unsigned long gup_flags)
 {
 	vm_flags_t vm_flags = vma->vm_flags;
 	int write = (gup_flags & FOLL_WRITE);
@@ -968,7 +969,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 	if (vm_flags & (VM_IO | VM_PFNMAP))
 		return -EFAULT;
 
-	if (gup_flags & FOLL_ANON && !vma_is_anonymous(vma))
+	if ((gup_flags & FOLL_ANON) && !vma_is_anonymous(vma))
 		return -EFAULT;
 
 	if ((gup_flags & FOLL_LONGTERM) && vma_is_fsdax(vma))
@@ -977,6 +978,9 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 	if (vma_is_secretmem(vma))
 		return -EFAULT;
 
+	if ((gup_flags & FOLL_SAME_FILE) && vma->vm_file != file)
+		return -EFAULT;
+
 	if (write) {
 		if (!(vm_flags & VM_WRITE)) {
 			if (!(gup_flags & FOLL_FORCE))
@@ -1081,6 +1085,7 @@ static long __get_user_pages(struct mm_struct *mm,
 	long ret = 0, i = 0;
 	struct vm_area_struct *vma = NULL;
 	struct follow_page_context ctx = { NULL };
+	struct file *file = NULL;
 
 	if (!nr_pages)
 		return 0;
@@ -1111,10 +1116,13 @@ static long __get_user_pages(struct mm_struct *mm,
 				ret = -EFAULT;
 				goto out;
 			}
-			ret = check_vma_flags(vma, gup_flags);
+			ret = check_vma_flags(vma, i == 0 ? vma->vm_file : file,
+					      gup_flags);
 			if (ret)
 				goto out;
 
+			file = vma->vm_file;
+
 			if (is_vm_hugetlb_page(vma)) {
 				i = follow_hugetlb_page(mm, vma, pages, vmas,
 						&start, &nr_pages, i,
@@ -1595,7 +1603,7 @@ long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
 	 * We want to report -EINVAL instead of -EFAULT for any permission
 	 * problems or incompatible mappings.
 	 */
-	if (check_vma_flags(vma, gup_flags))
+	if (check_vma_flags(vma, vma->vm_file, gup_flags))
 		return -EINVAL;
 
 	ret = __get_user_pages(mm, start, nr_pages, gup_flags,
-- 
2.40.0

