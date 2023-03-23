Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602F66C6773
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjCWMBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjCWMAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:00:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4519B366AB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 04:59:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D09BB62653
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E6BC4339C;
        Thu, 23 Mar 2023 11:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679572752;
        bh=XWLuxoeuAjQ0mUCYpCvh//KdRJ/f4l5MIwreKshFoaM=;
        h=From:To:Cc:Subject:Date:From;
        b=tBTAYbPS1lzP8x3XUCu1oh/aQIAFffDcYizxUgHHLq8+EBr1yoibNnSB25Fjgqecq
         BQrgn/kTrTGTYYCiLC3wdTqsMpcdzsvIMUAXsqe/nbxZNXv9qg23we0idnZR5og2jw
         U82IGtiPy3aqbBXoeoXbiovfzpEKNaheKqs74TluFDlxXOQ/VIY075Tgv/VgseLhq9
         rsGPMZLMQ8f5+DMBdly9fscK3PcZk1CxJ63dELFEirOgTTioOKx9JZI0haa1SzwLA5
         WYEIGxSY4pZQZ8K5qAWsCWLcbGCpuRRkWVAmf8g7cWSLUHFpqLKqR3E7PYP68FXQct
         G6gsSvaoLWKCQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 1/3] mm/mmap/vma_merge: actually set next to NULL if not applicable
Date:   Thu, 23 Mar 2023 12:58:34 +0100
Message-Id: <20230323115903.1483668-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

As clang builds point out, the variable 'next' is now uninitialized
in some conditions as a result of a previous patch that tried to
rely on it being NULL here:

mm/mmap.c:939:11: error: variable 'next' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
        else if (!curr)
                 ^~~~~
mm/mmap.c:952:15: note: uninitialized use occurs here
        merge_next = next && mpol_equal(policy, vma_policy(next)) &&
                     ^~~~

Fixes: e887ecae997e ("mm/mmap/vma_merge: set next to NULL if not applicable")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 54099a604cf8..c01d43bd694e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -939,6 +939,8 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	else if (!curr)
 		/* Is there a VMA next to a hole (case 1 - 3) or prev (4)? */
 		next = vma_lookup(mm, end);
+	else
+		next = NULL;
 
 	/* Can we merge the predecessor? */
 	if (prev && addr == prev->vm_end && mpol_equal(vma_policy(prev), policy)
-- 
2.39.2

