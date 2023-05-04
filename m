Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513226F636A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 05:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjEDDeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 23:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjEDDdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 23:33:47 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002B810D1
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 20:33:17 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aaea43def7so36087355ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 20:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683171197; x=1685763197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTDMySHrnRMrVKv9Dk+Mu/TJmsBqRn45hMZsS7Ztb/c=;
        b=L3HvVHzI06gwqAYhv4LwuOetQP/20Z2KpNc/nVnRNPYNdPHxemuViIPT5PiWlGQ+G1
         SXUl6SXL4gGq+Ve53ekOAUbcHpshvGVFLqJ4IgLXrANszqvHRzQyDXWflgH1DJNQY6E3
         crPvk+KF76Nreaukq39vVWsCYsNKTlpHSvzWP51JAEWyqPyjSrV7Xf/PIviqDFF9kE3N
         mChJQPutwkZONTgl9b7DpNAGkutS/bsi9eEGctZnGSTa9HAdbKp0RGKL5VNLzJEE8oly
         WVdW7deE08JJrkJVsKcYFk1M9hl0rwbW53seeYsXm4sstH6jG/zIX5xS/yEUeJj+zAkb
         wheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683171197; x=1685763197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mTDMySHrnRMrVKv9Dk+Mu/TJmsBqRn45hMZsS7Ztb/c=;
        b=IcNuHh64tmr+bI2AwJ95LzhOSHeTUUOeSE81Y8EYqmTXp4cXVDOMmARczh3X7Son8V
         odtXTM2FFDugucmxW3CEZsfHe2OoXDrLwYBYW6IjETuZm9YBAEOoPOlT2LLHMKseJ8Fl
         8KMkHiSW1l7qBeE7DmiqrWoNyZpV7oigzvZKr3Zpqqt8oH7SZoCXpL+To0xtIOdMO3kq
         sA9vwOWG4NopkLHrGWTEcUhfptK23CRqIJgMLesxjFEObBITnW/DVYm3P2MS3GbMNjbE
         zosKMQ+nwKyfumZ2VtscBOrPU6bnOexs9WFq2keCXJnJnu+ryG52JXlg3wX1dygvVIuD
         mwMw==
X-Gm-Message-State: AC+VfDw/aANHkZs99Gjmd+WQWy1StLsS0tFXTax5/t6Sb5nxuJjzVbSU
        v5vqX8jBXae5i+Rszcrt6XLjLePYzL2S2raVtcY=
X-Google-Smtp-Source: ACHHUZ6t3Rx/j7aF8+jIFYBkmezLdqbpgB1h9lbP0+/KIjP1WG3W2JNKEqTGuH0aHDe1W77S1Noahw==
X-Received: by 2002:a17:902:e5cd:b0:1a5:3da:84cb with SMTP id u13-20020a170902e5cd00b001a503da84cbmr2548378plf.21.1683171197344;
        Wed, 03 May 2023 20:33:17 -0700 (PDT)
Received: from [10.200.10.82] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id r12-20020a170902be0c00b001a0567811fbsm22322951pls.127.2023.05.03.20.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 20:33:17 -0700 (PDT)
Message-ID: <915edff9-1753-2a0b-327f-ba11e6c5a7b1@bytedance.com>
Date:   Thu, 4 May 2023 11:33:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 26/34] maple_tree: Update testing code for
 mas_{next,prev,walk}
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
 <20230425140955.3834476-27-Liam.Howlett@oracle.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230425140955.3834476-27-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/4/25 22:09, Liam R. Howlett 写道:
> Now that the functions have changed the limits, update the testing of
> the maple tree to test these new settings.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>   lib/test_maple_tree.c | 641 +++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 635 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
> index ae08d34d1d3c4..345eef526d8b0 100644
> --- a/lib/test_maple_tree.c
> +++ b/lib/test_maple_tree.c
> @@ -1290,6 +1290,7 @@ static noinline void __init check_root_expand(struct maple_tree *mt)
>   	mas_lock(&mas);
>   	mas_set(&mas, 3);
>   	ptr = mas_walk(&mas);
> +	MAS_BUG_ON(&mas, mas.index != 0);
>   	MT_BUG_ON(mt, ptr != NULL);
>   	MT_BUG_ON(mt, mas.index != 0);
>   	MT_BUG_ON(mt, mas.last != ULONG_MAX);
> @@ -1300,7 +1301,7 @@ static noinline void __init check_root_expand(struct maple_tree *mt)
>   
>   	mas_set(&mas, 0);
>   	ptr = mas_walk(&mas);
> -	MT_BUG_ON(mt, ptr != NULL);
> +	MAS_BUG_ON(&mas, ptr != NULL);
>   
>   	mas_set(&mas, 1);
>   	ptr = mas_walk(&mas);
> @@ -1359,7 +1360,7 @@ static noinline void __init check_root_expand(struct maple_tree *mt)
>   	mas_store_gfp(&mas, ptr, GFP_KERNEL);
>   	ptr = mas_next(&mas, ULONG_MAX);
>   	MT_BUG_ON(mt, ptr != NULL);
> -	MT_BUG_ON(mt, (mas.index != 1) && (mas.last != ULONG_MAX));
> +	MAS_BUG_ON(&mas, (mas.index != ULONG_MAX) && (mas.last != ULONG_MAX));
>   
>   	mas_set(&mas, 1);
>   	ptr = mas_prev(&mas, 0);
> @@ -1768,12 +1769,12 @@ static noinline void __init check_iteration(struct maple_tree *mt)
>   			mas.index = 760;
>   			mas.last = 765;
>   			mas_store(&mas, val);
> -			mas_next(&mas, ULONG_MAX);
>   		}
>   		i++;
>   	}
>   	/* Make sure the next find returns the one after 765, 766-769 */
>   	val = mas_find(&mas, ULONG_MAX);
> +	MAS_BUG_ON(&mas, val != xa_mk_value(76));
>   	MT_BUG_ON(mt, val != xa_mk_value(76));
>   	mas_unlock(&mas);
>   	mas_destroy(&mas);
> @@ -1979,7 +1980,7 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
>   
>   	val = mas_next(&mas, ULONG_MAX);
>   	MT_BUG_ON(mt, val != NULL);
> -	MT_BUG_ON(mt, mas.index != ULONG_MAX);
> +	MT_BUG_ON(mt, mas.index != 0x7d6);
>   	MT_BUG_ON(mt, mas.last != ULONG_MAX);
>   
>   	val = mas_prev(&mas, 0);
> @@ -2003,7 +2004,8 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
>   	val = mas_prev(&mas, 0);
>   	MT_BUG_ON(mt, val != NULL);
>   	MT_BUG_ON(mt, mas.index != 0);
> -	MT_BUG_ON(mt, mas.last != 0);
> +	MT_BUG_ON(mt, mas.last != 5);
> +	MT_BUG_ON(mt, mas.node != MAS_NONE);
>   
>   	mas.index = 0;
>   	mas.last = 5;
> @@ -2015,7 +2017,7 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
>   	val = mas_prev(&mas, 0);
>   	MT_BUG_ON(mt, val != NULL);
>   	MT_BUG_ON(mt, mas.index != 0);
> -	MT_BUG_ON(mt, mas.last != 0);
> +	MT_BUG_ON(mt, mas.last != 9);
>   	mas_unlock(&mas);
>   
>   	mtree_destroy(mt);
> @@ -2718,6 +2720,629 @@ static noinline void __init check_empty_area_fill(struct maple_tree *mt)
>   	mt_set_non_kernel(0);
>   }
>   
> +/*
> + * Check MAS_START, MAS_PAUSE, active (implied), and MAS_NONE transitions.
> + *
> + * The table below shows the single entry tree (0-0 pointer) and normal tree
> + * with nodes.
> + *
> + * Function	ENTRY	Start		Result		index & last
> + *     ┬          ┬       ┬               ┬                ┬
> + *     │          │       │               │                └─ the final range
> + *     │          │       │               └─ The node value after execution
> + *     │          │       └─ The node value before execution
> + *     │          └─ If the entry exists of does not exists (DNE)
of->or?
> + *     └─ The function name
> + *
> + * Function	ENTRY	Start		Result		index & last
> + * mas_next()
> + *  - after last
> + *			Single entry tree at 0-0
> + *			------------------------
> + *		DNE	MAS_START	MAS_NONE	1 - oo
> + *		DNE	MAS_PAUSE	MAS_NONE	1 - oo
> + *		DNE	MAS_ROOT	MAS_NONE	1 - oo
> + *			when index = 0
> + *		DNE	MAS_NONE	MAS_ROOT	0
> + *			when index > 0
> + *		DNE	MAS_NONE	MAS_NONE	1 - oo
> + *
> + *			Normal tree
> + *			-----------
> + *		exists	MAS_START	active		range
> + *		DNE	MAS_START	active		set to last range
> + *		exists	MAS_PAUSE	active		range
> + *		DNE	MAS_PAUSE	active		set to last range
> + *		exists	MAS_NONE	active		range
> + *		exists	active		active		range
> + *		DNE	active		active		set to last range
> + *
> + * Function	ENTRY	Start		Result		index & last
> + * mas_prev()
> + * - before index
> + *			Single entry tree at 0-0
> + *			------------------------
> + *				if index > 0
> + *		exists	MAS_START	MAS_ROOT	0
> + *		exists	MAS_PAUSE	MAS_ROOT	0
> + *		exists	MAS_NONE	MAS_ROOT	0
> + *
> + *				if index == 0
> + *		DNE	MAS_START	MAS_NONE	0
> + *		DNE	MAS_PAUSE	MAS_NONE	0
> + *		DNE	MAS_NONE	MAS_NONE	0
> + *		DNE	MAS_ROOT	MAS_NONE	0
> + *
> + *			Normal tree
> + *			-----------
> + *		exists	MAS_START	active		range
> + *		DNE	MAS_START	active		set to min
> + *		exists	MAS_PAUSE	active		range
> + *		DNE	MAS_PAUSE	active		set to min
> + *		exists	MAS_NONE	active		range
> + *		DNE	MAS_NONE	MAS_NONE	set to min
> + *		any	MAS_ROOT	MAS_NONE	0
> + *		exists	active		active		range
> + *		DNE	active		active		last range
> + *
> + * Function	ENTRY	Start		Result		index & last
> + * mas_find()
> + *  - at index or next
> + *			Single entry tree at 0-0
> + *			------------------------
> + *				if index >  0
> + *		DNE	MAS_START	MAS_NONE	0
> + *		DNE	MAS_PAUSE	MAS_NONE	0
> + *		DNE	MAS_ROOT	MAS_NONE	0
> + *		DNE	MAS_NONE	MAS_NONE	0
> + *				if index ==  0
> + *		exists	MAS_START	MAS_ROOT	0
> + *		exists	MAS_PAUSE	MAS_ROOT	0
> + *		exists	MAS_NONE	MAS_ROOT	0
> + *
> + *			Normal tree
> + *			-----------
> + *		exists	MAS_START	active		range
> + *		DNE	MAS_START	active		set to max
> + *		exists	MAS_PAUSE	active		range
> + *		DNE	MAS_PAUSE	active		set to max
> + *		exists	MAS_NONE	active		range
> + *		exists	active		active		range
> + *		DNE	active		active		last range (max < last)
> + *
> + * Function	ENTRY	Start		Result		index & last
> + * mas_find_rev()
> + *  - at index or before
> + *			Single entry tree at 0-0
> + *			------------------------
> + *				if index >  0
> + *		exists	MAS_START	MAS_ROOT	0
> + *		exists	MAS_PAUSE	MAS_ROOT	0
> + *		exists	MAS_NONE	MAS_ROOT	0
> + *				if index ==  0
> + *		DNE	MAS_START	MAS_NONE	0
> + *		DNE	MAS_PAUSE	MAS_NONE	0
> + *		DNE	MAS_NONE	MAS_NONE	0
> + *		DNE	MAS_ROOT	MAS_NONE	0
> + *
> + *			Normal tree
> + *			-----------
> + *		exists	MAS_START	active		range
> + *		DNE	MAS_START	active		set to min
> + *		exists	MAS_PAUSE	active		range
> + *		DNE	MAS_PAUSE	active		set to min
> + *		exists	MAS_NONE	active		range
> + *		exists	active		active		range
> + *		DNE	active		active		last range (min > index)
> + *
> + * Function	ENTRY	Start		Result		index & last
> + * mas_walk()
> + * - Look up index
> + *			Single entry tree at 0-0
> + *			------------------------
> + *				if index >  0
> + *		DNE	MAS_START	MAS_ROOT	1 - oo
> + *		DNE	MAS_PAUSE	MAS_ROOT	1 - oo
> + *		DNE	MAS_NONE	MAS_ROOT	1 - oo
> + *		DNE	MAS_ROOT	MAS_ROOT	1 - oo
> + *				if index ==  0
> + *		exists	MAS_START	MAS_ROOT	0
> + *		exists	MAS_PAUSE	MAS_ROOT	0
> + *		exists	MAS_NONE	MAS_ROOT	0
> + *		exists	MAS_ROOT	MAS_ROOT	0
> + *
> + *			Normal tree
> + *			-----------
> + *		exists	MAS_START	active		range
> + *		DNE	MAS_START	active		range of NULL
> + *		exists	MAS_PAUSE	active		range
> + *		DNE	MAS_PAUSE	active		range of NULL
> + *		exists	MAS_NONE	active		range
> + *		DNE	MAS_NONE	active		range of NULL
> + *		exists	active		active		range
> + *		DNE	active		active		range of NULL
> + */
> +
> +#define mas_active(x)		(((x).node != MAS_ROOT) && \
> +				 ((x).node != MAS_START) && \
> +				 ((x).node != MAS_PAUSE) && \
> +				 ((x).node != MAS_NONE))
> +static noinline void __init check_state_handling(struct maple_tree *mt)
> +{
> +	MA_STATE(mas, mt, 0, 0);
> +	void *entry, *ptr = (void *) 0x1234500;
> +	void *ptr2 = &ptr;
> +	void *ptr3 = &ptr2;
> +
> +	/* Check MAS_ROOT First */
> +	mtree_store_range(mt, 0, 0, ptr, GFP_KERNEL);
> +
> +	mas_lock(&mas);
> +	/* prev: Start -> none */
> +	entry = mas_prev(&mas, 0);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
> +
> +	/* prev: Start -> root */
> +	mas_set(&mas, 10);
> +	entry = mas_prev(&mas, 0);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0);
> +	MAS_BUG_ON(&mas, mas.last != 0);
> +	MAS_BUG_ON(&mas, mas.node != MAS_ROOT);
> +
> +	/* prev: pause -> root */
> +	mas_set(&mas, 10);
> +	mas_pause(&mas);
> +	entry = mas_prev(&mas, 0);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0);
> +	MAS_BUG_ON(&mas, mas.last != 0);
> +	MAS_BUG_ON(&mas, mas.node != MAS_ROOT);
> +
> +	/* next: start -> none */
> +	mas_set(&mas, 0);
> +	entry = mas_next(&mas, ULONG_MAX);
> +	MAS_BUG_ON(&mas, mas.index != 1);
> +	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
> +
> +	/* next: start -> none */
> +	mas_set(&mas, 10);
> +	entry = mas_next(&mas, ULONG_MAX);
> +	MAS_BUG_ON(&mas, mas.index != 1);
> +	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
> +
> +	/* find: start -> root */
> +	mas_set(&mas, 0);
> +	entry = mas_find(&mas, ULONG_MAX);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0);
> +	MAS_BUG_ON(&mas, mas.last != 0);
> +	MAS_BUG_ON(&mas, mas.node != MAS_ROOT);
> +
> +	/* find: root -> none */
> +	entry = mas_find(&mas, ULONG_MAX);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.index != 1);
> +	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
> +	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
> +
> +	/* find: none -> none */
> +	entry = mas_find(&mas, ULONG_MAX);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.index != 1);
> +	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
> +	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
> +
> +	/* find: start -> none */
> +	mas_set(&mas, 10);
> +	entry = mas_find(&mas, ULONG_MAX);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.index != 1);
> +	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
> +	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
> +
> +	/* find_rev: none -> root */
> +	entry = mas_find_rev(&mas, 0);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0);
> +	MAS_BUG_ON(&mas, mas.last != 0);
> +	MAS_BUG_ON(&mas, mas.node != MAS_ROOT);
> +
> +	/* find_rev: start -> root */
> +	mas_set(&mas, 0);
> +	entry = mas_find_rev(&mas, 0);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0);
> +	MAS_BUG_ON(&mas, mas.last != 0);
> +	MAS_BUG_ON(&mas, mas.node != MAS_ROOT);
> +
> +	/* find_rev: root -> none */
> +	entry = mas_find_rev(&mas, 0);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.index != 0);
> +	MAS_BUG_ON(&mas, mas.last != 0);
> +	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
> +
> +	/* find_rev: none -> none */
> +	entry = mas_find_rev(&mas, 0);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.index != 0);
> +	MAS_BUG_ON(&mas, mas.last != 0);
> +	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
> +
> +	/* find_rev: start -> root */
> +	mas_set(&mas, 10);
> +	entry = mas_find_rev(&mas, 0);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0);
> +	MAS_BUG_ON(&mas, mas.last != 0);
> +	MAS_BUG_ON(&mas, mas.node != MAS_ROOT);
> +
> +	/* walk: start -> none */
> +	mas_set(&mas, 10);
> +	entry = mas_walk(&mas);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.index != 1);
> +	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
> +	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
> +
> +	/* walk: pause -> none*/
> +	mas_set(&mas, 10);
> +	mas_pause(&mas);
> +	entry = mas_walk(&mas);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.index != 1);
> +	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
> +	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
> +
> +	/* walk: none -> none */
> +	mas.index = mas.last = 10;
> +	entry = mas_walk(&mas);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.index != 1);
> +	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
> +	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
> +
> +	/* walk: none -> none */
> +	entry = mas_walk(&mas);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.index != 1);
> +	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
> +	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
> +
> +	/* walk: start -> root */
> +	mas_set(&mas, 0);
> +	entry = mas_walk(&mas);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0);
> +	MAS_BUG_ON(&mas, mas.last != 0);
> +	MAS_BUG_ON(&mas, mas.node != MAS_ROOT);
> +
> +	/* walk: pause -> root */
> +	mas_set(&mas, 0);
> +	mas_pause(&mas);
> +	entry = mas_walk(&mas);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0);
> +	MAS_BUG_ON(&mas, mas.last != 0);
> +	MAS_BUG_ON(&mas, mas.node != MAS_ROOT);
> +
> +	/* walk: none -> root */
> +	mas.node = MAS_NONE;
> +	entry = mas_walk(&mas);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0);
> +	MAS_BUG_ON(&mas, mas.last != 0);
> +	MAS_BUG_ON(&mas, mas.node != MAS_ROOT);
> +
> +	/* walk: root -> root */
> +	entry = mas_walk(&mas);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0);
> +	MAS_BUG_ON(&mas, mas.last != 0);
> +	MAS_BUG_ON(&mas, mas.node != MAS_ROOT);
> +
> +	/* walk: root -> none */
> +	mas_set(&mas, 10);
> +	entry = mas_walk(&mas);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.index != 1);
> +	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
> +	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
> +
> +	/* walk: none -> root */
> +	mas.index = mas.last = 0;
> +	entry = mas_walk(&mas);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0);
> +	MAS_BUG_ON(&mas, mas.last != 0);
> +	MAS_BUG_ON(&mas, mas.node != MAS_ROOT);
> +
> +	mas_unlock(&mas);
> +
> +	/* Check when there is an actual node */
> +	mtree_store_range(mt, 0, 0, NULL, GFP_KERNEL);
> +	mtree_store_range(mt, 0x1000, 0x1500, ptr, GFP_KERNEL);
> +	mtree_store_range(mt, 0x2000, 0x2500, ptr2, GFP_KERNEL);
> +	mtree_store_range(mt, 0x3000, 0x3500, ptr3, GFP_KERNEL);
> +
> +	mas_lock(&mas);
> +
> +	/* next: start ->active */
> +	mas_set(&mas, 0);
> +	entry = mas_next(&mas, ULONG_MAX);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0x1000);
> +	MAS_BUG_ON(&mas, mas.last != 0x1500);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* next: pause ->active */
> +	mas_set(&mas, 0);
> +	mas_pause(&mas);
> +	entry = mas_next(&mas, ULONG_MAX);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0x1000);
> +	MAS_BUG_ON(&mas, mas.last != 0x1500);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* next: none ->active */
> +	mas.index = mas.last = 0;
> +	mas.offset = 0;
> +	mas.node = MAS_NONE;
> +	entry = mas_next(&mas, ULONG_MAX);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0x1000);
> +	MAS_BUG_ON(&mas, mas.last != 0x1500);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* next:active ->active */
> +	entry = mas_next(&mas, ULONG_MAX);
> +	MAS_BUG_ON(&mas, entry != ptr2);
> +	MAS_BUG_ON(&mas, mas.index != 0x2000);
> +	MAS_BUG_ON(&mas, mas.last != 0x2500);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* next:active -> active out of range*/
> +	entry = mas_next(&mas, 0x2999);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.index != 0x2501);
> +	MAS_BUG_ON(&mas, mas.last != 0x2fff);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* Continue after out of range*/
> +	entry = mas_next(&mas, ULONG_MAX);
> +	MAS_BUG_ON(&mas, entry != ptr3);
> +	MAS_BUG_ON(&mas, mas.index != 0x3000);
> +	MAS_BUG_ON(&mas, mas.last != 0x3500);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* next:active -> active out of range*/
> +	entry = mas_next(&mas, ULONG_MAX);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.index != 0x3501);
> +	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* next: none -> active, skip value at location */
> +	mas_set(&mas, 0);
> +	entry = mas_next(&mas, ULONG_MAX);
> +	mas.node = MAS_NONE;
> +	mas.offset = 0;
> +	entry = mas_next(&mas, ULONG_MAX);
> +	MAS_BUG_ON(&mas, entry != ptr2);
> +	MAS_BUG_ON(&mas, mas.index != 0x2000);
> +	MAS_BUG_ON(&mas, mas.last != 0x2500);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* prev:active ->active */
> +	entry = mas_prev(&mas, 0);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0x1000);
> +	MAS_BUG_ON(&mas, mas.last != 0x1500);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* prev:active -> active out of range*/
> +	entry = mas_prev(&mas, 0);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.index != 0);
> +	MAS_BUG_ON(&mas, mas.last != 0x0FFF);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* prev: pause ->active */
> +	mas_set(&mas, 0x3600);
> +	entry = mas_prev(&mas, 0);
> +	MAS_BUG_ON(&mas, entry != ptr3);
> +	mas_pause(&mas);
> +	entry = mas_prev(&mas, 0);
> +	MAS_BUG_ON(&mas, entry != ptr2);
> +	MAS_BUG_ON(&mas, mas.index != 0x2000);
> +	MAS_BUG_ON(&mas, mas.last != 0x2500);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* prev:active -> active out of range*/
> +	entry = mas_prev(&mas, 0x1600);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.index != 0x1501);
> +	MAS_BUG_ON(&mas, mas.last != 0x1FFF);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* prev: active ->active, continue*/
> +	entry = mas_prev(&mas, 0);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0x1000);
> +	MAS_BUG_ON(&mas, mas.last != 0x1500);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* find: start ->active */
> +	mas_set(&mas, 0);
> +	entry = mas_find(&mas, ULONG_MAX);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0x1000);
> +	MAS_BUG_ON(&mas, mas.last != 0x1500);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* find: pause ->active */
> +	mas_set(&mas, 0);
> +	mas_pause(&mas);
> +	entry = mas_find(&mas, ULONG_MAX);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0x1000);
> +	MAS_BUG_ON(&mas, mas.last != 0x1500);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* find: start ->active on value */;
> +	mas_set(&mas, 1200);
> +	entry = mas_find(&mas, ULONG_MAX);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0x1000);
> +	MAS_BUG_ON(&mas, mas.last != 0x1500);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* find:active ->active */
> +	entry = mas_find(&mas, ULONG_MAX);
> +	MAS_BUG_ON(&mas, entry != ptr2);
> +	MAS_BUG_ON(&mas, mas.index != 0x2000);
> +	MAS_BUG_ON(&mas, mas.last != 0x2500);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +
> +	/* find:active -> active (NULL)*/
> +	entry = mas_find(&mas, 0x2700);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.index != 0x2501);
> +	MAS_BUG_ON(&mas, mas.last != 0x2FFF);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* find: none ->active */
> +	entry = mas_find(&mas, 0x5000);
> +	MAS_BUG_ON(&mas, entry != ptr3);
> +	MAS_BUG_ON(&mas, mas.index != 0x3000);
> +	MAS_BUG_ON(&mas, mas.last != 0x3500);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* find:active -> active (NULL) end*/
> +	entry = mas_find(&mas, ULONG_MAX);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.index != 0x3501);
> +	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* find_rev: active (END) ->active */
> +	entry = mas_find_rev(&mas, 0);
> +	MAS_BUG_ON(&mas, entry != ptr3);
> +	MAS_BUG_ON(&mas, mas.index != 0x3000);
> +	MAS_BUG_ON(&mas, mas.last != 0x3500);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* find_rev:active ->active */
> +	entry = mas_find_rev(&mas, 0);
> +	MAS_BUG_ON(&mas, entry != ptr2);
> +	MAS_BUG_ON(&mas, mas.index != 0x2000);
> +	MAS_BUG_ON(&mas, mas.last != 0x2500);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* find_rev: pause ->active */
> +	mas_pause(&mas);
> +	entry = mas_find_rev(&mas, 0);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0x1000);
> +	MAS_BUG_ON(&mas, mas.last != 0x1500);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* find_rev:active -> active */
> +	entry = mas_find_rev(&mas, 0);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.index != 0);
> +	MAS_BUG_ON(&mas, mas.last != 0x0FFF);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* find_rev: start ->active */
> +	mas_set(&mas, 0x1200);
> +	entry = mas_find_rev(&mas, 0);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0x1000);
> +	MAS_BUG_ON(&mas, mas.last != 0x1500);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* mas_walk start ->active */
> +	mas_set(&mas, 0x1200);
> +	entry = mas_walk(&mas);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0x1000);
> +	MAS_BUG_ON(&mas, mas.last != 0x1500);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* mas_walk start ->active */
> +	mas_set(&mas, 0x1600);
> +	entry = mas_walk(&mas);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.index != 0x1501);
> +	MAS_BUG_ON(&mas, mas.last != 0x1fff);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* mas_walk pause ->active */
> +	mas_set(&mas, 0x1200);
> +	mas_pause(&mas);
> +	entry = mas_walk(&mas);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0x1000);
> +	MAS_BUG_ON(&mas, mas.last != 0x1500);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* mas_walk pause -> active */
> +	mas_set(&mas, 0x1600);
> +	mas_pause(&mas);
> +	entry = mas_walk(&mas);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.index != 0x1501);
> +	MAS_BUG_ON(&mas, mas.last != 0x1fff);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* mas_walk none -> active */
> +	mas_set(&mas, 0x1200);
> +	mas.node = MAS_NONE;
> +	entry = mas_walk(&mas);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0x1000);
> +	MAS_BUG_ON(&mas, mas.last != 0x1500);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* mas_walk none -> active */
> +	mas_set(&mas, 0x1600);
> +	mas.node = MAS_NONE;
> +	entry = mas_walk(&mas);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.index != 0x1501);
> +	MAS_BUG_ON(&mas, mas.last != 0x1fff);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* mas_walk active -> active */
> +	mas.index = 0x1200;
> +	mas.last = 0x1200;
> +	mas.offset = 0;
> +	entry = mas_walk(&mas);
> +	MAS_BUG_ON(&mas, entry != ptr);
> +	MAS_BUG_ON(&mas, mas.index != 0x1000);
> +	MAS_BUG_ON(&mas, mas.last != 0x1500);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	/* mas_walk active -> active */
> +	mas.index = 0x1600;
> +	mas.last = 0x1600;
> +	entry = mas_walk(&mas);
> +	MAS_BUG_ON(&mas, entry != NULL);
> +	MAS_BUG_ON(&mas, mas.index != 0x1501);
> +	MAS_BUG_ON(&mas, mas.last != 0x1fff);
> +	MAS_BUG_ON(&mas, !mas_active(mas));
> +
> +	mas_unlock(&mas);
> +}
> +
>   static DEFINE_MTREE(tree);
>   static int __init maple_tree_seed(void)
>   {
> @@ -2979,6 +3604,10 @@ static int __init maple_tree_seed(void)
>   	mtree_destroy(&tree);
>   
>   
> +	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
> +	check_state_handling(&tree);
> +	mtree_destroy(&tree);
> +
>   #if defined(BENCH)
>   skip:
>   #endif
