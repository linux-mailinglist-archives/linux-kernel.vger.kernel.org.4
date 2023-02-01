Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D115A682E84
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjAaN6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjAaN6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:58:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04D54B1B8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675173444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KLzrEVNF/I06hEyCLzFWZ+B0+c4Uy25WE0TJqoTLRzw=;
        b=QZhPvOsekA/DBfoNj2jeVyTVltGiqTznKirizv35Yu+eXGM2UwO4/gWDXK+l07lDkX6Rxh
        3GD6hIzrZFGpWP3zQY9TEjM80su8/cSZTdUVih6LjDnAc5ot4ycAzfAd7kvgo7KVzIc9Us
        PuYBvtkzOBdp7nV1X5ClVmRnyjPZkWQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-237-KS94Jv8MOSas0Dl0NrJRrw-1; Tue, 31 Jan 2023 08:57:23 -0500
X-MC-Unique: KS94Jv8MOSas0Dl0NrJRrw-1
Received: by mail-wm1-f70.google.com with SMTP id o31-20020a05600c511f00b003dc53da325dso4555888wms.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:57:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLzrEVNF/I06hEyCLzFWZ+B0+c4Uy25WE0TJqoTLRzw=;
        b=zWxiNrIBu+FfP68vjCzQWFjSictfAInQUYVg6kj7KNbzLLDMorwPBHlE5ykAocv2tB
         I4h8VRLO3j8INu2lFz5a4LR2ckTftA20UebzUaPJV5A8aYaJUTkWPvDtyBiga95GHRWA
         AH8eMW9jjFc+65D9x3lorFF6hC+KG1SA9CenCZIpgHZc13F/okWn/kNTNCVlIHpqrUhm
         7oTai3utAs1XcqncOZE0ilTFKS2Ynuspkl7l3kKPT39gNP1ss426SgDQ7BUpGlOKICu9
         WewfyHIKamf3FUPPwJhK3ip054YdM9tk7CVpMTES4afEv9kd9znNqXiGq4Sup9Eq5q20
         EQaA==
X-Gm-Message-State: AFqh2koSVB6+U2FXzaK4yJoF9tv6LYvtVJFmPMxmbA0M6R59DPjm0qhl
        Wmej30Oh/BpJCqlfJ5yb6Njjka0T+A066dBKNQBsGTCj4sdXRjZiDI3kTiPyBSxOqmT1FvgQaXR
        QIeB1PKC57Utr5UefZqb1NrIX
X-Received: by 2002:a05:600c:4e03:b0:3db:262a:8ef with SMTP id b3-20020a05600c4e0300b003db262a08efmr44560328wmq.38.1675173442172;
        Tue, 31 Jan 2023 05:57:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsjRC03EHs1ylOUCt2idLp4HzZmJ3Ve19/uWBVh0SsYpLR/66FyQTj2vCIacfH10/YwThbP4g==
X-Received: by 2002:a05:600c:4e03:b0:3db:262a:8ef with SMTP id b3-20020a05600c4e0300b003db262a08efmr44560307wmq.38.1675173441825;
        Tue, 31 Jan 2023 05:57:21 -0800 (PST)
Received: from ?IPV6:2003:d8:2f0a:ca00:f74f:2017:1617:3ec3? (p200300d82f0aca00f74f201716173ec3.dip0.t-ipconnect.de. [2003:d8:2f0a:ca00:f74f:2017:1617:3ec3])
        by smtp.gmail.com with ESMTPSA id f28-20020a5d58fc000000b002be5401ef5fsm15330455wrd.39.2023.01.31.05.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:57:21 -0800 (PST)
Message-ID: <6369225e-3522-341b-cd20-d95b1f11ea71@redhat.com>
Date:   Tue, 31 Jan 2023 14:57:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 00/19] mm: Introduce a cgroup to limit the amount of
 locked and pinned memory
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <Y9A7kDjm3ZFAttRR@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y9A7kDjm3ZFAttRR@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.01.23 21:12, Jason Gunthorpe wrote:
> On Tue, Jan 24, 2023 at 04:42:29PM +1100, Alistair Popple wrote:
>> Having large amounts of unmovable or unreclaimable memory in a system
>> can lead to system instability due to increasing the likelihood of
>> encountering out-of-memory conditions. Therefore it is desirable to
>> limit the amount of memory users can lock or pin.
>>
>>  From userspace such limits can be enforced by setting
>> RLIMIT_MEMLOCK. However there is no standard method that drivers and
>> other in-kernel users can use to check and enforce this limit.
>>
>> This has lead to a large number of inconsistencies in how limits are
>> enforced. For example some drivers will use mm->locked_mm while others
>> will use mm->pinned_mm or user->locked_mm. It is therefore possible to
>> have up to three times RLIMIT_MEMLOCKED pinned.
>>
>> Having pinned memory limited per-task also makes it easy for users to
>> exceed the limit. For example drivers that pin memory with
>> pin_user_pages() it tends to remain pinned after fork. To deal with
>> this and other issues this series introduces a cgroup for tracking and
>> limiting the number of pages pinned or locked by tasks in the group.
>>
>> However the existing behaviour with regards to the rlimit needs to be
>> maintained. Therefore the lesser of the two limits is
>> enforced. Furthermore having CAP_IPC_LOCK usually bypasses the rlimit,
>> but this bypass is not allowed for the cgroup.
>>
>> The first part of this series converts existing drivers which
>> open-code the use of locked_mm/pinned_mm over to a common interface
>> which manages the refcounts of the associated task/mm/user
>> structs. This ensures accounting of pages is consistent and makes it
>> easier to add charging of the cgroup.
>>
>> The second part of the series adds the cgroup and converts core mm
>> code such as mlock over to charging the cgroup before finally
>> introducing some selftests.
>>
>> As I don't have access to systems with all the various devices I
>> haven't been able to test all driver changes. Any help there would be
>> appreciated.
> 
> I'm excited by this series, thanks for making it.
> 
> The pin accounting has been a long standing problem and cgroups will
> really help!

Indeed. I'm curious how GUP-fast, pinning the same page multiple times, 
and pinning subpages of larger folios are handled :)

-- 
Thanks,

David / dhildenb

