Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2867D6A1DD2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjBXOwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBXOwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:52:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EE653293
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:52:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 369B0B81C98
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 14:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEF9C433D2;
        Fri, 24 Feb 2023 14:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677250356;
        bh=88jg955Xlrfjz0cdpx93zZt+1vg7t0UtMpUiq72/y20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WuayLX8T11FBApVctgpEi4iszLEZbC2I6zuVpzQ1lROGYa395L2A7EvStSF7LQxP9
         OYIliXyzfsSQuqYGcqzcGHiIjeruOZ56spgNEjHEI7tlVoxujKYnbnEEdtFR7w8Gpj
         NNGzX/a4Wi+ZhoPO6sB6i077FQM/EClwXuZAZuPahGvPAKxYFfo9xeyuYVPlUxundc
         bl97rVN929h+OFrKUJRa2dGILgG4rkYo4Dv8WEGujH6Tg2FvE40K+Bys9zwAex5K0M
         Lf4XEmemjnIfJhhnzQ3jwx8WPgkGcke0hxn6LRoPAxmlyMQ2fzXx9k2JsIWaHHw6o4
         bOb/7wNaxaLcw==
Date:   Fri, 24 Feb 2023 16:52:26 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Claudio Migliorelli <claudio.migliorelli@mail.polimi.it>
Cc:     remckee0@gmail.com, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Add tests for memblock_alloc_node()
Message-ID: <Y/jPKvcIpqi1zVgC@kernel.org>
References: <59d4745b-7b2-bf6-7b8-f6571d78d336@mail.polimi.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59d4745b-7b2-bf6-7b8-f6571d78d336@mail.polimi.it>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudio,

On Sun, Feb 19, 2023 at 05:28:46PM +0100, Claudio Migliorelli wrote:
> This test is aimed at verifying the memblock_alloc_node() to work as
> expected, so setting the correct NUMA node for the new allocated
> region. The memblock_alloc_node() is called directly without using any
> stub. The core check is between the requested NUMA node and the `nid`
> field inside the memblock_region structure. These two are supposed to
> be equal for the test to succeed.
> 
> Signed-off-by: Claudio Migliorelli <claudio.migliorelli@mail.polimi.it>
> ---
> Changelog:
> ----------
> v2:
> 	- Use the memblock_alloc_node() directly without mimicking it
> 
>  tools/testing/memblock/tests/alloc_nid_api.c | 40 ++++++++++++++++++++
>  1 file changed, 40 insertions(+)

When I tried to apply your patch I've got these errors:

<stdin>:188: trailing whitespace.
 
error: patch failed: tools/testing/memblock/tests/alloc_nid_api.c:2494
error: tools/testing/memblock/tests/alloc_nid_api.c: patch does not apply

> diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
> index 49ef68cccd6f..975a5317abf3 100644
> --- a/tools/testing/memblock/tests/alloc_nid_api.c
> +++ b/tools/testing/memblock/tests/alloc_nid_api.c
> @@ -2494,6 +2494,35 @@ static int alloc_nid_numa_split_all_reserved_generic_check(void)
>  	return 0;
>  }
> 
> +/*
> + * A simple test that tries to allocate a memory region through the
> + * memblock_alloc_node() on a NUMA node with id `nid`. Expected to have the
> + * correct NUMA node set for the new region.
> + */
> +static int alloc_node_on_correct_nid(void)
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
> + +	allocated_ptr = memblock_alloc_node(size, SMP_CACHE_BYTES, nid_req);
> +
> +	ASSERT_NE(allocated_ptr, NULL);
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
>  static int alloc_nid_numa_simple_check(void)
>  {
> @@ -2632,6 +2661,15 @@ static int alloc_nid_numa_split_all_reserved_check(void)
>  	return 0;
>  }
> 
> +static int alloc_node_numa_on_correct_nid(void)
> +{
> +	test_print("\tRunning %s...\n", __func__);
> +	run_top_down(alloc_node_on_correct_nid);
> +	run_bottom_up(alloc_node_on_correct_nid);
> +
> +	return 0;
> +}
> +
>  int __memblock_alloc_nid_numa_checks(void)
>  {
>  	test_print("Running %s NUMA tests...\n",
> @@ -2652,6 +2690,8 @@ int __memblock_alloc_nid_numa_checks(void)
>  	alloc_nid_numa_reserved_full_merge_check();
>  	alloc_nid_numa_split_all_reserved_check();
> 
> +	alloc_node_numa_on_correct_nid();
> +
>  	return 0;
>  }
> 
> -- 
> 2.38.3

-- 
Sincerely yours,
Mike.
