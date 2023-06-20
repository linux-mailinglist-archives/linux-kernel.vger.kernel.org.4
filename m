Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FE7737773
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 00:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjFTW0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 18:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFTW0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:26:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739121735;
        Tue, 20 Jun 2023 15:26:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00DEA61291;
        Tue, 20 Jun 2023 22:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF9BC433C0;
        Tue, 20 Jun 2023 22:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687300005;
        bh=MCSUz/MAQT4r5cMvV8x8YY+jmIPX87xmV2kPzuDjlpg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=B3M56n8f6vGBjTVCCPyYYm0G7wujWstKyfAKiGUE4pBBIOTpqlFx3AuEPXSsn+Aif
         raIznNSt2CXbCCNI0+ntn4m5k36dH8L+lkgISR4EEF/mzyxhtJaqgjsC+RZNHn99qD
         +Ku1EXgl5T8aJ10vNBIRFQBFgbnQx2Gq7eSiJOcupOCoWDm4K8p4+VJcdV17O/LCUk
         UTXuYboozzdUkTVkzLcgTZU5jpd93Tu0psReMwyqfYU2ia7wzpoCi5Fv/CbNb5nPZc
         pycNnx28ydtXEt23XI+e7oksux3a74EbX+0Fn2DTVnp4ky86HBggyuej9p5Xt8149h
         Tc2exysc5l3Fg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ED053CE1CC5; Tue, 20 Jun 2023 15:26:44 -0700 (PDT)
Date:   Tue, 20 Jun 2023 15:26:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Add necessary WRITE_ONCE()
Message-ID: <50c4aa37-388b-449c-8184-00a9d69471fc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230620171346.207076-1-mmpgouride@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620171346.207076-1-mmpgouride@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 05:13:46PM +0000, Alan Huang wrote:
> Commit c54a2744497d("list: Add hlist_unhashed_lockless()") and
> commit 860c8802ace1("rcu: Use WRITE_ONCE() for assignments to
> ->pprev for hlist_nulls") added various WRITE_ONCE() to pair with
> the READ_ONCE() in hlist_unhashed_lockless(), but there are still
> some places where WRITE_ONCE() was not added, this commit adds that.
> 
> Also add WRITE_ONCE() to pair with the READ_ONCE() in hlist_empty().
> 
> Signed-off-by: Alan Huang <mmpgouride@gmail.com>

On hlist_nulls_add_tail_rcu(), good catch, thank you!

On the others, are there really cases where a lockless read races with
the update?  At first glance, that sounds like a usage bug.  For example,
as I understand it, when you use something like hlist_del(), you are
supposed to ensure that there are no concurrent readers.  Which is the
point of the assignment of the special value LIST_POISON2, right?

Or is there some use case that I am missing?

If I am not missing something, then switching the non-RCU APIs to
WRITE_ONCE() would be a step backwards, because it would make it harder
for tools like KCSAN to find bugs.

							Thanx, Paul

> ---
> Changelog:
> V1 -> V2: 
>   Add WRITE_ONCE in hlist_del_init to pair with READ_ONCE in
>   hlist_unhashed_lockless.
> 
>  include/linux/list.h          | 9 +++++----
>  include/linux/list_nulls.h    | 2 +-
>  include/linux/rculist_nulls.h | 2 +-
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/list.h b/include/linux/list.h
> index ac366958ea..3a29b95bfe 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -912,7 +912,7 @@ static inline void hlist_del(struct hlist_node *n)
>  {
>  	__hlist_del(n);
>  	n->next = LIST_POISON1;
> -	n->pprev = LIST_POISON2;
> +	WRITE_ONCE(n->pprev, LIST_POISON2);
>  }
>  
>  /**
> @@ -925,7 +925,8 @@ static inline void hlist_del_init(struct hlist_node *n)
>  {
>  	if (!hlist_unhashed(n)) {
>  		__hlist_del(n);
> -		INIT_HLIST_NODE(n);
> +		n->next = NULL;
> +		WRITE_ONCE(n->pprev, NULL);
>  	}
>  }
>  
> @@ -1026,8 +1027,8 @@ static inline void hlist_move_list(struct hlist_head *old,
>  {
>  	new->first = old->first;
>  	if (new->first)
> -		new->first->pprev = &new->first;
> -	old->first = NULL;
> +		WRITE_ONCE(new->first->pprev, &new->first);
> +	WRITE_ONCE(old->first, NULL);
>  }
>  
>  #define hlist_entry(ptr, type, member) container_of(ptr,type,member)
> diff --git a/include/linux/list_nulls.h b/include/linux/list_nulls.h
> index fa6e8471bd..b63b0589fa 100644
> --- a/include/linux/list_nulls.h
> +++ b/include/linux/list_nulls.h
> @@ -95,7 +95,7 @@ static inline void hlist_nulls_add_head(struct hlist_nulls_node *n,
>  
>  	n->next = first;
>  	WRITE_ONCE(n->pprev, &h->first);
> -	h->first = n;
> +	WRITE_ONCE(h->first, n);
>  	if (!is_a_nulls(first))
>  		WRITE_ONCE(first->pprev, &n->next);
>  }
> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
> index ba4c00dd80..c65121655b 100644
> --- a/include/linux/rculist_nulls.h
> +++ b/include/linux/rculist_nulls.h
> @@ -138,7 +138,7 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
>  
>  	if (last) {
>  		n->next = last->next;
> -		n->pprev = &last->next;
> +		WRITE_ONCE(n->pprev, &last->next);
>  		rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
>  	} else {
>  		hlist_nulls_add_head_rcu(n, h);
> -- 
> 2.34.1
> 
