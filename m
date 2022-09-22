Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C5B5E6D59
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiIVUrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIVUrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:47:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0264410AB31
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:47:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 30D5B21A1B;
        Thu, 22 Sep 2022 20:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663879635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G91bghnzz5qsrAZ1KwKzy4Is49Fx+R+59WwLRAB/H7c=;
        b=LD5f5mRsPBBGv/unmS6PKW+8j11tQoCJyDUIk5V1s2vWTiFyabHvrtykwnhRBcbqBaTR+d
        di6/nPRJUx4b/EhRF1K/dzkLmo5Dx7PpP7tl9ZRbKqNz0K7m1h1fwozP3PEua41K74uaJB
        8e+i8oYCm95dB7pVQ413LQLI4Kc2pIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663879635;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G91bghnzz5qsrAZ1KwKzy4Is49Fx+R+59WwLRAB/H7c=;
        b=bqkZQTDBGGe6kA9+RxsH35mSaR2qMh34fY0Dbv/LZvMMd/n/OzSrhrllMdPYaaSfAK3Okt
        ezS9Mvx2iP6vmVBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB6EA13AA5;
        Thu, 22 Sep 2022 20:47:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 44fJONLJLGO6IQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 22 Sep 2022 20:47:14 +0000
Message-ID: <719a7ea0-c152-af03-8f6c-7dda702d1863@suse.cz>
Date:   Thu, 22 Sep 2022 22:47:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] mm/slub: clean up create_unique_id()
Content-Language: en-US
To:     Chao Yu <chao@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Hugh Dickins <hugh@veritas.com>
Cc:     Chao Yu <chao.yu@oppo.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Christoph Lameter <clameter@sgi.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220918092146.4060783-1-chao@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220918092146.4060783-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/22 11:21, Chao Yu wrote:
> From: Chao Yu <chao.yu@oppo.com>
> 
> As Christophe JAILLET suggested:
> 
> In create_unique_id(),
> 
> "looks that ID_STR_LENGTH could even be reduced to 32 or 16.
> 
> The 2nd BUG_ON at the end of the function could certainly be just
> removed as well or remplaced by a:
>         if (p > name + ID_STR_LENGTH - 1) {
>                 kfree(name);
>                 return -E<something>;
>         }
> "
> 
> According to above suggestion, let's do below cleanups:
> 1. reduce ID_STR_LENGTH to 32, as the buffer size should be enough;
> 2. remove BUG_ON() and return error if check condition is true.

I'd leave a WARN_ON there as we really don't expect this to happen, so if it
does, we should be loud about it and not silently fail.

> Link: https://lore.kernel.org/linux-mm/2025305d-16db-abdf-6cd3-1fb93371c2b4@wanadoo.fr/
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Fixes: 81819f0fc828 ("SLUB core")
> Signed-off-by: Chao Yu <chao.yu@oppo.com>
> ---
>  mm/slub.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 5ba6db62a5ab..a045c1ca8772 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5883,7 +5883,7 @@ static inline struct kset *cache_kset(struct kmem_cache *s)
>  	return slab_kset;
>  }
>  
> -#define ID_STR_LENGTH 64
> +#define ID_STR_LENGTH 32
>  
>  /* Create a unique string id for a slab cache:
>   *
> @@ -5919,7 +5919,10 @@ static char *create_unique_id(struct kmem_cache *s)
>  		*p++ = '-';
>  	p += sprintf(p, "%07u", s->size);

Hm but sprintf() will happily overflow, so if we only detect that
afterwards, it's kinda too late to gracefully fail.
Should use snprintf() then?

> -	BUG_ON(p > name + ID_STR_LENGTH - 1);
> +	if (p > name + ID_STR_LENGTH - 1) {
> +		kfree(name);
> +		return ERR_PTR(-EINVAL);
> +	}
>  	return name;
>  }
>  

