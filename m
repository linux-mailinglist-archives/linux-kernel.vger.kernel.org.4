Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5655F17FB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbiJABLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbiJABLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D0B1C0C66
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664586426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zc0SaAKpDNbb3UwCWe65+Ca5KZLIn58yTui8h1PFlaU=;
        b=VdROnznrWC+9gsp+eUOJ/MzR9h6fGUtgZZlsS1AXhYuF6NY2wFthQs6hqR5TXgHp+P5ith
        sOR9kcrqlr01XhsdClLzit/qUGO6SZpoejrYW2PK76rmKPpeQUQeAiVk7DNh01itAqh0aJ
        w7sbudnU+Q5APX3z1IYQU+5qhA5K8BI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-qpMlPbNaP_2i2vW30mCWZw-1; Fri, 30 Sep 2022 21:03:56 -0400
X-MC-Unique: qpMlPbNaP_2i2vW30mCWZw-1
Received: by mail-qv1-f71.google.com with SMTP id h3-20020a0ceec3000000b004b17a25f8bcso609549qvs.23
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zc0SaAKpDNbb3UwCWe65+Ca5KZLIn58yTui8h1PFlaU=;
        b=Mv1gRfZpYYNYJz2gc1hkwbLiNjGwX9N35pZQ5pOZwsoahKsx8yTwHuNQrFJtXRc1tc
         6OpJ2s1d7ZUSq83SU4oEvOYWf9zCW3JAcCcEIBWtsJt6831sKeSRwrxK3Nzp2/FjIRMx
         jFpa/YuN1+jxGRo+FABBGatAJtKMYn61HxYvvzObIZGjPoR262t774kAxj8TCg9GbDGA
         B83SN63JQQ+QOm8qZuOA0u3lk6fM6fcwsSceeGmKSDIdyY0LEizwYjd3kuei4qExNR74
         u4XPMGV5sQLDDmSe8i04ArDBSlxJiKX9htImWV4Y81HCnzZkf8RZ1k6KbcVEuOmKmkgt
         L5oA==
X-Gm-Message-State: ACrzQf3rl5zrDakQCpoXGw4wZp+N+s4WrEhx4lpMPRBzTmkngFrv0V/8
        NMa62zL7VNz6tcceemajmLdqG79og/5WpC4v1U3GIhekWYNLojABCjol93XLU6GZozUkSVc9SG4
        Zq4qNPLdxRRu9KxPvvsXlhH5G
X-Received: by 2002:a05:620a:4054:b0:6ce:192a:831e with SMTP id i20-20020a05620a405400b006ce192a831emr8226924qko.671.1664586235285;
        Fri, 30 Sep 2022 18:03:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM47tFZGrpm77W5knYNcCk/OIOK9UGl/UkGa3jAh2M9qO1SBeMvNlvbWjHSRwK3EinDqRUeXCA==
X-Received: by 2002:a05:620a:4054:b0:6ce:192a:831e with SMTP id i20-20020a05620a405400b006ce192a831emr8226903qko.671.1664586235025;
        Fri, 30 Sep 2022 18:03:55 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id fz17-20020a05622a5a9100b00359961365f1sm2943494qtb.68.2022.09.30.18.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 18:03:54 -0700 (PDT)
Date:   Fri, 30 Sep 2022 21:03:53 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+2b9b4f0895be09a6dec3@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Edward Liaw <edliaw@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Brian Geffon <bgeffon@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [syzbot] WARNING in change_protection
Message-ID: <YzeR+R6b4bwBlBHh@x1n>
References: <00000000000046580505e9dea8e4@google.com>
 <20220930164211.b8215770d44e1a3803f1e660@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="kOcqf18aKGDJ2WF5"
Content-Disposition: inline
In-Reply-To: <20220930164211.b8215770d44e1a3803f1e660@linux-foundation.org>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kOcqf18aKGDJ2WF5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Sep 30, 2022 at 04:42:11PM -0700, Andrew Morton wrote:
> On Thu, 29 Sep 2022 22:56:38 -0700 syzbot <syzbot+2b9b4f0895be09a6dec3@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> 
> Thanks.  Let's cc a few userfaultfd people.

I remembered there was a similar report and there might have a patch
already, but I can't find it.  The timing is a bit unfortunate..

Anyway, a new patch is attached, and I verified it with the reproducer this
time.  Thanks,

> 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    511cce163b75 Merge tag 'net-6.0-rc8' of git://git.kernel.o..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=135cf5c4880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a1992c90769e07
> > dashboard link: https://syzkaller.appspot.com/bug?extid=2b9b4f0895be09a6dec3
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1164d0ec880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c3c2e0880000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+2b9b4f0895be09a6dec3@syzkaller.appspotmail.com
> > 
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 make_pte_marker_entry include/linux/swapops.h:323 [inline]
> > WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 make_pte_marker include/linux/swapops.h:346 [inline]
> > WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 change_pte_range mm/mprotect.c:270 [inline]
> > WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 change_pmd_range mm/mprotect.c:409 [inline]
> > WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 change_pud_range mm/mprotect.c:438 [inline]
> > WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 change_p4d_range mm/mprotect.c:459 [inline]
> > WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 change_protection_range mm/mprotect.c:483 [inline]
> > WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 change_protection+0x16e9/0x4280 mm/mprotect.c:505
> > Modules linked in:
> > CPU: 1 PID: 3612 Comm: syz-executor181 Not tainted 6.0.0-rc7-syzkaller-00130-g511cce163b75 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> > RIP: 0010:make_pte_marker_entry include/linux/swapops.h:323 [inline]
> > RIP: 0010:make_pte_marker include/linux/swapops.h:346 [inline]
> > RIP: 0010:change_pte_range mm/mprotect.c:270 [inline]
> > RIP: 0010:change_pmd_range mm/mprotect.c:409 [inline]
> > RIP: 0010:change_pud_range mm/mprotect.c:438 [inline]
> > RIP: 0010:change_p4d_range mm/mprotect.c:459 [inline]
> > RIP: 0010:change_protection_range mm/mprotect.c:483 [inline]
> > RIP: 0010:change_protection+0x16e9/0x4280 mm/mprotect.c:505
> > Code: ff 48 8b 84 24 90 00 00 00 80 38 00 0f 85 25 29 00 00 48 8b 44 24 10 48 83 b8 90 00 00 00 00 0f 84 8f f9 ff ff e8 a7 d6 c3 ff <0f> 0b 48 ba 00 00 00 00 00 fc ff df 48 8b 04 24 48 c1 e8 03 80 3c
> > RSP: 0018:ffffc90002fbf968 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
> > RDX: ffff888073714180 RSI: ffffffff81b76079 RDI: 0000000000000007
> > RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
> > R10: 0000000000000004 R11: 0000000000000000 R12: 0000000000000000
> > R13: ffff8880000001e8 R14: 0000000000000000 R15: 000000002063e000
> > FS:  000055555624d300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000005d84c8 CR3: 000000007c916000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  uffd_wp_range+0xf0/0x180 mm/userfaultfd.c:718
> >  mwriteprotect_range+0x2ea/0x420 mm/userfaultfd.c:768
> >  userfaultfd_writeprotect fs/userfaultfd.c:1827 [inline]
> >  userfaultfd_ioctl+0x438/0x43a0 fs/userfaultfd.c:1999
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:870 [inline]
> >  __se_sys_ioctl fs/ioctl.c:856 [inline]
> >  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7f77d7707bb9
> > Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffe74be7168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f77d7707bb9
> > RDX: 00000000200000c0 RSI: 00000000c018aa06 RDI: 0000000000000003
> > RBP: 00007f77d76cbd60 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f77d76cbdf0
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> >  </TASK>
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > syzbot can test patches for this issue, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
> 

-- 
Peter Xu

--kOcqf18aKGDJ2WF5
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-mm-uffd-Fix-warning-without-PTE_MARKER_UFFD_WP-compi.patch"

From f965f8879301a5cb04b5b1ca91cb8852b9c17237 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Fri, 30 Sep 2022 20:25:55 -0400
Subject: [PATCH] mm/uffd: Fix warning without PTE_MARKER_UFFD_WP compiled in
Content-type: text/plain

When PTE_MARKER_UFFD_WP not configured, it's still possible to reach pte
marker code and trigger an warning. Add a few CONFIG_PTE_MARKER_UFFD_WP
ifdefs to make sure the code won't be reached when not compiled in.

Reported-by: syzbot+2b9b4f0895be09a6dec3@syzkaller.appspotmail.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c  | 4 ++++
 mm/memory.c   | 2 ++
 mm/mprotect.c | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0bdfc7e1c933..dd29cba46e9e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5059,6 +5059,7 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 		 * unmapped and its refcount is dropped, so just clear pte here.
 		 */
 		if (unlikely(!pte_present(pte))) {
+#ifdef CONFIG_PTE_MARKER_UFFD_WP
 			/*
 			 * If the pte was wr-protected by uffd-wp in any of the
 			 * swap forms, meanwhile the caller does not want to
@@ -5070,6 +5071,7 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 				set_huge_pte_at(mm, address, ptep,
 						make_pte_marker(PTE_MARKER_UFFD_WP));
 			else
+#endif
 				huge_pte_clear(mm, address, ptep, sz);
 			spin_unlock(ptl);
 			continue;
@@ -5098,11 +5100,13 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 		tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
 		if (huge_pte_dirty(pte))
 			set_page_dirty(page);
+#ifdef CONFIG_PTE_MARKER_UFFD_WP
 		/* Leave a uffd-wp pte marker if needed */
 		if (huge_pte_uffd_wp(pte) &&
 		    !(zap_flags & ZAP_FLAG_DROP_MARKER))
 			set_huge_pte_at(mm, address, ptep,
 					make_pte_marker(PTE_MARKER_UFFD_WP));
+#endif
 		hugetlb_count_sub(pages_per_huge_page(h), mm);
 		page_remove_rmap(page, vma, true);
 
diff --git a/mm/memory.c b/mm/memory.c
index a78814413ac0..de0dbe09b013 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1393,10 +1393,12 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
 			      unsigned long addr, pte_t *pte,
 			      struct zap_details *details, pte_t pteval)
 {
+#ifdef CONFIG_PTE_MARKER_UFFD_WP
 	if (zap_drop_file_uffd_wp(details))
 		return;
 
 	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
+#endif
 }
 
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
diff --git a/mm/mprotect.c b/mm/mprotect.c
index bc6bddd156ca..51e7dbd26b6a 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -260,6 +260,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 		} else {
 			/* It must be an none page, or what else?.. */
 			WARN_ON_ONCE(!pte_none(oldpte));
+#ifdef CONFIG_PTE_MARKER_UFFD_WP
 			if (unlikely(uffd_wp && !vma_is_anonymous(vma))) {
 				/*
 				 * For file-backed mem, we need to be able to
@@ -271,6 +272,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 					   make_pte_marker(PTE_MARKER_UFFD_WP));
 				pages++;
 			}
+#endif
 		}
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	arch_leave_lazy_mmu_mode();
-- 
2.37.3


--kOcqf18aKGDJ2WF5--

