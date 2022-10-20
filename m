Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D726061FA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiJTNke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiJTNkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:40:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218B0895D8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666273208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+D6nA/RQiM0r0D/mARVrqa4K36zvZYDKZGfaNnuym3E=;
        b=V1KuvcQ/W0wc+b7IMBYT6Fc4B4/kDE50RDfFE29vFqtvGJAHbsjbfHfT+rA26TxDC+Z+5d
        voDNXEtCxfLWQAVFgVNBLJsjbZgWVdJzWElEAV0qnj4Uxx25TOEKTZBarOWBcJUnxle9TN
        JuLFzAqJ4UlVtQsNbczzDUzkFTX/yAQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-362-T-3XQPfJPGaIs0S2odga7Q-1; Thu, 20 Oct 2022 09:40:07 -0400
X-MC-Unique: T-3XQPfJPGaIs0S2odga7Q-1
Received: by mail-wm1-f72.google.com with SMTP id v125-20020a1cac83000000b003bd44dc5242so1668913wme.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+D6nA/RQiM0r0D/mARVrqa4K36zvZYDKZGfaNnuym3E=;
        b=2DECDfn/K+Dy1TnMcy85Ifc2j/KYUGYfNHM5IEBWot2WW6Neymr+5xKh1aPzbVEiT4
         v1wzO3zmiCdWvNdp4t7143SEKAR3dpgjeX9M4MS7ZR0ZzDQcLFIohlATH8YP+6h7pe1l
         4qYBH1K3pdvOv/upjeo9LKvZ2CtspK93nzCLnpyOfdJy9fx3wG8nOBlHPzejOU5zEUW1
         yuHP2Vb9v7zktRnaCCxWXabGhYMQfPFMeE+cjijsqQ874TwF5NN5VBOGBwuEv5koaFDG
         AmnVItXCS6jsPUb0zfClUZ3kk95UE3zX9nFuvEot3+Hoh28euDyrl/K8SryqvoVR24uV
         Fpiw==
X-Gm-Message-State: ACrzQf3me7ZtMkd005rY2NonC52mXrzBuw3vlMEogJTPM4cqg1jVv+XN
        QksWIiJCFqnIls4FZCr/9VOOmeN0gsOLLUtcEaZ9HcN7cKZ1jS01+7Ld4KwD4m/w2LBxCxpjV8b
        aCcxdioacuwuGKHWMCn9ni4NP
X-Received: by 2002:a05:600c:4187:b0:3c6:fe18:b2a with SMTP id p7-20020a05600c418700b003c6fe180b2amr9621713wmh.41.1666273205768;
        Thu, 20 Oct 2022 06:40:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM42nI09Zx7JuDUjpO4oyn2J5zgyhZGpscOA3OtP8FeaJC+wi15pHAgOxE66WxMmfgyAKAJCdQ==
X-Received: by 2002:a05:600c:4187:b0:3c6:fe18:b2a with SMTP id p7-20020a05600c418700b003c6fe180b2amr9621682wmh.41.1666273205186;
        Thu, 20 Oct 2022 06:40:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:b100:1443:78d5:341f:c97a? (p200300cbc708b100144378d5341fc97a.dip0.t-ipconnect.de. [2003:cb:c708:b100:1443:78d5:341f:c97a])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c3b0600b003c6c2ff7f25sm3349651wms.15.2022.10.20.06.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:40:04 -0700 (PDT)
Message-ID: <c2cf3416-f762-3949-d97c-47dbbc2c6689@redhat.com>
Date:   Thu, 20 Oct 2022 15:40:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in
 break_ksm
Content-Language: en-US
To:     syzbot <syzbot+78a0878b3076f71313b3@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
References: <0000000000000f3fec05eb76e68f@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <0000000000000f3fec05eb76e68f@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.10.22 14:59, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    acee3e83b493 Add linux-next specific files for 20221020
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15961f62880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c82245cfb913f766
> dashboard link: https://syzkaller.appspot.com/bug?extid=78a0878b3076f71313b3
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1255612c880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a1bed2880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/98cc5896cded/disk-acee3e83.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b3d3eb3aa10a/vmlinux-acee3e83.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+78a0878b3076f71313b3@syzkaller.appspotmail.com
> 
> BUG: sleeping function called from invalid context at mm/ksm.c:500
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3610, name: syz-executor212
> preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> INFO: lockdep is turned off.
> Preemption disabled at:
> [<0000000000000000>] 0x0
> CPU: 0 PID: 3610 Comm: syz-executor212 Not tainted 6.1.0-rc1-next-20221020-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>   __might_resched.cold+0x222/0x26b kernel/sched/core.c:9890
>   break_ksm.part.0+0xbe/0x160 mm/ksm.c:500
>   break_ksm mm/ksm.c:875 [inline]
>   unmerge_ksm_pages+0x1a0/0x240 mm/ksm.c:881
>   unmerge_and_remove_all_rmap_items mm/ksm.c:1021 [inline]
>   run_store+0x3cf/0xa30 mm/ksm.c:2983
>   kobj_attr_store+0x50/0x80 lib/kobject.c:824
>   sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:136
>   kernfs_fop_write_iter+0x3f8/0x610 fs/kernfs/file.c:330
>   call_write_iter include/linux/fs.h:2191 [inline]
>   new_sync_write fs/read_write.c:491 [inline]
>   vfs_write+0x9e9/0xdd0 fs/read_write.c:584
>   ksys_write+0x127/0x250 fs/read_write.c:637
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd


This might be due a missing page table lock unlock:

https://lkml.kernel.org/r/8c86678a-3bfb-3854-b1a9-ae5969e730b8@redhat.com

-- 
Thanks,

David / dhildenb

