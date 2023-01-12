Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF6B666E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbjALJ3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239994AbjALJ3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:29:02 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29FA5004F
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:23:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A34C33F8E4;
        Thu, 12 Jan 2023 08:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673513374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awrr/2eQN8kHkx6Ll5v8jHUAG0dqkLvR+E0A3pmoohk=;
        b=jWeR+7UIObZEbVO/mD4onmOCHgzhSCgnWorYu/Z3N13Rw2r9MAm9wdc8vQ7aQoQMPyjC3v
        XwW2tS8N0MiVEBy+AM8A31ZeP2aY05b9S+U6aGAz983scZgzxtCFDG3RHrS9fhDFIMblVv
        LbP6XWtAlH8WOM1coB28++bWCMnXmJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673513374;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awrr/2eQN8kHkx6Ll5v8jHUAG0dqkLvR+E0A3pmoohk=;
        b=YoSB7387XvbuoFauipzh5bfoYxDHT6Mh8BCnZI6nvW2pPTLRBGHcmcfXC5K4NNqVva7y0Q
        7prG70yQy4+E3DDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78D2013776;
        Thu, 12 Jan 2023 08:49:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QlC0HJ7Jv2PJDAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 12 Jan 2023 08:49:34 +0000
Message-ID: <e443af8a-6fde-bd5a-3e5b-e30f7d5ac578@suse.cz>
Date:   Thu, 12 Jan 2023 09:49:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [linus:master] [mm, slub] 0af8489b02:
 kernel_BUG_at_include/linux/mm.h
Content-Language: en-US
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
References: <202212312021.bc1efe86-oliver.sang@intel.com>
 <41276905-b8a5-76ae-8a17-a8ec6558e988@suse.cz>
 <Y7Qxucg5le7WOzr7@xsang-OptiPlex-9020> <Y7VBFLHY/PMbb4XS@hyeyoo>
 <Y7Yr3kEkDEd51xns@xsang-OptiPlex-9020>
 <3f7fa3b3-9623-5c4c-94b1-a41dea6eaaf2@suse.cz>
 <Y7weKyxIY+QFYq6j@xsang-OptiPlex-9020> <Y71t89JMgtRoNHM/@xsang-OptiPlex-9020>
 <d024b846-9282-4ecd-eafd-2e5571932a72@suse.cz>
 <Y7+7KUyuo/9HeCF2@xsang-OptiPlex-9020>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y7+7KUyuo/9HeCF2@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/23 08:47, Oliver Sang wrote:
> hi, Vlastimil,
> 
> On Tue, Jan 10, 2023 at 03:09:36PM +0100, Vlastimil Babka wrote:
>> On 1/10/23 14:53, Oliver Sang wrote:
>> > hi all,
>> > 
>> > On Mon, Jan 09, 2023 at 10:01:15PM +0800, Oliver Sang wrote:
>> >> 
>> >> On Fri, Jan 06, 2023 at 11:13:15AM +0100, Vlastimil Babka wrote:
>> >> 
>> >> > And if the rate at the parent (has it increased thanks to the
>> >> > DEBUG_PAGEALLOC?) is sufficient to bisect to the truly first bad commit. Thanks!
>> >> 
>> >> got it. Thanks for suggestion!
>> >> 
>> >> since 0af8489b02 is based on v6.1-rc2, we will test (both rectorture and boot)
>> >> with same config upon v6.1-rc2 to see if it's really clean there.
>> >> if so we will use dmesg.invalid_opcode:#[##] to trigger new bisect.
>> >> 
>> >> will keep you updated. Thanks
>> > 
>> > by more tests, we cannot make sure the v6.1-rc2 is clean, so we also checked
>> > v6.1-rc1 and v6.0. from results, we have low confidence that we can make a
>> > successful bisection based on them [1][2]. could you suggest?
>> 
>> So am I reading it right, that the probleam appears to be introduced between
>> v6.0 (0 failures) and v6.1-rc1 (>0 failures)? But agree that with such low
>> incidence, it's hard to bisect.
> 
> yeah, you are reading it right :)
> 
>> 
>> > a further information not sure if it's helpful, [1][2] are both i386 based.
>> > we also tried to run boot tests on x86_64 upon commit 0af8489b02, whatever
>> > with or without CONFIG_DEBUG_PAGEALLOC/CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT,
>> > we never obseve similar issues (also run 999 times).
>> 
>> Yeah it looks very much like something that manifests only on i386 (perhaps
>> only in QEMU as well?) and never x86_64.
>> 
>> What might be interesting then is v6.1-rc1 with further modified config to
>> enabled CONFIG_SLUB_DEBUG and CONFIG_SLUB_DEBUG_ON. Maybe it will catch the
>> culprit sooner. Or maybe it will obscure the bug instead, unfortunately.
> 
> oh, seems, unfortunalately, 'obscure' happen :(
> 
> we enabled CONFIG_SLUB_DEBUG and CONFIG_SLUB_DEBUG_ON, along with
> CONFIG_DEBUG_PAGEALLOC and CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT
> 
> boot (we also add the test for v6.2-rc3):
> =========================================================================================
> compiler/kconfig/rootfs/sleep/tbox_group/testcase:
>   gcc-11/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT+CONFIG_SLUB_DEBUG_ON/debian-11.1-i386-20220923.cgz/1/vm-snb/boot
> 
>             v6.0                    v6.1-rc1                    v6.1-rc2 56d5a2b9ba85a390473e86b4fe4 0af8489b0216fa1dd83e264bef8                    v6.2-rc3
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- ---------------------------
>        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
>            |             |             |             |             |             |             |             |             |             |             |
>          43:999          3%          68:999          4%          84:999          6%          99:999          5%          94:999          4%          86:999   dmesg.invalid_opcode:#[##]
>           4:999         -0%           2:999          0%           7:999          0%           8:999          0%           4:999         -0%            :999   dmesg.kernel_BUG_at_include/linux/mm.h
>           3:999          0%           4:999          0%           3:999          0%           7:999          0%           5:999          1%           9:999   dmesg.kernel_BUG_at_include/linux/page-flags.h
>          34:999          3%          61:999          4%          73:999          5%          81:999          5%          85:999          4%          74:999   dmesg.kernel_BUG_at_lib/list_debug.c
>            :999          0%            :999          0%            :999          0%           1:999          0%            :999          0%            :999   dmesg.kernel_BUG_at_mm/internal.h
>           3:999         -0%           1:999         -0%            :999         -0%           2:999         -0%            :999         -0%           2:999   dmesg.kernel_BUG_at_mm/page_alloc.c
>            :999          0%            :999          0%           2:999          0%            :999          0%            :999          0%           2:999   dmesg.kernel_BUG_at_mm/usercopy.c
> 
> 
> since now even the v6.0 is not clean, attached one dmesg FYI

Interesting one, btw.

> [   38.392164][  T193] page:e6c3e400 refcount:1 mapcount:0 mapping:00000000 index:0x0 pfn:0x9e80
> [   38.393441][  T193] head:e6c3e2c0 order:3 compound_mapcount:0 compound_pincount:0

Yay, struct page pointers no longer hashed for printing, thanks to slub_debug.
Head page is order-3 (8 pages), yet e6c3e400 would be 9th page, nonsense.

> [   38.394491][  T193] flags: 0x10200(slab|head|zone=0)
> [   38.395181][  T193] raw: 00010000 e6c3e2c1 00000122 00000400 00000000 00000000 ffffffff 00000001

We have head flag, compound_head is e6c3e2c0+PageTail, there's again
00000400 in mapping that's specifically set by prep_compound_tail().

> [   38.396386][  T193] raw: 00000000 00000000
> [   38.396956][  T193] head: 00010200 e6ac7904 c01007f0 c0101a40 c9e79a00 00150004 ffffffff 00000001

00150004 are slub's counters suggesting it's been used for a while, we
should not be racing with e6c3e2c0's allocation here!

> [   38.398161][  T193] head: 00000000 00000000
> [   38.398775][  T193] page dumped because: VM_BUG_ON_PAGE(PageTail(page))
> [   38.399724][  T193] page_owner tracks the page as allocated
> [   38.400525][  T193] page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 193, tgid 193 (systemd-udevd), ts 38392157598, free_ts 0

This is a dump of e6c3e400, not the "head".

> [   38.403183][  T193]  post_alloc_hook+0x29a/0x320
> [   38.403891][  T193]  get_page_from_freelist+0x226/0x310
> [   38.404644][  T193]  __alloc_pages+0xdd/0x360
> [   38.405256][  T193]  alloc_slab_page+0x12d/0x200
> [   38.405936][  T193]  allocate_slab+0x6a/0x670
> [   38.406586][  T193]  new_slab+0x48/0xc0
> [   38.407127][  T193]  ___slab_alloc+0x9ba/0x1610
> [   38.407942][  T193]  __slab_alloc+0x41/0x70
> [   38.408776][  T193]  __kmalloc_track_caller+0x57b/0x710
> [   38.409538][  T193]  kmalloc_reserve+0x3f/0x100
> [   38.410339][  T193]  __alloc_skb+0xad/0x310
> [   38.410925][  T193]  netlink_sendmsg+0x384/0x6f0
> [   38.411602][  T193]  sock_sendmsg+0x79/0xe0
> [   38.420425][  T193]  ____sys_sendmsg+0x1ef/0x390
> [   38.421069][  T193]  ___sys_sendmsg+0xb0/0x120
> [   38.421726][  T193]  __sys_sendmsg+0x84/0x100
> [   38.422372][  T193] page_owner free stack trace missing
> [   38.423113][  T193] ------------[ cut here ]------------
> [   38.423899][  T193] kernel BUG at include/linux/page-flags.h:319!
> [   38.424778][  T193] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC
> [   38.425610][  T193] CPU: 1 PID: 193 Comm: systemd-udevd Tainted: G S                 6.0.0 #1 b46e496fab9f0be3d12299e0bf71444aabf1c433
> [   38.427187][  T193] EIP: folio_flags+0x31/0x70
> [   38.427951][  T193] Code: 48 83 05 e8 89 bd c5 01 ba a4 c0 2b c4 55 89 e5 83 15 ec 89 bd c5 00 e8 8d 3f f6 ff 83 05 f8 89 bd c5 01 83 15 fc 89 bd c5 00 <0f> 0b 83 05 00 8a bd c5 01 b8 38 1e a6 c4 83 15 04 8a bd c5 00 e8
> [   38.430464][  T193] EAX: 00000000 EBX: e6c3e400 ECX: 00000000 EDX: ee7ead00
> [   38.431382][  T193] ESI: 00000000 EDI: 000c2cc0 EBP: c995fb30 ESP: c995fb30
> [   38.432350][  T193] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210246
> [   38.433348][  T193] CR0: 80050033 CR2: b5c4f018 CR3: 09cab000 CR4: 000006d0
> [   38.434288][  T193] Call Trace:
> [   38.434737][  T193]  alloc_slab_page+0x7f/0x200

Aha, we have crashed while allocating a fresh new slab page, probably at
__folio_set_slab(folio), the page doesn't have het PageSlab() flag set.

So we have just took the page from a freelist (that modifies lru.next
overlapping compound_head, we can still see the poison in lru.prev),
verified that it's page->mapping is 0 (in page_expected_state()). Few
moments later there's a compound_head set and mapping set in a way that only
prep_compound_tail() does.
But the head that would be connected seems to have done its
prep_compound_tail()'s a while ago (nevermind that it would have to be an
off-by-one). So that just makes no sense.

> [   38.435361][  T193]  allocate_slab+0x6a/0x670
> [   38.436007][  T193]  new_slab+0x48/0xc0
> [   38.436536][  T193]  ___slab_alloc+0x9ba/0x1610
> [   38.437293][  T193]  ? __might_sleep+0x5a/0x100
> [   38.437912][  T193]  ? __alloc_skb+0xad/0x310
> [   38.438513][  T193]  ? lock_release+0xa1/0x190
> [   38.439127][  T193]  __slab_alloc+0x41/0x70
> [   38.439845][  T193]  __kmalloc_track_caller+0x57b/0x710
> [   38.440557][  T193]  ? kmem_cache_alloc+0x2d6/0x690
> [   38.441217][  T193]  ? __alloc_skb+0xad/0x310
> [   38.441821][  T193]  kmalloc_reserve+0x3f/0x100
> [   38.442569][  T193]  ? security_capable+0x40/0xd0
> [   38.443214][  T193]  __alloc_skb+0xad/0x310
> [   38.443801][  T193]  ? ns_capable_common+0x41/0x80
> [   38.444452][  T193]  netlink_sendmsg+0x384/0x6f0
> [   38.445089][  T193]  ? iovec_from_user+0xea/0x1b0
> [   38.445737][  T193]  sock_sendmsg+0x79/0xe0
> [   38.446313][  T193]  ____sys_sendmsg+0x1ef/0x390
> [   38.446955][  T193]  ___sys_sendmsg+0xb0/0x120
> [   38.447586][  T193]  __sys_sendmsg+0x84/0x100
> [   38.448225][  T193]  __do_sys_socketcall+0x20d/0x5e0
> [   38.448908][  T193]  __ia32_sys_socketcall+0x1b/0x30
> [   38.449593][  T193]  __do_fast_syscall_32+0x72/0xd0
> [   38.450264][  T193]  ? syscall_exit_to_user_mode+0x5f/0x90
> [   38.451001][  T193]  ? __do_fast_syscall_32+0x7c/0xd0
> [   38.451702][  T193]  ? __do_fast_syscall_32+0x7c/0xd0
> [   38.452388][  T193]  ? lockdep_hardirqs_on_prepare+0x242/0x400
> [   38.453184][  T193]  ? syscall_exit_to_user_mode+0x5f/0x90
> [   38.453922][  T193]  ? __do_fast_syscall_32+0x7c/0xd0
> [   38.454609][  T193]  ? lockdep_hardirqs_on_prepare+0x242/0x400
> [   38.455390][  T193]  ? syscall_exit_to_user_mode+0x5f/0x90
> [   38.460224][  T193]  ? __do_fast_syscall_32+0x7c/0xd0
> [   38.460922][  T193]  ? irqentry_exit_to_user_mode+0x23/0x30
> [   38.461675][  T193]  do_fast_syscall_32+0x32/0x70
> [   38.462327][  T193]  do_SYSENTER_32+0x15/0x20
> [   38.462936][  T193]  entry_SYSENTER_32+0xa2/0xfb
> [   38.463567][  T193] EIP: 0xb7ed4549
> [   38.464077][  T193] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
> [   38.466578][  T193] EAX: ffffffda EBX: 00000010 ECX: bfc1aa40 EDX: 00000000
> [   38.467499][  T193] ESI: b7e0f000 EDI: 00000000 EBP: 00534540 ESP: bfc1aa30
> [   38.468437][  T193] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200282
> [   38.469442][  T193] Modules linked in:
> [   38.470183][  T193] ---[ end trace 0000000000000000 ]---
> [   38.470910][  T193] EIP: folio_flags+0x31/0x70
> [   38.471704][  T193] Code: 48 83 05 e8 89 bd c5 01 ba a4 c0 2b c4 55 89 e5 83 15 ec 89 bd c5 00 e8 8d 3f f6 ff 83 05 f8 89 bd c5 01 83 15 fc 89 bd c5 00 <0f> 0b 83 05 00 8a bd c5 01 b8 38 1e a6 c4 83 15 04 8a bd c5 00 e8
> [   38.474274][  T193] EAX: 00000000 EBX: e6c3e400 ECX: 00000000 EDX: ee7ead00
> [   38.475233][  T193] ESI: 00000000 EDI: 000c2cc0 EBP: c995fb30 ESP: c995fb30
> [   38.476218][  T193] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210246
> [   38.477246][  T193] CR0: 80050033 CR2: b5c4f018 CR3: 09cab000 CR4: 000006d0
> [   38.478206][  T193] Kernel panic - not syncing: Fatal exception
> [   38.479153][  T193] Kernel Offset: disabled

