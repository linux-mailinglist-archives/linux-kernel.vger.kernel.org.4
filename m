Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B2664D0E8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiLNUPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiLNUOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:14:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0072C2DAB7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671048301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OjnVrIvGwtoddEojvu7v3r8jpkJLbQV8Ta0gkZnxU7g=;
        b=dJMiGNc5korgFkTz8aGwAU42B8noZ1NRT0OpwRv1k4ybyzgk8yBL2oPhRi4km9yHWJaNiM
        rNzbknOiCRylkAzY41gn+UOlUaOt9VYiIQWUw1RdtKevrljCVHcW8SkPfelMAVw/6sm//6
        mQDJWWmjSPJWl8/sPK+QH1eErz3iHeU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-170-45_FoOZWMe65xOXVc74Q7A-1; Wed, 14 Dec 2022 15:05:00 -0500
X-MC-Unique: 45_FoOZWMe65xOXVc74Q7A-1
Received: by mail-qv1-f69.google.com with SMTP id 71-20020a0c804d000000b004b2fb260447so543160qva.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:04:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjnVrIvGwtoddEojvu7v3r8jpkJLbQV8Ta0gkZnxU7g=;
        b=4mEXmQIgeuGlANXYDE2tfcuP2jGU9cxpyznOTGocsY9cy6LbAE3/PiK7whfYAzlm2h
         qF+FjGjh1ntZzTfoTO/tGoS6v+imLHdDOCUd4rtpOwWeIxk5TUBeaNxOcAP54sf7OMtZ
         Rm8d8uZxnS151NIkKOlDo6LVo4SjlSVUKQbSod4OlAxQ7GuL/Hb2zAeE3HsGyg60EatY
         JghgMyyzMxNWgtCAcami2km6RO5C4A6a9RUOdpP3S5q+M7SPRaabrLjDhwgW8UviIadw
         2+BHzzICtfjElo2Xi3VCd7HLot9oFnOGd/VDKikBbrGQ+sP6vdNZTSFoHI0P7smcTasd
         sPOA==
X-Gm-Message-State: ANoB5pmgNtx8mNyr1Oa8pRZDJti+O09AhvUtkTfEf9aWSoasVs6pBdUc
        dqP3s5TrvJ+QYRCFPaRW7K+HkpRqegbTI4WXRdSO1N+HqSBmPZ8l/xg4TVKFQmBf6+4BJxyIGRq
        LkJqkJgSqKkH5/4jHpMzTkPJQUJ+ss7uuWgLBC1b751obMzny7XiFNWGMetnNB8Mm3iCXqZlXIA
        ==
X-Received: by 2002:ac8:7a92:0:b0:3a8:234a:3204 with SMTP id x18-20020ac87a92000000b003a8234a3204mr11410979qtr.23.1671048298425;
        Wed, 14 Dec 2022 12:04:58 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6Nke0YvpERN8PSGIEPS7iAy63OPrfTbIIMSElRjL9bJJczmgiRGIt2KezRj+ugUt12mbA1aQ==
X-Received: by 2002:ac8:7a92:0:b0:3a8:234a:3204 with SMTP id x18-20020ac87a92000000b003a8234a3204mr11410949qtr.23.1671048298123;
        Wed, 14 Dec 2022 12:04:58 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id l11-20020ac848cb000000b003a689a5b177sm2199352qtr.8.2022.12.14.12.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 12:04:57 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Huang Ying <ying.huang@intel.com>, stable@vger.kernel.org
Subject: [PATCH 1/2] mm/uffd: Fix pte marker when fork() without fork event
Date:   Wed, 14 Dec 2022 15:04:52 -0500
Message-Id: <20221214200453.1772655-2-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221214200453.1772655-1-peterx@redhat.com>
References: <20221214200453.1772655-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fork(), dst_vma is not guaranteed to have VM_UFFD_WP even if src may
have it and has pte marker installed.  The warning is improper along with
the comment.  The right thing is to inherit the pte marker when needed, or
keep the dst pte empty.

A vague guess is this happened by an accident when there's the prior patch
to introduce src/dst vma into this helper during the uffd-wp feature got
developed and I probably messed up in the rebase, since if we replace
dst_vma with src_vma the warning & comment it all makes sense too.

Hugetlb did exactly the right here (copy_hugetlb_page_range()).  Fix the
general path.

Reproducer:

https://github.com/xupengfe/syzkaller_logs/blob/main/221208_115556_copy_page_range/repro.c

Cc: <stable@vger.kernel.org> # 5.19+
Fixes: c56d1b62cce8 ("mm/shmem: handle uffd-wp during fork()")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216808
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index aad226daf41b..032ef700c3e8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -828,12 +828,8 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			return -EBUSY;
 		return -ENOENT;
 	} else if (is_pte_marker_entry(entry)) {
-		/*
-		 * We're copying the pgtable should only because dst_vma has
-		 * uffd-wp enabled, do sanity check.
-		 */
-		WARN_ON_ONCE(!userfaultfd_wp(dst_vma));
-		set_pte_at(dst_mm, addr, dst_pte, pte);
+		if (userfaultfd_wp(dst_vma))
+			set_pte_at(dst_mm, addr, dst_pte, pte);
 		return 0;
 	}
 	if (!userfaultfd_wp(dst_vma))
-- 
2.37.3

