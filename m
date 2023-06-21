Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AC7737D61
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjFUIMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFUIMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:12:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9EF10E6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687335108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DnhJV2KGCC+wiy6UkhMaiziRwfOnl5wpgh8up90fkFU=;
        b=Z8ypdSa5pVhJxWlOykifonopz3vI2zHsuc6pJytLSs2AhW+84s7S5eMVTg7+L6K/FS/lT6
        DFwhit2Iv/kfqnZMhZaISvjahJ4uIf93Tx6ZXronIB+WYFsCrcN1kGy64WDnyNpvZLECGi
        52TGTCBSJE8A1QsgyjgDNisQcqDUvt8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-xs6mXFc6ODa6hqLIOISW-A-1; Wed, 21 Jun 2023 04:11:46 -0400
X-MC-Unique: xs6mXFc6ODa6hqLIOISW-A-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4f8fceddaeaso1433351e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687335105; x=1689927105;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnhJV2KGCC+wiy6UkhMaiziRwfOnl5wpgh8up90fkFU=;
        b=iaElkkr6NKeU1kI1xeCNkB6QEImA6dKrN/xd89nSE5LTfHnZxPPW8O57dZqnFH9T9b
         5HXdInmc4Kjjcr+nv/Huk8JDbows1YdrEwnFUXbOKkggQ7yCO81cQ1hzMmCzMw5u8yXR
         Gq4Qb1re602hp0hRt+e7hwiavX3zFTGH4ihC29zFkHmlZe946E6zgZSpFvqYO2FXVWiP
         dczcKW8AXGrPDNDIsh34l69+PdC64LJLfU6jyDWWulzOVm+LcGgvjSLwzYCEPLfgblbD
         5TJ+UcsI0M7/HohCcWbzUA1z3zC57yIB8soKNUH9Urd8tedDYmx/AUEQ0eJ7u/tGEoE1
         6DXA==
X-Gm-Message-State: AC+VfDy2O+2anuSPPe/2M9t1HxBwsCXyfyIwIvOX3XqWdKJr0qYoi/pz
        S7Xld5hoH9mWBm06qm6O8ARqYG2S73L07FsF9NYO42xdqT1dpYRTqwRBQspGpnucD3o1iUL8uOg
        GDGYwrOlhvJlXzebtLYcdUSv8
X-Received: by 2002:a05:6512:556:b0:4f8:4a86:3d82 with SMTP id h22-20020a056512055600b004f84a863d82mr9657102lfl.51.1687335104937;
        Wed, 21 Jun 2023 01:11:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5QHb/j3jEs5APyw67qLtHqMCCJJ4sJJDxS4xRs2nB3GY+63qdju+Fdp4euidCYoPbhNLySCA==
X-Received: by 2002:a05:6512:556:b0:4f8:4a86:3d82 with SMTP id h22-20020a056512055600b004f84a863d82mr9657084lfl.51.1687335104461;
        Wed, 21 Jun 2023 01:11:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:9c00:7978:3030:9d9a:1aef? (p200300cbc70b9c00797830309d9a1aef.dip0.t-ipconnect.de. [2003:cb:c70b:9c00:7978:3030:9d9a:1aef])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5711000000b003062b2c5255sm3779725wrv.40.2023.06.21.01.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 01:11:43 -0700 (PDT)
Message-ID: <83689f25-ca50-7ece-45f0-a936e704df7d@redhat.com>
Date:   Wed, 21 Jun 2023 10:11:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     John Hubbard <jhubbard@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <20230620011719.155379-1-jhubbard@nvidia.com>
 <ed83df65-f785-7077-ddd0-4e53d6fa6056@redhat.com>
 <80e01fa9-28c0-37e8-57f8-5bb4ce9a9db7@nvidia.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/memory_hotplug.c: don't fail hot unplug quite so
 eagerly
In-Reply-To: <80e01fa9-28c0-37e8-57f8-5bb4ce9a9db7@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.23 23:54, John Hubbard wrote:
> On 6/20/23 00:12, David Hildenbrand wrote:
>> On 20.06.23 03:17, John Hubbard wrote:
>>> mm/memory_hotplug.c: don't fail hot unplug quite so eagerly
>>>
>>> Some device drivers add memory to the system via memory hotplug. When
>>> the driver is unloaded, that memory is hot-unplugged.
>>
>> Which interfaces are they using to add/remove memory?
> 
> It's coming in from the kernel driver, like this:
> 
> offline_and_remove_memory()
>       walk_memory_blocks()
>           try_offline_memory_block()
>               device_offline()
>                   memory_subsys_offline()
>                       offline_pages()
> 
> ...and the above is getting invoked as part of killing a user space
> process that was helping (for performance reasons) holding the device
> nodes open. That triggers a final close of the file descriptors and
> leads to tearing down the driver. The teardown succeeds even though
> the memory was not offlined, and now everything is, to use a technical
> term, "stuck". :)
> 

Ah, I see, thanks! I thought it would just be offlining from user space.

> More below...
> 
>>
>>>
>>> However, memory hot unplug can fail. And these days, it fails a little
>>> too easily, with respect to the above case. Specifically, if a signal is
>>> pending on the process, hot unplug fails. This leads directly to: the
>>> user must reboot the machine in order to unload the driver, and
>>> therefore the device is unusable until the machine is rebooted.
>>
>> Why can't they retry in user space when offlining fails with -EINTR, or re-trigger driver unloading?
> 
> If someone uses "kill -9" to kill that process, then we get here,
> because user space cannot trap that signal.

Understood, thanks!

> 
> 
> ...
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -1879,12 +1879,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>>>        do {
>>>            pfn = start_pfn;
>>>            do {
>>> -            if (signal_pending(current)) {
>>> -                ret = -EINTR;
>>> -                reason = "signal backoff";
>>> -                goto failed_removal_isolated;
>>> -            }
>>> -
>>>                cond_resched();
>>>                ret = scan_movable_pages(pfn, end_pfn, &pfn);
>>
>> No, we can't remove that. It's documented behavior that exists precisely for that reason:
>>
>> https://docs.kernel.org/admin-guide/mm/memory-hotplug.html#id21
>>
>> "
>> When offlining is triggered from user space, the offlining context can be terminated by sending a fatal signal. A timeout based offlining can easily be implemented via:
>>
>> % timeout $TIMEOUT offline_block | failure_handling
>> "
>>
>> Otherwise, there is no way to stop an userspace-triggered offline operation that loops forever in the kernel.
> 
> OK yes, I see.
> 
>>
>> I guess switching to fatal_signal_pending() might help to some degree, it should keep the timeout trick working.
>>
>> But it wouldn't help in your case because where root kills arbitrary processes. I'm not sure if that is something we should be paying attention to.
>>
> 
> Right. I think it would be more accurate perhaps, but it wouldn't help
> this particular complaint.
> 
> Perhaps it is reasonable to claim that, "well, kill -9 *means* that you
> end up here!" :) And the above patch clearly is not the way to go, but...
> 
> ...what about discerning between "user initiated offline_pages" and
> "offline pages as part of a driver shutdown/unload"?

Makes sense to me.

There are two ways for triggering it directly from user space:

1) drivers/base/core.c:online_store()
2) drivers/base/memory.c:state_store()

We cannot easily hook into 2) to indicate "we're offlining directly
from user space". SO we might have to do it the other way around.


Something along the following lines should do the trick (expect whitespace damage):


diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 53ee7654f009..acd4b739505a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -152,6 +152,13 @@ void put_online_mems(void)
  
  bool movable_node_enabled = false;
  
+/*
+ * Protected by the device hotplug lock. Indicates whether device offlining
+ * is triggered from try_offline_memory_block() such that we don't fail memory
+ * offlining if a signal is pending.
+ */
+static bool mhp_in_try_offline_memory_block;
+
  #ifndef CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE
  int mhp_default_online_type = MMOP_OFFLINE;
  #else
@@ -1860,7 +1867,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
         do {
                 pfn = start_pfn;
                 do {
-                       if (signal_pending(current)) {
+                       if (!mhp_in_try_offline_memory_block &&
+                           signal_pending(current)) {
                                 ret = -EINTR;
                                 reason = "signal backoff";
                                 goto failed_removal_isolated;
@@ -2177,7 +2185,9 @@ static int try_offline_memory_block(struct memory_block *mem, void *arg)
         if (page && zone_idx(page_zone(page)) == ZONE_MOVABLE)
                 online_type = MMOP_ONLINE_MOVABLE;
  
+       mhp_in_try_offline_memory_block = true;
         rc = device_offline(&mem->dev);
+       mhp_in_try_offline_memory_block = false;
         /*
          * Default is MMOP_OFFLINE - change it only if offlining succeeded,
          * so try_reonline_memory_block() can do the right thing.



There is still arch/powerpc/platforms/pseries/hotplug-memory.c that calls
device_offline() and would fail on signals (not sure if relevant, like for virtio-mem it
shouldn't be that relevant).

I guess dlpar_remove_lmb() can now simply call offline_and_remove_memory().
[I might craft a patch later]

-- 
Cheers,

David / dhildenb

