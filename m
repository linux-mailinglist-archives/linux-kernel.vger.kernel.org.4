Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D5C7361F4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjFTDFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFTDFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:05:03 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37391E42
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 20:04:37 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-25ea1b6b659so2225460a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 20:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687230276; x=1689822276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FWAkX0wvK40L8Asrfp0HwD5G44IXPeP/M4M7zLIxf3U=;
        b=djRrFrDbBleVZdWXxrOVE2nAKGvwYAf4SY5iAtcImwDM+I6r6WJcylT6f6OEkUtoBV
         xgbl/pjdRjjbtHc5UotGCivqqLtUAFWTziJfP4qHWqCtF3SY3KH3HJwKpd1WN5JBEG90
         ng3L0GsmDo5iSLEF2nMA4rY9ABP63GvoZFfSCMxckB4194G8VI6P5u4dtP98jj7qLMf2
         YzUEmrXwxvwxdwbyzx+rsdyhmdambZrPMuzPZQ5DkaaChocbcjRoKD3NAYMiSqvWhTXT
         kwwa5Jhcfy1oQ+S8CId5jxKKVoOfz97qM3yf/h8BF4LWcxiXsSjjfx16mVBROj/iokmL
         33iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687230276; x=1689822276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWAkX0wvK40L8Asrfp0HwD5G44IXPeP/M4M7zLIxf3U=;
        b=VBbcQ4SzbcwmeMUjKUmmygD5OuJRPWrsgHsBuQuUmXoNYoFNWI01zVSxnmLTvkM3Tq
         6w4ed9pPPTRNdDNPu4pUolF/q92VTBxZBviQawy5SY8qdOPW0heQd4SMfNlXwyqjqHPJ
         IBgHqTKZovoQDTcK9+32729V8at2PAthwE3+pg6HVkUdl78LzH9lEqD6Z07tsn4oog1k
         STB+fxNVQmBxu4fqUPGoUkNNVfvSc8OgEIszc7ADJqEE7Y0xapF0tUWKB8OJYcYayg3u
         iLXmKSlz+NFIz1qRM3D2XoG19T4E9kbrqIxK8wUiC3UntqNJtMMMwioQbSM/KwOzxsKV
         X+hg==
X-Gm-Message-State: AC+VfDzSnwtnN5iTZys4+HRy0tQRZTiICvVnXAhW7mhgXmL6PB4pmiL0
        e7qcQSKullxlewaIn27GY3Hm3w==
X-Google-Smtp-Source: ACHHUZ4w85QKY83xVfS+cRb6Qqre68nSV3CdsUk24aZ87xP4al2moPQV5NWIu5nneOTpdg6qNbI8Mg==
X-Received: by 2002:a17:90a:19cb:b0:25e:e211:d300 with SMTP id 11-20020a17090a19cb00b0025ee211d300mr5873247pjj.4.1687230276680;
        Mon, 19 Jun 2023 20:04:36 -0700 (PDT)
Received: from [10.94.58.170] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id iz7-20020a170902ef8700b001b0603829a0sm457578plb.199.2023.06.19.20.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 20:04:35 -0700 (PDT)
Message-ID: <6ed78c81-c1ac-dba4-059c-12f6b2bb9c53@bytedance.com>
Date:   Tue, 20 Jun 2023 11:04:30 +0800
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
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CANn89i+deprQWB0dmsUD1sRmy1VQCQwKnZUkLu_AEGV=ow=PKQ@mail.gmail.com>
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

On 6/19/23 6:08 PM, Eric Dumazet wrote:
> On Mon, Jun 19, 2023 at 10:26 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> If there is no net-memcg associated with the sock, don't bother
>> calculating its memory usage for charge.
>>
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> ---
>>   net/ipv4/inet_connection_sock.c | 18 +++++++++++-------
>>   1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
>> index 65ad4251f6fd..73798282c1ef 100644
>> --- a/net/ipv4/inet_connection_sock.c
>> +++ b/net/ipv4/inet_connection_sock.c
>> @@ -706,20 +706,24 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
>>   out:
>>          release_sock(sk);
>>          if (newsk && mem_cgroup_sockets_enabled) {
>> -               int amt;
>> +               int amt = 0;
>>
>>                  /* atomically get the memory usage, set and charge the
>>                   * newsk->sk_memcg.
>>                   */
>>                  lock_sock(newsk);
>>
>> -               /* The socket has not been accepted yet, no need to look at
>> -                * newsk->sk_wmem_queued.
>> -                */
>> -               amt = sk_mem_pages(newsk->sk_forward_alloc +
>> -                                  atomic_read(&newsk->sk_rmem_alloc));
>>                  mem_cgroup_sk_alloc(newsk);
>> -               if (newsk->sk_memcg && amt)
>> +               if (newsk->sk_memcg) {
>> +                       /* The socket has not been accepted yet, no need
>> +                        * to look at newsk->sk_wmem_queued.
>> +                        */
>> +                       amt = sk_mem_pages(newsk->sk_forward_alloc +
>> +                                          atomic_read(&newsk->sk_rmem_alloc));
>> +
>> +               }
>> +
>> +               if (amt)
>>                          mem_cgroup_charge_skmem(newsk->sk_memcg, amt,
>>                                                  GFP_KERNEL | __GFP_NOFAIL);
> 
> This looks correct, but claiming reading an atomic_t is an 'atomic op'
> is a bit exaggerated.

Yeah, shall I change subject to 'inet: Skip usage calculation if no
memcg to charge'? Or do you have any suggestions?

Thanks,
	Abel
