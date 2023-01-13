Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B124766A2FE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjAMTap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjAMTaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:30:10 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68DE85C95
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:29:36 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id u8so11212294ilq.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3SoqAB8Gh1UCnjlHlOov/PHK/hqCz8PY+LuZEUXckVs=;
        b=Hv8W85udZRDJYjOECcpxmyNQ5Bqsb60Oiohh9ar3RZw1GlaHfZ30jJ8oofWgWkZAkl
         5CUbnBqaQCrPdZ3yOTw/PhtyxQZhn3I7bb5mcm1rEJkHJ4n+01bu+aXKJGeAHrdzLld/
         C3AGA2yF6W/m2iEh8l5nu7jECST5dcYtoRVU0iDbiPlP5imcAu+zXjNZx+JqqLeqyAgn
         mXGlgsMM/1mSvWNCl+8XfLDmYjqHOsCIBi9oNt0enABIftwH9NBNZOIc2bxTjJYLYiNO
         aihbfLRPqDRDA4lmR46hJI/UkyDmMeVhh4FYgdqBHcXsPtespE6AhV+VCoKIe5ZaNw/H
         QpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3SoqAB8Gh1UCnjlHlOov/PHK/hqCz8PY+LuZEUXckVs=;
        b=r7O0GBpNU3iXn83Q/M1MBgax2SztclZdVbwTr1G+WAA6wCcZsCfuDU+eXC5JyJVhT4
         FT2cFC3fXsaLJ9ev9W9JEDd8fCj+mF5gq6t98pUYC0lYfJENbr/0WA0VI+WcMPym6k/+
         fkV4phdEveah5e03w+BTSq4I8BUb+WDxc+JKDR7lE9BGxzLPuch8PCiNGHje2L8L+Nyt
         C03fEJr4zkYkVA5rC19RjRfnAueCjHOF8XK6Q0XSczVGKUMSln515ljig0/YMm1jVjeG
         O8GxlmMJOnQfFLl22lymmjrGHwfm7lc12j15dCphTTckd5eonbpAuocrHhHU5ZOvlHGo
         DojA==
X-Gm-Message-State: AFqh2krcdFV4CqIsFPpAxj2dji9d4zNkNpDrhY8Judneh/I0uTIFtNHp
        tPIaOqw/QsBNI6oS5Rkn7GD1Y8aWgWDzxMLaKlHYjdHcWV7Wfxae
X-Google-Smtp-Source: AMrXdXvpiaJnpwnVB3dmE0p/mALs5OaqMkG4c8hF6Oz7QhEW32fiaG19VRcxtzkW7WcXjB6vJF8P3UKVXT8uk0J/wx4=
X-Received: by 2002:a92:cac4:0:b0:30b:f4af:87bd with SMTP id
 m4-20020a92cac4000000b0030bf4af87bdmr7684206ilq.254.1673638175800; Fri, 13
 Jan 2023 11:29:35 -0800 (PST)
MIME-Version: 1.0
References: <20230111133351.807024-1-jannh@google.com> <20230112085649.gvriasb2t5xwmxkm@box.shutemov.name>
In-Reply-To: <20230112085649.gvriasb2t5xwmxkm@box.shutemov.name>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 13 Jan 2023 20:28:59 +0100
Message-ID: <CAG48ez3434wZBKFFbdx4M9j6eUwSUVPd4dxhzW_k_POneSDF+A@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Fix ->anon_vma race
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Zach O'Keefe" <zokeefe@google.com>, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000f44dc905f22a401e"
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

--000000000000f44dc905f22a401e
Content-Type: text/plain; charset="UTF-8"

On Thu, Jan 12, 2023 at 9:56 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> On Wed, Jan 11, 2023 at 02:33:51PM +0100, Jann Horn wrote:
> > If an ->anon_vma is attached to the VMA, collapse_and_free_pmd() requires
> > it to be locked. retract_page_tables() bails out if an ->anon_vma is
> > attached, but does this check before holding the mmap lock (as the comment
> > above the check explains).
> >
> > If we racily merge an existing ->anon_vma (shared with a child process)
> > from a neighboring VMA, subsequent rmap traversals on pages belonging to
> > the child will be able to see the page tables that we are concurrently
> > removing while assuming that nothing else can access them.
> >
> > Repeat the ->anon_vma check once we hold the mmap lock to ensure that there
> > really is no concurrent page table access.
> >
> > Reported-by: Zach O'Keefe <zokeefe@google.com>
> > Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > zokeefe@ pointed out to me that the current code (after my last round of patches)
> > can hit a lockdep assert by racing, and after staring at it a bit I've
> > convinced myself that this is a real, preexisting bug.
> > (I haven't written a reproducer for it though. One way to hit it might be
> > something along the lines of:
> >
> >  - set up a process A with a private-file-mapping VMA V1
> >  - let A fork() to create process B, thereby copying V1 in A to V1' in B
> >  - let B extend the end of V1'
> >  - let B put some anon pages into the extended part of V1'
>
> At this point V1' gets it's own ->anon_vma, not connected to V1, right?

Yes, true, it doesn't work in a child process because
reusable_anon_vma() refuses to reuse the anon_vma of an adjacent VMA
if that VMA is attached to more than one VMA. So to actually make it
work, you have to rearrange things a bit such that this happens in the
parent process, so that prepare_anon_vma() will reuse a neighboring
anon_vma via reusable_anon_vma().

Sorry, my description of the race was slightly off. See the attached
code for how to actually do it. Basically the trick is to use mremap()
to take one private file VMA with an anon_vma and turn it into two
private file VMAs ("mapping1" and "mapping2" in my code) with the same
anon_vma that map the same file range. Put an anonymous page into
mapping1. Then you can replace the first 2 MiB of "mapping2" with
another VMA that is not mergeable into mapping2, is
anon_vma-compatible with mapping2, has no anon_vma, and looks
THP-collapsible. And then you can, while khugepaged is in the race
window, attach the new VMA to the existing anon_vma and trigger an
rmap walk on the anonymous page.

> >  - let A map a new private-file-mapping VMA V2 directly behind V1, without
> >    an anon_vma
> > [race begins here]
> >   - in A's thread 1: begin retract_page_tables() on V2, run through first
> >     ->anon_vma check
> >   - in A's thread 2: run __anon_vma_prepare() on V2 and ensure that it
> >     merges the anon_vma of V1 (which implies V1 and V2 must be mapping the
> >     same file at compatible offsets)
> >   - in B: trigger rmap traversal on anon page in V1'
>
> I don't follow the race. rmap on V1' will not reach V1.
>
> >  mm/khugepaged.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 5cb401aa2b9d..0bfed37f3a3b 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1644,7 +1644,7 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
> >                * has higher cost too. It would also probably require locking
> >                * the anon_vma.
> >                */
> > -             if (vma->anon_vma) {
> > +             if (READ_ONCE(vma->anon_vma)) {
> >                       result = SCAN_PAGE_ANON;
> >                       goto next;
> >               }
>
> This makes perfect sense. At least for readability. But I think
> false-negative should not lead to bad results.
>
> > @@ -1672,6 +1672,18 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
> >               result = SCAN_PTE_MAPPED_HUGEPAGE;
> >               if ((cc->is_khugepaged || is_target) &&
> >                   mmap_write_trylock(mm)) {
> > +                     /*
> > +                      * Re-check whether we have an ->anon_vma, because
> > +                      * collapse_and_free_pmd() requires that either no
> > +                      * ->anon_vma exists or the anon_vma is locked.
> > +                      * We already checked ->anon_vma above, but that check
> > +                      * is racy because ->anon_vma can be populated under the
> > +                      * mmap lock in read mode.
> > +                      */
> > +                     if (vma->anon_vma) {
> > +                             result = SCAN_PAGE_ANON;
> > +                             goto unlock_next;
> > +                     }
>
> This is totally wrong direction. Or I don't understand the race.
>
> At this point we already paid nearly all price of of pagetable retraction.
> I don't see any correctness reason to stop here, except for the assert.

This condition can only be hit with a narrow race, since vma->anon_vma
was NULL a moment ago. So this branch will only run very rarely, which
means it is unlikely to have an effect on performance.

> I think lockdep assert in collapse_and_free_pmd() is wrong and has to be
> dropped.

No, that lockdep assert has to be there. Page table traversal is
allowed under any one of the mmap lock, the anon_vma lock (if the VMA
is associated with an anon_vma), and the mapping lock (if the VMA is
associated with a mapping); and so to be able to remove page tables,
we must hold all three of them. Even if we couldn't figure out a way
to actually exploit a lack of locking here, we still shouldn't be
skipping locking because of that. Unless we have clearly defined API
contracts such as "you are allowed to traverse page tables if you hold
one of these three locks", it is impossible to maintain code or to
make it robust and secure. Even if you could show that the lack of
locking can't lead to a crash in the current kernel, that still
wouldn't be a good reason to skip the locking. Without something at
least resembling an API contract, an innocent-looking change in
another part of the kernel can turn things in a completely different
part of the kernel into dangerous bugs, and it is impossible to change
anything while feeling confident that you haven't broken something
halfway across the kernel. (Or at least that's what it feels like to
me when I try to edit kernel code.)

Anyway, here are proper instructions for reproducing the bug.
First build the kernel with the attached patch
HACK-thp-anonvma-logging-and-delay.diff, which adds a bunch of debug
logging and injects extra timing delays to make the race much easier
to hit.
Then build with CONFIG_KASAN=y and
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y and lockdep, and run that
kernel.
Run "echo force > /sys/kernel/mm/transparent_hugepage/shmem_enabled"
to enable shmem THP.
Compile the attached reproducer thp_newbug.c ("gcc -o thp_newbug thp_newbug.c").
Let the reproducer run (it'll take a few seconds to run because it has
to wait for khugepaged and stuff). Then you should see a lockdep
assert failure followed by an ASAN splat due to page table UAF in
dmesg:


[ 1076.064348][  T116] khugepaged: retract_page_tables:
retract_page_tables(), cc->is_khugepaged=1, target_mm=ffff88817b4acc80
[ 1076.066331][  T116] khugepaged: retract_page_tables: running on vma
at 0x1fe000 in mm=ffff88817b4acc80
[ 1076.068464][  T116] khugepaged: retract_page_tables: about to call
collapse_and_free_pmd()
[ 1076.071078][  T116] khugepaged: retract_page_tables: done with
collapse_and_free_pmd()
[ 1076.072360][  T116] khugepaged: retract_page_tables: sleeping
before mmap lock...
[ 1076.135883][  T797] map_pte: executing under TEST1
pvmw->vma->vm_mm==ffff88817b4acc80 pvmw->vma->vm_start=0x23ff000
[ 1076.147212][  T797] map_pte:   ... begin delay...
[ 1079.074924][  T116] khugepaged: retract_page_tables: done sleeping
[ 1079.075874][  T116] khugepaged: retract_page_tables: about to call
collapse_and_free_pmd()
[ 1079.076964][  T116] ------------[ cut here ]------------
[ 1079.077663][  T116] WARNING: CPU: 14 PID: 116 at
mm/khugepaged.c:1406 collapse_and_free_pmd+0x364/0x420
[ 1079.078940][  T116] CPU: 14 PID: 116 Comm: khugepaged Not tainted
6.2.0-rc3-00060-gc757fc92a3f7-dirty #257
[ 1079.080191][  T116] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[ 1079.081462][  T116] RIP: 0010:collapse_and_free_pmd+0x364/0x420
[ 1079.082290][  T116] Code: ae 7e e6 03 85 d2 0f 84 b3 fd ff ff 4c 89
ff e8 52 86 fe ff 49 8b 3f 31 f6 48 83 c7 78 e8 34 56 e3 01 85 c0 0f
85 95 fd ff ff <0f> 0b e9 8e fd ff ff e8 d0 13 e8 ff ba ff ff ff ff be
26 00 00 00
[ 1079.084735][  T116] RSP: 0018:ffffc900009b79b0 EFLAGS: 00010246
[ 1079.085527][  T116] RAX: 0000000000000000 RBX: ffff88817b4acc80
RCX: 0000000000000001
[ 1079.089956][  T116] RDX: 0000000000000000 RSI: ffffffffa5cab020
RDI: ffffffffa5e382e0
[ 1079.090967][  T116] RBP: 1ffff92000136f36 R08: 0000000000000000
R09: ffff88817b4acd6f
[ 1079.091942][  T116] R10: ffffed102f6959ad R11: 0000000000000001
R12: ffff888117b0a3e8
[ 1079.092953][  T116] R13: 0000000002400000 R14: ffff888171ad1090
R15: ffff8881149b1100
[ 1079.094066][  T116] FS:  0000000000000000(0000)
GS:ffff8881f7100000(0000) knlGS:0000000000000000
[ 1079.095387][  T116] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1079.096379][  T116] CR2: 000055c6faaf9578 CR3: 0000000111738005
CR4: 0000000000370ee0
[ 1079.097695][  T116] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[ 1079.098909][  T116] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[ 1079.100117][  T116] Call Trace:
[ 1079.100668][  T116]  <TASK>
[...]
[ 1079.106003][  T116]  collapse_file.cold+0x3a4/0x400
[...]
[ 1079.110117][  T116]  hpage_collapse_scan_file+0x72a/0xad0
[ 1079.110856][  T116]  ? lock_release+0x22e/0x460
[ 1079.111483][  T116]  ? __pfx_hpage_collapse_scan_file+0x10/0x10
[ 1079.112289][  T116]  khugepaged+0x66b/0xbf0
[...]
[ 1079.118911][  T116]  kthread+0x17e/0x1b0
[ 1079.119440][  T116]  ? __pfx_kthread+0x10/0x10
[ 1079.120012][  T116]  ret_from_fork+0x2c/0x50
[ 1079.120593][  T116]  </TASK>
[ 1079.120971][  T116] irq event stamp: 12259
[ 1079.121520][  T116] hardirqs last  enabled at (12271):
[<ffffffffa388204e>] __up_console_sem+0x5e/0x70
[ 1079.122735][  T116] hardirqs last disabled at (12282):
[<ffffffffa3882033>] __up_console_sem+0x43/0x70
[ 1079.123950][  T116] softirqs last  enabled at (12018):
[<ffffffffa37cd108>] __irq_exit_rcu+0xd8/0x140
[ 1079.125151][  T116] softirqs last disabled at (12013):
[<ffffffffa37cd108>] __irq_exit_rcu+0xd8/0x140
[ 1079.126342][  T116] ---[ end trace 0000000000000000 ]---
[ 1079.140447][  T116] khugepaged: retract_page_tables: done with
collapse_and_free_pmd()
[ 1079.143002][  T116] khugepaged: retract_page_tables: skipping vma
at 0x1400000 in mm=ffff88817b4acc80 because anon_vma
[ 1079.146490][  T116] khugepaged: retract_page_tables: skipping vma
at 0x1400000 in mm=ffff88817b4a9980 because anon_vma
[ 1079.159601][  T116] khugepaged: retract_page_tables:
retract_page_tables(), cc->is_khugepaged=1, target_mm=ffff88817b4acc80
[ 1079.161186][  T116] khugepaged: retract_page_tables: skipping vma
at 0x1400000 in mm=ffff88817b4acc80 because anon_vma
[ 1079.162648][  T116] khugepaged: retract_page_tables: skipping vma
at 0x1400000 in mm=ffff88817b4a9980 because anon_vma
[ 1079.164000][  T116] khugepaged: retract_page_tables: skipping vma
at 0x2600000 in mm=ffff88817b4acc80 because anon_vma
[ 1079.649601][  T797] map_pte:   ... end delay
[ 1079.650358][  T797]
==================================================================
[ 1079.651257][  T797] BUG: KASAN: use-after-free in
page_vma_mapped_walk+0x5f3/0xdf0
[ 1079.652120][  T797] Read of size 8 at addr ffff888171e54000 by task TEST1/797
[ 1079.652915][  T797]
[ 1079.653179][  T797] CPU: 13 PID: 797 Comm: TEST1 Tainted: G
W          6.2.0-rc3-00060-gc757fc92a3f7-dirty #257
[ 1079.654410][  T797] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[ 1079.655534][  T797] Call Trace:
[ 1079.655907][  T797]  <TASK>
[ 1079.656268][  T797]  dump_stack_lvl+0x5b/0x77
[ 1079.656812][  T797]  print_report+0x168/0x458
[...]
[ 1079.659003][  T797]  kasan_report+0xbb/0xf0
[...]
[ 1079.662829][  T797]  page_vma_mapped_walk+0x5f3/0xdf0
[ 1079.663474][  T797]  folio_referenced_one+0x1b3/0x3e0
[...]
[ 1079.667670][  T797]  rmap_walk_anon+0x137/0x2b0
[ 1079.668252][  T797]  folio_referenced+0x298/0x2c0
[...]
[ 1079.673519][  T797]  shrink_folio_list+0xd30/0x1660
[...]
[ 1079.679030][  T797]  reclaim_folio_list.constprop.0+0xcf/0x200
[...]
[ 1079.681772][  T797]  reclaim_pages+0x154/0x1c0
[...]
[ 1079.683727][  T797]  madvise_cold_or_pageout_pte_range+0xf64/0x1900
[...]
[ 1079.686125][  T797]  walk_pgd_range+0x68a/0xcb0
[...]
[ 1079.687393][  T797]  __walk_page_range+0x25d/0x260
[...]
[ 1079.689327][  T797]  walk_page_range+0x253/0x2b0
[...]
[ 1079.691922][  T797]  madvise_pageout+0x1ab/0x2a0
[...]
[ 1079.694355][  T797]  do_madvise.part.0+0x3a3/0x1370
[...]
[ 1079.701143][  T797]  __x64_sys_madvise+0x7b/0xa0
[ 1079.701719][  T797]  do_syscall_64+0x3a/0x90
[ 1079.702207][  T797]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 1079.702863][  T797] RIP: 0033:0x7f18ae2dfd07
[ 1079.703352][  T797] Code: ff ff ff ff c3 48 8b 15 87 61 0c 00 f7 d8
64 89 02 b8 ff ff ff ff eb bc 66 2e 0f 1f 84 00 00 00 00 00 90 b8 1c
00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 59 61 0c 00 f7 d8
64 89 01 48
[ 1079.705469][  T797] RSP: 002b:00007fffaaf31198 EFLAGS: 00000206
ORIG_RAX: 000000000000001c
[ 1079.706382][  T797] RAX: ffffffffffffffda RBX: 0000000000000000
RCX: 00007f18ae2dfd07
[ 1079.707244][  T797] RDX: 0000000000000015 RSI: 0000000000001000
RDI: 0000000001400000
[ 1079.710207][  T797] RBP: 00007fffaaf322c0 R08: 00007f18ae3a8800
R09: 00007f18ae3ad540
[ 1079.711092][  T797] R10: 00007f18ae2d6274 R11: 0000000000000206
R12: 00005577fac45220
[ 1079.712021][  T797] R13: 00007fffaaf323a0 R14: 0000000000000000
R15: 0000000000000000
[ 1079.712883][  T797]  </TASK>
[ 1079.713219][  T797]
[ 1079.713495][  T797] The buggy address belongs to the physical page:
[ 1079.714273][  T797] page:000000009614ae4b refcount:0 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x171e54
[ 1079.715595][  T797] flags: 0x8000000000000000(zone=2)
[ 1079.716275][  T797] raw: 8000000000000000 ffffea0004562e48
ffff8881f713d810 0000000000000000
[ 1079.717389][  T797] raw: 0000000000000000 ffff8881183f50c0
00000000ffffffff 0000000000000000
[ 1079.718508][  T797] page dumped because: kasan: bad access detected
[ 1079.719358][  T797] page_owner tracks the page as freed
[ 1079.720053][  T797] page last allocated via order 0, migratetype
Unmovable, gfp_mask 0x400dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO), pid 796,
tgid 796 (thp_newbug), ts 1065542415232, free_ts 1079140429026
[ 1079.722276][  T797]  get_page_from_freelist+0xb0a/0x1300
[ 1079.722872][  T797]  __alloc_pages+0x17e/0x3c0
[ 1079.723376][  T797]  pte_alloc_one+0x18/0xe0
[ 1079.723885][  T797]  __handle_mm_fault+0x15fa/0x1660
[ 1079.724474][  T797]  handle_mm_fault+0x18c/0x4e0
[ 1079.724995][  T797]  do_user_addr_fault+0x232/0x7f0
[ 1079.725551][  T797]  exc_page_fault+0x5d/0xe0
[ 1079.726045][  T797]  asm_exc_page_fault+0x22/0x30
[ 1079.726577][  T797] page last free stack trace:
[ 1079.727089][  T797]  free_pcp_prepare+0x276/0x530
[ 1079.727680][  T797]  free_unref_page+0x37/0x250
[ 1079.728193][  T797]  collapse_and_free_pmd+0x2a3/0x420
[ 1079.728773][  T797]  collapse_file.cold+0x3a4/0x400
[ 1079.729321][  T797]  hpage_collapse_scan_file+0x72a/0xad0
[ 1079.729939][  T797]  khugepaged+0x66b/0xbf0
[ 1079.730426][  T797]  kthread+0x17e/0x1b0
[ 1079.730874][  T797]  ret_from_fork+0x2c/0x50
[ 1079.731393][  T797]
[ 1079.731674][  T797] Memory state around the buggy address:
[ 1079.732284][  T797]  ffff888171e53f00: 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00
[ 1079.733154][  T797]  ffff888171e53f80: 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00
[ 1079.734032][  T797] >ffff888171e54000: ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff
[ 1079.734932][  T797]                    ^
[ 1079.735380][  T797]  ffff888171e54080: ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff
[ 1079.736249][  T797]  ffff888171e54100: ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff
[ 1079.737119][  T797]
==================================================================
[ 1079.738129][  T797] Disabling lock debugging due to kernel taint
[ 1079.738897][  T797] map_pte: executing under TEST1
pvmw->vma->vm_mm==ffff88817b4acc80 pvmw->vma->vm_start=0x1400000
[ 1079.744091][  T797] map_pte:   ... continuing
[ 1079.744621][  T797] map_pte: executing under TEST1
pvmw->vma->vm_mm==ffff88817b4a9980 pvmw->vma->vm_start=0x1400000
[ 1079.745802][  T797] map_pte:   ... continuing


Here's the corresponding reproducer output (including dumps of the
anon_vma hierarchies attached to the VMAs, thanks to the extra debug
info I added to procfs in the attached diff):


user@vm:~/thp/thp_newbug$ ./thp_newbug
Rss = 2048 kB
[...]
Rss = 2048 kB
Rss = 2048 kB
Rss = 2048 kB
Rss = 2048 kB
Rss = 0 kB
khugepaged is about to write_trylock! associating anon_vma...
anon_vma associated, telling child to hit rmap now...
child hitting rmap...
child done with rmap

=========== PARENT ===========
001fe000-00400000 r--p 003fe000 00:01 13313
  /memfd:memfd (deleted)
Size:               2056 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   0 kB
Pss:                   0 kB
Pss_Dirty:             0 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:            0 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
FilePmdMapped:         0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:    1
VmFlags: rd mr mw me dc hg
01400000-01800000 rw-p 00400000 00:01 13313
  /memfd:memfd (deleted)
Size:               4096 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   0 kB
Pss:                   0 kB
Pss_Dirty:             0 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:            0 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
FilePmdMapped:         0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:    1
VmFlags: rd wr mr mw me ac
AnonVMAs:
 # [  0] ffff8881149b1100 root=ffff8881149b1100 refcount=2 anon_vmas=4
num_children=2 num_active_vmas=3 parent=ffff8881149b1100
023ff000-02600000 rwxp 003ff000 00:01 13313
  /memfd:memfd (deleted)
Size:               2052 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   4 kB
Pss_Dirty:             4 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         4 kB
Referenced:            4 kB
Anonymous:             4 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
FilePmdMapped:         0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:    1
VmFlags: rd wr ex mr mw me dc ac
AnonVMAs:
 # [  0] ffff8881149b1100 root=ffff8881149b1100 refcount=2 anon_vmas=4
num_children=2 num_active_vmas=3 parent=ffff8881149b1100
02600000-02800000 rw-p 00600000 00:01 13313
  /memfd:memfd (deleted)
Size:               2048 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   0 kB
Pss:                   0 kB
Pss_Dirty:             0 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:            0 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
FilePmdMapped:         0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:    1
VmFlags: rd wr mr mw me dc ac
AnonVMAs:
 # [  0] ffff8881149b1100 root=ffff8881149b1100 refcount=2 anon_vmas=4
num_children=2 num_active_vmas=3 parent=ffff8881149b1100
[...]
=========== CHILD ===========
01400000-01800000 rw-p 00400000 00:01 13313
  /memfd:memfd (deleted)
Size:               4096 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   4 kB
Pss_Dirty:             4 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         4 kB
Referenced:            0 kB
Anonymous:             4 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
FilePmdMapped:         0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:    1
VmFlags: rd wr mr mw me ac
AnonVMAs:
   [  0] ffff8881149b1100 root=ffff8881149b1100 refcount=2 anon_vmas=4
num_children=2 num_active_vmas=3 parent=ffff8881149b1100
 #   [  1] ffff8881149b0cc0 root=ffff8881149b1100 refcount=1
anon_vmas=1 num_children=0 num_active_vmas=1 parent=ffff8881149b1100
[...]
user@vm:~/thp/thp_newbug$

--000000000000f44dc905f22a401e
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="HACK-thp-anonvma-logging-and-delay.diff"
Content-Disposition: attachment; 
	filename="HACK-thp-anonvma-logging-and-delay.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lcuvwgij0>
X-Attachment-Id: f_lcuvwgij0

ZGlmZiAtLWdpdCBhL2ZzL3Byb2MvdGFza19tbXUuYyBiL2ZzL3Byb2MvdGFza19tbXUuYwppbmRl
eCBlMzVhMDM5OGRiNjMuLjg2NWFkMDI2Y2FiMyAxMDA2NDQKLS0tIGEvZnMvcHJvYy90YXNrX21t
dS5jCisrKyBiL2ZzL3Byb2MvdGFza19tbXUuYwpAQCAtODU2LDYgKzg1NiwzOSBAQCBzdGF0aWMg
dm9pZCBfX3Nob3dfc21hcChzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIGNvbnN0IHN0cnVjdCBtZW1fc2l6
ZV9zdGF0cyAqbXNzLAogCXNlcV9wdXRzKG0sICIga0JcbiIpOwogfQogCitzdGF0aWMgdm9pZCBh
bm9uX3ZtYV9kdW1wX3JlY3Vyc2l2ZShzdHJ1Y3Qgc2VxX2ZpbGUgKm0sCisJCQkJICAgIHN0cnVj
dCB2bV9hcmVhX3N0cnVjdCAqdm1hLAorCQkJCSAgICBzdHJ1Y3QgYW5vbl92bWEgKnBhcmVudCwK
KwkJCQkgICAgaW50IGxldmVsKQoreworCXN0cnVjdCBhbm9uX3ZtYV9jaGFpbiAqYXZjOworCWlu
dCBpZHggPSAtMTsKKwlpbnQgaTsKKworCWxpc3RfZm9yX2VhY2hfZW50cnlfcmV2ZXJzZShhdmMs
ICZ2bWEtPmFub25fdm1hX2NoYWluLCBzYW1lX3ZtYSkgeworCQlzdHJ1Y3QgYW5vbl92bWEgKmF2
ID0gYXZjLT5hbm9uX3ZtYTsKKwkJc3RydWN0IGFub25fdm1hX2NoYWluICphdmMyOworCQl1bnNp
Z25lZCBsb25nIGFub25fdm1hX2NvdW50ID0gMDsKKworCQlpZHgrKzsKKwkJaWYgKChwYXJlbnQg
PT0gTlVMTCkgPyAoYXYgIT0gdm1hLT5hbm9uX3ZtYS0+cm9vdCkgOgorCQkgICAgKGF2LT5wYXJl
bnQgIT0gcGFyZW50IHx8IGF2ID09IHBhcmVudCkpCisJCQljb250aW51ZTsKKworCQlhbm9uX3Zt
YV9pbnRlcnZhbF90cmVlX2ZvcmVhY2goYXZjMiwgJmF2LT5yYl9yb290LCAwLCAtKHBnb2ZmX3Qp
MSkgeworCQkJYW5vbl92bWFfY291bnQrKzsKKwkJfQorCisJCXNlcV9wdXRzKG0sIChhdiA9PSB2
bWEtPmFub25fdm1hKSA/ICIgIyAiIDogIiAgICIpOworCQlmb3IgKGk9MDsgaTxsZXZlbDsgaSsr
KQorCQkJc2VxX3B1dHMobSwgIiAgIik7CisJCXNlcV9wcmludGYobSwgIlslM2RdICVweCByb290
PSVweCByZWZjb3VudD0lZCBhbm9uX3ZtYXM9JWx1IG51bV9jaGlsZHJlbj0lbHUgbnVtX2FjdGl2
ZV92bWFzPSVsdSBwYXJlbnQ9JXB4XG4iLAorCQkJICAgaWR4LCBhdiwgYXYtPnJvb3QsIGF0b21p
Y19yZWFkKCZhdi0+cmVmY291bnQpLAorCQkJICAgYW5vbl92bWFfY291bnQsIGF2LT5udW1fY2hp
bGRyZW4sIGF2LT5udW1fYWN0aXZlX3ZtYXMsIGF2LT5wYXJlbnQpOworCQlhbm9uX3ZtYV9kdW1w
X3JlY3Vyc2l2ZShtLCB2bWEsIGF2LCBsZXZlbCsxKTsKKwl9Cit9CisKIHN0YXRpYyBpbnQgc2hv
d19zbWFwKHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqdikKIHsKIAlzdHJ1Y3Qgdm1fYXJlYV9z
dHJ1Y3QgKnZtYSA9IHY7CkBAIC04ODEsNiArOTE0LDE0IEBAIHN0YXRpYyBpbnQgc2hvd19zbWFw
KHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqdikKIAkJc2VxX3ByaW50ZihtLCAiUHJvdGVjdGlv
bktleTogICU4dVxuIiwgdm1hX3BrZXkodm1hKSk7CiAJc2hvd19zbWFwX3ZtYV9mbGFncyhtLCB2
bWEpOwogCisJLyogZHVtcCBhbm9uX3ZtYSBpbmZvcm1hdGlvbiAqLworCWlmIChSRUFEX09OQ0Uo
dm1hLT5hbm9uX3ZtYSkpIHsKKwkJc2VxX3ByaW50ZihtLCAiQW5vblZNQXM6XG4iKTsKKwkJYW5v
bl92bWFfbG9ja193cml0ZSh2bWEtPmFub25fdm1hKTsKKwkJYW5vbl92bWFfZHVtcF9yZWN1cnNp
dmUobSwgdm1hLCBOVUxMLCAwKTsKKwkJYW5vbl92bWFfdW5sb2NrX3dyaXRlKHZtYS0+YW5vbl92
bWEpOworCX0KKwogCXJldHVybiAwOwogfQogCmRpZmYgLS1naXQgYS9tbS9raHVnZXBhZ2VkLmMg
Yi9tbS9raHVnZXBhZ2VkLmMKaW5kZXggNWNiNDAxYWEyYjlkLi5mMjVlNDA5ZWIxZjEgMTAwNjQ0
Ci0tLSBhL21tL2todWdlcGFnZWQuYworKysgYi9tbS9raHVnZXBhZ2VkLmMKQEAgLTE5LDYgKzE5
LDcgQEAKICNpbmNsdWRlIDxsaW51eC9wYWdlX3RhYmxlX2NoZWNrLmg+CiAjaW5jbHVkZSA8bGlu
dXgvc3dhcG9wcy5oPgogI2luY2x1ZGUgPGxpbnV4L3NobWVtX2ZzLmg+CisjaW5jbHVkZSA8bGlu
dXgvZGVsYXkuaD4KIAogI2luY2x1ZGUgPGFzbS90bGIuaD4KICNpbmNsdWRlIDxhc20vcGdhbGxv
Yy5oPgpAQCAtMTYxOSw2ICsxNjIwLDkgQEAgc3RhdGljIGludCByZXRyYWN0X3BhZ2VfdGFibGVz
KHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLCBwZ29mZl90IHBnb2ZmLAogCXN0cnVjdCB2
bV9hcmVhX3N0cnVjdCAqdm1hOwogCWludCB0YXJnZXRfcmVzdWx0ID0gU0NBTl9GQUlMOwogCisJ
cHJfd2FybigiJXM6IHJldHJhY3RfcGFnZV90YWJsZXMoKSwgY2MtPmlzX2todWdlcGFnZWQ9JWQs
IHRhcmdldF9tbT0lcHhcbiIsCisJCV9fZnVuY19fLCBjYy0+aXNfa2h1Z2VwYWdlZCwgdGFyZ2V0
X21tKTsKKwogCWlfbW1hcF9sb2NrX3dyaXRlKG1hcHBpbmcpOwogCXZtYV9pbnRlcnZhbF90cmVl
X2ZvcmVhY2godm1hLCAmbWFwcGluZy0+aV9tbWFwLCBwZ29mZiwgcGdvZmYpIHsKIAkJaW50IHJl
c3VsdCA9IFNDQU5fRkFJTDsKQEAgLTE2NDUsMjAgKzE2NDksMzcgQEAgc3RhdGljIGludCByZXRy
YWN0X3BhZ2VfdGFibGVzKHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLCBwZ29mZl90IHBn
b2ZmLAogCQkgKiB0aGUgYW5vbl92bWEuCiAJCSAqLwogCQlpZiAodm1hLT5hbm9uX3ZtYSkgewor
CQkJcHJfd2FybigiJXM6IHNraXBwaW5nIHZtYSBhdCAweCVseCBpbiBtbT0lcHggYmVjYXVzZSBh
bm9uX3ZtYVxuIiwKKwkJCQlfX2Z1bmNfXywgdm1hLT52bV9zdGFydCwgdm1hLT52bV9tbSk7CiAJ
CQlyZXN1bHQgPSBTQ0FOX1BBR0VfQU5PTjsKIAkJCWdvdG8gbmV4dDsKIAkJfQogCQlhZGRyID0g
dm1hLT52bV9zdGFydCArICgocGdvZmYgLSB2bWEtPnZtX3Bnb2ZmKSA8PCBQQUdFX1NISUZUKTsK
IAkJaWYgKGFkZHIgJiB+SFBBR0VfUE1EX01BU0sgfHwKIAkJICAgIHZtYS0+dm1fZW5kIDwgYWRk
ciArIEhQQUdFX1BNRF9TSVpFKSB7CisJCQlwcl93YXJuKCIlczogc2tpcHBpbmcgdm1hIGF0IDB4
JWx4IGluIG1tPSVweCBiZWNhdXNlIGFsaWduXG4iLAorCQkJCV9fZnVuY19fLCB2bWEtPnZtX3N0
YXJ0LCB2bWEtPnZtX21tKTsKIAkJCXJlc3VsdCA9IFNDQU5fVk1BX0NIRUNLOwogCQkJZ290byBu
ZXh0OwogCQl9CiAJCW1tID0gdm1hLT52bV9tbTsKIAkJaXNfdGFyZ2V0ID0gbW0gPT0gdGFyZ2V0
X21tICYmIGFkZHIgPT0gdGFyZ2V0X2FkZHI7CiAJCXJlc3VsdCA9IGZpbmRfcG1kX29yX3RocF9v
cl9ub25lKG1tLCBhZGRyLCAmcG1kKTsKLQkJaWYgKHJlc3VsdCAhPSBTQ0FOX1NVQ0NFRUQpCisJ
CWlmIChyZXN1bHQgIT0gU0NBTl9TVUNDRUVEKSB7CisJCQlwcl93YXJuKCIlczogc2tpcHBpbmcg
dm1hIGF0IDB4JWx4IGluIG1tPSVweCBiZWNhdXNlIG5vIFBNRFxuIiwKKwkJCQlfX2Z1bmNfXywg
dm1hLT52bV9zdGFydCwgdm1hLT52bV9tbSk7CiAJCQlnb3RvIG5leHQ7CisJCX0KKworCQlpZiAo
Y2MtPmlzX2todWdlcGFnZWQgJiYgbW0gPT0gdGFyZ2V0X21tICYmIHZtYS0+dm1fc3RhcnQgPT0g
MHgyNDAwMDAwLTB4MTAwMCkgeworCQkJcHJfd2FybigiJXM6IHNsZWVwaW5nIGJlZm9yZSBtbWFw
IGxvY2suLi5cbiIsIF9fZnVuY19fKTsKKwkJCW1kZWxheSgzMDAwKTsKKwkJCXByX3dhcm4oIiVz
OiBkb25lIHNsZWVwaW5nXG4iLCBfX2Z1bmNfXyk7CisJCX0gZWxzZSB7CisJCQlwcl93YXJuKCIl
czogcnVubmluZyBvbiB2bWEgYXQgMHglbHggaW4gbW09JXB4XG4iLAorCQkJCV9fZnVuY19fLCB2
bWEtPnZtX3N0YXJ0LCB2bWEtPnZtX21tKTsKKwkJfQorCiAJCS8qCiAJCSAqIFdlIG5lZWQgZXhj
bHVzaXZlIG1tYXBfbG9jayB0byByZXRyYWN0IHBhZ2UgdGFibGUuCiAJCSAqCkBAIC0xNjg4LDcg
KzE3MDksOSBAQCBzdGF0aWMgaW50IHJldHJhY3RfcGFnZV90YWJsZXMoc3RydWN0IGFkZHJlc3Nf
c3BhY2UgKm1hcHBpbmcsIHBnb2ZmX3QgcGdvZmYsCiAJCQkJcmVzdWx0ID0gU0NBTl9QVEVfVUZG
RF9XUDsKIAkJCQlnb3RvIHVubG9ja19uZXh0OwogCQkJfQorCQkJcHJfd2FybigiJXM6IGFib3V0
IHRvIGNhbGwgY29sbGFwc2VfYW5kX2ZyZWVfcG1kKClcbiIsIF9fZnVuY19fKTsKIAkJCWNvbGxh
cHNlX2FuZF9mcmVlX3BtZChtbSwgdm1hLCBhZGRyLCBwbWQpOworCQkJcHJfd2FybigiJXM6IGRv
bmUgd2l0aCBjb2xsYXBzZV9hbmRfZnJlZV9wbWQoKVxuIiwgX19mdW5jX18pOwogCQkJaWYgKCFj
Yy0+aXNfa2h1Z2VwYWdlZCAmJiBpc190YXJnZXQpCiAJCQkJcmVzdWx0ID0gc2V0X2h1Z2VfcG1k
KHZtYSwgYWRkciwgcG1kLCBocGFnZSk7CiAJCQllbHNlCmRpZmYgLS1naXQgYS9tbS9wYWdlX3Zt
YV9tYXBwZWQuYyBiL21tL3BhZ2Vfdm1hX21hcHBlZC5jCmluZGV4IDkzZTEzZmMxN2QzYy4uNzcx
YTAxMjQzMjliIDEwMDY0NAotLS0gYS9tbS9wYWdlX3ZtYV9tYXBwZWQuYworKysgYi9tbS9wYWdl
X3ZtYV9tYXBwZWQuYwpAQCAtNCw2ICs0LDcgQEAKICNpbmNsdWRlIDxsaW51eC9odWdldGxiLmg+
CiAjaW5jbHVkZSA8bGludXgvc3dhcC5oPgogI2luY2x1ZGUgPGxpbnV4L3N3YXBvcHMuaD4KKyNp
bmNsdWRlIDxsaW51eC9kZWxheS5oPgogCiAjaW5jbHVkZSAiaW50ZXJuYWwuaCIKIApAQCAtMTYs
NiArMTcsMTkgQEAgc3RhdGljIGlubGluZSBib29sIG5vdF9mb3VuZChzdHJ1Y3QgcGFnZV92bWFf
bWFwcGVkX3dhbGsgKnB2bXcpCiBzdGF0aWMgYm9vbCBtYXBfcHRlKHN0cnVjdCBwYWdlX3ZtYV9t
YXBwZWRfd2FsayAqcHZtdykKIHsKIAlwdm13LT5wdGUgPSBwdGVfb2Zmc2V0X21hcChwdm13LT5w
bWQsIHB2bXctPmFkZHJlc3MpOworCisJaWYgKHN0cmNtcChjdXJyZW50LT5jb21tLCAiVEVTVDEi
KSA9PSAwKSB7CisJCXByX3dhcm4oIiVzOiBleGVjdXRpbmcgdW5kZXIgVEVTVDEgcHZtdy0+dm1h
LT52bV9tbT09JXB4IHB2bXctPnZtYS0+dm1fc3RhcnQ9MHglbHhcbiIsCisJCQlfX2Z1bmNfXywg
cHZtdy0+dm1hLT52bV9tbSwgcHZtdy0+dm1hLT52bV9zdGFydCk7CisJCWlmIChjdXJyZW50LT5t
bSA9PSBwdm13LT52bWEtPnZtX21tIHx8IHB2bXctPnZtYS0+dm1fc3RhcnQgIT0gMHgyNDAwMDAw
LTB4MTAwMCkgeworCQkJcHJfd2FybigiJXM6ICAgLi4uIGNvbnRpbnVpbmdcbiIsIF9fZnVuY19f
KTsKKwkJfSBlbHNlIHsKKwkJCXByX3dhcm4oIiVzOiAgIC4uLiBiZWdpbiBkZWxheS4uLlxuIiwg
X19mdW5jX18pOworCQkJbWRlbGF5KDM1MDApOworCQkJcHJfd2FybigiJXM6ICAgLi4uIGVuZCBk
ZWxheVxuIiwgX19mdW5jX18pOworCQl9CisJfQorCiAJaWYgKCEocHZtdy0+ZmxhZ3MgJiBQVk1X
X1NZTkMpKSB7CiAJCWlmIChwdm13LT5mbGFncyAmIFBWTVdfTUlHUkFUSU9OKSB7CiAJCQlpZiAo
IWlzX3N3YXBfcHRlKCpwdm13LT5wdGUpKQo=
--000000000000f44dc905f22a401e
Content-Type: text/x-csrc; charset="US-ASCII"; name="thp_newbug.c"
Content-Disposition: attachment; filename="thp_newbug.c"
Content-Transfer-Encoding: base64
Content-ID: <f_lcuw9und1>
X-Attachment-Id: f_lcuw9und1

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8ZXJyLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4K
I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPGZjbnRsLmg+
CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPGFzc2VydC5oPgojaW5jbHVkZSA8c3lzL21t
YW4uaD4KI2luY2x1ZGUgPHN5cy91aW8uaD4KI2luY2x1ZGUgPHN5cy93YWl0Lmg+CiNpbmNsdWRl
IDxzeXMvcHJjdGwuaD4KI2luY2x1ZGUgPHN5cy9ldmVudGZkLmg+CiNpbmNsdWRlIDxzeXMvc3lz
Y2FsbC5oPgoKI2lmbmRlZiBNQURWX1BBR0VPVVQKI2RlZmluZSBNQURWX1BBR0VPVVQgMjEKI2Vu
ZGlmCgojZGVmaW5lIFNZU0NISyh4KSAoeyAgICAgICAgICBcCiAgdHlwZW9mKHgpIF9fcmVzID0g
KHgpOyAgICAgIFwKICBpZiAoX19yZXMgPT0gKHR5cGVvZih4KSktMSkgXAogICAgZXJyKDEsICJT
WVNDSEsoIiAjeCAiKSIpOyBcCiAgX19yZXM7ICAgICAgICAgICAgICAgICAgICAgIFwKfSkKCi8v
IE5PVEU6IGFzc3VtZXMgaHVnZXBhZ2Ugc3VwcG9ydCBpcyBzZXQgdG8gbWFkdmlzZS1vbmx5IGFu
ZCBzaG1lbSB0aHAgaXMgc2V0Ci8vIHRvICJmb3JjZSIuCmludCBtYWluKHZvaWQpIHsKI2lmIDAK
ICAvLyBmb3IgYmV0dGVyIGNvcnJlbGF0aW9uIG9mIGV2ZW50cyBpbiBkbWVzZwogIEZJTEUgKmtt
c2dfZmlsZSA9IGZvcGVuKCIvZGV2L2ttc2ciLCAidyIpOwogIGlmICgha21zZ19maWxlKQogICAg
ZXJyeCgxLCAib3BlbiBrbXNnIik7CiAgc2V0bGluZWJ1ZihrbXNnX2ZpbGUpOwojZWxzZQogIC8v
IGZvciBydW5uaW5nIHVucHJpdmlsZWdlZAogICNkZWZpbmUga21zZ19maWxlIHN0ZGVycgojZW5k
aWYKCiAgLy8gY3JlYXRlIGEgbWVtZmQgY29udGFpbmluZyA4IE1pQiBvZiBkYXRhLCB3aXRoIHNv
bWUgZXh0cmEgYmFjay1hbmQtZm9ydGgKICAvLyB0byBhdm9pZCBoYXZpbmcgdHJhbnNodWdlIHNo
bWVtIHBhZ2VzIGF0IHRoaXMgcG9pbnQgZXZlbiBpbiAiZm9yY2UiIG1vZGUKICBpbnQgZmQgPSBT
WVNDSEsoc3lzY2FsbChfX05SX21lbWZkX2NyZWF0ZSwgIm1lbWZkIiwgMCkpOwogIGZvciAoaW50
IGk9MDsgaTw0KjUxMjsgaSsrKSB7CiAgICBjaGFyIGR1bW15X3BhZ2VbMHgxMDAwXTsKICAgIG1l
bXNldChkdW1teV9wYWdlLCAnUCcsIDB4MTAwMCk7CiAgICBhc3NlcnQoU1lTQ0hLKHB3cml0ZShm
ZCwgZHVtbXlfcGFnZSwgMHgxMDAwLCBpKjB4MTAwMCkpID09IDB4MTAwMCk7CiAgfQogIFNZU0NI
SyhmYWxsb2NhdGUoZmQsIEZBTExPQ19GTF9QVU5DSF9IT0xFfEZBTExPQ19GTF9LRUVQX1NJWkUs
IDB4NDAwMCwgMHgxMDAwKSk7CiAgU1lTQ0hLKGZhbGxvY2F0ZShmZCwgRkFMTE9DX0ZMX1BVTkNI
X0hPTEV8RkFMTE9DX0ZMX0tFRVBfU0laRSwgMHgyMDQwMDAsIDB4MTAwMCkpOwogIFNZU0NISyhm
YWxsb2NhdGUoZmQsIEZBTExPQ19GTF9QVU5DSF9IT0xFfEZBTExPQ19GTF9LRUVQX1NJWkUsIDB4
NDA0MDAwLCAweDEwMDApKTsKICBTWVNDSEsoZmFsbG9jYXRlKGZkLCBGQUxMT0NfRkxfUFVOQ0hf
SE9MRXxGQUxMT0NfRkxfS0VFUF9TSVpFLCAweDYwNDAwMCwgMHgxMDAwKSk7CiAgZm9yIChpbnQg
aT0wOyBpPDQqNTEyOyBpKyspIHsKICAgIGNoYXIgZHVtbXlfcGFnZVsweDEwMDBdOwogICAgbWVt
c2V0KGR1bW15X3BhZ2UsICdQJywgMHgxMDAwKTsKICAgIGFzc2VydChTWVNDSEsocHdyaXRlKGZk
LCBkdW1teV9wYWdlLCAweDEwMDAsIGkqMHgxMDAwKSkgPT0gMHgxMDAwKTsKICB9CgogIC8vIGNy
ZWF0ZSB0cmlnZ2VyX3ZtYSAoMiBNaUIsIG9mZnNldCA0IE1pQikKICBjaGFyICp0cmlnZ2VyX3Zt
YSA9IFNZU0NISyhtbWFwKCh2b2lkKikweDIwMDAwMCAtIDB4MjAwMCwgMHgyMDAwMDAgKyAweDIw
MDAsIFBST1RfUkVBRCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1BUF9QUklW
QVRFfE1BUF9GSVhFRF9OT1JFUExBQ0UsIGZkLCAweDQwMDAwMCAtIDB4MjAwMCkpICsgMHgyMDAw
OwogIFNZU0NISyhtYWR2aXNlKHRyaWdnZXJfdm1hLTB4MjAwMCwgMHgyMDAwMDArMHgyMDAwLCBN
QURWX0RPTlRGT1JLKSk7CgogIC8vIGNyZWF0ZSBtYXBwaW5nMSAoOCBNaUIsIGZ1bGwgZmlsZSkK
ICBjaGFyICptYXBwaW5nMSA9IFNZU0NISyhtbWFwKCh2b2lkKikweDEwMDAwMDAsIDB4ODAwMDAw
LCBQUk9UX1JFQUR8UFJPVF9XUklURSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1B
UF9QUklWQVRFfE1BUF9GSVhFRF9OT1JFUExBQ0UsIGZkLCAwKSk7CgogIC8vIGNyZWF0ZSBhbm9u
IHBhZ2UgYW5kIGFub25fdm1hIGluIG1hcHBpbmcxIChhdCBvZmZzZXQgNCBNaUIpCiAgKih2b2xh
dGlsZSBjaGFyICopKG1hcHBpbmcxICsgMHg0MDAwMDApID0gMTsKCiAgLy8gbWFrZSBpdCBzbyB0
aGF0IHdlIGVuZCB1cCB3aXRoIHR3byBWTUFzIHRoYXQgc2hhcmUgYW4gYW5vbl92bWEgYW5kIGhh
dmUgdGhlCiAgLy8gc2FtZSBvZmZzZXQgcmFuZ2UuCiAgLy8gc3RhcnQgd2l0aCBhIHBsYWNlaG9s
ZGVyIG1hcHBpbmcsIHRoZW4gbXJlbWFwIG92ZXIgaXQuCiAgY2hhciAqbWFwcGluZzIgPSBTWVND
SEsobW1hcCgodm9pZCopMHgyMDAwMDAwLCAweDgwMDAwMCwgUFJPVF9OT05FLAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgTUFQX1BSSVZBVEV8TUFQX0FOT05ZTU9VU3xNQVBfRklYRURf
Tk9SRVBMQUNFLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLTEsIDApKTsKICAvLyBt
b3ZlCiAgU1lTQ0hLKG1yZW1hcChtYXBwaW5nMSwgMHg0MDAwMDAsIDB4NDAwMDAwLCBNUkVNQVBf
TUFZTU9WRXxNUkVNQVBfRklYRUQsCiAgICAgICAgICAgICAgICBtYXBwaW5nMikpOwogIC8vIGV4
cGFuZAogIG11bm1hcChtYXBwaW5nMisweDQwMDAwMCwgMHg0MDAwMDApOwogIFNZU0NISyhtcmVt
YXAobWFwcGluZzIsIDB4NDAwMDAwLCAweDgwMDAwMCwgMCkpOwogIC8vIHRyaW0KICBTWVNDSEso
bXVubWFwKG1hcHBpbmcyLCAweDQwMDAwMCkpOwogIC8vIHJlcGxhY2UgZmlyc3QgaGFsZiBvZiBt
YXBwaW5nMiB3aXRoIGEgbmV3IHZtYSwgbm90IG1lcmdlYWJsZSBidXQKICAvLyBhbm9udm1hLW1l
cmdlYWJsZS4KICAvLyB3aXRoIGFuIGV4dHJhIHBhZ2UgaW4gZnJvbnQgdG8gbWFrZSBpdCBnbyBm
aXJzdCBpbiB0aGUgYW5vbl92bWEgaW50ZXJ2YWwKICAvLyB0cmVlLgogIFNZU0NISyhtbWFwKG1h
cHBpbmcyKzB4NDAwMDAwLTB4MTAwMCwgMHgxMDAwKzB4MjAwMDAwLCBQUk9UX1JFQUR8UFJPVF9X
UklURXxQUk9UX0VYRUMsCiAgICAgICAgICAgICAgTUFQX1BSSVZBVEV8TUFQX0ZJWEVELCBmZCwg
MHg0MDAwMDAtMHgxMDAwKSk7CiAgLy8gZG9uJ3QgaW5oZXJpdCBlaXRoZXIgaGFsZiBvZiBtYXBw
aW5nMgogIFNZU0NISyhtYWR2aXNlKG1hcHBpbmcyKzB4NDAwMDAwLTB4MTAwMCwgMHg0MDAwMDAr
MHgxMDAwLCBNQURWX0RPTlRGT1JLKSk7CgogIC8vIGluaGVyaXQgbWFwcGluZzEgaW4gY2hpbGQK
ICBpbnQgY2hpbGRfY29udF9mZCA9IFNZU0NISyhldmVudGZkKDAsIEVGRF9TRU1BUEhPUkUpKTsK
ICBwaWRfdCBjaGlsZCA9IFNZU0NISyhmb3JrKCkpOwogIGlmIChjaGlsZCA9PSAwKSB7CiAgICBT
WVNDSEsocHJjdGwoUFJfU0VUX1BERUFUSFNJRywgU0lHS0lMTCkpOwogICAgaWYgKGdldHBwaWQo
KSA9PSAxKQogICAgICBleGl0KDEpOwoKICAgIGV2ZW50ZmRfdCBkdW1teV92YWw7CiAgICBTWVND
SEsoZXZlbnRmZF9yZWFkKGNoaWxkX2NvbnRfZmQsICZkdW1teV92YWwpKTsKCiAgICBmcHJpbnRm
KGttc2dfZmlsZSwgImNoaWxkIGhpdHRpbmcgcm1hcC4uLlxuIik7CiAgICBwcmN0bChQUl9TRVRf
TkFNRSwgIlRFU1QxIik7CiAgICBTWVNDSEsobWFkdmlzZShtYXBwaW5nMSsweDQwMDAwMCwgMHgx
MDAwLCBNQURWX1BBR0VPVVQpKTsKICAgIHByY3RsKFBSX1NFVF9OQU1FLCAidGhwX25ld2J1Z19j
aGlsZCIpOwogICAgZnByaW50ZihrbXNnX2ZpbGUsICJjaGlsZCBkb25lIHdpdGggcm1hcFxuIik7
CgogICAgc2xlZXAoMTApOwogICAgY2hhciBjbWRbMTAwMF07CiAgICBzcHJpbnRmKGNtZCwgImVj
aG87IGVjaG8gPT09PT09PT09PT0gUEFSRU5UID09PT09PT09PT09OyBoZWFkIC1uMTIwIC9wcm9j
LyVkL3NtYXBzOyBlY2hvOyBlY2hvID09PT09PT09PT09IENISUxEID09PT09PT09PT09OyBoZWFk
IC1uNjAgL3Byb2MvJWQvc21hcHMiLCBnZXRwcGlkKCksIGdldHBpZCgpKTsKICAgIHN5c3RlbShj
bWQpOwogICAgZXhpdCgwKTsKICB9CgogIC8vIHBvcHVsYXRlIFBURXMgaW4gdHJpZ2dlcl92bWEg
YW5kIG1hcHBpbmcyIHdpdGggc2htZW0gcGFnZXMKICBmb3IgKGludCBpPTA7IGk8NTEyOyBpKysp
CiAgICAoKHZvbGF0aWxlIGNoYXIgKil0cmlnZ2VyX3ZtYSlbaSoweDEwMDBdOwogIGZvciAoaW50
IGk9MDsgaTw1MTI7IGkrKykKICAgICgodm9sYXRpbGUgY2hhciAqKW1hcHBpbmcyKVsweDQwMDAw
MCArIGkqMHgxMDAwXTsKCiAgLy8gZ2V0IHJpZCBvZiBwYXJlbnQncyBtYXBwaW5nIG9mIGFub24g
cGFnZSBzbyB0aGF0IE1BRFZfUEFHRU9VVCB3b3JrcwogIFNZU0NISyhtYWR2aXNlKG1hcHBpbmcx
KzB4NDAwMDAwLCAweDEwMDAsIE1BRFZfRE9OVE5FRUQpKTsKICAKICBzbGVlcCgxKTsKCiAgLy8g
ZW5hYmxlIGh1Z2VwYWdlIHN1cHBvcnQgZm9yIHRyaWdnZXJfdm1hIHRvIG1ha2Uga2h1Z2VwYWdl
ZCBsb29rIGF0IHVzCiAgU1lTQ0hLKG1hZHZpc2UodHJpZ2dlcl92bWEtMHgyMDAwLCAweDIwMDAw
MCsweDIwMDAsIE1BRFZfSFVHRVBBR0UpKTsKCiAgLy8gd2FpdCBmb3Iga2h1Z2VwYWdlZCAocmVs
aWVzIG9uIGZpcnN0IHZtYSBiZWluZyB0cmlnZ2VyIFZNQSkKICBpbnQgcGFyZW50X3NtYXBzX2Zk
ID0gU1lTQ0hLKG9wZW4oIi9wcm9jL3NlbGYvc21hcHMiLCBPX1JET05MWSkpOwogIHdoaWxlICgx
KSB7CiAgICBjaGFyIHBhcmVudF9zbWFwc1sweDEwMDFdOwogICAgaW50IHBhcmVudF9zbWFwc19s
ZW4gPSBTWVNDSEsocHJlYWQocGFyZW50X3NtYXBzX2ZkLCBwYXJlbnRfc21hcHMsIDB4MTAwMCwg
MCkpOwogICAgcGFyZW50X3NtYXBzW3BhcmVudF9zbWFwc19sZW5dID0gJ1wwJzsKICAgIGNoYXIg
KmxpbmUgPSBzdHJzdHIocGFyZW50X3NtYXBzLCAiXG5Sc3M6Iik7CiAgICBpZiAoIWxpbmUpCiAg
ICAgIGVycngoMSwgIm5vIFJzcyBpbiBzbWFwc19yb2xsdXA/Iik7CiAgICBjaGFyICpudW1wdHIg
PSBsaW5lICsgc3RybGVuKCJcblJzczoiKTsKICAgIHdoaWxlICgqbnVtcHRyID09ICcgJyB8fCAq
bnVtcHRyID09ICdcdCcpIG51bXB0cisrOwogICAgaW50IHJzcyA9IGF0b2kobnVtcHRyKTsKICAg
IHByaW50ZigiUnNzID0gJWQga0JcbiIsIHJzcyk7CiAgICBpZiAocnNzID09IDApCiAgICAgIGJy
ZWFrOwogICAgdXNsZWVwKDEwMDAqMTAwKTsKICB9CgogIGZwcmludGYoa21zZ19maWxlLCAia2h1
Z2VwYWdlZCBpcyBhYm91dCB0byB3cml0ZV90cnlsb2NrISBhc3NvY2lhdGluZyBhbm9uX3ZtYS4u
LlxuIik7CiAgKih2b2xhdGlsZSBjaGFyICopKG1hcHBpbmcyICsgMHg0MDAwMDAgLSAweDEwMDAp
ID0gMTsKICBmcHJpbnRmKGttc2dfZmlsZSwgImFub25fdm1hIGFzc29jaWF0ZWQsIHRlbGxpbmcg
Y2hpbGQgdG8gaGl0IHJtYXAgbm93Li4uXG4iKTsKCiAgU1lTQ0hLKGV2ZW50ZmRfd3JpdGUoY2hp
bGRfY29udF9mZCwgMSkpOwoKCiAgLy8gd2FpdCBmb3IgY2hpbGQKICBpbnQgd3N0YXR1czsKICBT
WVNDSEsod2FpdHBpZChjaGlsZCwgJndzdGF0dXMsIDApKTsKCiAgZXhpdCgwKTsKfQo=
--000000000000f44dc905f22a401e--
