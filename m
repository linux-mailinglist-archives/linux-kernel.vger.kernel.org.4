Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C156660587
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjAFRTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbjAFRTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:19:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FEB7DE26
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 09:19:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 746A3B81E1F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 17:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4686C433D2;
        Fri,  6 Jan 2023 17:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673025540;
        bh=zsgQcMJyYEHvXA7+Hi2ymIKCkYKxtTDwcZPe25Ntk/c=;
        h=From:To:Cc:Subject:Date:From;
        b=Ym4FgWJenrYaENFFfiHkz5raOXqV2gO8l0VH6+uErul8LKptdgwrWS01elvsQgZz6
         ZYa//Gq0qzKDbfIqqShqHsOIV6Tbk3fQ1Hlw2IzEQhCVbw0nVIIB2QcmeR3oP4t7XM
         oJN/EDTLheE85xLh46IKCZHk6AM4AZcNjwE0kX7djxvYBCjJR8RgdiAaKzeosuF2W1
         etB9ZpWIIegqdrtPBiuTu6HafAu3AuKiX5kjm4Hgb7fujiNZHkV/YUvj0243vIr3e9
         HjxEv09VWY4me/+kZebQbHTOIgEx+yoEx2dN0qyyMQ7NeypDK3Nmn0mDZ+aRw7CsQ6
         w3ln33stGcPhw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH mm-unstable 1/1] include/linux/mm: declare different type of split_vma() for !CONFIG_MMU
Date:   Fri,  6 Jan 2023 17:18:57 +0000
Message-Id: <20230106171857.149918-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
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

Commit 95000286ff79 ("mm: switch vma_merge(), split_vma(), and
__split_vma to vma iterator") on mm-unstable didn't make the change to
nommu.c, but the declaration change was applied to !CONFIG_MMU, too.  It
causes below build failure.

    linux/mm/nommu.c:1347:5: error: conflicting types for 'split_vma'
     1347 | int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
          |     ^~~~~~~~~
    In file included from linux/mm/nommu.c:20:
    linux/include/linux/mm.h:2846:12: note: previous declaration of 'split_vma' was here
     2846 | extern int split_vma(struct vma_iterator *vmi, struct vm_area_struct *,
          |            ^~~~~~~~~

Fix the build failure by adding the split_vma() declaration for
!CONFIG_MMU case.

Fixes: 95000286ff79 ("mm: switch vma_merge(), split_vma(), and __split_vma to vma iterator") on mm-unstabl
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/mm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4d9148b939f8..a2bf261cdbef 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2843,8 +2843,13 @@ extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
 extern int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *,
 		       unsigned long addr, int new_below);
+#ifdef CONFIG_MMU
 extern int split_vma(struct vma_iterator *vmi, struct vm_area_struct *,
 			 unsigned long addr, int new_below);
+#else
+extern int split_vma(struct mm_struct *, struct vm_area_struct *,
+			 unsigned long addr, int new_below);
+#endif	/* CONFIG_MMU */
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
-- 
2.25.1

