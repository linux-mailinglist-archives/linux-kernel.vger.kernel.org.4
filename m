Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C363664C0DE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbiLMXq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbiLMXqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:46:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C4A19C3B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670975116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DVhb72kd9R99mwbuxV0gpxyvFBS7R/Jb7x2Bq+94b50=;
        b=hDkYAJFABz/c+uzTQ3YCO5IQP/VE6wn2mWBTYgAgVT4qcxGDjOPSDxZfkBZMrToDm6Rvjq
        c6v7DNwU/hH+VBYArk8ALr+fsyhuQJU6qUxLZHb57tR3ml33JK2PwxfabgUFJlujTNcIj1
        ZEQZQPwLz5V+PgHSi4m+ERp9oTf7jT4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-FE8nIjigNqSvYgEBCMkZsw-1; Tue, 13 Dec 2022 18:45:13 -0500
X-MC-Unique: FE8nIjigNqSvYgEBCMkZsw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCAA1803533;
        Tue, 13 Dec 2022 23:45:12 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.32.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37F894085720;
        Tue, 13 Dec 2022 23:45:12 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     muchun.song@linux.dev, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, willy@infradead.org,
        gerald.schaefer@linux.ibm.com
Subject: [RFC V2] mm: add the zero case to page[1].compound_nr in set_compound_order
Date:   Tue, 13 Dec 2022 16:45:05 -0700
Message-Id: <20221213234505.173468-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 1378a5ee451a ("mm: store compound_nr as well as
compound_order") the page[1].compound_nr must be explicitly set to 0 if
calling set_compound_order(page, 0).

This can lead to bugs if the caller of set_compound_order(page, 0) forgets
to explicitly set compound_nr=0. An example of this is commit ba9c1201beaa
("mm/hugetlb: clear compound_nr before freeing gigantic pages")

Collapse these calls into the set_compound_order by utilizing branchless
bitmaths [1].

[1] https://graphics.stanford.edu/~seander/bithacks.html#ConditionalSetOrClearBitsWithoutBranching

V2: slight changes to commit log and remove extra '//' in the comments

Signed-off-by: Nico Pache <npache@redhat.com>
---
 include/linux/mm.h | 6 +++++-
 mm/hugetlb.c       | 6 ------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6a05a3bc0a28..9510f6294706 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -938,9 +938,13 @@ static inline int head_compound_pincount(struct page *head)
 
 static inline void set_compound_order(struct page *page, unsigned int order)
 {
+	unsigned long shift = (1U << order);
 	page[1].compound_order = order;
 #ifdef CONFIG_64BIT
-	page[1].compound_nr = 1U << order;
+	// Branchless conditional:
+	// order  > 0 --> compound_nr = shift
+	// order == 0 --> compound_nr = 0
+	page[1].compound_nr = shift ^ (-order  ^ shift) & shift;
 #endif
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3d9f4abec17c..706dec43a6a2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1344,9 +1344,6 @@ static void __destroy_compound_gigantic_page(struct page *page,
 	}
 
 	set_compound_order(page, 0);
-#ifdef CONFIG_64BIT
-	page[1].compound_nr = 0;
-#endif
 	__ClearPageHead(page);
 }
 
@@ -1865,9 +1862,6 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
 		__ClearPageReserved(p);
 	}
 	set_compound_order(page, 0);
-#ifdef CONFIG_64BIT
-	page[1].compound_nr = 0;
-#endif
 	__ClearPageHead(page);
 	return false;
 }
-- 
2.38.1

