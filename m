Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FF7722486
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjFEL0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjFEL0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:26:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9F6DF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685964365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nu9/UJ05GmGMdlY8zv0TMF1pLalxFizp/2Lh8UrDm0s=;
        b=jJA13n1Xi363hh+yh6JBZjZZchWdK14c6kqi98uN1INc3cGBAddt0oqV3pUQDBsVf4swVu
        B5iHclXZkx3XQgFKitb4A6vH7E3bIETUJonHzfW76pr7WXEifjg89ReH01BShxTWuDOAmV
        PatSyfGZrBvGQmy9ChnTybtXJdJL9FI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-3bRqWEnYMCmXOjzhGlE5yg-1; Mon, 05 Jun 2023 07:26:03 -0400
X-MC-Unique: 3bRqWEnYMCmXOjzhGlE5yg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f736116989so7315825e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 04:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685964363; x=1688556363;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nu9/UJ05GmGMdlY8zv0TMF1pLalxFizp/2Lh8UrDm0s=;
        b=VlzWZZjiRW2h9JCGaElAIwRiwcI5tYwm+fpe8zOpb+hBUXhOr2h61wXBGDirZEIQTL
         UfTTosLzUdmK0mczKlay5zpAh199uu9k4XtGxpXh70Vdny3JJk63uE4WtgutTvpFnfDS
         dV/aBmiFf9kBABEWKy0W0bwlKxxUYY4Q+5SKczGc6U/pkRWi5uT+hlzu7IElL0nZCxOo
         DrdNW2AdA+e2pEGWlwyHUDl4+OMviTWPfhaRShpTxUXS/wkq0Gz5toMa48KltTEeQxWd
         baUA4+absnX3OTCnMZJv4yB3tG7DWy0azbVTkVzxIJYscFHdEaojVx/5rY5fQ44Xb1P9
         n+tQ==
X-Gm-Message-State: AC+VfDwjTyyes3CdPHocU4hr2vbavUgZMQCEPEREXRwHRVa2hpPZfXcA
        c00EioGDDHKCDLGVGkHt80N48Ya48WYEt+qzpOqiUkp66vQkx8mxIdq+Kscy0cYpbneBQ2v9IEs
        /ZOI2NauSAl52sVVsYv15SF6L
X-Received: by 2002:a1c:7217:0:b0:3f4:2a69:409 with SMTP id n23-20020a1c7217000000b003f42a690409mr7918752wmc.11.1685964362703;
        Mon, 05 Jun 2023 04:26:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ52l2nNfYdRL0/tTDYacX5nCUAhQsJ3OdNJg+upRqFfnFrCCP3ViixDPw6m51Xn9fu6HOidgQ==
X-Received: by 2002:a1c:7217:0:b0:3f4:2a69:409 with SMTP id n23-20020a1c7217000000b003f42a690409mr7918715wmc.11.1685964362268;
        Mon, 05 Jun 2023 04:26:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:8f00:ed9:16b8:4e22:5820? (p200300cbc7378f000ed916b84e225820.dip0.t-ipconnect.de. [2003:cb:c737:8f00:ed9:16b8:4e22:5820])
        by smtp.gmail.com with ESMTPSA id u12-20020a05600c00cc00b003f7678a07c4sm3775227wmm.29.2023.06.05.04.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 04:26:01 -0700 (PDT)
Message-ID: <fa3f1a1f-edc6-f13b-cc84-f3264b03b0b1@redhat.com>
Date:   Mon, 5 Jun 2023 13:26:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johan Hovold <johan@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, song@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
References: <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
 <ZHRpH-JXAxA6DnzR@hovoldconsulting.com>
 <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
 <ZHSeOUpKtyc8VKx5@hovoldconsulting.com>
 <ZHTCK2_1pF61yWIr@hovoldconsulting.com>
 <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
 <ZHYitt7P7W+8ZlSB@bombadil.infradead.org>
 <499e30cc-d015-8353-1364-50d17da58f47@redhat.com>
 <ZHd8bLPY4OQCb/Z5@bombadil.infradead.org>
 <ba60bca6-b682-4c27-3c54-2512b6f16151@redhat.com>
 <ZHoTFDkPIgglW0sU@bombadil.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
In-Reply-To: <ZHoTFDkPIgglW0sU@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.23 18:04, Luis Chamberlain wrote:
> On Fri, Jun 02, 2023 at 05:19:58PM +0200, David Hildenbrand wrote:
>> On 31.05.23 18:57, Luis Chamberlain wrote:
>>> On Wed, May 31, 2023 at 09:51:41AM +0200, David Hildenbrand wrote:
>>>> On 30.05.23 18:22, Luis Chamberlain wrote:
>>>>> On Mon, May 29, 2023 at 09:55:15PM -0400, Linus Torvalds wrote:
>>>>>> On Mon, May 29, 2023 at 11:18 AM Johan Hovold <johan@kernel.org> wrote:
>>>>>>>
>>>>>>> I took a closer look at some of the modules that failed to load and
>>>>>>> noticed a pattern in that they have dependencies that are needed by more
>>>>>>> than one device.
>>>>>>
>>>>>> Ok, this is a "maybe something like this" RFC series of two patches -
>>>>>> one trivial one to re-organize things a bit so that we can then do the
>>>>>> real one which uses a filter based on the inode pointer to return an
>>>>>> "idempotent return value" for module loads that share the same inode.
>>>>>>
>>>>>> It's entirely untested, and since I'm on the road I'm going to not
>>>>>> really be able to test it. It compiles for me, and the code looks
>>>>>> fairly straightforward, but it's probably buggy.
>>>>>>
>>>>>> It's very loosely based on Luis' attempt,  but it
>>>>>>     (a) is internal to module loading
>>>>>>     (b) uses a reliable cookie
>>>>>>     (c) doesn't leave the cookie around randomly for later
>>>>>>     (d) has seen absolutely no testing
>>>>>>
>>>>>> Put another way: if somebody wants to play with this, please treat it
>>>>>> as a starting point, not the final thing. You might need to debug
>>>>>> things, and fix silly mistakes.
>>>>>>
>>>>>> The idea is to just have a simple hash list of currently executing
>>>>>> module loads, protected by a trivial spinlock. Every module loader
>>>>>> adds itself to the right hash list, and if they were the *first* one
>>>>>> (ie no other pending module loads for that inode), will actually do
>>>>>> the module load.
>>>>>>
>>>>>> Everybody who *isn't* the first one will just wait for completion and
>>>>>> return the same error code that the first one returned.
>>>>>
>>>>> That's also a hell much more snazzier MODULE_DEBUG_AUTOLOAD_DUPS if we
>>>>> ever wanted to do something similar there if we wanted to also
>>>>> join request_module() calls, instead of it hiding under debug.
>>>>>
>>>>>> This is technically bogus. The first one might fail due to arguments.
>>>>>
>>>>> For boot it's fine, as I can't think of boot wanting to support trying
>>>>> to load a module with different arguments but who knows. But I can't
>>>>> see it sensible to issue concurrent multiple requests for modules
>>>>> with different arguments without waiting in userspace for the first
>>>>> to fail.
>>>>>
>>>>> Even post-boot, doing that sounds rather insane, but it would certainly
>>>>> be a compromise and should probably be clearly documented. I think just
>>>>> a comment acknolwedging that corner case seems sensible.
>>>>>
>>>>> Because we won't be able to get the arguments until we process the
>>>>> module, so it would be too late for this optimization on kread. So it is
>>>>> why I had also stuck to the original feature being in kread, as then it
>>>>> provides a uniq kread call and the caller is aware of it. But indeed I
>>>>> had not considered the effects of arguments.
>>>>>
>>>>> Lucas, any thoughts from modules kmod userspace perspective into
>>>>> supporting anyone likely issuing concurrent modules requests with
>>>>> differing arguments?
>>>>>
>>>>>> So the cookie shouldn't be just the inode, it should be the inode and
>>>>>> a hash of the arguments or something like that.
>>>>>
>>>>> Personally I think it's a fine optimization without the arguments.
>>>>>
>>>>>> But it is what it is,
>>>>>> and apart from possible show-stopper bugs this is no worse than the
>>>>>> failed "exclusive write deny" attempt. IOW - maybe worth trying?
>>>>>
>>>>> The only thing I can think of is allowing threads other than the
>>>>> first one to complete before the one that actually loaded the
>>>>> module. I thought about this race for module auto-loading, see
>>>>> the comment in kmod_dup_request_announce(), so that just
>>>>> further delays the completion to other thread with a stupid
>>>>> queue_work(). That seems more important for module auto-loading
>>>>> duplicates than for boot finit_module() duplicates. But not sure
>>>>> if odering matters in the end due to a preemtible kernel and maybe
>>>>> that concern is hysteria.
>>>>>
>>>>>> And if *that* didn't sell people on this patch series, I don't know
>>>>>> what will. I should be in marketing! Two drink minimums, here I come!
>>>>>
>>>>> Sold:
>>>>>
>>>>> on 255 vcpus 0 duplicates found with this setup:
>>>>>
>>>>> root@kmod ~ # cat /sys/kernel/debug/modules/stats
>>>>>             Mods ever loaded       66
>>>>>         Mods failed on kread       0
>>>>> Mods failed on decompress       0
>>>>>      Mods failed on becoming       0
>>>>>          Mods failed on load       0
>>>>>            Total module size       11268096
>>>>>          Total mod text size       4149248
>>>>>           Failed kread bytes       0
>>>>>      Failed decompress bytes       0
>>>>>        Failed becoming bytes       0
>>>>>            Failed kmod bytes       0
>>>>>     Virtual mem wasted bytes       0
>>>>>             Average mod size       170729
>>>>>        Average mod text size       62868
>>>>>
>>>>> So:
>>>>>
>>>>> Tested-by: Luis Chamberlain <mcgrof@kernel.org>
>>>>>
>>>>> In terms of bootup timing:
>>>>>
>>>>> Before:
>>>>> Startup finished in 41.653s (kernel) + 44.305s (userspace) = 1min 25.958s
>>>>> graphical.target reached after 44.178s in userspace.
>>>>> After:
>>>>> Startup finished in 23.995s (kernel) + 40.350s (userspace) = 1min 4.345s
>>>>> graphical.target reached after 40.226s in userspace.
>>>>
>>>> I'll try grabbing the system where we saw the KASAN-related issues [1] and
>>>> give it a churn with and without the two patches. Might take a bit (~1 day),
>>>> unfortunately.
>>>>
>>>> [1] https://lkml.kernel.org/r/20221013180518.217405-1-david@redhat.com
>>>
>>> Great, don't forget:
>>>
>>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>>> index 82b0dcc1fe77..222015093eeb 100644
>>> --- a/kernel/module/main.c
>>> +++ b/kernel/module/main.c
>>> @@ -3066,7 +3066,7 @@ struct idempotent {
>>>    #define IDEM_HASH_BITS 8
>>>    static struct hlist_head idem_hash[1 << IDEM_HASH_BITS];
>>> -static struct spinlock idem_lock;
>>> +static DEFINE_SPINLOCK(idem_lock);
>>>    static bool idempotent(struct idempotent *u, const void *cookie)
>>>    {
>>>
>>
>> Finally was able to run it on that ThinkSystem SR950 with 8 populated
>> sockets -> 224 cores and 448 logical CPUs.
>>
>> The KASAN vmap issues on that system were already no longer reproducible with your
>> (Luis) previous work that's already in master.
>>
>> I tested a !debug and debug config (both based on corresponding RHEL9 configs), comparing
>> 929ed21dfdb6 ("master") with 929ed21dfdb6 + Linus' patches ("patched").
>>
>>
>> Unfortunately, boot times vary a lot, and I did not figure out how to reduce
>> the noise. I captured the "systemd-analyze blame" output as well.
>>
>>
>> 1) !debug config (not enabling KASAN)
>>
>> a) master
>>
>> Startup finished in 32.225s (kernel) + 7.399s (initrd) + 20.378s (userspace) = 1min 3ms
>> multi-user.target reached after 20.352s in userspace.
>> Startup finished in 43.734s (kernel) + 7.288s (initrd) + 19.827s (userspace) = 1min 10.851s
>> multi-user.target reached after 19.800s in userspace.
>> Startup finished in 50.514s (kernel) + 7.171s (initrd) + 24.757s (userspace) = 1min 22.443s
>> multi-user.target reached after 24.734s in userspace.
>> Startup finished in 26.722s (kernel) + 7.249s (initrd) + 23.923s (userspace) = 57.895s
>> multi-user.target reached after 23.892s in userspace.
>>
>> b) patched
>>
>> Startup finished in 36.318s (kernel) + 7.177s (initrd) + 21.383s (userspace) = 1min 4.879s
>> multi-user.target reached after 21.355s in userspace.
>> Startup finished in 36.318s (kernel) + 7.177s (initrd) + 21.383s (userspace) = 1min 4.879s
>> multi-user.target reached after 21.355s in userspace.
>> Startup finished in 1min 34.678s (kernel) + 7.239s (initrd) + 24.066s (userspace) = 2min 5.985s
>> multi-user.target reached after 24.040s in userspace.
>> Startup finished in 25.879s (kernel) + 7.144s (initrd) + 29.665s (userspace) = 1min 2.689s
>> multi-user.target reached after 29.637s in userspace.
>>
>>
>>
>> 2) debug config (enabling KASAN)
>>
>> a) master
>>
>> Startup finished in 2min 12.695s (kernel) + 25.058s (initrd) + 1min 13.012s (userspace) = 3min 50.765s
>> multi-user.target reached after 1min 12.903s in userspace.
>> Startup finished in 1min 45.400s (kernel) + 24.294s (initrd) + 1min 8.910s (userspace) = 3min 18.606s
>> multi-user.target reached after 1min 8.786s in userspace.
>> Startup finished in 2min 4.857s (kernel) + 24.715s (initrd) + 1min 5.088s (userspace) = 3min 34.660s
>> multi-user.target reached after 1min 4.967s in userspace.
>> Startup finished in 3min 20.400s (kernel) + 24.703s (initrd) + 1min 5.469s (userspace) = 4min 50.573s
>> multi-user.target reached after 1min 5.344s in userspace.
>>
>> b) patched
>>
>> Startup finished in 2min 5.250s (kernel) + 25.049s (initrd) + 1min 1.961s (userspace) = 3min 32.262s
>> multi-user.target reached after 1min 1.844s in userspace.
>> Startup finished in 1min 52.524s (kernel) + 24.897s (initrd) + 1min 5.062s (userspace) = 3min 22.484s
>> multi-user.target reached after 1min 4.916s in userspace.
>> Startup finished in 9min 36.817s (kernel) + 24.859s (initrd) + 1min 18.657s (userspace) = 11min 20.335s
>> multi-user.target reached after 1min 18.455s in userspace.
>> Startup finished in 30min 20.715s (kernel) + 24.722s (initrd) + 1min 7.039s (userspace) = 31min 52.476s
>> multi-user.target reached after 1min 6.907s in userspace.
>>
>>
>> What concerns me a bit, is that on the patched kernel we seem to hit more cases where
>> boot takes much longer (in both kernel configs).
>>
>> I'll do some more runs/investigation to see if this is reproducible or just some system oddity.
>>
>> Staring just at the udev settle time (systemd-analyze blame), it's very similar between both kernel
>> versions.
> 
> Thanks for these tests, having MODULE_STATS enabled +
> 
> cat /sys/kernel/debug/modules/stats
> 
> would be of huge value, both on master and + patched.

Sure! Sorry for the slight delay, had to recompile the kernels.

I only did a single run on each kernel, should be good enough for the purpose here.


1) !debug config (not enabling KASAN)

a) master

# cat /sys/kernel/debug/modules/stats
          Mods ever loaded       75
      Mods failed on kread       0
Mods failed on decompress       0
   Mods failed on becoming       8052
       Mods failed on load       531
         Total module size       16343040
       Total mod text size       4767744
        Failed kread bytes       0
   Failed decompress bytes       0
     Failed becoming bytes       19185958488
         Failed kmod bytes       1172591936
  Virtual mem wasted bytes       20358550424
          Average mod size       217908
     Average mod text size       63570
   Avg fail becoming bytes       2382757
   Average fail load bytes       2208272
Duplicate failed modules:
               Module-name        How-many-times                    Reason
         intel_rapl_common                   447                  Becoming
    intel_uncore_frequency                   447                  Becoming
intel_uncore_frequency_common               445           Becoming & Load
          isst_if_mbox_msr                   447                  Becoming
            isst_if_common                   447           Becoming & Load
                  skx_edac                   447           Becoming & Load
                      nfit                   447                  Becoming
                 libnvdimm                   447                  Becoming
      x86_pkg_temp_thermal                   447                  Becoming
          intel_powerclamp                   447                  Becoming
                  coretemp                   447           Becoming & Load
                 kvm_intel                   447                  Becoming
                       kvm                   447           Becoming & Load
                     irdma                     3                      Load
                       ice                     3                  Becoming
                 irqbypass                   447           Becoming & Load
                      rapl                   393           Becoming & Load
                      gnss                     2           Becoming & Load
                   ioatdma                    63           Becoming & Load
                 ib_uverbs                     3           Becoming & Load
              intel_cstate                   447           Becoming & Load
                   ipmi_si                     1                      Load
              intel_uncore                   447           Becoming & Load
                   ib_core                     3           Becoming & Load
              ipmi_devintf                     1                      Load
           ipmi_msghandler                     1                  Becoming
                       dca                    63                  Becoming
                      ahci                     1                  Becoming
                      i40e                     3                  Becoming
                   libahci                     1                  Becoming
          crct10dif_pclmul                   195                  Becoming
              crc32_pclmul                   262                  Becoming
              crc32c_intel                   126           Becoming & Load
                    libata                     1                      Load
       ghash_clmulni_intel                   297           Becoming & Load
                      fjes                    11                  Becoming


b) patched

# cat /sys/kernel/debug/modules/stats
          Mods ever loaded       75
      Mods failed on kread       0
Mods failed on decompress       0
   Mods failed on becoming       0
       Mods failed on load       0
         Total module size       16343040
       Total mod text size       4767744
        Failed kread bytes       0
   Failed decompress bytes       0
     Failed becoming bytes       0
         Failed kmod bytes       0
  Virtual mem wasted bytes       0
          Average mod size       217908
     Average mod text size       63570



2) debug config (enabling KASAN)

a) master

# cat /sys/kernel/debug/modules/stats
          Mods ever loaded       75
      Mods failed on kread       0
Mods failed on decompress       0
   Mods failed on becoming       3173
       Mods failed on load       923
         Total module size       32288768
       Total mod text size       14819328
        Failed kread bytes       0
   Failed decompress bytes       0
     Failed becoming bytes       4279728952
         Failed kmod bytes       2174133088
  Virtual mem wasted bytes       6453862040
          Average mod size       430517
     Average mod text size       197592
   Avg fail becoming bytes       1348796
   Average fail load bytes       2355508
Duplicate failed modules:
               Module-name        How-many-times                    Reason
                   ioatdma                    63           Becoming & Load
         intel_rapl_common                   313                  Becoming
    intel_uncore_frequency                   136           Becoming & Load
intel_uncore_frequency_common                38                  Becoming
          isst_if_mbox_msr                   443           Becoming & Load
            isst_if_common                   210           Becoming & Load
                  skx_edac                   257           Becoming & Load
                      nfit                   180           Becoming & Load
                 libnvdimm                   294           Becoming & Load
      x86_pkg_temp_thermal                   321           Becoming & Load
          intel_powerclamp                   247           Becoming & Load
                  coretemp                    55           Becoming & Load
                 kvm_intel                     2                  Becoming
                       kvm                     3           Becoming & Load
                 irqbypass                     3                  Becoming
                      rapl                     1                  Becoming
              intel_cstate                   444                      Load
              intel_uncore                   447           Becoming & Load
                 ib_uverbs                     1                      Load
                   ib_core                     3           Becoming & Load
                   ipmi_si                     1                  Becoming
                       dca                    20           Becoming & Load
                        sg                     1                  Becoming
                      i40e                     3           Becoming & Load
                      ahci                     1                  Becoming
          crct10dif_pclmul                   160           Becoming & Load
              crc32_pclmul                   151           Becoming & Load
              crc32c_intel                   146           Becoming & Load
       ghash_clmulni_intel                   140                  Becoming
                    libata                     1                      Load
                      fjes                    11           Becoming & Load



b) patched

# cat /sys/kernel/debug/modules/stats
          Mods ever loaded       75
      Mods failed on kread       0
Mods failed on decompress       0
   Mods failed on becoming       19
       Mods failed on load       0
         Total module size       32288768
       Total mod text size       14819328
        Failed kread bytes       0
   Failed decompress bytes       0
     Failed becoming bytes       6441296
         Failed kmod bytes       0
  Virtual mem wasted bytes       6441296
          Average mod size       430517
     Average mod text size       197592
   Avg fail becoming bytes       339016
Duplicate failed modules:
               Module-name        How-many-times                    Reason
         intel_rapl_common                     2                  Becoming
intel_uncore_frequency_common                 5                  Becoming
            isst_if_common                     3                  Becoming
          intel_powerclamp                     2                  Becoming
                 irqbypass                     5                  Becoming
          crct10dif_pclmul                     1                  Becoming
              crc32c_intel                     1                  Becoming



So, with these (helpful) stats, the improvement is obvious (and explains the ~1s
improvement I saw staring at the startup times of the udev services).

There are still some failed module loads with the debug config (only in the
becoming state), I did not dive deeply into the actual code changes (-EBUSY),
just spelling it out so we can decide if this is to be expected or some corner
case that shouldn't be happening.


Thanks!

-- 
Cheers,

David / dhildenb

