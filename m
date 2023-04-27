Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3366F0703
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243793AbjD0OKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243343AbjD0OKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:10:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75043B3;
        Thu, 27 Apr 2023 07:10:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2D4921FE3B;
        Thu, 27 Apr 2023 14:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682604607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=jEqRVG+8Dcj6ijJa/JrCFAx9tBcDp1RS6kPZqc1Elbc=;
        b=MePFwGhaepIE3/27uZpP71e7L5tVtchBYpdXJ4oUagj0/EjIJe+PGXVrfUv0i6427RuUkb
        QJY+xGZy6cRmiyxihdjr/pJ7I9aRNnult1PaQMd4okCQrejLCHB12LwzqnV4VSuFbCUVMl
        CLpoDdcszSWFz3Qi2dVWKmwACY0dhUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682604607;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=jEqRVG+8Dcj6ijJa/JrCFAx9tBcDp1RS6kPZqc1Elbc=;
        b=ySABGXvhe1KqxVKho6dXds9Kj/WWS8MSO1VyFw9UZ5laodhQY+uuJ9N9osw8id34H7TGWb
        vEhr0ZCOsZ8Lt9CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE850138F9;
        Thu, 27 Apr 2023 14:10:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id drdvOT6CSmQuEAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 27 Apr 2023 14:10:06 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, lstoakes@gmail.com,
        regressions@lists.linux.dev, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Jiri Slaby <jirislaby@kernel.org>,
        Fabian Vogt <fvogt@suse.com>, stable@vger.kernel.org
Subject: [PATCH for v6.3 regression] mm/mremap: fix vm_pgoff in vma_merge() case 3
Date:   Thu, 27 Apr 2023 16:09:59 +0200
Message-Id: <20230427140959.27655-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading build guests to v6.3, rpm started segfaulting for
specific packages, which was bisected to commit 0503ea8f5ba7 ("mm/mmap:
remove __vma_adjust()"). rpm is doing many mremap() operations with file
mappings of its db. The problem is that in vma_merge() case 3 (we merge
with the next vma, expanding it downwards) vm_pgoff is not adjusted as
it should when vm_start changes. As a result the rpm process most likely
sees data from the wrong offset of the file. Fix the vm_pgoff
calculation.

For case 8 this is a non-functional change as the resulting vm_pgoff is
the same.

Reported-and-bisected-by: Jiri Slaby <jirislaby@kernel.org>
Reported-and-tested-by: Fabian Vogt <fvogt@suse.com>
Link: https://bugzilla.suse.com/show_bug.cgi?id=1210903
Fixes: 0503ea8f5ba7 ("mm/mmap: remove __vma_adjust()")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
---
Hi, I'm sending this patch on top of v6.3 as I think it should be
applied and backported to 6.3-stable rather sooner than later.
This means there would be a small conflict when merging mm/mm-stable
later. Alternatively it could be added to mm/mm-stable and upcoming 6.4
pull request, but then the stable backport would need adjustment.
It's up to Linus and Andrew.

#regzbot introduced: 0503ea8f5ba7 https://bugzilla.suse.com/show_bug.cgi?id=1210903

 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index d5475fbf5729..eefa6f0cda28 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -978,7 +978,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma = next;			/* case 3 */
 			vma_start = addr;
 			vma_end = next->vm_end;
-			vma_pgoff = mid->vm_pgoff;
+			vma_pgoff = next->vm_pgoff - pglen;
 			err = 0;
 			if (mid != next) {		/* case 8 */
 				remove = mid;
-- 
2.40.0

