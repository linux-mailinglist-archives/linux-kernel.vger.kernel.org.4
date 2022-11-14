Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0335A628444
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbiKNPqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236409AbiKNPqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:46:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E10C10043
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668440710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+xPiYnu4pkWEmH1p92vUZspB2keG3AyvQckrQsd//E0=;
        b=IE9dHKNaKKWIkC1pSxTaWtYNOhgEJL7dMQeHWmkZ3tx4p+IIf5AfYjUDXjZlbIPK5JYQnS
        uyo0tsWbbTRkscQ+F3m4sqFOLQWwVm16MYeni8erzMSDliVNtq5ZhbslKuHluDQc/rsVO9
        SAzffuiBfV+PB0zlPmXCPL1dBYMWHP0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-114-6IZ0MjciOvq69dNQw_LKgw-1; Mon, 14 Nov 2022 10:45:09 -0500
X-MC-Unique: 6IZ0MjciOvq69dNQw_LKgw-1
Received: by mail-wm1-f70.google.com with SMTP id 186-20020a1c02c3000000b003cfab28cbe0so9091620wmc.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xPiYnu4pkWEmH1p92vUZspB2keG3AyvQckrQsd//E0=;
        b=ZzNeRJFT0GupB/RZba0TFOxbgfJhCGTao6CnoNxHt02B9ZPgbKcjwRr7GDEMoGHRWM
         Z5pL63MhqMf1LUhhEVuPNuL6pHK1lZYFETzSxatyIEzLmjWf2loVVtx8HZ1A4IEvnKd4
         ebc7N3cmmrf453Yqhyv3K/rvcXHh2wrZW8HCVW/0X4fp83Lc4uECPUsb3DlWVIMsua2r
         amOgZyQiQG+F5gDyQlFrbx10cHId/18ejaAR94j0XCUZqCsKRsY2iZL+QW6merYZt5NJ
         t/l98QnuZdzC3mw1qg4Cnz8f++SYtvHLgbZrNldGH1Hgfq0a3ESimmFCXhSyphtIlVYA
         hf3w==
X-Gm-Message-State: ANoB5pmWNHFE0esk+TspzYnMDKTEJuxRFZAdAVPPek/FOjwfTiFOup/D
        XNc1sLwwVA2F8WDLTu4D5X0guIivI+p3jtk/xMj9sg7Skha/VSe3R9clRaSe5aEx5NygZ4VesYo
        F7k1T0h5ZtjtelJzHHYY2Vpe5
X-Received: by 2002:a1c:7504:0:b0:3cf:7385:7621 with SMTP id o4-20020a1c7504000000b003cf73857621mr8349825wmc.62.1668440707803;
        Mon, 14 Nov 2022 07:45:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7Yfvg/80tM1j9uxQlPEghXzgZ+j6SPZGey2mM2dwoYYalADZakvgS1xnMIarRZ1MeXD3QzYw==
X-Received: by 2002:a1c:7504:0:b0:3cf:7385:7621 with SMTP id o4-20020a1c7504000000b003cf73857621mr8349803wmc.62.1668440707478;
        Mon, 14 Nov 2022 07:45:07 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:d300:d881:1fd5:bc95:5e2d? (p200300cbc703d300d8811fd5bc955e2d.dip0.t-ipconnect.de. [2003:cb:c703:d300:d881:1fd5:bc95:5e2d])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c510f00b003c6d21a19a0sm14391032wms.29.2022.11.14.07.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 07:45:06 -0800 (PST)
Message-ID: <5467e66d-55de-ca8f-c1ae-ffe6efe7290d@redhat.com>
Date:   Mon, 14 Nov 2022 16:45:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Prarit Bhargava <prarit@redhat.com>, pmladek@suse.com,
        Petr Pavlu <petr.pavlu@suse.com>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
In-Reply-To: <Y3Jg8X7qv2AKPU1J@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.11.22 16:38, Luis Chamberlain wrote:
> On Mon, Nov 14, 2022 at 09:57:56AM +0100, David Hildenbrand wrote:
>> On 12.11.22 02:47, Luis Chamberlain wrote:
>>> On Wed, Oct 19, 2022 at 02:00:55PM +0200, Petr Pavlu wrote:
>>>> On 10/18/22 20:33, Luis Chamberlain wrote:
>>>>> On Sat, Oct 15, 2022 at 11:27:10AM +0200, Petr Pavlu wrote:
>>>>>> The patch does address a regression observed after commit 6e6de3dee51a
>>>>>> ("kernel/module.c: Only return -EEXIST for modules that have finished
>>>>>> loading"). I guess it can have a Fixes tag added to the patch.
>>>>>>
>>>>>> I think it is hard to split this patch into parts because the implemented
>>>>>> "optimization" is the fix.
>>>>>
>>>>> git describe --contains 6e6de3dee51a
>>>>> v5.3-rc1~38^2~6
>>>>>
>>>>> I'm a bit torn about this situation. Reverting 6e6de3dee51a would be the
>>>>> right thing to do, but without it, it still leaves the issue reported
>>>>> by Prarit Bhargava. We need a way to resolve the issue on stable and
>>>>> then your optimizations can be applied on top.
>>>>
>>>> Simpler could be to do the following:
>>>>
>>>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>>>> index d02d39c7174e..0302ac387e93 100644
>>>> --- a/kernel/module/main.c
>>>> +++ b/kernel/module/main.c
>>>> @@ -2386,7 +2386,8 @@ static bool finished_loading(const char *name)
>>>>    	sched_annotate_sleep();
>>>>    	mutex_lock(&module_mutex);
>>>>    	mod = find_module_all(name, strlen(name), true);
>>>> -	ret = !mod || mod->state == MODULE_STATE_LIVE;
>>>> +	ret = !mod || mod->state == MODULE_STATE_LIVE
>>>> +		|| mod->state == MODULE_STATE_GOING;
>>>>    	mutex_unlock(&module_mutex);
>>>>    	return ret;
>>>> @@ -2566,7 +2567,8 @@ static int add_unformed_module(struct module *mod)
>>>>    	mutex_lock(&module_mutex);
>>>>    	old = find_module_all(mod->name, strlen(mod->name), true);
>>>>    	if (old != NULL) {
>>>> -		if (old->state != MODULE_STATE_LIVE) {
>>>> +		if (old->state == MODULE_STATE_COMING
>>>> +		    || old->state == MODULE_STATE_UNFORMED) {
>>>>    			/* Wait in case it fails to load. */
>>>>    			mutex_unlock(&module_mutex);
>>>>    			err = wait_event_interruptible(module_wq,
>>>> @@ -2575,7 +2577,7 @@ static int add_unformed_module(struct module *mod)
>>>>    				goto out_unlocked;
>>>>    			goto again;
>>>>    		}
>>>> -		err = -EEXIST;
>>>> +		err = old->state != MODULE_STATE_LIVE ? -EBUSY : -EEXIST;
>>>>    		goto out;
>>>>    	}
>>>>    	mod_update_bounds(mod);
>>>
>>>
>>> Prarit, can you verify this still does not break the issue you reported?
>>> David, does this also fix your issue?
>>
>> I didn't try, but from a quick glimpse I assume no. Allocating module space
>> happens before handling eventual duplicates right now, before a module even
>> is "alive" and in the MODULE_STATE_UNFORMED state.
> 
> The first two hunks are a revert of commit 6e6de3dee51a and I'm under
> the impression that cauased your issues as *more* modules states are
> allowed through.
> 
> The last hunk tries to fix what 6e6de3dee51a wanted to do.
> 

Note that I don't think the issue I raised is due to 6e6de3dee51a.

>> But maybe I am missing something important.
> 
> Please do test if you can.

I don't have the machine at hand right now. But, again, I doubt this 
will fix it.


The flow is in load_module():

	mod = layout_and_allocate(info, flags);
	if (IS_ERR(mod)) {
		...
	}

	audit_log_kern_module(mod->name);

	/* Reserve our place in the list. */
	err = add_unformed_module(mod);
	if (err)
		goto free_module;


You can have 400 threads in layout_and_allocate() loading the same 
module at the same time and running out of module space. Any changes to 
add_unformed_module() and finished_loading() won't change that, because 
they are not involved before the module space allocations happened.

-- 
Thanks,

David / dhildenb

