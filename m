Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4966C43E1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCVHNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCVHNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:13:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C68CDCA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:13:12 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j24so7046568wrd.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679469191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3VXMKh/lkCWPY1Nds8D2UzOeCpT3iiYlHjzEEB942A=;
        b=GIm+f8mi9fCweTMKzPk05Ys0YPYQIbGyytB0E1s9AR5+K+Ct2WQ0mJk9QUvfse58Ke
         rhDYYMkdWV8HmemOs3SeLkyrp47xRYkpI7kZsEjAWP/kSJOKRQzKaKBxOh1UDBKDMaKu
         zjGQK7NHAQBWGDjfYXWqpfXwkmjBviXhjAjKwvNKiJGl4aejpEQNXQ5bwWY6DA/ZP3Ou
         wxYsSTtHKka7IcCBslj7pMM6+tR6pn6YDide1uess0h+JuyvPLw8lPfszQmfF/EEJXaj
         Cf8qYi0yEKfpCGjyb7sSLMjDog7fekwpVzaFfbb1a1GsIotHP73gRECeCJlUtWgcv4T1
         E9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679469191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3VXMKh/lkCWPY1Nds8D2UzOeCpT3iiYlHjzEEB942A=;
        b=UywN6bZkyLy9VohFitpjdoSkXERA5eM6UkIJSPh0DqCGLCVYXdnUUnAJJWZZ8IyaMV
         QNxaDyrK+LGpFYWaGvLWSUiZnPObiiveJV8GoFd+g4td24KX+f3zDENuViw9JQVQcOPi
         aHGdL3N9NmEDj9D75NZ/sPQlbEEn05d1e642Y93QdXlqos31J3HCA292dYzICdsxDBr9
         oW56lqox3bhU05qj3Q5buQJtCqm+g8hlrDKlLo/CI8YsOgm4hnYo/KNQBVQ0PZysOIDE
         cQayMhpdZzKeOPHewC5vnUfkGNMh0MP4GYp2RMxqnJnHRtRt8H7WDQlC8oQ9njmhpfwW
         dvvQ==
X-Gm-Message-State: AO0yUKWS9oi02StVZfKEJHUllcr9h1GliNt5CF8M6yyShw7H0KapPrCr
        tXTXx5A6M/uYUhXjqOzrFwU=
X-Google-Smtp-Source: AK7set8l06vQUVZgYZZr43xezu2O1WbwUwuF5+5hPlxdDocLJ0+tvB7JHfxQq0H/QQBq80ZfOxmCcw==
X-Received: by 2002:a05:6000:100f:b0:2d5:b6a9:772a with SMTP id a15-20020a056000100f00b002d5b6a9772amr4821063wrx.17.1679469190963;
        Wed, 22 Mar 2023 00:13:10 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id u4-20020a5d4344000000b002c5526234d2sm13290279wrr.8.2023.03.22.00.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 00:13:10 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v3 2/4] mm/mmap/vma_merge: fold curr, next assignment logic
Date:   Wed, 22 Mar 2023 07:13:02 +0000
Message-Id: <36399b6cdc843eb7fe243488ea9b29464f699170.1679468982.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679468982.git.lstoakes@gmail.com>
References: <cover.1679468982.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
