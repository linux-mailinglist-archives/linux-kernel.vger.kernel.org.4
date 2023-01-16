Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E0766B53C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 02:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjAPB2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 20:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjAPB2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 20:28:34 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8775263
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 17:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673832511; x=1705368511;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=OTJvv8OEQa+t9gey6hK3h8YaGGJbHT1UX7o/JYml814=;
  b=ma3pUjauPkDkHbUWMX0EQRQ5E3Q2pkbE0ECkX/5uTcc8CuYFYzc/2UAJ
   hrRmbeckqtMgnuk8uJynWGORYy/US7jbFWDWFrCVFJ85SshckV37L1qtp
   29oGDHDmlNqmpTGGoApm19/9qFxJaFXT/Dhh0PYN29bR8ch7mqWTGbTus
   +elqm5taoXm8eZ7xcoRwLow4E/Eg0q5MZfyw1CI2Mk+3H+WmxCWa0gnxe
   wFCbxNUBVYHRREnleE3PsSQUTwlTITA6XytEdDRQuty6jEQ4S+Uaprm8s
   q/rQ4Y0rpxk5zyENk42muAwlXTv4gm0+k9Ii8jh9UoWIrotADf0E3mAD7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="410608049"
X-IronPort-AV: E=Sophos;i="5.97,219,1669104000"; 
   d="scan'208";a="410608049"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 17:28:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="660813034"
X-IronPort-AV: E=Sophos;i="5.97,219,1669104000"; 
   d="scan'208";a="660813034"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 17:28:28 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv2 0/4] zsmalloc: make zspage chain size configurable
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
        <Y8G3nJ9+k2lB0kas@monkey> <Y8JU8iGlu5uLGdDt@google.com>
        <Y8Oo3+9UmZ4ac8sW@google.com> <Y8O3Cbj/QLBRtAJK@google.com>
Date:   Mon, 16 Jan 2023 09:27:27 +0800
In-Reply-To: <Y8O3Cbj/QLBRtAJK@google.com> (Sergey Senozhatsky's message of
        "Sun, 15 Jan 2023 17:19:21 +0900")
Message-ID: <87y1q3qneo.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sergey,

Sergey Senozhatsky <senozhatsky@chromium.org> writes:
> + Huang Ying,
>
>> On (23/01/14 16:08), Sergey Senozhatsky wrote:
>> > [   87.208255] ------------[ cut here ]------------
>> > [   87.209431] WARNING: CPU: 18 PID: 300 at mm/migrate.c:995 move_to_new_folio+0x1ef/0x260
>> > [   87.211993] Modules linked in: deflate zlib_deflate zstd zstd_compress zram
>> > [   87.214287] CPU: 18 PID: 300 Comm: kcompactd0 Tainted: G                 N 6.2.0-rc3-next-20230113+ #385
>> > [   87.217529] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
>> > [   87.220131] RIP: 0010:move_to_new_folio+0x1ef/0x260
>> > [ 87.221892] Code: 84 c0 74 78 48 8b 43 18 44 89 ea 48 89 de 4c 89
>> > e7 ff 50 06 85 c0 0f 85 a9 fe ff ff 48 8b 03 a9 00 00 04 00 0f 85
>> > 7a fe ff ff <0f> 0b e9 73 fe ff ff 48 8b 03 f6 c4 20 74 2a be c0
>> > 0c 00 00 48 89
>> > [   87.226514] RSP: 0018:ffffc90000b9fb08 EFLAGS: 00010246
>> > [   87.227879] RAX: 4000000000000021 RBX: ffffea0000890500 RCX: 0000000000000000
>> > [   87.230948] RDX: 0000000000000000 RSI: ffffffff81e6f950 RDI: ffffea0000890500
>> > [   87.233026] RBP: ffffea0000890500 R08: 0000001e82ec3c3e R09: 0000000000000001
>> > [   87.235517] R10: 00000000ffffffff R11: 00000000ffffffff R12: ffffea00015a26c0
>> > [   87.237807] R13: 0000000000000001 R14: ffffea00015a2680 R15: ffffea00008904c0
>> > [   87.239438] FS:  0000000000000000(0000) GS:ffff888624200000(0000) knlGS:0000000000000000
>> > [   87.241303] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > [   87.242627] CR2: 00007fe537ebbdb8 CR3: 0000000110a0a004 CR4: 0000000000770ee0
>> > [   87.244283] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> > [   87.245913] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> > [   87.247559] PKRU: 55555554
>> > [   87.248269] Call Trace:
>> > [   87.248862]  <TASK>
>> > [   87.249370]  ? lock_is_held_type+0xd9/0x130
>> > [   87.250377]  migrate_pages_batch+0x553/0xc80
>> > [   87.251513]  ? move_freelist_tail+0xc0/0xc0
>> > [   87.252545]  ? isolate_freepages+0x290/0x290
>> > [   87.253654]  ? trace_mm_migrate_pages+0xf0/0xf0
>> > [   87.254901]  migrate_pages+0x1ae/0x330
>> > [   87.255877]  ? isolate_freepages+0x290/0x290
>> > [   87.257015]  ? move_freelist_tail+0xc0/0xc0
>> > [   87.258213]  compact_zone+0x528/0x6a0
>> > [   87.260911]  proactive_compact_node+0x87/0xd0
>> > [   87.262090]  kcompactd+0x1ca/0x360
>> > [   87.263018]  ? swake_up_all+0xe0/0xe0
>> > [   87.264101]  ? kcompactd_do_work+0x240/0x240
>> > [   87.265243]  kthread+0xec/0x110
>> > [   87.266031]  ? kthread_complete_and_exit+0x20/0x20
>> > [   87.267268]  ret_from_fork+0x1f/0x30
>> > [   87.268243]  </TASK>
>> > [   87.268984] irq event stamp: 311113
>> > [   87.269930] hardirqs last  enabled at (311125): [<ffffffff810da6c2>] __up_console_sem+0x52/0x60
>> > [   87.272235] hardirqs last disabled at (311134): [<ffffffff810da6a7>] __up_console_sem+0x37/0x60
>> > [   87.275707] softirqs last  enabled at (311088): [<ffffffff819d2b2c>] __do_softirq+0x21c/0x31f
>> > [   87.278450] softirqs last disabled at (311083): [<ffffffff81070b8d>] __irq_exit_rcu+0xad/0x120
>> > [   87.280555] ---[ end trace 0000000000000000 ]---
>> 
>> So this warning is move_to_new_folio() being called on un-isolated
>> src folio. I had DEBUG_VM disabled so VM_BUG_ON_FOLIO(!folio_test_isolated(src))
>> did nothing, however after mops->migrate_page() it would trigger WARN_ON()
>> because it evaluates folio_test_isolated(src) one more time:
>> 
>> [   59.500580] page:0000000097d97a42 refcount:2 mapcount:1665 mapping:0000000000000000 index:0xffffea00185ce940 pfn:0x113dc4
>> [   59.503239] flags: 0x8000000000000001(locked|zone=2)
>> [   59.505060] raw: 8000000000000001 ffffea00044f70c8 ffffc90000ba7c20 ffffffff81c22582
>> [   59.507288] raw: ffffea00185ce940 ffff88809183fdb0 0000000200000680 0000000000000000
>> [   59.509622] page dumped because: VM_BUG_ON_FOLIO(!folio_test_isolated(src))
>> [   59.511845] ------------[ cut here ]------------
>> [   59.513181] kernel BUG at mm/migrate.c:988!
>> [   59.514821] invalid opcode: 0000 [#1] PREEMPT SMP PTI
>> 
>> [   59.523018] RIP: 0010:move_to_new_folio+0x362/0x3b0
>> [ 59.524160] Code: ff ff e9 55 fd ff ff 48 89 df e8 69 d8 ff ff f0
>> 80 60 02 fb 31 c0 e9 65 fd ff ff 48 c7 c6 00 f5 e9 81 48 89 df e8 be
>> c0 f9 ff <0f> 0b 48 c7 c6 00 f5 e9 81 48 89 df e8 ad c0 f9 ff 0f 0b
>> b8 f5 ff
>> [   59.528349] RSP: 0018:ffffc90000ba7af8 EFLAGS: 00010246
>> [   59.529551] RAX: 000000000000003f RBX: ffffea00044f7100 RCX: 0000000000000000
>> [   59.531186] RDX: 0000000000000000 RSI: ffffffff81e8dcf1 RDI: 00000000ffffffff
>> [   59.532790] RBP: ffffea00184f1140 R08: 00000000ffffbfff R09: 00000000ffffbfff
>> [   59.534392] R10: ffff888621ca0000 R11: ffff888621ca0000 R12: 8000000000000001
>> [   59.536026] R13: 0000000000000001 R14: 0000000000000000 R15: ffffea00184f1140
>> [   59.537646] FS:  0000000000000000(0000) GS:ffff888626a00000(0000) knlGS:0000000000000000
>> [   59.539484] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   59.540785] CR2: 00007ff7fbed8000 CR3: 0000000101a26001 CR4: 0000000000770ee0
>> [   59.542412] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [   59.544030] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [   59.545637] PKRU: 55555554
>> [   59.546261] Call Trace:
>> [   59.546833]  <TASK>
>> [   59.547371]  ? lock_is_held_type+0xd9/0x130
>> [   59.548331]  migrate_pages_batch+0x650/0xdc0
>> [   59.549326]  ? move_freelist_tail+0xc0/0xc0
>> [   59.550281]  ? isolate_freepages+0x290/0x290
>> [   59.551289]  ? folio_flags.constprop.0+0x50/0x50
>> [   59.552348]  migrate_pages+0x3fa/0x4d0
>> [   59.553224]  ? isolate_freepages+0x290/0x290
>> [   59.554214]  ? move_freelist_tail+0xc0/0xc0
>> [   59.555173]  compact_zone+0x51b/0x6a0
>> [   59.556031]  proactive_compact_node+0x8e/0xe0
>> [   59.557033]  kcompactd+0x1c3/0x350
>> [   59.557842]  ? swake_up_all+0xe0/0xe0
>> [   59.558699]  ? kcompactd_do_work+0x260/0x260
>> [   59.559703]  kthread+0xec/0x110
>> [   59.560450]  ? kthread_complete_and_exit+0x20/0x20
>> [   59.561582]  ret_from_fork+0x1f/0x30
>> [   59.562427]  </TASK>
>> [   59.562966] Modules linked in: deflate zlib_deflate zstd zstd_compress zram
>> [   59.564591] ---[ end trace 0000000000000000 ]---
>> [   59.565661] RIP: 0010:move_to_new_folio+0x362/0x3b0
>> [ 59.566802] Code: ff ff e9 55 fd ff ff 48 89 df e8 69 d8 ff ff f0
>> 80 60 02 fb 31 c0 e9 65 fd ff ff 48 c7 c6 00 f5 e9 81 48 89 df e8 be
>> c0 f9 ff <0f> 0b 48 c7 c6 00 f5 e9 81 48 89 df e8 ad c0 f9 ff 0f 0b
>> b8 f5 ff
>> [   59.571048] RSP: 0018:ffffc90000ba7af8 EFLAGS: 00010246
>> [   59.572257] RAX: 000000000000003f RBX: ffffea00044f7100 RCX: 0000000000000000
>> [   59.573906] RDX: 0000000000000000 RSI: ffffffff81e8dcf1 RDI: 00000000ffffffff
>> [   59.575544] RBP: ffffea00184f1140 R08: 00000000ffffbfff R09: 00000000ffffbfff
>> [   59.577236] R10: ffff888621ca0000 R11: ffff888621ca0000 R12: 8000000000000001
>> [   59.578893] R13: 0000000000000001 R14: 0000000000000000 R15: ffffea00184f1140
>> [   59.580593] FS:  0000000000000000(0000) GS:ffff888626a00000(0000) knlGS:0000000000000000
>> [   59.582432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   59.583767] CR2: 00007ff7fbed8000 CR3: 0000000101a26001 CR4: 0000000000770ee0
>> [   59.585437] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [   59.587082] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [   59.588738] PKRU: 55555554

Thanks for reporting.  We have just fixed a ZRAM related bug in
migrate_pages() batching series with the help of Mike.

https://lore.kernel.org/linux-mm/Y8DizzvFXBSEPzI4@monkey/

I will send out a new version today or tomorrow to fix it.  Please try
that.

Best Regards,
Huang, Ying
