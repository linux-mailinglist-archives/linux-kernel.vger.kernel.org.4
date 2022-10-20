Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FF0605A1E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiJTIm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiJTImz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:42:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAB3161FC0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666255373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j1iLSA1qAVvUAJ90BnDlPL9tsmmgvjQsGUXqLRV/pk0=;
        b=FNf5RFT0hCZK1ZO6F8Jr6zOAJXFI81l0EIbIE3G2gvzgAPubTHY6ETVOQgSdlpwnocfDGA
        22tsRYovEMbFbHtSjBb9tX8mDcgPkeH3MwipIrjrafcy0FxK+KT0k+4/4qELz65ywGAzqb
        zocMX91ahtAYc1uv32EMJCZEmvUaBso=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-116-oWdZ-bpwOaqqfVhdMxpZBA-1; Thu, 20 Oct 2022 04:42:52 -0400
X-MC-Unique: oWdZ-bpwOaqqfVhdMxpZBA-1
Received: by mail-qv1-f71.google.com with SMTP id mz8-20020a0562142d0800b004b18a95b180so12166149qvb.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1iLSA1qAVvUAJ90BnDlPL9tsmmgvjQsGUXqLRV/pk0=;
        b=I13ul+sJY2URd4ZbHRMHasKjRNhKVwmhVKIp/4nrDUtLOXzBivsTFLRiz2j+fR3XJX
         pB6ep8Vb6/V1dRQFI+w2E863xn9A3Glsp+UbO1m+xgO34yysGqqUB0mAHQVm7e8vI9W/
         7kFDM+BCQ74QA+FdFlAUjVXN6gXnOqnipk52Cb16ejC4j8LI1tNw4bZiMkBKBNcwtgZ7
         xEfZy8mnzdnUVrZTv/QFJ1O8zBXmRYo+7maMVjqqAJljqWi8rpZ2lQDw0icnDfeKKAuX
         pJ5x14jFfJCjcA7FF1qZVImlY4jTM9yMjQnUc8u6+aPVPGsfWA+FeL2+WrfkjmyWXK4r
         DWUQ==
X-Gm-Message-State: ACrzQf2YptIfLuZmbFWDwabrvf3DVYXLQuM5VPlT0XbSfCAWEfLyxxBt
        EtGapcdX4QkXpLzJ03sACdHcYXw0uayYEEsTO+HACCV5f8ymgQM0C9Td2jh2KF5QAkvbZKeiB2J
        7Q4jaXDUiKTzm3BdfLvTnlBta
X-Received: by 2002:a05:6214:4015:b0:4b1:78f2:8dfd with SMTP id kd21-20020a056214401500b004b178f28dfdmr10406524qvb.81.1666255371682;
        Thu, 20 Oct 2022 01:42:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4G2Ly824JslpAOrsCImj1qgPlZpL3LIwzhVcfllshLKLi54wpuecLxDHYV9pp8Hrk72ONAJQ==
X-Received: by 2002:a05:6214:4015:b0:4b1:78f2:8dfd with SMTP id kd21-20020a056214401500b004b178f28dfdmr10406506qvb.81.1666255371453;
        Thu, 20 Oct 2022 01:42:51 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-103-235.dyn.eolo.it. [146.241.103.235])
        by smtp.gmail.com with ESMTPSA id ew5-20020a05622a514500b0039cc9d24843sm5705563qtb.66.2022.10.20.01.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 01:42:50 -0700 (PDT)
Message-ID: <0ea1fc165a6c6117f982f4f135093e69cb884930.camel@redhat.com>
Subject: Re: [PATCH v3][next] skbuff: Proactively round up to kmalloc bucket
 size
From:   Paolo Abeni <pabeni@redhat.com>
To:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Menglong Dong <imagedong@tencent.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Thu, 20 Oct 2022 10:42:47 +0200
In-Reply-To: <20221018093005.give.246-kees@kernel.org>
References: <20221018093005.give.246-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 2022-10-18 at 02:33 -0700, Kees Cook wrote:
> Instead of discovering the kmalloc bucket size _after_ allocation, round
> up proactively so the allocation is explicitly made for the full size,
> allowing the compiler to correctly reason about the resulting size of
> the buffer through the existing __alloc_size() hint.
> 
> This will allow for kernels built with CONFIG_UBSAN_BOUNDS or the
> coming dynamic bounds checking under CONFIG_FORTIFY_SOURCE to gain
> back the __alloc_size() hints that were temporarily reverted in commit
> 93dd04ab0b2b ("slab: remove __alloc_size attribute from __kmalloc_track_caller")
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v3: refactor again to pass allocation size more cleanly to callers
> v2: https://lore.kernel.org/lkml/20220923202822.2667581-4-keescook@chromium.org/
> ---
>  net/core/skbuff.c | 41 ++++++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 1d9719e72f9d..3ea1032d03ec 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -425,11 +425,12 @@ EXPORT_SYMBOL(napi_build_skb);
>   * memory is free
>   */
>  static void *kmalloc_reserve(size_t size, gfp_t flags, int node,
> -			     bool *pfmemalloc)
> +			     bool *pfmemalloc, size_t *alloc_size)
>  {
>  	void *obj;
>  	bool ret_pfmemalloc = false;
>  
> +	size = kmalloc_size_roundup(size);
>  	/*
>  	 * Try a regular allocation, when that fails and we're not entitled
>  	 * to the reserves, fail.
> @@ -448,6 +449,7 @@ static void *kmalloc_reserve(size_t size, gfp_t flags, int node,
>  	if (pfmemalloc)
>  		*pfmemalloc = ret_pfmemalloc;
>  
> +	*alloc_size = size;
>  	return obj;
>  }
>  
> @@ -479,7 +481,7 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
>  {
>  	struct kmem_cache *cache;
>  	struct sk_buff *skb;
> -	unsigned int osize;
> +	size_t alloc_size;
>  	bool pfmemalloc;
>  	u8 *data;
>  
> @@ -506,15 +508,15 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
>  	 */
>  	size = SKB_DATA_ALIGN(size);
>  	size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> -	data = kmalloc_reserve(size, gfp_mask, node, &pfmemalloc);
> -	if (unlikely(!data))
> -		goto nodata;

I'm sorry for not noticing the above in the previous iteration, but I
think this revision will produce worse code than the V1, as
kmalloc_reserve() now pollutes an additional register.

Why did you prefer adding an additional parameter to kmalloc_reserve()?
I think computing the alloc_size in the caller is even more readable.

Additionally, as a matter of personal preference, I would not introduce
an additional variable for alloc_size, just:

	// ...
	size = kmalloc_size_roundup(size);
	data = kmalloc_reserve(size, gfp_mask, node, &pfmemalloc);

The rationale is smaller diff, and consistent style with the existing
code where 'size' is already adjusted multiple times icrementally.

Cheers,

Paolo

