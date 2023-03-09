Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8C76B227E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjCILRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjCILRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:17:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FE351FB6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:13:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5D51921E8A;
        Thu,  9 Mar 2023 11:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678360391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3YUrWV7jfpXoA++JeKVk7hZ9f1CmC3d5xDMhvCnqQY=;
        b=vEtLBCb2yry/emu/jQIc82ZS1qlwzsWUD3kbJjRDcSQH1Plr6grvNfNZcmXccfFFnXIVOJ
        KXC3aZGxY+Q4fR2CySOSWAp5CLIId9rmeDxY7aMapaHDH2HsOYxzL7hfo+3kQUVZBHKdau
        tbbQR77ynnrN30wYRBqIe6kqhTK7okQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678360391;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3YUrWV7jfpXoA++JeKVk7hZ9f1CmC3d5xDMhvCnqQY=;
        b=uW6jZY4OeymUbTM2/kEI4rtBKz9eeX37/5LcvI4Yc+ms/o0L55GgSWDvQw5rEuIxSmmxfT
        kLvXbh1WeGCFo0Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E55F13A73;
        Thu,  9 Mar 2023 11:13:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wFGoDke/CWRiRwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 09 Mar 2023 11:13:11 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        maple-tree@lists.infradead.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 03/10] mm/mmap/vma_merge: use the proper vma pointers in cases 1 and 6
Date:   Thu,  9 Mar 2023 12:12:51 +0100
Message-Id: <20230309111258.24079-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309111258.24079-1-vbabka@suse.cz>
References: <20230309111258.24079-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Case 1 is now shown in the comment as next vma being merged with prev,
so use 'next' instead of 'mid'. In case 1 they both point to the same
vma.

As a consequence, in case 6, the dup_anon_vma() is now tried first on
'next' and then on 'mid', before it was the opposite order. This is not
a functional change, as those two vma's cannnot have a different
anon_vma, as that would have prevented the merging in the first place.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1af4c9bc2c87..c33237b283c9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -605,7 +605,7 @@ static inline void vma_complete(struct vma_prepare *vp,
 
 		/*
 		 * In mprotect's case 6 (see comments on vma_merge),
-		 * we must remove the one after next as well.
+		 * we are removing both mid and next vmas
 		 */
 		if (vp->remove2) {
 			vp->remove = vp->remove2;
@@ -948,13 +948,14 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	/* Can we merge both the predecessor and the successor? */
 	if (merge_prev && merge_next &&
 	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
-		remove = mid;				/* case 1 */
+		remove = next;				/* case 1 */
 		vma_end = next->vm_end;
-		err = dup_anon_vma(prev, mid);
+		err = dup_anon_vma(prev, next);
 		if (mid != next) {			/* case 6 */
+			remove = mid;
 			remove2 = next;
-			if (!mid->anon_vma)
-				err = dup_anon_vma(prev, next);
+			if (!next->anon_vma)
+				err = dup_anon_vma(prev, mid);
 		}
 	} else if (merge_prev) {
 		err = 0;				/* case 2 */
-- 
2.39.2

