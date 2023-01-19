Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB27674BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjATFTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjATFTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:19:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F35C4E88
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:08:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B03D5B821A9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73BCC433D2;
        Thu, 19 Jan 2023 11:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674127165;
        bh=AHRTvCqcDRguckzlPkzDt+9TRgs80cyxqkFM/YPHV7o=;
        h=From:To:Cc:Subject:Date:From;
        b=mr6N/Gc1WC1pfdDU+E3cH/JuHYj74oI2DxlcPM8GbYV2NquDGomHGTrr6gzPGL1NW
         cbyothn/+4lhwaltHb5T5xso1/6BpcEIKtoB4Imynmftnh0AMnJ5A7tHPrJkmu7sOr
         Y9206pb9QBDkxFs2ESv/q5cIidJWn6jreRXaSFqT2ZLfnEXlmo0RNY6W+6WOr8/lMb
         jUT0F7vwy3UxM8E9kg4DZlQ6CmQIz34+SpfJm881EachTteJphCYY8xpnBBtDv2rc1
         1M5fEYR+RNyffmYPoji+m1TnlSDDcFSsdbAxPVnwNFa1cAoytbAGf018JvPcCI89f8
         ifXdCkIayrKyw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Peter Xu <peterx@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/hugetlb: fix get_hwpoison_hugetlb_folio() stub
Date:   Thu, 19 Jan 2023 12:19:12 +0100
Message-Id: <20230119111920.635260-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The folio conversion patch only changed one of the two implementations,
the empty stub one still needs the corresponding change:

mm/memory-failure.c: In function '__get_hwpoison_page':
mm/memory-failure.c:1335:15: error: implicit declaration of function 'get_hwpoison_hugetlb_folio'; did you mean 'get_hwpoison_huge_page'? [-Werror=implicit-function-declaration]
 1335 |         ret = get_hwpoison_hugetlb_folio(folio, &hugetlb, false);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |               get_hwpoison_huge_page

Fixes: 92e109a2c5a7 ("mm/hugetlb: convert get_hwpoison_huge_page() to folios")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/hugetlb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f14a6bd2a6ed..06eb59711e4a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -417,7 +417,7 @@ static inline int isolate_hugetlb(struct folio *folio, struct list_head *list)
 	return -EBUSY;
 }
 
-static inline int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison)
+static inline int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison)
 {
 	return 0;
 }
-- 
2.39.0

