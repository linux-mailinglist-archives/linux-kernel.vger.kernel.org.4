Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90ECC6E20D5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjDNKce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjDNKcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482D28A53
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681468307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z4OY31S9mUHw6BlIMwhzxwBlTgpR3iZTfz/4sQFURp8=;
        b=AjGrTNqN/QXfiCAO8noubXFkuZIcsH2irAWgwPgWKVZvXjezcGxIkY4tzjd+PJW8xkVSEh
        HST6QceSkypbiPH8y5yJoSQVAoYnCUWaqN9QX4WOlu366azjrs6nSFV35BWQSa2UWB5KDh
        SbB601jgBuPE2K0jDExVhhZV9aLLxxg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-vPCan0r_PLCaGIlZM7JjLQ-1; Fri, 14 Apr 2023 06:31:46 -0400
X-MC-Unique: vPCan0r_PLCaGIlZM7JjLQ-1
Received: by mail-wr1-f69.google.com with SMTP id g23-20020adfa497000000b002f420263923so2099063wrb.21
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681468305; x=1684060305;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4OY31S9mUHw6BlIMwhzxwBlTgpR3iZTfz/4sQFURp8=;
        b=PhFrjvwDITRiLmmGN3VxgwWUQpbugzFPye+ze2JnHwZ8GS4CPPBLyRgU8hX5IDWg4u
         JKFxgvWsk+2jYxr8NE55JSVuiQ4QMJ23QvlpXZt3JRrHUvwvFgx3wmDTPYtFSVPoP1xM
         Ef6piAxiGtwD2AePW4AM5q46iyu6EFXnEZkdS/i+EWJEgo20MEnueUoZEgdF7x/QLtpW
         CUpoV92rZWt9GtaPULfLd/Xdwu1ZkkweEekgPHF/T1rGUda3MVozQGj7a5jJcDEtgEXa
         0rbnVToTQHvmgjHcEHcwDansAFll/K5TdAQJOQ1KbR3tjhugUpmdXlv5zPL2cCnmG4Vl
         KZiw==
X-Gm-Message-State: AAQBX9c1SJ0ZG6VNiSAroiaLApRBJdjcZiEWrBOe99wpCN/N6suhTd/K
        vFFDPVUr7B1uiy08xMlyn3TUoq4TUSWmHVI9FWonTwE4JIj7H2y8qgP9gBReEPrmGTytYYTuXhY
        yhzZNbheGK67mhLoPxNdwQ+rl
X-Received: by 2002:a05:6000:107:b0:2f4:170:3807 with SMTP id o7-20020a056000010700b002f401703807mr3923334wrx.44.1681468305138;
        Fri, 14 Apr 2023 03:31:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350YJev2/y8Y93fyj23BgYm40VnAb0CKaZh0JPuItMitr0VyPEpZgKjy6MkOkxfO8rUIFpCcLkQ==
X-Received: by 2002:a05:6000:107:b0:2f4:170:3807 with SMTP id o7-20020a056000010700b002f401703807mr3923315wrx.44.1681468304747;
        Fri, 14 Apr 2023 03:31:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5700:cb5b:f73a:c650:1d9? (p200300cbc7025700cb5bf73ac65001d9.dip0.t-ipconnect.de. [2003:cb:c702:5700:cb5b:f73a:c650:1d9])
        by smtp.gmail.com with ESMTPSA id p11-20020a5d458b000000b002efb31d3c24sm3251251wrq.32.2023.04.14.03.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 03:31:44 -0700 (PDT)
Message-ID: <832d4026-c88f-876b-5f95-4d573bb9d1dd@redhat.com>
Date:   Fri, 14 Apr 2023 12:31:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] mm: page_alloc: Assume huge tail pages are valid when
 allocating contiguous pages
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <OSalvador@suse.com>,
        Yuanxi Liu <y.liu@naruida.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230414082222.idgw745cgcduzy37@techsingularity.net>
 <ZDkU6PuuDsUb82lr@dhcp22.suse.cz>
 <20230414095204.7fz6trkj5i4mzthz@techsingularity.net>
 <ZDkolzCWQNe0NmTD@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZDkolzCWQNe0NmTD@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.04.23 12:19, Michal Hocko wrote:
> On Fri 14-04-23 10:52:04, Mel Gorman wrote:
>> On Fri, Apr 14, 2023 at 10:55:04AM +0200, Michal Hocko wrote:
>>> On Fri 14-04-23 09:22:22, Mel Gorman wrote:
>>> [...]
>>>> +
>>>> +		/*
>>>> +		 * Do not migrate huge pages that span the size of the region
>>>> +		 * being allocated contiguous. e.g. Do not migrate a 1G page
>>>> +		 * for a 1G allocation request. CMA is an exception as the
>>>> +		 * region may be reserved for hardware that requires physical
>>>> +		 * memory without a MMU or scatter/gather capability.
>>>> +		 *
>>>> +		 * Note that the compound check is race-prone versus
>>>> +		 * free/split/collapse but it should be safe and result in
>>>> +		 * a premature skip or a useless migration attempt.
>>>> +		 */
>>>> +		if (PageHuge(page) && compound_nr(page) >= nr_pages &&
>>>> +		    !is_migrate_cma_page(page)) {
>>>> +			return false;
>>>
>>> Is the CMA check working as expected?
>>
>> I didn't test it as I don't have a good simulator for CMA contraints which
>> is still a mobile phone concern for devices like cameras.
>>
>>> The function sounds quite generic
>>> and I agree that it would make sense if it was generic but it is used
>>> only for GB pages in fact and unless I am missing something it would
>>> allow to migrate CMA pages and potentially allocate over that region
>>> without any possibility to migrate GB page out so the CMA region would
>>> be essentially unusable for CMA users.
>>
>> It's used primarily for 1G pages but does have other users (debugging
>> mostly, low priority). As it's advertised as a general API, I decided to
>> treat it as such and that meant being nice to CMA if possible. If CMA pages
>> migrate but can still use the target location then it should be fine. If a
>> CMA can migrate to an usable location that breaks a device then that's a bug.
>>
>>> GB pages already have their CMA
>>> allocator path before we get to alloc_contig_pages. Or do I miss
>>> something?
>>
>> I don't think you missed anything. The CMA check is, at best, an effort
>> to have a potentially useful semantic but it's very doubtful anyone will
>> notice or care. I'm perfectly happy just to drop the CMA check because it's a
>> straight-forward fix and more suitable as a -stable backport.  I'm also happy
>> to just go with a PageHuge check and ignore any possibility that a 2M page
>> could be migrated to satisfy a 1G allocation.  1G allocation requests after
>> significant uptime is a crapshoot at best and relying on them succeeding is
>> unwise. There is a non-zero possibility that the latency incurred migrating
>> 2M pages and still failing a 1G allocation could itself be classed as a
>> bug with users preferring fast-failure of 1G allocation attempts.
> 
> Yes, the simpler the better. If we encounter a real usecase where couple
> of 2MB hugetlb pages stand in the way to GB pages then we can add the
> check so I would just go with reintroducing the PageHuge check alone.

alloc_contig_pages() -> __alloc_contig_pages() -> 
alloc_contig_range(MIGRATE_MOVABLE)

Should always fail when stumbling over MIGRATE_CMA pageblocks IIRC.

So we could bail out in that function early if we stumble over any CMA 
region.

-- 
Thanks,

David / dhildenb

