Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2EF6C37D1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjCURI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjCURIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:08:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E846053716;
        Tue, 21 Mar 2023 10:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29775B818FC;
        Tue, 21 Mar 2023 17:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A63C4339B;
        Tue, 21 Mar 2023 17:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679418379;
        bh=KhfLtALYKzODXFE/bKaEWmdPAncGVA8ZXqw3mr1syxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iP13+nPFKWexWO3d0/NXkearn4Tj8eWKPbGRJCvBjOENCtyJZblBuGz9AdeeUfjdA
         EMjeaK/CSluxUo7Ua2KaaJmij2/OzMp5dxXpPxj04YzyIGphxVJMKhOF4bXMSL94nz
         ol5MOh1u+X7joFijl49MvNJQdym1l9XEL8k6DV2Hki6DyjSX4rtuMvSy1ILwGRIi44
         XrAoxjg2ZccTAZ8/36v34co5C40IvtmtGUbbKNLnmjVEj9VBI5qp0vymUpsAr05iX4
         k26ZQ8N0iCz8C/Gsjz8cV7FjFtufjJ/T1bSEgNV3NbZ/t6IPG5KpyVbUKrbwbSXAmj
         579oV8zZkoCuw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Doug Berger <opendmb@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 13/14] mm: move vmalloc_init() declaration to mm/internal.h
Date:   Tue, 21 Mar 2023 19:05:12 +0200
Message-Id: <20230321170513.2401534-14-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230321170513.2401534-1-rppt@kernel.org>
References: <20230321170513.2401534-1-rppt@kernel.org>
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

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

vmalloc_init() is called only from mm_core_init(), there is no need to
declare it in include/linux/vmalloc.h

Move vmalloc_init() declaration to mm/internal.h

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 include/linux/vmalloc.h | 4 ----
 mm/internal.h           | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 69250efa03d1..351fc7697214 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -131,12 +131,8 @@ extern void *vm_map_ram(struct page **pages, unsigned int count, int node);
 extern void vm_unmap_aliases(void);
 
 #ifdef CONFIG_MMU
-extern void __init vmalloc_init(void);
 extern unsigned long vmalloc_nr_pages(void);
 #else
-static inline void vmalloc_init(void)
-{
-}
 static inline unsigned long vmalloc_nr_pages(void) { return 0; }
 #endif
 
diff --git a/mm/internal.h b/mm/internal.h
index 02273c5e971f..c05ad651b515 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -900,9 +900,14 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
  * mm/vmalloc.c
  */
 #ifdef CONFIG_MMU
+void __init vmalloc_init(void);
 int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
                 pgprot_t prot, struct page **pages, unsigned int page_shift);
 #else
+static inline void vmalloc_init(void)
+{
+}
+
 static inline
 int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
                 pgprot_t prot, struct page **pages, unsigned int page_shift)
-- 
2.35.1

