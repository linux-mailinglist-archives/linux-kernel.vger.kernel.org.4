Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B85679DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbjAXPtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjAXPtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:49:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1E322789
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:49:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66D2DB811DA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23FAC433EF;
        Tue, 24 Jan 2023 15:49:00 +0000 (UTC)
Date:   Tue, 24 Jan 2023 15:48:57 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Isaac Manjarres <isaacmanjarres@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Fixes for kmemleak tracking with CMA regions
Message-ID: <Y8/96eIu47UfqsWO@arm.com>
References: <20230109221624.592315-1-isaacmanjarres@google.com>
 <Y8gpfgEXtialPVLk@arm.com>
 <Y8neaPB2y689WKOf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8neaPB2y689WKOf@google.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 04:20:56PM -0800, Isaac Manjarres wrote:
> On Wed, Jan 18, 2023 at 05:16:46PM +0000, Catalin Marinas wrote:
> > What I don't understand is why kmemleak scans such CMA regions. The only
> > reason for a kmemleak_ignore_phys() call in cma_declare_contiguous_nid()
> > is because the kmemleak_alloc_phys() hook was called on the
> > memblock_alloc_range_nid() path, so we don't want this scanned.
> The reason is because kmemleak_ignore_phys() is only called within
> cma_declare_contiguous_nid(), which is not called for every CMA region.
> 
> For instance, CMA regions which are specified through the devicetree
> and not constrained to a fixed address are allocated through
> early_init_dt_alloc_reserved_memory_arch(), which eventually calls
> kmemleak_alloc_phys() through memblock_phys_alloc_range().
> 
> When the CMA region is constrained to a particular address, it is allocated
> through early_init_dt_reserve_memory(), which is followed up by a call to
> kmemleak_alloc_phys() due to this commit:
> https://lore.kernel.org/all/20211123090641.3654006-1-calvinzhang.cool@gmail.com/T/#u

Thanks for digging this out. This patch shouldn't have ended up upstream
(commit 972fa3a7c17c "mm: kmemleak: alloc gray object for reserved
region with direct map"). I thought both Calvin Zhang and I agreed that
it's not the correct approach (not even sure there was a real problem to
fix).

Do you still get the any faults with the above commit reverted? I'd
prefer this if it works rather than adding unnecessary
kmemleak_alloc/free callbacks that pretty much cancel each-other.

> I'm not sure if that commit is appropriate, given that reserved regions
> that still have their direct mappings intact may be used for DMA, which
> isn't appropriate for kmemleak scanning.

It's not. I think it should be reverted.

> > kmemleak would only scan such objects if it knows about them. So I think
> > it's only the case where CMA does a memblock allocation. The
> > kmemleak_ignore_phys() should tell kmemleak not to touch this region but
> > it's probably better to just free it altogether (i.e. replace the ignore
> > with the free kmemleak callback). Would this be sufficient for your
> > scenario?
> 
> I agree that freeing the kmemleak object is a better strategy. However,
> replacing the call to kmemleak_ignore_phys() wouldn't be sufficient,
> as there are other scenarios that would still leave behind kmemleak
> objects to be scanned. That's why I ended up freeing the kmemleak object
> in a path that is common for all CMA areas.

The only reason for kmemleak_ignore_phys() was to counter the actual
kmemleak_alloc() call from the memblock code on the CMA allocation.

-- 
Catalin
