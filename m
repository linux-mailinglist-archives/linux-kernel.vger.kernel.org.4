Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99CB66433B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjAJO2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjAJO2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:28:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2466C1C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:28:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8C0864EE9B;
        Tue, 10 Jan 2023 14:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673360892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ifLyQ+MOB8va2XR1K/FSEoQ13TM793cM+jcIwLQQ1I=;
        b=FWFe/2g3VcdAzJMPRdwrZ/OV4tN95vwMMNoC8plTb9de6EmMq3WlidVmHDvga3gj+unvfS
        LQGtgpctufOtAovPRn+ZLX+g59MWli6aVvXivzuKbo0sFH3gIWzLL66S0b3jt7IhZsyoT6
        kGwDynhFTtXsMT1xiPgKXujn9R2Puw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673360892;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ifLyQ+MOB8va2XR1K/FSEoQ13TM793cM+jcIwLQQ1I=;
        b=6lEdOHu4gM5jCStFiKTGkzXIvnRYZV/jQZj3Wnw6qGvDjmyc4OyNmubcBNTEMiWpGuCES8
        lfENQdqnaiBv3ZAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EFC41358A;
        Tue, 10 Jan 2023 14:28:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0W16Gvx1vWOcXgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 10 Jan 2023 14:28:12 +0000
Message-ID: <1e862dbf-1618-c546-f0d9-ca54f129285c@suse.cz>
Date:   Tue, 10 Jan 2023 15:28:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] mm/sl{a,u}b: fix wrong usages of folio_page() for getting
 head pages
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org
Cc:     willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20230110005124.1609-1-sj@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230110005124.1609-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/23 01:51, SeongJae Park wrote:
> The standard idiom for getting head page of a given folio is
> '&folio->page', but some are wrongly using 'folio_page(folio, 0)' for
> the purpose.  Fix those to use the idiom.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: SeongJae Park <sj@kernel.org>

Thanks, pushed to slab/for-6.3/cleanups

> ---
>  mm/slab.c | 4 ++--
>  mm/slub.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index b77be9c6d6b1..a5398676dc60 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1389,7 +1389,7 @@ static void kmem_freepages(struct kmem_cache *cachep, struct slab *slab)
>  
>  	BUG_ON(!folio_test_slab(folio));
>  	__slab_clear_pfmemalloc(slab);
> -	page_mapcount_reset(folio_page(folio, 0));
> +	page_mapcount_reset(&folio->page);
>  	folio->mapping = NULL;
>  	/* Make the mapping reset visible before clearing the flag */
>  	smp_wmb();
> @@ -1398,7 +1398,7 @@ static void kmem_freepages(struct kmem_cache *cachep, struct slab *slab)
>  	if (current->reclaim_state)
>  		current->reclaim_state->reclaimed_slab += 1 << order;
>  	unaccount_slab(slab, order, cachep);
> -	__free_pages(folio_page(folio, 0), order);
> +	__free_pages(&folio->page, order);
>  }
>  
>  static void kmem_rcu_free(struct rcu_head *head)
> diff --git a/mm/slub.c b/mm/slub.c
> index 67020074ecb4..d5f20c062004 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2066,7 +2066,7 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
>  	if (current->reclaim_state)
>  		current->reclaim_state->reclaimed_slab += pages;
>  	unaccount_slab(slab, order, s);
> -	__free_pages(folio_page(folio, 0), order);
> +	__free_pages(&folio->page, order);
>  }
>  
>  static void rcu_free_slab(struct rcu_head *h)

