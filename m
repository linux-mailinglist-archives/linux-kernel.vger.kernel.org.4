Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DC56C05ED
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 23:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjCSWCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 18:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjCSWB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 18:01:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2620F1EBF8;
        Sun, 19 Mar 2023 15:01:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B7B8611A7;
        Sun, 19 Mar 2023 22:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEBEC4339B;
        Sun, 19 Mar 2023 22:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679263273;
        bh=PogP7wRngXQiUqmQnWvQozicSIVShAdtUNbeYC8wpS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BbRrG7/No3s+Wxn35WykZgqumgAtgA71gdQ5J12dxWsQy8T8UYZ0xOfDgvafCU0gU
         juKoeAAlcxDYKBZj7ANUaIDhkirDSSOn9GQHrhjrlBMAH632EHvpMIDKl/8mm6psIy
         x4E9jus7CN4xPRD62XXDkHy6wYmKhH/Rrkc6uE9Pi+lX/HLxmCNzPlOAfx4mQDCypg
         0IKAP5boUvNjsBQkM3+RA309/oZJHntXBHJ5Xor9n1MvaJQAHrzbMA0bHab61TmasX
         l+NN5p1t3GG1PEDp6Sv0t7ytroVh+moRTc2smV8hZ2vuDxm+xP/p1KRVuZ4d2A2bEy
         5G44pgtQ35qMQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 14/15] mm: move vmalloc_init() declaration to mm/internal.h
Date:   Mon, 20 Mar 2023 00:00:07 +0200
Message-Id: <20230319220008.2138576-15-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319220008.2138576-1-rppt@kernel.org>
References: <20230319220008.2138576-1-rppt@kernel.org>
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

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

vmalloc_init() is called only from mm_core_init(), there is no need to
declare it in include/linux/vmalloc.h

Move vmalloc_init() declaration to mm/internal.h

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
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
index 1be4278d7913..7e22137b4e86 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -895,9 +895,14 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
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

