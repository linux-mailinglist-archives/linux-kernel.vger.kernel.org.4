Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7294A5E86D8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiIXA6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIXA6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782AD1205B3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663981091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LXS8AXAm70UR1+lqvfWA9CpMJuVPfWH77f8iEGHbcYU=;
        b=UtQBw+z4zz8tK8sJOSZB5uLvrGAdscUgI0vYhQ8N04utbgg9jW+3iSlSwB++DAG8PjHt6L
        7f4wr9x3ZDDZ0+W6iCrcbmHUljJ/v4Q38ug2izb7kAkyti8o7kgl4H5+MCpS6Vmb0P/Uc4
        zYc8sF3x6A5ugxW6am4LvoR9oWDOlDU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-665-kEkRF8lTNziA8sXMnYgiVw-1; Fri, 23 Sep 2022 20:58:10 -0400
X-MC-Unique: kEkRF8lTNziA8sXMnYgiVw-1
Received: by mail-qk1-f197.google.com with SMTP id bk21-20020a05620a1a1500b006be9f844c59so1166541qkb.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=LXS8AXAm70UR1+lqvfWA9CpMJuVPfWH77f8iEGHbcYU=;
        b=5EsA4ZO6dXmMtMgPAIMBwHa0CoDZXntf1HzGa7X3Y+Jpcm/5sfrJu7gXJZC8QaP5xh
         ousmwlw7ky/wSA+tfa2WWtMgdIT6yWLJTCh8ZPp2dndRBF4Rh+N5YDcJMx3eyL4ksINT
         qDVDIWEs1c+eKCUZCOxZ9qzv3O36Fy3TbBFfdbctfv6HFGaCDAAXong+mkf9379InRyW
         IUII4slY3UdLQRbUzVXyVkFiYD7ne7KPM7E0++wQksrFuTj/OInNX+eEDeMo3UAn2exl
         CnGFTmDk7ToEaYI01uHsgsaHWu7dTcAmPPohy1Va2sT+VMwZ+GL/aA2XjTCQvcsDYz7p
         LEBw==
X-Gm-Message-State: ACrzQf0fw/zdRhe1GlrwBD7KTOtimJuEujiLTtM/tFo72gNb5/YHPlFB
        1GgdZnYariZt3Bn9123r1n08mUeptG1u73ePkUE1vpOT1LXDAggt29nModDSGCRX8d+nUwJgXvm
        hId41EVk8DEE4fRr2t4EIBUBa
X-Received: by 2002:ac8:5ac1:0:b0:35b:bb64:b3c6 with SMTP id d1-20020ac85ac1000000b0035bbb64b3c6mr9251271qtd.119.1663981089413;
        Fri, 23 Sep 2022 17:58:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7rKrZOS2HXeamXk7XMBxU/F6ql1HdkediOxsopPNKkUNQyYuuwz296uSEgyBtcgrnVTUogZA==
X-Received: by 2002:ac8:5ac1:0:b0:35b:bb64:b3c6 with SMTP id d1-20020ac85ac1000000b0035bbb64b3c6mr9251261qtd.119.1663981089154;
        Fri, 23 Sep 2022 17:58:09 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a424f00b006af0ce13499sm6833555qko.115.2022.09.23.17.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 17:58:08 -0700 (PDT)
Date:   Fri, 23 Sep 2022 20:58:06 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+152d76c44ba142f8992b@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] general protection fault in PageHeadHuge
Message-ID: <Yy5WHvioerD2Sev1@x1n>
References: <0000000000006c300705e95a59db@google.com>
 <Yy4g/BKpnJga1toG@monkey>
 <7693a84-bdc2-27b5-2695-d0fe8566571f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7693a84-bdc2-27b5-2695-d0fe8566571f@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hugh, Mike,

On Fri, Sep 23, 2022 at 05:14:38PM -0700, Hugh Dickins wrote:
> On Fri, 23 Sep 2022, Mike Kravetz wrote:
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
> Thanks Mike.  Yes, it looks like userfaultfd's successful returns from
> shmem_get_folio_gfp() have (correctly?) filled in vmf->page directly,

AFAICT handle_userfault() doens't set vmf->page; it relies on returning
"*fault_type" to be VM_FAULT_RETRY so the fault will be retried assuming
the pgtable has been installed properly when it returns.

> and are not setting *foliop at all.  So this would affect any
> userfaultfd usage of shmem, not just an odd syzbot corner case.
> 
> I do think shmem_fault() ought at least to initialize its folio pointer
> (as shmem_file_read_iter() correctly does); and if it does that, then we
> don't need to weed out the userfaultfd cases as such, but just avoid
> folio_file_page() when folio is still NULL.
> 
> I've neither tried the syzbot test case (but see its .c does involve
> userfaultld), nor tried userfaultfd shmem: Peter, could you give this a
> try - we'd expect userfaultfd shmem to crash on linux-next without the
> patch below.
> 
> And it implies that nobody has been trying userfaultfd shmem on recent
> linux-next, so whether vmf->page is then set correctly we're not sure.
> 
> But me, I cannot even get the latest linux-next to boot: next job.
> 
> Hugh
> 
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
> @@ -2127,7 +2127,8 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
>  				  gfp, vma, vmf, &ret);
>  	if (err)
>  		return vmf_error(err);
> -	vmf->page = folio_file_page(folio, vmf->pgoff);
> +	if (folio)
> +		vmf->page = folio_file_page(folio, vmf->pgoff);
>  	return ret;
>  }

The patch itself looks correct to me.  Thanks.

Reviewed-by: Peter Xu <peterx@redhat.com>

Not sure whether it can be directly squashed into 371133f76a6d.

-- 
Peter Xu

