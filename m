Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F075EAB79
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiIZPpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbiIZPoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:44:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576685E66B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:29:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 102C91F899;
        Mon, 26 Sep 2022 14:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664202560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=msezDbUBbMMaEKZkaR9Cxg7iF8T83ElsnAJUDKpPaBM=;
        b=qPZo+vy6b2umJ1r6o0eIlrQ06OEMQ4zvC69M6QEaiJlY4+3Eivwa/ulX8MDfu2zOGJHtJo
        tvSai6xoNG7sTbRk80a0IjE7muA1CXjGJ++dupw47NnKxL3etjh/WTnH2FiL27s3XGsNeU
        dujJqNa9l6mIT7QjQ5nb+COTfmpiUPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664202560;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=msezDbUBbMMaEKZkaR9Cxg7iF8T83ElsnAJUDKpPaBM=;
        b=Kty9zgf4Dhf1HiIqbS9E1dvVYDiIMeihfVRcBGfS2Q5OhvXsKNGUAQ6CXw7FRWeB4FA9wI
        6ROk0Xl6Nnwt8YBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BED5113486;
        Mon, 26 Sep 2022 14:29:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WKyXLT+3MWPNCgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 26 Sep 2022 14:29:19 +0000
Message-ID: <61bbbf65-9397-ac7d-9b57-2bfe5f0375ff@suse.cz>
Date:   Mon, 26 Sep 2022 16:29:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3] mm/slub: clean up create_unique_id()
Content-Language: en-US
To:     Chao Yu <chao@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hugh@veritas.com>
Cc:     Chao Yu <chao.yu@oppo.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220926142042.2725-1-chao@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220926142042.2725-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/22 16:20, Chao Yu wrote:
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
>          if (p > name + ID_STR_LENGTH - 1) {
>                  kfree(name);
>                  return -E<something>;
>          }
> "
> 
> According to above suggestion, let's do below cleanups:
> 1. reduce ID_STR_LENGTH to 32, as the buffer size should be enough;
> 2. use WARN_ON instead of BUG_ON() and return error if check condition
> is true;
> 3. use snprintf instead of sprintf to avoid overflow.
> 
> Link: https://lore.kernel.org/linux-mm/2025305d-16db-abdf-6cd3-1fb93371c2b4@wanadoo.fr/
> Fixes: 81819f0fc828 ("SLUB core")
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Signed-off-by: Chao Yu <chao.yu@oppo.com>

Thanks, added to slab.git for-next.

> ---
> v3:
> - clean up codes
> - fix size parameter of snprintf()
>   mm/slub.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 4b98dff9be8e..4d3ee0924533 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5890,7 +5890,7 @@ static inline struct kset *cache_kset(struct kmem_cache *s)
>   	return slab_kset;
>   }
>   
> -#define ID_STR_LENGTH 64
> +#define ID_STR_LENGTH 32
>   
>   /* Create a unique string id for a slab cache:
>    *
> @@ -5924,9 +5924,12 @@ static char *create_unique_id(struct kmem_cache *s)
>   		*p++ = 'A';
>   	if (p != name + 1)
>   		*p++ = '-';
> -	p += sprintf(p, "%07u", s->size);
> +	p += snprintf(p, ID_STR_LENGTH - (p - name), "%07u", s->size);
>   
> -	BUG_ON(p > name + ID_STR_LENGTH - 1);
> +	if (WARN_ON(p > name + ID_STR_LENGTH - 1)) {
> +		kfree(name);
> +		return ERR_PTR(-EINVAL);
> +	}
>   	return name;
>   }
>   

