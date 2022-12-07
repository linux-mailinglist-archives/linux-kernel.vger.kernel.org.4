Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4974B646267
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiLGUcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiLGUbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:31:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97C67BC28
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 12:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670445043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RTEeCRjKpb4wZGC2IHTK/YLghk1hCkfDBIBgYSHgVC0=;
        b=evZwOO/reQhgKX78m90wFfpYs0rFtY1fq+Cxif56xRNB+CUFF17eR/kzpN5JQzu/NfKv+S
        2/pU0BAM51YhINEEIzjPB+pZE7tRI3889YnCqAvVm3qXP1BDS+7qClDsau2YHodaZYp0ch
        iuLX4hhdq6x2WwIprAJh6v9iv5UToU0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-529-PasFPQGDPvi8z08cbKKKGA-1; Wed, 07 Dec 2022 15:30:41 -0500
X-MC-Unique: PasFPQGDPvi8z08cbKKKGA-1
Received: by mail-qv1-f69.google.com with SMTP id 71-20020a0c804d000000b004b2fb260447so37545241qva.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 12:30:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTEeCRjKpb4wZGC2IHTK/YLghk1hCkfDBIBgYSHgVC0=;
        b=PTF57sVXTgP3tc7wWW8Hgp+SMFzlIgBuVr0BR1C9Y2vAqvUTBuM8tHK2swcx9iFqiK
         IZ9gjWPAYEsJF6ymVB092+ekWBugygdQser10kg5uIRX+gw+zGLWm15FXsi05y3kHTZ5
         PiuQZSYOl+tnVT2MJAnKAVF/WNkzRvXKvPdikT9upZUUyCL2axDY5CelfMhGQvmipF/F
         6OSs91zbBRwbYie9juws87mTi/ILjkRk2VBDdeA/fsrN056zIdsg7glS5ZsJOTsnQ6q6
         4c4cKmLl6iRqXrl05mDJQsQaorEu7qGeJGP0hc/p1gM7+sZoboQxHRwgtokKtmKeuKVE
         IfaQ==
X-Gm-Message-State: ANoB5pkYxxohLOAJNIpFSCQ44P1sZbkQ+HEUdfvrhka3fRcn0FZ+6Gu1
        NrmJrenlK7Y06r4OHbdSGjcCC12Fdn995krOJbSqjjH1yaDat5m251bslX/fSM5ISbLT6uyINxa
        38wSwrjeyrIbr4nWf+H2b/x01
X-Received: by 2002:ac8:6b92:0:b0:3a6:8a53:b8ab with SMTP id z18-20020ac86b92000000b003a68a53b8abmr1339915qts.36.1670445041489;
        Wed, 07 Dec 2022 12:30:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4sNFnBMyehihPsNzLXJQMBLFYcojqEtB+STHm+CXTTITN32QZQYRMPzOE5zmyAwmPrrPQM7g==
X-Received: by 2002:ac8:6b92:0:b0:3a6:8a53:b8ab with SMTP id z18-20020ac86b92000000b003a68a53b8abmr1339904qts.36.1670445041289;
        Wed, 07 Dec 2022 12:30:41 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id dc53-20020a05620a523500b006fefa5f7fcesm855594qkb.10.2022.12.07.12.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:30:40 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH v2 02/10] mm/hugetlb: Don't wait for migration entry during follow page
Date:   Wed,  7 Dec 2022 15:30:26 -0500
Message-Id: <20221207203034.650899-3-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221207203034.650899-1-peterx@redhat.com>
References: <20221207203034.650899-1-peterx@redhat.com>
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

That's what the code does with !hugetlb pages, so we should logically do
the same for hugetlb, so migration entry will also be treated as no page.

This is probably also the last piece in follow_page code that may sleep,
the last one should be removed in cf994dd8af27 ("mm/gup: remove
FOLL_MIGRATION", 2022-11-16).

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1088f2f41c88..c8a6673fe5b4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6232,7 +6232,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	if (WARN_ON_ONCE(flags & FOLL_PIN))
 		return NULL;
 
-retry:
 	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (!pte)
 		return NULL;
@@ -6255,16 +6254,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 			page = NULL;
 			goto out;
 		}
-	} else {
-		if (is_hugetlb_entry_migration(entry)) {
-			spin_unlock(ptl);
-			__migration_entry_wait_huge(pte, ptl);
-			goto retry;
-		}
-		/*
-		 * hwpoisoned entry is treated as no_page_table in
-		 * follow_page_mask().
-		 */
 	}
 out:
 	spin_unlock(ptl);
-- 
2.37.3

