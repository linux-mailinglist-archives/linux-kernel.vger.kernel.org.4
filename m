Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE77C67E4AB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjA0MJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjA0MJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:09:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A166584
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674820861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C3rFWvX2KDOh8ZoRdoaFO7pdzDg8/M7CJeQbeOt0z1I=;
        b=h+a/6Gkx+mpZrPFxz0hhztrFUH0WHRnx8qkJ/MwNUnD4QFR1bJQMuzU9I5nLNnZD/vFVZ/
        5FbMzA4A5V7tHJYPMCwZSk5rLbIoIbkpnvlOul1evWYGwjxKKnDo4pLubDMzo25m9NA6rt
        0UqtVx0rT3YHybSG7Fm8vy1oghc6PRU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-66-LS3wMJRuMuWOp_enRMLYPA-1; Fri, 27 Jan 2023 06:44:21 -0500
X-MC-Unique: LS3wMJRuMuWOp_enRMLYPA-1
Received: by mail-wm1-f72.google.com with SMTP id 12-20020a05600c228c00b003db09699216so1319282wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:44:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3rFWvX2KDOh8ZoRdoaFO7pdzDg8/M7CJeQbeOt0z1I=;
        b=3Jk2HobNHHmp5TVRdZJilkGQP/zlOlzoFaC9bRK5lLzzQMQd/yKWUY3T8IbukjdYUt
         2lI4X6+/yKUqzScoG5Tbgt3ONK8IdWQGUfUq9/NVIMPtZLiAW3CTc66KKKCuU514mwDi
         l8ts0jT9qz/TawfXDEq7ELgXm0UtdxMpmtrpvgeQnMGwpzYOz+nonhoOB+H3jAZFF9Hw
         Q3U76g+EdZ8y2Aow0vGYpKlMltmBllpVrhrw5aWc8X+NBLlDAbygEwnJpRsD+LFgzFK+
         Lykv+aeyS5kHQIxTbCTP6tknu3fc4HBLDu6/v6qi8zWBNa1JyEGlFLp4GXRtsQF3LD4O
         veSg==
X-Gm-Message-State: AO0yUKWIjivNYo8CZ3V97k+IoAYpFpmugA2+R6xLPMPN8hpbKCeQHCoZ
        BSjIx9SEacdJjVs0xcIcYrwif9cVJte7+SnOEZ8V8azW7UE26sx+m1OSzFaYmlE3D9VDCtcU1j9
        XdpS4Ngr91ex4lDizdsfL6q4s
X-Received: by 2002:a7b:cb94:0:b0:3dc:2d8c:b302 with SMTP id m20-20020a7bcb94000000b003dc2d8cb302mr3694431wmi.39.1674819859903;
        Fri, 27 Jan 2023 03:44:19 -0800 (PST)
X-Google-Smtp-Source: AK7set8siuhzXuF8mjzaZKHZ9dMOAgmZ9J3tZCF6IX9ohu+Ksp/Lrsu4NVkAU1+TrfnoM5F2fD8pdQ==
X-Received: by 2002:a7b:cb94:0:b0:3dc:2d8c:b302 with SMTP id m20-20020a7bcb94000000b003dc2d8cb302mr3694393wmi.39.1674819859255;
        Fri, 27 Jan 2023 03:44:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:2600:5c01:dcac:6d6:415? (p200300cbc70526005c01dcac06d60415.dip0.t-ipconnect.de. [2003:cb:c705:2600:5c01:dcac:6d6:415])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c1d0400b003db2e3f2c7csm16100904wms.0.2023.01.27.03.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 03:44:18 -0800 (PST)
Message-ID: <adc9152e-c547-12ec-3538-006500619896@redhat.com>
Date:   Fri, 27 Jan 2023 12:44:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     Matthew Wilcox <willy@infradead.org>,
        Sanan Hasanov <sanan.hasanov@knights.ucf.edu>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>
References: <IA1PR07MB983017D2FBA174D2FF78CEB6ABCE9@IA1PR07MB9830.namprd07.prod.outlook.com>
 <Y9LNCouUvsUFCYkT@casper.infradead.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: kernel BUG in page_add_anon_rmap
In-Reply-To: <Y9LNCouUvsUFCYkT@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.01.23 19:57, Matthew Wilcox wrote:
> On Wed, Jan 25, 2023 at 11:59:16PM +0000, Sanan Hasanov wrote:
>> Good day, dear maintainers,
>>
>> We found a bug using a modified kernel configuration file used by syzbot.
>>
>> We enhanced the coverage of the configuration file using our tool, klocalizer.
>>
>> Kernel Branch: 6.2.0-rc5-next-20230124
>> Kernel config: https://drive.google.com/file/d/1MZSgIF4R9QfikEuF5siUIZVPce-GiJQK/view?usp=sharing
>> Reproducer: https://drive.google.com/file/d/1H5KWkT9VVMWTUVVgIaZi6J-fmukRx-BM/view?usp=sharing
>>
>> Thank you!
>>
>> Best regards,
>> Sanan Hasanov
>>
>> head: 0000000000020000 0000000000000000 00000004ffffffff ffff8881002b8000
>> page dumped because: VM_BUG_ON_PAGE(!first && (flags & (( rmap_t)((((1UL))) << (0)))))
>> ------------[ cut here ]------------
> 
> I know it says "cut here" and you did that, but including just a few
> lines above that would be so much more helpful.  I can infer that this
> is a multi-page folio, but more than that is hard to tell.
> 
>> kernel BUG at mm/rmap.c:1248!
> 
> That tracks with VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
> 
>> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>> CPU: 7 PID: 14932 Comm: syz-executor.1 Not tainted 6.2.0-rc5-next-20230124 #1
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>> RIP: 0010:page_add_anon_rmap+0xddd/0x11c0 mm/rmap.c:1248
>> Code: c0 ff 48 8b 34 24 48 89 df e8 1f ff 07 00 49 89 c6 e9 85 f6 ff ff e8 52 73 c0 ff 48 c7 c6 c0 3c d8 89 48 89 ef e8 b3 23 f8 ff <0f> 0b e8 3c 73 c0 ff 48 c7 c6 00 3b d8 89 48 89 ef e8 9d 23 f8 ff
>> RSP: 0018:ffffc9000c56f7b0 EFLAGS: 00010293
>> RAX: 0000000000000000 RBX: ffff88807efc6f30 RCX: 0000000000000000
>> RDX: ffff8880464fd7c0 RSI: ffffffff81be733d RDI: fffff520018adedb
>> RBP: ffffea0000c68080 R08: 0000000000000056 R09: 0000000000000000
>> R10: 0000000000000001 R11: 0000000000000001 R12: ffffea0000c68000
>> R13: 0000000000000001 R14: ffffea0000c68088 R15: 0000000000000000
>> FS:  00007f717898a700(0000) GS:ffff888119f80000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f7178947d78 CR3: 000000004a9e6000 CR4: 0000000000350ee0
>> Call Trace:
>>   <TASK>
>>   remove_migration_pte+0xaa6/0x1390 mm/migrate.c:261
> 
>                          if (folio_test_anon(folio))
>                                  page_add_anon_rmap(new, vma, pvmw.address,
>                                                     rmap_flags);
> 
> Earlier in that function, we had:
>                  if (folio_test_anon(folio) && !is_readable_migration_entry(entry))
>                          rmap_flags |= RMAP_EXCLUSIVE;
> 
> so that also makes sense.  We can also infer that RMAP_COMPOUND wasn't
> set, so we're trying to do just one page from the folio.
> 
> All right, back to rmap.c:
> 
>                  first = atomic_inc_and_test(&page->_mapcount);
> 
> So first is clearly false (ie _mapcount was not -1), implying somebody
> else already mapped this page.  Not really sure what's going on at
> this point.  Seems unlikely that the folio changes in
> remove_migration_pte() are responsible since they're from last January.
> Huang has some more changes to migrate.c that I don't feel qualified
> to judge.
> 
> Nothing's jumping out at me as obviously wrong.  Is it possible to
> do a bisect?

I reproduced on next-20230127 (did not try upstream yet).

I think two key things are that a) THP are set to "always" and b) we have a NUMA setup [I assume].

The relevant bits:

[  439.886738] page:00000000c4de9000 refcount:513 mapcount:2 mapping:0000000000000000 index:0x20003 pfn:0x14ee03
[  439.893758] head:000000003d5b75a4 order:9 entire_mapcount:0 nr_pages_mapped:511 pincount:0
[  439.899611] memcg:ffff986dc4689000
[  439.902207] anon flags: 0x17ffffc009003f(locked|referenced|uptodate|dirty|lru|active|head|swapbacked|node=0|zone=2|lastcpupid=0x1fffff)
[  439.910737] raw: 0017ffffc0020000 ffffe952c53b8001 ffffe952c53b80c8 dead000000000400
[  439.916268] raw: 0000000000000000 0000000000000000 0000000000000001 0000000000000000
[  439.921773] head: 0017ffffc009003f ffffe952c538b108 ffff986de35a0010 ffff98714338a001
[  439.927360] head: 0000000000020000 0000000000000000 00000201ffffffff ffff986dc4689000
[  439.932341] page dumped because: VM_BUG_ON_PAGE(!first && (flags & (( rmap_t)((((1UL))) << (0)))))


Indeed, the mapcount of the subpage is 2 instead of 1. The subpage is only mapped into a single
page table (no fork() or similar).

I created this reduced reproducer that triggers 100%:


#include <stdint.h>
#include <unistd.h>
#include <sys/mman.h>
#include <numaif.h>

int main(void)
{
	mmap((void*)0x20000000ul, 0x1000000ul, PROT_READ|PROT_WRITE|PROT_EXEC,
	     MAP_ANONYMOUS|MAP_FIXED|MAP_PRIVATE, -1, 0ul);
	madvise((void*)0x20000000ul, 0x1000000ul, MADV_HUGEPAGE);

	*(uint32_t*)0x20000080 = 0x80000;
	mlock((void*)0x20001000ul, 0x2000ul);
	mlock((void*)0x20000000ul, 0x3000ul);
	mbind((void*)0x20002000ul, 0x1000ul, MPOL_LOCAL, NULL, 0x7fful, MPOL_MF_MOVE);
	return 0;
}

We map a large-enough are for a THP and then populate a fresh anon THP (PMD mapped)
to write to it.

The first mlock() will trigger PTE-mapping the THP and mlocking that subpage.
The second mlock() seems to cause the issue. The final mbind() triggers page migration.

Removing one of the mlock() makes it work. Note that we do a double
mlock() of the same page -- the one we are then trying to migrate.

Somehow, the double mlock() of the same page seems to affect our mapcount.

CCing Hugh.

-- 
Thanks,

David / dhildenb

