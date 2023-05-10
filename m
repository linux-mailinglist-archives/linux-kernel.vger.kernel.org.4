Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62546FE098
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbjEJOlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbjEJOlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:41:14 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E3B9030
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:40:37 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aad5245632so52648105ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683729636; x=1686321636;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kd6kEcT77nI1oDBKsN5ir2ctAlFdCVvTy+59Li4MlkA=;
        b=CE3+Agwjke0KFC5RDWHPvTC9VtvHOBDKBuzYVqUCWwMfiDFTLSyZnUC4oGIHr3aArL
         kKBW5Jg/PLV+HPH+N0w6M5LZHjYlBfnyBjoT8DKX1eBZC8jfVXqft8mSnug2yNDgG/gi
         Ogm2f7jpogLoELJ6w56pe4KdUfP67zufwCV3FRC7iRpevH0nl/Km4EMzz+nyvuDCVQ8v
         Ssbe55a/jEkaIZbYScbGOgqKBwoppBT1mxePAlqeETypHiAsvQYkrjJ4+RnuX9qTUaHR
         nZL1uNUu8xqM6fCXmMbb47pRfsIYq/zZiUROQEvfaC/v3R9Crcge2SyKA//JDeDIgTKm
         XR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683729636; x=1686321636;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kd6kEcT77nI1oDBKsN5ir2ctAlFdCVvTy+59Li4MlkA=;
        b=WhBkmwTMLk+HD5uxv7FlzZixJq0w1uxnMMSj8JmazTreqDwkMW8yli4kOKQdurqp4G
         dfv3/F/dXaeB8zTMcs/49aavMUW7RTaq0vBEJlrFbKS+Yi+n9dmkGfJg4LmZV8Bo7k42
         ONiSIx9O/EYtKgDCSpHnISJmMt06rbSgqwQkYq70qiupvxqJxDlWIVe+dKEwbAOkP1Rd
         Uof5vmTyYVwhe8uhA1r86D5E4h2avA7VXEWbXtpf2SOlRSpSYTIoEWMNCNrGm1Qj5xp3
         6KhOgF1vcG9N4qa9xllDwiRAx5amlnwBZlmznpAlXeVIj8tElltBQQmpsO7RnbYDe9Ah
         6w7g==
X-Gm-Message-State: AC+VfDz4FBtvEEvlppBihIgCqUDCYMNhdphI9+bslmrCL5Qf7M0wxZNY
        wx6sozA02F1tOjeuyBAinKwyzPJOO5rrCX6q8xM=
X-Google-Smtp-Source: ACHHUZ6z2UxO0eeY8HV8Q2CeKxSF45ZQOWb49Ug6Th5Ek1dllZx0R2P+OXXDD8I/ZPqL2phVe+PCAg==
X-Received: by 2002:a17:903:228c:b0:19e:6e00:4676 with SMTP id b12-20020a170903228c00b0019e6e004676mr24468658plh.61.1683729636018;
        Wed, 10 May 2023 07:40:36 -0700 (PDT)
Received: from [10.255.19.214] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id r1-20020a170902be0100b001a24cded097sm3856815pls.236.2023.05.10.07.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 07:40:35 -0700 (PDT)
Message-ID: <c4453efb-34a7-7a09-b179-e3e17b8074cc@bytedance.com>
Date:   Wed, 10 May 2023 22:40:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: Re: [PATCH] sock: Fix misuse of sk_under_memory_pressure()
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230506085903.96133-1-wuyun.abel@bytedance.com>
 <CANn89iK154B-NzRFymx_ggO9ZuVW-0YyHEKi6C46zjHpdRfokQ@mail.gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CANn89iK154B-NzRFymx_ggO9ZuVW-0YyHEKi6C46zjHpdRfokQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric, thanks very much for comments!

On 5/9/23 4:55 PM, Eric Dumazet wrote:
> On Sat, May 6, 2023 at 10:59 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> The commit 180d8cd942ce ("foundations of per-cgroup memory pressure
>> controlling") wrapped proto::memory_pressure status into an accessor
>> named sk_under_memory_pressure(), and in the next commit e1aab161e013
>> ("socket: initial cgroup code") added the consideration of net-memcg
>> pressure into this accessor.
>>
>> But with the former patch applied, not all of the call sites of
>> sk_under_memory_pressure() are interested in net-memcg's pressure.
>> The __sk_mem_{raise,reduce}_allocated() only focus on proto/netns
>> pressure rather than net-memcg's. IOW this accessor are generally
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
>> -       return sk->sk_prot->memory_pressure != NULL;
>> -}
>> -
>>   static inline bool sk_under_memory_pressure(const struct sock *sk)
>>   {
>>          if (!sk->sk_prot->memory_pressure)
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index 5440e67bcfe3..8d215f821ea6 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -3017,13 +3017,14 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
>>                  }
>>          }
>>
>> -       if (sk_has_memory_pressure(sk)) {
>> -               u64 alloc;
>> -
>> -               if (!sk_under_memory_pressure(sk))
>> -                       return 1;
>> -               alloc = sk_sockets_allocated_read_positive(sk);
>> -               if (sk_prot_mem_limits(sk, 2) > alloc *
>> +       if (prot->memory_pressure) {
> 
> I do not understand this patch.
> 
> Changelog is evasive, I do not see what practical problem you want to solve.
> 
> sk_has_memory_pressure() is not about memcg, simply the fact that a
> proto has a non NULL memory_pressure pointer.

Sorry for failed to provide a reasonable explanation... Would you please
check my reply to Paolo?

Thanks,
	Abel
