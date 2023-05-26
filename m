Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FC0712B40
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbjEZQ5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjEZQ5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:57:52 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACF8194;
        Fri, 26 May 2023 09:57:49 -0700 (PDT)
Received: from [10.10.2.69] (unknown [10.10.2.69])
        by mail.ispras.ru (Postfix) with ESMTPSA id 68F9344C100F;
        Fri, 26 May 2023 16:57:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 68F9344C100F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1685120267;
        bh=c84dgllaeAzbre9/T1wlXCItwbcLWSfy8pwOc1pg/N8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YAp+x9ZMWEfLyCsB3E2S3nA08iZuQdEHO+MGDMvVpOklJgXRGIfmWcFCiZh72Bmkt
         mlGkC9sbdwIozmMqe/3x8uS4Llxbd5ku7+8xECcKB7dJZLTmiBWad3PUbAE7PN5we3
         t2MCxQwqnOy8sK1JPEKwqNcqSvrIn0yX8Z3TwVYM=
Message-ID: <e058a2e7-707c-a66d-b1b2-ac3086f77ec0@ispras.ru>
Date:   Fri, 26 May 2023 19:57:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] udp6: Fix race condition in udp6_sendmsg & connect
Content-Language: ru
To:     Eric Dumazet <edumazet@google.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20230526150806.1457828-1-VEfanov@ispras.ru>
 <CANn89i+p7_UB8Z5FQ+iWg4G_caAnUf9W4P-t+VOzigUuJo+qRw@mail.gmail.com>
 <c63e08fc-7abf-24fb-fc1e-9ecf36618aa6@ispras.ru>
 <CANn89iJkOOcombRniD7PP4KY=5Z6tx5QMQ-M24KS_AZ0h4nAcg@mail.gmail.com>
From:   Vlad Efanov <vefanov@ispras.ru>
In-Reply-To: <CANn89iJkOOcombRniD7PP4KY=5Z6tx5QMQ-M24KS_AZ0h4nAcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes.


There is no lock for this lines and my patch does not broken this logic.

I sugessted to set lock only for lines 1566-1571 
(ip6_sk_dst_lookup_flow() call).


Best regards,

Vlad.


On 26.05.2023 19:46, Eric Dumazet wrote:
> On Fri, May 26, 2023 at 6:09 PM Vlad Efanov <vefanov@ispras.ru> wrote:
>> Eric,
>>
>>
>> udp6_sendmsg() currently still locks the socket (on line 1595).
>>
> Not really, look more closely at lines 1580 -> 1594
>
>
>> Best regards,
>>
>> Vlad.
>>
>>
>> On 26.05.2023 18:29, Eric Dumazet wrote:
>>> On Fri, May 26, 2023 at 5:08 PM Vladislav Efanov <VEfanov@ispras.ru> wrote:
>>>> Syzkaller got the following report:
>>>> BUG: KASAN: use-after-free in sk_setup_caps+0x621/0x690 net/core/sock.c:2018
>>>> Read of size 8 at addr ffff888027f82780 by task syz-executor276/3255
>>> Please include a full report.
>>>
>>>> The function sk_setup_caps (called by ip6_sk_dst_store_flow->
>>>> ip6_dst_store) referenced already freed memory as this memory was
>>>> freed by parallel task in udpv6_sendmsg->ip6_sk_dst_lookup_flow->
>>>> sk_dst_check.
>>>>
>>>>             task1 (connect)              task2 (udp6_sendmsg)
>>>>           sk_setup_caps->sk_dst_set |
>>>>                                     |  sk_dst_check->
>>>>                                     |      sk_dst_set
>>>>                                     |      dst_release
>>>>           sk_setup_caps references  |
>>>>           to already freed dst_entry|
>>>> The reason for this race condition is: udp6_sendmsg() calls
>>>> ip6_sk_dst_lookup() without lock for sock structure and tries to
>>>> allocate/add dst_entry structure to sock structure in parallel with
>>>> "connect" task.
>>>>
>>>> Found by Linux Verification Center (linuxtesting.org) with syzkaller.
>>>>
>>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>> This is a bogus Fixes: tag
>>>
>>> In old times, UDP sendmsg() was using the socket lock.
>>>
>>> Then, in linux-4.0 Vlad Yasevich made UDP v6 sendmsg() lockless (and
>>> racy in many points)
>>>
>>>
>>>> Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
>>>> ---
>>>>    net/ipv6/udp.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
>>>> index e5a337e6b970..a5ecd5d93b0a 100644
>>>> --- a/net/ipv6/udp.c
>>>> +++ b/net/ipv6/udp.c
>>>> @@ -1563,12 +1563,15 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>>>>
>>>>           fl6->flowlabel = ip6_make_flowinfo(ipc6.tclass, fl6->flowlabel);
>>>>
>>>> +       lock_sock(sk);
>>>>           dst = ip6_sk_dst_lookup_flow(sk, fl6, final_p, connected);
>>>>           if (IS_ERR(dst)) {
>>>>                   err = PTR_ERR(dst);
>>>>                   dst = NULL;
>>>> +               release_sock(sk);
>>>>                   goto out;
>>>>           }
>>>> +       release_sock(sk);
>>>>
>>>>           if (ipc6.hlimit < 0)
>>>>                   ipc6.hlimit = ip6_sk_dst_hoplimit(np, fl6, dst);
>>>> --
>>>> 2.34.1
>>>>
>>> There must be another way really.
>>> You just killed UDP performance.
