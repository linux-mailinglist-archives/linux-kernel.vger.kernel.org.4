Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0E364F551
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiLPXrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLPXrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:47:43 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B1C2CCA3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:47:42 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id ja17so2881595wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YKCtj2GItVn5vwBA55ZwLozGerWg+NJMZ6sxZgOdjMw=;
        b=RQ4om1iHJz9UV/iaR/HjPgpl0yqpoyE4rl9RgvBzTe5x3j+U4SQs0vuQtyXkhTWrOi
         rkqBsfT2eTos1yGxzvFmYJQ8hfhCKV0tQpd1qIEFAh5X87d9hEWgMqgTzLBgRpAnT5fa
         ltMAj1Zpvrik6wFz9/XIJ7mB3saNJMd/rH2W02JE2wdMZxKMoLQDt1AfQE8udqOZGiQs
         0QDdgoi9KzMTPhMgr1+y+05ZhZrj8rkOJ3vGjcJ3x+sGChnUxtd8lEAJYsUCYa9BaZ1T
         Cg6BItPZnffnwPneQzdZR89P5dQHl851qzje1idgA5NzQAX3bGfaO8/ynradFA3dS9ob
         Ug3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKCtj2GItVn5vwBA55ZwLozGerWg+NJMZ6sxZgOdjMw=;
        b=2N6U4ILoIV/32TkoXI8oBbvF2r0RHZ3BjVZMMN7pvw8gJ/OGAp2uBTAM4Px9QA3XPj
         xMVkCY/AShCoYDK5guMmK1DJF0iowBMCpCO7PlVkrH2gb6elyeb4UdLnc6VjyXe2PzH5
         QiWfbg3rX+CAdnTXi3CZSG0++9ERuzlawBGDc2nV6gxN/d7mPZhm1kGiOVfsbbWy33wn
         YPnLK+rv2fepzK7arZqZEZ2V16mk/9E+O+obEQjP84sNWTEfjmynUCfh2DHpeWPW/MKI
         heK5dV45KmCSPq5+GUAnyMEI47Ey9zIe6UFxvxnMgQoKP6itiE+tpmctDMJJ6UVA6Ts+
         CYeg==
X-Gm-Message-State: ANoB5pmsm0a4H6prVzbp9oWNY/TcTTxEVdT8UWsMEop2JEKCwg6KKUZ+
        EkZV/xeIPoFLVwiPCqty5d0=
X-Google-Smtp-Source: AA0mqf7HMHTbeA3MM1mVyYjnJdlEPY0HsVdj4nFPmJwiDRjbfsC+3BE20Gmz5xwLvfwT33vdVwPi0w==
X-Received: by 2002:a05:600c:35c4:b0:3cf:85f7:bbc4 with SMTP id r4-20020a05600c35c400b003cf85f7bbc4mr27799118wmq.2.1671234460998;
        Fri, 16 Dec 2022 15:47:40 -0800 (PST)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id j41-20020a05600c1c2900b003b4ff30e566sm23829333wms.3.2022.12.16.15.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:47:40 -0800 (PST)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH] mm: vmalloc: correct use of __GFP_NOWARN mask in __vmalloc_area_node()
Date:   Fri, 16 Dec 2022 23:46:59 +0000
Message-Id: <20221216234659.493794-1-lstoakes@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function invokes warn_alloc() with __GFP_NOWARN set which is a
no-op. Set this flag _after_ this call so it is actually invoked, and
additionally remove a duplicate application of __GFP_NOWARN afterwards.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/vmalloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ca71de7c9d77..9e30f0b39203 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3031,7 +3031,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	int ret;

 	array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
-	gfp_mask |= __GFP_NOWARN;
+
 	if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
 		gfp_mask |= __GFP_HIGHMEM;

@@ -3051,10 +3051,12 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		return NULL;
 	}

+	gfp_mask |= __GFP_NOWARN;
+
 	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
 	page_order = vm_area_page_order(area);

-	area->nr_pages = vm_area_alloc_pages(gfp_mask | __GFP_NOWARN,
+	area->nr_pages = vm_area_alloc_pages(gfp_mask,
 		node, page_order, nr_small_pages, area->pages);

 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
--
2.38.1
