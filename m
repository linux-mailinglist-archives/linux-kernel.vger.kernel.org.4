Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B7F69FC84
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjBVTyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjBVTx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:53:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B248A46
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 11:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677095572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=t0NA5RenyfNbff5yQYPO5wNBBKMedrP9MogpxUVd1CU=;
        b=dIQVPY4PmII5FweOmT1FmXWiZtAVcnYV6BgLgSqErYR6UTWeeRMY/MS8wTC3B/ecs83fek
        c6Uw8cDYEUy2mIa073U4v36h8PwPe/EP+7w7cxvjc9R0ESD+lOGVcHGQzrUS7HkyGe8vsa
        SoCl+7P3DXIvH0BJqVQVE/S73o3r4YU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-600-amP0OJxMO4ym50rrLXvXNw-1; Wed, 22 Feb 2023 14:52:50 -0500
X-MC-Unique: amP0OJxMO4ym50rrLXvXNw-1
Received: by mail-qv1-f70.google.com with SMTP id pp11-20020a056214138b00b0056c228fa15cso3952504qvb.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 11:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0NA5RenyfNbff5yQYPO5wNBBKMedrP9MogpxUVd1CU=;
        b=drxttxUDrLSrqO3k7Ku/udxmd9LG+svZcYBhEClhNInyvjib86s7DREU4aWeheonN2
         ZNhS9CShqmJteNRd42ZXnD0Eue/4J4208WkB8Q/laeCv2fefhIMHd0t0RMgAlHcNXVWY
         B3vs94pG9N82S6xcmQlAiDMXb2aSekWE8Ny2t+UGV56ZPJwZaFovUR7KcIwM/dKDHlr7
         nI2Erz3CFncfNJ56mIWyBGp9jxpXNOvuFc6O37Eif5JnSs6HFRCJ5wkaggyhrCr9L6Bv
         3KGsNdMa0pQghlcDEit080Ho9LCBlmr5Lazet7VsK7tuk7yYXgHTbrqcHEBXHiGi+CXW
         YjkA==
X-Gm-Message-State: AO0yUKUQ+hu52k6CGXvsh5PffZ03QCkvusX0j9T4FsCytQ8eDcQeVVqp
        rddsosBDlg4SahhPws02L0LiQLYweZ+ktl0vUjiCvdVZEfuV4uO1k0UpN0NGlHxYDPN9z9woNwq
        x42sjgIzG0A4osJCniDTu86J2RunHok5bOfiKnupRqf8bE3kbN/IoL180rE8JEQPmNkElfXfEW4
        oeRbw=
X-Received: by 2002:a05:622a:1002:b0:3b8:5199:f841 with SMTP id d2-20020a05622a100200b003b85199f841mr16964421qte.0.1677095569917;
        Wed, 22 Feb 2023 11:52:49 -0800 (PST)
X-Google-Smtp-Source: AK7set+i8gH40eG4zEccagdjimlzOlZhlL8oGj47vXuvtA4JJ/FKzBVgYL6RseMyK3jse9jHsqIs0w==
X-Received: by 2002:a05:622a:1002:b0:3b8:5199:f841 with SMTP id d2-20020a05622a100200b003b85199f841mr16964375qte.0.1677095569503;
        Wed, 22 Feb 2023 11:52:49 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id f190-20020a37d2c7000000b00729b7d71ac7sm626022qkj.33.2023.02.22.11.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 11:52:48 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        David Stevens <stevensd@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH v2] mm/khugepaged: alloc_charge_hpage() take care of mem charge errors
Date:   Wed, 22 Feb 2023 14:52:47 -0500
Message-Id: <20230222195247.791227-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
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

If memory charge failed, instead of returning the hpage but with an error,
allow the function to cleanup the folio properly, which is normally what a
function should do in this case - either return successfully, or return
with no side effect of partial runs with an indicated error.

This will also avoid the caller calling mem_cgroup_uncharge() unnecessarily
with either anon or shmem path (even if it's safe to do so).

Cc: Yang Shi <shy828301@gmail.com>
Reviewed-by: David Stevens <stevensd@chromium.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v1->v2:
- Enhance commit message, drop "Fixes:" and "Cc: stable" tag, add R-bs.
---
 mm/khugepaged.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8dbc39896811..941d1c7ea910 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1063,12 +1063,19 @@ static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
 	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
 		     GFP_TRANSHUGE);
 	int node = hpage_collapse_find_target_node(cc);
+	struct folio *folio;
 
 	if (!hpage_collapse_alloc_page(hpage, gfp, node, &cc->alloc_nmask))
 		return SCAN_ALLOC_HUGE_PAGE_FAIL;
-	if (unlikely(mem_cgroup_charge(page_folio(*hpage), mm, gfp)))
+
+	folio = page_folio(*hpage);
+	if (unlikely(mem_cgroup_charge(folio, mm, gfp))) {
+		folio_put(folio);
+		*hpage = NULL;
 		return SCAN_CGROUP_CHARGE_FAIL;
+	}
 	count_memcg_page_event(*hpage, THP_COLLAPSE_ALLOC);
+
 	return SCAN_SUCCEED;
 }
 
-- 
2.39.1

