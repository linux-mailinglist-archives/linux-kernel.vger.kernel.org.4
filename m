Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABE26BD07F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjCPNO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjCPNOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:14:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853E5CDD9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/aWedzsw7s5dh5oPwPfRoS0tq8TyVis1dtJ7OKpO1Dc=; b=F7JDAF+3N4UWoW/9MmOE/cinBW
        YRLtE3ctmv5dizaO+XGmKATzdOkAdXS8brbF9tZIRRadpypqsnqkTl4y7PsEr2jFiVVUPmH63PwNV
        6ymi5FwwLOxXfimYVjg9wtyy+iklrSDsLuGiZTtGIwouFj2u/u17zpDH9H7JDciyZ8uBA0k900WKX
        32/fo4ZT/QoaFaypjz4NN0Y0MVGoFvbRWqA+RCOSbtcEjtLKpGWdgEQ01dPmDxDwGN9s0fugk3m0z
        BIbujheg0Se9qKFA/UXIVm00QgT/2nG1mhv6h77PA2PqyD3z2LggYkV2XKeq/on+P7XmV3vBEnbWC
        QQ+cB8XA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcnQj-00EqgY-Jt; Thu, 16 Mar 2023 13:14:05 +0000
Date:   Thu, 16 Mar 2023 13:14:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     yang.yang29@zte.com.cn
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iamjoonsoo.kim@lge.com
Subject: Re: =?iso-8859-1?Q?=A0=5BPATCH_linux-next?=
 =?iso-8859-1?Q?=5D_mm=3A_workingset=3A_simplify_the=A0calculatio?=
 =?iso-8859-1?Q?n?= of workingset size
Message-ID: <ZBMWHUJfFnIX7F9y@casper.infradead.org>
References: <202303161723055514455@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303161723055514455@zte.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 05:23:05PM +0800, yang.yang29@zte.com.cn wrote:
>  	 * Compare the distance to the existing workingset size. We
>  	 * don't activate pages that couldn't stay resident even if
> -	 * all the memory was available to the workingset. Whether
> -	 * workingset competition needs to consider anon or not depends
> -	 * on having swap.
> +	 * all the memory was available to the workingset. For page
> +	 * cache whether workingset competition needs to consider
> +	 * anon or not depends on having swap.

I don't mind this change

>  	 */
>  	workingset_size = lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
> +	/* For anonymous page */

This comment adds no value

>  	if (!file) {
> +		workingset_size += lruvec_page_state(eviction_lruvec,
> +						     NR_ACTIVE_ANON);
>  		workingset_size += lruvec_page_state(eviction_lruvec,
>  						     NR_INACTIVE_FILE);
> -	}
> -	if (mem_cgroup_get_nr_swap_pages(eviction_memcg) > 0) {
> +	/* For page cache */

Nor this one

> +	} else if (mem_cgroup_get_nr_swap_pages(eviction_memcg) > 0) {
>  		workingset_size += lruvec_page_state(eviction_lruvec,
>  						     NR_ACTIVE_ANON);
> -		if (file) {
> -			workingset_size += lruvec_page_state(eviction_lruvec,
> +		workingset_size += lruvec_page_state(eviction_lruvec,
>  						     NR_INACTIVE_ANON);
> -		}
>  	}

I don't have an opinion on the actual code changes.
