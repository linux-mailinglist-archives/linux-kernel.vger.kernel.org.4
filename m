Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04BF6724A4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjARRRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjARRRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:17:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCB15895B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:16:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D0FCB81DA7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 17:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E9EC433EF;
        Wed, 18 Jan 2023 17:16:49 +0000 (UTC)
Date:   Wed, 18 Jan 2023 17:16:46 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Fixes for kmemleak tracking with CMA regions
Message-ID: <Y8gpfgEXtialPVLk@arm.com>
References: <20230109221624.592315-1-isaacmanjarres@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109221624.592315-1-isaacmanjarres@google.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Isaac,

Please cc me on kmemleak patches. I only noticed when Andrew picket them
up.

On Mon, Jan 09, 2023 at 02:16:21PM -0800, Isaac J. Manjarres wrote:
> When trying to boot a device with an ARM64 kernel with the following
> config options enabled:
> 
> CONFIG_DEBUG_PAGEALLOC=y
> CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
> CONFIG_DEBUG_KMEMLEAK=y
> 
> a page-fault is encountered when kmemleak starts to scan the list of gray
> or allocated objects that it maintains. Upon closer inspection, it was
> observed that these page-faults always occurred when kmemleak attempted
> to scan a CMA region.

What I don't understand is why kmemleak scans such CMA regions. The only
reason for a kmemleak_ignore_phys() call in cma_declare_contiguous_nid()
is because the kmemleak_alloc_phys() hook was called on the
memblock_alloc_range_nid() path, so we don't want this scanned.

Do you have a backtrace?

> At the moment, kmemleak is made aware of CMA regions that are specified
> through the devicetree to be created at specific memory addresses or
> dynamically allocated within a range of addresses. However, if the
> CMA region is constrained to a certain range of addresses through the
> command line, the region is reserved through the memblock_reserve()
> function, but kmemleak_alloc_phys() is not invoked.

The combination of kmemleak_alloc_phys() + kmemleak_free_part_phys() in
your series is equivalent to not adding it at all in the first place.

> Furthermore,
> kmemleak is never informed about CMA regions being freed to buddy at
> boot, which is problematic when CONFIG_DEBUG_PAGEALLOC is enabled, as
> all CMA regions are unmapped from the kernel's address space, and
> subsequently causes a page-fault when kmemleak attempts to scan any
> of them.

kmemleak would only scan such objects if it knows about them. So I think
it's only the case where CMA does a memblock allocation. The
kmemleak_ignore_phys() should tell kmemleak not to touch this region but
it's probably better to just free it altogether (i.e. replace the ignore
with the free kmemleak callback). Would this be sufficient for your
scenario?

> This series makes it so that kmemleak is aware of every CMA region before
> they are freed to the buddy allocator, so that at that time, kmemleak
> can be informed that each region is about to be freed, and thus it
> should not attempt to scan those regions.

I may be missing something but I don't get why kmemleak needs to be
informed only to tell kmemleak shortly after to remove them from its
list of objects.

-- 
Catalin
