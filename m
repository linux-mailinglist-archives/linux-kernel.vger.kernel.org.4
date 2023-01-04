Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB9D65D7A9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbjADP52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239277AbjADP50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:57:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91712AE9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 07:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672847803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JHICDqOYgukumk9LLwV3EBYxIew7z8FbH0jMEwELhJU=;
        b=K6gSSx8NYBjYZIDsxGHtl8cwV8teKLO5FPMC1Srcm3tECOCC92DiLytevTs4B12G1QAqSr
        xYgFTn+6Whz6X7ImG7n1YIhME1y0Jiybbl/Y5ZDqGyYbwOJidt9/yG1/mOl7DYZ6dDx3h8
        DSgtCt1DZt+PVEGky6sJ++io9U45q9s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-675-PatMQ56pPSWba6xKx7_W3Q-1; Wed, 04 Jan 2023 10:56:41 -0500
X-MC-Unique: PatMQ56pPSWba6xKx7_W3Q-1
Received: by mail-wr1-f71.google.com with SMTP id v4-20020adfa1c4000000b002753317406aso3604454wrv.21
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 07:56:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JHICDqOYgukumk9LLwV3EBYxIew7z8FbH0jMEwELhJU=;
        b=S74YpJArpBPchHDooHD1hCE6nEdAXII1biWvV2Ndq+h0eDjS+5pcJZTHS5+vpdrcqU
         ZHtkNzhZvnRE9OhjglOb9NHr7OjTAaBYjWSE+tQYMvuHiLHrBXEdn8/HF4xfTcSatbzs
         DVkXjd6+qCnfXi5Ic0Dfi8IcJheGbRruv2xn9CQevQ3R860QLhJScvtxXKwAibyHCK3Z
         F6tCE6L3gJxgrMzK8hifrwKAo4jHQTOcZLrEMHtAXdJTida6qDSbXN7P8B6K9rDoSWgb
         ljRa7Hs4sgh2Yx2OgC4ol9QaptGz0vHROApuWZ6Q2vpYxsZ7FzMgRRlphIJk/4odNuRa
         abuQ==
X-Gm-Message-State: AFqh2kowUGRzha7qNHNNtUeyY2V4ucA8quKU0DbBFRl5rT79y3rJTw8s
        FlxI835lTi7sSVdVfCjNGGja4g23Gjg6r5YKGLoDZV9Ln7/t7yVeDZzeXpYBpuE1nUQeRTYiNFl
        ePLRqznFe7nhMTaOyNrV0a/Yz
X-Received: by 2002:a05:600c:1c8e:b0:3d2:4234:e8fe with SMTP id k14-20020a05600c1c8e00b003d24234e8femr34647339wms.19.1672847799934;
        Wed, 04 Jan 2023 07:56:39 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt40B+dtViPfORnTqodkSNT3rePREF+wDWgBhvy/3xO+yStgoKvUDgnDiJUjA2nL/MozidRew==
X-Received: by 2002:a05:600c:1c8e:b0:3d2:4234:e8fe with SMTP id k14-20020a05600c1c8e00b003d24234e8femr34647305wms.19.1672847799605;
        Wed, 04 Jan 2023 07:56:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:f100:8100:5a6c:eb:fd3b? (p200300cbc703f10081005a6c00ebfd3b.dip0.t-ipconnect.de. [2003:cb:c703:f100:8100:5a6c:eb:fd3b])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b003d96efd09b7sm49070632wmp.19.2023.01.04.07.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 07:56:39 -0800 (PST)
Message-ID: <0c4e35de-f790-5399-c812-ff90a4ab7531@redhat.com>
Date:   Wed, 4 Jan 2023 16:56:37 +0100
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 0/9] mm: introduce Designated Movable Blocks
In-Reply-To: <bff78f19-fd40-d9be-6592-93a7a4a91587@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.01.23 00:43, Florian Fainelli wrote:
> On 10/20/22 14:53, Doug Berger wrote:
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
>> The main objective of this patch set is therefore to allow a
>> block of memory to be designated as part of the ZONE_MOVABLE
>> zone where it will always only be used by the kernel page
>> allocator to satisfy requests for movable pages. The term
>> Designated Movable Block is introduced here to represent such a
>> block. The favored implementation allows extension of the
>> 'movablecore' kernel parameter to allow specification of a base
>> address and support for multiple blocks. The existing
>> 'movablecore' mechanisms are retained.
>>
>> BACKGROUND:
>> NUMA architectures support distributing movablecore memory
>> across each node, but it is undesirable to introduce the
>> overhead and complexities of NUMA on systems that don't have a
>> Non-Uniform Memory Architecture.
>>
>> Commit 342332e6a925 ("mm/page_alloc.c: introduce kernelcore=mirror option")
>> also depends on zone overlap to support sytems with multiple
>> mirrored ranges.
>>
>> Commit c6f03e2903c9 ("mm, memory_hotplug: remove zone restrictions")
>> embraced overlapped zones for memory hotplug.
>>
>> This commit set follows their lead to allow the ZONE_MOVABLE
>> zone to overlap other zones. Designated Movable Blocks are made
>> absent from overlapping zones and present within the
>> ZONE_MOVABLE zone.
>>
>> I initially investigated an implementation using a Designated
>> Movable migrate type in line with comments[1] made by Mel Gorman
>> regarding a "sticky" MIGRATE_MOVABLE type to avoid using
>> ZONE_MOVABLE. However, this approach was riskier since it was
>> much more instrusive on the allocation paths. Ultimately, the
>> progress made by the memory hotplug folks to expand the
>> ZONE_MOVABLE functionality convinced me to follow this approach.
>>
> 
> Mel, David, does the sub-thread discussion with Doug help ensuring that
> all of the context is gathered before getting into a more detailed patch
> review on a patch-by-patch basis?
> 
> Eventually we may need a fairly firm answer as to whether the proposed
> approach has any chance of landing upstream in order to either commit to
> in subsequent iterations of this patch set, or find an alternative.


As raised, I'd appreciate if less intrusive alternatives could be 
evaluated (e.g., fake NUMA nodes and being ablee to just use mbind(), 
moving such memory to ZONE_MOVABLE after boot via something like daxctl).

I'm not convinced that these intrusive changes are worth it at this 
point. Further, some of the assumptions (ZONE_MOVABLE == user space) are 
not really future proof as I raised.

-- 
Thanks,

David / dhildenb

