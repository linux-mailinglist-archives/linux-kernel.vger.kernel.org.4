Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3DD6FE079
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbjEJOgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237366AbjEJOgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:36:15 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A6483CD
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:35:31 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-52c30fbccd4so6616089a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683729331; x=1686321331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bTpSjY8dX/y2zw0+NUgDM2A5G47HoQ8GogR43hjUa+4=;
        b=U1BL7pDWdm6dMgdRlYEOsn3jJ6itpMbTnfKk4p5qEwlDqp8kiNataTmNTlWgZet2CV
         KnuZQwYCPuozY32mLmNHfejB4ko8pgMHHq07odHo4IJFsV61QzZpkXIkWgrxcG4IPG33
         rdI474FkDKXtC+ssqTsqUJFniv1/Q60bZBpHhziKMMJaGuOXdHJTvSVwaBtkvBlnCEma
         rSf6pyMDO3u0CZM5fJ8jp4xc0F9MficrxIMpX5aq1XFLba4UDC4FcTW/HBxxNJYv/w4D
         CSIh9bjxJ0Q3Ya8QdvaHbgBN0ZATdo32Zrsw50ttJ6+sne6tR0iVXKN6oZLvIZuTfMzB
         kwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683729331; x=1686321331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTpSjY8dX/y2zw0+NUgDM2A5G47HoQ8GogR43hjUa+4=;
        b=U5sZNeXRmHYyeM9GH8vxKHuGDaxjY+NN86NhwNHzuDrq4VgDKnSyFl7RanZG88t4RY
         +u23y7Qgv3QvVmqMoj3CVlK+UJpV6uKRWGy9V2oGjUMmUTUN7HBk5ZWOtFM5vf08DRVg
         N3MoUu9r4JiZIM8GKWy0LmI9ypzboeOXPWNVKu5wYWHkReWNGDahpG+JW/GluqKoEPv6
         seCsRBUfYbOnhisdcvGpusULH+RvKVFxRW6nDNkuHHOoit/EPcSe3E4IKfANdaoxC0FI
         rVtnrSPcZ0tkAxi9MhmK7crea/VgZbuLHQqZY6hkYUkoLtYk7vkGpDR9aUL2LfDFuA3j
         mQXg==
X-Gm-Message-State: AC+VfDytpaMrk1XW/6vnejgXlNRUKuv18Cah9fk7piLNstT8GoXHVc3k
        XDE2lXwwCGGyVU01CpnXeTm07Q==
X-Google-Smtp-Source: ACHHUZ6LlHvWjeKdwipRJtpid2l1hYqXh/C154EJzieaxeO/rFUIva+U+OxJyW22thRzh/C4w8vlgg==
X-Received: by 2002:a17:90b:190f:b0:24e:16ae:61ca with SMTP id mp15-20020a17090b190f00b0024e16ae61camr17257306pjb.34.1683729330995;
        Wed, 10 May 2023 07:35:30 -0700 (PDT)
Received: from [10.255.19.214] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id bx15-20020a17090af48f00b00246f9725ffcsm21611374pjb.33.2023.05.10.07.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 07:35:30 -0700 (PDT)
Message-ID: <d2abfe0c-0152-860c-60f7-2787973c95d0@bytedance.com>
Date:   Wed, 10 May 2023 22:35:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: Re: [PATCH] sock: Fix misuse of sk_under_memory_pressure()
To:     Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230506085903.96133-1-wuyun.abel@bytedance.com>
 <588689343dcd6c904e7fc142a001043015e5b14e.camel@redhat.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <588689343dcd6c904e7fc142a001043015e5b14e.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo, thanks very much for comment!

On 5/9/23 3:52 PM, Paolo Abeni wrote:
> On Sat, 2023-05-06 at 16:59 +0800, Abel Wu wrote:
>> The commit 180d8cd942ce ("foundations of per-cgroup memory pressure
>> controlling") wrapped proto::memory_pressure status into an accessor
>> named sk_under_memory_pressure(), and in the next commit e1aab161e013
>> ("socket: initial cgroup code") added the consideration of net-memcg
>> pressure into this accessor.
>>
>> But with the former patch applied, not all of the call sites of
>> sk_under_memory_pressure() are interested in net-memcg's pressure.
>> The __sk_mem_{raise,reduce}_allocated() only focus on proto/netns
>> pressure rather than net-memcg's.
> 
> Why do you state the above? The current behavior is established since
> ~12y, arguably we can state quite the opposite.
> 
> I think this patch should at least target net-next, and I think we need
> a more detailed reasoning to introduce such behavior change.

Sorry for failed to provide a reasonable explanation... When @allocated
is no more than tcp_mem[0], the global tcp_mem pressure is gone even if
the socket's memcg is under pressure.

This reveals that prot::memory_pressure only considers the global tcp
memory pressure, and is irrelevant to the memcg's. IOW if we're updating
prot::memory_pressure or making desicions upon prot::memory_pressure,
the memcg stat should not be considered and sk_under_memory_pressure()
should not be called since it considers both.

> 
>> IOW this accessor are generally
>> used for deciding whether should reclaim or not.
>>
>> Fixes: e1aab161e013 ("socket: initial cgroup code")
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> ---
>>   include/net/sock.h |  5 -----
>>   net/core/sock.c    | 17 +++++++++--------
>>   2 files changed, 9 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index 8b7ed7167243..752d51030c5a 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -1404,11 +1404,6 @@ static inline int sk_under_cgroup_hierarchy(struct sock *sk,
>>   #endif
>>   }
>>   
>> -static inline bool sk_has_memory_pressure(const struct sock *sk)
>> -{
>> -	return sk->sk_prot->memory_pressure != NULL;
>> -}
>> -
>>   static inline bool sk_under_memory_pressure(const struct sock *sk)
>>   {
>>   	if (!sk->sk_prot->memory_pressure)
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index 5440e67bcfe3..8d215f821ea6 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -3017,13 +3017,14 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
>>   		}
>>   	}
>>   
>> -	if (sk_has_memory_pressure(sk)) {
>> -		u64 alloc;
>> -
>> -		if (!sk_under_memory_pressure(sk))
>> -			return 1;
>> -		alloc = sk_sockets_allocated_read_positive(sk);
>> -		if (sk_prot_mem_limits(sk, 2) > alloc *
>> +	if (prot->memory_pressure) {
>> +		/*
>> +		 * If under global pressure, allow the sockets that are below
>> +		 * average memory usage to raise, trying to be fair between all
>> +		 * the sockets under global constrains.
>> +		 */
>> +		if (!*prot->memory_pressure ||
>> +		    sk_prot_mem_limits(sk, 2) > sk_sockets_allocated_read_positive(sk) *
> 
> The above introduces unrelated changes that makes the code IMHO less
> readable - I don't see a good reason to drop the 'alloc' variable.
Besides drop the @alloc variable, this change also removes the condition
of memcg's pressure from sk_under_memory_pressure() due to the reason
aforementioned. I can re-introduce @alloc in the next version if you
think it makes code more readable.

Thanks & Best,
	Abel

