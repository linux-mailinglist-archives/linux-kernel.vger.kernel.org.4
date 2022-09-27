Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F755EB93C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 06:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiI0Ece (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 00:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiI0Ecb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 00:32:31 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0798FD57
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 21:32:30 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1280590722dso11896822fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 21:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=FDQFIFZmEpESx0NkqzxjgqXPNxrdAestfMo8AUyrMOE=;
        b=kULZoJlDicz0Mvl7mbueMpEQ5yYYEMcP3Z1fjIcQYDrqIP66UvDEW6JosIoYafCqDL
         srhWW0XYZfRoFAA520ocChY69AvOV1Y+7Dk02s1Es0dLOD5HNoWIPI7OI863/2Wn709c
         waqECJLYGI/dcCK48Mnr1b0kaLzsSjH60YXr9YVNhUhLTAAXC1Sbs5aYL3H+WqEi5o2e
         DI/ZKWquZ/ZR0OrwQT7dZvIDy7rzvvH62f4L0SFNTVmkaggtNjViT1BbbifFbIi2fcnI
         W4e4Op1Kn8NMW5XwhtTyKmH2LqEy823o4fhRAhy0kx8KE49Ei+ey4oi61uZ7HWvXGNoB
         DPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=FDQFIFZmEpESx0NkqzxjgqXPNxrdAestfMo8AUyrMOE=;
        b=YLZnFTjQsYQNaIYRhUkO4TiroXkeV0b9i/LSS88ZI3V9j05Ddb8Cm4s8iNVv6iO95j
         Ew4sKyJcboJwj7/jXcOdOJCQpXKE6fZSTM5PqkMkbwtz019TNtlt9KpkReLmI3piWvMS
         ca4Vj8EoeDtUPDKlTUbqU00Ojm2fsRTfnnA4t/sLMDA28YRJpJHIbhPTESP1typERglL
         AMSZeZUodOaRuRCmOTZzSv2P7O94YQhEYh5xYYeNntqKIbnzsUPtTitHsT/OXHuCP9NL
         whpLLDWWQg+m0fcb5kb3MU52PSiv1AgCOdcCjhyMLIDCMCpHH5ioZRxJyeW227wAffwh
         6JBQ==
X-Gm-Message-State: ACrzQf33QXmaR1Hu4ny5QgwPG0drdnevLruz0dYvlTyJRj2GbyCH0ni0
        jLkp2wFe6VoO5dCpDsXENicFyQ==
X-Google-Smtp-Source: AMsMyM6cIE/LRH032XT9mtZiYlLXaS3kgkwA4uIfynJ/ZZ0iX27yHrL7c1y+I6nQ/GCBvjpf+QYogQ==
X-Received: by 2002:a05:6870:529:b0:130:b1cd:f6f8 with SMTP id j41-20020a056870052900b00130b1cdf6f8mr1108784oao.55.1664253149830;
        Mon, 26 Sep 2022 21:32:29 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r5-20020acac105000000b0034ffacec0basm156663oif.15.2022.09.26.21.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 21:32:29 -0700 (PDT)
Date:   Mon, 26 Sep 2022 21:32:16 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Matthew Wilcox <willy@infradead.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        syzbot <syzbot+152d76c44ba142f8992b@syzkaller.appspotmail.com>,
        Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        songmuchun@bytedance.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, vishal.moola@gmail.com, peterx@redhat.com
Subject: Re: [syzbot] general protection fault in PageHeadHuge
In-Reply-To: <Yy988Jv7/28k8l5x@casper.infradead.org>
Message-ID: <8bad8f70-b5a2-8f36-d7a-db78e4465820@google.com>
References: <0000000000006c300705e95a59db@google.com> <Yy4g/BKpnJga1toG@monkey> <Yy988Jv7/28k8l5x@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2022, Matthew Wilcox wrote:
> On Fri, Sep 23, 2022 at 02:11:24PM -0700, Mike Kravetz wrote:
> > On 09/23/22 09:05, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    483fed3b5dc8 Add linux-next specific files for 20220921
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=16f0a418880000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=849cb9f70f15b1ba
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=152d76c44ba142f8992b
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b97b64880000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11fb9040880000
> > > 
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/1cb3f4618323/disk-483fed3b.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/cc02cb30b495/vmlinux-483fed3b.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+152d76c44ba142f8992b@syzkaller.appspotmail.com
> > > 
> > > general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> > > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> > > CPU: 1 PID: 3617 Comm: syz-executor722 Not tainted 6.0.0-rc6-next-20220921-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/16/2022
> > > RIP: 0010:PagePoisoned include/linux/page-flags.h:304 [inline]
> > > RIP: 0010:PageHead include/linux/page-flags.h:787 [inline]
> > > RIP: 0010:PageHeadHuge+0x1d/0x200 mm/hugetlb.c:1892
> > > Code: ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 41 54 55 48 89 fd 53 e8 54 c9 b9 ff 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 a2 01 00 00 48 8b 5d 00 48 c7 c7 ff ff ff ff 48
> > > RSP: 0018:ffffc90003e7f5a0 EFLAGS: 00010246
> > > RAX: dffffc0000000000 RBX: ffffc90003e7f788 RCX: 0000000000000000
> > > RDX: 0000000000000000 RSI: ffffffff81c2cb2c RDI: 0000000000000000
> > > RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000001 R12: ffffc90003e7f798
> > > R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000003f4
> > > FS:  00007f5642262700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00000000203f4ef0 CR3: 000000007adcc000 CR4: 00000000003506e0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  folio_test_hugetlb include/linux/page-flags.h:831 [inline]
> > >  folio_file_page include/linux/pagemap.h:683 [inline]
> > >  shmem_fault+0x27c/0x8a0 mm/shmem.c:2130
> > >  __do_fault+0x107/0x600 mm/memory.c:4191
> > >  do_shared_fault mm/memory.c:4597 [inline]
> > >  do_fault mm/memory.c:4675 [inline]
> > >  handle_pte_fault mm/memory.c:4943 [inline]
> > >  __handle_mm_fault+0x2200/0x3a40 mm/memory.c:5085
> > >  handle_mm_fault+0x1c8/0x780 mm/memory.c:5206
> > >  do_user_addr_fault+0x475/0x1210 arch/x86/mm/fault.c:1428
> > >  handle_page_fault arch/x86/mm/fault.c:1519 [inline]
> > >  exc_page_fault+0x94/0x170 arch/x86/mm/fault.c:1575
> > >  asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
> > > RIP: 0010:__put_user_nocheck_4+0x3/0x11
> > > Code: 00 00 48 39 d9 73 54 0f 01 cb 66 89 01 31 c9 0f 01 ca c3 0f 1f 44 00 00 48 bb fd ef ff ff ff 7f 00 00 48 39 d9 73 34 0f 01 cb <89> 01 31 c9 0f 01 ca c3 66 0f 1f 44 00 00 48 bb f9 ef ff ff ff 7f
> > > RSP: 0018:ffffc90003e7fa00 EFLAGS: 00050293
> > > RAX: 0000000000000000 RBX: ffffc90003e7fdf4 RCX: 00000000203f4ef0
> > > RDX: ffff888020c51d40 RSI: ffffffff8726d52f RDI: 0000000000000005
> > > RBP: ffffc90003e7fdb0 R08: 0000000000000005 R09: 0000000000000000
> > > R10: 0000000000000002 R11: 0000000000000001 R12: 0000000000000000
> > > R13: 0000000000000002 R14: 00000000203f4ef0 R15: 0000000000000000
> > >  ____sys_recvmsg+0x3ba/0x610 net/socket.c:2714
> > >  ___sys_recvmsg+0xf2/0x180 net/socket.c:2743
> > >  do_recvmmsg+0x25e/0x6e0 net/socket.c:2837
> > >  __sys_recvmmsg net/socket.c:2916 [inline]
> > >  __do_sys_recvmmsg net/socket.c:2939 [inline]
> > >  __se_sys_recvmmsg net/socket.c:2932 [inline]
> > >  __x64_sys_recvmmsg+0x20b/0x260 net/socket.c:2932
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > RIP: 0033:0x7f56422dabb9
> > > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007f5642262208 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
> > > RAX: ffffffffffffffda RBX: 00007f564235c4b8 RCX: 00007f56422dabb9
> > > RDX: 0000000000010106 RSI: 00000000200000c0 RDI: 0000000000000003
> > > RBP: 00007f564235c4b0 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000002 R11: 0000000000000246 R12: 00007f564235c4bc
> > > R13: 00007fffbde3618f R14: 00007f5642262300 R15: 0000000000022000
> > >  </TASK>
> > > Modules linked in:
> > > ---[ end trace 0000000000000000 ]---
> > 
> > While it is true that the addressing exception is happening in the hugetlb
> > routine PageHeadHuge(), the reason is because it is passed a NULL page
> > pointer.  This is via the call to folio_file_page() at the end of shmem_fault.
> > 
> > 	err = shmem_get_folio_gfp(inode, vmf->pgoff, &folio, SGP_CACHE,
> > 				  gfp, vma, vmf, &ret);
> > 	if (err)
> > 		return vmf_error(err);
> > 
> > 	vmf->page = folio_file_page(folio, vmf->pgoff);
> > 	return ret;
> > 
> > The code assumes that if a non-zero value is returned from shmem_get_folio_gfp,
> > then folio pointer will be set to a folio.  However, it looks like there are
> > a few places in shmem_get_folio_gfp where it will return zero and not set
> > folio.
> > 
> > In this specific case, it is the code block:
> > 
> >         if (vma && userfaultfd_missing(vma)) {
> >                 *fault_type = handle_userfault(vmf, VM_UFFD_MISSING);
> >                 return 0;
> >         }
> > 
> > I could try to sort this out, but I believe Matthew has the most context as
> > he has been changing this code recently.
> 
> Vishal sent me a patch a few days ago, but I was on holiday so haven't
> seen it until now.
> 
> From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
> To: willy@infradead.org
> Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
> Subject: [PATCH 1/1] Fix an issue in shmem_fault()
> Date: Wed, 21 Sep 2022 17:38:56 -0700
> Message-Id: <20220922003855.23411-2-vishal.moola@gmail.com>
> X-Mailer: git-send-email 2.36.1
> In-Reply-To: <20220922003855.23411-1-vishal.moola@gmail.com>
> References: <20220922003855.23411-1-vishal.moola@gmail.com>
> 
> If shmem_get_folio_gfp returns 0 AND does not assign folio,
> folio_file_page() runs into issues. Make sure to assign vmf->page only
> if a folio is assigned, otherwise set it to NULL.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Hugh Dickins <hughd@google.com>

Peter, thank you for reviewing and advising and testing mine, and
Andrew, thank you for taking it into mm-unstable.  But I think that
since Vishal sent his first, thank you, it is his that should go in.

Me, I tend to avoid an "else", but that's not a very good reason to
prefer mine.  If, in my ignorance, I'd been right about userfaultfd
setting vmf->page, then mine would have been the right patch; but
Peter showed I was wrong on that, so Vishal's seems slightly the better.

Matthew, please send Vishal's with your signoff on to Andrew;
or I can do so (mutatis mutandis) if you prefer.

Thanks,
Hugh

> ---
>  mm/shmem.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d6921b8e2cb5..986c07362eab 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2060,7 +2060,7 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct inode *inode = file_inode(vma->vm_file);
>  	gfp_t gfp = mapping_gfp_mask(inode->i_mapping);
> -	struct folio *folio;
> +	struct folio *folio = NULL;
>  	int err;
>  	vm_fault_t ret = VM_FAULT_LOCKED;
>  
> @@ -2127,7 +2127,10 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
>  				  gfp, vma, vmf, &ret);
>  	if (err)
>  		return vmf_error(err);
> -	vmf->page = folio_file_page(folio, vmf->pgoff);
> +	if (folio)
> +		vmf->page = folio_file_page(folio, vmf->pgoff);
> +	else
> +		vmf->page = NULL;
>  	return ret;
>  }
>  
> -- 
> 2.36.1
