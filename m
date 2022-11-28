Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D8763ADBC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiK1Qaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiK1Qax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:30:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BFC20989
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669652993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CLqIykAiP9wRIEjDnHvwAp6ap+B8rV/e+NXpU2JbTJ0=;
        b=Sa8GdY8Q0h0cGphY9VEoyOdoa4TVgfgMYn+X5cytAXQ3thxxrBn3iXu7oI4ZABBjTq5/OL
        fAcYA1qtBaO6KYUunvxQMa3pQt3YhJPo/7QgyZnvtDR3nryFyhPlC53eHwQWpH4Msm0m/t
        JlllIUz65jZwXXMrbq9DDm0KU+b9qXk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-607-1pgBRvZrPJqTlTe7vM33mw-1; Mon, 28 Nov 2022 11:29:52 -0500
X-MC-Unique: 1pgBRvZrPJqTlTe7vM33mw-1
Received: by mail-qv1-f72.google.com with SMTP id ns11-20020a056214380b00b004c64784249eso14264200qvb.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:29:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLqIykAiP9wRIEjDnHvwAp6ap+B8rV/e+NXpU2JbTJ0=;
        b=qlgHkFhLbdJp1aT5ERvlwd+mp7ws2SaKs9YgGwv8JkrSD7LZqTmuL9tz+VF9nT1Rto
         NuFRFb9gDvUbwYTldWvzKIPWegW0GoXywYkBjApIGmYJpcnICiFAf5ff6A9CiHRw6wfJ
         5tKK5zGOQajUrL5H1fEz+utQjwBu3sBinhz2bmIuD+QQPVvNRirHLXG+WSAidHnK0ZLy
         ugf2iY7hJlK3P8cRzDNKSdmnlQUEy6NwL77ouFVRJGE++s19qPV+kfHFiyUV4maSG3Os
         1rb39Fo0h5j0fNGYcsKYL35sRSeJxSGwD3sN2ec6zWCjKsi9s7VUXA/G1bNA7+TdbuAS
         HqDA==
X-Gm-Message-State: ANoB5pkyhR2+ax9NVb9oRubVTx6NJrmAI8CiV9fnA8wPWqQJxRngbRu+
        Q9cF1swDQdq0IDCGnorQkalIl+3NOtyPYbU8crmd4AwRgYoYRcZ0+ESKV4LAIagzALvglrhQUAZ
        pJMh4oCpUdO9dUhKLjxvbLAMU
X-Received: by 2002:ac8:4698:0:b0:39c:1435:423e with SMTP id g24-20020ac84698000000b0039c1435423emr31749018qto.490.1669652991327;
        Mon, 28 Nov 2022 08:29:51 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4meOp2prWcMWyL7deOnLG98NNIxnGjkncaoSfMTd98qDA4thOziSE8vORkUhORDgONsUD6gA==
X-Received: by 2002:ac8:4698:0:b0:39c:1435:423e with SMTP id g24-20020ac84698000000b0039c1435423emr31748976qto.490.1669652990853;
        Mon, 28 Nov 2022 08:29:50 -0800 (PST)
Received: from [10.16.222.26] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a0b8b00b006fbae4a5f59sm8416039qkh.41.2022.11.28.08.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 08:29:50 -0800 (PST)
Message-ID: <94cd5565-1058-2c97-57bb-0ddf12416cd6@redhat.com>
Date:   Mon, 28 Nov 2022 11:29:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     pmladek@suse.com, Petr Pavlu <petr.pavlu@suse.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
 <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
 <Y3Jg8X7qv2AKPU1J@bombadil.infradead.org>
 <5467e66d-55de-ca8f-c1ae-ffe6efe7290d@redhat.com>
From:   Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <5467e66d-55de-ca8f-c1ae-ffe6efe7290d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/22 10:45, David Hildenbrand wrote:
> On 14.11.22 16:38, Luis Chamberlain wrote:
>> On Mon, Nov 14, 2022 at 09:57:56AM +0100, David Hildenbrand wrote:
>>> On 12.11.22 02:47, Luis Chamberlain wrote:
>>>> On Wed, Oct 19, 2022 at 02:00:55PM +0200, Petr Pavlu wrote:
>>>>> On 10/18/22 20:33, Luis Chamberlain wrote:
>>>>>> On Sat, Oct 15, 2022 at 11:27:10AM +0200, Petr Pavlu wrote:
>>>>>>> The patch does address a regression observed after commit 
>>>>>>> 6e6de3dee51a
>>>>>>> ("kernel/module.c: Only return -EEXIST for modules that have 
>>>>>>> finished
>>>>>>> loading"). I guess it can have a Fixes tag added to the patch.
>>>>>>>
>>>>>>> I think it is hard to split this patch into parts because the 
>>>>>>> implemented
>>>>>>> "optimization" is the fix.
>>>>>>
>>>>>> git describe --contains 6e6de3dee51a
>>>>>> v5.3-rc1~38^2~6
>>>>>>
>>>>>> I'm a bit torn about this situation. Reverting 6e6de3dee51a would 
>>>>>> be the
>>>>>> right thing to do, but without it, it still leaves the issue reported
>>>>>> by Prarit Bhargava. We need a way to resolve the issue on stable and
>>>>>> then your optimizations can be applied on top.
>>>>>
>>>>> Simpler could be to do the following:
>>>>>
>>>>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>>>>> index d02d39c7174e..0302ac387e93 100644
>>>>> --- a/kernel/module/main.c
>>>>> +++ b/kernel/module/main.c
>>>>> @@ -2386,7 +2386,8 @@ static bool finished_loading(const char *name)
>>>>>        sched_annotate_sleep();
>>>>>        mutex_lock(&module_mutex);
>>>>>        mod = find_module_all(name, strlen(name), true);
>>>>> -    ret = !mod || mod->state == MODULE_STATE_LIVE;
>>>>> +    ret = !mod || mod->state == MODULE_STATE_LIVE
>>>>> +        || mod->state == MODULE_STATE_GOING;
>>>>>        mutex_unlock(&module_mutex);
>>>>>        return ret;
>>>>> @@ -2566,7 +2567,8 @@ static int add_unformed_module(struct module 
>>>>> *mod)
>>>>>        mutex_lock(&module_mutex);
>>>>>        old = find_module_all(mod->name, strlen(mod->name), true);
>>>>>        if (old != NULL) {
>>>>> -        if (old->state != MODULE_STATE_LIVE) {
>>>>> +        if (old->state == MODULE_STATE_COMING
>>>>> +            || old->state == MODULE_STATE_UNFORMED) {
>>>>>                /* Wait in case it fails to load. */
>>>>>                mutex_unlock(&module_mutex);
>>>>>                err = wait_event_interruptible(module_wq,
>>>>> @@ -2575,7 +2577,7 @@ static int add_unformed_module(struct module 
>>>>> *mod)
>>>>>                    goto out_unlocked;
>>>>>                goto again;
>>>>>            }
>>>>> -        err = -EEXIST;
>>>>> +        err = old->state != MODULE_STATE_LIVE ? -EBUSY : -EEXIST;
>>>>>            goto out;
>>>>>        }
>>>>>        mod_update_bounds(mod);
>>>>
>>>>
>>>> Prarit, can you verify this still does not break the issue you 
>>>> reported?
>>>> David, does this also fix your issue?
>>>
>>> I didn't try, but from a quick glimpse I assume no. Allocating module 
>>> space
>>> happens before handling eventual duplicates right now, before a 
>>> module even
>>> is "alive" and in the MODULE_STATE_UNFORMED state.
>>
>> The first two hunks are a revert of commit 6e6de3dee51a and I'm under
>> the impression that cauased your issues as *more* modules states are
>> allowed through.
>>
>> The last hunk tries to fix what 6e6de3dee51a wanted to do.
>>
> 
> Note that I don't think the issue I raised is due to 6e6de3dee51a.
> 
>>> But maybe I am missing something important.
>>
>> Please do test if you can.
> 
> I don't have the machine at hand right now. But, again, I doubt this 
> will fix it.
> 
> 
> The flow is in load_module():
> 
>      mod = layout_and_allocate(info, flags);
>      if (IS_ERR(mod)) {
>          ...
>      }
> 
>      audit_log_kern_module(mod->name);
> 
>      /* Reserve our place in the list. */
>      err = add_unformed_module(mod);
>      if (err)
>          goto free_module;
> 
> 
> You can have 400 threads in layout_and_allocate() loading the same 
> module at the same time and running out of module space. Any changes to 
> add_unformed_module() and finished_loading() won't change that, because 
> they are not involved before the module space allocations happened.
> 

I'd like to see a refreshed patch but I tested the latest version and 
see that the boot time is LONGER with the change

Before:

[11:17 AM root@intel-eaglestream-spr-15 kernel-ark]# systemd-analyze
Startup finished in 55.418s (firmware) + 22.766s (loader) + 35.856s 
(kernel) + 5.830s (initrd) + 15.671s (userspace) = 2min 15.542s
multi-user.target reached after 15.606s in userspace.

After:

Startup finished in 55.314s (firmware) + 23.033s (loader) + 35.331s 
(kernel) + 5.176s (initrd) + 23.465s (userspace) = 2min 22.320s
multi-user.target reached after 23.093s in userspace.

Subsequent reboots also indicate that userspace boot time is longer 
after the change.

P.

