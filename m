Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D7B6A2A04
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 14:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjBYNdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 08:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYNdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 08:33:41 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919C4144A1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 05:33:13 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q16so1904895wrw.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 05:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lugj9/6FRU18SGOBaVBCrk4XbU8QaK+WR+JtSCdwNes=;
        b=NBgZt7sbUqdwK+7hJtBN/BCrUzAIfuEHof6urqFq7lqGNP0sXigENiZULo4EYV/hZ1
         rxb6PNEhMIKmVC1xPEP6rKnnv4KKEdXd6yFz7uZRLOuJD6gA7UHad+yah1gzkD8JgTjn
         ZEExdgiivS3PGjKRfYLFpwRv4g3y0ouCkKAfYcRv8t0rwJW7UTulfl9o7XQkaRpo7vka
         ZPgy5Xe3f2qsXEL17pFZC7CXWFDE50AtRNt4HiXiUIpUsKvs0U9Rh9Qo6JGdpRLgVCTo
         VjpvLomH4D9CIlv97PjEDoL5OsQixo9sPMFm/V+R4pmrS1kd1ZGa4G8KgUjmTGoIaBQh
         bDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lugj9/6FRU18SGOBaVBCrk4XbU8QaK+WR+JtSCdwNes=;
        b=50g1pC07+iOVVLSA19M61sD7qWWvqlX62aK0Mf+7EuvVCrAE7Bptjld2W+KnkQKz6D
         yjSJVucIlavpwXeOwbloAetaG4ivXkoMX9tOTdoeiAlCAxfDyjKaj+KjU+kV8YchxyXC
         oI1rmDmTGNK4TVa1O0MlJDVZlreTDWm3u+X5d/voaAsIHv+ud56bNuRke01wFE/0daNQ
         sQP2mTbJc0JjgyN9y8cMbakx4u61fkgc4aj96lh3HHUGNCbwdXKmzihsJZQX6R17IPIF
         JDuSj6B2Kqq4RxwdtZh9ZvPCS5Q3lGytzaNbL+lJDY+hpUNqw693BcwJpfhViTNtdsHv
         FMgA==
X-Gm-Message-State: AO0yUKW25b6hj99n6roGtNRV39zPAwwi1N/HtvQ5GJwKLb+2a9Caz3Un
        x3FTRBbqEQ9BmkqPoCxHA5jP2QJ6FPVmINh8
X-Google-Smtp-Source: AK7set9I1KDggPOOm4GFpb7WMNIUQtdysSo2DeLQZswxUgBYa98TDGtTBEmn4nkZR6PKiXA9s9Sl3A==
X-Received: by 2002:a5d:6950:0:b0:2bf:cfb4:2e1 with SMTP id r16-20020a5d6950000000b002bfcfb402e1mr18069001wrw.45.1677331992068;
        Sat, 25 Feb 2023 05:33:12 -0800 (PST)
Received: from ?IPV6:2a02:6b6a:b566:0:d12b:5d7b:42ef:d31a? ([2a02:6b6a:b566:0:d12b:5d7b:42ef:d31a])
        by smtp.gmail.com with ESMTPSA id u17-20020adff891000000b002c553e061fdsm1757452wrp.112.2023.02.25.05.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 05:33:11 -0800 (PST)
Message-ID: <671dc8ad-2721-a3a3-7aa2-0e2558d5c953@bytedance.com>
Date:   Sat, 25 Feb 2023 13:33:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] [PATCH v2 0/5] x86-64: Remove global variables from
 boot
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Yuan Yao <yuan.yao@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20230224154235.277350-1-brgerst@gmail.com>
 <cfdb9c5a-4723-d920-511e-b57ae6c492f7@bytedance.com>
 <CAMzpN2hvPHWYOeyzfpRmk39XYwCrSJx0UyqxE48F1TjTNyoKAg@mail.gmail.com>
 <ca5788873c373249983ab6ac9ee173b12293641e.camel@infradead.org>
 <CAMzpN2ixYTKQaNoizkeNBrHQH_2SN9OMexnK9t3oVMDDCMwbOA@mail.gmail.com>
 <E940A2E7-6FAC-4E87-96DE-596BA3F505AF@infradead.org>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <E940A2E7-6FAC-4E87-96DE-596BA3F505AF@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/02/2023 12:55, David Woodhouse wrote:
> 
> 
> On 25 February 2023 12:47:33 GMT, Brian Gerst <brgerst@gmail.com> wrote:
>> On Sat, Feb 25, 2023 at 5:20 AM David Woodhouse <dwmw2@infradead.org> wrote:
>>>
>>> On Fri, 2023-02-24 at 16:38 -0500, Brian Gerst wrote:
>>>> Removing the globals before the parallel boot series, would be the
>>>> best option IMO.  That would make the transition simpler.
>>>
>>> Looks like this:
>>>
>>> https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/parallel-6.2-rc8-brfirst
>>>
>>> Passes basic smoke testing in qemu, including suspend to RAM and
>>> offlining CPU0.
>>
>> Looks good, thanks.
> 
> Aside from the fact that I forgot to put the tr_lock into the other startup paths that load the realmode %esp. But I'll let Usama do that now.
> 
Yeah looks good! I am testing with the macro diff for tr_lock from 
https://lore.kernel.org/all/05e27a7a-1faa-944e-2764-6ab4d620fb8f@bytedance.com/. 
If it all works, happy for me to send out v12 with it?

> I can probably work out how to test the AMD SEV path; is there a way I can test the startup_64 MADT one?

I guess the easiest way is to create a TDX VM on Sapphire Rapids which I 
believe mostly Intel people have access to right now? Maybe we can post 
v12 and someone from Intel could just quickly verify if it boots with 
it? I have added Yuan from the other thread in here who pointed it out 
initially.
