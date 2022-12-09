Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D665364872F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiLIRC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiLIRCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:02:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D8A14D13
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670605285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QzeyNG+xisx8vPYcMzT01YLXY3V0nLFHTQTVfPkpFHw=;
        b=egPMxOEL9VEKTZCHwGQlHUDVy1Qj4DNJlAz6zvnBvfNqmv0fU4nUSA7iVaxqxZka0v5AJ+
        AfN1256Jb70mOjXsRX9X8bYTaRwr1cU/61/wSgo6pE5iGnvknIJ5GE28e1yA+ioEFxRITp
        bOi5JxY0p+Sb8rBg1+9IcXZbkuZZgc8=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-672-SWK1_QJZMOyDYZOZg4M2QQ-1; Fri, 09 Dec 2022 12:01:24 -0500
X-MC-Unique: SWK1_QJZMOyDYZOZg4M2QQ-1
Received: by mail-ua1-f72.google.com with SMTP id z44-20020a9f372f000000b00390af225beaso2088206uad.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:01:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzeyNG+xisx8vPYcMzT01YLXY3V0nLFHTQTVfPkpFHw=;
        b=FLdwDIQvnhZWV2UuoIYMU83iH0Qoo16E80/mF2zaZ+i0wAIeG73odeMFU09nIBg/q6
         QHbFtEBl/IOHkPoEqaGatWIxXRNtVUvZWsDN9g2Yz1kPfBEW3nWHNmWq/OSvSjLvODlb
         JekakgLLUA3wLZEhcq0BbShEtjMI7pi4IKja8A66PqXfHoQ5w7aCXBjp4jKFPhzdy52Q
         RvYdVwwJG40MbV1d1YN0p4yOaBxgRg7j64SbP02+fLf0VsPQwCodR6ZKVRKIEo9dstm6
         z8E0UhQF2sxKlavuSg/DdOtSLhsNOLuCBd28X2rFG8v7t+Ota59KYMZerhtgIvnDA8zF
         7DOA==
X-Gm-Message-State: ANoB5plNsYQcjtbTZyXNpvm5yapsnS/9e/1YfWN/vjt70PuR7wS/B7Ov
        v/xQFya8u7wWst7OEIRZwRJYCvNu4RbuswG3CvePoTkQKMhGAxaY+2OR6ftYluBR3YX1kjgGTyT
        pmebaBVjEG8YeoMyz515Ms8x3
X-Received: by 2002:a1f:ee4e:0:b0:3bd:f324:5500 with SMTP id m75-20020a1fee4e000000b003bdf3245500mr3198331vkh.2.1670605283871;
        Fri, 09 Dec 2022 09:01:23 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5nmOoaLlqHDusb7JXaz8VNhkWlW4brwxUYuPvukkJNtkEIbapa5We/uBYiNWEM3SCaE8rMvQ==
X-Received: by 2002:a1f:ee4e:0:b0:3bd:f324:5500 with SMTP id m75-20020a1fee4e000000b003bdf3245500mr3198279vkh.2.1670605283615;
        Fri, 09 Dec 2022 09:01:23 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id q7-20020a05620a0d8700b006cf38fd659asm178907qkl.103.2022.12.09.09.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:01:22 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 6/9] mm/hugetlb: Make hugetlb_follow_page_mask() safe to pmd unshare
Date:   Fri,  9 Dec 2022 12:00:57 -0500
Message-Id: <20221209170100.973970-7-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221209170100.973970-1-peterx@redhat.com>
References: <20221209170100.973970-1-peterx@redhat.com>
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
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 247702eb9f88..e3af347470ac 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6227,9 +6227,10 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	if (WARN_ON_ONCE(flags & FOLL_PIN))
 		return NULL;
 
+	hugetlb_vma_lock_read(vma);
 	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (!pte)
-		return NULL;
+		goto out_unlock;
 
 	ptl = huge_pte_lock(h, mm, pte);
 	entry = huge_ptep_get(pte);
@@ -6252,6 +6253,8 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	}
 out:
 	spin_unlock(ptl);
+out_unlock:
+	hugetlb_vma_unlock_read(vma);
 	return page;
 }
 
-- 
2.37.3

