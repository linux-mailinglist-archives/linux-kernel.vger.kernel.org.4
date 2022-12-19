Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F52651255
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiLSTAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiLSTAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:00:02 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746945F52
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:59:35 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id x2so9897867plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YXfRuD0XfIija2Fu4Zh5yh7fZwHxF8sos3x+jWEicXs=;
        b=ODbh7AHIyVlbnpVquiBqy8uEqHmm0QDGOQpUJwJz/fbNOgW3c0R/3yhPHQnjBkR/8r
         tnh0wWulPnf0Wj3awEx8ZPQPMrdKzjq7pV7sN2bCjtjdIQ/LcSbHqSmXvPDtBY+lnfir
         7uJGSab0IG9Tx8xG9I7eas8PxE+cPMOmkqpBUFsyjEFMrvfNppiutfoNT7Z/HGBY3IkU
         alKfJUqOrRLJNjr4lKh3oxDJmmEo59BuF8lOFQlnhMTfyVNZzqAoC3bNX4b+p/FrF92G
         GWZVZNyfjzrwVX1w9NsKXgGt0W/3iz6L6SvXShaG9dlAeQjPraoMq6bGI2EO7PUtLLRc
         4gDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YXfRuD0XfIija2Fu4Zh5yh7fZwHxF8sos3x+jWEicXs=;
        b=JfCe1NnS3nZWOk3LtUavjvpgQ4XJfosFIVAJjn0XMqC8pO3o+y3XlHjWLRPs4vjuun
         kEMYoVJFSQlgrFlIdQjWxJZOF9u8EKNUXJEAaK7ZzKb6D6YvEic3JCaMevZjyF6w2UhX
         XITgmcW2jbTl06aCxryjXlczu9Rd2NnVJeMho28nG5dHEOPmnVsHdpO0ScRz6kVFym+s
         qb+qU15AZkSN75eMEuIkDwFNe8mRTdCrbUPE2+b0wYh/vuRx29sLK+5WLERnEMkgy38i
         R2NvDKG9q+uTmmen9FsslgJwCVIyBlpV5lEn2FJ9fHOWSKszTb4bcnntqWhmRmDtbFHn
         tZhg==
X-Gm-Message-State: AFqh2kpozQ4soJ2EK5Xa/7pYDz80dgEldOmk35b2tPvZkMLXUxqUoBT1
        kZxgdIQoTMuUBzeX9fADNwM=
X-Google-Smtp-Source: AMrXdXulOr2VKgdwgb5ddyFY81acDgesX38ZIxXMTqNqQO11JCVLUIZ2yxFN1GN1A2WIBZRP+TzUWQ==
X-Received: by 2002:a17:903:2154:b0:189:5a49:36c3 with SMTP id s20-20020a170903215400b001895a4936c3mr9539682ple.0.1671476374965;
        Mon, 19 Dec 2022 10:59:34 -0800 (PST)
Received: from localhost.localdomain ([198.13.51.166])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902c94600b00189847cd4acsm7480790pla.237.2022.12.19.10.59.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Dec 2022 10:59:34 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 4/4] swap: avoid holding swap reference in swap_cache_get_folio
Date:   Tue, 20 Dec 2022 02:58:40 +0800
Message-Id: <20221219185840.25441-5-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20221219185840.25441-1-ryncsn@gmail.com>
References: <20221219185840.25441-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
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

From: Kairui Song <kasong@tencent.com>

All its callers either already hold a reference to, or lock the
swap device while calling this function. There is only one exception
in shmem_swapin_folio, just make this caller also hold a reference
of the swap device, so this helper can be simplified and saves
a few cycles.

This also provides finer control of error handling in shmem_swapin_folio,
on race (with swap off), it can just try again. For invalid swap entry,
it can fail with a proper error code.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/shmem.c      | 11 +++++++++++
 mm/swap_state.c |  8 ++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index c301487be5fb..5bdf7298d494 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1735,6 +1735,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct mm_struct *charge_mm = vma ? vma->vm_mm : NULL;
+	struct swap_info_struct *si;
 	struct folio *folio = NULL;
 	swp_entry_t swap;
 	int error;
@@ -1746,6 +1747,14 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	if (is_swapin_error_entry(swap))
 		return -EIO;
 
+	si = get_swap_device(swap);
+	if (!si) {
+		if (!shmem_confirm_swap(mapping, index, swap))
+			return -EEXIST;
+		else
+			return -EINVAL;
+	}
+
 	/* Look it up and read it in.. */
 	folio = swap_cache_get_folio(swap, NULL, 0);
 	if (!folio) {
@@ -1806,6 +1815,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	delete_from_swap_cache(folio);
 	folio_mark_dirty(folio);
 	swap_free(swap);
+	put_swap_device(si);
 
 	*foliop = folio;
 	return 0;
@@ -1819,6 +1829,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		folio_unlock(folio);
 		folio_put(folio);
 	}
+	put_swap_device(si);
 
 	return error;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index d8d171195a3a..cb9aaa00951d 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -321,19 +321,15 @@ static inline bool swap_use_vma_readahead(void)
  * unlocked and with its refcount incremented - we rely on the kernel
  * lock getting page table operations atomic even if we drop the folio
  * lock before returning.
+ *
+ * Caller must lock the swap device or hold a reference to keep it valid.
  */
 struct folio *swap_cache_get_folio(swp_entry_t entry,
 		struct vm_area_struct *vma, unsigned long addr)
 {
 	struct folio *folio;
-	struct swap_info_struct *si;
 
-	si = get_swap_device(entry);
-	if (!si)
-		return NULL;
 	folio = filemap_get_folio(swap_address_space(entry), swp_offset(entry));
-	put_swap_device(si);
-
 	if (folio) {
 		bool vma_ra = swap_use_vma_readahead();
 		bool readahead;
-- 
2.35.2

