Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D713966AFE0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 09:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjAOITb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 03:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjAOIT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 03:19:28 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFC393F1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 00:19:27 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gz9-20020a17090b0ec900b002290bda1b07so4293704pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 00:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJrV6D33u8S5NvCgphHrVPuXRpbI3fo9eNceub/HsNg=;
        b=hPDCcv3VZ+lH4UGnu63+7WtxFwDzfWwNCXJ0mnHQtcDG98USroDBto4UKsHyUNqrGX
         jPfMdOG+P197mRVTNPEik195FcH1pHEVWNKSeY2+n9zgZHWYjPsXIsQwaWD2cgVfevEl
         L0RDxEve9DdJRTyC/DmU2mFu5//9jwEwpw5JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJrV6D33u8S5NvCgphHrVPuXRpbI3fo9eNceub/HsNg=;
        b=49UNxjdhv8HsAiTMUIcy3CFRgzwli8ttbYobL3mXkySRClg1Eec2o7rrNGnkcWOBj1
         AUaHJ7NNXFKYdSiQWJj+0aKg8OKa17E8BOQHgCi4wDxzfCU6jKcSFgd27tbkQhUEymLG
         8NdAGKXb6DhxrLmDUbgwME1kjhV6r/OKryhE7f/WhlR0xeevafnLknJeJpB3dLMYGtxm
         WYGuaxTap1gXnlza2yaYJG4Hc1PvbssxdtQTQG3BlIZyPg9hSg1ndwIA/YKFPhPuV0xf
         9aoCd6ppzPCNtiY1IfpCwDVnRb3JbAWgKsNbH+gJr8BI6P+uahGwomP/+LzpR6ZTw0d4
         eowA==
X-Gm-Message-State: AFqh2koZPGU2fhjcQyA4LshlaC2OLHM36MIzR6hQzEI0yTtXdYxsgUpZ
        gGP8BmP2hKEnivvaArmdRgaVog==
X-Google-Smtp-Source: AMrXdXsTQIJXcaNrvFZIORqPYdd0czBX4+SX6ijHLQ9AyLxtWJgcKqljBfNftibGJ6Mk12rDiuHxYQ==
X-Received: by 2002:a17:902:a406:b0:189:6ab3:9e75 with SMTP id p6-20020a170902a40600b001896ab39e75mr87350558plq.15.1673770766708;
        Sun, 15 Jan 2023 00:19:26 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902eb8b00b00189c93ce5easm16953658plg.166.2023.01.15.00.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 00:19:25 -0800 (PST)
Date:   Sun, 15 Jan 2023 17:19:21 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv2 0/4] zsmalloc: make zspage chain size configurable
Message-ID: <Y8O3Cbj/QLBRtAJK@google.com>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
 <Y8G3nJ9+k2lB0kas@monkey>
 <Y8JU8iGlu5uLGdDt@google.com>
 <Y8Oo3+9UmZ4ac8sW@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8Oo3+9UmZ4ac8sW@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Huang Ying,

> On (23/01/14 16:08), Sergey Senozhatsky wrote:
> > [   87.208255] ------------[ cut here ]------------
> > [   87.209431] WARNING: CPU: 18 PID: 300 at mm/migrate.c:995 move_to_new_folio+0x1ef/0x260
> > [   87.211993] Modules linked in: deflate zlib_deflate zstd zstd_compress zram
> > [   87.214287] CPU: 18 PID: 300 Comm: kcompactd0 Tainted: G                 N 6.2.0-rc3-next-20230113+ #385
> > [   87.217529] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> > [   87.220131] RIP: 0010:move_to_new_folio+0x1ef/0x260
> > [   87.221892] Code: 84 c0 74 78 48 8b 43 18 44 89 ea 48 89 de 4c 89 e7 ff 50 06 85 c0 0f 85 a9 fe ff ff 48 8b 03 a9 00 00 04 00 0f 85 7a fe ff ff <0f> 0b e9 73 fe ff ff 48 8b 03 f6 c4 20 74 2a be c0 0c 00 00 48 89
> > [   87.226514] RSP: 0018:ffffc90000b9fb08 EFLAGS: 00010246
> > [   87.227879] RAX: 4000000000000021 RBX: ffffea0000890500 RCX: 0000000000000000
> > [   87.230948] RDX: 0000000000000000 RSI: ffffffff81e6f950 RDI: ffffea0000890500
> > [   87.233026] RBP: ffffea0000890500 R08: 0000001e82ec3c3e R09: 0000000000000001
> > [   87.235517] R10: 00000000ffffffff R11: 00000000ffffffff R12: ffffea00015a26c0
> > [   87.237807] R13: 0000000000000001 R14: ffffea00015a2680 R15: ffffea00008904c0
> > [   87.239438] FS:  0000000000000000(0000) GS:ffff888624200000(0000) knlGS:0000000000000000
> > [   87.241303] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   87.242627] CR2: 00007fe537ebbdb8 CR3: 0000000110a0a004 CR4: 0000000000770ee0
> > [   87.244283] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   87.245913] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [   87.247559] PKRU: 55555554
> > [   87.248269] Call Trace:
> > [   87.248862]  <TASK>
> > [   87.249370]  ? lock_is_held_type+0xd9/0x130
> > [   87.250377]  migrate_pages_batch+0x553/0xc80
> > [   87.251513]  ? move_freelist_tail+0xc0/0xc0
> > [   87.252545]  ? isolate_freepages+0x290/0x290
> > [   87.253654]  ? trace_mm_migrate_pages+0xf0/0xf0
> > [   87.254901]  migrate_pages+0x1ae/0x330
> > [   87.255877]  ? isolate_freepages+0x290/0x290
> > [   87.257015]  ? move_freelist_tail+0xc0/0xc0
> > [   87.258213]  compact_zone+0x528/0x6a0
> > [   87.260911]  proactive_compact_node+0x87/0xd0
> > [   87.262090]  kcompactd+0x1ca/0x360
> > [   87.263018]  ? swake_up_all+0xe0/0xe0
> > [   87.264101]  ? kcompactd_do_work+0x240/0x240
> > [   87.265243]  kthread+0xec/0x110
> > [   87.266031]  ? kthread_complete_and_exit+0x20/0x20
> > [   87.267268]  ret_from_fork+0x1f/0x30
> > [   87.268243]  </TASK>
> > [   87.268984] irq event stamp: 311113
> > [   87.269930] hardirqs last  enabled at (311125): [<ffffffff810da6c2>] __up_console_sem+0x52/0x60
> > [   87.272235] hardirqs last disabled at (311134): [<ffffffff810da6a7>] __up_console_sem+0x37/0x60
> > [   87.275707] softirqs last  enabled at (311088): [<ffffffff819d2b2c>] __do_softirq+0x21c/0x31f
> > [   87.278450] softirqs last disabled at (311083): [<ffffffff81070b8d>] __irq_exit_rcu+0xad/0x120
> > [   87.280555] ---[ end trace 0000000000000000 ]---
> 
> So this warning is move_to_new_folio() being called on un-isolated
> src folio. I had DEBUG_VM disabled so VM_BUG_ON_FOLIO(!folio_test_isolated(src))
> did nothing, however after mops->migrate_page() it would trigger WARN_ON()
> because it evaluates folio_test_isolated(src) one more time:
> 
> [   59.500580] page:0000000097d97a42 refcount:2 mapcount:1665 mapping:0000000000000000 index:0xffffea00185ce940 pfn:0x113dc4
> [   59.503239] flags: 0x8000000000000001(locked|zone=2)
> [   59.505060] raw: 8000000000000001 ffffea00044f70c8 ffffc90000ba7c20 ffffffff81c22582
> [   59.507288] raw: ffffea00185ce940 ffff88809183fdb0 0000000200000680 0000000000000000
> [   59.509622] page dumped because: VM_BUG_ON_FOLIO(!folio_test_isolated(src))
> [   59.511845] ------------[ cut here ]------------
> [   59.513181] kernel BUG at mm/migrate.c:988!
> [   59.514821] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> 
> [   59.523018] RIP: 0010:move_to_new_folio+0x362/0x3b0
> [   59.524160] Code: ff ff e9 55 fd ff ff 48 89 df e8 69 d8 ff ff f0 80 60 02 fb 31 c0 e9 65 fd ff ff 48 c7 c6 00 f5 e9 81 48 89 df e8 be c0 f9 ff <0f> 0b 48 c7 c6 00 f5 e9 81 48 89 df e8 ad c0 f9 ff 0f 0b b8 f5 ff
> [   59.528349] RSP: 0018:ffffc90000ba7af8 EFLAGS: 00010246
> [   59.529551] RAX: 000000000000003f RBX: ffffea00044f7100 RCX: 0000000000000000
> [   59.531186] RDX: 0000000000000000 RSI: ffffffff81e8dcf1 RDI: 00000000ffffffff
> [   59.532790] RBP: ffffea00184f1140 R08: 00000000ffffbfff R09: 00000000ffffbfff
> [   59.534392] R10: ffff888621ca0000 R11: ffff888621ca0000 R12: 8000000000000001
> [   59.536026] R13: 0000000000000001 R14: 0000000000000000 R15: ffffea00184f1140
> [   59.537646] FS:  0000000000000000(0000) GS:ffff888626a00000(0000) knlGS:0000000000000000
> [   59.539484] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   59.540785] CR2: 00007ff7fbed8000 CR3: 0000000101a26001 CR4: 0000000000770ee0
> [   59.542412] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   59.544030] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   59.545637] PKRU: 55555554
> [   59.546261] Call Trace:
> [   59.546833]  <TASK>
> [   59.547371]  ? lock_is_held_type+0xd9/0x130
> [   59.548331]  migrate_pages_batch+0x650/0xdc0
> [   59.549326]  ? move_freelist_tail+0xc0/0xc0
> [   59.550281]  ? isolate_freepages+0x290/0x290
> [   59.551289]  ? folio_flags.constprop.0+0x50/0x50
> [   59.552348]  migrate_pages+0x3fa/0x4d0
> [   59.553224]  ? isolate_freepages+0x290/0x290
> [   59.554214]  ? move_freelist_tail+0xc0/0xc0
> [   59.555173]  compact_zone+0x51b/0x6a0
> [   59.556031]  proactive_compact_node+0x8e/0xe0
> [   59.557033]  kcompactd+0x1c3/0x350
> [   59.557842]  ? swake_up_all+0xe0/0xe0
> [   59.558699]  ? kcompactd_do_work+0x260/0x260
> [   59.559703]  kthread+0xec/0x110
> [   59.560450]  ? kthread_complete_and_exit+0x20/0x20
> [   59.561582]  ret_from_fork+0x1f/0x30
> [   59.562427]  </TASK>
> [   59.562966] Modules linked in: deflate zlib_deflate zstd zstd_compress zram
> [   59.564591] ---[ end trace 0000000000000000 ]---
> [   59.565661] RIP: 0010:move_to_new_folio+0x362/0x3b0
> [   59.566802] Code: ff ff e9 55 fd ff ff 48 89 df e8 69 d8 ff ff f0 80 60 02 fb 31 c0 e9 65 fd ff ff 48 c7 c6 00 f5 e9 81 48 89 df e8 be c0 f9 ff <0f> 0b 48 c7 c6 00 f5 e9 81 48 89 df e8 ad c0 f9 ff 0f 0b b8 f5 ff
> [   59.571048] RSP: 0018:ffffc90000ba7af8 EFLAGS: 00010246
> [   59.572257] RAX: 000000000000003f RBX: ffffea00044f7100 RCX: 0000000000000000
> [   59.573906] RDX: 0000000000000000 RSI: ffffffff81e8dcf1 RDI: 00000000ffffffff
> [   59.575544] RBP: ffffea00184f1140 R08: 00000000ffffbfff R09: 00000000ffffbfff
> [   59.577236] R10: ffff888621ca0000 R11: ffff888621ca0000 R12: 8000000000000001
> [   59.578893] R13: 0000000000000001 R14: 0000000000000000 R15: ffffea00184f1140
> [   59.580593] FS:  0000000000000000(0000) GS:ffff888626a00000(0000) knlGS:0000000000000000
> [   59.582432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   59.583767] CR2: 00007ff7fbed8000 CR3: 0000000101a26001 CR4: 0000000000770ee0
> [   59.585437] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   59.587082] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   59.588738] PKRU: 55555554
