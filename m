Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0B16DBEEA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 08:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjDIGbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 02:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDIGbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 02:31:17 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BAD61AE
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 23:30:42 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63240bdd5e8so3320b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 23:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681021830; x=1683613830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JWSrzZ+WmnkEEZQrIrLPTXFIpjJHDPTmZDPW/lvOXiw=;
        b=dpexI5A5rOmH36tj+Rf+azGcaVpvUhcpHR7ydnO6dRTQaRjKK1kQfjEwbeybQEHohQ
         3DangPts9pFgYruHmiKURElblTE3+tN9/o1I59IwlfEAtoq6H4S+eCpJycxJJaQJeySl
         uGHRt2d4icuLAYxoloZGPx/Fc6TcHhPbUNevW0cUY5+xnRj81k9OmNdAkyVb+8kC/aWv
         8B4MZfJJi44577aF8Zg5JWN2S2N+CMA893SzSLc1K3TYFhmQqb3pVcECZM1zDek1fz+2
         L1plsfhMM19ORrUccycgAcYJrnQS0izMKDKgPo5VGMD8M03lomNGFFl7veK63Ff+YV7w
         +ACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681021830; x=1683613830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWSrzZ+WmnkEEZQrIrLPTXFIpjJHDPTmZDPW/lvOXiw=;
        b=lUyMSmAPXRMTuf8Va9d5eYCzM5eUbmMSzEcrMBfCAym6PfY+wIDy2cj+ddWUhw+g1S
         L81pU6S2Y4rf64PlUkBWV4jO0NRdXj3ATjSOUbvQhE2B+ocUJCd9B6tdDtkZ/zrCypRG
         3wHdlJFZ6422NSHg9dihPH4VXlfBZohVvF4IFWOsZiokn98ZtK/ONj8OE/tGRT3G10TA
         kR7ZpVH1fwtdEDc5uTtF3P37T0lNS2IEWcJW4IDee7qlml4xppDRQd8TGiCyRKk/iFkk
         gKIFmvlTP6CoJdF6nKUAcUcsnb9yApMtnVcDZ2I+XP2OmBg5Ox3oUmJq6ApGn0LzBMF4
         gabg==
X-Gm-Message-State: AAQBX9d+W0OgTxfGGK18axl35dB6YpK02MgUd7nmvb7Z6w29Hj+upVH7
        H5uABpXDET0ZI+3C7uhqmCOARw==
X-Google-Smtp-Source: AKy350bvzYpRSGWM7CUQGP8LcLTrBCaKlJs28sX/qwlv5RrLcGeAfoqtpX0TD/Mg6k1nw7awBwaO/Q==
X-Received: by 2002:aa7:8c44:0:b0:633:4c01:58b4 with SMTP id e4-20020aa78c44000000b006334c0158b4mr3780501pfd.2.1681021830108;
        Sat, 08 Apr 2023 23:30:30 -0700 (PDT)
Received: from [10.200.8.229] ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id y20-20020aa78054000000b00593e4e6516csm5555886pfm.124.2023.04.08.23.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Apr 2023 23:30:29 -0700 (PDT)
Message-ID: <4aba3e74-a205-5dd1-69bc-9186c04e733d@bytedance.com>
Date:   Sun, 9 Apr 2023 14:30:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH 2/2] x86: make __get_wchan() use arch_stack_walk()
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     peterz@infradead.org, keescook@chromium.org,
        dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de, rostedt@goodmis.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230330081552.54178-1-zhengqi.arch@bytedance.com>
 <20230330081552.54178-3-zhengqi.arch@bytedance.com>
 <20230408050822.ezdbhc6j7zuvutrm@treble>
 <fffd59ff-eaa8-bba7-03f2-9fc27620bd1c@bytedance.com>
 <20230408221206.mi7nsquoxklgword@treble>
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230408221206.mi7nsquoxklgword@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/9 06:12, Josh Poimboeuf wrote:
> On Sat, Apr 08, 2023 at 01:36:06PM +0800, Qi Zheng wrote:
>>
>>
>> On 2023/4/8 13:08, Josh Poimboeuf wrote:
>>> On Thu, Mar 30, 2023 at 04:15:52PM +0800, Qi Zheng wrote:
>>>> Make __get_wchan() use arch_stack_walk() directly to
>>>> avoid open-coding of unwind logic.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>
>>> Can we just have a shared version of __get_wchan() for all
>>> CONFIG_ARCH_STACKWALK arches?
>>
>>  From a quick glance, I think it's ok, but we still need to define
>> the arch's own get_wchan_cb(). I will try to do it.
> 
> Hm, why would we need to do that?

Because I see checks for count++ < 16 exist in __get_wchan() for some
arches and some don't. So I'm not sure if this check can be discarded
after using arch_stack_walk(). And I see that this check is retained in
arm64, see [1] for details.

[1]. 
https://github.com/torvalds/linux/commit/4f62bb7cb165f3e7b0a91279fe9dd5c56daf3457

> 

-- 
Thanks,
Qi
