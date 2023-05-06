Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F038F6F8E2B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 05:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjEFDBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 23:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjEFDBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 23:01:47 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6466F2723
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 20:01:46 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64115eef620so23610179b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 20:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683342106; x=1685934106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FmBm5vNAgHORXxMgu2mjcwSavYW7pZayOJH2Y/rbbc0=;
        b=EIZTNuvO8/aXPib0KFL+jspYRqDLnSfWXwUaSldyDcGM/NsVQcDD+epFcOWR9f2Yd1
         oTyLhnbCSYpwvmECowB/nuWjBMpgRy9nHQnfLhtChFLao20Ad2c9EGX0YvGSIqH9WZG4
         mmG22TidsH8nGsccKw9DCm/0LJazK0WABiAzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683342106; x=1685934106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmBm5vNAgHORXxMgu2mjcwSavYW7pZayOJH2Y/rbbc0=;
        b=hqKPheX7fujUq5wcfdAgRbNN1e0ECAorK6pFkj6Mo0PsPe/BriiqkJDGYBVF7MjCEn
         8E/Ox++mtb4aL9mMJrS5qyHo3Rqj+l3LKk2zatXMvv1S6bprXbryiHpaYgIivm5oS4D1
         GQT8yCgijTafY779CVzuH9qxhJMo8BPLzFoHOvxSYSZ3xkwwcxqyAVd0d8uNt0dYwoTi
         1cPag+Th9tasOkC+DuotQQx6Emiw7TIKwgr1uoqeM3lnqU72RmDQQfYlXHpzIyDE2G2g
         /Nv2gYdhdf+I0gMv9vdhrHS0GrDXMePWYg/wT5XnERfICJ+fLpqlTCjvvt2bBHsHaoxA
         dHwg==
X-Gm-Message-State: AC+VfDxafOu7B0robQDhROlnd0N9bFJM42PH6wNWhOPWfoA4BmDqxbxr
        c9roUkd9s4IskeBICILYLSsYU43KrUCYR6dicsg=
X-Google-Smtp-Source: ACHHUZ4bl45BFMa41mnCdv1bJay2NwFbekkAmzh6VIuv8NGqDO82KNfjIn7xftkTQXGZyoZ8UirCwA==
X-Received: by 2002:a17:903:1cb:b0:1a6:f5d5:b7f6 with SMTP id e11-20020a17090301cb00b001a6f5d5b7f6mr10767170plh.10.1683342105801;
        Fri, 05 May 2023 20:01:45 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001ac381f1ce9sm2446881plx.185.2023.05.05.20.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 20:01:45 -0700 (PDT)
Date:   Sat, 6 May 2023 12:01:40 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, kernel-team@meta.com
Subject: Re: [PATCH] zsmalloc: move LRU update from zs_map_object() to
 zs_malloc()
Message-ID: <20230506030140.GC3281499@google.com>
References: <20230505185054.2417128-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505185054.2417128-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/05/05 11:50), Nhat Pham wrote:
> Under memory pressure, we sometimes observe the following crash:
> 
> [ 5694.832838] ------------[ cut here ]------------
> [ 5694.842093] list_del corruption, ffff888014b6a448->next is LIST_POISON1 (dead000000000100)
> [ 5694.858677] WARNING: CPU: 33 PID: 418824 at lib/list_debug.c:47 __list_del_entry_valid+0x42/0x80
> [ 5694.961820] CPU: 33 PID: 418824 Comm: fuse_counters.s Kdump: loaded Tainted: G S                5.19.0-0_fbk3_rc3_hoangnhatpzsdynshrv41_10870_g85a9558a25de #1
> [ 5694.990194] Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive MP, BIOS YMM16 05/24/2021
> [ 5695.007072] RIP: 0010:__list_del_entry_valid+0x42/0x80
> [ 5695.017351] Code: 08 48 83 c2 22 48 39 d0 74 24 48 8b 10 48 39 f2 75 2c 48 8b 51 08 b0 01 48 39 f2 75 34 c3 48 c7 c7 55 d7 78 82 e8 4e 45 3b 00 <0f> 0b eb 31 48 c7 c7 27 a8 70 82 e8 3e 45 3b 00 0f 0b eb 21 48 c7
> [ 5695.054919] RSP: 0018:ffffc90027aef4f0 EFLAGS: 00010246
> [ 5695.065366] RAX: 41fe484987275300 RBX: ffff888008988180 RCX: 0000000000000000
> [ 5695.079636] RDX: ffff88886006c280 RSI: ffff888860060480 RDI: ffff888860060480
> [ 5695.093904] RBP: 0000000000000002 R08: 0000000000000000 R09: ffffc90027aef370
> [ 5695.108175] R10: 0000000000000000 R11: ffffffff82fdf1c0 R12: 0000000010000002
> [ 5695.122447] R13: ffff888014b6a448 R14: ffff888014b6a420 R15: 00000000138dc240
> [ 5695.136717] FS:  00007f23a7d3f740(0000) GS:ffff888860040000(0000) knlGS:0000000000000000
> [ 5695.152899] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5695.164388] CR2: 0000560ceaab6ac0 CR3: 000000001c06c001 CR4: 00000000007706e0
> [ 5695.178659] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 5695.192927] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 5695.207197] PKRU: 55555554
> [ 5695.212602] Call Trace:
> [ 5695.217486]  <TASK>
> [ 5695.221674]  zs_map_object+0x91/0x270
> [ 5695.229000]  zswap_frontswap_store+0x33d/0x870
> [ 5695.237885]  ? do_raw_spin_lock+0x5d/0xa0
> [ 5695.245899]  __frontswap_store+0x51/0xb0
> [ 5695.253742]  swap_writepage+0x3c/0x60
> [ 5695.261063]  shrink_page_list+0x738/0x1230
> [ 5695.269255]  shrink_lruvec+0x5ec/0xcd0
> [ 5695.276749]  ? shrink_slab+0x187/0x5f0
> [ 5695.284240]  ? mem_cgroup_iter+0x6e/0x120
> [ 5695.292255]  shrink_node+0x293/0x7b0
> [ 5695.299402]  do_try_to_free_pages+0xea/0x550
> [ 5695.307940]  try_to_free_pages+0x19a/0x490
> [ 5695.316126]  __folio_alloc+0x19ff/0x3e40
> [ 5695.323971]  ? __filemap_get_folio+0x8a/0x4e0
> [ 5695.332681]  ? walk_component+0x2a8/0xb50
> [ 5695.340697]  ? generic_permission+0xda/0x2a0
> [ 5695.349231]  ? __filemap_get_folio+0x8a/0x4e0
> [ 5695.357940]  ? walk_component+0x2a8/0xb50
> [ 5695.365955]  vma_alloc_folio+0x10e/0x570
> [ 5695.373796]  ? walk_component+0x52/0xb50
> [ 5695.381634]  wp_page_copy+0x38c/0xc10
> [ 5695.388953]  ? filename_lookup+0x378/0xbc0
> [ 5695.397140]  handle_mm_fault+0x87f/0x1800
> [ 5695.405157]  do_user_addr_fault+0x1bd/0x570
> [ 5695.413520]  exc_page_fault+0x5d/0x110
> [ 5695.421017]  asm_exc_page_fault+0x22/0x30
> 
> After some investigation, I have found the following issue: unlike other
> zswap backends, zsmalloc performs the LRU list update at the object
> mapping time, rather than when the slot for the object is allocated.
> This deviation was discussed and agreed upon during the review process
> of the zsmalloc writeback patch series:
> 
> https://lore.kernel.org/lkml/Y3flcAXNxxrvy3ZH@cmpxchg.org/
> 
> Unfortunately, this introduces a subtle bug that occurs when there is a
> concurrent store and reclaim, which interleave as follows:
> 
> zswap_frontswap_store()            shrink_worker()
>   zs_malloc()                        zs_zpool_shrink()
>     spin_lock(&pool->lock)             zs_reclaim_page()
>     zspage = find_get_zspage()
>     spin_unlock(&pool->lock)
>                                          spin_lock(&pool->lock)
>                                          zspage = list_first_entry(&pool->lru)
>                                          list_del(&zspage->lru)
>                                            zspage->lru.next = LIST_POISON1
>                                            zspage->lru.prev = LIST_POISON2

					Will list_del_init() there do the trick?

>                                          spin_unlock(&pool->lock)
>   zs_map_object()
>     spin_lock(&pool->lock)
>     if (!list_empty(&zspage->lru))
>       list_del(&zspage->lru)

	list_del_init()

>         CHECK_DATA_CORRUPTION(next == LIST_POISON1) /* BOOM */
