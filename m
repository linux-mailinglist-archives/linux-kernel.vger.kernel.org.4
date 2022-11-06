Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4105A61E603
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 21:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiKFU4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 15:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiKFU4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 15:56:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FA5DFD2
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 12:56:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3035E22522;
        Sun,  6 Nov 2022 20:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667768161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZtjHZhTXVaGjQcJVa95fXnoOmRq7kv/Z46oADISZGSU=;
        b=HAkMG7zHvJxEfRZQcfZaiyCQUnZF0sQ/QvviRRjN25NoY7CJSDKuBxNzNmihz6WLaoCvM0
        jyc4wJWWQ8Xszwc7gXwNppmN351gq8BMZ79vMUtOqr2r/XE4LehQQ6QmOuDc2qcapN8vdn
        QRQ7R6G1YDKkTCkW7Vvd0EByzFdjWBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667768161;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZtjHZhTXVaGjQcJVa95fXnoOmRq7kv/Z46oADISZGSU=;
        b=EpUpFW9X9hU+kQuKMsWg56gKGJ4tA5iKd++PJ3c7LApVcYUZzDZj1b117Ks1wAfrbEVgyd
        Cgz/3xzQD5ets6AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E42B9132E7;
        Sun,  6 Nov 2022 20:56:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 43rbNmAfaGMOBwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sun, 06 Nov 2022 20:56:00 +0000
Message-ID: <b3776af5-65c7-62b4-7624-184420d0da63@suse.cz>
Date:   Sun, 6 Nov 2022 21:56:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 8/8] mm/slub, percpu: correct the calculation of early
 percpu allocation size
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20221024081435.204970-1-bhe@redhat.com>
 <20221024081435.204970-9-bhe@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221024081435.204970-9-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 10:14, Baoquan He wrote:
> SLUB allocator relies on percpu allocator to initialize its ->cpu_slab
> during early boot. For that, the dynamic chunk of percpu which serves
> the early allocation need be large enough to satisfy the kmalloc
> creation.
> 
> However, the current BUILD_BUG_ON() in alloc_kmem_cache_cpus() doesn't
> consider the kmalloc array with NR_KMALLOC_TYPES length. Fix that
> with correct calculation.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/slub.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

As only slub is touched and there's no prerequsities in the previous
patches, I took this to the slab tree, branch
slab/for-6.2/cleanups

Thanks!

> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 157527d7101b..8ac3bb9a122a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4017,7 +4017,8 @@ init_kmem_cache_node(struct kmem_cache_node *n)
>  static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
>  {
>  	BUILD_BUG_ON(PERCPU_DYNAMIC_EARLY_SIZE <
> -			KMALLOC_SHIFT_HIGH * sizeof(struct kmem_cache_cpu));
> +			NR_KMALLOC_TYPES * KMALLOC_SHIFT_HIGH *
> +			sizeof(struct kmem_cache_cpu));
>  
>  	/*
>  	 * Must align to double word boundary for the double cmpxchg

