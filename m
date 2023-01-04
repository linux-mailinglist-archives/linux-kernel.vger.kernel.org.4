Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02B765E09A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 00:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbjADW42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 17:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbjADW4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:56:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFE24437D
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 14:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672872924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iUQecF0p0KDaGb3ic+3dlRjRyqZfOtSt4XLNwuIXR0Y=;
        b=eKUy64RdDxZuGHGRVfko63JMu8nXyYKDgA8xffbzTgoMxxK91i7THAk2ztsUgR8iQWuRY7
        AMD/ucEp788aDf49h0BvU8D8XSF/maGYquUYrc7dhfv4uEhGesHBlB4TsDxKiiJuO3TKyb
        3E5aVl5MGn7yBzDPKPDvrlkS3pWiNhY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-QnrUK-fnMuKlk5MHAX28yA-1; Wed, 04 Jan 2023 17:52:13 -0500
X-MC-Unique: QnrUK-fnMuKlk5MHAX28yA-1
Received: by mail-qv1-f69.google.com with SMTP id o95-20020a0c9068000000b005320eb4e959so471614qvo.16
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 14:52:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUQecF0p0KDaGb3ic+3dlRjRyqZfOtSt4XLNwuIXR0Y=;
        b=65SkchlFOIpuEPwKDD5DPfLgCYckfo+sd+ZF6TfIyGW6TBTH/pm4a5wsIS12kn57uf
         it9/pYGKv267DB/G0Q/820LcVk+DWsvRSittCkm3Tf5Aylk4jsTncfe5tdu9oKHHbBvl
         Zi96C2F8tUMmaTGglZIIzH0X44SjfBJLRAsv0fFoxJEs1xwGGnwt0VshHub3e+GQwUL/
         1T8KofVkaKSMi9UIktQgEumSb/+K65z9ii3loN3le9x7dSJfEdEt7PQRXbNz1YFJ4OBV
         IV0sISWZV5X/e7J5w7QNGHCmAHuPCf77dmGbPEVPz27pJJUwiso8uhNOLTP0PS52x0e2
         RmQA==
X-Gm-Message-State: AFqh2kr8gz9TT5gE2WiDLi3acFTEZ3dkncx9OhqsFvs3Qz1DidDYj4LI
        r42Y0hOV01p/ZqvPaC7k0gtyK3n9lxkN/v1FBOHi55n8qhZDiSUAQhhAVzmWNkmTo1mZDxJc9sb
        sQ2nWn4XSzl73OsYKqpo8FIoQ
X-Received: by 2002:a0c:f3ce:0:b0:531:7b1e:cdaa with SMTP id f14-20020a0cf3ce000000b005317b1ecdaamr56474332qvm.44.1672872732866;
        Wed, 04 Jan 2023 14:52:12 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvpKKemP1V8IrIbogqNKolIRqZbJHS4f3LCuRtRb0RPSmf1nkmMiOVux8MqIUMl3pEtxplS2A==
X-Received: by 2002:a0c:f3ce:0:b0:531:7b1e:cdaa with SMTP id f14-20020a0cf3ce000000b005317b1ecdaamr56474310qvm.44.1672872732634;
        Wed, 04 Jan 2023 14:52:12 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-39-70-52-228-144.dsl.bell.ca. [70.52.228.144])
        by smtp.gmail.com with ESMTPSA id r1-20020a05620a298100b006eeb3165565sm24654710qkp.80.2023.01.04.14.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:52:11 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-stable <stable@vger.kernel.org>
Subject: [PATCH 1/3] mm/hugetlb: Pre-allocate pgtable pages for uffd wr-protects
Date:   Wed,  4 Jan 2023 17:52:05 -0500
Message-Id: <20230104225207.1066932-2-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230104225207.1066932-1-peterx@redhat.com>
References: <20230104225207.1066932-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userfaultfd-wp uses pte markers to mark wr-protected pages for both shmem
and hugetlb.  Shmem has pre-allocation ready for markers, but hugetlb path
was overlooked.

Doing so by calling huge_pte_alloc() if the initial pgtable walk fails to
find the huge ptep.  It's possible that huge_pte_alloc() can fail with high
memory pressure, in that case stop the loop immediately and fail silently.
This is not the most ideal solution but it matches with what we do with
shmem meanwhile it avoids the splat in dmesg.

Cc: linux-stable <stable@vger.kernel.org> # 5.19+
Fixes: 60dfaad65aa9 ("mm/hugetlb: allow uffd wr-protect none ptes")
Reported-by: James Houghton <jthoughton@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bf7a1f628357..017d9159cddf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6649,8 +6649,17 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 		spinlock_t *ptl;
 		ptep = hugetlb_walk(vma, address, psize);
 		if (!ptep) {
-			address |= last_addr_mask;
-			continue;
+			if (!uffd_wp) {
+				address |= last_addr_mask;
+				continue;
+			}
+			/*
+			 * Userfaultfd wr-protect requires pgtable
+			 * pre-allocations to install pte markers.
+			 */
+			ptep = huge_pte_alloc(mm, vma, address, psize);
+			if (!ptep)
+				break;
 		}
 		ptl = huge_pte_lock(h, mm, ptep);
 		if (huge_pmd_unshare(mm, vma, address, ptep)) {
-- 
2.37.3

