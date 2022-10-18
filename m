Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF5560281F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiJRJS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiJRJSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:18:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC55AB807
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666084699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIDXdwfZHTBvNme63up4p5nGL42BSI+TUibwt0PBRvw=;
        b=F0QeMRfDjJtLIyEQm9zqz5+R6jvNVZqQwbZpvWczkaKR+inF+evJj/Y6FxYk5pqgjACirX
        lgQZYgAxnmCLAbS6QK5K9u8jB9w6O3wH2iNrjhSvjSSk0iOxNynM5c90MXPxkEk/dL+jmp
        8duNHCOVlfOUorKq1+Yw/Oc0YManwDA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-632-JuK1-ceUOESXIKrljpcDLg-1; Tue, 18 Oct 2022 05:18:18 -0400
X-MC-Unique: JuK1-ceUOESXIKrljpcDLg-1
Received: by mail-wm1-f69.google.com with SMTP id h131-20020a1c2189000000b003c56437e529so1447133wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iIDXdwfZHTBvNme63up4p5nGL42BSI+TUibwt0PBRvw=;
        b=PcAMH6PywREqM7HJnkfzmAF+vWJo0VPhaLSwakz0bQQI31AqUTr+LrbrN/Ujdn1pVG
         M8BgrxssdAg9HvgWgbhGxnInwf6xynLK8pWcJs85P2SPzhTlzHGEQyJuk/CPW/8n7y6V
         NGuYA3LerphR2Zi9lpK3YZNfZlFZEkgiwq935Inm5JqIm6gPKLSM1FbJ1RLBhObNpM0I
         TIKjR26L3xiqdaeTlvGeqnN5YHghrzHrwCRcXwLZDV1KtjPo2DcOxKhfIMWjbfZiY/li
         Oy4GsNMt2tz5khFgNepocsHLT3q49lFn8IEnkwmWfFt4XPBYtSVPvq1cs4RDZcJI9XDk
         /cRg==
X-Gm-Message-State: ACrzQf1gDi7ld1dGnGmO/A0v3lHW0aS1dc/L+/5SOToPJLVhiDqfti1s
        10ZMqXD8b17xaRefBTJnf9w/jsa0uZhBIZ84J48Wc2jIhPvFLa36tml4c3d6VAnpeE8bXxOOQtO
        uDXCLtYBkRVGFAkAbN7nrt4Ie
X-Received: by 2002:a7b:cb92:0:b0:3c4:cf60:7a7 with SMTP id m18-20020a7bcb92000000b003c4cf6007a7mr1278707wmi.24.1666084697251;
        Tue, 18 Oct 2022 02:18:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM53SnT+0rXdVe6JPVnCYamGaykaRTOLltCDPLFVbV0fkm5zDkD32g0rRrGF1UY19SAk1K/1TA==
X-Received: by 2002:a7b:cb92:0:b0:3c4:cf60:7a7 with SMTP id m18-20020a7bcb92000000b003c4cf6007a7mr1278691wmi.24.1666084696890;
        Tue, 18 Oct 2022 02:18:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:8900:d1f:5430:86b1:31ba? (p200300cbc70589000d1f543086b131ba.dip0.t-ipconnect.de. [2003:cb:c705:8900:d1f:5430:86b1:31ba])
        by smtp.gmail.com with ESMTPSA id dn7-20020a05600c654700b003b47ff307e1sm12073106wmb.31.2022.10.18.02.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 02:18:16 -0700 (PDT)
Message-ID: <aada0b86-cca8-78f1-59ad-cd82b99c5f4a@redhat.com>
Date:   Tue, 18 Oct 2022 11:18:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To:     Petr Pavlu <petr.pavlu@suse.com>, mcgrof@kernel.org
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221016123031.3963-1-petr.pavlu@suse.com>
 <20221016123031.3963-4-petr.pavlu@suse.com>
 <d6e6abc4-84ae-0ddf-eb02-9f0537d4bed1@redhat.com>
 <86ed1568-52ce-b030-0fb0-1b902cb222d1@suse.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 3/4] module: Merge same-name module load requests
In-Reply-To: <86ed1568-52ce-b030-0fb0-1b902cb222d1@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> User space that concurrently loads and unloads the same module is shaky
>> already, no?
> 
> I cannot quite think of a scenario where it would practically matter how this
> corner case is handled. Prior to 6e6de3dee51a ("kernel/module.c: Only return
> -EEXIST for modules that have finished loading"), an init_module() call would
> have returned EEXIST in this case. After the mentioned commit, the loader
> waits for the old module to be gone and then proceeds with the load. Finally,
> this patch changes init_module() to immediately return EBUSY.
> 
> With the proposed changes, EEXIST and EBUSY is used as follows:
> * EEXIST is returned from init_module() if a given module is already loaded or
>    becomes live by a parallel load.
> * EBUSY is returned if a concurrent operation is detected on a module with the
>    same name and the module is not live. This applies to both init_module() and
>    delete_module().
> 
> I think it is generally a good idea to return EEXIST from init_module() only
> if a given module is fully operational. Userspace (udev) typically handles
> EEXIST as "success" and so there is some potential for confusion otherwise.
> 
> However, I don't feel strongly about this particular case.
> 

I'd vote to keep it simple and not change the way errors are returned 
unless there is real reason.

EBUSY is currently documented to be only returned for "Timeout while 
trying to resolve a symbol reference by this module.". Your're changing 
that.

EEXIST: "A module with this name is already loaded." -- which includes 
IMHO if the module is concurrently going away. Again, it's all racy 
either way.

>>> * A new reference-counted shared_load_info structure is introduced to
>>>     keep track of duplicate load requests. Two loads are considered
>>>     equivalent if their module name matches. In case a load duplicates
>>>     another running insert, the code waits for its completion and then
>>>     returns -EEXIST or -EBUSY depending on whether it succeeded.
>>>
>>> Moving the check for same-name module loads earlier has also a positive
>>> effect on reducing memory pressure. For instance, David Hildenbrand and
>>> Lin Liu reported [1] that when KASAN_INLINE is enabled (resulting in
>>> large module size), with plenty of devices that udev wants to probe and
>>> with plenty of CPUs that can carry out that probing concurrently, the
>>> system can actually run out of module vmap space and trigger vmap
>>> allocation errors. This is fixed by the patch too as it avoids duplicate
>>> layout_and_allocate() work.
>>
>> It might we reasonable to add the kernel messages here. Can you also add
>> the Reported-by?
> 
> Ok, I avoided adding the Reported-by tag because I was not sure how to
> properly record that it applies only to the vmap allocation issue. I suspect
> it can be clarified after the tag in a "[...]" note.
> 
> My plan is to add the following:
> 
> [  165.842123] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
> [  165.843359] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
> [  165.844894] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
> [  165.847028] CPU: 253 PID: 4995 Comm: systemd-udevd Not tainted 5.19.0 #2
> [  165.935689] Hardware name: Lenovo ThinkSystem SR950 -[7X12ABC1WW]-/-[7X12ABC1WW]-, BIOS -[PSE130O-1.81]- 05/20/2020
> [  165.947343] Call Trace:
> [  165.950075]  <TASK>
> [  165.952425]  dump_stack_lvl+0x57/0x81
> [  165.956532]  warn_alloc.cold+0x95/0x18a
> [  165.981219]  __vmalloc_node_range+0x291/0x560
> [  166.003741]  module_alloc+0xe7/0x170
> [  166.011840]  move_module+0x4c/0x630
> [  166.015751]  layout_and_allocate+0x32c/0x560
> [  166.020519]  load_module+0x8e0/0x25c0
> [  166.053854]  __do_sys_finit_module+0x11a/0x1c0
> [  166.068494]  do_syscall_64+0x59/0x90
> [  166.095855]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [  165.818200] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
> 
> Reported-by: Lin Liu <linl@redhat.com>
> Reported-by: David Hildenbrand <david@redhat.com>
> [the vmap allocation issue]

Sounds good, you can also mention which issue was reported by whom in 
the text in addition.

[...]

>>> -static int add_unformed_module(struct module *mod)
>>> +static struct shared_load_info *add_running_load(const struct load_info *info)
>>>    {
>>> -	int err;
>>>    	struct module *old;
>>> +	struct shared_load_info *shared_info;
>>>    
>>> -	mod->state = MODULE_STATE_UNFORMED;
>>> -
>>> -again:
>>>    	mutex_lock(&module_mutex);
>>> -	old = find_module_all(mod->name, strlen(mod->name), true);
>>> -	if (old != NULL) {
>>> -		if (old->state != MODULE_STATE_LIVE) {
>>> -			/* Wait in case it fails to load. */
>>> +
>>> +	/* Search if there is a running load of a module with the same name. */
>>> +	list_for_each_entry(shared_info, &running_loads, list)
>>> +		if (strcmp(shared_info->name, info->name) == 0) {
>>> +			int err;
>>> +
>>> +			shared_load_info_get(shared_info);
>>>    			mutex_unlock(&module_mutex);
>>> -			err = wait_event_interruptible(module_wq,
>>> -					       finished_loading(mod->name));
>>> -			if (err)
>>> -				goto out_unlocked;
>>> -			goto again;
>>> +
>>> +			err = wait_for_completion_interruptible(
>>> +				&shared_info->done);
>>> +			/*
>>> +			 * Return -EBUSY when the parallel load failed for any
>>> +			 * reason. This load might end up another way but we are
>>> +			 * not going to try.
>>
>> Why not? Usually "-EAGAIN" signals that user space should retry. But I
>> hope that we can avoid EBUSY altogether and simply retry here.
>>
>> I'd suggest shared_load_info_put()+retry.
>>
>> No need to optimize for corner cases (concurrent load failing so we
>> don't retry ourselves).
> 
> Avoiding a retry in this case is actually the main motivation for this patch.
> It looks I'm still failing to explain this in the commit message, but please
> see my replies on previous versions of the patch where I provided more details
> about the observed issue [1, 2].

How is it the common case we care about that a parallel load *failed* 
(not with -EEXIST but via some other error)?

That would mean we're optimizing for the case that 400 CPUs try loading 
the same module and loading the module essentially always fails.

Is this really what we want to optimize?

Isn't there a way to not report EBUSY in that case as well? Return the 
error from the other load that failed?

> 
> Worth noting is that both your scenario and my case are situations where
> a same module is attempted to be loaded multiple times, once per each CPU.
> Even if only one attempt is eventually fully processed, the decision that
> other parallel loads are not needed happens quite late. In particular, udev
> (libkmod) still has to load and decompress a given module binary multiple
> times. Ideally, I think this should be prevented altogether by improving other
> parts of the whole process. Udev could be made smarter to avoid duplicate
> loads or the kernel could model uevents related to CPUs differently. This is
> something that I was also considering but eventually settled on trying to fix
> only the immediate kernel regression.

Yes, exactly same thoughts here.


-- 
Thanks,

David / dhildenb

