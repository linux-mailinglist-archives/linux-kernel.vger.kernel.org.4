Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF1363864B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKYJ3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiKYJ3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:29:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B243823EA2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669368500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=onEr/5J0flqsYvcgarvEHk+r7IyB64r8DXyLrUW/Ar0=;
        b=O4QUa24RCM8OvUqH+HNxYaQSvTrHAnwZ1by4riPRW2vTT7RisNk4qvTkV4nMvPkT2BgmDK
        BfSfCsey37nKhMfacpA01DyfQE5NBUjFEfjI4Qf8eZe0W02Pcm8xgh6mis1wh1cwAPnW3a
        0NUdqqgPnd9XB1p0lxEjgGbJDYpKLpo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-3Zp_s12fPGS81qLTcu-uLw-1; Fri, 25 Nov 2022 04:28:18 -0500
X-MC-Unique: 3Zp_s12fPGS81qLTcu-uLw-1
Received: by mail-wr1-f69.google.com with SMTP id l9-20020adfa389000000b00241f907e102so717243wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:28:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=onEr/5J0flqsYvcgarvEHk+r7IyB64r8DXyLrUW/Ar0=;
        b=tXsaGdvjMOEVzPyD2jFXBIhROxcpZKeE5OXsiIyYsPhlZ5uIVPIfDUXmld0xwJT77I
         oF6eiy2ARhwtrOVgm+AFRX31WS19iMcpWozFEshlMk5QUHvvsk2uL6lBYIYVDBBaGfRC
         3cO27PJ/f2hLOIrreFDsFj4GCAxMz7Rdb7T6Pz1NBxfIa49f++T0/6GAcZHm61meBydX
         YYRUhTLC4LzpkNuLhaatXeRKeeIPgncRt8K8Z2boP/DItxMV0d+azv9us982LcLlJRpL
         A8e8pFfpsVVtoLU+RwYxQf+U8DYcVCCbGWHqfZC/Z2Xa/BYOAbNEUbB+4sNe1ho6We+N
         ED1w==
X-Gm-Message-State: ANoB5pljQKWIrINg7qWRSRwnvVduFsw6y7pqaSuBp8oAAAQGU6nyVGYK
        V7LKNmKoNWnvSusTyHmL6OJI3edjKA80FciinQv7lKu7CyUbYalbPBJfq9GH3pIWaFmzjYcF6DV
        leQeVstIK/FzawI/WQgDzJhu5
X-Received: by 2002:adf:f3d0:0:b0:241:f721:3ba2 with SMTP id g16-20020adff3d0000000b00241f7213ba2mr5788518wrp.681.1669368497460;
        Fri, 25 Nov 2022 01:28:17 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6iXy13FMYkhy+fD3Q7XTLxdC2exbVu/sGMn5iymyk0EKRg1862HBW99ZvN/TTdGcZxZaAxKw==
X-Received: by 2002:adf:f3d0:0:b0:241:f721:3ba2 with SMTP id g16-20020adff3d0000000b00241f7213ba2mr5788489wrp.681.1669368497034;
        Fri, 25 Nov 2022 01:28:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:d800:887:cbec:f31f:a08? (p200300cbc704d8000887cbecf31f0a08.dip0.t-ipconnect.de. [2003:cb:c704:d800:887:cbec:f31f:a08])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b003c6c182bef9sm11363749wmq.36.2022.11.25.01.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 01:28:16 -0800 (PST)
Message-ID: <361875cb-e4b3-a46f-b275-6d87a98ce966@redhat.com>
Date:   Fri, 25 Nov 2022 10:28:15 +0100
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
        "Shahar, Sagi" <sagis@google.com>,
        "imammedo@redhat.com" <imammedo@redhat.com>,
        "Gao, Chao" <chao.gao@intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>
References: <cover.1668988357.git.kai.huang@intel.com>
 <9b545148275b14a8c7edef1157f8ec44dc8116ee.1668988357.git.kai.huang@intel.com>
 <637ecded7b0f9_160eb329418@dwillia2-xfh.jf.intel.com.notmuch>
 <8e8f72ad5d7a3d09be32bee54e4ebb9c280610a2.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <8e8f72ad5d7a3d09be32bee54e4ebb9c280610a2.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.11.22 10:06, Huang, Kai wrote:
> On Wed, 2022-11-23 at 17:50 -0800, Dan Williams wrote:
>>>    
>>> @@ -968,6 +969,15 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>>    	unsigned long start_pfn = start >> PAGE_SHIFT;
>>>    	unsigned long nr_pages = size >> PAGE_SHIFT;
>>>    
>>> +	/*
>>> +	 * For now if TDX is enabled, all pages in the page allocator
>>> +	 * must be TDX memory, which is a fixed set of memory regions
>>> +	 * that are passed to the TDX module.  Reject the new region
>>> +	 * if it is not TDX memory to guarantee above is true.
>>> +	 */
>>> +	if (!tdx_cc_memory_compatible(start_pfn, start_pfn + nr_pages))
>>> +		return -EINVAL;
>>
>> arch_add_memory() does not add memory to the page allocator.  For
>> example, memremap_pages() uses arch_add_memory() and explicitly does not
>> release the memory to the page allocator.
> 
> Indeed.  Sorry I missed this.
> 
>> This check belongs in
>> add_memory_resource() to prevent new memory that violates TDX from being
>> onlined.
> 
> This would require adding another 'arch_cc_memory_compatible()' to the common
> add_memory_resource() (I actually long time ago had such patch to work with the
> memremap_pages() you mentioned above).
> 
> How about adding a memory_notifier to the TDX code, and reject online of TDX
> incompatible memory (something like below)?  The benefit is this is TDX code
> self contained and won't pollute the common mm code:
> 
> +static int tdx_memory_notifier(struct notifier_block *nb,
> +                              unsigned long action, void *v)
> +{
> +       struct memory_notify *mn = v;
> +
> +       if (action != MEM_GOING_ONLINE)
> +               return NOTIFY_OK;
> +
> +       /*
> +        * Not all memory is compatible with TDX.  Reject
> +        * online of any incompatible memory.
> +        */
> +       return tdx_cc_memory_compatible(mn->start_pfn,
> +                       mn->start_pfn + mn->nr_pages) ? NOTIFY_OK : NOTIFY_BAD;
> +}
> +
> +static struct notifier_block tdx_memory_nb = {
> +       .notifier_call = tdx_memory_notifier,
> +};

With mhp_memmap_on_memory() some memory might already be touched during 
add_memory() (because part of the hotplug memory is used for holding the 
memmap), not when actually onlining memory. So in that case, this would 
be too late.

add_memory_resource() sounds better, even though I disgust such TDX 
special handling in common code.

-- 
Thanks,

David / dhildenb

