Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C015E564E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 00:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiIUWhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 18:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiIUWhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 18:37:24 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0508AA8953
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 15:37:23 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id j10so5172953qtv.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 15:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LmEVzalCJFIRHw39sUF5chZzrB9L9Ol3S17vl8cf3+Y=;
        b=aZdar3AJ1DG3bz5HOxv9V7SzAwaMBzRGfUiS2XhA18Fcs8H4Ak5WpiBR1K2Se7ALpk
         bO5X4Q3hs7tZXOHJ7kqDEFfkGSd5t1TshU98QnDHGeXRCCBrctK0s1+vmE/l9n+wMFEy
         KmuZhTGthHpG1FGxaAPgsnbYGSp3KhhNzHIGR4IpQ2IgFZn8JdyeTULbj5YlXASe6zfd
         +Jw+BUD1TUAvRH2kEJfCf3ILMgbKZCaqj3qJFLPXK0pLCCS4K5bnURD0A52RmHGkxMhB
         HN3Xhv0e+DFmztWDUwIiDLA5nfC0eLWMpyhpTMzmJLl6IKZ0XkD8fK0b08YlrPT44Rke
         zrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LmEVzalCJFIRHw39sUF5chZzrB9L9Ol3S17vl8cf3+Y=;
        b=5m7PW4MNsVzHrFzvBZ08H5wHjCGOdZ2igJRWT33iFF9OCYJgu6mE44nwDJYMcmqwK7
         2C/aeq4VHq4jxvpaARDt/oTJS1hB9+9FuejHs6eWhmFF+Tc7xyAKOmACrSKumAbrONnP
         4VK+CaSxe203l8BaKS+lGQcOrgRfzXBXgZRdfDmNhFPw04HdwBy4iKW+WGVxrzpijx3J
         0eU+urSrxy4sOQADUo4kUfbuTeHdq2xSXuta7V4Mp8h35p4GyFDYjFz8Dc5PBf1NB7w1
         7CRxRDgEE4MT8+Noljz7q/BmV2n9ILi+YDxHYVovLYM6jYFl63o2h/4f0FGpQNfzUvOx
         WoNA==
X-Gm-Message-State: ACrzQf117rEwJ4ensMcz2WI74AOvKLR4RemiOQXSzNuC3esWAQ1GAcae
        j9vvukM/LH5jLRDbY+A/vcg=
X-Google-Smtp-Source: AMsMyM6pGX6zsqz0C40T23b+r6f11juvY3D4Nzd4CRClOWX9iALWXgBruz8A7GfTwra9HpWNdE+06Q==
X-Received: by 2002:a05:622a:1015:b0:35a:de14:45b1 with SMTP id d21-20020a05622a101500b0035ade1445b1mr569768qte.348.1663799842103;
        Wed, 21 Sep 2022 15:37:22 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a288d00b006cea2984c9bsm2731540qkp.100.2022.09.21.15.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:37:21 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Florian Fainelli <f.fainelli@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH 3/3] mm/hugetlb: add hugepage isolation support
Date:   Wed, 21 Sep 2022 15:36:39 -0700
Message-Id: <20220921223639.1152392-4-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921223639.1152392-1-opendmb@gmail.com>
References: <20220921223639.1152392-1-opendmb@gmail.com>
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

When a range of pageblocks is isolated there is at most one
hugepage that has only tail pages overlapping that range (i.e.
a hugepage that overlaps the beginning of the range).

However, that hugepage is the first migration target for an
alloc_contig_range() attempt so it already receives special
attention.

Checking whether the pageblock containing the head of a hugepage
is isolated is an inexpensive way to avoid hugepage allocations
from isolated pageblocks which makes alloc_contig_range() more
efficient.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/hugetlb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index eab812760fbe..3a2f0b55059d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -33,6 +33,7 @@
 #include <linux/migrate.h>
 #include <linux/nospec.h>
 #include <linux/delayacct.h>
+#include <linux/page-isolation.h>
 
 #include <asm/page.h>
 #include <asm/pgalloc.h>
@@ -1135,6 +1136,10 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 		if (PageHWPoison(page))
 			continue;
 
+		/* Check head pageblock isolation */
+		if (is_migrate_isolate_page(page))
+			continue;
+
 		list_move(&page->lru, &h->hugepage_activelist);
 		set_page_refcounted(page);
 		ClearHPageFreed(page);
-- 
2.25.1

