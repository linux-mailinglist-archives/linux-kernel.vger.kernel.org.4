Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3744C74DC1A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjGJRSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjGJRSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:18:32 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A5B10D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:18:30 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-313fb7f0f80so4807233f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689009509; x=1691601509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t6oy+ikXFliz7hnRG2fRcIG8cUU4C16Syr9hNMIkcUc=;
        b=Tmp9Ctr8fCoOjVTqIM3I/iC02vVdsUuLPEpkAiuhmbYbmOtaYkRQJwBrlLxiS+VHId
         TAhFKPzsbLqcVed9wIsAKkq+tUAvEQ5Msrd4+eDBUjUJ3jeav+WLPa6/xja+cJsnweBs
         svBDQAdU7RTVfHs+z/DowCYVhCL6lFmOcIX6KsCwztiymTl0d3yxEVQuq0oO56KoOlB6
         RAcd/XY9w9vhOLwcV4dl+HavowDnexbKe/YjIMXI7EBzdnXywoWO/2ZsZFxK+WhWwD+R
         qnjbMQ554HUaFe2V9p55VvZ9RpnU3fJIPR7O0TkbnUvZnkVdGV2ztYrO69o9AgbsiMBt
         9jCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689009509; x=1691601509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6oy+ikXFliz7hnRG2fRcIG8cUU4C16Syr9hNMIkcUc=;
        b=U3N/JKiGvddde32CTbvMFJj73aF5eQKGw8zkYtaR4Q0hVuc0I/fytGJQxDPE8HSDzo
         Km9xow87jaZV4F/CmMg2LIjz9lwLaSrxaVXVdWNOpkxmONncvg1AlegWsqZwxQJVsrzj
         6C8/AfUR+WATiv+biwi0AG1zQNnxW/jkR3a5q2rVZuQRorz8Ji3I5M/yezqqU8OOQh3S
         HI0/lSaSgq8NbqeUmN7vN7v3gvtaM2PV1Q/ReMH/2FPsVhR+cVvHmYSYzPtfx/NooeIT
         2e1fdvpWBNqwvSIWwaO4s9WqZnqxGeLJDc3RXnjttjwB0n8oJ3zdOLwLIwYoUooKvYS9
         sDjA==
X-Gm-Message-State: ABy/qLbhhpMPYT7OigPJq3cyJQ5DNHa/u9hDbNdqng9zklQulpwIGpHq
        GwUVIhiCshB3XaQGSFT8goI=
X-Google-Smtp-Source: APBJJlFsxSchrS9YTJrVYffunPhZZ0dq+oD6vU1Crkz0mGCPtBYkHOPKU7WAIbbEsNeJAYd6eN9QqQ==
X-Received: by 2002:a5d:504d:0:b0:30f:c5b1:23ef with SMTP id h13-20020a5d504d000000b0030fc5b123efmr12080633wrt.41.1689009508817;
        Mon, 10 Jul 2023 10:18:28 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id i18-20020adfefd2000000b0031272fced4dsm12219311wrp.52.2023.07.10.10.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 10:18:28 -0700 (PDT)
Date:   Mon, 10 Jul 2023 18:18:27 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        regressions@leemhuis.info, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 12/32] mm/vmalloc: vmalloc_to_page() use
 pte_offset_kernel()
Message-ID: <901ae88d-ad0c-4e9d-b199-f1566cc62a00@lucifer.local>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
 <696386a-84f8-b33c-82e5-f865ed6eb39@google.com>
 <42279f1f-7b82-40dc-8546-86171018729c@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42279f1f-7b82-40dc-8546-86171018729c@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 03:42:31PM +0100, Mark Brown wrote:
> On Thu, Jun 08, 2023 at 06:21:41PM -0700, Hugh Dickins wrote:
> > vmalloc_to_page() was using pte_offset_map() (followed by pte_unmap()),
> > but it's intended for userspace page tables: prefer pte_offset_kernel().
> >
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
>
> Currently Linus' tree is reliably failing to boot on pine64plus, an
> arm64 SBC.  Most other boards seem fine, though I am seeing some
> additional instability on Tritium which is another Allwinner platform,
> I've not dug into that yet and Tritium is generally less stable.
>
> We end up seeing NULL or otherwise bad pointer dereferences, the
> specific error does vary a bit though it mostly appears to be in the
> pinctrl code.  A bisect (full log below) identified this patch as
> introducing the failure, nothing is jumping out at me about the patch
> and it's not affecting everything so I'd not be surprised if it's just
> unconvering some bug in the platform support but I'm not super familiar
> with the code.

Yeah seems likely. Do you have a .config you can share for this board? For
a 64-bit device you'd expect that this change would probably be a nop.

>
> Sample backtrace:
>
> [    1.919725] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [    1.928551] Mem abort info:
> [    1.931359]   ESR = 0x0000000096000044
>
> ...
>
> [    1.968870] [0000000000000000] user address but active_mm is swapper
>
> ...
>
> [    2.093969] Call trace:
> [    2.096414]  dt_remember_or_free_map+0xc8/0x120
> [    2.100949]  pinctrl_dt_to_map+0x23c/0x364
> [    2.105050]  create_pinctrl+0x68/0x3ec
> [    2.108803]  pinctrl_get+0xb0/0x124
> [    2.112294]  devm_pinctrl_get+0x48/0x90
> [    2.116133]  pinctrl_bind_pins+0x58/0x158
> [    2.120148]  really_probe+0x54/0x2b0
> [    2.123724]  __driver_probe_device+0x78/0x12c
>
> Another common theme is the same but with an address like 0x4c and:
>
> [    2.098328]  __kmem_cache_alloc_node+0x1bc/0x2dc
> [    2.102947]  kmalloc_trace+0x20/0x2c
> [    2.106524]  pinctrl_register_mappings+0x98/0x178
>
> Full boot log from a failure:
>
>     https://lava.sirena.org.uk/scheduler/job/712456
>
> git bisect start
> # bad: [06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5] Linux 6.5-rc1
> git bisect bad 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> # good: [6995e2de6891c724bfeb2db33d7b87775f913ad1] Linux 6.4
> git bisect good 6995e2de6891c724bfeb2db33d7b87775f913ad1
> # bad: [1b722407a13b7f8658d2e26917791f32805980a2] Merge tag 'drm-next-2023-06-29' of git://anongit.freedesktop.org/drm/drm
> git bisect bad 1b722407a13b7f8658d2e26917791f32805980a2
> # bad: [3a8a670eeeaa40d87bd38a587438952741980c18] Merge tag 'net-next-6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> git bisect bad 3a8a670eeeaa40d87bd38a587438952741980c18
> # bad: [6e17c6de3ddf3073741d9c91a796ee696914d8a0] Merge tag 'mm-stable-2023-06-24-19-15' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect bad 6e17c6de3ddf3073741d9c91a796ee696914d8a0
> # good: [2605e80d3438c77190f55b821c6575048c68268e] Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
> git bisect good 2605e80d3438c77190f55b821c6575048c68268e
> # good: [72dc6db7e3b692f46f3386b8dd5101d3f431adef] Merge tag 'wq-for-6.5-cleanup-ordered' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq
> git bisect good 72dc6db7e3b692f46f3386b8dd5101d3f431adef
> # bad: [179d3e4f3bfa5947821c1b1bc6aa49a4797b7f21] mm/madvise: clean up force_shm_swapin_readahead()
> git bisect bad 179d3e4f3bfa5947821c1b1bc6aa49a4797b7f21
> # good: [523716770e63e229dbb6307d663f03d990dfefc5] maple_tree: rework mtree_alloc_{range,rrange}()
> git bisect good 523716770e63e229dbb6307d663f03d990dfefc5
> # good: [b764253c18821da31c49a260f92f5d093cf1637e] selftests/mm: fix "warning: expression which evaluates to zero..." in mlock2-tests.c
> git bisect good b764253c18821da31c49a260f92f5d093cf1637e
> # good: [5c7f3bf04a6cf266567fdea1ae4987875e92619f] s390: allow pte_offset_map_lock() to fail
> git bisect good 5c7f3bf04a6cf266567fdea1ae4987875e92619f
> # good: [0d940a9b270b9220dcff74d8e9123c9788365751] mm/pgtable: allow pte_offset_map[_lock]() to fail
> git bisect good 0d940a9b270b9220dcff74d8e9123c9788365751
> # bad: [0d1c81edc61e553ed7a5db18fb8074c8b78e1538] mm/vmalloc: vmalloc_to_page() use pte_offset_kernel()
> git bisect bad 0d1c81edc61e553ed7a5db18fb8074c8b78e1538
> # good: [2798bbe75b9c2752b46d292e5c2a49f49da36418] mm/page_vma_mapped: pte_offset_map_nolock() not pte_lockptr()
> git bisect good 2798bbe75b9c2752b46d292e5c2a49f49da36418
> # good: [be872f83bf571f4f9a0ac25e2c9c36e905a36619] mm/pagewalk: walk_pte_range() allow for pte_offset_map()
> git bisect good be872f83bf571f4f9a0ac25e2c9c36e905a36619
> # good: [e5ad581c7f1c32d309ae4e895eea0cd1a3d9f363] mm/vmwgfx: simplify pmd & pud mapping dirty helpers
> git bisect good e5ad581c7f1c32d309ae4e895eea0cd1a3d9f363
> # first bad commit: [0d1c81edc61e553ed7a5db18fb8074c8b78e1538] mm/vmalloc: vmalloc_to_page() use pte_offset_kernel()
