Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA0663A4F3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiK1J1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiK1J1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:27:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79276C4D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669627607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=klYlT0QKH+4SL9No1+i0WufA2DveKgjOeQpHH/zXAQc=;
        b=iJR/3PPSappr7JhkqTuZVIWwHwm3Wv3wooLRNLs44UmPzcXhRUzIfOc/9c0R8ppS+qRPIB
        xCtPngpTt5pxvF/OmOB2Ev3X/jXykw7qeGFgbMMzhICdqD+1EiBtHuoEGcDsH3kmm1P8BB
        llc6JKEBoVAK95kfwMLq7+5K9XEJurw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-589-BKP1vzD2M3eoR2VFDV5KVQ-1; Mon, 28 Nov 2022 04:26:41 -0500
X-MC-Unique: BKP1vzD2M3eoR2VFDV5KVQ-1
Received: by mail-wr1-f72.google.com with SMTP id s1-20020adfa281000000b00241f7467851so1681721wra.17
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:26:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=klYlT0QKH+4SL9No1+i0WufA2DveKgjOeQpHH/zXAQc=;
        b=wfGbemA9ojyBiPKiMXDV179NG74sKMde2hyAgpQ/RuKLKxCnh6fsQO00d57Pv4ER+1
         kahKYhFJQgPP4EGc+oLQJGlBRDnr3tQJKf0ECahvFIRkc3YvtXPPdWEi1B9shL5vK4a7
         e8BodQ6R+5fix9rE5oWbkf9ccHsbWqpXVCI10ziTwAYfb9B+hLgXwAbl5FMk3SAVEUeZ
         l0Aq8fnjBOJGw/5fwkdR5iD2h0w1WwuMz1FJ7WhyFQDDN/f0jNnai6hn0UAMloVNv2XX
         s4ZFLkWlCFLFbBgCeAZp+QX9Gn996ojOpZNIHYIzXS25lZd5+0puDOcp3AyQQc9aiL3d
         8png==
X-Gm-Message-State: ANoB5pl3U47abNthQPd4d5+3tDcZLyBsdPvMGitJIPJ1Rc2gfRjcQ6rN
        IhcM7VBnV8nJOAaywM1SOxEkdSRrDf7zPaoDpvJ6Rx2J/YiAW3Q7/eul2Yg9DwpMNQq+LwGrRDD
        ET4hin5ArYmd3Dw4C4waxeywh
X-Received: by 2002:a05:600c:3421:b0:3cf:ac8a:d43e with SMTP id y33-20020a05600c342100b003cfac8ad43emr25478666wmp.65.1669627600131;
        Mon, 28 Nov 2022 01:26:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5YnAsVdDSPhUTuDTe1E4NOjJSUbaLCxukiYCM/P5NI3OP5blqbagembcddhMNSo3dpxegf3Q==
X-Received: by 2002:a05:600c:3421:b0:3cf:ac8a:d43e with SMTP id y33-20020a05600c342100b003cfac8ad43emr25478652wmp.65.1669627599841;
        Mon, 28 Nov 2022 01:26:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:9000:3d6:e434:f8b4:80cf? (p200300cbc702900003d6e434f8b480cf.dip0.t-ipconnect.de. [2003:cb:c702:9000:3d6:e434:f8b4:80cf])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4cba4ef71sm18157087wmi.41.2022.11.28.01.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 01:26:38 -0800 (PST)
Message-ID: <ace4f538-77e4-964e-5c71-ff09f208689b@redhat.com>
Date:   Mon, 28 Nov 2022 10:26:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v7 10/20] x86/virt/tdx: Use all system memory when
 initializing TDX module as TDX memory
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "imammedo@redhat.com" <imammedo@redhat.com>,
        "Gao, Chao" <chao.gao@intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        "Shahar, Sagi" <sagis@google.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>
References: <cover.1668988357.git.kai.huang@intel.com>
 <9b545148275b14a8c7edef1157f8ec44dc8116ee.1668988357.git.kai.huang@intel.com>
 <637ecded7b0f9_160eb329418@dwillia2-xfh.jf.intel.com.notmuch>
 <8e8f72ad5d7a3d09be32bee54e4ebb9c280610a2.camel@intel.com>
 <361875cb-e4b3-a46f-b275-6d87a98ce966@redhat.com>
 <397ebe70bf9cede731f2f8bbd05e0df518fd3a22.camel@intel.com>
 <49ab9f26-9e23-25ab-71b4-e666c70ff77e@redhat.com>
 <8300f1098aa8fbfae711313be41ee44cb1203d62.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <8300f1098aa8fbfae711313be41ee44cb1203d62.camel@intel.com>
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

On 28.11.22 10:21, Huang, Kai wrote:
> On Mon, 2022-11-28 at 09:43 +0100, David Hildenbrand wrote:
>> On 28.11.22 09:38, Huang, Kai wrote:
>>> On Fri, 2022-11-25 at 10:28 +0100, David Hildenbrand wrote:
>>>> On 24.11.22 10:06, Huang, Kai wrote:
>>>>> On Wed, 2022-11-23 at 17:50 -0800, Dan Williams wrote:
>>>>>>>      
>>>>>>> @@ -968,6 +969,15 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>>>>>>      	unsigned long start_pfn = start >> PAGE_SHIFT;
>>>>>>>      	unsigned long nr_pages = size >> PAGE_SHIFT;
>>>>>>>      
>>>>>>> +	/*
>>>>>>> +	 * For now if TDX is enabled, all pages in the page allocator
>>>>>>> +	 * must be TDX memory, which is a fixed set of memory regions
>>>>>>> +	 * that are passed to the TDX module.  Reject the new region
>>>>>>> +	 * if it is not TDX memory to guarantee above is true.
>>>>>>> +	 */
>>>>>>> +	if (!tdx_cc_memory_compatible(start_pfn, start_pfn + nr_pages))
>>>>>>> +		return -EINVAL;
>>>>>>
>>>>>> arch_add_memory() does not add memory to the page allocator.  For
>>>>>> example, memremap_pages() uses arch_add_memory() and explicitly does not
>>>>>> release the memory to the page allocator.
>>>>>
>>>>> Indeed.  Sorry I missed this.
>>>>>
>>>>>> This check belongs in
>>>>>> add_memory_resource() to prevent new memory that violates TDX from being
>>>>>> onlined.
>>>>>
>>>>> This would require adding another 'arch_cc_memory_compatible()' to the common
>>>>> add_memory_resource() (I actually long time ago had such patch to work with the
>>>>> memremap_pages() you mentioned above).
>>>>>
>>>>> How about adding a memory_notifier to the TDX code, and reject online of TDX
>>>>> incompatible memory (something like below)?  The benefit is this is TDX code
>>>>> self contained and won't pollute the common mm code:
>>>>>
>>>>> +static int tdx_memory_notifier(struct notifier_block *nb,
>>>>> +                              unsigned long action, void *v)
>>>>> +{
>>>>> +       struct memory_notify *mn = v;
>>>>> +
>>>>> +       if (action != MEM_GOING_ONLINE)
>>>>> +               return NOTIFY_OK;
>>>>> +
>>>>> +       /*
>>>>> +        * Not all memory is compatible with TDX.  Reject
>>>>> +        * online of any incompatible memory.
>>>>> +        */
>>>>> +       return tdx_cc_memory_compatible(mn->start_pfn,
>>>>> +                       mn->start_pfn + mn->nr_pages) ? NOTIFY_OK : NOTIFY_BAD;
>>>>> +}
>>>>> +
>>>>> +static struct notifier_block tdx_memory_nb = {
>>>>> +       .notifier_call = tdx_memory_notifier,
>>>>> +};
>>>>
>>>> With mhp_memmap_on_memory() some memory might already be touched during
>>>> add_memory() (because part of the hotplug memory is used for holding the
>>>> memmap), not when actually onlining memory. So in that case, this would
>>>> be too late.
>>>
>>> Hi David,
>>>
>>> Thanks for the review!
>>>
>>> Right. The memmap pages are added to the zone before online_pages(), but IIUC
>>> those memmap pages will never be free pages thus won't be allocated by the page
>>> allocator, correct?  Therefore in practice there won't be problem even they are
>>> not TDX compatible memory.
>>
>> But that memory will be read/written. Isn't that an issue, for example,
>> if memory doesn't get accepted etc?
>>
> 
> Sorry I don't quite understand "if memory doesn't get accepted" mean.  Do you
> mean accepted by the TDX module?
> 
> Only the host kernel will read/write those memmap pages.  The TDX module won't
> (as they won't be allocated to be used as TDX guest memory or TDX module
> metadata).  So it's fine.

Oh, so we're not also considering hotplugging memory to a TDX VM that 
might not be backed by TDX. Got it.

So what you want to prevent is getting !TDX memory exposed to the buddy 
such that it won't accidentally get allocated for a TDX guest, correct?

In that case, memory notifiers would indeed be fine.

Thanks!

-- 
Thanks,

David / dhildenb

