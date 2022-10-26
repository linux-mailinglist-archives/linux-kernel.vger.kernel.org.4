Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB0860E55C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiJZQSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiJZQSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:18:06 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F5A10C4D4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:18:05 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-13b103a3e5dso20738468fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Rx7jRbeJFQQeY4CuX68l+sc3xlUHAWmS3stTUI4NW4=;
        b=tXTU3cd+Kem9VQGM9wx+izXfLuSE0e5vXjNSSlsAFVcNWvD6N++yblUw3Sj4lfIo1F
         Y2wEsaeDpdjPjfDnHhK7PvAhfBeRhP4zOJs55LyF1DqEVthK8F+3LZIca6N5UIxr4jDV
         CVE6muoI+bPlkye9/FKzzJPxFCEBlGMGeQ+HzGFQywzCXCFUjQC+PKi67pCkmeAxYImd
         4c/PkkuLKsqjIJULeyNaiEaaaOMVpOsX8FZWQ3X/EXjD5/wn0SgWvyNm5yPT227gKQfs
         o2bxSVvBHqImSAWrwHfazOREziDKbg9IuXduyCL9l9fUPfB3ikDstfSKlBJsOiQuF82b
         cJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Rx7jRbeJFQQeY4CuX68l+sc3xlUHAWmS3stTUI4NW4=;
        b=5fCykxMFjq58nKJC6nJT2u3eViTPaVUrFHO+UYurc3fe56C9umNP/MGn7lM+IrEvPH
         257ONbm+66Aqde78RZ8+gqSSnlZFaAIAzezP5mUTunnOVqj9lGaUWeZxQl6Jjf+Vlb3K
         TTE3G+ea3ZNrHYvWfwsAKoPQPaueGk6k0y2cNQqvFrIAn0BaRGPW4okNSJ3UziblGMNf
         kIhqclXtHmY11bc7/rW14GR6Ve1NC+X1wcOfPVD7sUR9xjVjnb06OI2Z/GRziMzsmOsg
         pdQA1sS8AOtBbTlG5ZmAZmtaWW4c2ovG2pghkt6+Ge/I2E/2t1jAZEXjwvEFQCwNGmOI
         7wxw==
X-Gm-Message-State: ACrzQf0EZHaHacxbmjXB+gJRrlUSIt4iOoHEtcOzOID0UY1THTcGxB/T
        neecW9lk9LrUhpK4t2FudzD1WQ==
X-Google-Smtp-Source: AMsMyM6M1iDV0OZbGMhwkNmiuLLXfbwMYg2h+5uP+hfUNLmpAFlxkFD9AwKteR1ZnqQkuEEucDL6ug==
X-Received: by 2002:a05:6870:eaaa:b0:132:e501:4053 with SMTP id s42-20020a056870eaaa00b00132e5014053mr2732963oap.186.1666801083998;
        Wed, 26 Oct 2022 09:18:03 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f11-20020a05680807cb00b003546cb60859sm2163458oij.14.2022.10.26.09.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 09:18:02 -0700 (PDT)
Date:   Wed, 26 Oct 2022 09:17:53 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     David Hildenbrand <david@redhat.com>
cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+273b547b15eb58ea35e8@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [syzbot] WARNING in __split_huge_page_tail
In-Reply-To: <c17502a0-2e43-bf34-239b-1e9b0bde46db@redhat.com>
Message-ID: <cc37ae88-e526-2bec-d727-a748f6bd69ec@google.com>
References: <000000000000aa2b2805ebea9137@google.com> <9a450a11-531d-8e1a-4c77-70102aa7f424@redhat.com> <CACT4Y+YTjYMWQKixhkNMuty4LXTsgBmpiYAN5ChGVXZBCyp0uA@mail.gmail.com> <c17502a0-2e43-bf34-239b-1e9b0bde46db@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022, David Hildenbrand wrote:
> On 26.10.22 15:25, Dmitry Vyukov wrote:
> > On Wed, 26 Oct 2022 at 02:54, David Hildenbrand <david@redhat.com> wrote:
> >> On 26.10.22 08:59, syzbot wrote:
> >>> Hello,
> >>>
> >>> syzbot found the following issue on:
> >>>
> >>> HEAD commit:    4da34b7d175d Merge tag 'thermal-6.1-rc2' of
> >>> git://git.kern..
> >>> git tree:       upstream
> >>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=113bd8bc880000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=4789759e8a6d5f57
> >>> dashboard link:
> >>> https://syzkaller.appspot.com/bug?extid=273b547b15eb58ea35e8
> >>> compiler:       Debian clang version
> >>> 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU
> >>> Binutils for Debian) 2.35.2
> >>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161e1f62880000
> >>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16dd4fe6880000
> >>>
> >>> Downloadable assets:
> >>> disk image:
> >>> https://storage.googleapis.com/syzbot-assets/a61ddb36c296/disk-4da34b7d.raw.xz
> >>> vmlinux:
> >>> https://storage.googleapis.com/syzbot-assets/ceee41246252/vmlinux-4da34b7d.xz
> >>>
> >>> IMPORTANT: if you fix the issue, please add the following tag to the
> >>> commit:
> >>> Reported-by: syzbot+273b547b15eb58ea35e8@syzkaller.appspotmail.com
> >>>
> >>>    tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:363
> >>>    exit_mmap+0x2b1/0x670 mm/mmap.c:3098
> >>>    __mmput+0x114/0x3b0 kernel/fork.c:1185
> >>>    exit_mm+0x217/0x2f0 kernel/exit.c:516
> >>>    do_exit+0x5e7/0x2070 kernel/exit.c:807
> >>>    do_group_exit+0x1fd/0x2b0 kernel/exit.c:950
> >>>    __do_sys_exit_group kernel/exit.c:961 [inline]
> >>>    __se_sys_exit_group kernel/exit.c:959 [inline]
> >>>    __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:959
> >>>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >>>    do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
> >>>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >>> ------------[ cut here ]------------
> >>> WARNING: CPU: 0 PID: 3908 at mm/huge_memory.c:2465
> >>> __split_huge_page_tail+0x81c/0x1080 mm/huge_memory.c:2465
> >>
> >> Is this the
> >>
> >> VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) != -1, page_tail);
> >>
> >> assertion?
> > 
> > Hi David,
> > 
> > You can check the sources for that revision, but on the dashboard
> > there are clickable links for all source references:
> > https://syzkaller.appspot.com/bug?extid=273b547b15eb58ea35e8
> > 
> > In this case it points to:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/huge_memory.c?id=4da34b7d175dc99b8befebd69e96546c960d526c#n2465
> > 
> 
> Ah, thanks!
> 
> ... so
> 
> 	if (!folio_test_swapcache(page_folio(head))) {
> 		VM_WARN_ON_ONCE_PAGE(page_tail->private != 0, head);
> 		page_tail->private = 0;
> 	}
> 
> I recall that there was a patch either from Hugh or Mel floating around that
> might be related.

Yes, it's in akpm's mm-hotfixes-unstable branch, currently at
826367c8c422 ("mm: prep_compound_tail() clear page->private")

[PATCH] mm: prep_compound_tail() clear page->private

Although page allocation always clears page->private in the first page
or head page of an allocation, it has never made a point of clearing
page->private in the tails (though 0 is often what is already there).

But now commit 71e2d666ef85 ("mm/huge_memory: do not clobber swp_entry_t
during THP split") issues a warning when page_tail->private is found to
be non-0 (unless it's swapcache).

Change that warning to dump page_tail (which also dumps head), instead
of just the head: so far we have seen dead000000000122, dead000000000003,
dead000000000001 or 0000000000000002 in the raw output for tail private.

We could just delete the warning, but today's consensus appears to want
page->private to be 0, unless there's a good reason for it to be set:
so now clear it in prep_compound_tail() (more general than just for THP;
but not for high order allocation, which makes no pass down the tails).

Fixes: 71e2d666ef85 ("mm/huge_memory: do not clobber swp_entry_t during THP split")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>
---
 mm/huge_memory.c | 2 +-
 mm/page_alloc.c  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 03fc7e5edf07..561a42567477 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2462,7 +2462,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
 	 * Fix up and warn once if private is unexpectedly set.
 	 */
 	if (!folio_test_swapcache(page_folio(head))) {
-		VM_WARN_ON_ONCE_PAGE(page_tail->private != 0, head);
+		VM_WARN_ON_ONCE_PAGE(page_tail->private != 0, page_tail);
 		page_tail->private = 0;
 	}
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b5a6c815ae28..218b28ee49ed 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -807,6 +807,7 @@ static void prep_compound_tail(struct page *head, int tail_idx)
 
 	p->mapping = TAIL_MAPPING;
 	set_compound_head(p, head);
+	set_page_private(p, 0);
 }
 
 void prep_compound_page(struct page *page, unsigned int order)
-- 
2.35.3
