Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B20627857
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbiKNI7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbiKNI70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:59:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5831DA54
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668416280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZg0DxB8so7m34QKRBpTnK7NzeILrTRgIJDNhSB4dJs=;
        b=Mql/1PKJsF7cNtp39XiMKiv5BqcZkGijStIm6MUM81lr4m8kWg3+nIAONg5LwQWkANS2s0
        d1erYBN0+nqV2UGJBMAKrAZH+4lVvXo0tW6oUd1T+d/Z75ZfOYP1DC/uoXpkXfgCyaFBcQ
        Xz3MrSci7HUgP0xSOgme7TvySjHRxLQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-351-4Uu3mZ-NNmSEUvtKylMFOw-1; Mon, 14 Nov 2022 03:57:59 -0500
X-MC-Unique: 4Uu3mZ-NNmSEUvtKylMFOw-1
Received: by mail-wm1-f69.google.com with SMTP id l42-20020a05600c1d2a00b003cf8e70c1ecso8630795wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZg0DxB8so7m34QKRBpTnK7NzeILrTRgIJDNhSB4dJs=;
        b=VgNjaYOfAXeI1L5EOv3uY2a23la5MFT6olbVaFRi1ach3UkYYtseWO8w8V9YN/apFy
         YmiRiXTtW2pDIpI/M6YLgGYNPOLbkbbbA5g8bVnK4w92YEzPppFYPSQvqJp4lHtcgg8L
         4Nt4+K6endNxU0VaBxU7VPzrxYICe0ykuR3oHgEDqfkG0uq5tQ1BxD0sS70vtlv5PHpt
         /LEwCdyaGc0grY2/LK1Vat+LgKGH7CVrleS0hlX07fQ6lgUqMTtZZHUfWnI9ciLjhf17
         pRMkxkxjxXjxfNY2C2IGrGDVtmPDh25CEfZG3kMeeTcx/uJcHSEQmR7wLGgWJzvrSihq
         comQ==
X-Gm-Message-State: ANoB5plNskJ3IJVKBMxV+Md2kVqgRyRGiiu14dpJmU1aqmxJrYfvEnyk
        nnYqFlqZkyfLNku9gOOVqAO1EbGt+Y34H0xqhq7HXmjs1fAjw1YPzxqSyIJwPRgVw9OUrTGnFVf
        0pNcqU65gNn/I3Kz8jPb1nPAI
X-Received: by 2002:adf:ea42:0:b0:236:cfcf:8e36 with SMTP id j2-20020adfea42000000b00236cfcf8e36mr6883703wrn.323.1668416277878;
        Mon, 14 Nov 2022 00:57:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6C4tbw+mII5DH1BvxyEuPB/WV9+rqn3TOzxHf0EGkwtwfnzuHykZnjcAk4yYnUVmxJBgTX3g==
X-Received: by 2002:adf:ea42:0:b0:236:cfcf:8e36 with SMTP id j2-20020adfea42000000b00236cfcf8e36mr6883692wrn.323.1668416277602;
        Mon, 14 Nov 2022 00:57:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:d300:8765:6ef2:3111:de53? (p200300cbc703d30087656ef23111de53.dip0.t-ipconnect.de. [2003:cb:c703:d300:8765:6ef2:3111:de53])
        by smtp.gmail.com with ESMTPSA id r2-20020a5d6942000000b0022e47b57735sm9002499wrw.97.2022.11.14.00.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:57:57 -0800 (PST)
Message-ID: <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
Date:   Mon, 14 Nov 2022 09:57:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Prarit Bhargava <prarit@redhat.com>
Cc:     pmladek@suse.com, Petr Pavlu <petr.pavlu@suse.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
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

On 12.11.22 02:47, Luis Chamberlain wrote:
> On Wed, Oct 19, 2022 at 02:00:55PM +0200, Petr Pavlu wrote:
>> On 10/18/22 20:33, Luis Chamberlain wrote:
>>> On Sat, Oct 15, 2022 at 11:27:10AM +0200, Petr Pavlu wrote:
>>>> The patch does address a regression observed after commit 6e6de3dee51a
>>>> ("kernel/module.c: Only return -EEXIST for modules that have finished
>>>> loading"). I guess it can have a Fixes tag added to the patch.
>>>>
>>>> I think it is hard to split this patch into parts because the implemented
>>>> "optimization" is the fix.
>>>
>>> git describe --contains 6e6de3dee51a
>>> v5.3-rc1~38^2~6
>>>
>>> I'm a bit torn about this situation. Reverting 6e6de3dee51a would be the
>>> right thing to do, but without it, it still leaves the issue reported
>>> by Prarit Bhargava. We need a way to resolve the issue on stable and
>>> then your optimizations can be applied on top.
>>
>> Simpler could be to do the following:
>>
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index d02d39c7174e..0302ac387e93 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -2386,7 +2386,8 @@ static bool finished_loading(const char *name)
>>   	sched_annotate_sleep();
>>   	mutex_lock(&module_mutex);
>>   	mod = find_module_all(name, strlen(name), true);
>> -	ret = !mod || mod->state == MODULE_STATE_LIVE;
>> +	ret = !mod || mod->state == MODULE_STATE_LIVE
>> +		|| mod->state == MODULE_STATE_GOING;
>>   	mutex_unlock(&module_mutex);
>>   
>>   	return ret;
>> @@ -2566,7 +2567,8 @@ static int add_unformed_module(struct module *mod)
>>   	mutex_lock(&module_mutex);
>>   	old = find_module_all(mod->name, strlen(mod->name), true);
>>   	if (old != NULL) {
>> -		if (old->state != MODULE_STATE_LIVE) {
>> +		if (old->state == MODULE_STATE_COMING
>> +		    || old->state == MODULE_STATE_UNFORMED) {
>>   			/* Wait in case it fails to load. */
>>   			mutex_unlock(&module_mutex);
>>   			err = wait_event_interruptible(module_wq,
>> @@ -2575,7 +2577,7 @@ static int add_unformed_module(struct module *mod)
>>   				goto out_unlocked;
>>   			goto again;
>>   		}
>> -		err = -EEXIST;
>> +		err = old->state != MODULE_STATE_LIVE ? -EBUSY : -EEXIST;
>>   		goto out;
>>   	}
>>   	mod_update_bounds(mod);
> 
> 
> Prarit, can you verify this still does not break the issue you reported?
> David, does this also fix your issue?

I didn't try, but from a quick glimpse I assume no. Allocating module 
space happens before handling eventual duplicates right now, before a 
module even is "alive" and in the MODULE_STATE_UNFORMED state.

But maybe I am missing something important.

-- 
Thanks,

David / dhildenb

