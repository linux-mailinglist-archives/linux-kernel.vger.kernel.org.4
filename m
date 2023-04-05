Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EF66D79EA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 12:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbjDEKjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 06:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237635AbjDEKjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:39:15 -0400
Received: from outbound-smtp14.blacknight.com (outbound-smtp14.blacknight.com [46.22.139.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD7B4C23
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 03:39:13 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id 8F9891C4325
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 11:39:12 +0100 (IST)
Received: (qmail 9016 invoked from network); 5 Apr 2023 10:39:12 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 5 Apr 2023 10:39:12 -0000
Date:   Wed, 5 Apr 2023 11:39:10 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, osalvador@suse.de, vbabka@suse.cz,
        william.lam@bytedance.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: compaction: fix the possible deadlock when
 isolating hugetlb pages
Message-ID: <20230405103910.t2774qzhs2tne72q@techsingularity.net>
References: <73d6250a90707649cc010731aedc27f946d722ed.1678962352.git.baolin.wang@linux.alibaba.com>
 <7ab3bffebe59fb419234a68dec1e4572a2518563.1678962352.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <7ab3bffebe59fb419234a68dec1e4572a2518563.1678962352.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 07:06:47PM +0800, Baolin Wang wrote:
> When trying to isolate a migratable pageblock, it can contain several
> normal pages or several hugetlb pages (e.g. CONT-PTE 64K hugetlb on arm64)
> in a pageblock. That means we may hold the lru lock of a normal page to
> continue to isolate the next hugetlb page by isolate_or_dissolve_huge_page()
> in the same migratable pageblock.
> 
> However in the isolate_or_dissolve_huge_page(), it may allocate a new hugetlb
> page and dissolve the old one by alloc_and_dissolve_hugetlb_folio() if the
> hugetlb's refcount is zero. That means we can still enter the direct compaction
> path to allocate a new hugetlb page under the current lru lock, which
> may cause possible deadlock.
> 
> To avoid this possible deadlock, we should release the lru lock when trying
> to isolate a hugetbl page. Moreover it does not make sense to take the lru
> lock to isolate a hugetlb, which is not in the lru list.
> 
> Fixes: 369fa227c219 ("mm: make alloc_contig_range handle free hugetlb pages")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
