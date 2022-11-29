Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A0C63C88E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbiK2Thv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbiK2ThE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:37:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7088B5B865
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669750535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=069LEwdmpjbCoEgrG7X25LyQKpeCovMtZOQCiu77QNo=;
        b=Rfxez/FP9JJaudHFIXy4W5UtTsBr5aMRRqpt4QbucuzCXp2qwJtSb/RckuK3/fRrxeZE3c
        EwWofrqsM26KyfSP663WyWgCTDrrFr4qXnKAhd7oFht7VDx4yCwmfa6zN4gIsk9T2x8I2j
        446K7zzGYtN/mhIsTZInKoShtPwYTrs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-115-dgg8WBogPbebm8-WkaycRQ-1; Tue, 29 Nov 2022 14:35:34 -0500
X-MC-Unique: dgg8WBogPbebm8-WkaycRQ-1
Received: by mail-qk1-f198.google.com with SMTP id v7-20020a05620a0f0700b006faffce43b2so30637050qkl.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=069LEwdmpjbCoEgrG7X25LyQKpeCovMtZOQCiu77QNo=;
        b=PprMjNl2kr8/RPwgLp7H19MEUsnQo1bffNVKGPnmJESYTs2RJNj43xwpv/H8rUJbq4
         QMKVJloqJ4nh9hukGVVsc7apZrUEJ19tuBtdl+/P5jUzFs5/nzjAd3W+DpdLsjrs9DTF
         tQhDDlh7Jk2dq0U2Arp59ee6QzywZ2EmW8VgfsfUDVxQV4tBsFNOS19sNT5bD3/rY7Ou
         nPpPBSObIQiDoI473Z4HkYTzXT3RR+2VIRDxf4jbwQeK2Ud7hr64lrA7WZNxbCQQ2v60
         XHKlB1NOJ2CQaEPH3sfQuyqVT1bxkAR0OdovQW9rhTKSPuFiXg4tTbh8LqGZD6Pf2aWX
         Y5tA==
X-Gm-Message-State: ANoB5pnvrBlmCf7tCektNwRwcjt5k+RSJ4+i9IDEW1E/3x0KctuHfY1h
        D0Vz0JbCxYOSemSeS4B782ZhAYBuS8Xwqm6+vG9YX+I8tubESDDxPhZKKwPSPL24DYCyRzO1RjB
        t1i4hv5S9iN+WkvfCOAEMvxg2
X-Received: by 2002:a05:6214:3b0b:b0:4c6:fb71:d337 with SMTP id nm11-20020a0562143b0b00b004c6fb71d337mr12678553qvb.110.1669750533675;
        Tue, 29 Nov 2022 11:35:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4LlhV6iVquMdiRB0LITiL37rfEs8kARYiG6upAcjW7OrRevlCH3PouYPzzz2q3p48laJLCeg==
X-Received: by 2002:a05:6214:3b0b:b0:4c6:fb71:d337 with SMTP id nm11-20020a0562143b0b00b004c6fb71d337mr12678530qvb.110.1669750533458;
        Tue, 29 Nov 2022 11:35:33 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id n1-20020a05620a294100b006fa16fe93bbsm11313013qkp.15.2022.11.29.11.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 11:35:33 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 02/10] mm/hugetlb: Don't wait for migration entry during follow page
Date:   Tue, 29 Nov 2022 14:35:18 -0500
Message-Id: <20221129193526.3588187-3-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221129193526.3588187-1-peterx@redhat.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9d97c9a2a15d..dfe677fadaf8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6234,7 +6234,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	if (WARN_ON_ONCE(flags & FOLL_PIN))
 		return NULL;
 
-retry:
 	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (!pte)
 		return NULL;
@@ -6257,16 +6256,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
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

