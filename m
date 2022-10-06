Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F94A5F6453
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJFKYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiJFKYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:24:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29AC5F8E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 03:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E41C5618DB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 10:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B6EC433C1;
        Thu,  6 Oct 2022 10:24:33 +0000 (UTC)
Date:   Thu, 6 Oct 2022 11:24:30 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     James Morse <james.morse@arm.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        tongtiangen@huawei.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Will Deacon <will@kernel.org>,
        syzbot <syzbot+c2c79c6d6eddc5262b77@syzkaller.appspotmail.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [syzbot] KASAN: invalid-access Read in copy_page
Message-ID: <Yz6s3lk2cpmOSWHg@arm.com>
References: <0000000000004387dc05e5888ae5@google.com>
 <CA+fCnZc9u+QrF-JCQSA+uCM9-egh_=9x4hPdJng6T_uh6XWMZQ@mail.gmail.com>
 <YxdJ684ypgAy8k98@arm.com>
 <CACT4Y+YOnTpWT5NCNhsPY=kV=2gFfQkY=7xGdU_1k7AdGhQneg@mail.gmail.com>
 <YxdZXvsWr37RrFRk@arm.com>
 <CA+fCnZf-GOZpnBRLkRPrL7FUwYrAb-bu=PV0zMfbKOuNYrZ00A@mail.gmail.com>
 <Yxd0C7ndn+iPAGcj@arm.com>
 <CA+fCnZcpba7qinx4DmuJPjRQj07uJ5H9Xq9Zhi8v1rw-AW_yWQ@mail.gmail.com>
 <830e8c64-0118-9a2d-5dcf-5cad55425dc2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <830e8c64-0118-9a2d-5dcf-5cad55425dc2@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 01:38:55PM +0100, James Morse wrote:
> On 27/09/2022 17:55, Andrey Konovalov wrote:
> > On Tue, Sep 6, 2022 at 6:23 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> On Tue, Sep 06, 2022 at 04:39:57PM +0200, Andrey Konovalov wrote:
> >>> On Tue, Sep 6, 2022 at 4:29 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >>>>>> Does it take long to reproduce this kasan warning?
> >>>>>
> >>>>> syzbot finds several such cases every day (200 crashes for the past 35 days):
> >>>>> https://syzkaller.appspot.com/bug?extid=c2c79c6d6eddc5262b77
> >>>>> So once it reaches the tested tree, we should have an answer within a day.
[...]
> I've reproduced this with the latest qemu and v6.0 kernel using ubuntu 15.04 user-space.
> 
> The reproducer is just to log in once its booted. The vm has swap, and I've turned the
> memory down low enough to force it to swap. The round trip time is about 15 minutes.
> 
> I've not managed to reproduce it without swap, or with more memory. (but it may be a
> timing thing)

Thanks James. I got the error without swap enabled. Just booted Debian
under Qemu with 256MB of RAM (no graphics), did an 'ls -lR /' and it
triggered shortly after. There's no MTE used in user-space.

==================================================================
BUG: KASAN: invalid-access in copy_page+0x10/0xd0
Read at addr f9ff0000050ba000 by task kcompactd0/28
Pointer tag: [f9], memory tag: [f8]

CPU: 0 PID: 28 Comm: kcompactd0 Tainted: G        W          6.0.0-rc3-dirty #1
Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
Call trace:
 dump_backtrace.part.0+0xdc/0xf0
 show_stack+0x1c/0x4c
 dump_stack_lvl+0x68/0x84
 print_report+0x104/0x610
 kasan_report+0x90/0xb0
 __do_kernel_fault+0x70/0x194
 do_tag_check_fault+0x7c/0x90
 do_mem_abort+0x48/0xa0
 el1_abort+0x40/0x60
 el1h_64_sync_handler+0xdc/0xec
 el1h_64_sync+0x64/0x68
 copy_page+0x10/0xd0
 folio_copy+0x50/0xb0
 migrate_folio+0x50/0x9c
 move_to_new_folio+0xc0/0x1d4
 migrate_pages+0x16b4/0x1740
 compact_zone+0x66c/0xb0c
 proactive_compact_node+0x70/0xac
 kcompactd+0x1b4/0x370
 kthread+0x110/0x114
 ret_from_fork+0x10/0x20

The buggy address belongs to the physical page:
page:000000007339140a refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff90019 pfn:0x450ba
memcg:f9ff0000052e4000
anon flags: 0x3fffc180088000d(locked|uptodate|dirty|swapbacked|arch_2|node=0|zone=0|lastcpupid=0xffff|kasantag=0x6)
raw: 03fffc180088000d fffffc0000142e48 ffff80000815bd68 fdff000001c738c1
raw: 0000000ffff90019 0000000000000000 00000001ffffffff f9ff0000052e4000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000050b9e00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffff0000050b9f00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
>ffff0000050ba000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffff0000050ba100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffff0000050ba200: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================

It looks like it always happens on read. Something updated the tag in
page->flags for an existing page (or repainted the page, though less
likely as I think the page is in use).

I'm surprised that even without MTE in user-space, we still get
PG_mte_tagged (arch_2) set. Time for more printks.

-- 
Catalin
