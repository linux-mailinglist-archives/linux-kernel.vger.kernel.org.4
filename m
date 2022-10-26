Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867B160DE70
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 11:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbiJZJy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 05:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiJZJyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:54:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80674C7877
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 02:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666778057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x/uJi88rLYn+Jby6NBl7m6FkQ3GGLfjzxETi8/CrQyY=;
        b=iSKlby99UplZQjmmAAM5/UjZqu/nEK9KUiwbfB9PUX0jBz5Q/SqxqAOIfO8xbgZ1mKF7Xl
        1Lh4cbRjVavoVSd6ba8Moszsxt2CZVwhLU/cbIa7bHbzprUgcIHmntOFJodakRDjnPDtA4
        IiXQiHyHkLwBCOriUrSxjWrZk4Ux10c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-380-9wjYEAY1MOOUptQmaIgIjw-1; Wed, 26 Oct 2022 05:54:15 -0400
X-MC-Unique: 9wjYEAY1MOOUptQmaIgIjw-1
Received: by mail-wr1-f69.google.com with SMTP id g4-20020adfbc84000000b0022fc417f87cso5857397wrh.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 02:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/uJi88rLYn+Jby6NBl7m6FkQ3GGLfjzxETi8/CrQyY=;
        b=kBTrGe9IGnpKEGrL7zoRhASHVx/bbHu38Q8OR+Imh07pKD1md43OuNGtnM3CEqsrE6
         qD/MOZolrFXTG2BFgsCXGFYn46M3vF5+EsbzcI7qSntivGHCOaNELPMEK8wMOaHTPxUN
         meGDsBlOgCJo5oMDRaZCJAmu5GKwXUBjMNOQfqIhBjsfWyFPaalnr6GbYtIwsp/cZA5I
         Ap1BBY5qx6DTZRTc4PoTegPLIwub/sDoIsXaoDKwXQ8Nx6Di1+p6+UGzxJeOhTi4i6Eh
         du+czQD8jghPJ3yZI1YhF+zZU4Ipi1NgAayv0j8XlSCpAePFZlXoiBJ5wBOTetytKw6e
         21bA==
X-Gm-Message-State: ACrzQf0sHw6v/ZA86cUg+3phENr1/vrmxrkZsgNMZAjWp65rgELbm/R2
        j3qXRa8IOqDDVDW/+DHHK0njKW8nUpyEJ1DOzc9cFmXG+pkgsrOYZ9a3pUYzc7Pzzr+ROVQ2Ibq
        quk0BbdFgAO4oNzyoSNIL4THK
X-Received: by 2002:a1c:19c4:0:b0:3b4:a1da:76c3 with SMTP id 187-20020a1c19c4000000b003b4a1da76c3mr1802571wmz.106.1666778054387;
        Wed, 26 Oct 2022 02:54:14 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5gnhIJI5fMpEcs4UaESIX7W2jHroFsl4g/+KuAGD6//954emnet0+lEIUinuRjtWcePbZqZA==
X-Received: by 2002:a1c:19c4:0:b0:3b4:a1da:76c3 with SMTP id 187-20020a1c19c4000000b003b4a1da76c3mr1802543wmz.106.1666778054094;
        Wed, 26 Oct 2022 02:54:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:5b00:c9f4:7535:9360:70d7? (p200300cbc7065b00c9f47535936070d7.dip0.t-ipconnect.de. [2003:cb:c706:5b00:c9f4:7535:9360:70d7])
        by smtp.gmail.com with ESMTPSA id bx6-20020a5d5b06000000b00228d52b935asm5095909wrb.71.2022.10.26.02.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 02:54:13 -0700 (PDT)
Message-ID: <9a450a11-531d-8e1a-4c77-70102aa7f424@redhat.com>
Date:   Wed, 26 Oct 2022 11:54:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [syzbot] WARNING in __split_huge_page_tail
Content-Language: en-US
To:     syzbot <syzbot+273b547b15eb58ea35e8@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
References: <000000000000aa2b2805ebea9137@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <000000000000aa2b2805ebea9137@google.com>
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

On 26.10.22 08:59, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4da34b7d175d Merge tag 'thermal-6.1-rc2' of git://git.kern..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=113bd8bc880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4789759e8a6d5f57
> dashboard link: https://syzkaller.appspot.com/bug?extid=273b547b15eb58ea35e8
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161e1f62880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16dd4fe6880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a61ddb36c296/disk-4da34b7d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ceee41246252/vmlinux-4da34b7d.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+273b547b15eb58ea35e8@syzkaller.appspotmail.com
> 
>   tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:363
>   exit_mmap+0x2b1/0x670 mm/mmap.c:3098
>   __mmput+0x114/0x3b0 kernel/fork.c:1185
>   exit_mm+0x217/0x2f0 kernel/exit.c:516
>   do_exit+0x5e7/0x2070 kernel/exit.c:807
>   do_group_exit+0x1fd/0x2b0 kernel/exit.c:950
>   __do_sys_exit_group kernel/exit.c:961 [inline]
>   __se_sys_exit_group kernel/exit.c:959 [inline]
>   __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:959
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 3908 at mm/huge_memory.c:2465 __split_huge_page_tail+0x81c/0x1080 mm/huge_memory.c:2465

Is this the

VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) != -1, page_tail);

assertion?

-- 
Thanks,

David / dhildenb

