Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D3368081E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbjA3JEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjA3JEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:04:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898C17DBF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675069430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IAqgWmN1xd1G9ow++NKtAbPr5zDPwkdjveX+CdcfGNQ=;
        b=CYzQYJo4Xog9nrmIr25u3vMnzrPQdPFhgZpt8Di30ZsXpX/5ZQQDym96lZ1OKHHPvUJsNs
        8YeSRRSRf9nvaMiLvLrcTGX52ds4PH9dKBaWdWBwc8umuDoyemAQQAgTEPyC7is6XopSI2
        IYfrVLAr9yIAWcnwQQJXmq2t3u6E7xA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-418-iTzpR2ozOQOpyJJpXbQ8Qw-1; Mon, 30 Jan 2023 04:03:49 -0500
X-MC-Unique: iTzpR2ozOQOpyJJpXbQ8Qw-1
Received: by mail-wm1-f69.google.com with SMTP id h9-20020a1ccc09000000b003db1c488826so9203021wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:03:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IAqgWmN1xd1G9ow++NKtAbPr5zDPwkdjveX+CdcfGNQ=;
        b=3H+PLTAbk4eTMMb383SY41+9yJ/pAA1UO0YL81y2lIcaOIDERW7pfOTT0pTeqMrtNz
         /bjGdo+9biPSypaQIVFZzuoKEuvnAZi8FdHGgXHOa18CpNeDo+bSqM+VW34anNfE9S3m
         vJUic7gX9AzSGPa0GF0MJxG9/5V0sNO6/4lCySz04eDjeY8NbYjWm/syGOWLF9pr/BaP
         l+v4ZfNMw4yOgjPAW5s4erVe5TEUCc+Cq+ZyiJrc2+QZog05QmW9dIc4mAXVfJk3fp2o
         AhANr5e80oVsV22lSlxNGN6a284AUtgPFkoUYX8uRk6Zha3aK4J4OllPBXUWMllnBn3s
         QD3g==
X-Gm-Message-State: AO0yUKVolq0wZz5OR/GprcvXrV659NLj5CxcZtFe+qqUWT8tLOvT/UKZ
        kj8WGTDJgsXI8y5V9l2ySYtqSGj+L/kmTdUU0vX9LUNTABHzn9u5+TfVnA9ZEo1fWns07fp/1bY
        dBlX4gih7k+yzBne4cZthApPh
X-Received: by 2002:a05:600c:5114:b0:3dc:54e9:dfd7 with SMTP id o20-20020a05600c511400b003dc54e9dfd7mr4274348wms.25.1675069427856;
        Mon, 30 Jan 2023 01:03:47 -0800 (PST)
X-Google-Smtp-Source: AK7set9snCm1aOVKnYLp3xP63lQlRYDnMVlb/oxVe9LHBuPADmhYO8jAN2DNcTv3bsmzxTCAlVbSoA==
X-Received: by 2002:a05:600c:5114:b0:3dc:54e9:dfd7 with SMTP id o20-20020a05600c511400b003dc54e9dfd7mr4274316wms.25.1675069427425;
        Mon, 30 Jan 2023 01:03:47 -0800 (PST)
Received: from ?IPV6:2003:d8:2f16:1800:a9b4:1776:c5d9:1d9a? (p200300d82f161800a9b41776c5d91d9a.dip0.t-ipconnect.de. [2003:d8:2f16:1800:a9b4:1776:c5d9:1d9a])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c339200b003dc42d48defsm8109745wmp.6.2023.01.30.01.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 01:03:46 -0800 (PST)
Message-ID: <67dfd817-073e-9abb-316f-689ba8193965@redhat.com>
Date:   Mon, 30 Jan 2023 10:03:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     Hugh Dickins <hughd@google.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Sanan Hasanov <sanan.hasanov@knights.ucf.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        Huang Ying <ying.huang@intel.com>
References: <IA1PR07MB983017D2FBA174D2FF78CEB6ABCE9@IA1PR07MB9830.namprd07.prod.outlook.com>
 <Y9LNCouUvsUFCYkT@casper.infradead.org>
 <adc9152e-c547-12ec-3538-006500619896@redhat.com>
 <713c6242-be65-c212-b790-2b908627c1b4@google.com>
 <9d8fb9c-1b81-67cd-e55b-34517388e1ab@google.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: kernel BUG in page_add_anon_rmap
In-Reply-To: <9d8fb9c-1b81-67cd-e55b-34517388e1ab@google.com>
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

>>>
>>> I reproduced on next-20230127 (did not try upstream yet).
> 
> Upstream's fine; on next-20230127 (with David's repro) it bisects to
> 5ddaec50023e ("mm/mmap: remove __vma_adjust()").  I think I'd better
> hand on to Liam, rather than delay you by puzzling over it further myself.
> 

Thanks for identifying the problematic commit! ...

>>>
>>> I think two key things are that a) THP are set to "always" and b) we have a
>>> NUMA setup [I assume].
>>>
>>> The relevant bits:
>>>
>>> [  439.886738] page:00000000c4de9000 refcount:513 mapcount:2
>>> mapping:0000000000000000 index:0x20003 pfn:0x14ee03
>>> [  439.893758] head:000000003d5b75a4 order:9 entire_mapcount:0
>>> nr_pages_mapped:511 pincount:0
>>> [  439.899611] memcg:ffff986dc4689000
>>> [  439.902207] anon flags:
>>> 0x17ffffc009003f(locked|referenced|uptodate|dirty|lru|active|head|swapbacked|node=0|zone=2|lastcpupid=0x1fffff)
>>> [  439.910737] raw: 0017ffffc0020000 ffffe952c53b8001 ffffe952c53b80c8
>>> dead000000000400
>>> [  439.916268] raw: 0000000000000000 0000000000000000 0000000000000001
>>> 0000000000000000
>>> [  439.921773] head: 0017ffffc009003f ffffe952c538b108 ffff986de35a0010
>>> ffff98714338a001
>>> [  439.927360] head: 0000000000020000 0000000000000000 00000201ffffffff
>>> ffff986dc4689000
>>> [  439.932341] page dumped because: VM_BUG_ON_PAGE(!first && (flags & ((
>>> rmap_t)((((1UL))) << (0)))))
>>>
>>>
>>> Indeed, the mapcount of the subpage is 2 instead of 1. The subpage is only
>>> mapped into a single
>>> page table (no fork() or similar).
> 
> Yes, that mapcount:2 is weird; and what's also weird is the index:0x20003:
> what is remove_migration_pte(), in an mbind(0x20002000,...), doing with
> index:0x20003?

I was assuming the whole folio would get migrated. As you raise below, 
it's all a bit unclear once THP get involved and dealing with mbind() 
and page migration.

>>>
>>> I created this reduced reproducer that triggers 100%:
> 
> Very helpful, thank you.
> 
>>>
>>>
>>> #include <stdint.h>
>>> #include <unistd.h>
>>> #include <sys/mman.h>
>>> #include <numaif.h>
>>>
>>> int main(void)
>>> {
>>> 	mmap((void*)0x20000000ul, 0x1000000ul, PROT_READ|PROT_WRITE|PROT_EXEC,
>>> 	     MAP_ANONYMOUS|MAP_FIXED|MAP_PRIVATE, -1, 0ul);
>>> 	madvise((void*)0x20000000ul, 0x1000000ul, MADV_HUGEPAGE);
>>>
>>> 	*(uint32_t*)0x20000080 = 0x80000;
>>> 	mlock((void*)0x20001000ul, 0x2000ul);
>>> 	mlock((void*)0x20000000ul, 0x3000ul);
> 
> It's not an mlock() issue in particular: quickly established by
> substituting madvise(,, MADV_NOHUGEPAGE) for those mlock() calls.
> Looks like a vma splitting issue now.

Gah, should have tried something like that first before suspecting it's 
mlock related. :)

> 
>>> 	mbind((void*)0x20002000ul, 0x1000ul, MPOL_LOCAL, NULL, 0x7fful,
>>> 	MPOL_MF_MOVE);
> 
> I guess it will turn out not to be relevant to this particular syzbug,
> but what do we expect an mbind() of just 0x1000 of a THP to do?
> 
> It's a subject I've wrestled with unsuccessfully in the past: I found
> myself arriving at one conclusion (split THP) in one place, and a contrary
> conclusion (widen range) in another place, and never had time to work out
> one unified answer.

I'm aware of a similar issue with long-term page pinning: we might want 
to pin a 4k portion of a THP, but will end up blocking the whole THP 
from getting migrated/swapped/split/freed/ ... until we unpin (ever?). I 
wrote a reproducer [1] a while ago to show how you can effectively steal 
most THP in the system using comparatively small memlock limit using 
io_uring ...

In theory, we could split the THP before long-term pinning only a 
subregion ... but what if we cannot split the THP because it's already 
pinned (previous pinning request that covered the whole THP)? Copying 
instead of splitting would also not be possible, if the page is already 
pinned ... so we'd never want to allow long-term pinning a THP ... but 
that means that we would have to fail pinning if splitting the THP fails 
and that there would be performance-consequences for THP users :/

Non-trivial ... just like mlocking only a part of a THP or mbinding 
different parts of a THP to different nodes ...

[1] 
https://gitlab.com/davidhildenbrand/scratchspace/-/blob/main/io_uring_thp.c

-- 
Thanks,

David / dhildenb

