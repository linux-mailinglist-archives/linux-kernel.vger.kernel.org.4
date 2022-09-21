Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3055E564B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 00:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiIUWhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 18:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiIUWhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 18:37:15 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E209AFBA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 15:37:14 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c19so5028517qkm.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 15:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=jg/Gl7Z8koWCH3EVK8ZxePVcvCL50iYxWjhRlo72dUo=;
        b=qhBUOiiLFKbmBirKrjqRHaxf6UzRE/CkIjRJeQFwjs6UWeQDDJHP80BRI2/6t6w7yv
         G89CgjJ6D5YnRBos19KphDCEl45IUUwi2kWqwI+iNuIrYz0TcvbsTj90ZuAUj5AmIlm6
         cNP5FPiT+KmytCQ3akPaoyK4OkoUo8FZIdw9suidyudRqm38qnfF4GJBDwDDpuiB2dvL
         0eXQlIucL/Ci6S/n4OImFmLTYq61RrLaDuGCDFq56h50QvieE6iofZjnqCCfuEecNlRs
         nkUXjhbxb0Vi0kjwgVKxQlygYF0WFZCybourRbgEfKoguM1cBJDHXwBY2Yew2/xTpG8m
         F0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=jg/Gl7Z8koWCH3EVK8ZxePVcvCL50iYxWjhRlo72dUo=;
        b=kf9eB87rGOVKFiGljCVcyaXmF5v3tNsuOucQmxUMWgcs+O2BGNtdhbcPQH7yiSFYKd
         YzC4D26uAdxbSXX9Wllp8quhBQvj+VXJwd915zs0F4L26h0INJFuSPnKkQOtv3QDA529
         dHe+vnwbqFLBktdvwLU7Sq/YoYyw0SsSi+7D7tCbB0Wyp1ce3x8FQp5e8OUqlT7bA7V8
         mPinKzdYFzTs9O4hufIKiwokiXXWie6z6B2l1UzWA1tFtWRghYzMdPOhsXpX4C2cFkkz
         whx9Gz2IKSXzgyllYcwbWRysKKTNnz6t7q9MD4feNVgu5H3OoYQh0Blb8o3q5o4sxUHM
         J0Lg==
X-Gm-Message-State: ACrzQf1IPdYvx4TYkvnoqGH0ZTZI7UJXtT6LIieJZ4+Bufj+yYQek1sB
        y3tV8n4MpgERwLgtZF+Vq/s=
X-Google-Smtp-Source: AMsMyM7sWUmFCQvM4gIOUFNORUgZqQSXmTTG3w2kCEpm9xYr/ksUyU2feKL+ClHC5s5wbNlVvpPmew==
X-Received: by 2002:a05:620a:410e:b0:6bc:1ea0:19f9 with SMTP id j14-20020a05620a410e00b006bc1ea019f9mr210704qko.667.1663799832876;
        Wed, 21 Sep 2022 15:37:12 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a288d00b006cea2984c9bsm2731540qkp.100.2022.09.21.15.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:37:10 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Florian Fainelli <f.fainelli@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH 0/3] mm/hugetlb: hugepage migration enhancements
Date:   Wed, 21 Sep 2022 15:36:36 -0700
Message-Id: <20220921223639.1152392-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
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

This patch set was included as patches [04/21-06/21] in my
previous patch set to introduce Designated Movable Blocks [1].
They were included there for context, but they have value on
their own and are being resubmitted here for consideration on
their own merits.

The alloc_contig_range() function attempts to isolate the free
pages within the range and migrate the data from non-free pages
within the range to allow those pages to become isolated free
pages. If all of the pages in the range are on isolated free
page lists they can be allocated to the caller.

When free hugepages are encountered in the range an attempt is
made to allocate a new compound page to become a replacement
hugepage and to dissolve the free hugepage so that its pages
within isolated pageblocks can be added to the isolated free
page lists. Hugepages that are not free and encountered within
the range must be migrated out of the range and dissolved to
allow the underlying pages to be added to the isolated free
page lists.

Moving the data from hugepages within the range and freeing the
hugepages is not sufficient since the allocation of migration
target hugepages is allowed to come from free hugepages that may
contain isolated pageblocks and freed hugepages will not be on
isolated free page lists so the alloc_contig_range() will fail.

To address these shortcommings the HPG_dissolve hugepage flag is
introduced to tag hugepages that must be dissolved when they are
freed so that their underlying pages can be moved to the page
allocator's free lists. This prevents hugepages that have had
their data migrated to new hugepages from being made available
to subsequent hugepage allocations and allows the isolated free
page test of alloc_contig_range() to succeed.

Dissolved hugepages must be replaced with new hugepages to keep
the hugetlbfs balanced. To support blocking allocation a new
workqueue in introduced that is analogous to the workqueue
introduced to support the hugetlb vmemmap optimization. This new
workqueue allows the allocation and dissolution of the hugepage
to be offloaded to a separate context from the freeing of the
hugepage. The sync_hugetlb_dissolve() function is introduced to
allow outstanding dissolution of hugepages to complete before
the isolated free page check is made by alloc_contig_range().

In addition, a check is added to hugepage allocation to prevent
free hugepages within an isolated pageblock range from being
used to satisfy migration target allocations preventing circular
migrations.

[1] https://lore.kernel.org/linux-mm/20220913195508.3511038-1-opendmb@gmail.com/

Doug Berger (3):
  mm/hugetlb: refactor alloc_and_dissolve_huge_page
  mm/hugetlb: allow migrated hugepage to dissolve when freed
  mm/hugetlb: add hugepage isolation support

 include/linux/hugetlb.h |   5 ++
 mm/hugetlb.c            | 161 +++++++++++++++++++++++++++++++---------
 mm/migrate.c            |   1 +
 mm/page_alloc.c         |   1 +
 4 files changed, 131 insertions(+), 37 deletions(-)


base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
-- 
2.25.1

