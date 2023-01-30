Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D85680986
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbjA3Jal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236894AbjA3JaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:30:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D918F301BF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675070783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vnEWQUSw8JxK0U8nGwdoLi/zEuKRzSDFmH5aEjEeKDQ=;
        b=a8uROYazbtnjy96cjtxGhJ5nnyxawuIJjiURRrvjih3nJNCBVPVw7Htr4VA09M/RVWHPSL
        neczJjbFZTZwZ9vXZkmfCBaLTWN6JndLRen5BrH5sVkZvC+YtBhc+L66pveUZZeQx/c5GS
        x4V2HdEKXmQvNDLwvWYtEBmykdaHmFc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-449-wmRWBxn-PSKXAxZlLVlmxQ-1; Mon, 30 Jan 2023 04:26:19 -0500
X-MC-Unique: wmRWBxn-PSKXAxZlLVlmxQ-1
Received: by mail-wr1-f69.google.com with SMTP id t3-20020adff043000000b002bfd38027fcso1147899wro.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:26:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnEWQUSw8JxK0U8nGwdoLi/zEuKRzSDFmH5aEjEeKDQ=;
        b=uU6k69sqb/yQsd1nMSYaGA26o6WxfP1V0+Tt46j/mptgkIruigL8BVm2nUtbzBiW5U
         U7aCCULlajstWxN1ab7d/9p9MEV+LBOxTHII57wTe6JeBZ9bMON9VNYfarmN950+QyI8
         mdJHiUfR27EFarCOOm348FoqQFb9xjR1vIIA64SeNXNckERqtqCsCklRMrKD8Au5lw3T
         7LVTX2oGadHwcwtXMlMZa2AcPfeTM9gclUyjTB2d5/uNtEXpEiexH6ryM/lOhzBoXn5m
         W2GjXHjvVdWdU3+4jAvnlvEUmEBoBYVYKpLyiQ/++EeeQid1w+PHY+m7TlLJbjDDeXME
         YNyA==
X-Gm-Message-State: AO0yUKUwLInfNABAdPG5YHapyf1qvIQNyDLVqqRbK11lkiyeZkgVwRSJ
        /xufGnwEJDbIEdNH3qbDdyNsr8f+N1RT/V4nTwD0AbVGrkLm96v1e63aK9wkEQx8rzIOJ5XBRP3
        vVfOrue3nPzc0Kh7zQ3l3Hkz+
X-Received: by 2002:a5d:404c:0:b0:2bf:ea00:8142 with SMTP id w12-20020a5d404c000000b002bfea008142mr3595137wrp.34.1675070778231;
        Mon, 30 Jan 2023 01:26:18 -0800 (PST)
X-Google-Smtp-Source: AK7set/DWMnJx7SNtGfZSq5YYcHFEeGb8BelXSZ8JUB9iMWEO5v3R7w2rAp/wavW9aDThk64AmJJ0Q==
X-Received: by 2002:a5d:404c:0:b0:2bf:ea00:8142 with SMTP id w12-20020a5d404c000000b002bfea008142mr3595123wrp.34.1675070777891;
        Mon, 30 Jan 2023 01:26:17 -0800 (PST)
Received: from ?IPV6:2003:d8:2f16:1800:a9b4:1776:c5d9:1d9a? (p200300d82f161800a9b41776c5d91d9a.dip0.t-ipconnect.de. [2003:d8:2f16:1800:a9b4:1776:c5d9:1d9a])
        by smtp.gmail.com with ESMTPSA id g8-20020adfe408000000b002bdda9856b5sm11468378wrm.50.2023.01.30.01.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 01:26:17 -0800 (PST)
Message-ID: <92076c0e-1eee-66a4-6342-202989c32955@redhat.com>
Date:   Mon, 30 Jan 2023 10:26:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: kernel BUG in page_add_anon_rmap
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
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
 <67dfd817-073e-9abb-316f-689ba8193965@redhat.com>
Organization: Red Hat
In-Reply-To: <67dfd817-073e-9abb-316f-689ba8193965@redhat.com>
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

On 30.01.23 10:03, David Hildenbrand wrote:
>>>>
>>>> I reproduced on next-20230127 (did not try upstream yet).
>>
>> Upstream's fine; on next-20230127 (with David's repro) it bisects to
>> 5ddaec50023e ("mm/mmap: remove __vma_adjust()").  I think I'd better
>> hand on to Liam, rather than delay you by puzzling over it further myself.
>>
> 
> Thanks for identifying the problematic commit! ...
> 
>>>>
>>>> I think two key things are that a) THP are set to "always" and b) we have a
>>>> NUMA setup [I assume].
>>>>
>>>> The relevant bits:
>>>>
>>>> [  439.886738] page:00000000c4de9000 refcount:513 mapcount:2
>>>> mapping:0000000000000000 index:0x20003 pfn:0x14ee03
>>>> [  439.893758] head:000000003d5b75a4 order:9 entire_mapcount:0
>>>> nr_pages_mapped:511 pincount:0
>>>> [  439.899611] memcg:ffff986dc4689000
>>>> [  439.902207] anon flags:
>>>> 0x17ffffc009003f(locked|referenced|uptodate|dirty|lru|active|head|swapbacked|node=0|zone=2|lastcpupid=0x1fffff)
>>>> [  439.910737] raw: 0017ffffc0020000 ffffe952c53b8001 ffffe952c53b80c8
>>>> dead000000000400
>>>> [  439.916268] raw: 0000000000000000 0000000000000000 0000000000000001
>>>> 0000000000000000
>>>> [  439.921773] head: 0017ffffc009003f ffffe952c538b108 ffff986de35a0010
>>>> ffff98714338a001
>>>> [  439.927360] head: 0000000000020000 0000000000000000 00000201ffffffff
>>>> ffff986dc4689000
>>>> [  439.932341] page dumped because: VM_BUG_ON_PAGE(!first && (flags & ((
>>>> rmap_t)((((1UL))) << (0)))))
>>>>
>>>>
>>>> Indeed, the mapcount of the subpage is 2 instead of 1. The subpage is only
>>>> mapped into a single
>>>> page table (no fork() or similar).
>>
>> Yes, that mapcount:2 is weird; and what's also weird is the index:0x20003:
>> what is remove_migration_pte(), in an mbind(0x20002000,...), doing with
>> index:0x20003?
> 
> I was assuming the whole folio would get migrated. As you raise below,
> it's all a bit unclear once THP get involved and dealing with mbind()
> and page migration.
> 
>>>>
>>>> I created this reduced reproducer that triggers 100%:
>>
>> Very helpful, thank you.
>>
>>>>
>>>>
>>>> #include <stdint.h>
>>>> #include <unistd.h>
>>>> #include <sys/mman.h>
>>>> #include <numaif.h>
>>>>
>>>> int main(void)
>>>> {
>>>> 	mmap((void*)0x20000000ul, 0x1000000ul, PROT_READ|PROT_WRITE|PROT_EXEC,
>>>> 	     MAP_ANONYMOUS|MAP_FIXED|MAP_PRIVATE, -1, 0ul);
>>>> 	madvise((void*)0x20000000ul, 0x1000000ul, MADV_HUGEPAGE);
>>>>
>>>> 	*(uint32_t*)0x20000080 = 0x80000;
>>>> 	mlock((void*)0x20001000ul, 0x2000ul);
>>>> 	mlock((void*)0x20000000ul, 0x3000ul);
>>
>> It's not an mlock() issue in particular: quickly established by
>> substituting madvise(,, MADV_NOHUGEPAGE) for those mlock() calls.
>> Looks like a vma splitting issue now.
> 
> Gah, should have tried something like that first before suspecting it's
> mlock related. :)
> 
>>
>>>> 	mbind((void*)0x20002000ul, 0x1000ul, MPOL_LOCAL, NULL, 0x7fful,
>>>> 	MPOL_MF_MOVE);
>>
>> I guess it will turn out not to be relevant to this particular syzbug,
>> but what do we expect an mbind() of just 0x1000 of a THP to do?
>>
>> It's a subject I've wrestled with unsuccessfully in the past: I found
>> myself arriving at one conclusion (split THP) in one place, and a contrary
>> conclusion (widen range) in another place, and never had time to work out
>> one unified answer.
> 
> I'm aware of a similar issue with long-term page pinning: we might want
> to pin a 4k portion of a THP, but will end up blocking the whole THP
> from getting migrated/swapped/split/freed/ ... until we unpin (ever?). I
> wrote a reproducer [1] a while ago to show how you can effectively steal
> most THP in the system using comparatively small memlock limit using
> io_uring ...
> 

Correction, my reproducer already triggers a compund page split to 
really only pin a 4k page, to then free the remaining 4k pages of the 
previous THP. As a single 4k page is allocated and pinned, we cannot get 
a THP at these physical memory locations until the page is unpinned.

-- 
Thanks,

David / dhildenb

