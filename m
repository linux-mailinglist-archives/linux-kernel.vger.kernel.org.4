Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE9E60EEC5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 05:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbiJ0Dkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 23:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiJ0Dkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 23:40:39 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DD13678B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 20:40:35 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v13-20020a17090a6b0d00b0021332e5388fso279177pjj.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 20:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cQ9qt2H3+WuvBDHbHWfbVWKejzzW1xGSnc9xon7GeGI=;
        b=FaoEaSwlAKXHzt5NDkPv7b9UEtVtJhvIN56rMLqPNM3XuAhzxE3Ei63sYPl2OrwrkN
         A4MQk9Xrdt/lOC2aAZcuN3BS4t54cOa1H1p8N0/O5Fmzg2fBGYyGBOuI5/NJCPJnL2+6
         MO9VW9L+aYJZs/TGB/pMiRjfeWoE+ijnC0GhZ/3sr1mA91RRTRv8xVODy4FCHzi+tuo2
         WznBDEAnmtOHuNCWLPYwBJCC1LaAwdT48uiZFRKBePpWF8fZTEpv4Scu4BThRLyUniWQ
         Kj5/CXzunWXCGrie3wHXkqu7We+4/F9wOt6Dj/kCJcGEb7W8NAZ9WGGOxQX8Q+7uFTJV
         wEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQ9qt2H3+WuvBDHbHWfbVWKejzzW1xGSnc9xon7GeGI=;
        b=42mJhYhxdjdvGOI3mLtT5F8KTLUYrptG4260inUAPdqjWGOHd6XwizeRfd3TY703W8
         UiRPuB71mKzjSVIN9blFcPVzUZMfql0dlhWPHcLKPeE0HGPqk9jZT0jQcJKOcOr2cvtC
         rkv+CiKS/HiQBGkXPowaI3+nOWiKvg40KOPkFWPxV7CAehe90YWtmee/qQEb968EnZXf
         BS03kxhcw6OH1mYUSjpdFpFzor0YMlOusZRtue3qQ2nB5MRQbFuRXLGYoU+45vPowWXs
         CO1VYcajpGAE4WDVyx/UwRM2WmHdvzuDgcPDs3VH8HWq1bHr6bjGNFxjvZCyobgUeA3F
         IyNQ==
X-Gm-Message-State: ACrzQf3W5q5tQYvKg/KtbDO7tmB+OKCNGIyN3xo/ZfQz049GCuG5XghT
        NVKjWJQzex2gScwgu3/J+lPH8A==
X-Google-Smtp-Source: AMsMyM4nzx+dOJeoCczfkVX6U6DE7vTgCCa02oK34VCx0Yfw+ZJQaGmQQloH4emVoeArvPpn+80ELA==
X-Received: by 2002:a17:90a:4607:b0:202:e22d:489c with SMTP id w7-20020a17090a460700b00202e22d489cmr7976237pjg.80.1666842034853;
        Wed, 26 Oct 2022 20:40:34 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902f14d00b00176ab6a0d5fsm98877plb.54.2022.10.26.20.40.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Oct 2022 20:40:34 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: hugetlb_vmemmap: remove redundant list_del()
Date:   Thu, 27 Oct 2022 11:36:41 +0800
Message-Id: <20221027033641.66709-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ->lru field will be assigned to a new value in __free_page().
So it is unnecessary to delete it from the @list.  Just remove it
to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 20f414c0379f..c98805d5b815 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -231,10 +231,8 @@ static void free_vmemmap_page_list(struct list_head *list)
 {
 	struct page *page, *next;
 
-	list_for_each_entry_safe(page, next, list, lru) {
-		list_del(&page->lru);
+	list_for_each_entry_safe(page, next, list, lru)
 		free_vmemmap_page(page);
-	}
 }
 
 static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
-- 
2.11.0

