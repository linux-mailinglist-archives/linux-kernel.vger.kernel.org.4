Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFC064626E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiLGUdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiLGUdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:33:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C907E40B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 12:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670445122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJ6TW2E1hLLncShjpLbEpjeIsJ0SxMbIuMnmoV2Wa4Y=;
        b=iC7vgpMD1kprpPJTbKrRyUt3svh17KKgXEa/L3QmSGYlHFLn5DPIs5YYg3IDRDvsC9643J
        Bp5b5a3GiA4/E/fI7Ir1alKClmjdETTQVhkdcpKsMc3JYNPb8fjbG+JO3RFVoeFcjT2TO6
        Drg9L25wi3K1gZNMP1QY2DsK57xU/4w=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-526-TThzOUmoOVa49-e_Ar_Mew-1; Wed, 07 Dec 2022 15:32:01 -0500
X-MC-Unique: TThzOUmoOVa49-e_Ar_Mew-1
Received: by mail-qv1-f72.google.com with SMTP id 71-20020a0c804d000000b004b2fb260447so37549156qva.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 12:32:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJ6TW2E1hLLncShjpLbEpjeIsJ0SxMbIuMnmoV2Wa4Y=;
        b=xZg0+5I8pd3k9ZKQY/Ut8S4jSnK+Op4a9wLCqSv4U1qLqE64G+HrSc85Lv7iah8W4E
         gwibX+dcUtcbxgFbGr4xMI1EzAZ4AnIxmS6/xrbuRv3iXRc6UC3n33GZNH6La4fp3Hfo
         WPxaS+K/9wpNpFvrCsTeti5NspNIAFOCSnnB3GHx1cB/lhfJGsTylyGMsxdavZZuqUlK
         Ynrh0k1qhcq8VDaRUIqM2o3JjD6LwfifVXHy3k3YDBYV0rSnB/fOOushvAchzGQd8GAA
         a9TCr7Ip3SuiymPl80T9bRLNBwQ/jcNZl/bebRGeCfPt8gjWcRqP3aMnSL9ssHliv1f6
         PYDg==
X-Gm-Message-State: ANoB5pm0Tn0Zwob6Y5Ai1538JLZlWdIO+sIwahFlX8G9k2ols7AetQ2G
        d4Oe1GQxVuyvda4epCxEZne9OOYRJnJ7J0wUJULFfzutcDJ47OPZfm48D0iike754TAWAmdxsXX
        REPG4Y5aR9eHn4XMT2haEqaRn
X-Received: by 2002:ad4:4709:0:b0:4c7:629e:7a70 with SMTP id qb9-20020ad44709000000b004c7629e7a70mr1636771qvb.44.1670445120725;
        Wed, 07 Dec 2022 12:32:00 -0800 (PST)
X-Google-Smtp-Source: AA0mqf55/5Slqm2ol0UT7nKwE62yK11661Qb4rAHiirqSdnnW+OXObDyf5lhkoXKQEtl720joxSvoQ==
X-Received: by 2002:ad4:4709:0:b0:4c7:629e:7a70 with SMTP id qb9-20020ad44709000000b004c7629e7a70mr1636758qvb.44.1670445120489;
        Wed, 07 Dec 2022 12:32:00 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bm8-20020a05620a198800b006fa8299b4d5sm18007118qkb.100.2022.12.07.12.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:32:00 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 10/10] mm/hugetlb: Document why page_vma_mapped_walk() is safe to walk
Date:   Wed,  7 Dec 2022 15:31:58 -0500
Message-Id: <20221207203158.651092-1-peterx@redhat.com>
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

Taking vma lock here is not needed for now because all potential hugetlb
walkers here should have i_mmap_rwsem held.  Document the fact.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/page_vma_mapped.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index e97b2e23bd28..2e59a0419d22 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -168,8 +168,14 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		/* The only possible mapping was handled on last iteration */
 		if (pvmw->pte)
 			return not_found(pvmw);
-
-		/* when pud is not present, pte will be NULL */
+		/*
+		 * NOTE: we don't need explicit lock here to walk the
+		 * hugetlb pgtable because either (1) potential callers of
+		 * hugetlb pvmw currently holds i_mmap_rwsem, or (2) the
+		 * caller will not walk a hugetlb vma (e.g. ksm or uprobe).
+		 * When one day this rule breaks, one will get a warning
+		 * in hugetlb_walk(), and then we'll figure out what to do.
+		 */
 		pvmw->pte = hugetlb_walk(vma, pvmw->address, size);
 		if (!pvmw->pte)
 			return false;
-- 
2.37.3

