Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB03073A644
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjFVQmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjFVQmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:42:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7CB1FE6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687452105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKQxo2ybKG3VitBeJfoexX4S6PJQFIvYCFny4nwoy3Y=;
        b=BI6pljdJIHVaYYIhkuJTqiTRaHnfZYoGBx0jNmlnbfbL38w5mm7RhKIW/7oOwJGE/0sG4C
        YJTQAkfHNPA7ik1p04WYNsMuZmVIc797Rvcdp0pA4jEhU57qnNQWV1iX9QFUl+F6PVsqrn
        SYh+3Zshsjl77lvgr9GN2AoGnTAk1ls=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-KoHvMP2fOXOeJSUJvnhfcw-1; Thu, 22 Jun 2023 12:41:34 -0400
X-MC-Unique: KoHvMP2fOXOeJSUJvnhfcw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1b679ec24f7so21557115ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687452086; x=1690044086;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKQxo2ybKG3VitBeJfoexX4S6PJQFIvYCFny4nwoy3Y=;
        b=BOKADNWdMo1tkunr93ZghfFLZRp7hQBGJLTtnlQ4MPgzFhF9RkquTpjuhmPnLvMQHa
         8I+ElLiDm+2Ckfjk2ZtKwqnOFrY9pMnNAFO+EO//o791lNXsrMZKZuDUUKoeNGQx8qb/
         pY5i71uR7lg1GoZVgqT9vYe3QAyeVDbmYDfrNs/koepwSMzj4BUctMM8VVTWxKJVrp75
         CbOHRaSqX0GAorM9NuPGPI1mXMWcWw0k6fzms2kTmsvrnhxsYutmbh6f032t6kQvpJcT
         uCd32tWWZKDJcifqe15blEcCW90SZtGbZy95xSbRe1Bz3ALuKPF0QXu/h1zcSs+EfJkG
         NyLg==
X-Gm-Message-State: AC+VfDzfVtuJkJNgztPHOx3U8TQbkPxZM4TjxGghZpeDBou2SI+f69uU
        RAOQPr6gX8Ptkz+nadL3wECxTMhY08LTsOrBcz/TOL1a4UiZvPwmZW0dymdtk2Ull0PtY4R6N4o
        p+YexbmPzFyksxccbtMtx9QO7
X-Received: by 2002:a17:902:d682:b0:1b2:a63:9587 with SMTP id v2-20020a170902d68200b001b20a639587mr8026095ply.36.1687452086556;
        Thu, 22 Jun 2023 09:41:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ70F0+HQZlh5eNwYNO6SGbE2N5G7FJeFBkwR3g4WVuO3ZqYMiBjBKa4G94Qgr+Vu1E+d8T3Jw==
X-Received: by 2002:a17:902:d682:b0:1b2:a63:9587 with SMTP id v2-20020a170902d68200b001b20a639587mr8026077ply.36.1687452086223;
        Thu, 22 Jun 2023 09:41:26 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id jk14-20020a170903330e00b001b536aaf7c2sm5639127plb.189.2023.06.22.09.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 09:41:25 -0700 (PDT)
Message-ID: <26d8fbcf-d34f-0a79-9d91-8c60e66f7341@redhat.com>
Date:   Thu, 22 Jun 2023 18:41:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 14/16] maple_tree: Refine mas_preallocate() node
 calculations
Content-Language: en-US
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        David Airlie <airlied@redhat.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
 <20230612203953.2093911-15-Liam.Howlett@oracle.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20230612203953.2093911-15-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/23 22:39, Liam R. Howlett wrote:
> Calculate the number of nodes based on the pending write action instead
> of assuming the worst case.

Liam already gave me a heads-up on this patch, which I already replied 
to [1].

However, I think it might make sense to also reply to this patch directly.

For a mas_preallocate() calculating the actual required nodes to be 
allocated instead of assuming the worst to work, it is required to 
ensure that the tree does not change between calling mas_preallocate() 
and mas_store_prealloc() if my understanding is correct.

In DRM however, more specifically the DRM GPUVA Manager [2], we do have 
the case that we are not able to ensure this:

Jobs to create GPU mappings can be submitted by userspace, are queued up 
by the kernel and are processed asynchronously in dma-fence signalling 
critical paths, e.g. by using the drm_gpu_scheduler. Hence, we must be 
able to allocate the worst case amount of node, since at the time a job 
is submitted we can't predict the state the maple tree keeping track of 
mappings has once a mapping is inserted in the (asynchronous) dma-fence 
signalling critical path.

A more detailed explanation can be found in [1].

Could we keep a separate function for allocating the worst case amount 
of nodes additionally to this optimization? E.g. something like 
mas_preallocate_worst_case() or mas_preallocate_unlocked() (since I 
guess the new one requires the maple tree to be kept locked in order not 
to change)?

[1] 
https://lore.kernel.org/nouveau/68cd25de-e767-725e-2e7b-703217230bb0@redhat.com/T/#ma326e200b1de1e3c9df4e9fcb3bf243061fee8b5

[2] 
https://lore.kernel.org/linux-mm/20230620004217.4700-8-dakr@redhat.com/T/#m47ab82310f87793d0f0cc1825a316eb30ad5b653

- Danilo

> 
> This addresses a performance regression introduced in platforms that
> have longer allocation timing.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>   lib/maple_tree.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 048d6413a114..7ac5b5457603 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5541,9 +5541,55 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
>    */
>   int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>   {
> +	MA_WR_STATE(wr_mas, mas, entry);
> +	unsigned char node_size;
> +	int request = 1;
>   	int ret;
>   
> -	mas_node_count_gfp(mas, 1 + mas_mt_height(mas) * 3, gfp);
> +
> +	if (unlikely(!mas->index && mas->last == ULONG_MAX))
> +		goto ask_now;
> +
> +	mas_wr_store_setup(&wr_mas);
> +	wr_mas.content = mas_start(mas);
> +	/* Root expand */
> +	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
> +		goto ask_now;
> +
> +	if (unlikely(!mas_wr_walk(&wr_mas))) {
> +		/* Spanning store, use worst case for now */
> +		request = 1 + mas_mt_height(mas) * 3;
> +		goto ask_now;
> +	}
> +
> +	/* At this point, we are at the leaf node that needs to be altered. */
> +	/* Exact fit, no nodes needed. */
> +	if (wr_mas.r_min == mas->index && wr_mas.r_max == mas->last)
> +		return 0;
> +
> +	mas_wr_end_piv(&wr_mas);
> +	node_size = mas_wr_new_end(&wr_mas);
> +	/* Slot store can avoid using any nodes */
> +	if (node_size == wr_mas.node_end && wr_mas.offset_end - mas->offset == 1)
> +		return 0;
> +
> +	if (node_size >= mt_slots[wr_mas.type]) {
> +		/* Split, worst case for now. */
> +		request = 1 + mas_mt_height(mas) * 2;
> +		goto ask_now;
> +	}
> +
> +	/* Appending does not need any nodes */
> +	if (node_size == wr_mas.node_end + 1 && mas->offset == wr_mas.node_end)
> +		return 0;
> +
> +	/* Potential spanning rebalance collapsing a node, use worst-case */
> +	if (node_size  - 1 <= mt_min_slots[wr_mas.type])
> +		request = mas_mt_height(mas) * 2 - 1;
> +
> +	/* node store needs one node */
> +ask_now:
> +	mas_node_count_gfp(mas, request, gfp);
>   	mas->mas_flags |= MA_STATE_PREALLOC;
>   	if (likely(!mas_is_err(mas)))
>   		return 0;

