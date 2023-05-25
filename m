Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE36A71039B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjEYECv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEYECs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:02:48 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54649135
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 21:02:47 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d24136685so413506b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 21:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1684987367; x=1687579367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANsIwyslEqWqt/AnM3EiaC6NohGcLnN3qIazUJUVzP4=;
        b=NQJaaIdzuOmU2ZfoUS/HfLXDpN2lpDz6rxgmnio+kZPpgUMm8yFkHv0hT8FTIcZdVt
         Ro2TjOvsYI8Sjxrlcl9/rf95KDbQVHMgA1b5mYpT8p72lDYlZA1C5tZy72BZcjaAxdWv
         5LloYVYAxTGN2gD10YUAommoIjdIy/149C79MorSY1AtC/EmTjZy/5Hg0tgXhtqZ/Adr
         CiNne8GdcsARkuTNHNT6MOFjZ+iM6Ydix0MCy/3hqzvExsAklMKN0t5GFNMkV3NW//HI
         n07UXJRmrOF6W2ZNXMqSbRAxdQBg4fDRbECDjakujwM97aOUZD9iU/igqiVV9oKC9mxF
         Ghjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684987367; x=1687579367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANsIwyslEqWqt/AnM3EiaC6NohGcLnN3qIazUJUVzP4=;
        b=V3nxlHfZg+9F8m+NXlsjC0Szs6tR/e8rgBtt1KauIlgRnHPb9s73vge3AcwwUXKZcq
         kDZnuNMH78yH/VzvrZ+rpOjOE/pBK9fwRVc9pq2MuMcYjC70xMoRmPVCB1F45w//exul
         bEbbS0suDj28zNGeanUS0fSI6v7+a5w8pJcCEYHqJQxyCTr6ED5p4Hf57pfh09BhoVEm
         3rdV9aZAnFgzQWaQBnbB8oYTusCRvPxIzvQXYH4FoLjDIIxzsXb5OGOBY6aD1sMhk/GD
         JmXBrNGDIvCVaSxIRGAW9Qw6o6+kOBkkvbZpoD5zmwdvrXC8at+5+laDt+mRkfePzyRo
         DSMw==
X-Gm-Message-State: AC+VfDwFgKCziULzV2w/Q8bnvC51xc1ktgPSeclSu6a+wTKISLUR93qN
        7gQ/t1BDbjo0E0D5T80aeueaIB2HVLlHgaqLdUktl63A
X-Google-Smtp-Source: ACHHUZ4M33VfkiEYeZxyk70nhvhOVHqK3x9PsgMDApROp+V/I6KHRI3r1n/c1Qap5fKrlvpfXIq1fA==
X-Received: by 2002:a05:6a20:748e:b0:10c:b9ed:6a3f with SMTP id p14-20020a056a20748e00b0010cb9ed6a3fmr1539402pzd.7.1684987366781;
        Wed, 24 May 2023 21:02:46 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id i11-20020aa7908b000000b0064c56d04316sm189916pfa.193.2023.05.24.21.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 21:02:46 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 1/3] mm/mm_init.c: remove comments in zone_spanned_pages_in_node() and zone_absent_pages_in_node()
Date:   Thu, 25 May 2023 04:01:48 +0000
Message-Id: <20230525040150.1588-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 03e85f9d5f1f ("mm/page_alloc: Introduce free_area_init_core_hotplug"),
free_area_init_node() doesn't get called in hotplug path anymore, so
remove the comments related to it.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/mm_init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 7f7f9c677854..cf55bba04b23 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1174,7 +1174,6 @@ static unsigned long __init zone_absent_pages_in_node(int nid,
 	unsigned long zone_start_pfn, zone_end_pfn;
 	unsigned long nr_absent;
 
-	/* When hotadd a new node from cpu_up(), the node should be empty */
 	if (!node_start_pfn && !node_end_pfn)
 		return 0;
 
@@ -1227,7 +1226,7 @@ static unsigned long __init zone_spanned_pages_in_node(int nid,
 {
 	unsigned long zone_low = arch_zone_lowest_possible_pfn[zone_type];
 	unsigned long zone_high = arch_zone_highest_possible_pfn[zone_type];
-	/* When hotadd a new node from cpu_up(), the node should be empty */
+
 	if (!node_start_pfn && !node_end_pfn)
 		return 0;
 
-- 
2.25.1

