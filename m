Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE41669A785
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBQIyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBQIyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:54:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B23C60A5E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676624031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tgD2uEymDagnzBwSlUGEHk29gX9WAxjQ6+JjiZ4XaSI=;
        b=Ch65n9CbetfqpEIhT6U+FHvjTloOZQwBKiJ7I05LDgAFYSSw/J6IKlwDQOt4kk9OfO6fzo
        rqWI6/z3XccYPOUxoO43L/6flpQ59rMZhYt7QyNpao6HHct1qeeLQnhGRvk4lSn7wrOUsH
        PNMb+W5QPAeyMCYfHpkMYhb0zPxc5Ok=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-4Gn-nSPxMAihySxRJ4BX-Q-1; Fri, 17 Feb 2023 03:53:50 -0500
X-MC-Unique: 4Gn-nSPxMAihySxRJ4BX-Q-1
Received: by mail-wr1-f71.google.com with SMTP id i4-20020a5d5224000000b002c559840c76so507261wra.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:53:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgD2uEymDagnzBwSlUGEHk29gX9WAxjQ6+JjiZ4XaSI=;
        b=kb6q4RlwBW2Zy08tQaqNRzGSI/p8uzdImwu8YCR+/BAhF3YHY4u38HTtR7gq3eir/D
         Zs6TiHUS3kXG3Qb3FLvvCRSOXfq8deM7pMyk+LMOKTVoUZkTdd2MWL4aIvpZIH6kHfZg
         YCExZAf4uG2U3htGovHlIqqFc4iwoLQNe7HbmvoiaaPWpDG13RRwTG428Q+2In9U507O
         o18kFuWLlo7s/Ae08wvq/UzI5rYeKe9p67JcGbPiMaCxPw0cyIx1EOBe4PanGOLVJVns
         ESVkCvWOKNUos2WZ3T00AIKRiDz+u3FGgsEFGayGP5XR98V1i1TFzfUZNkV/mv7OHgLx
         6BLg==
X-Gm-Message-State: AO0yUKViMe21j2N3mAR5/dzeKJX+AGS5Bob4WzSteVVlJ+1HA1glxM1B
        Ex04WH5I6YmVbyqpPmjKpG5cSeXBoZWBIx1l9tfXfdj0hDI+uQUqbcEDCWXj1p5QSTuMDXoQWo+
        ZCdiXaUYiaI2/IYVosk7pyo9/KFNxMA==
X-Received: by 2002:a05:6000:180f:b0:2c6:e91d:1359 with SMTP id m15-20020a056000180f00b002c6e91d1359mr520377wrh.61.1676624029207;
        Fri, 17 Feb 2023 00:53:49 -0800 (PST)
X-Google-Smtp-Source: AK7set95a+M7/PizFBZZTVRGJDhDAH5Z0d4fwTlTuXv7W0l5qprNUlC8qglp9fDeqWRsHQsPiUimdg==
X-Received: by 2002:a05:6000:180f:b0:2c6:e91d:1359 with SMTP id m15-20020a056000180f00b002c6e91d1359mr520360wrh.61.1676624028848;
        Fri, 17 Feb 2023 00:53:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9800:59ba:1006:9052:fb40? (p200300cbc707980059ba10069052fb40.dip0.t-ipconnect.de. [2003:cb:c707:9800:59ba:1006:9052:fb40])
        by smtp.gmail.com with ESMTPSA id b11-20020adfe30b000000b002c573a6216fsm3714387wrj.37.2023.02.17.00.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 00:53:48 -0800 (PST)
Message-ID: <53dc6054-07eb-f97b-7b2f-558f02d1b90a@redhat.com>
Date:   Fri, 17 Feb 2023 09:53:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@collabora.com, Paul Gofman <pgofman@codeweavers.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230216091656.2045471-1-usama.anjum@collabora.com>
 <f4b6cd03-28d7-b041-6dd4-46ac0812fc9b@redhat.com> <Y+6RUjv/K6RkwKQ7@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 1/2] mm/userfaultfd: Support WP on multiple VMAs
In-Reply-To: <Y+6RUjv/K6RkwKQ7@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.02.23 21:25, Peter Xu wrote:
> On Thu, Feb 16, 2023 at 10:37:36AM +0100, David Hildenbrand wrote:
>> On 16.02.23 10:16, Muhammad Usama Anjum wrote:
>>> mwriteprotect_range() errors out if [start, end) doesn't fall in one
>>> VMA. We are facing a use case where multiple VMAs are present in one
>>> range of interest. For example, the following pseudocode reproduces the
>>> error which we are trying to fix:
>>> - Allocate memory of size 16 pages with PROT_NONE with mmap
>>> - Register userfaultfd
>>> - Change protection of the first half (1 to 8 pages) of memory to
>>>     PROT_READ | PROT_WRITE. This breaks the memory area in two VMAs.
>>> - Now UFFDIO_WRITEPROTECT_MODE_WP on the whole memory of 16 pages errors
>>>     out.
>>
>> I think, in QEMU, with partial madvise()/mmap(MAP_FIXED) while handling
>> memory remapping during reboot to discard pages with memory errors, it would
>> be possible that we get multiple VMAs and could not enable uffd-wp for
>> background snapshots anymore. So this change makes sense to me.
> 
> Any pointer for this one?

In qemu, softmmu/physmem.c:qemu_ram_remap() is instructed on reboot to 
remap VMAs due to MCE pages. We apply QEMU_MADV_MERGEABLE (if configured 
for the machine) and QEMU_MADV_DONTDUMP (if configured for the machine), 
so the kernel could merge the VMAs again.

(a) From experiments (~2 years ago), I recall that some VMAs won't get 
merged again ever. I faintly remember that this was the case for 
hugetlb. It might have changed in the meantime, haven't tried it again. 
But looking at is_mergeable_vma(), we refuse to merge with 
vma->vm_ops->close. I think that might be set for hugetlb 
(hugetlb_vm_op_close).

(b) We don't consider memory-backend overrides, like toggling a backend 
QEMU_MADV_MERGEABLE or QEMU_MADV_DONTDUMP from backends/hostmem.c, 
resulting in multiple unmergable VMAs.

(c) We don't consider memory-backend  mbind() we don't re-apply the 
mbind() policy, resulting in unmergable VMAs.


The correct way to handle (b) and (c) would be to notify the memory 
backend, to let it reapply the correct flags, and to reapply the mbind() 
policy (I once had patches for that, have to look them up again).

So in these rare setups with MCEs, we would be getting more VMAs and 
while the uffd-wp registration would succeed, uffd-wp protection would fail.

Not that this is purely theoretical, people don't heavily use background 
snapshots yet, so I am not aware of any reports. Further, I consider it 
only to happen very rarely (MCE+reboot+a/b/c).

So it's more of a "the app doesn't necessarily keep track of the exact 
VMAs".

[I am not sure sure how helpful remapping !anon memory really is, we 
should be getting the same messed-up MCE pages from the fd again, but 
that's a different discussion I guess]

-- 
Thanks,

David / dhildenb

