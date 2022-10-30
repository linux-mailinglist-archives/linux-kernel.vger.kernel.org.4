Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D99612D05
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 22:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJ3Vbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 17:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJ3Vbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 17:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DEBA47B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667165438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IiwOf4LgCWPWNLGKe48rMbCAvlS3n6l4UUSg+FeDzrg=;
        b=idvhbcWR738L/aQ5ehZP1m92TgG1mhHVdofKWfsPj6/uLrpY7dqRMns5mzEyCnCvEZyZWM
        sXdbGlNO/rtvnnSObICra9kepZMwW2BWn1JjTDj0tQNiCpeZUphOzbvPd4V2+OCpxXUYH4
        SVztPpxQYhTCboot/LVYDt8rhJ0z3bU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-583-AGrdtJLdMoe3b1tBraq3Wg-1; Sun, 30 Oct 2022 17:30:37 -0400
X-MC-Unique: AGrdtJLdMoe3b1tBraq3Wg-1
Received: by mail-qt1-f199.google.com with SMTP id i13-20020ac8764d000000b003a4ec8693dcso6554819qtr.14
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiwOf4LgCWPWNLGKe48rMbCAvlS3n6l4UUSg+FeDzrg=;
        b=iDgkPSmJokemggaz2DS9wVZYmi7SSps4YlhFpS42ilLy+LZdVJkEeetdD45uvgIBne
         V2LhsWk3y4u1U+r8oa1L0VQ4iizthcWEddUctXpOIoFB2ucKpMfOp/RLcRcYSRayONsG
         k+XF0VF5bieEYJKrmI8e9cYaML2f7T1bAE7s2FwDTmwwgKNiHhE+oZDFTzP1icuvR/KR
         ldsqu2CANh/Bjvl9oRToTRuOaiUnjGN2s8lt+d/pYdoc+du0OR4cDEwn63M3dVhase18
         mw45kDktigbGB+jTqez48Cp/gq4kiGQeCFn65+UcLXV6Fw3ejpYh4Aq5f4EPVekJWHyd
         6yNA==
X-Gm-Message-State: ACrzQf1EmoK1+RPxXQ2KPL+HD9GP42rE8dyD5R2JwQPQi+i+LcxETpJM
        3IHB8mKqgR0HE1L3hsOHggzplz/V+i56XKpCnwxdUSsrirGbsvlSa4AyCA/ewG6BXKZx+AG6Qcs
        S/E6k4XVnAkgYDkidXZODdVXD9JealPoX1zSp9mejF/BhQzdxhp6W+VhR6jjj69zMlNhQMGAbrg
        ==
X-Received: by 2002:a05:620a:16c7:b0:6fa:313b:f0e0 with SMTP id a7-20020a05620a16c700b006fa313bf0e0mr325886qkn.137.1667165434619;
        Sun, 30 Oct 2022 14:30:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5tfUshtQQUT1K81sgbv4hWXmjMUpQkS9187l/2AQBRJVYTUcvFXxGStsp5n6ll6i2p3uKefg==
X-Received: by 2002:a05:620a:16c7:b0:6fa:313b:f0e0 with SMTP id a7-20020a05620a16c700b006fa313bf0e0mr325867qkn.137.1667165434343;
        Sun, 30 Oct 2022 14:30:34 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bm29-20020a05620a199d00b006e42a8e9f9bsm3469443qkb.121.2022.10.30.14.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 14:30:33 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Rik van Riel <riel@surriel.com>,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com
Subject: [PATCH RFC 08/10] mm/hugetlb: Make follow_hugetlb_page RCU-safe
Date:   Sun, 30 Oct 2022 17:30:32 -0400
Message-Id: <20221030213032.335589-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221030212929.335473-1-peterx@redhat.com>
References: <20221030212929.335473-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCU makes sure the pte_t* won't go away from under us.  Please refer to the
comment above huge_pte_offset() for more information.

Some small trick is used to release RCU slightly earlier, but that should
be safe and just cleaner (with rich comment in code).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 85214095fb85..5dc87e4e6780 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6300,6 +6300,9 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			break;
 		}
 
+		/* For huge_pte_offset() */
+		rcu_read_lock();
+
 		/*
 		 * Some archs (sparc64, sh*) have multiple pte_ts to
 		 * each hugepage.  We have to make sure we get the
@@ -6324,6 +6327,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		    !hugetlbfs_pagecache_present(h, vma, vaddr)) {
 			if (pte)
 				spin_unlock(ptl);
+			rcu_read_unlock();
 			remainder = 0;
 			break;
 		}
@@ -6345,6 +6349,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 
 			if (pte)
 				spin_unlock(ptl);
+			rcu_read_unlock();
+
 			if (flags & FOLL_WRITE)
 				fault_flags |= FAULT_FLAG_WRITE;
 			else if (unshare)
@@ -6387,6 +6393,19 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			continue;
 		}
 
+		/*
+		 * When reach here, it means the pteval is not absent, so
+		 * anyone who wants to free and invalidate the pgtable page
+		 * (aka, pte*) should need to first unmap the entries which
+		 * relies on the pgtable lock.  Since we're holding it,
+		 * we're safe even without RCU anymore.
+		 *
+		 * We can also just release RCU after each unlock of
+		 * pgtable below, but this is just much cleaner, and also
+		 * smaller critical section.
+		 */
+		rcu_read_unlock();
+
 		pfn_offset = (vaddr & ~huge_page_mask(h)) >> PAGE_SHIFT;
 		page = pte_page(huge_ptep_get(pte));
 
-- 
2.37.3

