Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5996E70B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 03:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjDSBRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 21:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDSBRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 21:17:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1A52109
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 18:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681867001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOBnveSOjqfldaC+dMN0HauptgWXOYKbnsQgtF4Vvns=;
        b=ZKD3JXXKdERWFppGqICEzSE8/WUf+oZ4nFanggDQEzxDmF5+8Gyz+tzt2ZyOD3FiowXTo7
        iNhd9jKYseSvstYh58Nf9PVydpm6CoATDJONRa9zDZIyUiE3jdq0f27Bfdqv32n9uuVTFP
        9nmbkVaO4e7DdhkeJ3T88Yv0p7XWriA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-MoQpVtKQN_iYCgFYAlw6uQ-1; Tue, 18 Apr 2023 21:16:38 -0400
X-MC-Unique: MoQpVtKQN_iYCgFYAlw6uQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 061DC101A531;
        Wed, 19 Apr 2023 01:16:38 +0000 (UTC)
Received: from [10.22.34.98] (unknown [10.22.34.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6816400DC9;
        Wed, 19 Apr 2023 01:16:37 +0000 (UTC)
Message-ID: <6c3c68b1-c4d4-dd82-58e8-f7013fb6c8e5@redhat.com>
Date:   Tue, 18 Apr 2023 21:16:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mm/mmap: Map MAP_STACK to VM_STACK
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joe Mario <jmario@redhat.com>,
        Barry Marson <bmarson@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
References: <20230418210230.3495922-1-longman@redhat.com>
 <20230418141852.75e551e57e97f4b522957c5c@linux-foundation.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230418141852.75e551e57e97f4b522957c5c@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/18/23 17:18, Andrew Morton wrote:
> On Tue, 18 Apr 2023 17:02:30 -0400 Waiman Long <longman@redhat.com> wrote:
>
>> One of the flags of mmap(2) is MAP_STACK to request a memory segment
>> suitable for a process or thread stack. The kernel currently ignores
>> this flags. Glibc uses MAP_STACK when mmapping a thread stack. However,
>> selinux has an execstack check in selinux_file_mprotect() which disallows
>> a stack VMA to be made executable.
>>
>> Since MAP_STACK is a noop, it is possible for a stack VMA to be merged
>> with an adjacent anonymous VMA. With that merging, using mprotect(2)
>> to change a part of the merged anonymous VMA to make it executable may
>> fail. This can lead to sporadic failure of applications that need to
>> make those changes.
> "Sporadic failure of applications" sounds quite serious.  Can you
> provide more details?

The problem boils down to the fact that it is possible for user code to 
mmap a region of memory and then for the kernel to merge the VMA for 
that memory with the VMA for one of the application's thread stacks. 
This is causing random SEGVs with one of our large customer application.

At a high level, this is what's happening:

  1) App runs creating lots of threads.
  2) It mmap's 256K pages of anonymous memory.
  3) It writes executable code to that memory.
  4) It calls mprotect() with PROT_EXEC on that memory so
     it can subsequently execute the code.

The above mprotect() will fail if the mmap'd region's VMA gets merged 
with the VMA for one of the thread stacks.  That's because the default 
RHEL SELinux policy is to not allow executable stacks.

>
> Did you consider a -stable backport?  I'm unable to judge, because the
> description of the userspace effects is so thin,

Yes, stable backport can be considered.


>
>> One possible fix is to make sure that a stack VMA will not be merged
>> with a non-stack anonymous VMA. That requires a vm flag that can be
>> used to distinguish a stack VMA from a regular anonymous VMA. One
>> can add a new dummy vm flag for that purpose. However, there is only
>> 1 bit left in the lower 32 bits of vm_flags. Another alternative is
>> to use an existing vm flag. VM_STACK (= VM_GROWSDOWN for most arches)
>> can certainly be used for this purpose. The downside is that it is a
>> slight change in existing behavior.
>>
>> Making a stack VMA growable by default certainly fits the need of a
>> process or thread stack. This patch now maps MAP_STACK to VM_STACK to
>> prevent unwanted merging with adjacent non-stack VMAs and make the VMA
>> more suitable for being used as a stack.
>>
>> ...
>>
>> --- a/include/linux/mman.h
>> +++ b/include/linux/mman.h
>> @@ -152,6 +152,7 @@ calc_vm_flag_bits(unsigned long flags)
>>   	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
>>   	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
>>   	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
>> +	       _calc_vm_trans(flags, MAP_STACK,	     VM_STACK     ) |
>>   	       arch_calc_vm_flag_bits(flags);
>>   }
> The mmap(2) manpage says
>
>    This flag is currently a no-op on Linux.  However, by employing
>    this flag, applications can ensure that they transparently ob- tain
>    support if the flag is implemented in the future.  Thus, it is used
>    in the glibc threading implementation to allow for the fact that some
>    architectures may (later) require special treat- ment for stack
>    allocations.  A further reason to employ this flag is portability:
>    MAP_STACK exists (and has an effect) on some other systems (e.g.,
>    some of the BSDs).
>
> so please propose an update for this?

OK, will do.

Thanks,
Longman

