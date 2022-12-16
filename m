Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223FE64F261
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 21:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiLPUaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 15:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiLPUaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:30:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C12A2637
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:30:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C78D46221A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 20:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA01C433D2;
        Fri, 16 Dec 2022 20:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671222643;
        bh=tTI5+JlUZWGk4Qn2IlYwarGglLDZGP6vou+JfYABe2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zb3aYLGgNXa2vW2C+Ixxpxl2gXR4ljbH5ylBHG8vY0UnZihFLElQJcS4SB1rnrLOE
         +FXG0lkDY1vbkIGSBYmNkgKAd8v7g8k9Eux9ziN0sLchl3+Fn4Lp4Puh1+33eUM7kI
         NePuVXU4naa741wujWHSMvG4tsayRBmuQyaGxkGyDtpZ1JeBeheYymDvn5cmXZdJq+
         qeOc2nKmiO3zFx91Uzh/Wti4Ce1OjUp8WW2sv4VK9oACmd60O0GMeTjFTfa84AOrTO
         dUCuEr7Xe9vpRGDj5s7hVicxwrYKANwWo0KzGinOhdR1zeikghIr/DUYp7CxwVTr4i
         STk8ySIjcxLeQ==
Date:   Fri, 16 Dec 2022 22:30:30 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Andrei Vagin <avagin@gmail.com>,
        "usama.anjum@collabora.com" <usama.anjum@collabora.com>
Subject: Re: [PATCH] maple_tree: Fix mas_spanning_rebalance() on insufficient
 data
Message-ID: <Y5zVZooCy0EaR9Wi@kernel.org>
References: <20221216185233.2036415-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216185233.2036415-1-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 06:53:15PM +0000, Liam Howlett wrote:
> Mike Rapoport contacted me off-list with a regression in running criu.
> Periodic tests fail with an RCU stall during execution.  Although rare,
> it is possible to hit this with other uses so this patch should be
> backported to fix the regression.
> 
> An insufficient node was causing an out-of-bounds access on the node in
> mas_leaf_max_gap().  The cause was the faulty detection of the new node
> being a root node when overwriting many entries at the end of the tree.
> 
> Fix the detection of a new root and ensure there is sufficient data
> prior to entering the spanning rebalance loop.
> 
> Add a testcase to the maple tree test suite for this issue.
> 
> Cc: Andrei Vagin <avagin@gmail.com>
> Cc: usama.anjum@collabora.com
> Reported-by: Mike Rapoport <rppt@kernel.org>
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Tested-by: Mike Rapoport <rppt@kernel.org>

> ---
>  lib/maple_tree.c      |  4 +++-
>  lib/test_maple_tree.c | 23 +++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index fe3947b80069..26e2045d3cda 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -2994,7 +2994,9 @@ static int mas_spanning_rebalance(struct ma_state *mas,
>  	mast->free = &free;
>  	mast->destroy = &destroy;
>  	l_mas.node = r_mas.node = m_mas.node = MAS_NONE;
> -	if (!(mast->orig_l->min && mast->orig_r->max == ULONG_MAX) &&
> +
> +	/* Check if this is not root and has sufficient data.  */
> +	if (((mast->orig_l->min != 0) || (mast->orig_r->max != ULONG_MAX)) &&
>  	    unlikely(mast->bn->b_end <= mt_min_slots[mast->bn->type]))
>  		mast_spanning_rebalance(mast);
>  
> diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
> index f425f169ef08..497fc93ccf9e 100644
> --- a/lib/test_maple_tree.c
> +++ b/lib/test_maple_tree.c
> @@ -2498,6 +2498,25 @@ static noinline void check_dup(struct maple_tree *mt)
>  	}
>  }
>  
> +static noinline void check_bnode_min_spanning(struct maple_tree *mt)
> +{
> +	int i = 50;
> +	MA_STATE(mas, mt, 0, 0);
> +
> +	mt_set_non_kernel(9999);
> +	mas_lock(&mas);
> +	do {
> +		mas_set_range(&mas, i*10, i*10+9);
> +		mas_store(&mas, check_bnode_min_spanning);
> +	} while (i--);
> +
> +	mas_set_range(&mas, 240, 509);
> +	mas_store(&mas, NULL);
> +	mas_unlock(&mas);
> +	mas_destroy(&mas);
> +	mt_set_non_kernel(0);
> +}
> +
>  static DEFINE_MTREE(tree);
>  static int maple_tree_seed(void)
>  {
> @@ -2742,6 +2761,10 @@ static int maple_tree_seed(void)
>  	check_dup(&tree);
>  	mtree_destroy(&tree);
>  
> +	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
> +	check_bnode_min_spanning(&tree);
> +	mtree_destroy(&tree);
> +
>  #if defined(BENCH)
>  skip:
>  #endif
> -- 
> 2.35.1

-- 
Sincerely yours,
Mike.
