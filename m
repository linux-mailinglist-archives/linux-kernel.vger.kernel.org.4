Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F47745083
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGBTjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjGBTiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:38:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702041997;
        Sun,  2 Jul 2023 12:38:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE43260C8C;
        Sun,  2 Jul 2023 19:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDE8C433C7;
        Sun,  2 Jul 2023 19:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326716;
        bh=Khh4iWMEVT9SMqf0Lbl4TwZP+WrkxYnZ9N4x2CSXiek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TsODVfyCvfGyfzdvwXARhzgP+FmdRWOoUqPeNNNkuwDZZJ6aem7THmpS99EDnYKTa
         +HDebuBNE13OlDWtPrgv1GsSzz2y5MP683+jHcD+0qRLiJ7hO/qukjih0tht7Fkcwk
         Z5sZXeNIWJ/Y89ctVo4sig9PksYqfcrPpYL5wWFPeWW+FoGkIJeW8/b8x0eH7pHes+
         axruYkppTAB9yw3XmgIKTrhuiYSzK62Yp0UZE231T6Zn0y/GVzyDuZW4yhzHwaECW/
         0utdtc3KPx3eQ5OXipxFeRJsvvTZSpiE9dBAqXvvtJJdIAa+Dpqq+uPu+9SI8ijfE+
         dEkYcWwMA0AXg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, hca@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 08/16] s390/kasan: avoid short by one page shadow memory
Date:   Sun,  2 Jul 2023 15:38:07 -0400
Message-Id: <20230702193815.1775684-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702193815.1775684-1-sashal@kernel.org>
References: <20230702193815.1775684-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Gordeev <agordeev@linux.ibm.com>

[ Upstream commit 3e8261003bd28208986d3c42004510083c086e24 ]

Kernel Address Sanitizer uses 3 bits per byte to
encode memory. That is the number of bits the start
and end address of a memory range is shifted right
when the corresponding shadow memory is created for
that memory range.

The used memory mapping routine expects page-aligned
addresses, while the above described 3-bit shift might
turn the shadow memory range start and end boundaries
into non-page-aligned in case the size of the original
memory range is less than (PAGE_SIZE << 3). As result,
the resulting shadow memory range could be short on one
page.

Align on page boundary the start and end addresses when
mapping a shadow memory range and avoid the described
issue in the future.

Note, that does not fix a real problem, since currently
no virtual regions of size less than (PAGE_SIZE << 3)
exist.

Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/boot/vmem.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/s390/boot/vmem.c b/arch/s390/boot/vmem.c
index acb1f8b53105b..c67f59db7a512 100644
--- a/arch/s390/boot/vmem.c
+++ b/arch/s390/boot/vmem.c
@@ -45,6 +45,13 @@ static void pgtable_populate(unsigned long addr, unsigned long end, enum populat
 
 static pte_t pte_z;
 
+static inline void kasan_populate(unsigned long start, unsigned long end, enum populate_mode mode)
+{
+	start = PAGE_ALIGN_DOWN(__sha(start));
+	end = PAGE_ALIGN(__sha(end));
+	pgtable_populate(start, end, mode);
+}
+
 static void kasan_populate_shadow(void)
 {
 	pmd_t pmd_z = __pmd(__pa(kasan_early_shadow_pte) | _SEGMENT_ENTRY);
@@ -95,17 +102,17 @@ static void kasan_populate_shadow(void)
 	 */
 
 	for_each_physmem_usable_range(i, &start, &end)
-		pgtable_populate(__sha(start), __sha(end), POPULATE_KASAN_MAP_SHADOW);
+		kasan_populate(start, end, POPULATE_KASAN_MAP_SHADOW);
 	if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
 		untracked_end = VMALLOC_START;
 		/* shallowly populate kasan shadow for vmalloc and modules */
-		pgtable_populate(__sha(VMALLOC_START), __sha(MODULES_END), POPULATE_KASAN_SHALLOW);
+		kasan_populate(VMALLOC_START, MODULES_END, POPULATE_KASAN_SHALLOW);
 	} else {
 		untracked_end = MODULES_VADDR;
 	}
 	/* populate kasan shadow for untracked memory */
-	pgtable_populate(__sha(ident_map_size), __sha(untracked_end), POPULATE_KASAN_ZERO_SHADOW);
-	pgtable_populate(__sha(MODULES_END), __sha(_REGION1_SIZE), POPULATE_KASAN_ZERO_SHADOW);
+	kasan_populate(ident_map_size, untracked_end, POPULATE_KASAN_ZERO_SHADOW);
+	kasan_populate(MODULES_END, _REGION1_SIZE, POPULATE_KASAN_ZERO_SHADOW);
 }
 
 static bool kasan_pgd_populate_zero_shadow(pgd_t *pgd, unsigned long addr,
-- 
2.39.2

