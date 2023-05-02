Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5846F4DED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 01:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjEBX4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 19:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjEBX4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 19:56:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC2A40C6
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 16:56:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a7df507c5so8813882276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 16:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683071792; x=1685663792;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VTfG7F65o0oFg67+X6WxPMuxEdDT/M2lH43dZvx+e04=;
        b=c02k0bI/rvnso3tOW89PkXkbHVcOqnqtz/00RV+zglFTuL3AV5vA/JoKSNHXrhMxG9
         +LZbpUPZXFVoVQSziSRHpEdmft/gnRjoj88wWvi7L3QqqtQLPo/bTT9KlqUe7FEZrkmT
         kGRk8qzYo+aZdpDYL+VamZFw9iAGIVJRiPI6zv15Q2xrkqDjBi8jP9NS7Dbu8bdZK2F7
         KEJ2wKk3UtPulyyjlsZpP3fIL2NFuQldZ2lmIa+b3C2DxvEaMQUrhg17UOZSdvvjzx+B
         ZPjjwHFYiiaZmKrHPUjRp9V+c1NbfhSytafwBjb3vd+XSDdVfZYD8U0Yn4pTZyIRQ4R/
         2xUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683071792; x=1685663792;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VTfG7F65o0oFg67+X6WxPMuxEdDT/M2lH43dZvx+e04=;
        b=iEwrHsg3kJJxkDxDz9511T8le5RzqgGbDt0Bd8lboR5pUoBjuaRchYhUGuZkzPliY7
         Qwm11vJnorRMtWIAl0Y1geJbTLmjSsIfE9A1Gmuz5QwXnF0r5/HnJ81/YbM9KeCBQXYA
         +AbW05c7Gmv/8Vr7WIMp5Q8Psryx3IlVW0S1dCrQhckQo9/81671I8mrRmZ8cY0/cFEt
         6Ojd+th1uJqI/VbEjly7HTOTgrY625eHiCi/EeF4dAQBfADcdO4tmQsCJfSxJl5ZB3Rk
         igKFZ2rI4ucG73e55rFMsQ5vbKrpMWctu4xRP86pPFma2qYW9MEg6++mIbOlkVcXhxvm
         OD3w==
X-Gm-Message-State: AC+VfDwpPicUVzddRgdhFQ9URZ3nKWv4W2ZJrMvdd2mJvc8AZumFYwqn
        vh3Gd7NE78Wk8zV8UC1GvGKZWkPC5E/TvrdS8g==
X-Google-Smtp-Source: ACHHUZ48PCyKBqXvRaNrp+9TLDB21cvKYwuAMRuGxA5xQuupd0isU49vzdMgfnH965aUyYs8rAuSZBdYGckJj4CLgw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:50c1:0:b0:b9d:94eb:fa4c with SMTP
 id e184-20020a2550c1000000b00b9d94ebfa4cmr7441408ybb.6.1683071792300; Tue, 02
 May 2023 16:56:32 -0700 (PDT)
Date:   Tue,  2 May 2023 23:56:22 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502235622.3652586-1-ackerleytng@google.com>
Subject: [PATCH] fs: hugetlbfs: Set vma policy only when needed for allocating folio
From:   Ackerley Tng <ackerleytng@google.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev,
        willy@infradead.org, sidhartha.kumar@oracle.com,
        jhubbard@nvidia.com
Cc:     vannapurve@google.com, erdemaktas@google.com,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling hugetlb_set_vma_policy() later avoids setting the vma policy
and then dropping it on a page cache hit.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 fs/hugetlbfs/inode.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index f640cff1bbce..380b1cd6c93f 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -833,9 +833,6 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 			break;
 		}
 
-		/* Set numa allocation policy based on index */
-		hugetlb_set_vma_policy(&pseudo_vma, inode, index);
-
 		/* addr is the offset within the file (zero based) */
 		addr = index * hpage_size;
 
@@ -846,7 +843,6 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		/* See if already present in mapping to avoid alloc/free */
 		if (filemap_has_folio(mapping, index)) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			hugetlb_drop_vma_policy(&pseudo_vma);
 			continue;
 		}
 
@@ -858,6 +854,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		 * folios in these areas, we need to consume the reserves
 		 * to keep reservation accounting consistent.
 		 */
+		hugetlb_set_vma_policy(&pseudo_vma, inode, index);
 		folio = alloc_hugetlb_folio(&pseudo_vma, addr, 0);
 		hugetlb_drop_vma_policy(&pseudo_vma);
 		if (IS_ERR(folio)) {
-- 
2.40.1.495.gc816e09b53d-goog

