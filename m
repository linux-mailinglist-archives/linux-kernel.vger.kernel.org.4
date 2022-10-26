Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FAB60E3A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiJZOqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbiJZOqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:46:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB78100BF5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666795585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9+Xbb5RQBhXFVF0gto838Senf/9nz2P5jsm5fcrSvM=;
        b=Fbq0BBYtGlYoM2a3ARjc1SLJXIe9TdFX0PxjNb1VSY7dWobBQ3tz0c71W1dT51rx9Duo38
        MEKnjb8s4UwGtfszFZEh8sZFnLvYWaqoBpcHS8QtscqaTdDS3ose6Ie+rvLuRo153sDBBT
        wSqM+19Qi51VDduNGKFavQOgRttgDEo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-344-cvnu4LigMc2WqoHc2nAi9A-1; Wed, 26 Oct 2022 10:46:24 -0400
X-MC-Unique: cvnu4LigMc2WqoHc2nAi9A-1
Received: by mail-wm1-f69.google.com with SMTP id r66-20020a1c4445000000b003cf4c205936so566035wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9+Xbb5RQBhXFVF0gto838Senf/9nz2P5jsm5fcrSvM=;
        b=Q6vleBdrs5AcajmJxh5Dz9ldoSR4M1kUCfxjCwkXxE36bSOy7zQnGLHdYSMk7EQxEj
         1UeDwUiYg4dfjINiRduJoIM3FBMcacIRCxkN9/umY/LH5KnS4KTEn6zTKP0eugogCQst
         Or8Y5yhNq6XpqJ7oh/VrQJoPCcaQ1ewIC/eLGA0M9AMJVKIDIeAGlVWxedHqRxbqhVTg
         e8DWM0t4aKoi44wF7HX98kxxy6WYfs9i8CJZDe3KiHah0UxaKMn8Btu10p0IIj/V+zg7
         DqoxNfncqpvlo7ggqsZXo2PYdPnmK3a9RNEeSPBrpcfn7Ukg9LszX/pgPeBk19/1wY2Y
         M+TA==
X-Gm-Message-State: ACrzQf1gJ2SF4r+dTP6DXh1n6fwILIYKVuqWeXH/Qsrkp4cN51HDwHj0
        qfBMKDyewAkvEL07gqSRiFsyCRnKXRzs6NiANo7rzarmwiUBnl88RC64/nW4rdPHPLw1kv0/LE0
        ARVnYBnkkgsWL3Q78ij6Pi+8m
X-Received: by 2002:adf:fb43:0:b0:22b:64:8414 with SMTP id c3-20020adffb43000000b0022b00648414mr29850895wrs.70.1666795581731;
        Wed, 26 Oct 2022 07:46:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6qzzVrO9wpr3qnIOHUcJaAfmjQ5F5tBnpRNBBzgF413+NO9Ot/9ckpUBdSy/jA4ZFu8I3Ujw==
X-Received: by 2002:adf:fb43:0:b0:22b:64:8414 with SMTP id c3-20020adffb43000000b0022b00648414mr29850881wrs.70.1666795581450;
        Wed, 26 Oct 2022 07:46:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:5b00:c9f4:7535:9360:70d7? (p200300cbc7065b00c9f47535936070d7.dip0.t-ipconnect.de. [2003:cb:c706:5b00:c9f4:7535:9360:70d7])
        by smtp.gmail.com with ESMTPSA id m17-20020a056000009100b0022eafed36ebsm5567280wrx.73.2022.10.26.07.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 07:46:20 -0700 (PDT)
Message-ID: <c17502a0-2e43-bf34-239b-1e9b0bde46db@redhat.com>
Date:   Wed, 26 Oct 2022 16:46:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [syzbot] WARNING in __split_huge_page_tail
Content-Language: en-US
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+273b547b15eb58ea35e8@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>
References: <000000000000aa2b2805ebea9137@google.com>
 <9a450a11-531d-8e1a-4c77-70102aa7f424@redhat.com>
 <CACT4Y+YTjYMWQKixhkNMuty4LXTsgBmpiYAN5ChGVXZBCyp0uA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CACT4Y+YTjYMWQKixhkNMuty4LXTsgBmpiYAN5ChGVXZBCyp0uA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.22 15:25, Dmitry Vyukov wrote:
> On Wed, 26 Oct 2022 at 02:54, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 26.10.22 08:59, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    4da34b7d175d Merge tag 'thermal-6.1-rc2' of git://git.kern..
>>> git tree:       upstream
>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=113bd8bc880000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=4789759e8a6d5f57
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=273b547b15eb58ea35e8
>>> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161e1f62880000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16dd4fe6880000
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/a61ddb36c296/disk-4da34b7d.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/ceee41246252/vmlinux-4da34b7d.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+273b547b15eb58ea35e8@syzkaller.appspotmail.com
>>>
>>>    tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:363
>>>    exit_mmap+0x2b1/0x670 mm/mmap.c:3098
>>>    __mmput+0x114/0x3b0 kernel/fork.c:1185
>>>    exit_mm+0x217/0x2f0 kernel/exit.c:516
>>>    do_exit+0x5e7/0x2070 kernel/exit.c:807
>>>    do_group_exit+0x1fd/0x2b0 kernel/exit.c:950
>>>    __do_sys_exit_group kernel/exit.c:961 [inline]
>>>    __se_sys_exit_group kernel/exit.c:959 [inline]
>>>    __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:959
>>>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>>    do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
>>>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 0 PID: 3908 at mm/huge_memory.c:2465 __split_huge_page_tail+0x81c/0x1080 mm/huge_memory.c:2465
>>
>> Is this the
>>
>> VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) != -1, page_tail);
>>
>> assertion?
> 
> Hi David,
> 
> You can check the sources for that revision, but on the dashboard
> there are clickable links for all source references:
> https://syzkaller.appspot.com/bug?extid=273b547b15eb58ea35e8
> 
> In this case it points to:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/huge_memory.c?id=4da34b7d175dc99b8befebd69e96546c960d526c#n2465
> 

Ah, thanks!

... so

	if (!folio_test_swapcache(page_folio(head))) {
		VM_WARN_ON_ONCE_PAGE(page_tail->private != 0, head);
		page_tail->private = 0;
	}

I recall that there was a patch either from Hugh or Mel floating around 
that might be related.

-- 
Thanks,

David / dhildenb

