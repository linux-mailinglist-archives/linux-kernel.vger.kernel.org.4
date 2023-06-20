Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10227368EA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjFTKNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjFTKN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:13:27 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6059DA2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 03:13:26 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b505665e2fso37151495ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 03:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687256006; x=1689848006;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfUr1e9aEQZRasLBwYauLBgpBkHg6F78JJmqZq7mi1o=;
        b=kGAeI2k3c7yrjwWMuk9zKQSyRj2fyG04oBVEuSGxLYzlpdg1RRLqQ7vgmusYieQWNq
         rXUbQkyU5cdc14ox53xkgIKMau5Mhro6ux/G7dWapSTmk8pZBq89mctgu8eisA/8O9HC
         p40SMFfbn+a8xjDhJKTdGZqslkEP9dtUhf0LDMYYoMLa7YrxSZXtv/eUdwZ953rE+6iC
         tftSJje1HVjU3LUTDS/mcmPRnKsRcq2b0WuDCgPda5ilR5CLwbsqMOFjPXLhWSOR4JCr
         /xwzY0vHRGiYhFLclXS5Bb8OzE674jpHuR24JOYdlWXtkWpO65LmiZmQ9T/6YIk4JSGy
         pcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687256006; x=1689848006;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfUr1e9aEQZRasLBwYauLBgpBkHg6F78JJmqZq7mi1o=;
        b=kuVzWnBm9bFaBiH2/tVjWkuo5vRkKJfXRbniW1zKcSCxFtLp3KRrpryAKKgIly0YD6
         J/1q2RHFnfgHi2DCO+8Ko3MtQa+OFt2Dpc9WY/nzNP0d9AeUhFqFMBC1dh/WwGsjIUVl
         21AO+w8Tn54OIjmxaaNORAuvQuaGZULncK8hr6e6oiUUeDIH/kBVoETwzagHqdgLVtCm
         xd30Qj6mtjjdpoZzg8NN12Rp1G3HtT+gMIH1HjY+SKViAZs8L7q7rXEDDJd4QAg1T42O
         e9zHKgpQyL13uXkugwn5A/3T8upw1vur1kt2j9kuSEscoIOh6+uOtFTaV51ALMtmStM8
         QSAA==
X-Gm-Message-State: AC+VfDwXco5Q0EbePaDx4LryJJh2UySA+hbTlB08eefbBma0dtEHZutf
        S55WTtzfybik7gERitHr00VKUA==
X-Google-Smtp-Source: ACHHUZ4WtJhG0PPz3SFJZ/k2bW8clbE97J78XfZQ7GBV0JaALbG0TDAUZwHyCzssBTaOzSYxJlv5pQ==
X-Received: by 2002:a17:902:d2ca:b0:1b0:5ce9:adc7 with SMTP id n10-20020a170902d2ca00b001b05ce9adc7mr23389792plc.28.1687256005848;
        Tue, 20 Jun 2023 03:13:25 -0700 (PDT)
Received: from [10.94.58.170] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id n21-20020a170902969500b001ab1b7bae5asm1270189plp.184.2023.06.20.03.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 03:13:25 -0700 (PDT)
Message-ID: <23d45f7e-3a34-44b3-f1a0-b992bbb5076f@bytedance.com>
Date:   Tue, 20 Jun 2023 18:13:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: Re: [PATCH net-next] inet: Save one atomic op if no memcg to
 charge
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:NETWORKING [IPv4/IPv6]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230619082547.73929-1-wuyun.abel@bytedance.com>
 <CANn89i+deprQWB0dmsUD1sRmy1VQCQwKnZUkLu_AEGV=ow=PKQ@mail.gmail.com>
 <6ed78c81-c1ac-dba4-059c-12f6b2bb9c53@bytedance.com>
 <CANn89iK4hme4XmUyZVjTXMZYqAm8w+9tbwnrtHyJ3N28cAFYTw@mail.gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CANn89iK4hme4XmUyZVjTXMZYqAm8w+9tbwnrtHyJ3N28cAFYTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/23 4:46 PM, Eric Dumazet wrote:
> On Tue, Jun 20, 2023 at 5:04 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> On 6/19/23 6:08 PM, Eric Dumazet wrote:
>>> On Mon, Jun 19, 2023 at 10:26 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>>>>
>>>> If there is no net-memcg associated with the sock, don't bother
>>>> calculating its memory usage for charge.
>>>>
>>>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>>>> ---
>>>>    net/ipv4/inet_connection_sock.c | 18 +++++++++++-------
>>>>    1 file changed, 11 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
>>>> index 65ad4251f6fd..73798282c1ef 100644
>>>> --- a/net/ipv4/inet_connection_sock.c
>>>> +++ b/net/ipv4/inet_connection_sock.c
>>>> @@ -706,20 +706,24 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
>>>>    out:
>>>>           release_sock(sk);
>>>>           if (newsk && mem_cgroup_sockets_enabled) {
>>>> -               int amt;
>>>> +               int amt = 0;
>>>>
>>>>                   /* atomically get the memory usage, set and charge the
>>>>                    * newsk->sk_memcg.
>>>>                    */
>>>>                   lock_sock(newsk);
>>>>
>>>> -               /* The socket has not been accepted yet, no need to look at
>>>> -                * newsk->sk_wmem_queued.
>>>> -                */
>>>> -               amt = sk_mem_pages(newsk->sk_forward_alloc +
>>>> -                                  atomic_read(&newsk->sk_rmem_alloc));
>>>>                   mem_cgroup_sk_alloc(newsk);
>>>> -               if (newsk->sk_memcg && amt)
>>>> +               if (newsk->sk_memcg) {
>>>> +                       /* The socket has not been accepted yet, no need
>>>> +                        * to look at newsk->sk_wmem_queued.
>>>> +                        */
>>>> +                       amt = sk_mem_pages(newsk->sk_forward_alloc +
>>>> +                                          atomic_read(&newsk->sk_rmem_alloc));
>>>> +
>>>> +               }
>>>> +
>>>> +               if (amt)
>>>>                           mem_cgroup_charge_skmem(newsk->sk_memcg, amt,
>>>>                                                   GFP_KERNEL | __GFP_NOFAIL);
>>>
>>> This looks correct, but claiming reading an atomic_t is an 'atomic op'
>>> is a bit exaggerated.
>>
>> Yeah, shall I change subject to 'inet: Skip usage calculation if no
>> memcg to charge'? Or do you have any suggestions?
> 
> I would call this a cleanup or refactoring, maybe...

Alright, I have changed to 'cleanup', please take a look at v2.

Yet I have another question about this condition:
	'if (newsk && mem_cgroup_sockets_enabled)'
IMHO in the scope of cgroup v1, 'mem_cgroup_sockets_enabled' doesn't
imply socket accounting enabled for current's memcg. As the listening
socket and the newly accepted socket are processing same traffic, can
we make this condition more specific like this:
	'if (newsk && mem_cgroup_sockets_enabled && sk->sk_memcg)'
would you mind shedding some light please?

Thanks!
	Abel
