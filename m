Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55AC5FEA40
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 10:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJNIPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 04:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJNIPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:15:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F866C941
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:15:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B73011F383;
        Fri, 14 Oct 2022 08:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665735327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wiClufEX8gfPW9xRDiuGe0Q9e36uYJDoy7apgwehwGU=;
        b=e5jz93ekyXrf97a9Sinalx2ZrBWTmpzb4T4BP3dcgQjKq7XsCG3EfJB6cShHzMIQUIEoIF
        nF/LWqe3EvNEQmQlUc3x5mt22rYUl7tQinIJY7RDAuVzPJkeiwFvrBUuVhstsp7kd0l8X/
        64KbW0bnNafCXnyTpzs7vSQ5IKVPXwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665735327;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wiClufEX8gfPW9xRDiuGe0Q9e36uYJDoy7apgwehwGU=;
        b=GvYODW4J4vZUr6xg7tg4yBXSZJ3wK3M8EoV+tpCh1ueBt9U82jQkfJ6626hqSKOVYaPDvs
        QXwMtughU/mtA/AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EB6E13A4A;
        Fri, 14 Oct 2022 08:15:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b2AGIp8aSWMDdQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 14 Oct 2022 08:15:27 +0000
Message-ID: <e0fc92a3-3e4f-b82b-f52c-0745d0e1ba09@suse.cz>
Date:   Fri, 14 Oct 2022 10:15:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] mm: slub: remove dead and buggy code from
 sysfs_slab_add()
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220930084742.771804-1-linux@rasmusvillemoes.dk>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220930084742.771804-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/22 10:47, Rasmus Villemoes wrote:
> The function sysfs_slab_add() has two callers:
> 
> One is slab_sysfs_init(), which first initializes slab_kset, and only
> when that succeeds sets slab_state to FULL, and then proceeds to call
> sysfs_slab_add() for all previously created slabs.
> 
> The other is __kmem_cache_create(), but only after a
> 
> 	if (slab_state <= UP)
> 		return 0;
> 
> check.
> 
> So in other words, sysfs_slab_add() is never called without
> slab_kset (aka the return value of cache_kset()) being non-NULL.
> 
> And this is just as well, because if we ever did take this path and
> called kobject_init(&s->kobj), and then later when called again from
> slab_sysfs_init() would end up calling kobject_init_and_add(), we
> would hit
> 
> 	if (kobj->state_initialized) {
> 		/* do not error out as sometimes we can recover */
> 		pr_err("kobject (%p): tried to init an initialized object, something is seriously wrong.\n",
> 		dump_stack();
> 	}
> 
> in kobject.c.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Thanks, added to slab.git for-6.2/slub-sysfs

> ---
>  mm/slub.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 4b98dff9be8e..04a7f75a7b1f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5937,11 +5937,6 @@ static int sysfs_slab_add(struct kmem_cache *s)
>  	struct kset *kset = cache_kset(s);
>  	int unmergeable = slab_unmergeable(s);
>  
> -	if (!kset) {
> -		kobject_init(&s->kobj, &slab_ktype);
> -		return 0;
> -	}
> -
>  	if (!unmergeable && disable_higher_order_debug &&
>  			(slub_debug & DEBUG_METADATA_FLAGS))
>  		unmergeable = 1;

