Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A325E5BBC4E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 09:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiIRHcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 03:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIRHcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 03:32:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967C3222B9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 00:32:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27AF4B80E34
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 07:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D256C433C1;
        Sun, 18 Sep 2022 07:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663486338;
        bh=Sz9RGbEOczmoZukIVTYFVfeQaabX+3wQGSh1Zq8l9Nw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kpk7nMOvNxPCgzfWL8B7YRw+96Of517uH8tWw47I6ow5yZN9RV6ektnF9nRltloQY
         O9tyz3oX7MLW3H+ssn7TUmmGOIlxYW+uia0t2y0F5Hauiw4qDvk0wXxtaLshNBLKXP
         gDPss1T13vYRBLg6KEgRUNJfxZAKrQMLnkP32I9oBZBm+TIp+FrQ3JexaneJPivu/3
         pFdxQ+PXsslDO+uXSo6aejDoteuMswe9xLwgF1Da/VGtlESU1Ba45E+SkcxtDkWLxY
         cjZ6Ftc8ATVkLsK54eVVQ0BP4JGyG54mh/Kdk89kkCghmL4m/TFXB/ChKSs5m9CruZ
         Lod4N+fULyO9Q==
Date:   Sun, 18 Sep 2022 10:32:05 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6 0/4] memblock tests: add NUMA tests for
 memblock_alloc_try_nid*
Message-ID: <YybJdXgUm1csEsWj@kernel.org>
References: <cover.1663046060.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1663046060.git.remckee0@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 12:21:08AM -0500, Rebecca Mckeever wrote:
> These patches add additional tests for memblock_alloc_try_nid() and
> memblock_alloc_try_nid_raw() that use a simulated physical
> memory that is set up with multiple NUMA nodes. Additionally, most of
> these tests set nid != NUMA_NO_NODE.
> 
> To set up a simulated physical memory with multiple NUMA nodes, patch 1
> introduces setup_numa_memblock(). This function uses a previously
> allocated dummy physical memory. It can be used in place of
> setup_memblock() in tests that need to simulate a NUMA system.
> 
> These tests are run twice, once for memblock_alloc_try_nid() and once
> for memblock_alloc_try_nid_raw(), so that both functions are tested with
> the same set of tests. When the tests run memblock_alloc_try_nid(), they
> test that the entire memory region is zero. When the tests run
> memblock_alloc_try_nid_raw(), they test that the entire memory region is
> nonzero.
> 
> Rebecca Mckeever (4):
>   memblock tests: add simulation of physical memory with multiple NUMA
>     nodes
>   memblock tests: add top-down NUMA tests for memblock_alloc_try_nid*
>   memblock tests: add bottom-up NUMA tests for memblock_alloc_try_nid*
>   memblock tests: add generic NUMA tests for memblock_alloc_try_nid*
> 
>  .../testing/memblock/scripts/Makefile.include |    2 +-
>  tools/testing/memblock/tests/alloc_nid_api.c  | 1466 ++++++++++++++++-
>  tools/testing/memblock/tests/alloc_nid_api.h  |   16 +
>  tools/testing/memblock/tests/common.c         |   31 +
>  tools/testing/memblock/tests/common.h         |   22 +-
>  5 files changed, 1524 insertions(+), 13 deletions(-)

Applied, thanks! 

-- 
Sincerely yours,
Mike.
