Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D876FB23D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjEHOHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjEHOHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:07:05 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E91059C4
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:07:02 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-75131c2997bso1788372085a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 07:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1683554821; x=1686146821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0zHIB1p0r9db3H8iesbnDhoKul8VUYPYDCCOq/EsIAs=;
        b=PnFkj4n4y+ttVT7PqKup3F5pFJAFTWzr09cEqKrDuVzaVafMm9brRAWQjqQNdGMluu
         0QeNEFD0bR+u/rNSk9K4O6Y3X8BJqYwDaXKsxLcyqD+4XQt7i8xYKDlCwQFLRloKDqz1
         OaGYQ3p32vOb53U8IJQYKIcSvSlIEgtpDVNDPwL4eqHSfdw4FZwW2RX8ogm+kic0qqXq
         bfNtcIwNiQqTV3bBHvHvkAaOF3e5GB+aGuMIMQp0HTTkasWR/3Qv2JzMPtu/8o1TAH2m
         H3/CVtezpZcCtXSx6BMYQpRtQzmX4rfAxgc/odEIBWx6Ls3gJUJUqklC8hYgcyFD5bk3
         a4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683554821; x=1686146821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zHIB1p0r9db3H8iesbnDhoKul8VUYPYDCCOq/EsIAs=;
        b=a2TL5b3d9B17Kt0Cji94mf4yGbjbl36/BhjwO3/OMblgLhYRaEUFl+cQthnB88h6EZ
         gyUMl0YJUoqg6LnzRO2uxVTqi5nY2MZsbX377TN1PXmPaOMGoNIHajQN2dxpulJUkiET
         OmjV7Bon7jHdLeT0jz6XBBLLtlkZXX6Li6btx2OPZfOsOLrQQkZ3NcZWOY4RD/flBq4C
         D74o62BFIho/7a0COrthif0ZMxjQdysAjc3wHCHq2qDQ8tFBbbI/FPbu+8oNQRWIayUJ
         6HFK4a7yUxZBXbObYpyIMR85Kuc7QjnzWn4U+rTDCK81X/InHsJZESQIoboq6H8w6bV4
         GlBQ==
X-Gm-Message-State: AC+VfDxmzaiiZZJj0RQPubMkeYeLZKHsGdHi4gSMlmG1eZw5kPPArYHE
        mObaChg4kxpfymcd6t+sle/bbw==
X-Google-Smtp-Source: ACHHUZ6wpokICs+/mgYMHuejLrCPxUUQwBF+qP13E/j1zk2eQdB0d9Z7h7dIrUEkeiRDZF/3zlFIAA==
X-Received: by 2002:a05:6214:d0f:b0:5ef:653e:169b with SMTP id 15-20020a0562140d0f00b005ef653e169bmr15621972qvh.8.1683554821234;
        Mon, 08 May 2023 07:07:01 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id o14-20020a0c8c4e000000b0062119a7a7a3sm18000qvb.4.2023.05.08.07.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 07:07:00 -0700 (PDT)
Date:   Mon, 8 May 2023 10:06:58 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, ngupta@vflare.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, kernel-team@meta.com
Subject: Re: [PATCH] zsmalloc: move LRU update from zs_map_object() to
 zs_malloc()
Message-ID: <20230508140658.GA3421@cmpxchg.org>
References: <20230505185054.2417128-1-nphamcs@gmail.com>
 <20230506030140.GC3281499@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506030140.GC3281499@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2023 at 12:01:40PM +0900, Sergey Senozhatsky wrote:
> On (23/05/05 11:50), Nhat Pham wrote:
> > Under memory pressure, we sometimes observe the following crash:
> > 
> > [ 5694.832838] ------------[ cut here ]------------
> > [ 5694.842093] list_del corruption, ffff888014b6a448->next is LIST_POISON1 (dead000000000100)
> > [ 5694.858677] WARNING: CPU: 33 PID: 418824 at lib/list_debug.c:47 __list_del_entry_valid+0x42/0x80
> > [ 5694.961820] CPU: 33 PID: 418824 Comm: fuse_counters.s Kdump: loaded Tainted: G S                5.19.0-0_fbk3_rc3_hoangnhatpzsdynshrv41_10870_g85a9558a25de #1
> > [ 5694.990194] Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive MP, BIOS YMM16 05/24/2021
> > [ 5695.007072] RIP: 0010:__list_del_entry_valid+0x42/0x80
> > [ 5695.017351] Code: 08 48 83 c2 22 48 39 d0 74 24 48 8b 10 48 39 f2 75 2c 48 8b 51 08 b0 01 48 39 f2 75 34 c3 48 c7 c7 55 d7 78 82 e8 4e 45 3b 00 <0f> 0b eb 31 48 c7 c7 27 a8 70 82 e8 3e 45 3b 00 0f 0b eb 21 48 c7
> > [ 5695.054919] RSP: 0018:ffffc90027aef4f0 EFLAGS: 00010246
> > [ 5695.065366] RAX: 41fe484987275300 RBX: ffff888008988180 RCX: 0000000000000000
> > [ 5695.079636] RDX: ffff88886006c280 RSI: ffff888860060480 RDI: ffff888860060480
> > [ 5695.093904] RBP: 0000000000000002 R08: 0000000000000000 R09: ffffc90027aef370
> > [ 5695.108175] R10: 0000000000000000 R11: ffffffff82fdf1c0 R12: 0000000010000002
> > [ 5695.122447] R13: ffff888014b6a448 R14: ffff888014b6a420 R15: 00000000138dc240
> > [ 5695.136717] FS:  00007f23a7d3f740(0000) GS:ffff888860040000(0000) knlGS:0000000000000000
> > [ 5695.152899] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 5695.164388] CR2: 0000560ceaab6ac0 CR3: 000000001c06c001 CR4: 00000000007706e0
> > [ 5695.178659] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [ 5695.192927] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [ 5695.207197] PKRU: 55555554
> > [ 5695.212602] Call Trace:
> > [ 5695.217486]  <TASK>
> > [ 5695.221674]  zs_map_object+0x91/0x270
> > [ 5695.229000]  zswap_frontswap_store+0x33d/0x870
> > [ 5695.237885]  ? do_raw_spin_lock+0x5d/0xa0
> > [ 5695.245899]  __frontswap_store+0x51/0xb0
> > [ 5695.253742]  swap_writepage+0x3c/0x60
> > [ 5695.261063]  shrink_page_list+0x738/0x1230
> > [ 5695.269255]  shrink_lruvec+0x5ec/0xcd0
> > [ 5695.276749]  ? shrink_slab+0x187/0x5f0
> > [ 5695.284240]  ? mem_cgroup_iter+0x6e/0x120
> > [ 5695.292255]  shrink_node+0x293/0x7b0
> > [ 5695.299402]  do_try_to_free_pages+0xea/0x550
> > [ 5695.307940]  try_to_free_pages+0x19a/0x490
> > [ 5695.316126]  __folio_alloc+0x19ff/0x3e40
> > [ 5695.323971]  ? __filemap_get_folio+0x8a/0x4e0
> > [ 5695.332681]  ? walk_component+0x2a8/0xb50
> > [ 5695.340697]  ? generic_permission+0xda/0x2a0
> > [ 5695.349231]  ? __filemap_get_folio+0x8a/0x4e0
> > [ 5695.357940]  ? walk_component+0x2a8/0xb50
> > [ 5695.365955]  vma_alloc_folio+0x10e/0x570
> > [ 5695.373796]  ? walk_component+0x52/0xb50
> > [ 5695.381634]  wp_page_copy+0x38c/0xc10
> > [ 5695.388953]  ? filename_lookup+0x378/0xbc0
> > [ 5695.397140]  handle_mm_fault+0x87f/0x1800
> > [ 5695.405157]  do_user_addr_fault+0x1bd/0x570
> > [ 5695.413520]  exc_page_fault+0x5d/0x110
> > [ 5695.421017]  asm_exc_page_fault+0x22/0x30
> > 
> > After some investigation, I have found the following issue: unlike other
> > zswap backends, zsmalloc performs the LRU list update at the object
> > mapping time, rather than when the slot for the object is allocated.
> > This deviation was discussed and agreed upon during the review process
> > of the zsmalloc writeback patch series:
> > 
> > https://lore.kernel.org/lkml/Y3flcAXNxxrvy3ZH@cmpxchg.org/
> > 
> > Unfortunately, this introduces a subtle bug that occurs when there is a
> > concurrent store and reclaim, which interleave as follows:
> > 
> > zswap_frontswap_store()            shrink_worker()
> >   zs_malloc()                        zs_zpool_shrink()
> >     spin_lock(&pool->lock)             zs_reclaim_page()
> >     zspage = find_get_zspage()
> >     spin_unlock(&pool->lock)
> >                                          spin_lock(&pool->lock)
> >                                          zspage = list_first_entry(&pool->lru)
> >                                          list_del(&zspage->lru)
> >                                            zspage->lru.next = LIST_POISON1
> >                                            zspage->lru.prev = LIST_POISON2
> 
> 					Will list_del_init() there do the trick?
> 
> >                                          spin_unlock(&pool->lock)
> >   zs_map_object()
> >     spin_lock(&pool->lock)
> >     if (!list_empty(&zspage->lru))
> >       list_del(&zspage->lru)
> 
> 	list_del_init()

The deeper bug here is that zs_map_object() tries to add the page to
the LRU list while the shrinker has it isolated for reclaim. This is
way too sutble and error prone. Even if it worked now, it'll cause
corruption issues down the line.

For example, Nhat is adding a secondary entry point to reclaim.
Reclaim expects that a page that's on the LRU is also on the fullness
list, so this would lead to a double remove_zspage() and BUG_ON().

This patch doesn't just fix the crash, it eliminates the deeper LRU
isolation issue and makes the code more robust and simple.
