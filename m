Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26B05FE94F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJNHQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiJNHQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:16:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D118E122758
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 00:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665731764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KO4vXEPLGC2thf70UdJUXD19wedZIU97Jq4KCtGmIIs=;
        b=hszTEZzkRuSf8n2AiV0OB9YZjcU7MZyoKAOrClGZGYw1E+Dmt6CeN9z/vrQmmtXVCyrFtH
        5HQXBH/dF8BFdV2R0AyJo0Kxmq2wmseopi7cwgrYDPgp4s1EGhDBY3kFpO20jrV8N7vBxE
        KJqnwmAIaqXok9AAR/wyViPEi0ETcts=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-542-XQ0GuBbfNamKQyuCvxb2sA-1; Fri, 14 Oct 2022 03:16:02 -0400
X-MC-Unique: XQ0GuBbfNamKQyuCvxb2sA-1
Received: by mail-wr1-f72.google.com with SMTP id j8-20020adfa548000000b0022e2bf8f48fso1587263wrb.23
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 00:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KO4vXEPLGC2thf70UdJUXD19wedZIU97Jq4KCtGmIIs=;
        b=ENCKtOwf2HidcZ6KhZtZYxMv218A+dg+OfpQg6ijLbkcWiYHKA6Zvk+elNNHOIoJkB
         E+140oWz48SUwsoFhky5ItC6coSfex5EGFhpeNW16Hgq5XgkfWZijWFXfOnCbd+yi7zt
         no/yeQ+qeccvkwhxfclfCZuhM7yspWthGeTsp6ZtQqKlv4w6yhtugwJ8FbyXTNh+83uG
         GkHd4KAULzmIA1BzuY+nvYn45uDjEz+QaTnDaYJdlR4IZ3vkve6ChJxsmQkhXAXRMb6A
         J8d6B5nF/nFirjfYMN74db05Vd6PLaurQcIQfs9J9HBanB2QKShtqhjZrYl2+XAOhTWZ
         eS2g==
X-Gm-Message-State: ACrzQf0FidlDv7DE7QoUeL9V4GXXwHV/gZcbHvHbNMN+/0asEJLqAwYV
        DSx3W+tjsUC8qVgAI2IjMOu3Zc01Qptj2cq+Ja9SJcyb5qD+IGoRruAqeM5UeSIrS/I9j6ZslTr
        PzS4y0SOdpRt3zRhoOgavZ52o
X-Received: by 2002:a05:6000:1565:b0:22f:1407:9bfd with SMTP id 5-20020a056000156500b0022f14079bfdmr2279477wrz.620.1665731761364;
        Fri, 14 Oct 2022 00:16:01 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM41rldxBoNh/RMt1ByTlaTXLw9SYpH3W5fAvpDXpxqtb3bZsCT/4Dv37kMAf+ueHCWdQV2ZKA==
X-Received: by 2002:a05:6000:1565:b0:22f:1407:9bfd with SMTP id 5-20020a056000156500b0022f14079bfdmr2279458wrz.620.1665731761011;
        Fri, 14 Oct 2022 00:16:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:8f00:9219:ab4c:826e:9646? (p200300cbc7048f009219ab4c826e9646.dip0.t-ipconnect.de. [2003:cb:c704:8f00:9219:ab4c:826e:9646])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c154700b003a3442f1229sm6872888wmg.29.2022.10.14.00.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 00:16:00 -0700 (PDT)
Message-ID: <77d0c7e8-ca07-bd38-5624-03fbc659733b@redhat.com>
Date:   Fri, 14 Oct 2022 09:15:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        Lin Liu <linl@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        petr.pavlu@suse.com
References: <20221013180518.217405-1-david@redhat.com>
 <alpine.LSU.2.21.2210140806130.17614@pobox.suse.cz>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] kernel/module: allocate module vmap space after making
 sure the module is unique
In-Reply-To: <alpine.LSU.2.21.2210140806130.17614@pobox.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.10.22 08:09, Miroslav Benes wrote:
> Hi,
> 
> On Thu, 13 Oct 2022, David Hildenbrand wrote:
> 
>> We already make sure to allocate percpu data only after we verified that
>> the module we're loading hasn't already been loaded and isn't
>> concurrently getting loaded -- that it's unique.
>>
>> On big systems (> 400 CPUs and many devices) with KASAN enabled, we're now
>> phasing a similar issue with the module vmap space.
>>
>> When KASAN_INLINE is enabled (resulting in large module size), plenty
>> of devices that udev wants to probe and plenty (> 400) of CPUs that can
>> carry out that probing concurrently, we can actually run out of module
>> vmap space and trigger vmap allocation errors:
>>
>> [  165.818200] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
>> [  165.836622] vmap allocation for size 315392 failed: use vmalloc=<size> to increase size
>> [  165.837461] vmap allocation for size 315392 failed: use vmalloc=<size> to increase size
>> [  165.840573] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
>> [  165.841059] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
>> [  165.841428] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
>> [  165.841819] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
>> [  165.842123] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
>> [  165.843359] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
>> [  165.844894] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
>> [  165.847028] CPU: 253 PID: 4995 Comm: systemd-udevd Not tainted 5.19.0 #2
>> [  165.935689] Hardware name: Lenovo ThinkSystem SR950 -[7X12ABC1WW]-/-[7X12ABC1WW]-, BIOS -[PSE130O-1.81]- 05/20/2020
>> [  165.947343] Call Trace:
>> [  165.950075]  <TASK>
>> [  165.952425]  dump_stack_lvl+0x57/0x81
>> [  165.956532]  warn_alloc.cold+0x95/0x18a
>> [  165.960836]  ? zone_watermark_ok_safe+0x240/0x240
>> [  165.966100]  ? slab_free_freelist_hook+0x11d/0x1d0
>> [  165.971461]  ? __get_vm_area_node+0x2af/0x360
>> [  165.976341]  ? __get_vm_area_node+0x2af/0x360
>> [  165.981219]  __vmalloc_node_range+0x291/0x560
>> [  165.986087]  ? __mutex_unlock_slowpath+0x161/0x5e0
>> [  165.991447]  ? move_module+0x4c/0x630
>> [  165.995547]  ? vfree_atomic+0xa0/0xa0
>> [  165.999647]  ? move_module+0x4c/0x630
>> [  166.003741]  module_alloc+0xe7/0x170
>> [  166.007747]  ? move_module+0x4c/0x630
>> [  166.011840]  move_module+0x4c/0x630
>> [  166.015751]  layout_and_allocate+0x32c/0x560
>> [  166.020519]  load_module+0x8e0/0x25c0
>> [  166.024623]  ? layout_and_allocate+0x560/0x560
>> [  166.029586]  ? kernel_read_file+0x286/0x6b0
>> [  166.034269]  ? __x64_sys_fspick+0x290/0x290
>> [  166.038946]  ? userfaultfd_unmap_prep+0x430/0x430
>> [  166.044203]  ? lock_downgrade+0x130/0x130
>> [  166.048698]  ? __do_sys_finit_module+0x11a/0x1c0
>> [  166.053854]  __do_sys_finit_module+0x11a/0x1c0
>> [  166.058818]  ? __ia32_sys_init_module+0xa0/0xa0
>> [  166.063882]  ? __seccomp_filter+0x92/0x930
>> [  166.068494]  do_syscall_64+0x59/0x90
>> [  166.072492]  ? do_syscall_64+0x69/0x90
>> [  166.076679]  ? do_syscall_64+0x69/0x90
>> [  166.080864]  ? do_syscall_64+0x69/0x90
>> [  166.085047]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
>> [  166.090984]  ? lockdep_hardirqs_on+0x79/0x100
>> [  166.095855]  entry_SYSCALL_64_after_hwframe+0x63/0xcd[  165.818200] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
>>
>> Interestingly, when reducing the number of CPUs (nosmt), it works as
>> expected.
>>
>> The underlying issue is that we first allocate memory (including module
>> vmap space) in layout_and_allocate(), and then verify whether the module
>> is unique in add_unformed_module(). So we end up allocating module vmap
>> space even though we might not need it -- which is a problem when modules
>> are big and we can have a lot of concurrent probing of the same set of
>> modules as on the big system at hand.
>>
>> Unfortunately, we cannot simply add the module earlier, because
>> move_module() -- that allocates the module vmap space -- essentially
>> brings the module to life from a temporary one. Adding the temporary one
>> and replacing it is also sub-optimal (because replacing it would require
>> to synchronize against RCU) and feels kind of dangerous judging that we
>> end up copying it.
>>
>> So instead, add a second list (pending_load_infos) that tracks the modules
>> (via their load_info) that are unique and are still getting loaded
>> ("pending"), but haven't made it to the actual module list yet. This
>> shouldn't have a notable runtime overhead when concurrently loading
>> modules: the new list is expected to usually either be empty or contain
>> very few entries for a short time.
>>
>> Thanks to Uladzislau for his help to verify that it's not actually a
>> vmap code issue.
> 
> this seems to be related to what
> https://lore.kernel.org/all/20220919123233.8538-1-petr.pavlu@suse.com/
> tries to solve. Just your symptoms are different. Does the patch set fix
> your issue too?

Hi Miroslav,

the underlying approach with a load_info list is similar (which is nice 
to see), so I assume it will similarly fix the issue.

I'm not sure if merging the requests (adding the refcount logic and the 
-EBUSY change is really required/wanted), though. Looks like some of 
these changes that might have been factored out into separate patches.

Not my call to make. I'll give the set a churn on the machine where I 
can reproduce the issue.

-- 
Thanks,

David / dhildenb

