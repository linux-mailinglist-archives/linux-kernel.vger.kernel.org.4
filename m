Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D014D646269
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiLGUcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiLGUbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:31:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED5130573
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 12:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670445051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PxW1+7FnblUXilUivNjEMBQoO6EpHq3+X52yjUcQpsM=;
        b=O2SbdXyZpKklrTHYxm5bTPaPWW5Yow3P1uLvnYHlM97GmfxL+QD7RDrcDdWDdp5zGbBpxg
        VJwEUQmAxILNB0/ArXSZdY0iN6JbbOv5u4MwIF3TL/GXmrQBBpAI4oeKFD1G6LYBkF185r
        ZGq8t4C2ZaVvhCIR6H/oYcuWre2MJZo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-vRZXXeIlPNW-QusS_hoOmw-1; Wed, 07 Dec 2022 15:30:48 -0500
X-MC-Unique: vRZXXeIlPNW-QusS_hoOmw-1
Received: by mail-qt1-f200.google.com with SMTP id cm12-20020a05622a250c00b003a521f66e8eso39653106qtb.17
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 12:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxW1+7FnblUXilUivNjEMBQoO6EpHq3+X52yjUcQpsM=;
        b=7s0vKwbZLDj+Z+EwORus8sT5GMdhxpqsPy9CuoB3iScVCeTbv+BuDorHGcQ61XWlMJ
         27SjLBd/tx9G5XguPTSJ26SO8oW7VV79pTas3h529ELqEsZGvtXSUcrT8GREfAqT9Tvt
         s28PpTFrgT8JZgTXMUGsBM+PoFe2w6xL6DVT4LWIQh6KAtthoEhG8d0CmHFETljLPZX+
         HaOqp1FbCw7Yg+IUYzPbT6hNQVxFYoAV4UdNNxKp4GfgF97YDCm9p0WjbCA93oDMLR5p
         nt5DYpTTB/M/GxifP0qb0pVE0pi8+KPk8RwCnZN33f3BgM3Lv3TE/1KwsAEHSYVssaij
         NzHQ==
X-Gm-Message-State: ANoB5pl9675HQOBQAKTOSHqtWQqrbbxhwL5kimG1ZMPT2gbNl2GIZ5X2
        9xQfXQQGZ/SHWDqF56aUqTh6+Rq5r2zn8+cE8rsBfzN17t5UnPdhT0g7hfu4lDYkhJr626xQNzR
        K348JMdD3Cr4iFI+9hzqmyMZz
X-Received: by 2002:a05:622a:1b1c:b0:3a6:a205:741f with SMTP id bb28-20020a05622a1b1c00b003a6a205741fmr1433034qtb.32.1670445047602;
        Wed, 07 Dec 2022 12:30:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4LgYx0Tk+k6P2vLtvZSUdKvr8Brzp1Zc7q0zTbDSasDnwn5BMIAU2eNX9tOidMqIznOg+0Lg==
X-Received: by 2002:a05:622a:1b1c:b0:3a6:a205:741f with SMTP id bb28-20020a05622a1b1c00b003a6a205741fmr1433023qtb.32.1670445047366;
        Wed, 07 Dec 2022 12:30:47 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id dc53-20020a05620a523500b006fefa5f7fcesm855594qkb.10.2022.12.07.12.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:30:47 -0800 (PST)
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
Subject: [PATCH v2 06/10] mm/hugetlb: Make hugetlb_follow_page_mask() safe to pmd unshare
Date:   Wed,  7 Dec 2022 15:30:30 -0500
Message-Id: <20221207203034.650899-7-peterx@redhat.com>
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

Since hugetlb_follow_page_mask() walks the pgtable, it needs the vma lock
to make sure the pgtable page will not be freed concurrently.

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 49f73677a418..3fbbd599d015 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6226,9 +6226,10 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	if (WARN_ON_ONCE(flags & FOLL_PIN))
 		return NULL;
 
+	hugetlb_vma_lock_read(vma);
 	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (!pte)
-		return NULL;
+		goto out_unlock;
 
 	ptl = huge_pte_lock(h, mm, pte);
 	entry = huge_ptep_get(pte);
@@ -6251,6 +6252,8 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	}
 out:
 	spin_unlock(ptl);
+out_unlock:
+	hugetlb_vma_unlock_read(vma);
 	return page;
 }
 
-- 
2.37.3

