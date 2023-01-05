Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAA265E8CA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjAEKTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjAEKTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:13 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8234A50156
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:00 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a4-20020a5b0004000000b006fdc6aaec4fso36882267ybp.20
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QisuvGCTCnQrC46aY73QASoWAbEZFo7ff5Vj8AOV5D4=;
        b=D05RGKnu5npzQ4+IoIOCUoopJdHBZlGdmzR7wKgjiYJ7fpsPJXuc7/AVMHrkDHqo2o
         RNix7ExBJuxdhCqhn48A5PCySgryuQc3GCHIVd9cC5LTv0Q9aGo5YYJG8Ce+XT9OpeXk
         M3IL0FBVE2YUx+rEwav3paVke2g6M0EhpZNkkEWcM4bLj0uxgg8utb4DdIrHzftCy4tA
         Kij4pO4w0SwaaYqXSHOVWmgJ+wQsZ23Y9Y/ujE19y5mdHZG78XAtWGKWdrNVRkm9Nl44
         elMxTtHTuRQV91u0RG0dTfAvGUJKSIuBA+Spih8dBWhAl2BkcB0t7zcxNmwHvfL9sk81
         3ptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QisuvGCTCnQrC46aY73QASoWAbEZFo7ff5Vj8AOV5D4=;
        b=bI+UbhFoZYNZW+Fsd1qnpMj342fV5eDzP/Z5NXBwfIF6ZQtDmnJsukLUDfydugn0aA
         4K4XEhs0LXWcdVYqQH0ZX5VBhH2QPY9oLjUxdzGgtfxwJtKjVd/feTrMayvGAbqSlQuP
         pqJ4cO6zl0PHCLAX4hxGwPhQssmoAY+KAsweVxF3h80N20L49IZIV657JfZT0/pzSXfT
         sBJwSTmNS07Pz4HlxT9P9eAGdz8EHSAcuxI6K0XwI0fWFGefRbPvW6NKhLjDfmd13Pwp
         dBQ7+uwPXPZUlNPnurp7sUKFHn6lvaSl0mQArMF9UOnEKicvRRPLGvQzYQEu2WB/2g8j
         MBGA==
X-Gm-Message-State: AFqh2kp4ho5J2pAWpkNV04/1FYjW3H7EokoUeZc9H8kGX9AL1po6uCMr
        yCpU0li2doWLLQyQNm4a6ZAkCrDmQjyPczaY
X-Google-Smtp-Source: AMrXdXuNwgkkz9NCdvDombHELm4ryvn27Y2ZeR0xTnznCwFeZu8QafDmhNLkdStzMtbGd0AFx5F58froof/Omrr/
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:ab4a:0:b0:7b4:df57:d887 with SMTP
 id u68-20020a25ab4a000000b007b4df57d887mr131335ybi.601.1672913939807; Thu, 05
 Jan 2023 02:18:59 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:03 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-6-jthoughton@google.com>
Subject: [PATCH 05/46] hugetlb: add CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the Kconfig to enable or disable high-granularity mapping.
Each architecture must explicitly opt-in to it (via
ARCH_WANT_HUGETLB_HIGH_GRANULARITY_MAPPING), but when opted in, HGM will
be enabled by default if HUGETLB_PAGE is enabled.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 fs/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/Kconfig b/fs/Kconfig
index 2685a4d0d353..ce2567946016 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -267,6 +267,13 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
 	  enable HVO by default. It can be disabled via hugetlb_free_vmemmap=off
 	  (boot command line) or hugetlb_optimize_vmemmap (sysctl).
 
+config ARCH_WANT_HUGETLB_HIGH_GRANULARITY_MAPPING
+	bool
+
+config HUGETLB_HIGH_GRANULARITY_MAPPING
+	def_bool HUGETLB_PAGE
+	depends on ARCH_WANT_HUGETLB_HIGH_GRANULARITY_MAPPING
+
 config MEMFD_CREATE
 	def_bool TMPFS || HUGETLBFS
 
-- 
2.39.0.314.g84b9a713c41-goog

