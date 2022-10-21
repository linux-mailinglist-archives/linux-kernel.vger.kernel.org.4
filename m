Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B388607544
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJUKn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJUKnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:43:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD6B25F1F2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:43:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5A35C2271B;
        Fri, 21 Oct 2022 10:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666349023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TA7eXrG7O3B23odrrkOkZeSr4Pfu3eeY9ko+Mp8d0go=;
        b=xUaaGYFVu0gPmo4L0tL7e2f/7X+LfimgY+c5ACBUf69XBQbcB02ILZ/tCQYZAgjM5UbdyG
        iCfJWI4RiCd1S/0BiNU3udYY8iRbJEbKOY0LW2ScOuS0wj0SqgX1CHZ0v4Vc/7j3XPvHsv
        6eIZ2eiF1f0AM+0sBOpg/ZvebBQ9SEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666349023;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TA7eXrG7O3B23odrrkOkZeSr4Pfu3eeY9ko+Mp8d0go=;
        b=OUEt6dx5IOWptug7O299I3fq+sUl422kxESBxABV83D15QaX2vFZpaGPgRGbKzzwPWNulT
        qEtinpFISPFgwpAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 344E51331A;
        Fri, 21 Oct 2022 10:43:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FIktDN93UmPAJAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 21 Oct 2022 10:43:43 +0000
Message-ID: <82e8147e-f031-6bc2-9395-56d2052e62cb@suse.cz>
Date:   Fri, 21 Oct 2022 12:43:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] mm/slub: remove dead code for debug caches on
 deactivate_slab()
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20221014114322.97512-1-42.hyeyoo@gmail.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221014114322.97512-1-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 13:43, Hyeonggon Yoo wrote:
> After commit c7323a5ad0786 ("mm/slub: restrict sysfs validation to debug
> caches and make it safe"), SLUB does not take a slab from partial list for

I'm confused by "SLUB does not take a slab from partial list" here. Did you
mean something like "SLUB never installs (even temporarily) a percpu slab
for debug caches"? So that means we never deactivate percpu slabs for debug
caches. And since debug caches are also the only ones that use the full
list, we no longer need to care about the full list in deactivate_slab(), right?

> debug caches. As deactivation isn't needed anymore, remove dead code.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Otherwise it looks correct to me, just wanted to clarify I'm not missing
something.

> ---
>  mm/slub.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 96dd392d7f99..e2215240954d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2411,7 +2411,7 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
>  static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>  			    void *freelist)
>  {
> -	enum slab_modes { M_NONE, M_PARTIAL, M_FULL, M_FREE, M_FULL_NOLIST };
> +	enum slab_modes { M_NONE, M_PARTIAL, M_FREE, M_FULL_NOLIST };
>  	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
>  	int free_delta = 0;
>  	enum slab_modes mode = M_NONE;
> @@ -2487,14 +2487,6 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>  		 * acquire_slab() will see a slab that is frozen
>  		 */
>  		spin_lock_irqsave(&n->list_lock, flags);
> -	} else if (kmem_cache_debug_flags(s, SLAB_STORE_USER)) {
> -		mode = M_FULL;
> -		/*
> -		 * This also ensures that the scanning of full
> -		 * slabs from diagnostic functions will not see
> -		 * any frozen slabs.
> -		 */
> -		spin_lock_irqsave(&n->list_lock, flags);
>  	} else {
>  		mode = M_FULL_NOLIST;
>  	}
> @@ -2504,7 +2496,7 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>  				old.freelist, old.counters,
>  				new.freelist, new.counters,
>  				"unfreezing slab")) {
> -		if (mode == M_PARTIAL || mode == M_FULL)
> +		if (mode == M_PARTIAL)
>  			spin_unlock_irqrestore(&n->list_lock, flags);
>  		goto redo;
>  	}
> @@ -2518,10 +2510,6 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>  		stat(s, DEACTIVATE_EMPTY);
>  		discard_slab(s, slab);
>  		stat(s, FREE_SLAB);
> -	} else if (mode == M_FULL) {
> -		add_full(s, n, slab);
> -		spin_unlock_irqrestore(&n->list_lock, flags);
> -		stat(s, DEACTIVATE_FULL);
>  	} else if (mode == M_FULL_NOLIST) {
>  		stat(s, DEACTIVATE_FULL);
>  	}

