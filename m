Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E306C5765
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjCVUVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjCVUVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:21:24 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5099BA7E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:11:31 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id e18so6784243wra.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679515770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GO8gjHQRXv2Un29P2Y8lUFkK9dWM8KuuH6aA4Tbj+3k=;
        b=DHN/J40dkIVQbTYscSGO+Nw3wEnp3jsVaZKInlFauFW/fFD37W6vZ3gD4yucGEbMAb
         QscnKR1q8gI0jP9TfvTnzL8PuKAn/v8E6mRSVpHHyNejyrYBOy6ZtHsegXjtL4d3JZgx
         xUxxpms7Y5kej7CVVVjWMlUt9vO3kIOHPPLCLdfEXk3dbwmX7OuYUdItV92IiMz1WwJo
         nNF6GihJphkb0G4LDa99hh4HXG3i/M6dRusRNUNQnlHK50Cr/g5T6FLlC9bzbWDoritH
         jy7thn1e04UQWcu/lg4zGjzKUHg8SR5UmcNifTHC2/V0aTJKCmdAVi4hNooXgtfBvD69
         0wog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GO8gjHQRXv2Un29P2Y8lUFkK9dWM8KuuH6aA4Tbj+3k=;
        b=cx697D9/1sY7d1xIN5bNV8E0l1NLuEyHoxEC6BwFbzF2Wbhh4Pax5bHwERpyohfjWy
         Gqf0KOwMOcU6U5NsIJooQtxacxwFX6DxYxTsfiMgPG/KnnqAcuEWT41g66+tQh9rqzxn
         HdWQEJEwi301soJUNh218g/CSrvqw08O97tIONPJixCbil+jWjnAND+WpIFmbvLyZmOS
         gd4akLAG5UFmo9zD5rZqwPyLLgiNmf4hjM/dCKR2pn75+zFU9pQZO94+n92yIqRbO/Fx
         DeMs3fYBQlHhl/pA4GIEG7MuaxJQjaqKZpXZ6/yeAPY6EmWHR/RnnMulGc2sKsU4437U
         gelw==
X-Gm-Message-State: AAQBX9dzwWPqUVzQVKKXPtt6aUgYA+a6Org5/sH5mOvVQhvzMlSNRQ9+
        PmvB7bPpCDbf7jwYsl6r3m0=
X-Google-Smtp-Source: AKy350aqO36egO2mzIugs0TiepT1e3+Ad2Tmkr+3Aay8N6lO3xSIhw5jGIIgjtJP7nZDPH74zPcdjQ==
X-Received: by 2002:a5d:5144:0:b0:2ce:9d06:58c6 with SMTP id u4-20020a5d5144000000b002ce9d0658c6mr700190wrt.53.1679515769795;
        Wed, 22 Mar 2023 13:09:29 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id a7-20020adff7c7000000b002c70ce264bfsm14664342wrq.76.2023.03.22.13.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 13:09:28 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4 2/4] mm/mmap/vma_merge: fold curr, next assignment logic
Date:   Wed, 22 Mar 2023 20:09:20 +0000
Message-Id: <d8c6aa22316af346854a1812944bcb193b1a7d4b.1679515236.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679515236.git.lstoakes@gmail.com>
References: <cover.1679515236.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use find_vma_intersection() and vma_lookup() to both simplify the logic and
to fold the end == next->vm_start condition into one block.

This groups all of the simple range checks together and establishes the
invariant that, if prev, curr or next are non-NULL then their positions are
as expected.

This has no functional impact.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c9834364ac98..dbdbb92493b2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -930,15 +930,14 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
 
-	curr = find_vma(mm, prev ? prev->vm_end : 0);
-	if (curr && curr->vm_end == end)		/* cases 6, 7, 8 */
-		next = find_vma(mm, curr->vm_end);
-	else
-		next = curr;
+	/* Does the input range span an existing VMA? (cases 5 - 8) */
+	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
 
-	/* In cases 1 - 4 there's no CCCC vma */
-	if (curr && end <= curr->vm_start)
-		curr = NULL;
+	if (!curr ||			/* cases 1 - 4 */
+	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
+		next = vma_lookup(mm, end);
+	else
+		next = NULL;		/* case 5 */
 
 	/* verify some invariant that must be enforced by the caller */
 	VM_WARN_ON(prev && addr <= prev->vm_start);
@@ -959,11 +958,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		}
 	}
 	/* Can we merge the successor? */
-	if (next && end == next->vm_start &&
-			mpol_equal(policy, vma_policy(next)) &&
-			can_vma_merge_before(next, vm_flags,
-					     anon_vma, file, pgoff+pglen,
-					     vm_userfaultfd_ctx, anon_name)) {
+	if (next && mpol_equal(policy, vma_policy(next)) &&
+	    can_vma_merge_before(next, vm_flags,
+				 anon_vma, file, pgoff+pglen,
+				 vm_userfaultfd_ctx, anon_name)) {
 		merge_next = true;
 	}
 
-- 
2.39.2

