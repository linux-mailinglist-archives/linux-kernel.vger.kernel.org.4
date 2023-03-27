Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7876C9E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjC0IwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjC0Ivx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:51:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DEC65B0;
        Mon, 27 Mar 2023 01:47:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BC1F321B2E;
        Mon, 27 Mar 2023 08:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679906567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZKboqUHI/6gJOZvhB30fR9xntPa2QoVQjkmdLgpJsA=;
        b=dPS5YBD8q1EdTV+vU47/4eO7xmkxnK1BKk+ZfLUsqg38SBUSyHLd1oIFdVhJ1HguaNhcFY
        nKW2g1dglGbmvtMlIXXgnwYBsNyWStSmcH4ezSJWrYvOzbgmK7jWfOxd2fXi6ZBveB9Azo
        sr2cySZgETinBo+jOsiH+2ufY/M+Oz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679906567;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZKboqUHI/6gJOZvhB30fR9xntPa2QoVQjkmdLgpJsA=;
        b=Py296J0/E9moC1pQe0cbN+LozO2SckLVlx9RkdU9LSck0s9namJ8JA9HjY5eQYZLG/iFJj
        IZIuGhjPYfMK6mCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9314213329;
        Mon, 27 Mar 2023 08:42:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dRRJIgdXIWQyTAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 27 Mar 2023 08:42:47 +0000
Message-ID: <098c59e8-166c-ffa6-2742-9c7d32faa5e7@suse.cz>
Date:   Mon, 27 Mar 2023 10:42:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [syzbot] linux-next test error: general protection fault in
 vma_merge
To:     syzbot <syzbot+a2fd5af4a33891110a79@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
References: <000000000000c0822e05f7d9812d@google.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <000000000000c0822e05f7d9812d@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/23 05:40, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7c4a254d78f8 Add linux-next specific files for 20230323

Known issue already fixed in newer -next.

> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15f70246c80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=20fd034702e6edd2
> dashboard link: https://syzkaller.appspot.com/bug?extid=a2fd5af4a33891110a79
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/dc0bbbecd2a5/disk-7c4a254d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6b2c8c7cfd4b/vmlinux-7c4a254d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ae312a388585/bzImage-7c4a254d.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a2fd5af4a33891110a79@syzkaller.appspotmail.com
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000018: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x00000000000000c0-0x00000000000000c7]
> CPU: 1 PID: 5080 Comm: syz-fuzzer Not tainted 6.3.0-rc3-next-20230323-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
> RIP: 0010:vma_merge+0x234/0x1fd0 mm/mmap.c:952
> Code: 08 00 0f 84 b0 03 00 00 e8 e9 54 bf ff 48 8b 44 24 08 48 8d b8 a8 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 4d 18 00 00 48 8b 44 24 08 48 8b b0 a8 00 00 00
> RSP: 0018:ffffc90003d0f998 EFLAGS: 00010207
> RAX: dffffc0000000000 RBX: ffff88802974b800 RCX: 0000000000000000
> RDX: 0000000000000018 RSI: ffffffff81c37957 RDI: 00000000000000c7
> RBP: ffff888079aaa400 R08: 0000000000000006 R09: 0000000000000000
> R10: 000000c001ffffff R11: 0000000000000000 R12: 0000000000000001
> R13: 0000000000000000 R14: 000000c002000000 R15: 0000000000000000
> FS:  000000c000524890(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fe510676000 CR3: 00000000249a5000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  madvise_update_vma+0x23f/0xd40 mm/madvise.c:153
>  madvise_vma_behavior+0x7f6/0x20e0 mm/madvise.c:1091
>  madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1260
>  do_madvise.part.0+0x193/0x470 mm/madvise.c:1439
>  do_madvise mm/madvise.c:1452 [inline]
>  __do_sys_madvise mm/madvise.c:1452 [inline]
>  __se_sys_madvise mm/madvise.c:1450 [inline]
>  __x64_sys_madvise+0x117/0x150 mm/madvise.c:1450
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x46b557
> Code: 8b 24 24 48 8b 6c 24 10 48 83 c4 18 c3 cc cc cc cc cc cc 48 8b 7c 24 08 48 8b 74 24 10 8b 54 24 18 48 c7 c0 1c 00 00 00 0f 05 <89> 44 24 20 c3 cc cc cc cc 48 8b 7c 24 08 8b 74 24 10 8b 54 24 14
> RSP: 002b:000000c00022de60 EFLAGS: 00000206 ORIG_RAX: 000000000000001c
> RAX: ffffffffffffffda RBX: 0000000000a12000 RCX: 000000000046b557
> RDX: 000000000000000e RSI: 0000000000800000 RDI: 000000c001c00000
> RBP: 000000c00022de88 R08: 0000000000000509 R09: 000000c001b6a000
> R10: 00000000000012bd R11: 0000000000000206 R12: 0000000000000509
> R13: 0000000000000003 R14: 000000c0003f1a00 R15: 00000000010e0700
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:vma_merge+0x234/0x1fd0 mm/mmap.c:952
> Code: 08 00 0f 84 b0 03 00 00 e8 e9 54 bf ff 48 8b 44 24 08 48 8d b8 a8 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 4d 18 00 00 48 8b 44 24 08 48 8b b0 a8 00 00 00
> RSP: 0018:ffffc90003d0f998 EFLAGS: 00010207
> RAX: dffffc0000000000 RBX: ffff88802974b800 RCX: 0000000000000000
> RDX: 0000000000000018 RSI: ffffffff81c37957 RDI: 00000000000000c7
> RBP: ffff888079aaa400 R08: 0000000000000006 R09: 0000000000000000
> R10: 000000c001ffffff R11: 0000000000000000 R12: 0000000000000001
> R13: 0000000000000000 R14: 000000c002000000 R15: 0000000000000000
> FS:  000000c000524890(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000564702bbb078 CR3: 00000000249a5000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	08 00                	or     %al,(%rax)
>    2:	0f 84 b0 03 00 00    	je     0x3b8
>    8:	e8 e9 54 bf ff       	callq  0xffbf54f6
>    d:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
>   12:	48 8d b8 a8 00 00 00 	lea    0xa8(%rax),%rdi
>   19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>   20:	fc ff df
>   23:	48 89 fa             	mov    %rdi,%rdx
>   26:	48 c1 ea 03          	shr    $0x3,%rdx
> * 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
>   2e:	0f 85 4d 18 00 00    	jne    0x1881
>   34:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
>   39:	48 8b b0 a8 00 00 00 	mov    0xa8(%rax),%rsi
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 

