Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8C670624F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjEQIKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEQIKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:10:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284DE10D4
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684310976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=01liRdz6Q+TmEyjnaMxU3rDH25cRBYMipC4CBhtj1oc=;
        b=Mm863mKGdBRtcD4WMdLQDr+feQgF8vaWgMIXDiuNI+9ougyiOtrmYohrHGjSV+L9r8i7eO
        LAOrBUzt48iAF6cwvQNUrG9jsmFNh1mirEeVfpNd2Rj/y0z/FQk5EJFfihoobTt82ZY+lY
        RQqc9ffF7a5pvpA50Vx5AB7STxr7TBc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-5WAGlax5PFiZ5P3NT5_JLg-1; Wed, 17 May 2023 04:09:34 -0400
X-MC-Unique: 5WAGlax5PFiZ5P3NT5_JLg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30629b36d9bso176455f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684310973; x=1686902973;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01liRdz6Q+TmEyjnaMxU3rDH25cRBYMipC4CBhtj1oc=;
        b=NGbvjKC8lBJT0R+sLSBJZ7KT4BVmw9w5x/h4HJIpmsVRs9fOdF3CQvG+P0hhOaokB/
         lYqcmIhv2j+/ftUHDU9ei8gzrNyECZ1Q/UiGFeFqpgbzLFNVs1hnx6OZjrxHC0lyZSIk
         Mt6fOTHumLwgx4476J7g7w9VyhriiSZkdmfxvgANRVu4RTB+HiFUpOTeXiKmX9C4FqDp
         b7aNZJrXMBj4gkQsNJRgCxZe6zmrWu0l40x6YoRDwtXi9C3kE1wOwR69IA0ERbJTq4YX
         6nsNRP/5RdEfRaT/dfAzZLh+S1efM1AySsys+QaMVvoiJMtJVb6FyTxIABjmJ2QFOzwP
         90jw==
X-Gm-Message-State: AC+VfDy26dXAF25ol5NAneOWMOOBV7RLp6VJho4noiP60XlcmOz0I0B+
        r1AQTWx+kgEb6bXFAw5Lq/VJUcQB8lJIRc8+N/M1oqK9CZ0hSVTJ1d4JK0AR5O41slND9/qKPfn
        QZF7rKmipqq/VK/mWvEX4xQNrGGz7Ocnt
X-Received: by 2002:a5d:568e:0:b0:309:3e6f:6725 with SMTP id f14-20020a5d568e000000b003093e6f6725mr912950wrv.4.1684310973544;
        Wed, 17 May 2023 01:09:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ46X9BkjYgsxlk5mS9oQkAdmElgN6LCRa1pV6ETGXekFADfe8w0UP+ZRbuQZth1xiZ2DP++gQ==
X-Received: by 2002:a5d:568e:0:b0:309:3e6f:6725 with SMTP id f14-20020a5d568e000000b003093e6f6725mr912932wrv.4.1684310973159;
        Wed, 17 May 2023 01:09:33 -0700 (PDT)
Received: from [192.168.3.108] (p4ff23b51.dip0.t-ipconnect.de. [79.242.59.81])
        by smtp.gmail.com with ESMTPSA id e17-20020adfe7d1000000b00300aee6c9cesm1986633wrn.20.2023.05.17.01.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 01:09:32 -0700 (PDT)
Message-ID: <eae68813-4240-4de1-6177-0a44e00bd04d@redhat.com>
Date:   Wed, 17 May 2023 10:09:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20230511065607.37407-1-ying.huang@intel.com>
 <ZF0ET82ajDbFrIw/@dhcp22.suse.cz>
 <87r0rm8die.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZGIUEqhSydAdvRFN@dhcp22.suse.cz>
 <87jzx87h1d.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <3d77ca46-6256-7996-b0f5-67c414d2a8dc@redhat.com>
 <87bkij7ncn.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC 0/6] mm: improve page allocator scalability via splitting
 zones
In-Reply-To: <87bkij7ncn.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> If we could avoid instantiating more zones and rather improve existing
>> mechanisms (PCP), that would be much more preferred IMHO. I'm sure
>> it's not easy, but that shouldn't stop us from trying ;)
> 
> I do think improving PCP or adding another level of cache will help
> performance and scalability.
> 
> And, I think that it has value too to improve the performance of zone
> itself.  Because there will be always some cases that the zone lock
> itself is contended.
> 
> That is, PCP and zone works at different level, and both deserve to be
> improved.  Do you agree?

Spoiler: my humble opinion


Well, the zone is kind-of your "global" memory provider, and PCPs cache 
a fraction of that to avoid exactly having to mess with that global 
datastructure and lock contention.

One benefit I can see of such a "global" memory provider with caches on 
top is is that it is nicely integrated: for example, the concept of 
memory pressure exists for the zone as a whole. All memory is of the 
same kind and managed in a single entity, but free memory is cached for 
performance.

As soon as you manage the memory in multiple zones of the same kind, you 
lose that "global" view of your memory that is of the same kind, but 
managed in different bucks. You might end up with a lot of memory 
pressure in a single such zone, but still have plenty in another zone.

As one example, hot(un)plug of memory is easy: there is only a single 
zone. No need to make smart decisions or deal with having memory we're 
hotunplugging be stranded in multiple zones.

> 
>> I did not look into the details of this proposal, but seeing the
>> change in include/linux/page-flags-layout.h scares me.
> 
> It's possible for us to use 1 more bit in page->flags.  Do you think
> that will cause severe issue?  Or you think some other stuff isn't
> acceptable?

The issue is, everybody wants to consume more bits in page->flags, so if 
we can get away without it that would be much better :)

The more bits you want to consume, the more people will ask for making 
this a compile-time option and eventually compile it out on distro 
kernels (e.g., with many NUMA nodes). So we end up with more code and 
complexity and eventually not get the benefits where we really want them.

> 
>> Further, I'm not so sure how that change really interacts with
>> hot(un)plug of memory ... on a quick glimpse I feel like this series
>> hacks the code such that such that the split works based on the boot
>> memory size ...
> 
> Em..., the zone stuff is kind of static now.  It's hard to add a zone at
> run-time.  So, in this series, we determine the number of zones per zone
> type based on boot memory size.  This may be improved in the future via
> pre-allocate some empty zone instances during boot and hot-add some
> memory to these zones.

Just to give you some idea: with virtio-mem, hyper-v, daxctl, and 
upcoming cxl dynamic memory pooling (some day I'm sure ;) ) you might 
see quite a small boot memory (e.g., 4 GiB) but a significant amount of 
memory getting hotplugged incrementally (e.g., up to 1 TiB) -- well, and 
hotunplugged. With multiple zone instances you really have to be careful 
and might have to re-balance between the multiple zones to keep the 
scalability, to not create imbalances between the zones ...

Something like PCP auto-tuning would be able to handle that mostly 
automatically, as there is only a single memory pool.

> 
>> I agree with Michal that looking into auto-tuning PCP would be
>> preferred. If that can't be done, adding another layer might end up
>> cleaner and eventually cover more use cases.
> 
> I do agree that it's valuable to make PCP etc. cover more use cases.  I
> just think that this should not prevent us from optimizing zone itself
> to cover remaining use cases.

I really don't like the concept of replicating zones of the same kind 
for the same NUMA node. But that's just my personal opinion maintaining 
some memory hot(un)plug code :)

Having that said, some kind of a sub-zone concept (additional layer) as 
outlined by Michal IIUC, for example, indexed by core id/has/whatsoever 
could eventually be worth exploring. Yes, such a design raises various 
questions ... :)

-- 
Thanks,

David / dhildenb

