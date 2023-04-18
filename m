Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DEE6E6CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjDRTN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjDRTNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:13:33 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A268A10240
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:23 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id m16so18343888qvx.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845202; x=1684437202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5SnIlaO0rXlDNrbIipd1QFsl3Kwll1/DWWk9w0ZS8w=;
        b=phgXjhYwXg3OCGPRKhBvTgFcaFQYHSKs8TQycpKy6Vj7NYOeHax3ZHG4ro7qbt6UuA
         JF51v3B18zEUVvZDZnNNDBXHiS2b6Tq1HXFiJxKw9p+6Mx89Rgd2RJU/zsjn7vLY241i
         MKeUzmB5AHKtmXkf4hDMRr20OIpBEF+bV8qpHw5olo3beiyALYxqKqMbkp/HbNpGk7NJ
         ukwixb6eSH0cNmhdMS8bZQt3NGWA7C/bL+/YY6wI83+dKvJxLNBr78X4ennNHHmOj0Yt
         5r4Yf3GUa7UROctvzCXAsXuKLK1G6qtC30yjMZWjnRlXK/bEWWb7onJzOj7tlzRdljt6
         Babg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845202; x=1684437202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5SnIlaO0rXlDNrbIipd1QFsl3Kwll1/DWWk9w0ZS8w=;
        b=dIknDFQVR6vUzCvpYWi8Y701gfHBviXYqAp11IB0Mz1I3LMGFQq3J/3eJFwSenRwnJ
         dykKRAnDEWH/9Ow/BG7ZiCSk6QqLedBynqpEy/MvYh3+p9auFW8PBvcYblIMU/Sh9S0Z
         u7Ua8QHsH6lYCXtpZ8THbuISlB/dk0VGDSBr89OacSue/ONxKKjbu/ZxiGWenPKIyS+g
         8W+ON+pn1TPN8XLfRJrKHPX108bOfLWXZxn5bzKZL9Z90blKBvJHhaPyedEv0ZbcQuLe
         X0LjVXR8hJyhqDyVyc59BB1G9WRnRY561+zoz/yVioyNTuvR3P/X8R2Ufdd7FvXUasXT
         m20Q==
X-Gm-Message-State: AAQBX9e6Wm+jCt9x19ersY7ORJvkZ3aFno1dLdiIrFq46f0wYPEMDG40
        GMAAHWW9pVt27hjijxk6UCQcsTqmV7tK7zh3f+I=
X-Google-Smtp-Source: AKy350b9afMxBv6edVSpodj5/I8/s1MMj3kTb89vTQ4djsDWn/SVzn9x9uBL9GyIXdZ9FhPbmcE+vA==
X-Received: by 2002:a05:6214:20ed:b0:5c5:c835:c8f1 with SMTP id 13-20020a05621420ed00b005c5c835c8f1mr25959976qvk.22.1681845202760;
        Tue, 18 Apr 2023 12:13:22 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id o5-20020a0cc385000000b005ef4ee791casm3855524qvi.120.2023.04.18.12.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:22 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 03/26] mm: make pageblock_order 2M per default
Date:   Tue, 18 Apr 2023 15:12:50 -0400
Message-Id: <20230418191313.268131-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418191313.268131-1-hannes@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pageblock_order can be of various sizes, depending on configuration,
but the default is MAX_ORDER-1. Given 4k pages, that comes out to
4M. This is a large chunk for the allocator/reclaim/compaction to try
to keep grouped per migratetype. It's also unnecessary as the majority
of higher order allocations - THP and slab - are smaller than that.

Before subsequent patches increase the effort that goes into
maintaining migratetype isolation, it's important to first set the
defrag block size to what's likely to have common consumers.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/pageblock-flags.h | 4 ++--
 mm/page_alloc.c                 | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index 5f1ae07d724b..05b6811f8cee 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -47,8 +47,8 @@ extern unsigned int pageblock_order;
 
 #else /* CONFIG_HUGETLB_PAGE */
 
-/* If huge pages are not used, group by MAX_ORDER_NR_PAGES */
-#define pageblock_order		(MAX_ORDER-1)
+/* Manage fragmentation at the 2M level */
+#define pageblock_order		ilog2(2U << (20 - PAGE_SHIFT))
 
 #endif /* CONFIG_HUGETLB_PAGE */
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ac03571e0532..5e04a69f6a26 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7634,7 +7634,7 @@ static inline void setup_usemap(struct zone *zone) {}
 /* Initialise the number of pages represented by NR_PAGEBLOCK_BITS */
 void __init set_pageblock_order(void)
 {
-	unsigned int order = MAX_ORDER - 1;
+	unsigned int order = ilog2(2U << (20 - PAGE_SHIFT));
 
 	/* Check that pageblock_nr_pages has not already been setup */
 	if (pageblock_order)
-- 
2.39.2

