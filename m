Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BF765592B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 09:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiLXIUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 03:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiLXIUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 03:20:39 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAFADFA2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 00:20:38 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id k22-20020aa79736000000b0057f3577fdbaso3549972pfg.8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 00:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ihTDH6jZHdlVGdscYLo+1J1fOC8tjCOiHkEMZL35An0=;
        b=O2RgjytvDPz+6g9CFcczLL248lQ0CKGMUUPXSrAXNh49DWEMFH6BB2Lu/8S/m1Kd7R
         Bbsz01ZiRT223Syp1Eh8kai1+ObucV/135HjfhH/GAAJY7X6m0MNIIp+V8920RBGR8RY
         ft42nde+5+lSZI87XCDPY+KcgYaQE4nB4d1mZWFmGojxerVBeU6Wi9EA+5lLrc0hezdj
         rTwNYEsX9FdvJGxM1T5juuxMYPYcEZ4eDajArurOQ2qOcm79cw1AWS9I0uiItkwStEHd
         aYL4JlQ+/BpySpoV/dNjsTPOdw2ifprcV9CU3S2243eAiX/YA4qE6bWLcOQhevfRonxY
         BV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ihTDH6jZHdlVGdscYLo+1J1fOC8tjCOiHkEMZL35An0=;
        b=EexG6WmFFnxgFeOfM6h10HPJuyvpZqdCmrA1kcQuv171cR7PhwyQuWrJAtqOp0uC86
         I/1FeD5cU3ZJfJLY3HrHeyy3GZxj6sg6qHb17mMGr5kXpxAEyvg1n8X/4GQbDpG6xoS3
         5Xi30kAJrHuIkYP+veIFgWpOUAMwhE0Q2QJNykpxY8bWam3YN7PIkFvvkM1wDJtyfHol
         MjeT7WavxUpqYxTFf+8RCq8H6qc/3+JjQ9awXN6qSMQS/sA+EddEleXwkjODQdpWI6Cf
         ueAib4oOesbd6ImjEVlMX8/OpKcpnAFoUBKfbPsia1qguQaXBYGMANx+69FpJ5Xx7C9Y
         xszw==
X-Gm-Message-State: AFqh2kprdrSkndIV8AH5O0J/e5Yn0JObmDZ9/nCfqoEMheEICEcusS3i
        xkHlbPQ6zPabh9C0pn53tGk7nXPlqcxc
X-Google-Smtp-Source: AMrXdXvdFmFXW5Qb97N0QrfYVlOEyfoUEa8iHxd87AV61GPshlomzetW6kZfirXu9H1n5bGTnaw2lWu62OEO
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a17:90b:3015:b0:219:c8d5:27d7 with SMTP id
 hg21-20020a17090b301500b00219c8d527d7mr1200309pjb.141.1671870037941; Sat, 24
 Dec 2022 00:20:37 -0800 (PST)
Date:   Sat, 24 Dec 2022 00:20:34 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221224082035.3197140-1-zokeefe@google.com>
Subject: [PATCH v3 1/2] mm/MADV_COLLAPSE: don't expand collapse when vm_end is
 past requested end
From:   "Zach O'Keefe" <zokeefe@google.com>
To:     linux-mm@kvack.org
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Yang Shi <shy828301@gmail.com>,
        "Zach O'Keefe" <zokeefe@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MADV_COLLAPSE acts on one hugepage-aligned/sized region at a time, until
it has collapsed all eligible memory contained within the bounds
supplied by the user.

At the top of each hugepage iteration we (re)lock mmap_lock and
(re)validate the VMA for eligibility and update variables that might
have changed while mmap_lock was dropped.  One thing that might occur,
is that the VMA could be resized, and as such, we refetch vma->vm_end
to make sure we don't collapse past the end of the VMA's new end.

However, it's possible that when refetching vma>vm_end that we expand the
region acted on by MADV_COLLAPSE if vma->vm_end is greater than size+len
supplied by the user.

The consequence here is that we may attempt to collapse more memory than
requested, possibly yielding either "too much success" or "false
failure" user-visible results.  An example of the former is if we
MADV_COLLAPSE the first 4MiB of a 2TiB mmap()'d file, the incorrect
refetch would cause the operation to block for much longer than
anticipated as we attempt to collapse the entire TiB region.  An example
of the latter is that applying MADV_COLLPSE to a 4MiB file mapped to the
start of a 6MiB VMA will successfully collapse the first 4MiB, then
incorrectly attempt to collapse the last hugepage-aligned/sized region
-- fail (since readahead/page cache lookup will fail) -- and report a
failure to the user.

Don't expand the acted-on region when refetching vma->vm_end.

Fixes: 4d24de9425f7 ("mm: MADV_COLLAPSE: refetch vm_end after reacquiring mmap_lock")
Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Zach O'Keefe <zokeefe@google.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: stable@vger.kernel.org
---
v2->v3: Add 'Cc: stable@vger.kernel.org' as per stable-kernel-rules.
v1->v2: Updated changelog to make clear what user-visible issues this
	patch addresses, as well makes the case for backporting (Andrew
	Morton).

While there aren't any stability risks, without this patch there exist
trivial examples where MADV_COLLAPSE won't work; as such, this should be
backported to stable 6.1.X to make MADV_COLLAPSE dependable in such
cases.

v1: https://lore.kernel.org/linux-mm/CAAa6QmRx_b2UCJWE2XZ3=3c3-_N3R4cDGX6Wm4OT7qhFC6U_SQ@mail.gmail.com/T/#m6c91da3cdbd9b1d1ebb29d415962deb158a2c658
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 5cb401aa2b9d..b4d2ec0a94ed 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2649,7 +2649,7 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 				goto out_nolock;
 			}
 
-			hend = vma->vm_end & HPAGE_PMD_MASK;
+			hend = min(hend, vma->vm_end & HPAGE_PMD_MASK);
 		}
 		mmap_assert_locked(mm);
 		memset(cc->node_load, 0, sizeof(cc->node_load));
-- 
2.39.0.314.g84b9a713c41-goog

