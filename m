Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E796E2CD9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 01:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjDNX2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 19:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjDNX2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 19:28:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B405B93CC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 16:27:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-2f4c431f69cso68577f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 16:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681514866; x=1684106866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3KXMf3LCMhF+M2dvABgEBrAeCcDHD/N5/gKopMor18=;
        b=rA3A5jDmQUSuq498w/mMrmtN4dO3es8hQUHoowqJXmDtxEcp9n7bDFLLpduCRUkl8x
         TqOjwaAdQIfmjlEEi9FlTM9Z0lhqKtz9w7fjO//BoEs82BYK6Is80o76ACdjNB57IkYV
         X8zrkWdz5H4UMELq6qYVBk2YUTzOvS49IhM3himuygLL1kmBZi+oqfYwluBdMmbaPZN0
         OYiWM4wK0tkuxjOn7Z3BiXVSz6SuSwg+c5gVUDvm6QG58cJiMXMr+jxegxGHQfX/GJBq
         xfRs+2lywTFaKpIvqgwaVTtkYgHAd7b30FX6xbqy+CibstKe6PGASFwoYgVAq7zI2aqW
         oKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681514866; x=1684106866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3KXMf3LCMhF+M2dvABgEBrAeCcDHD/N5/gKopMor18=;
        b=UkaL0S0KT+gYyRYuMNPvToUzOviOTEEN+F21Ncz4+ONtvtk81PgRpFGj8BXdrCBefM
         IDfUCdRUr1kYz05qJuvBZ/SDGLpaDbx2ijXWoYG/xCqaBS3jDBOF+QTrlyWCcz85IDOs
         9UtY4lKmAB3GzljM2y/p7yTjW266y/Ywx2ON4wj+jD0pIJzQ1ax8/RSZe3+2AxW0LNqF
         dt/xh3KIVx/vM/LgP66t2IxpYupH9VyBnRyNodKMp2FZgRs/6VTJHUhc+BMv+oxa/t/9
         A4S1VPtRHR+NhDR8MF6SoMLO7GAfIQ2JmTDHVidy9sdrGlfowkkMiNUs72iRYBoX8v98
         vKfg==
X-Gm-Message-State: AAQBX9f21OS0O7xnZHBL18db0eMDdbRCCGqpZwoEVoEbqWl8o2TbDPWr
        76pDkXZQhBqroLwD7yG9V5M=
X-Google-Smtp-Source: AKy350a+P9S5jxCfK2lbwQc6Obvd3PgsHiVvYMRb0JbJSww10NGtsszykSGvKw9YoLx8+jm9AJTxTQ==
X-Received: by 2002:a5d:5447:0:b0:2f0:2d0a:1901 with SMTP id w7-20020a5d5447000000b002f02d0a1901mr247777wrv.45.1681514865812;
        Fri, 14 Apr 2023 16:27:45 -0700 (PDT)
Received: from lucifer.home (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.googlemail.com with ESMTPSA id u6-20020a5d6ac6000000b002f2789d1bcfsm4546827wrw.21.2023.04.14.16.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 16:27:45 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 4/7] mm/gup: introduce the FOLL_SAME_FILE GUP flag
Date:   Sat, 15 Apr 2023 00:27:40 +0100
Message-Id: <7ed66bd5243f7535030e0fa6a8a94b76dc5033f1.1681508038.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681508038.git.lstoakes@gmail.com>
References: <cover.1681508038.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

