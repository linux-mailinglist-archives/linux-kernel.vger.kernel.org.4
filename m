Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E716C5761
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjCVUUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjCVUUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:20:24 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2755399BD3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:10:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r29so18302177wra.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679515771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RY15Fh9kVTomLumjnxR3TB6ZLQ5YugEBgBi/gOE3sug=;
        b=heTwx97LsAuGz+zH+hB+ONFmZkqLMAfFgK6EkCn9Lc5rvPLphCGmRxHfrBHvldZIhN
         6nIp+q/EMzTSmk2NqTn706651dldDJgV6mY13uVCt9ZBZawk7f4L87JOr60Ayc49k+A7
         FF4qB1JiVSm60DdnQUWg4YH9w8VEVxzt3m0GYd5uQgrZgxJD1zP8+eEScWx06xz9BcyO
         9GzUOxRz1arIvgRGWGI4gi5Yyl7BnZS7DiTyl183vy534DHMcI9c5tOP9GZ8QGSKkIF3
         iHCou4d5uH0sXYHAO1mb/yHVarH5IO7TvWWrx/L55yzTNVLWV7ZvNPFj8W0b4ttIL9KG
         4IDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RY15Fh9kVTomLumjnxR3TB6ZLQ5YugEBgBi/gOE3sug=;
        b=ad+24tlXUUUxKw7z2mutRnQqYQ00/mMA/f8IXEEuIiy77UXrfdt09nH3L2CrMs3WoS
         6LQQeGDj080rFOyR/nhNO4jvgtYbrJ6WBa7o6wiuPSUkGqcm0TrHADXp4yZW/UdpZkY0
         Vvr3ZnrKI5AKNFVGnx24Dk9528+IOoTuS5RYASi4IhC/qCAWgcRvFSyGADlh/Va7IGpA
         eAhaVU0fl/w4c2bpqhVTU0PGCpIwPJFRK+/y4VISg1FdgeMaCiXqHukkm2zcHRbGxJLs
         x0PLVazQkzaZe5gYfq9zTEIAPieLYmdpv52GPyndsnNKcoIBkUPhi+FcMMVIauXARAq+
         drxw==
X-Gm-Message-State: AAQBX9fNmavejqAS9B1Pov8dMJ+gvhqdVTBmgnGtsieXVWI1TjG9t5P+
        tHoiNAjHOFSZrVX2pzcg9QA=
X-Google-Smtp-Source: AKy350Z63sSn+tcLJv9yQVGsamu6+bIn2KX6NdJ/94Wwl7SGKmy8kFxAFDAfxsovQe9a4fYAkbTCYQ==
X-Received: by 2002:adf:f5c5:0:b0:2ce:aa73:4960 with SMTP id k5-20020adff5c5000000b002ceaa734960mr806288wrp.5.1679515771219;
        Wed, 22 Mar 2023 13:09:31 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id a7-20020adff7c7000000b002c70ce264bfsm14664342wrq.76.2023.03.22.13.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 13:09:30 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4 3/4] mm/mmap/vma_merge: explicitly assign res, vma, extend invariants
Date:   Wed, 22 Mar 2023 20:09:21 +0000
Message-Id: <d439482d214a47c88c781bbe4ae71edce6882cad.1679515236.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679515236.git.lstoakes@gmail.com>
References: <cover.1679515236.git.lstoakes@gmail.com>
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

Previously, vma was an uninitialised variable which was only definitely
assigned as a result of the logic covering all possible input cases - for
it to have remained uninitialised, prev would have to be NULL, and next
would _have_ to be mergeable.

The value of res defaults to NULL, so we can neatly eliminate the
assignment to res and vma in the if (prev) block and ensure that both res
and vma are both explicitly assigned, by just setting both to prev.

In addition we add an explanation as to under what circumstances both might
change, and since we absolutely do rely on addr == curr->vm_start should
curr exist, assert that this is the case.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index dbdbb92493b2..2a4f63716231 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -911,7 +911,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 {
 	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
 	pgoff_t vma_pgoff;
-	struct vm_area_struct *curr, *next, *res = NULL;
+	struct vm_area_struct *curr, *next, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
 	int err = -1;
 	bool merge_prev = false;
@@ -939,14 +939,18 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	else
 		next = NULL;		/* case 5 */
 
-	/* verify some invariant that must be enforced by the caller */
+	/*
+	 * By default, we return prev. Cases 3, 4, 8 will instead return next
+	 * and cases 3, 8 will also update vma to point at next.
+	 */
+	res = vma = prev;
+
+	/* Verify some invariant that must be enforced by the caller. */
 	VM_WARN_ON(prev && addr <= prev->vm_start);
-	VM_WARN_ON(curr && end > curr->vm_end);
+	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
 	VM_WARN_ON(addr >= end);
 
 	if (prev) {
-		res = prev;
-		vma = prev;
 		vma_start = prev->vm_start;
 		vma_pgoff = prev->vm_pgoff;
 		/* Can we merge the predecessor? */
@@ -957,6 +961,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_prev(vmi);
 		}
 	}
+
 	/* Can we merge the successor? */
 	if (next && mpol_equal(policy, vma_policy(next)) &&
 	    can_vma_merge_before(next, vm_flags,
@@ -997,6 +1002,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			adj_start = -(prev->vm_end - addr);
 			err = dup_anon_vma(next, prev);
 		} else {
+			/*
+			 * Note that cases 3 and 8 are the ONLY ones where prev
+			 * is permitted to be (but is not necessarily) NULL.
+			 */
 			vma = next;			/* case 3 */
 			vma_start = addr;
 			vma_end = next->vm_end;
-- 
2.39.2

