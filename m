Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000D768FE3E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjBIEIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjBIEIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:08:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409B2903A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 20:08:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89BAD61838
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F6EC433EF;
        Thu,  9 Feb 2023 04:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1675915709;
        bh=pHJypjgeDSW+11z03k8Qy0ZiPxB15zj8h5OsUvUjIdM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fJmx7LmC3VIWvSWeCitVOw2zg8kbhehG3WbBeiLxT76ErH2PV7xjYLPH73d/cMjKS
         IC6YYIWWKtqeZQ2G96J6GDd2i4dFLrw03Nsg/mDL8Mz2a26nH3jpR/aplnRZ38avrN
         S1mZqAknZagGKwPw5s4Ip1c5Wnpt9X9PonuFX1Es=
Date:   Wed, 8 Feb 2023 20:08:27 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+d632e24db18585d7b3c6@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 folio_flags
Message-Id: <20230208200827.9b461dc5955770535aa2ec78@linux-foundation.org>
In-Reply-To: <000000000000a6b67d05f43a9854@google.com>
References: <000000000000cce8cd05f435fc77@google.com>
        <000000000000a6b67d05f43a9854@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Feb 2023 17:49:49 -0800 syzbot <syzbot+d632e24db18585d7b3c6@syzkaller.appspotmail.com> wrote:

> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    38d2b86a665b Add linux-next specific files for 20230208
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15f5e3a7480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3691b32dd4410e01
> dashboard link: https://syzkaller.appspot.com/bug?extid=d632e24db18585d7b3c6
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1454ddf3480000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a8431f480000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0a9d60e90514/disk-38d2b86a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/71311be5f1a1/vmlinux-38d2b86a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a242870cc8eb/bzImage-38d2b86a.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d632e24db18585d7b3c6@syzkaller.appspotmail.com
> 
> memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=5080 'syz-executor561'
> BUG: unable to handle page fault for address: ffffffffffffffed
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD c570067 P4D c570067 PUD c572067 PMD 0 
> Oops: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 5080 Comm: syz-executor561 Not tainted 6.2.0-rc7-next-20230208-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
> RIP: 0010:PageTail include/linux/page-flags.h:290 [inline]
> RIP: 0010:folio_flags.constprop.0+0x2c/0x150 include/linux/page-flags.h:317
> Code: 49 89 fc 55 53 e8 84 4e b7 ff 49 8d 7c 24 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 f8 00 00 00 <49> 8b 5c 24 08 31 ff 83 e3 01 48 89 de e8 c2 4a b7 ff 48 85 db 0f
> RSP: 0018:ffffc90003cbfc08 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffffffffffffffe5 RCX: 0000000000000000
> RDX: 1ffffffffffffffd RSI: ffffffff81cd1f5c RDI: ffffffffffffffed
> RBP: ffffffffffffffe5 R08: 0000000000000005 R09: 0000000000000000
> R10: 00000000ffffffe5 R11: 0000000000000000 R12: ffffffffffffffe5
> R13: 000feffffff00000 R14: 0000000000000046 R15: 000feffffff00000
> FS:  0000555556e84300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffed CR3: 000000002bb37000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  folio_test_head include/linux/page-flags.h:781 [inline]
>  folio_test_large include/linux/page-flags.h:802 [inline]
>  PageHeadHuge+0x18/0xc0 mm/hugetlb.c:2060
>  folio_test_hugetlb include/linux/page-flags.h:830 [inline]
>  folio_file_page include/linux/pagemap.h:702 [inline]
>  shmem_read_mapping_page_gfp+0x34/0x100 mm/shmem.c:4366
>  shmem_read_mapping_page include/linux/shmem_fs.h:124 [inline]
>  udmabuf_create+0x93b/0x1440 drivers/dma-buf/udmabuf.c:286
>  udmabuf_ioctl_create drivers/dma-buf/udmabuf.c:346 [inline]
>  udmabuf_ioctl+0x156/0x2c0 drivers/dma-buf/udmabuf.c:377

Thanks, I expect Matthew just fixed this.


From: Andrew Morton <akpm@linux-foundation.org>
Subject: shmem-add-shmem_read_folio-and-shmem_read_folio_gfp-fix
Date: Wed Feb  8 07:54:45 PM PST 2023

fix shmem_read_mapping_page_gfp(), per Matthew

Link: https://lkml.kernel.org/r/Y+QdJTuzxeBYejw2@casper.infradead.org
Cc: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Mark Hemment <markhemm@googlemail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---


--- a/mm/shmem.c~shmem-add-shmem_read_folio-and-shmem_read_folio_gfp-fix
+++ a/mm/shmem.c
@@ -4354,8 +4354,12 @@ struct page *shmem_read_mapping_page_gfp
 					 pgoff_t index, gfp_t gfp)
 {
 	struct folio *folio = shmem_read_folio_gfp(mapping, index, gfp);
-	struct page *page = folio_file_page(folio, index);
+	struct page *page;
 
+	if (IS_ERR(folio))
+		return &folio->page;
+
+	page = folio_file_page(folio, index);
 	if (PageHWPoison(page)) {
 		folio_put(folio);
 		return ERR_PTR(-EIO);
_

