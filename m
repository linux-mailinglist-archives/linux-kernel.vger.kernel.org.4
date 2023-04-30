Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D22A6F2A9D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 22:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjD3UTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 16:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjD3UTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 16:19:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDB3E4C
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 13:19:39 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f1950f5628so17354165e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 13:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682885978; x=1685477978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b23kKCtHH6bptYMnbkiFzswByhO4ugXGC7lReBIJxcE=;
        b=RgSAcUcAQnMir0yk7+P9NWQKpZGc724wNfiCtLYUJMRweuO2G+rKaOundt+kRebwgE
         2sA6flt2erNsCueOprvBW5SVElIoXeSqxHKlTYRo8Cw0fuD0ciyAHEh4AqzOJ79knliE
         tI+mXlKr22bkfbqqxwogYvuX9gJzfcwlkj31+Hx0lnvhaZQ45bKVZ8ygnOqmAN2t/m0F
         AFck/JQXi3Wnk9y6Qs5sEAcTgxRgzt4BNEXcCuW8IMPnZTSe9D4D29ih0EszWGpOvkqT
         0C6kd4cypf2y4ntF4CURxvHijaSw2BKIRmpcHs6CbSoOcbZ0sgOtmzAuvGyCNFQOUABm
         6p/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682885978; x=1685477978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b23kKCtHH6bptYMnbkiFzswByhO4ugXGC7lReBIJxcE=;
        b=lt4l4pRzcXUFluLoeXyjaxsUnK45WU7Ffis8m32dFU5EhWtzvhcja40C2Aiqz1QpQQ
         zotfQV8iCuKOxO7z90i/kZByKlnEvrVip1Yphyxbrvcc0PdDrhqnCaWnF2iKDnQL7JKr
         myj84I1F0MP0mfWrx5o3Q1pUHUBW1GiIQC4Xt4oN42OkBuRzva3Ub3qy0BVmcqa8WP7v
         nmR4htCBGu2LH1fzmkI3Wszcv3QCycaBvLKtCZKDXv/E43CTJAmFoj33+O8cXaeJvkup
         Y6TrruJoZQwF71Mx5mycS8x9rKHxXF1z7UoGmcSbnwoIhON2nO6YvTjhdhZK+NKrpieq
         xu2w==
X-Gm-Message-State: AC+VfDxWZJANvZqYFl3mwCBL1RMeHXUOGUtUhB+XDjpvgW08C49gd1g2
        9hoVqQM35TLkgiuqwb5byBc=
X-Google-Smtp-Source: ACHHUZ6jJ+pDxPFfbgjuEUDVYH+RAM1MTqF8dig4HP3VWbf9qEzmQ6g1LWOyO8x9g4vaC13vY+25Mw==
X-Received: by 2002:a7b:c84b:0:b0:3f1:75a9:5c0d with SMTP id c11-20020a7bc84b000000b003f175a95c0dmr9248332wml.26.1682885977604;
        Sun, 30 Apr 2023 13:19:37 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id j32-20020a05600c1c2000b003f173987ec2sm34328903wms.22.2023.04.30.13.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 13:19:36 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH] mm/mmap/vma_merge: always check invariants
Date:   Sun, 30 Apr 2023 21:19:17 +0100
Message-Id: <df548a6ae3fa135eec3b446eb3dae8eb4227da97.1682885809.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We may still have inconsistent input parameters even if we choose not to
merge and the vma_merge() invariant checks are useful for checking this
with no production runtime cost (these are only relevant when
CONFIG_DEBUG_VM is specified).

Therefore, perform these checks regardless of whether we merge.

This is relevant, as a recent issue (addressed in commit "mm/mempolicy:
Correctly update prev when policy is equal on mbind") in the mbind logic
was only picked up in the 6.2.y stable branch where these assertions are
performed prior to determining mergeability.

Had this remained the same in mainline this issue may have been picked up
faster, so moving forward let's always check them.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 5522130ae606..13678edaa22c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -960,17 +960,17 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		merge_next = true;
 	}
 
+	/* Verify some invariant that must be enforced by the caller. */
+	VM_WARN_ON(prev && addr <= prev->vm_start);
+	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
+	VM_WARN_ON(addr >= end);
+
 	if (!merge_prev && !merge_next)
 		return NULL; /* Not mergeable. */
 
 	res = vma = prev;
 	remove = remove2 = adjust = NULL;
 
-	/* Verify some invariant that must be enforced by the caller. */
-	VM_WARN_ON(prev && addr <= prev->vm_start);
-	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
-	VM_WARN_ON(addr >= end);
-
 	/* Can we merge both the predecessor and the successor? */
 	if (merge_prev && merge_next &&
 	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
-- 
2.40.1

