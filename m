Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06DC68D179
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjBGIbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjBGIbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:31:32 -0500
X-Greylist: delayed 561 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Feb 2023 00:31:31 PST
Received: from smtp-out1.aaront.org (smtp-out1.aaront.org [IPv6:2600:1f18:2745:f404::15:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173031E5CF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 00:31:30 -0800 (PST)
Received: by smtp-out1.aaront.org (Postfix) with ESMTP id 4P9x1q2S5kzPy;
        Tue,  7 Feb 2023 08:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aaront.org; h=
    from:to:cc:subject:date:message-id:mime-version
    :content-transfer-encoding; s=qkjur4vrxk6kmqfk; bh=tOntP/lKnUfaa
    WikAtnq4B5ZEFsg26kBaZ4PbeUZz8I=; b=Ev+TEZ9HTq95nVrDVoAGosIMYfs6X
    Tl7AMRZUYPXqROqJejhlIA85ctukhiyeCpCFxkmMotHn1OxAbm2AoF1ZUU/z0Y9M
    gindODTgIFWAdZ0rqE6TGfaDHR+O4FPatu2autzeOpr1r1CuLEBWg+ymSBCj51lm
    LjXMN7856Sw3iY0cR79TjHYz0K8EAwZFTbPVA8xEaQiAx2D56WIdhlnB2yQXxZ6W
    iUkyRTWa+x6gxn2lkErb+rimVDWEdCM7q172J8ZV/OMcQ/tsrMXxtuGQB2cs4rEG
    IOW7bkCPuGrsPO1c3qha6e9h/jNT/h45l5ShxLQisdCJksrTo0HCClGig==
From:   Aaron Thompson <dev@aaront.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Aaron Thompson <dev@aaront.org>
Subject: [PATCH] Revert "mm: Always release pages to the buddy allocator in memblock_free_late()."
Date:   Tue,  7 Feb 2023 08:21:51 +0000
Message-Id: <20230207082151.1303-1-dev@aaront.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 115d9d77bb0f9152c60b6e8646369fa7f6167593.

The pages being freed by memblock_free_late() have already been
initialized, but if they are in the deferred init range,
__free_one_page() might access nearby uninitialized pages when trying to
coalesce buddies. This can, for example, trigger this BUG:

  BUG: unable to handle page fault for address: ffffe964c02580c8
  RIP: 0010:__list_del_entry_valid+0x3f/0x70
   <TASK>
   __free_one_page+0x139/0x410
   __free_pages_ok+0x21d/0x450
   memblock_free_late+0x8c/0xb9
   efi_free_boot_services+0x16b/0x25c
   efi_enter_virtual_mode+0x403/0x446
   start_kernel+0x678/0x714
   secondary_startup_64_no_verify+0xd2/0xdb
   </TASK>

A proper fix will be more involved so revert this change for the time
being.

Fixes: 115d9d77bb0f ("mm: Always release pages to the buddy allocator in memblock_free_late().")
Signed-off-by: Aaron Thompson <dev@aaront.org>
---
 mm/memblock.c                     | 8 +-------
 tools/testing/memblock/internal.h | 4 ----
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 685e30e6d27c..d036c7861310 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1640,13 +1640,7 @@ void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
 	end = PFN_DOWN(base + size);
 
 	for (; cursor < end; cursor++) {
-		/*
-		 * Reserved pages are always initialized by the end of
-		 * memblock_free_all() (by memmap_init() and, if deferred
-		 * initialization is enabled, memmap_init_reserved_pages()), so
-		 * these pages can be released directly to the buddy allocator.
-		 */
-		__free_pages_core(pfn_to_page(cursor), 0);
+		memblock_free_pages(pfn_to_page(cursor), cursor, 0);
 		totalram_pages_inc();
 	}
 }
diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
index 85973e55489e..fdb7f5db7308 100644
--- a/tools/testing/memblock/internal.h
+++ b/tools/testing/memblock/internal.h
@@ -15,10 +15,6 @@ bool mirrored_kernelcore = false;
 
 struct page {};
 
-void __free_pages_core(struct page *page, unsigned int order)
-{
-}
-
 void memblock_free_pages(struct page *page, unsigned long pfn,
 			 unsigned int order)
 {
-- 
2.30.2

