Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41CA6461E5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiLGTyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGTye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:54:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB815E3CD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 11:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670442820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aTaYB3sa4Il+5PaPzg2yGawyCbkJidScej/Ia+Ui0do=;
        b=SnmClVjOVC8SYU1AezTyG6nCtMVPjoa+46Yd1po8UEt+be78s0al16l2XlYbeUSinUx7Uq
        wSq6qr0pzV2PhVV6BrW0FKuSe7xUHJorKAKv3hnAGPdgv2uJ1crEvIQ2Ae3chiBJvZn5PX
        iBTdPUy6dyEWFKKrbX4Z+893hBq6VnE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-326-EXaduns7MhSjvAJXPUykNA-1; Wed, 07 Dec 2022 14:53:39 -0500
X-MC-Unique: EXaduns7MhSjvAJXPUykNA-1
Received: by mail-wm1-f69.google.com with SMTP id r67-20020a1c4446000000b003d09b0fbf54so1235164wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 11:53:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTaYB3sa4Il+5PaPzg2yGawyCbkJidScej/Ia+Ui0do=;
        b=SNwxHe9Sp7JV6lrMvbLOlA5lB0S2zMkKlS3kT89mBKXmsLrC6aJfTYhH/9XtyQlc4t
         EitCEuOKJZAVtDoRcdayTdXS05oqGf/apw9fbRj6vJq653F2Lpjze3B8X5DQpdqiacT0
         rd5x9nTpBsMRvEtjC/Jx1WQeBJ8ogPRvzC26O2CD4/5iZbL+m87Ky+EcBYn8XneoKn3X
         iElFwh8fOVWe1WF6HCxu4Ss7TRGKBRvtCBnLINpSLr7Rnv9XJTMc7P8+NuTIThY7t7wU
         oACZi7+zJ9i4cnKdDPgiXzUv90qkIcoOPPYMCwFSZnpYzbKFWxq8Jy9jyqHW2fzWWDl4
         G1sA==
X-Gm-Message-State: ANoB5pkFG8HNf3SSzlBcl0Z+2MvIjxH+cEQmfPT5nBRc4XK9FkWoe9CJ
        mS81X136EXDVg5/jkY3dTEEFgCqn4wChUF/sK4DTZesoR9oYslj+5pIdugNDfd2ijQO3W9XdJb+
        9zm7H4IVHy3zy/lwWavr8S4Bd
X-Received: by 2002:adf:e852:0:b0:242:2390:15c with SMTP id d18-20020adfe852000000b002422390015cmr22288516wrn.381.1670442818028;
        Wed, 07 Dec 2022 11:53:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7dos9Ed2Fzog7r6MvC5cKgX/zgKNi5bfkzd1mbQRVKTGJViHq2Wprb3XUGTPv4xA+SLw9Kjw==
X-Received: by 2002:adf:e852:0:b0:242:2390:15c with SMTP id d18-20020adfe852000000b002422390015cmr22288503wrn.381.1670442817719;
        Wed, 07 Dec 2022 11:53:37 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:2500:fe2d:7534:ffa4:c1e5? (p200300cbc7022500fe2d7534ffa4c1e5.dip0.t-ipconnect.de. [2003:cb:c702:2500:fe2d:7534:ffa4:c1e5])
        by smtp.gmail.com with ESMTPSA id f14-20020a1c6a0e000000b003cf75213bb9sm2688611wmc.8.2022.12.07.11.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 11:53:37 -0800 (PST)
Message-ID: <37a9442e-f6e5-35f5-0d51-669d60936b5f@redhat.com>
Date:   Wed, 7 Dec 2022 20:53:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ives van Hoorne <ives@codesandbox.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20221202122748.113774-1-david@redhat.com> <Y4oo6cN1a4Yz5prh@x1n>
 <690afe0f-c9a0-9631-b365-d11d98fdf56f@redhat.com>
 <19800718-9cb6-9355-da1c-c7961b01e922@redhat.com> <Y45duzmGGUT0+u8t@x1n>
 <92173bad-caa3-6b43-9d1e-9a471fdbc184@redhat.com>
 <22d8e8ac-d75-a66-2650-b4d59f89855e@google.com> <Y4+xpCRQCazCymdS@x1n>
 <be1a2244-24a8-480a-a38b-e4ebb9868ce5@redhat.com> <Y5DQrHqc7RPYWpIA@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC] mm/userfaultfd: enable writenotify while
 userfaultfd-wp is enabled for a VMA
In-Reply-To: <Y5DQrHqc7RPYWpIA@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> On upstream during the next write fault, we'll end up in do_numa_page() and
>> simply remap the page writable due to vm_page_prot, not triggering a write
>> fault. I can see the "numa_hint_faults" counter in /proc/vmstat increasing
>> accordingly, so we're really in do_numa_page().
> 
> Seems true.  I think fundamentally it's because numa hint rely on PROT_NONE
> as the hint, and it explicitly checks against mprotect(PROT_NONE) using the
> accessible check:
> 
> 	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
> 		return do_numa_page(vmf);
> 
> I'm not sure whether we should also add a pte_uffd_wp(vmf->orig_pte) here
> to mask out the uffd-wp cases.

:/ more special UFFD-wp casing, I'm not sure sure about that.

Most importantly, once someone unlocks NUMA hinting for shmem (e.g., 
MPOL_MF_LAZY, MPOL_F_NUMA_BALANCING) this might be problematic. That at 
least makes it sound fragile to me.

> 
> So far it seems the outcome is not extremely bad - PROT_WRITE only mappings
> are rare in real life, and also with the protnone recovery code (and along
> with the vm_page_prot patch coming) we'll be able to still recover the pte
> into a uffd-wp-ed pte without PROTNONE bit set.  But I don't have a solid
> clue yet on what's the best.
> 

Yes, just another way to trigger surprise uffd-wp behavior (at least 
surprising for me ;) ). But this time, not involving mprotect(). I 
suspect there are more cases, but I might be wrong.

I was primarily trying to find out which other cases might be affected.

[..]

>>
>>
>> Independent of uffd-wp on shmem, we seem to be missing propagating the
>> uffd-wp bit when splitting the huge zeropage. So uffd-wp'ing the huge
>> zeropage and then splitting it loses the uffd-wp markers. :/
> 
> For this one, thanks for the reproducer.  I'm not extremely sure whether
> it's a bug.
> 
> Firstly, I think your reproducer should just work well with shmem, afaiu,
> because shmem is based on pte markers and it should only work on pte level
> (not pmd).  The huge zero pmd should got split right after wr-protected.
> So the reproducer shouldn't go wrong on shmem at all with/without any
> recent fix.  Let me know otherwise.

shmem doesn't use the huge shared zeropage, so it should be fine.

> 
> For anon, I'm not sure it's a bug, because there's a semantic difference on
> anon/shmem.  The thing is losing wr-protect on the zero page is the same as
> losing wr-protect on a page that is not mapped.  For anon currently we
> can't track a page that is not mapped and we skip those ranges (being zero
> when read).  So fundamentally I am not sure whether it'll be an issue for
> existing anon uffd-wp users because if it is then it's more than zero
> pages.

I think it's a bug, although most probably a low priority one.

Once user space successfully placed an uffd-wp marker, and e.g., 
verified using pagemap that it is indeed placed, the system should not 
silently drop it.

The behavior between an ordinary THP and a huge zeropage differs. For 
THP, we handle the split correctly and don't lose the marker. Assuming 
the huge zeropage woud be disabled, the behavior would be (IMHO) 
correct. The test case would pass.

For example, QEMU with uffd-wp based snapshotting will make sure that 
all virtual addresses are populated (e.g., mapping the shared, 
eventually the huge zeropage -- populate_read_range()), before 
protecting using uffd-wp. Losing a uffd-wp marker would be problematic.

The good news is that we barely will end up PTE-mapping the huge 
zeropage unless there is real user-space interaction (mprotect(), 
mremap(), mmap()), so this shouldn't trigger in the QEMU use-case.


Anyhow, I'll send a patch in a couple of days and we can discuss 
further. It's independent of the other discussion, just wanted to report 
my findings after staring at that code for way too long today.

-- 
Thanks,

David / dhildenb

