Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCEE673910
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjASM6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjASM6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:58:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBD53589
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:58:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0932F60AD1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63145C433F1;
        Thu, 19 Jan 2023 12:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674133122;
        bh=O7Q6zdiSVpb/QDVMFg0WjTXi5Io4YYx9Rx3NmusYSWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hf8lOQ9q6jbPYH6nwpaVSCKgXIockgfW0UvyhxN2AEaCZ+GoMbcxxyZvsiR4ls/bm
         xSeTiu5YAbbHejfxRtz96g3kGRLEetjE2ZbcIAsS19nmXb7NvMVy4LtIWnLzoD1wA5
         eB8qS9YdFTqD88eGY/4JhIBOmTS3odZvsbS7WuPKK2HNHxJBeJd7cDad2iUqVCb/lF
         Faqaz6JrSdkshCch9vkc+5BYBxCdfpn4LzyBl3M4D1FtOUrRajX+dNNw7FZ5mG9utT
         eynXauAKI484b9aNgpzuYRzgQGHd2U7ulQWrxiDwTEkU/fnnGZ/PKVGBVSUv2vXe62
         TD5wNcSN7ZoCw==
Date:   Thu, 19 Jan 2023 14:58:29 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Claudio Migliorelli <claudio.migliorelli@mail.polimi.it>
Cc:     Rebecca Mckeever <remckee0@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add tests for memblock_alloc_node()
Message-ID: <Y8k+deIUhcVMyzdn@kernel.org>
References: <0c3fdce6-3180-89c6-ba9e-77b7e98a5691@mail.polimi.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c3fdce6-3180-89c6-ba9e-77b7e98a5691@mail.polimi.it>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 05:01:43PM +0100, Claudio Migliorelli wrote:
> These tests are aimed at verifying the memblock_alloc_node() to work as expected, so setting the
> correct NUMA node for the new allocated region. The memblock_alloc_node() is mimicked by executing
> the already implemented test function run_memblock_alloc_try_nid() and by setting the flags used
> internally by the memblock_alloc_node(). The core check is between the requested NUMA node and the
> `nid` field inside the memblock_region structure. These two are supposed to be equal in order for
> the test to succeed.

We already have tests that verify that verify that NUMA APIs respect nid
parameter, e.g. alloc_nid_numa_simple_check().

If you'd like to add a test that verifies that memblock_alloc_node() works
as expected, don't mimic it, but use it directly.

When posting patches please format the commit log to wrap at 75 columns (see
Documentation/process/submitting-patches.rst) and use recent Linus' tree as
the base.

> Signed-off-by: Claudio Migliorelli <claudio.migliorelli@mail.polimi.it>
> ---
>  tools/testing/memblock/tests/alloc_nid_api.c | 43 ++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
> index 2c2d60f4e3e3..9183e2219c5c 100644
> --- a/tools/testing/memblock/tests/alloc_nid_api.c
> +++ b/tools/testing/memblock/tests/alloc_nid_api.c
> @@ -2483,6 +2483,40 @@ static int alloc_try_nid_numa_split_all_reserved_generic_check(void)
>  	return 0;
>  }
> 
> +/*
> + * A test that tries to allocate a memory region through the
> + * memblock_alloc_node() on a NUMA node with id `nid`. The call to the
> + * memblock_alloc_node() is mimicked using the run_memblock_alloc_try_nid()
> + * with appropriate flags, the same used internally by the memblock_alloc_node().
> + * Expected to have the correct NUMA node set for the new region.
> + */
> +static int alloc_node_on_correct_nid_simple_check(void)
> +{
> +	int nid_req = 2;
> +	void *allocated_ptr = NULL;
> +#ifdef CONFIG_NUMA
> +	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
> +#endif
> +	phys_addr_t size = SZ_512;
> +
> +	PREFIX_PUSH();
> +	setup_numa_memblock(node_fractions);
> +
> +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> +						   MEMBLOCK_LOW_LIMIT, MEMBLOCK_ALLOC_ACCESSIBLE,
> +						   nid_req);
> +
> +	ASSERT_NE(allocated_ptr, NULL);
> +	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
> +#ifdef CONFIG_NUMA
> +	ASSERT_EQ(nid_req, req_node->nid);
> +#endif
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
>  /* Test case wrappers for NUMA tests */
>  static int alloc_try_nid_numa_simple_check(void)
>  {
> @@ -2621,6 +2655,14 @@ static int alloc_try_nid_numa_split_all_reserved_check(void)
>  	return 0;
>  }
> 
> +static int alloc_try_nid_numa_correct_node_simple_check(void)
> +{
> +	test_print("\tRunning %s...\n", __func__);
> +	alloc_node_on_correct_nid_simple_check();
> +
> +	return 0;
> +}
> +
>  int __memblock_alloc_nid_numa_checks(void)
>  {
>  	test_print("Running %s NUMA tests...\n",
> @@ -2640,6 +2682,7 @@ int __memblock_alloc_nid_numa_checks(void)
>  	alloc_try_nid_numa_large_region_check();
>  	alloc_try_nid_numa_reserved_full_merge_check();
>  	alloc_try_nid_numa_split_all_reserved_check();
> +	alloc_try_nid_numa_correct_node_simple_check();
> 
>  	return 0;
>  }
> -- 
> 2.39.0
> 

-- 
Sincerely yours,
Mike.
