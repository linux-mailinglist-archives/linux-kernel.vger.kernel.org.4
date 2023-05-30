Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB609716F86
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjE3VQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjE3VQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:16:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B88619B
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:15:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 158CB632F1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 21:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15857C433D2;
        Tue, 30 May 2023 21:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1685481348;
        bh=BsfsJT3RNDghO1BT+q5WEVurwj/3UqhWOXK4IIuJXH0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nhW6W/5iMxjAytttCC/K0zmpFkn4MmAKCh7wCaQOd1LqQjyVlMgFDQTgS8OLrob4x
         oa487zz/93lbMOX92PMcBDA/Wer/rq2x+mO/TSkalpdppofj/A0m6ucNO9+TReWccc
         GyLKULTJ8HLXWO/KshhR3T1rOOLDLsRCdTMNX0Pk=
Date:   Tue, 30 May 2023 14:15:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: zswap: support exclusive loads
Message-Id: <20230530141547.609c4a434470c3fbf7570ff8@linux-foundation.org>
In-Reply-To: <20230530210251.493194-1-yosryahmed@google.com>
References: <20230530210251.493194-1-yosryahmed@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 21:02:51 +0000 Yosry Ahmed <yosryahmed@google.com> wrote:

> Commit 71024cb4a0bf ("frontswap: remove frontswap_tmem_exclusive_gets")
> removed support for exclusive loads from frontswap as it was not used.
> 
> Bring back exclusive loads support to frontswap by adding an
> exclusive_loads argument to frontswap_ops. Add support for exclusive
> loads to zswap behind CONFIG_ZSWAP_EXCLUSIVE_LOADS.

Why is this Kconfigurable?  Why not just enable the feature for all
builds?

> Refactor zswap entry invalidation in zswap_frontswap_invalidate_page()
> into zswap_invalidate_entry() to reuse it in zswap_frontswap_load().
> 
> With exclusive loads, we avoid having two copies of the same page in
> memory (compressed & uncompressed) after faulting it in from zswap. On
> the other hand, if the page is to be reclaimed again without being
> dirtied, it will be re-compressed. Compression is not usually slow, and
> a page that was just faulted in is less likely to be reclaimed again
> soon.
> 
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -46,6 +46,19 @@ config ZSWAP_DEFAULT_ON
>  	  The selection made here can be overridden by using the kernel
>  	  command line 'zswap.enabled=' option.
>  
> +config ZSWAP_EXCLUSIVE_LOADS
> +	bool "Invalidate zswap entries when pages are loaded"
> +	depends on ZSWAP
> +	help
> +	  If selected, when a page is loaded from zswap, the zswap entry is
> +	  invalidated at once, as opposed to leaving it in zswap until the
> +	  swap entry is freed.
> +
> +	  This avoids having two copies of the same page in memory
> +	  (compressed and uncompressed) after faulting in a page from zswap.
> +	  The cost is that if the page was never dirtied and needs to be
> +	  swapped out again, it will be re-compressed.

So it's a speed-vs-space tradeoff?  I'm not sure how users are to
decide whether they want this.  Did we help them as much as possible?


