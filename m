Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C990F5FE9D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJNHy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJNHyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:54:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82F71B6C9D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 00:54:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A94A11F385;
        Fri, 14 Oct 2022 07:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665734062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YKCTjUXkgWXHelzxl7iwE9MFXdtFxf+ctoNJ6hwB31w=;
        b=d+G7iCu4/46sYKXEXRYF34PpehqY2SvKQ+zLHYaKdgh2JQdykEuqRi1cdXUZ/JfFSSwO/b
        QWprGOA4RFfRkX9+hvJM8u1ikvQlIKPl1BkIepHd92GUsBohyq6bv1KrF2utGrXc2xgvQL
        LOMoQ6aXDGjbU4yIhE/klUTllwQJvIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665734062;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YKCTjUXkgWXHelzxl7iwE9MFXdtFxf+ctoNJ6hwB31w=;
        b=rC2JV+OVOSeKfGDRmoqiyFNwGLXkJid3OiC5YuhjuebKh8UQsaMIIs0HT8wVdR9mcS/3jK
        nuK/kkmu5yLJrDAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9263713A4A;
        Fri, 14 Oct 2022 07:54:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /2MLI64VSWMMaQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 14 Oct 2022 07:54:22 +0000
Message-ID: <8ef3a72d-8719-aeaf-1a03-9b7cb1a03cc4@suse.cz>
Date:   Fri, 14 Oct 2022 09:54:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: kernel BUG in page_try_dup_anon_rmap
Content-Language: en-US
To:     Wei Chen <harperchen1110@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, hughd@google.com,
        dhowells@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <CAO4mrfdLMXsao9RF4fUE8-Wfde8xmjsKrTNMNC9wjUb6JudD0g@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAO4mrfdLMXsao9RF4fUE8-Wfde8xmjsKrTNMNC9wjUb6JudD0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 14:25, Wei Chen wrote:
> Dear Linux Developer,
> 
> Recently when using our tool to fuzz kernel, the following crash was triggered:
> 
> HEAD commit: 03c765b0e3b4 Linux 5.19-rc4

That's a rather odd version to report against, now that there's v6.0 final?
(not to mention 5.19 final, months ago) Or is v5.19-rc4 just the first
affected tag and the bug persists until v6.0?

> git tree: upstream
> compiler: clang 12.0.0
> console output:
> https://drive.google.com/file/d/16ht-2pDp_nU_nXhobMfHaQraVt4qfzBK/view?usp=sharing
> kernel config: https://drive.google.com/file/d/1lNGU17X6Ui1NDLE4XCRu3I6f9lzhCBcH/view?usp=sharing
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: Wei Chen <harperchen1110@gmail.com>
> 
> kernel BUG at include/linux/mm.h:1585!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 20332 Comm: syz-executor Not tainted 5.19.0-rc4 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:page_try_dup_anon_rmap+0x927/0x1120
> Code: e6 ff 0f 00 00 31 ff e8 87 75 b2 ff 4c 89 e0 48 25 ff 0f 00 00
> 0f 84 0e 01 00 00 e8 c3 70 b2 ff e9 43 03 00 00 e8 b9 70 b2 ff <0f> 0b
> e8 b2 70 b2 ff 4c 89 e7 48 c7 c6 80 96 9e 8a e8 03 91 ee ff
> RSP: 0018:ffffc900088e7368 EFLAGS: 00010287
> RAX: ffffffff81d29967 RBX: 0000000000000000 RCX: 0000000000040000
> RDX: ffffc900084b9000 RSI: 00000000000023c4 RDI: 00000000000023c5
> RBP: ffff88802e3a0670 R08: ffffffff81d29420 R09: fffff9400011d001
> R10: fffff9400011d001 R11: 0000000000000000 R12: ffffea00008e8000
> R13: dffffc0000000000 R14: ffff88802e3a0670 R15: 1ffff11005c740ce
> FS:  00007fa374806700(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa3737b8000 CR3: 000000002f26f000 CR4: 0000000000750ef0
> DR0: 0000000020000080 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  copy_hugetlb_page_range+0xc9d/0x1cc0
>  copy_page_range+0x424/0x1b40
>  dup_mmap+0xa72/0xf80
>  dup_mm+0x8c/0x310
>  copy_process+0x2b3b/0x60d0
>  kernel_clone+0x21a/0x7d0
>  __do_sys_fork+0x9e/0xf0
>  do_syscall_64+0x3d/0x90
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7fa373695c4d
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fa374805c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000039
> RAX: ffffffffffffffda RBX: 00007fa3737bc0a0 RCX: 00007fa373695c4d
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 00007fa37370ed80 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa3737bc0a0
> R13: 00007ffc0a3c127f R14: 00007ffc0a3c1420 R15: 00007fa374805dc0
>  </TASK>
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:page_try_dup_anon_rmap+0x927/0x1120
> Code: e6 ff 0f 00 00 31 ff e8 87 75 b2 ff 4c 89 e0 48 25 ff 0f 00 00
> 0f 84 0e 01 00 00 e8 c3 70 b2 ff e9 43 03 00 00 e8 b9 70 b2 ff <0f> 0b
> e8 b2 70 b2 ff 4c 89 e7 48 c7 c6 80 96 9e 8a e8 03 91 ee ff
> RSP: 0018:ffffc900088e7368 EFLAGS: 00010287
> RAX: ffffffff81d29967 RBX: 0000000000000000 RCX: 0000000000040000
> RDX: ffffc900084b9000 RSI: 00000000000023c4 RDI: 00000000000023c5
> RBP: ffff88802e3a0670 R08: ffffffff81d29420 R09: fffff9400011d001
> R10: fffff9400011d001 R11: 0000000000000000 R12: ffffea00008e8000
> R13: dffffc0000000000 R14: ffff88802e3a0670 R15: 1ffff11005c740ce
> FS:  00007fa374806700(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa3737b8000 CR3: 000000002f26f000 CR4: 0000000000750ef0
> DR0: 0000000020000080 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> PKRU: 55555554
> 
> Best,
> Wei

