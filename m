Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4697760DF4E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbiJZLLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiJZLLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:11:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F359915CC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666782705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8DuMJUWUkJCTr3gZi1XbnDhQu/giShmRMKViyo2Tw/c=;
        b=ArSBf9CAdp8k6+oWv5UkKuhHfc8bLX/sw7cMYO6zCrAhgEqsOaa19RjH0623HiCmBgrWVQ
        JOXdCFNX48es9jzrHlmK91b/bVePW1CUe1y40Vz7h/bskSVCJnLSl4kdTb56JoIbvGQec+
        d/1gAMUrn9MYDh01s+IPixOJWHvDHVM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-392-ZQCB9VHBOB6nnLqXrJN25A-1; Wed, 26 Oct 2022 07:11:44 -0400
X-MC-Unique: ZQCB9VHBOB6nnLqXrJN25A-1
Received: by mail-wm1-f69.google.com with SMTP id v125-20020a1cac83000000b003bd44dc5242so913704wme.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DuMJUWUkJCTr3gZi1XbnDhQu/giShmRMKViyo2Tw/c=;
        b=hJ/TwSWEhDMYZ84eBmm5U0v+jtz1te/u1VbJjBciVQghwc39oa+inU/QNyKJHHOLqf
         EoZqnaeomYo6TKzYoJqJYV32lgJE6IOyyy54jEaiBF8z43Mxz34wUpP2fWmyv0NkTojL
         FOKLhRISE1HJHmiZpwiZkOO9JrD1OaUPsEkbHXJJKPXGDstsQG+RjlvcdwEhga+oaUTQ
         QXAMeEr8m900fOHEPLdIxQcvcSMRn3NM3JTfP+uJBu9f7EaLfM1fpGUC7vdYn5YwCNo/
         SAp8v40imibi01ozbziC8D1GMSoHIsAcBQrplckTW06wQyyAE8fv3LpYaOPi9wqaGUUh
         dVnQ==
X-Gm-Message-State: ACrzQf379omq2WMju73Mx/VHaKjaQUnpUrcApbW8DXdUJtt4uAZ8JfTt
        D9zHVN0zCukZnWO6x3uD1p9qYXHc4QhrRfFNTYjf/ZGb3tYCnaezNZl6sjIHnYWN7iH3zRXQQ3G
        4dt1MuWGJjqneFU3G6rB0D0J1
X-Received: by 2002:a05:600c:384d:b0:3c6:f5ad:1e0 with SMTP id s13-20020a05600c384d00b003c6f5ad01e0mr2041149wmr.127.1666782702922;
        Wed, 26 Oct 2022 04:11:42 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7tjbdLdnf8ASBtkjPbGQ+HkcSXhzbJ5kVeO1ol6xkrYe1APAI2V56D3NT5kQ3OgEtb/3q3ow==
X-Received: by 2002:a05:600c:384d:b0:3c6:f5ad:1e0 with SMTP id s13-20020a05600c384d00b003c6f5ad01e0mr2041113wmr.127.1666782702518;
        Wed, 26 Oct 2022 04:11:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:5b00:c9f4:7535:9360:70d7? (p200300cbc7065b00c9f47535936070d7.dip0.t-ipconnect.de. [2003:cb:c706:5b00:c9f4:7535:9360:70d7])
        by smtp.gmail.com with ESMTPSA id m1-20020a5d6241000000b00228cd9f6349sm4762676wrv.106.2022.10.26.04.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 04:11:41 -0700 (PDT)
Message-ID: <b8a4cd98-8236-d6e4-ee36-550ae1c107ff@redhat.com>
Date:   Wed, 26 Oct 2022 13:11:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>, Doug Berger <opendmb@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>, Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20221020215318.4193269-1-opendmb@gmail.com>
 <20221026105500.n6ddzqqf5ozjswsp@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 0/9] mm: introduce Designated Movable Blocks
In-Reply-To: <20221026105500.n6ddzqqf5ozjswsp@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.22 12:55, Mel Gorman wrote:
> On Thu, Oct 20, 2022 at 02:53:09PM -0700, Doug Berger wrote:
>> MOTIVATION:
>> Some Broadcom devices (e.g. 7445, 7278) contain multiple memory
>> controllers with each mapped in a different address range within
>> a Uniform Memory Architecture. Some users of these systems have
>> expressed the desire to locate ZONE_MOVABLE memory on each
>> memory controller to allow user space intensive processing to
>> make better use of the additional memory bandwidth.
>> Unfortunately, the historical monotonic layout of zones would
>> mean that if the lowest addressed memory controller contains
>> ZONE_MOVABLE memory then all of the memory available from
>> memory controllers at higher addresses must also be in the
>> ZONE_MOVABLE zone. This would force all kernel memory accesses
>> onto the lowest addressed memory controller and significantly
>> reduce the amount of memory available for non-movable
>> allocations.
>>
> 
> I didn't review the first version of this patch because others, particularly
> David Hildenbrand highlighted many of the concerns I had. I broadly followed
> the discussion but didn't respond because I live in a permanent state of
> having too much to do but with a new version, I have to say something.

:) Just a note that I am still behind on replying to the discussion in 
v2. I wish I had more capacity right now to be more responsive -- but 
just like you (Mel) "permanent state of having too much to do". Other 
things (especially bug fixes) have higher priority.

Thanks for having a look at it Mel --- I only skimmed over your reply, 
but ...

> 
> The three big questions he initially asked were
> 
> 	How large are these areas typically?
> 	How large are they in comparison to other memory in the system?
> 	How is this memory currently presented to the system?
> 	Can you share some more how exactly ZONE_MOVABLE would help here to make
> 		better use of the memory bandwidth?
> 
> Zones are about addressing limitations primarily and frankly, ZONE_MOVABLE
> was a bad idea in retrospect. Today, the preferred approach would have
> been to create a separate NUMA node with distance-1 to the local node
> (fudge by adding 1 to the local distance "10" for zonelist purposes)
> that was ZONE_MOVABLE with the zonelists structured such that GFP_MOVABLE
> allocations would prefer the "movable" node first. While I don't recall
> why I did not take that approach, it most likely was because CONFIG_NUMA
> was not always set, it was only intended for hugetlbfs allocations and
> maybe I didn't have the necessary skill or foresight to take that approach.
> 
> Hotplugs requirements are somewhat different, the primary motivation that
> I'm aware of is being able to guarantee they can be offlined, particularly
> nodes, which can be done in some circumstances. Generally hotplug does
> not care what uses the memory as long as it can be removed later. The
> requirements for restricted access to high speed memory is different.
> 
> There is a high degree of uncertainity of how these regions are to be
> used by applications to get access to the high speed memory, to quote
> 
> 	I'm not certain what is typical because these systems are highly
> 	configurable and Broadcom's customers have different ideas about
> 	application processing.
> 
> 	...
> 
> 	The Designated Movable Block concept introduced here has the
> 	potential to offer useful services to different constituencies. I
> 	tried to highlight this in my V1 patch set with the hope of
> 	attracting some interest, but it can complicate the overall
> 	discussion, so I would like to maybe narrow the discussion here. It
> 	may be good to keep them in mind when assessing the overall value,
> 	but perhaps the "other opportunities" can be covered as a follow
> 	on discussion.
> 
> I note the "potential" part here because we don't actually know. A
> major limitation of ZONE_MOVABLE is that there is no way of controlling
> access from userspace to restrict the high-speed memory to a designated
> application, only to all applications in general. The primary interface
> to control access to memory with different characteristics is mempolicies
> which is NUMA orientated, not zone orientated. So, if there is a special
> application that requires exclusive access, it's very difficult to configure
> based on zones.  Furthermore, page table pages mapping data located in the
> high-speed region are stored in the slower memory which potentially impacts
> the performance if the working set of the application exceeds TLB reach.
> Finally, while there is mention that Broadcom may have some special
> interface to determine what applications can use the high-speed region,
> it's hardware-specific as opposed to something that belongs in the core mm.
> 
> I agree that keeping the high-speed memory in a local node and using "sticky"
> pageblocks or CMA has limitations of its own but in itself, that does not
> justify using ZONE_MOVABLE in my opinion. The statement that ARM can have
> multiple controllers with equal distance and bandwidth (if I'm reading it
> correctly) but places them in different zones.... that's just a bit weird if
> there are no other addressing limitations. It's not obvious why ARM would do
> that, but it also does not matter because it shouldn't be a core mm concern.
> 
> There are already examples of where memory is physically "local" to
> the CPU but has different bandwidth or latency including High Bandwidth
> (HBM), Sub-NUMA Clustering (SNC), PMEM as a memory-life device and some
> AMD EPYC Chips, particularly the first generation where a sockets memory
> controllers had different distances. With the broadcom controllers,
> it sounds like a local memory controller but the bandwidth available
> differs. It's functionally equivalent to HBM.
> 
> The fact that the memory access is physically local to the CPU socket is
> irrelevant when the characteristics of that locality differs. NUMA stands
> for Non-Uniform Memory Access and if bandwidth to different address ranges
> differs, then the system is inherently NUMA even if that is inconvenient.
> 
> While I have not evaluated the implementation in detail, there is already
> infrastructure dealing with tiered memory (memory that is local but has
> different characteristics) with support for moving memory between tiers
> depending on access patterns. Memory policies can be used to restrict
> access to what processes can access the higher bandwidth memory. Given the
> use case for DSM, I suspect that the intent is "application data uses high
> bandwidth memory where possible and kernel uses lower bandwidth memory"
> which is probably fine for an appliance because there is only one workload
> but it's not a generic solution suitable.
> 
> Going back to the original questions;
> 
> 	How large are these areas typically?
> 	How large are they in comparison to other memory in the system?
> 
> I am treating this as the same question because the consequencs are the
> same. A high ratio of !MOVABLE:MOVABLE can cause big problems including
> premature OOM, surprising reclaim behaviour etc
> 
> 	How is this memory currently presented to the system?
> 
> It's local, but with different characteristics so it's inherently NUMA
> because it's Non-Uniform, there is no getting away from that.
> 
> 	Can you share some more how exactly ZONE_MOVABLE would help here to make
> 		better use of the memory bandwidth?
> 
> In the appliance case, it doesn't matter if the intent is that "all
> application data should use high bandwidth memory where possible and
> the application phase behaviour is predictable" and that may very well
> work fine for the users of the Broadcom platforms with multiple memory
> controllers. It does not work at all for the general where access must
> be restricted to a subset of tasks in a general system that can only be
> controlled with memory policies.
> 
> The high bandwidth memory should be representated as a NUMA node, optionally
> to create that node as ZONE_MOVABLE and relying on the zonelists to select
> the movable zone as the first preference.

... that boils down to my remark to tiered memory and eventually using 
devdax to expose this memory to the system and letting the admin decide 
to online it to ZONE_MOVABLE. Of course, that's just one way of doing it.

-- 
Thanks,

David / dhildenb

