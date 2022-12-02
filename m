Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A53640AE1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiLBQdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbiLBQdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:33:33 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34817B56D;
        Fri,  2 Dec 2022 08:33:31 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0FCC121C4A;
        Fri,  2 Dec 2022 16:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669998810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hIc9GGjidMLX67s74TxPgelqErquLYtaNNBhCjPFqvA=;
        b=MwBmd4I4d8KSktFz/t5PZovdXIqOQ5v2Zt6TQ0Df/7i7flVc8VMat/73irTERwEquJZWuM
        6ijPzkGxOpuXdJKjN7nsix4C2kjRUJUHja2j8+Xu1AxemS131SQg6jiCLzSJhvxiOi/x1l
        g8T2TpH66VWCsQku07NdRlCazSFzJVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669998810;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hIc9GGjidMLX67s74TxPgelqErquLYtaNNBhCjPFqvA=;
        b=Cv8NaFoZeePDhTQ0uNdRQTyG/d8lLH+uoet4DwRfwNTXpyWRbDGj0rorDax8+cPZeWkp9S
        l6KyAVGggKGciHBA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C423013644;
        Fri,  2 Dec 2022 16:33:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id KrwsL9koimPFLQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Fri, 02 Dec 2022 16:33:29 +0000
Message-ID: <a4bc8ee2-8db9-5ce4-630b-ab0be6b1a890@suse.cz>
Date:   Fri, 2 Dec 2022 17:33:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] mm: do not BUG_ON missing brk mapping, because userspace
 can unmap it
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Cc:     "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        SeongJae Park <sj@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Will Deacon <will@kernel.org>
References: <20221202162724.2009-1-Jason@zx2c4.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221202162724.2009-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/22 17:27, Jason A. Donenfeld wrote:
> The following program will trigger the BUG_ON that this patch removes,
> because the user can munmap() mm->brk:
> 
>   #include <sys/syscall.h>
>   #include <sys/mman.h>
>   #include <assert.h>
>   #include <unistd.h>
> 
>   static void *brk_now(void)
>   {
>     return (void *)syscall(SYS_brk, 0);
>   }
> 
>   static void brk_set(void *b)
>   {
>     assert(syscall(SYS_brk, b) != -1);
>   }
> 
>   int main(int argc, char *argv[])
>   {
>     void *b = brk_now();
>     brk_set(b + 4096);
>     assert(munmap(b - 4096, 4096 * 2) == 0);
>     brk_set(b);
>     return 0;
>   }
> 
> Compile that with musl, since glibc actually uses brk(), and then
> execute it, and it'll hit this splat:
> 
>   kernel BUG at mm/mmap.c:229!
>   invalid opcode: 0000 [#1] PREEMPT SMP
>   CPU: 12 PID: 1379 Comm: a.out Tainted: G S   U             6.1.0-rc7+ #419
>   RIP: 0010:__do_sys_brk+0x2fc/0x340
>   Code: 00 00 4c 89 ef e8 04 d3 fe ff eb 9a be 01 00 00 00 4c 89 ff e8 35 e0 fe ff e9 6e ff ff ff 4d 89 a7 20>
>   RSP: 0018:ffff888140bc7eb0 EFLAGS: 00010246
>   RAX: 0000000000000000 RBX: 00000000007e7000 RCX: ffff8881020fe000
>   RDX: ffff8881020fe001 RSI: ffff8881955c9b00 RDI: ffff8881955c9b08
>   RBP: 0000000000000000 R08: ffff8881955c9b00 R09: 00007ffc77844000
>   R10: 0000000000000000 R11: 0000000000000001 R12: 00000000007e8000
>   R13: 00000000007e8000 R14: 00000000007e7000 R15: ffff8881020fe000
>   FS:  0000000000604298(0000) GS:ffff88901f700000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000603fe0 CR3: 000000015ba9a005 CR4: 0000000000770ee0
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    do_syscall_64+0x2b/0x50
>    entry_SYSCALL_64_after_hwframe+0x46/0xb0
>   RIP: 0033:0x400678
>   Code: 10 4c 8d 41 08 4c 89 44 24 10 4c 8b 01 8b 4c 24 08 83 f9 2f 77 0a 4c 8d 4c 24 20 4c 01 c9 eb 05 48 8b>
>   RSP: 002b:00007ffc77863890 EFLAGS: 00000212 ORIG_RAX: 000000000000000c
>   RAX: ffffffffffffffda RBX: 000000000040031b RCX: 0000000000400678
>   RDX: 00000000004006a1 RSI: 00000000007e6000 RDI: 00000000007e7000
>   RBP: 00007ffc77863900 R08: 0000000000000000 R09: 00000000007e6000
>   R10: 00007ffc77863930 R11: 0000000000000212 R12: 00007ffc77863978
>   R13: 00007ffc77863988 R14: 0000000000000000 R15: 0000000000000000
>    </TASK>
> 
> Instead, just error out if the original mapping has been removed.
> 
> Fixes: 2e7ce7d354f2 ("mm/mmap: change do_brk_flags() to expand existing VMA and add do_brk_munmap()")

That's 6.1-rc1 so probably fast track to Linus as we don't need to introduce
such trivial local user DoS in 6.1, right?

> Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/mmap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index c3c5c1d6103d..f5a37fe9a19e 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -226,8 +226,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>  		/* Search one past newbrk */
>  		mas_set(&mas, newbrk);
>  		brkvma = mas_find(&mas, oldbrk);
> -		BUG_ON(brkvma == NULL);
> -		if (brkvma->vm_start >= oldbrk)
> +		if (!brkvma || brkvma->vm_start >= oldbrk)
>  			goto out; /* mapping intersects with an existing non-brk vma. */
>  		/*
>  		 * mm->brk must be protected by write mmap_lock.

