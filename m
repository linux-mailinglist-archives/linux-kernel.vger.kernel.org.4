Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CD265ED17
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjAENa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjAENaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:30:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5F7E09D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672925358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O6R7HSCOxRXuYv+zoqZxPQeYz/IwjoGgHnYsJS6+SSo=;
        b=SlE79pTchv8VgWk9pSWc2229E4AMkFlr3q2mkICSp+MHodbPUFvY3jk/xiKAd2Pg469gp2
        uzlB4NHx79+wFKEuHgN2U6yLZ5U60S8tKV0oRq7L5ox0aqkzeQbE6eJH1hw6yamlA4RCKI
        l2YbEZlJlZYAXJtnG9XFsVbyhnalHHw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-61-T84EB8gyO72x0KrcdPsmxQ-1; Thu, 05 Jan 2023 08:29:17 -0500
X-MC-Unique: T84EB8gyO72x0KrcdPsmxQ-1
Received: by mail-wm1-f69.google.com with SMTP id l17-20020a05600c1d1100b003d9a145366cso9545953wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:29:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6R7HSCOxRXuYv+zoqZxPQeYz/IwjoGgHnYsJS6+SSo=;
        b=ByOO5qVU+G5FZPq8OtY1d5CldUxHK0LC0dpNr3mfu+FU++gYqkUxG3pzE9GvYkm9ge
         O+T+P0+LuHK6fwyTOABIIAv03l1h7b3ikptDsw+2V4hGziF0EEc4Yv0xF9lC1mShpXhR
         BRq98/E7Y2h3XSinI2NlIDiMPeAbjeiEimInQ7QRnBmTjjumdK4/4HS8f1JvC+0pPUiE
         MmoxeAoLmNH5APYCAIYBDgb3pEe5uz++d24DkJ6KNIs83VFntWDpHyO0AkJsKO8muyxi
         dQkUIzEvHX8OBf+4DMUyZ+OF7xI6eM6n8yvGuwDbxUg9ZYijuO9R4CNEKJ6RGHw0eiXy
         ZBgQ==
X-Gm-Message-State: AFqh2koYlFrvTc0/Jrv9NahfUwKqmVilIPsbf4Yy3/oITARETvAzP/kA
        Ukt9SvnyBA0jD959MrAJeWsF8yiDDsbl4/BUD3CTbRnpr5g9ZN+CBYrVMP+5ZT+AuVzMixNbp83
        V+nXqto1kEMtv+4Waeo5sdUNJ
X-Received: by 2002:a1c:6a16:0:b0:3c6:f732:bf6f with SMTP id f22-20020a1c6a16000000b003c6f732bf6fmr35815232wmc.13.1672925356185;
        Thu, 05 Jan 2023 05:29:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsIb4mlwr8N+FqFf4QYtSkskqWJZSxuZsms0l9suPP1E3kmInAUswjm9Kp2ieEsBXtnPXnr7Q==
X-Received: by 2002:a1c:6a16:0:b0:3c6:f732:bf6f with SMTP id f22-20020a1c6a16000000b003c6f732bf6fmr35815203wmc.13.1672925355881;
        Thu, 05 Jan 2023 05:29:15 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e? (p200300cbc7076e00ff02ec7aded5ec1e.dip0.t-ipconnect.de. [2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e])
        by smtp.gmail.com with ESMTPSA id bi10-20020a05600c3d8a00b003d9bd56e9c1sm2393180wmb.11.2023.01.05.05.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 05:29:15 -0800 (PST)
Message-ID: <cbf408b3-82e8-79fe-0998-f4aed7117c95@redhat.com>
Date:   Thu, 5 Jan 2023 14:29:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
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
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20221020215318.4193269-1-opendmb@gmail.com>
 <bff78f19-fd40-d9be-6592-93a7a4a91587@gmail.com>
 <0c4e35de-f790-5399-c812-ff90a4ab7531@redhat.com>
 <c9f1b9f7-06d1-1425-62c1-caaaab1e230e@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 0/9] mm: introduce Designated Movable Blocks
In-Reply-To: <c9f1b9f7-06d1-1425-62c1-caaaab1e230e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.01.23 20:00, Florian Fainelli wrote:
> On 1/4/23 07:56, David Hildenbrand wrote:
>> On 04.01.23 00:43, Florian Fainelli wrote:
>>> On 10/20/22 14:53, Doug Berger wrote:
>>>> MOTIVATION:
>>>> Some Broadcom devices (e.g. 7445, 7278) contain multiple memory
>>>> controllers with each mapped in a different address range within
>>>> a Uniform Memory Architecture. Some users of these systems have
>>>> expressed the desire to locate ZONE_MOVABLE memory on each
>>>> memory controller to allow user space intensive processing to
>>>> make better use of the additional memory bandwidth.
>>>> Unfortunately, the historical monotonic layout of zones would
>>>> mean that if the lowest addressed memory controller contains
>>>> ZONE_MOVABLE memory then all of the memory available from
>>>> memory controllers at higher addresses must also be in the
>>>> ZONE_MOVABLE zone. This would force all kernel memory accesses
>>>> onto the lowest addressed memory controller and significantly
>>>> reduce the amount of memory available for non-movable
>>>> allocations.
>>>>
>>>> The main objective of this patch set is therefore to allow a
>>>> block of memory to be designated as part of the ZONE_MOVABLE
>>>> zone where it will always only be used by the kernel page
>>>> allocator to satisfy requests for movable pages. The term
>>>> Designated Movable Block is introduced here to represent such a
>>>> block. The favored implementation allows extension of the
>>>> 'movablecore' kernel parameter to allow specification of a base
>>>> address and support for multiple blocks. The existing
>>>> 'movablecore' mechanisms are retained.
>>>>
>>>> BACKGROUND:
>>>> NUMA architectures support distributing movablecore memory
>>>> across each node, but it is undesirable to introduce the
>>>> overhead and complexities of NUMA on systems that don't have a
>>>> Non-Uniform Memory Architecture.
>>>>
>>>> Commit 342332e6a925 ("mm/page_alloc.c: introduce kernelcore=mirror
>>>> option")
>>>> also depends on zone overlap to support sytems with multiple
>>>> mirrored ranges.
>>>>
>>>> Commit c6f03e2903c9 ("mm, memory_hotplug: remove zone restrictions")
>>>> embraced overlapped zones for memory hotplug.
>>>>
>>>> This commit set follows their lead to allow the ZONE_MOVABLE
>>>> zone to overlap other zones. Designated Movable Blocks are made
>>>> absent from overlapping zones and present within the
>>>> ZONE_MOVABLE zone.
>>>>
>>>> I initially investigated an implementation using a Designated
>>>> Movable migrate type in line with comments[1] made by Mel Gorman
>>>> regarding a "sticky" MIGRATE_MOVABLE type to avoid using
>>>> ZONE_MOVABLE. However, this approach was riskier since it was
>>>> much more instrusive on the allocation paths. Ultimately, the
>>>> progress made by the memory hotplug folks to expand the
>>>> ZONE_MOVABLE functionality convinced me to follow this approach.
>>>>
>>>
>>> Mel, David, does the sub-thread discussion with Doug help ensuring that
>>> all of the context is gathered before getting into a more detailed patch
>>> review on a patch-by-patch basis?
>>>
>>> Eventually we may need a fairly firm answer as to whether the proposed
>>> approach has any chance of landing upstream in order to either commit to
>>> in subsequent iterations of this patch set, or find an alternative.
>>
>>
>> As raised, I'd appreciate if less intrusive alternatives could be
>> evaluated (e.g., fake NUMA nodes and being ablee to just use mbind(),
>> moving such memory to ZONE_MOVABLE after boot via something like daxctl).
> 
> This is not an option with the environment we have to ultimately fit in
> which is Android TV utilizing the GKI kernel which does not enable NUMA
> and probably never will, and for similar reasons bringing a whole swath
> of user-space tools like daxctl may not be practical either, from both a
> logistical perspective (simply getting the tools built with bionic,
> accepted etc.) as well as system configuration perspective.

Adding feature A because people don't want to (! whoever the "people" 
are) enable feature B? I hope I don't have to tell you what I think 
about statements like this :)

If feature B is a problem, try stripping it down such that it can be 
enabled. If it's to hard to configure for your use case, maybe we can 
extend configuration options to avoid tools like daxctl for some special 
cases.

But of course, only if feature B actually solves the problem.

One issue I have with DMB is actual use cases / users / requirements. 
Maybe requirements are defined somewhere cleanly and I missed them.

If we have clear requirements, we can talk about possible solutions. If 
we have a specific solution, it's harder to talk about requirements.

>  >>
>> I'm not convinced that these intrusive changes are worth it at this
>> point. Further, some of the assumptions (ZONE_MOVABLE == user space) are
>> not really future proof as I raised.
> 
> I find this patch set reasonably small in contrast to a lot of other mm/
> changes, what did you find intrusive specifically?
> 
> AFAICT, there only assumption that is being made is that ZONE_MOVABLE
> contains memory that can be moved, but even if it did not in the future,
> there should hopefully be enough opportunities, given a large enough DMB
> region to service the allocation requests of its users. I will go back
> and read your comment to make sure I don't misunderstand it.

Let me clarify what ZONE_MOVABLE can and cannot do:

* We cannot assume that specific user space allocations are served from
   it, neither can we really modify behavior.
* We cannot assume that user space allocations won't be migrated off
   that zone to another zone.
* We cannot assume that no other (kernel) allocations will end up on it.
* We cannot make specific processes preferably consume memory from it.

Designing a feature that relies on any of these assumptions is IMHO wrong.

If you want an application to consume memory from a specific address 
range, there are some possible ways I can see:

(1) Model the special memory areas using fake NUMA nodes. e.g., mbind()
     the applications to these nodes. Use ZONE_MOVABLE to make sure we
     don't get unmovable allocations. The buddy will take care of it.
(2) Use some driver that manages that memory and provides that memory
     to an application by mmap()'ing it. The buddy won't manage it (no
     swap, migration ...). DEVDAX is one possible such driver.
(3) Use hugetlb and reserve them from the selected memory ranges.
     Make the application consume these hugetlb pages.

For a single node, without a special driver, it gets more complicated: 
We'd need new way to tell the buddy that these memory ranges are 
"special". I don't want to use the word "new zone" but that's most 
likely what it would have to be. Further, one would need a way to 
specify that only specific allocations should end up on these ranges.

Maybe I'm overthinking this. Having clear requirements such that we can 
try discussing solutions and exploring alternatives would be great.

-- 
Thanks,

David / dhildenb

