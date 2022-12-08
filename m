Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE675647548
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 19:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiLHSDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 13:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiLHSDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 13:03:35 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8B1AD99D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 10:03:32 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y4so2276709plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 10:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9xhnDKrjvRgwnAVDsuEDmotQGE1PCbtaJeEpVqamujQ=;
        b=fYS6yck+ReWd2uxK6tV27Mwp2zNKPzSSjv+tEjGFN0KC2KzjO1Lrmvll2fXcklu/xD
         9vsO4te8pgwd8ikSvVhnd3cwQx6jAaJ+vsCjpJpWAcPWuMpTh4kMHQ9/dylSB1sgEc4o
         boBlj0P69dZgpYTOUuCtE/bC1caINvJKSvgBOFJhQlKFahGnFN6IKytmc7ep9fmjJmPD
         3aA6IRu+YJpaJSgbmFX3HXbLKCae+EEYKDBMiBDanJtFjy9xSdATtmt6iO7JXOaXc9+c
         EalfcbAgPYUi2n4VnkKdxQR6xvSx4sNswYuOd7MIrzR2KOOO13g8om7jQ1QjQuO11Lmi
         /Jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9xhnDKrjvRgwnAVDsuEDmotQGE1PCbtaJeEpVqamujQ=;
        b=0p5DgSfURVcPNlhHE7WBVAI9QDd2gexfawfrqC6/rM4QIcoe7iHNWUYahJ+tF8wsqP
         ZhK08EfMWQei/UelzFXalXzMfnDOXHsQn5rgcgPby3bRq9zGzoUvzJApJmjW4Mvnrhpo
         hBMaeMvDXbIIMm6SymfmPCnWVSAGL6CmIORqt5Pu4cuEY0p20/YK1qYs+lc0d4LLFF2r
         2yCaX89nKjiEVkJnv9Mar3NNkDVB9obGw5bkdQ9D3fQMh9I0ZChDR1vJVSiwrWa+m1MH
         PGIt2lxerxriMRoBBskhx7SZqSd6zy8cjo9oBTHt5lvW0uf3BCHhGf+wa9UJyOs/H0wn
         Cgbg==
X-Gm-Message-State: ANoB5pnFWgvyPhNxFpkndM9xYyQHMEibp9NoY62tQOCm2V0bYy9472mg
        Ro/r6A1LnPXOVOXddaMSjEw=
X-Google-Smtp-Source: AA0mqf40eA3n9hLVOhVvV4ReS4Fw/NzKyEAVdLHHp5a3pHjwNFExX1/Jxq1YuAjRsdgd/lCwVPtNjw==
X-Received: by 2002:a05:6a20:2d29:b0:a3:ba8a:43ea with SMTP id g41-20020a056a202d2900b000a3ba8a43eamr4354489pzl.58.1670522612163;
        Thu, 08 Dec 2022 10:03:32 -0800 (PST)
Received: from localhost.localdomain ([198.13.51.166])
        by smtp.gmail.com with ESMTPSA id x23-20020a63db57000000b004785e505bcdsm13377909pgi.51.2022.12.08.10.03.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Dec 2022 10:03:31 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Kairui Song <kasong@tencent.com>
Subject: [PATCH 4/5] swap: remove the swap lock in swap_cache_get_folio
Date:   Fri,  9 Dec 2022 02:02:08 +0800
Message-Id: <20221208180209.50845-5-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20221208180209.50845-1-ryncsn@gmail.com>
References: <20221208180209.50845-1-ryncsn@gmail.com>
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

There is only one caller not keep holding a reference or lock the
swap device while calling this function. Just move the lock out
of this function, it only used to prevent swapoff, and this helper
function is very short so there is no performance regression
issue. Help saves a few cycles.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/shmem.c      | 8 +++++++-
 mm/swap_state.c | 8 ++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index c1d8b8a1aa3b..0183b6678270 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1725,6 +1725,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct mm_struct *charge_mm = vma ? vma->vm_mm : NULL;
+	struct swap_info_struct *si;
 	struct folio *folio = NULL;
 	swp_entry_t swap;
 	int error;
@@ -1737,7 +1738,12 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		return -EIO;
 
 	/* Look it up and read it in.. */
-	folio = swap_cache_get_folio(swap, NULL, 0);
+	si = get_swap_device(swap);
+	if (si) {
+		folio = swap_cache_get_folio(swap, NULL, 0);
+		put_swap_device(si);
+	}
+
 	if (!folio) {
 		/* Or update major stats only when swapin succeeds?? */
 		if (fault_type) {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 19089417abd1..eba388f67741 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -324,19 +324,15 @@ static inline bool swap_use_vma_readahead(void)
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

