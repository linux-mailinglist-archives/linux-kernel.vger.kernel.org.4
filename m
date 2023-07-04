Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466B3746D48
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjGDJ0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjGDJ0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:26:14 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8E8B6;
        Tue,  4 Jul 2023 02:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=dqtmIxbNifx0ASyE7vPUiMcgbpvNHFd86ifBe6b/c3Q=; b=hp1h9O13K4M0nCG4aQvgTxGVdh
        1IVvh0paFFGpu981/toaLnD4cIJMUq5HB32i+SU9bkrLKATtV8/nzHDnY2DDy2YgAPNYzxlZzYbXc
        tKxUzN9X7MO8IkpkPFIDF7ELFzsl43Nbk+ZNs9XXL4Uu6/yEL9RQbyNsleh1l9UwLp3s7qgug32Ab
        6xwIXwplxQ5uu3tgjscvYRD4qY9q8sIV4EkqLQFRtlzLLCl0vjW3dtgdWeQgRydxF0HxJKxXFP0z7
        2e7Kr2luv/ciR+8GUQC0jS+hPDUGMJLJ0LhLUgy/RoH6UPbDNyVScPuzjoRC+VVdy+/2hQxCc95eb
        X9SVRTkA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qGcIP-00036E-II; Tue, 04 Jul 2023 11:26:05 +0200
Received: from [81.6.34.132] (helo=localhost.localdomain)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qGcIP-000G0v-25; Tue, 04 Jul 2023 11:26:05 +0200
Subject: Re: [PATCH] libbpf: fix some typo of hashmap init
To:     John Sanpe <sanpeqf@gmail.com>, ast@kernel.org, andrii@kernel.org
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230704085429.3110340-1-sanpeqf@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2af93aa0-a81d-d783-b946-dc7ffc875f4c@iogearbox.net>
Date:   Tue, 4 Jul 2023 11:26:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230704085429.3110340-1-sanpeqf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26959/Tue Jul  4 09:29:23 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/23 10:54 AM, John Sanpe wrote:
> rename macro parameters to prevent replacing struct members of hashmap
> 
> Signed-off-by: John Sanpe <sanpeqf@gmail.com>
> ---
>   tools/lib/bpf/hashmap.h | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
> index 0a5bf1937a7c..bae3feaf29d0 100644
> --- a/tools/lib/bpf/hashmap.h
> +++ b/tools/lib/bpf/hashmap.h
> @@ -80,14 +80,14 @@ struct hashmap {
>   	size_t sz;
>   };
>   
> -#define HASHMAP_INIT(hash_fn, equal_fn, ctx) {	\
> -	.hash_fn = (hash_fn),			\
> -	.equal_fn = (equal_fn),			\
> -	.ctx = (ctx),				\
> -	.buckets = NULL,			\
> -	.cap = 0,				\
> -	.cap_bits = 0,				\
> -	.sz = 0,				\
> +#define HASHMAP_INIT(_hash_fn, _equal_fn, _ctx) {	\
> +	.hash_fn = (_hash_fn),				\
> +	.equal_fn = (_equal_fn),			\
> +	.ctx = (_ctx),					\
> +	.buckets = NULL,				\
> +	.cap = 0,					\
> +	.cap_bits = 0,					\
> +	.sz = 0,					\
>   }
>   
>   void hashmap__init(struct hashmap *map, hashmap_hash_fn hash_fn,
> 

Please send a v2 and just remove the whole HASHMAP_INIT. It's not used
anywhere in libbpf.
