Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72ED262EAC0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240908AbiKRBLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240850AbiKRBLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:11:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485967A374
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668733835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U+Gtvi2x1OMFo8SBrSP3Pl5SiCw4KKSlLL8MzskCOZw=;
        b=baOfAKtrhbiKxjDPoeJnpmzl3rgMObZ3/3RbW8cuq5liAJNJOdPZ6yYUmX9NU5B9lOe40V
        n9WLw6+sCCoZdNX3QoISblZxD45imgFgVee7DlxO0OYPOcq8/m6n2iZs/ifGvio2f0Zsoi
        ZFHwSxxX3NJV/Ntg/8gui+FD+vxB/wM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-384-NEyy7AkfOFCENNnUAzmUdw-1; Thu, 17 Nov 2022 20:10:34 -0500
X-MC-Unique: NEyy7AkfOFCENNnUAzmUdw-1
Received: by mail-qt1-f198.google.com with SMTP id i13-20020ac8764d000000b003a4ec8693dcso3430361qtr.14
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:10:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+Gtvi2x1OMFo8SBrSP3Pl5SiCw4KKSlLL8MzskCOZw=;
        b=QeY/uynadGzZfLH8CGH1lMYDZZbe7/3+yf8MZIUVWdaOjKFaD07CIX8eSG5VhH7pM+
         DGvKXM4aFqzP+vujDbKqaXW8cGPPXJIrlKZ+U/eIlTN6lwNaFIUMA8SYoPdB5RMNnL+f
         yb4AP5xbLtqKdT0xNEygTolScf4mGbJPrxpOUvQDHQgrQLfaaVyPvwk+xMVCcfkUbMEc
         uIyWHlIgUljuSnIDcIq5PhRIfDPPM9dGH1B9l09THtSWXbmq1AFsAss44xG86MyJiQpd
         xlcbNUHC15N/9VEwsxOZ+c10Rf44loe1tng3CmNPUcr9zGf5Qq2xUFULzwzPWE9T7gvE
         Llpw==
X-Gm-Message-State: ANoB5pkI5OUoRI2cKtOHuar6YyipckCU96XTJmgyHW8P7dMhI6aLel5g
        0Ot1rsOEOlb5mTfNVIwYS+tEiK5nskyWTmu7cH8HQh3RLRJykIrxaxqxIPmT5csUd+g9hSqa/kl
        QQAe4zidfnRLA2Z/6ZezLSoE0
X-Received: by 2002:a05:6214:aab:b0:4bb:625c:e300 with SMTP id ew11-20020a0562140aab00b004bb625ce300mr4898431qvb.96.1668733833658;
        Thu, 17 Nov 2022 17:10:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6NCzhzda4Hbt+DXca7JaSEwUx4nLg4wsJGPVAjeHHodiz4M9R0WBhRFqNCAHbtCQKOIPJeFg==
X-Received: by 2002:a05:6214:aab:b0:4bb:625c:e300 with SMTP id ew11-20020a0562140aab00b004bb625ce300mr4898416qvb.96.1668733833478;
        Thu, 17 Nov 2022 17:10:33 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a430700b006eed75805a2sm1491342qko.126.2022.11.17.17.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:10:33 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH RFC v2 03/12] mm/hugetlb: Don't wait for migration entry during follow page
Date:   Thu, 17 Nov 2022 20:10:16 -0500
Message-Id: <20221118011025.2178986-4-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221118011025.2178986-1-peterx@redhat.com>
References: <20221118011025.2178986-1-peterx@redhat.com>
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
index 62ff3fc51d4e..61a1fa678172 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6222,7 +6222,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	if (WARN_ON_ONCE(flags & FOLL_PIN))
 		return NULL;
 
-retry:
 	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (!pte)
 		return NULL;
@@ -6245,16 +6244,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
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

