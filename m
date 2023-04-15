Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4325D6E3142
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 14:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjDOMJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 08:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjDOMJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 08:09:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B837D6A72
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 05:09:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v10so4945334wmn.5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 05:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681560570; x=1684152570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3KXMf3LCMhF+M2dvABgEBrAeCcDHD/N5/gKopMor18=;
        b=HCQPeahSRNGA1+644YmdKAsb7uhy41UDRl+Ffk+UBiugmtIJ1UwebL3WK05/E5kQmt
         e0FgpQGGYiRlu/wuWS+upcjPzRo/KEPrqFXftML9a6NJw2gwQuq8ybTF4Hf1RlUxJfAY
         YCofypjnM0rrSC8pQ0qMbKc8l5i4lFRVFxiMMcvljNC5UIulGywa/jzT/TJC5O/QgIj0
         tF0Ccj8C42JwnT/REe98VBm2rcVMpSt4lEWhidXsa/PABiFwo9hrnEJbsrCxrUdRN9de
         /9JxRzc+C+mClhTZtiUC0cAxUJqF90LHfRPAET67CX47HLB+cTt7nwocKuzhaKsUsBVY
         4Rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681560570; x=1684152570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3KXMf3LCMhF+M2dvABgEBrAeCcDHD/N5/gKopMor18=;
        b=PuQRCYE7d739Tq6iAYodZzbvUogHAy75BRpE/F6OYH40ldhvrb11QFJiY25GiPfOaE
         DjJESv0Erj8J1Y21QkGK1/l6XJxlVPGkQIKqFbRZAyd7GdDaOzcj4TSsLBKCb7R4Yoqy
         WlUe2/5UBj0tpqNu2BXn5iPSZbq7AjSeoYaOGvJ3Ky4f9k5Mz2DW1Evzm70mEwMbqy6Q
         VuaJNd/gJXUsJrT8dmNE7zDK47MG+rS+foWVOvKP5fS73rxeFIIzHSUd5GNr1GqtxAbW
         BvWCgedaG9caNPT9sGraQpsCUGXIG0tBmb69r2DMNQS5EoFOiMsj7v/Wi29W79E48c93
         lltg==
X-Gm-Message-State: AAQBX9cTm9H6KV7YKuwfxUXE/hlrRG+6JkFwY0qY2I1wHypo4r4FamiP
        SRmwvBZhQ/xidIvScZ67SUxDpwLj57cMkQ==
X-Google-Smtp-Source: AKy350ZW9TkFIfQVYumPSBdggPeeuEhDPf7snltP+gAOWpvxGUiwgsz+5dP35izb+1pjtOjGL6ewjQ==
X-Received: by 2002:a05:600c:229a:b0:3f0:a098:f503 with SMTP id 26-20020a05600c229a00b003f0a098f503mr6725468wmf.14.1681560569972;
        Sat, 15 Apr 2023 05:09:29 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id n16-20020a05600c3b9000b003dd1bd0b915sm10301859wms.22.2023.04.15.05.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 05:09:29 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v3 4/7] mm/gup: introduce the FOLL_SAME_FILE GUP flag
Date:   Sat, 15 Apr 2023 13:09:27 +0100
Message-Id: <2feedd2bad6fd1ec4bc4639f9d9012c5ae2faf1f.1681558407.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681558407.git.lstoakes@gmail.com>
References: <cover.1681558407.git.lstoakes@gmail.com>
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

