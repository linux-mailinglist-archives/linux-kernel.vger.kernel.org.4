Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CC16AE01A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCGNOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjCGNOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:14:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D4980916
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:12:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D66561361
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 13:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62650C433EF;
        Tue,  7 Mar 2023 13:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678194716;
        bh=yPEK0b3AslIzUscbkPKlhlg12JscyL7jmaUh7CLYLdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WnTHk92ZX7U648HeH7O5AWjcqAn8oZz05jvYbHiXRhUHTElBN8Uz7YbOpmeUyPt+5
         eMO8ebmsABW0rhY56HkBoNHZ64m4GvfCjRMYKXoIgbrklexdGAsu5AJ2oXEEaJ5wiA
         j5hTQrzndekYoG/gEZ25QS4rF5dw60KENe7XMwOnr5K4x+ZcJWx6ZLa3AYnmETHMGe
         +0Aj4mM25P7FllrqGtMwUtvJKi+IQZEGYVuJ9CrQ6o8yB+CfauiEHDC5Aj9/VqSOr9
         fWFtlI90H69Fhsv0nBYv2u7yNGdqsOQIa1njLxPXW3Nogq74jxYUMdVeu2UBItLpKg
         v0jgExwZtqP/A==
Date:   Tue, 7 Mar 2023 15:11:43 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Claudio Migliorelli <claudio.migliorelli@mail.polimi.it>
Cc:     remckee0@gmail.com, david@redhat.com, shaoqin.huang@intel.com,
        karolinadrobnik@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Add tests for memblock_alloc_node()
Message-ID: <ZAc4D3+qfMVwpZr7@kernel.org>
References: <ea5e938e-6b74-b188-af59-4b94b18bc0@mail.polimi.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea5e938e-6b74-b188-af59-4b94b18bc0@mail.polimi.it>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 07:07:11PM +0100, Claudio Migliorelli wrote:
> This test is aimed at verifying the memblock_alloc_node() to work as
> expected, so setting the correct NUMA node for the new allocated
> region. The memblock_alloc_node() is called directly without using any
> stub. The core check is between the requested NUMA node and the `nid`
> field inside the memblock_region structure. These two are supposed to
> be equal for the test to succeed.
> 
> Signed-off-by: Claudio Migliorelli <claudio.migliorelli@mail.polimi.it>

Applied, thanks!

> ---
> Changelog:
> ----------
> v3:
> 	- Fixed errors related to "<stdin>:188: trailing whitespace"
> 	that caused a failure when applying the patch
> v2:
> 	- Use the memblock_alloc_node() directly without mimicking it
> ---
>  tools/testing/memblock/tests/alloc_nid_api.c | 40 ++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
> index 49ef68cccd6f..49bb416d34ff 100644
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
> +
> +	allocated_ptr = memblock_alloc_node(size, SMP_CACHE_BYTES, nid_req);
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
> 

-- 
Sincerely yours,
Mike.
