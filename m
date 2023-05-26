Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB002712A1A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244122AbjEZP6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243698AbjEZP6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:58:51 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567A1F7;
        Fri, 26 May 2023 08:58:50 -0700 (PDT)
Received: from [10.10.2.69] (unknown [10.10.2.69])
        by mail.ispras.ru (Postfix) with ESMTPSA id 854ED40D403D;
        Fri, 26 May 2023 15:58:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 854ED40D403D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1685116728;
        bh=sZ8mdgkZi4Do7aNW4BbGNJlNBJlCPu2Np4nerPaxak4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lM7HTOJzO9Aqx5Lf4HEFwnjhSgFxYg73UKvn2UDFs4vLgFN841cvFGFY1OEANNG5s
         aOXwzilhH4QXxlVwrIP9ZpUf5t/tIOLW1vmhSWsnqvjlDKoVnJzhGf6RgKLA1cz8eQ
         GvImaG59IZsXFdkqT30JmjqNijgFJK61Pbz/XVH0=
Message-ID: <027d28a0-b31b-ab42-9eb6-2826c04c9364@ispras.ru>
Date:   Fri, 26 May 2023 18:58:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] udp6: Fix race condition in udp6_sendmsg & connect
Content-Language: ru
To:     Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20230526150806.1457828-1-VEfanov@ispras.ru>
 <27614af23cd7ae4433b909194062c553a6ae16ac.camel@redhat.com>
From:   =?UTF-8?B?0JXRhNCw0L3QvtCyINCS0LvQsNC00LjRgdC70LDQsiDQkNC70LXQutGB0LA=?=
         =?UTF-8?B?0L3QtNGA0L7QstC40Yc=?= <vefanov@ispras.ru>
In-Reply-To: <27614af23cd7ae4433b909194062c553a6ae16ac.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo,


I don't think that we can just move sk_dst_set() call.

I think we can destroy dst of sendmsg task in this case.


Best regards,

Vlad.


On 26.05.2023 18:33, Paolo Abeni wrote:
> On Fri, 2023-05-26 at 18:08 +0300, Vladislav Efanov wrote:
>> Syzkaller got the following report:
>> BUG: KASAN: use-after-free in sk_setup_caps+0x621/0x690 net/core/sock.c:2018
>> Read of size 8 at addr ffff888027f82780 by task syz-executor276/3255
>>
>> The function sk_setup_caps (called by ip6_sk_dst_store_flow->
>> ip6_dst_store) referenced already freed memory as this memory was
>> freed by parallel task in udpv6_sendmsg->ip6_sk_dst_lookup_flow->
>> sk_dst_check.
>>
>>            task1 (connect)              task2 (udp6_sendmsg)
>>          sk_setup_caps->sk_dst_set |
>>                                    |  sk_dst_check->
>>                                    |      sk_dst_set
>>                                    |      dst_release
>>          sk_setup_caps references  |
>>          to already freed dst_entry|
>>
>> The reason for this race condition is: udp6_sendmsg() calls
>> ip6_sk_dst_lookup() without lock for sock structure and tries to
>> allocate/add dst_entry structure to sock structure in parallel with
>> "connect" task.
>>
>> Found by Linux Verification Center (linuxtesting.org) with syzkaller.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
> Thank you for the detailed report!
>
>> ---
>>   net/ipv6/udp.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
>> index e5a337e6b970..a5ecd5d93b0a 100644
>> --- a/net/ipv6/udp.c
>> +++ b/net/ipv6/udp.c
>> @@ -1563,12 +1563,15 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>>   
>>   	fl6->flowlabel = ip6_make_flowinfo(ipc6.tclass, fl6->flowlabel);
>>   
>> +	lock_sock(sk);
> Acquiring the socket lock in this fast-path is going to kill the xmit
> performances, I think we can't do that.
>
> What about something like the following instead? Does that addresses
> the UaF? (completely untested, not even built ;) If so, feel free to
> take it over.
>
> Thanks.
>
> Paolo
> ---
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 5440e67bcfe3..24f2761bdb1d 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2381,7 +2381,6 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
>   {
>   	u32 max_segs = 1;
>   
> -	sk_dst_set(sk, dst);
>   	sk->sk_route_caps = dst->dev->features;
>   	if (sk_is_tcp(sk))
>   		sk->sk_route_caps |= NETIF_F_GSO;
> @@ -2400,6 +2399,7 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
>   		}
>   	}
>   	sk->sk_gso_max_segs = max_segs;
> +	sk_dst_set(sk, dst);
>   }
>   EXPORT_SYMBOL_GPL(sk_setup_caps);
>   
>
