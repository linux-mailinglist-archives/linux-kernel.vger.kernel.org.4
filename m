Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F577235B0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 05:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbjFFDUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 23:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjFFDUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 23:20:48 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D462112D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 20:20:46 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6af6fe73f11so5252404a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 20:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686021646; x=1688613646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ntz136Kv/Z3zkhnJ6VCfDwRACVjWDfGBtrEKcKvWUw=;
        b=DqncP1yN7WvbpQmN3FIeaCkq3uY5TqNpLAQQZx+mpFCIDPZvMnxMND6j6piAILHxFZ
         12jQKJcLNw78VtiWS4VyU11ZsmRDw6Dm9et5QMiEjYJNXlcwuH9TUqH1n1MLaIhSUkTs
         Y8w0K3I95RBssUjpOT6c8Zsifk7Gma0/7XBfQ1cROortF+wRJO3JkSGKcAbymSdKpDlR
         ctkPxm3/qZqnPj+G0p4YMdNPBpMYuCeMovBjxu0SX6DztNyyVNBIiJFQGjXpmmifSSjk
         byeo1qdtYt3G1C80N/sjLfejh1dzK48I6TyppSVCdXCZd55kwmdvI4+0jQUA9jixYidH
         9z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686021646; x=1688613646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7ntz136Kv/Z3zkhnJ6VCfDwRACVjWDfGBtrEKcKvWUw=;
        b=eIL46ENmWyurG/L1AsE8S6gyJCuKF4jufPiohxd9Ff4/jr1YjEiCuRlFv1VPYR987G
         qhffi6Uu82RcpstLttiZhQ7gW01Sg01zYJJZ7VWZ6zaI2zHGOzx+wK/sZcsdi/EXPFSX
         tY53VyTJFMW91j9dCcwLr6jw6ZbKrZSh9j9QFEvu2/ulz1D0rvoA0X1rP4B36gZR+EUz
         CnMOlO+HHOzh2gAy97QWfcQWUZCCumqSRMQfZkNbrvmtVA5C0u/WQdt1WgqsRFovpTWG
         v++BTVSDvbiVzwUpZiYzdlmRgFlKrjuFEsz3AEj1udSu2WlNkfmCikV9yUKG/io+Ja7W
         BxxA==
X-Gm-Message-State: AC+VfDwU9IMqAW5PAbg2C7cIVoNmQuRP+dBkz/X+Q1rlDkW/ra/MfPy7
        yofhgjAm505E6/x3RA8Cge4Q6A==
X-Google-Smtp-Source: ACHHUZ6YuXJUXGWkdpcGrIlzXzS0Yda3ftDJl98KfFEAf+y0rJ12iMkNK2jsHTija0uGTAdiexMjcw==
X-Received: by 2002:a9d:67d3:0:b0:6ab:1d99:5dc6 with SMTP id c19-20020a9d67d3000000b006ab1d995dc6mr821640otn.3.1686021646162;
        Mon, 05 Jun 2023 20:20:46 -0700 (PDT)
Received: from [10.71.57.173] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j1-20020aa78d01000000b0065329194416sm5769668pfe.193.2023.06.05.20.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 20:20:45 -0700 (PDT)
Message-ID: <2d138e12-9273-46e6-c219-96c665f38f0f@bytedance.com>
Date:   Tue, 6 Jun 2023 11:20:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: Re: [PATCH bpf-next] bpf: getsockopt hook to get optval without
 checking kernel retval
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
References: <20230601024900.22902-1-zhoufeng.zf@bytedance.com>
 <5bc1ac0d-cea8-19e5-785a-cd72140d8cdb@linux.dev>
 <20881602-9afc-96b7-3d58-51c31e3f50b7@bytedance.com>
 <d7be9d22-c6aa-da2a-77fc-9638ad1e0f15@linux.dev>
From:   Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <d7be9d22-c6aa-da2a-77fc-9638ad1e0f15@linux.dev>
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

在 2023/6/1 23:50, Martin KaFai Lau 写道:
> On 5/31/23 11:05 PM, Feng Zhou wrote:
>> 在 2023/6/1 13:37, Martin KaFai Lau 写道:
>>> On 5/31/23 7:49 PM, Feng zhou wrote:
>>>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>>
>>>> Remove the judgment on retval and pass bpf ctx by default. The
>>>> advantage of this is that it is more flexible. Bpf getsockopt can
>>>> support the new optname without using the module to call the
>>>> nf_register_sockopt to register.
>>>>
>>>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>> ---
>>>>   kernel/bpf/cgroup.c | 35 +++++++++++++----------------------
>>>>   1 file changed, 13 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>>>> index 5b2741aa0d9b..ebad5442d8bb 100644
>>>> --- a/kernel/bpf/cgroup.c
>>>> +++ b/kernel/bpf/cgroup.c
>>>> @@ -1896,30 +1896,21 @@ int 
>>>> __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
>>>>       if (max_optlen < 0)
>>>>           return max_optlen;
>>>> -    if (!retval) {
>>>> -        /* If kernel getsockopt finished successfully,
>>>> -         * copy whatever was returned to the user back
>>>> -         * into our temporary buffer. Set optlen to the
>>>> -         * one that kernel returned as well to let
>>>> -         * BPF programs inspect the value.
>>>> -         */
>>>> -
>>>> -        if (get_user(ctx.optlen, optlen)) {
>>>> -            ret = -EFAULT;
>>>> -            goto out;
>>>> -        }
>>>> +    if (get_user(ctx.optlen, optlen)) {
>>>> +        ret = -EFAULT;
>>>> +        goto out;
>>>> +    }
>>>> -        if (ctx.optlen < 0) {
>>>> -            ret = -EFAULT;
>>>> -            goto out;
>>>> -        }
>>>> -        orig_optlen = ctx.optlen;
>>>> +    if (ctx.optlen < 0) {
>>>> +        ret = -EFAULT;
>>>> +        goto out;
>>>> +    }
>>>> +    orig_optlen = ctx.optlen;
>>>> -        if (copy_from_user(ctx.optval, optval,
>>>> -                   min(ctx.optlen, max_optlen)) != 0) {
>>>> -            ret = -EFAULT;
>>>> -            goto out;
>>>> -        }
>>>> +    if (copy_from_user(ctx.optval, optval,
>>>> +                min(ctx.optlen, max_optlen)) != 0) {
>>> What is in optval that is useful to copy from if the kernel didn't 
>>> handle the optname?
>>
>> For example, if the user customizes a new optname, it will not be 
>> processed if the kernel does not support it. Then the data stored in 
>> optval is the data put 
> 
> 
> 
>> by the user. If this part can be seen by bpf prog, the user can 
>> implement processing logic of the custom optname through bpf prog.
> 
> This part does not make sense. It is a (get)sockopt. Why the bpf prog 
> should expect anything useful in the original __user optval? Other than 
> unnecessary copy for other common cases, it looks like a bad api, so 
> consider it a NAK.
> 
>>
>>>
>>> and there is no selftest also.
>>>
>>
>> Yes, if remove this restriction, everyone thinks it's ok, I'll add it 
>> in the next version.
>>
>>>> +        ret = -EFAULT;
>>>> +        goto out;
>>>>       }
>>>>       lock_sock(sk);
>>>
>>
> 

According to my understanding, users will have such requirements, 
customize an optname, which is not available in the kernel. All logic is 
completed in bpf prog, and bpf prog needs to obtain the user data passed 
in by the system call, and then return the data required by the user 
according to this data.

For optname not in the kernel, the error code is
#define ENOPROTOOPT 92/* Protocol not available */
Whether to consider the way of judging with error codes,
If (! retval | | retval == -ENOPROTOOPT)

