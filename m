Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26862680E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbjA3NHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjA3NHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:07:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441F72ED43
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:07:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D97B60FC9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB31C433EF;
        Mon, 30 Jan 2023 13:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675084065;
        bh=82pzv7nUQ7xEKOT9LUE7jHsMtpD/ZVzFzf10YTQKDDM=;
        h=From:To:Cc:Subject:Date:From;
        b=MeM4klGK6M3/EzB+GGzqaj/trET6jVqY4qqcULNKq3uaclfWxZWK6C15RoifjV4kR
         9t7hqvmSE296+5YIb/xkXzrljjFiwjS78ZFpBRsHruwS6WwU6lBt4t1Fed+Twq0XjB
         LSvAcWmYqL72kM+EibA2sgVUB8Au6Q2jlp07F+DN0a8Xlpmq315CXuGdkk0CbC36fp
         NYNVv7Cdu5J1FVHJC1E2nHrz5+BNp1f/QrqVVtqOmw9HHEykLtrr4HLeQn3DiUrL+X
         He7mo9886bCxvdCsLgb5D7ehlT1pM/obD/rRLVfkptqEKlLiHDsRnQOdj7FeVMDjUo
         psjK/JhIS7NzQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: extend max struct page size for kmsan
Date:   Mon, 30 Jan 2023 14:07:26 +0100
Message-Id: <20230130130739.563628-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

After x86 has enabled support for KMSAN, it has become possible
to have larger 'struct page' than was expected when commit
5470dea49f53 ("mm: use mm_zero_struct_page from SPARC on all 64b
architectures") was merged:

include/linux/mm.h:156:10: warning: no case matching constant switch condition '96'
        switch (sizeof(struct page)) {

Extend the maximum accordingly.

Fixes: 5470dea49f53 ("mm: use mm_zero_struct_page from SPARC on all 64b architectures")
Fixes: 4ca8cc8d1bbe ("x86: kmsan: enable KMSAN builds for x86")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This seems to show up extremely rarely in randconfig builds, but
enough to trigger my build machine.

I saw a related discussion at [1] about raising MAX_STRUCT_PAGE_SIZE,
but as I understand it, that needs to be addressed separately.

[1] https://lore.kernel.org/lkml/20220701142310.2188015-11-glider@google.com/
---
 include/linux/mm.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b73ba2e5cfd2..aa39d5ddace1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -137,7 +137,7 @@ extern int mmap_rnd_compat_bits __read_mostly;
  * define their own version of this macro in <asm/pgtable.h>
  */
 #if BITS_PER_LONG == 64
-/* This function must be updated when the size of struct page grows above 80
+/* This function must be updated when the size of struct page grows above 96
  * or reduces below 56. The idea that compiler optimizes out switch()
  * statement, and only leaves move/store instructions. Also the compiler can
  * combine write statements if they are both assignments and can be reordered,
@@ -148,12 +148,18 @@ static inline void __mm_zero_struct_page(struct page *page)
 {
 	unsigned long *_pp = (void *)page;
 
-	 /* Check that struct page is either 56, 64, 72, or 80 bytes */
+	 /* Check that struct page is either 56, 64, 72, 80, 88 or 96 bytes */
 	BUILD_BUG_ON(sizeof(struct page) & 7);
 	BUILD_BUG_ON(sizeof(struct page) < 56);
-	BUILD_BUG_ON(sizeof(struct page) > 80);
+	BUILD_BUG_ON(sizeof(struct page) > 96);
 
 	switch (sizeof(struct page)) {
+	case 96:
+		_pp[11] = 0;
+		fallthrough;
+	case 88:
+		_pp[10] = 0;
+		fallthrough;
 	case 80:
 		_pp[9] = 0;
 		fallthrough;
-- 
2.39.0

