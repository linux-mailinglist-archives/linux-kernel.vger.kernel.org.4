Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A2A635FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238828AbiKWNdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238848AbiKWNcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:32:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5037D6F358
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:17:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C75281F85D;
        Wed, 23 Nov 2022 13:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669209444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BwHThTpYm4ogWgiikA57PW4WR5H2lDWMkGSpVJhBdAQ=;
        b=1LaCHmhMTUOmzes6tF4T0u/nAJDQ3PberecBaI531n5rvnFq+GRgMF/6AMADSLomJyoEMy
        7iO5E7WdKjNSsRVF1c+Me9oip+Rmo2KNxQdXUoFJg4HGbfZXoxOA34IvgWHnSU0exHXyKv
        928cVDirLHkxUKJ+fQV9QalNPQhrJ4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669209444;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BwHThTpYm4ogWgiikA57PW4WR5H2lDWMkGSpVJhBdAQ=;
        b=5od+xeF3ejKfwKoFoxF772QplZmHVfCAoyGAoSgICdLOgXmQ35QvUURDhMedCKNpsVbKCA
        ECsMxpYGhEoBRGCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0C9013A37;
        Wed, 23 Nov 2022 13:17:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /Nt7JmQdfmPgfQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 23 Nov 2022 13:17:24 +0000
Message-ID: <0afc97c8-2b43-8a0b-8884-20347438a347@suse.cz>
Date:   Wed, 23 Nov 2022 14:17:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] mm/tracing: Add check for kmem_cache
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, rostedt@goodmis.org,
        mhiramat@kernel.org, 42.hyeyoo@gmail.com, vasily.averin@linux.dev,
        akpm@linux-foundation.org, shakeelb@google.com,
        vvghjk1234@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20221123111001.34855-1-jiasheng@iscas.ac.cn>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221123111001.34855-1-jiasheng@iscas.ac.cn>
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

On 11/23/22 12:10, Jiasheng Jiang wrote:
> In __kmem_cache_alloc_lru() of mm/slab.c, cachep may be NULL when error
> occurs in slab_alloc().

Are you sure? AFAICS internally in slab_alloc_node(), slab_pre_alloc_hook()
can return NULL which is assigned to cachep local variable, but only NULL
propagated back to __kmem_cache_alloc_lru() is the object, not cachep.
So trace_kmem_cache_alloc() should only see NULL s, if it was already NULL
when passed to kmem_cache_alloc(), at which point the NULL is dereferenced
and crashing (as expected) earlier than reaching the tracepoint.

> However, trace_kmem_cache_alloc() will still use it as the parameter,
> which may cause NULL poineter dereference.
> Therefore, it should be better to add the check and handle the error
> in the trace_kmem_cache_alloc().
> 
> Fixes: 36555751c675 ("kmemtrace: SLAB hooks.")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  include/trace/events/kmem.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> index 243073cfc29d..d99507d32ef5 100644
> --- a/include/trace/events/kmem.h
> +++ b/include/trace/events/kmem.h
> @@ -32,8 +32,8 @@ TRACE_EVENT(kmem_cache_alloc,
>  	TP_fast_assign(
>  		__entry->call_site	= call_site;
>  		__entry->ptr		= ptr;
> -		__entry->bytes_req	= s->object_size;
> -		__entry->bytes_alloc	= s->size;
> +		__entry->bytes_req	= s ? s->object_size : 0;
> +		__entry->bytes_alloc	= s ? s->size : 0;
>  		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
>  		__entry->node		= node;
>  		__entry->accounted	= IS_ENABLED(CONFIG_MEMCG_KMEM) ?

