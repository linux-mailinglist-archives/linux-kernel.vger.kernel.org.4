Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DA86E3ECB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 07:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjDQFQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 01:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjDQFQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 01:16:08 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82C0A4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 22:16:02 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230417051558epoutp04adeaffe73711764d7d807bba1589db78~WoQYPzPhV3193231932epoutp04f
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:15:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230417051558epoutp04adeaffe73711764d7d807bba1589db78~WoQYPzPhV3193231932epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681708558;
        bh=oQH1naoWtLD71WIQ92Fbb5ccJRV/l3zPgMVGl81OVR4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=BUkBN7pNirfTWePbDhEtle6GsXdU32dA00+1R7o1L7YJ0qTBesxEWDuxjyEYUKS15
         9haSenP/jyY2GpHsb6OceKP7WhZnBBY+fGbd3EFNaUUZKwhxJRvYkhC+2perpyk2wn
         2xnsvhdIViZstKDvK28wqjImvXnr9hCuB06WHAKc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230417051557epcas2p14972c5846249963c413da7249c443650~WoQXkDYlO0906509065epcas2p19;
        Mon, 17 Apr 2023 05:15:57 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.98]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Q0Fd91j4Nz4x9QC; Mon, 17 Apr
        2023 05:15:57 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.61.09961.D06DC346; Mon, 17 Apr 2023 14:15:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230417051556epcas2p25b57d681bfae498b30ff33f0a96033d6~WoQW5Hg121683216832epcas2p2J;
        Mon, 17 Apr 2023 05:15:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230417051556epsmtrp1d10d23c1a487a9e1e6a9cd71c13f65d7~WoQW4Y6Dl0874208742epsmtrp1O;
        Mon, 17 Apr 2023 05:15:56 +0000 (GMT)
X-AuditID: b6c32a45-e13fa700000026e9-82-643cd60dbb9a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.B9.08279.C06DC346; Mon, 17 Apr 2023 14:15:56 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [10.229.95.126]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230417051556epsmtip2575acc0a257b0c53fe99034ea3aa21eb~WoQWs50hb0214102141epsmtip2J;
        Mon, 17 Apr 2023 05:15:56 +0000 (GMT)
From:   SEO HOYOUNG <hy50.seo@samsung.com>
To:     andreyknvl@gmail.com, osalvador@suse.de, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        vbabka@suse.cz, edumazet@google.com, longman@redhat.com,
        surenb@google.com, elver@google.com, glider@google.com,
        dvyukov@google.com
Cc:     SEO HOYOUNG <hy50.seo@samsung.com>
Subject: [PATCH v1] lib/stackdepot: limit nr_entries size
Date:   Mon, 17 Apr 2023 14:16:37 +0900
Message-Id: <20230417051637.103964-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmqS7vNZsUgzd72CzmrF/DZvF94nR2
        iwkP29gtnh57xG7RdmY7q0X7x73MFqsXP2CxuLxrDpvFvTX/WS1OHzvBYnG/z8HizLQii8mX
        FrBZzG7sY3Tg89g56y67x4JNpR6bPk1i9zgx4zeLx/t9V9k8+rasYvRYv+Uqi8eZBUfYPTaf
        rvb4vEkugCsq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DX
        LTMH6HwlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5qiZWh
        gYGRKVBhQnbG4sflBXPtKiZOXcPawHjZvIuRk0NCwERi2b+FjF2MXBxCAjsYJda17GKHcD4x
        Smx9/5gZwvnGKDFtfy9QGQdYy4OF3BDxvYwSMxtbWCCcH4wSt1btZgKZyyagIbHm2CEmkISI
        wBQmiU1fzrODJJgF1CQ+313GAmILC1hKTHt8kBnEZhFQlVi+/T2YzStgJXHt0x52iAPlJRY1
        /GaCiAtKnJz5hAVijrxE89bZYOdJCCzlkDj4dBEzRIOLxOqrz6FsYYlXx7dADZKSeNnfBmVn
        SzTuWQtlV0jM3TyZEcI2lpj1rB3sTWYBTYn1u/QhPlaWOHILai2fRMfhv+wQYV6JjjYhiEYl
        iTNzb0OFJSQOzs6BCHtIXPtyiwkkLCQQK/Fpr/YERvlZSF6ZheSVWQhbFzAyr2IUSy0ozk1P
        LTYqMITHaHJ+7iZGcPLVct3BOPntB71DjEwcjIcYJTiYlUR4z7hapQjxpiRWVqUW5ccXleak
        Fh9iNAUG7kRmKdHkfGD6zyuJNzSxNDAxMzM0NzI1MFcS55W2PZksJJCeWJKanZpakFoE08fE
        wSnVwFRvJ+79TP8mz5wNzH1zT15gjl1WFbYwfs+Xi5N3fOz96nzr4IQW5QuCGd5eC2KY36ev
        62Z9qB0pe4Vt/kVxBYO+EOOrCWIB7PbKK179YEhdKH71StYmzhvPziflb9p/zMjh97+HXdPn
        ce+ez7q+9NAVI/M73jKiahsVLx8uuxp5VeLgq33aSjzPl8xI/j51QdmrsovTj+jOOqk8WTyM
        74vQnRRWkSVcqa83p6tN5CkMULt6TP/UmbOlslfKJlfUC9/4zPf/wfny1FO6T57LTNxy6z23
        0yu9RKEL3/9w1ftzuTB+bJkbeMVf4Xnon47EbcKK5SKbTkhMdLCwm/px0fkWEaNMNSHGEq4S
        s57OPlElluKMREMt5qLiRACpp6O2RwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvC7PNZsUg0V3dC3mrF/DZvF94nR2
        iwkP29gtnh57xG7RdmY7q0X7x73MFqsXP2CxuLxrDpvFvTX/WS1OHzvBYnG/z8HizLQii8mX
        FrBZzG7sY3Tg89g56y67x4JNpR6bPk1i9zgx4zeLx/t9V9k8+rasYvRYv+Uqi8eZBUfYPTaf
        rvb4vEkugCuKyyYlNSezLLVI3y6BK2Px4/KCuXYVE6euYW1gvGzexcjBISFgIvFgIXcXIxeH
        kMBuRoklz5+ydjFyAsUlJP4vbmKCsIUl7rccYYUo+sYosf/iVWaQBJuAhsSaY4eYQBIiAsuY
        JHavvsAIkmAWUJP4fHcZC4gtLGApMe3xQbAGFgFVieXb34PZvAJWEtc+7WGH2CAvsajhNxNE
        XFDi5MwnLBBz5CWat85mnsDINwtJahaS1AJGplWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ
        +bmbGMFRoaW5g3H7qg96hxiZOBgPMUpwMCuJ8J5xtUoR4k1JrKxKLcqPLyrNSS0+xCjNwaIk
        znuh62S8kEB6YklqdmpqQWoRTJaJg1OqgWnhjIXfZh4QErDKLq387+kyaeKZJyHFmqElBXN4
        OGue9Ol/nnLN1/r8WokberNKZW3XsZzYLKO5dkmNm+yR0xMtYp1czXTrs5lLt65xidihcJdh
        5+Irx9sX+wW/mKW58vi5Y8xr1y10/s4QrMu6cXM6+8lbrhz7f099Jfb5sePrA0kbDULkW2SW
        r39cdWiioF+qyQE7m4dJ05ZtLPG5umLanV2btYtztKadFhBZONt7w7WLkzZyfHwjp9z6oOvx
        Sx/L/DvKeuXXzyWq/TKJ9Vvs4mbf3/km9t+BeUceOCjtZNNauP7Vpg0pXG//qnrxHNmruPiz
        WZvvBcGMkkUZNtE73kivv39E3yeuXEjk5d52JZbijERDLeai4kQA56N4ovkCAAA=
X-CMS-MailID: 20230417051556epcas2p25b57d681bfae498b30ff33f0a96033d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230417051556epcas2p25b57d681bfae498b30ff33f0a96033d6
References: <CGME20230417051556epcas2p25b57d681bfae498b30ff33f0a96033d6@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While using the MCQ feature of UFS, dump stack was detected very deeply.
If this continues to happen, depot_alloc_stack() will continue to exceed
STACK_ALLOC_SIZE and STACK_ALLOC_MAX_SLABS, eventually resulting 
in the warning "Stack depot reached limit capacity".

So want to limit the size of entries stored in it.
25 is a test value, and we found that in a normal case,
the depth of the stack does not exceed 25.

[ 2479.383395]I[0:launcher-loader: 1719] Stack depot reached limit capacity
[ 2479.383538]I[0:launcher-loader: 1719] WARNING: CPU: 0 PID: 1719 at lib/stackdepot.c:129 __stack_depot_save+0x464/0x46c
[ 2479.385693]I[0:launcher-loader: 1719] pstate: 624000c5 (nZCv daIF +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
[ 2479.385724]I[0:launcher-loader: 1719] pc : __stack_depot_save+0x464/0x46c
[ 2479.385751]I[0:launcher-loader: 1719] lr : __stack_depot_save+0x460/0x46c
[ 2479.385774]I[0:launcher-loader: 1719] sp : ffffffc0080073c0
[ 2479.385793]I[0:launcher-loader: 1719] x29: ffffffc0080073e0 x28: ffffffd00b78a000 x27: 0000000000000000
[ 2479.385839]I[0:launcher-loader: 1719] x26: 000000000004d1dd x25: ffffff891474f000 x24: 00000000ca64d1dd
[ 2479.385882]I[0:launcher-loader: 1719] x23: 0000000000000200 x22: 0000000000000220 x21: 0000000000000040
[ 2479.385925]I[0:launcher-loader: 1719] x20: ffffffc008007440 x19: 0000000000000000 x18: 0000000000000000
[ 2479.385969]I[0:launcher-loader: 1719] x17: 2065726568207475 x16: 000000000000005e x15: 2d2d2d2d2d2d2d20
[ 2479.386013]I[0:launcher-loader: 1719] x14: 5d39313731203a72 x13: 00000000002f6b30 x12: 00000000002f6af8
[ 2479.386057]I[0:launcher-loader: 1719] x11: 00000000ffffffff x10: ffffffb90aacf000 x9 : e8a74a6c16008800
[ 2479.386101]I[0:launcher-loader: 1719] x8 : e8a74a6c16008800 x7 : 00000000002f6b30 x6 : 00000000002f6af8
[ 2479.386145]I[0:launcher-loader: 1719] x5 : ffffffc0080070c8 x4 : ffffffd00b192380 x3 : ffffffd0092b313c
[ 2479.386189]I[0:launcher-loader: 1719] x2 : 0000000000000001 x1 : 0000000000000004 x0 : 0000000000000022
[ 2479.386231]I[0:launcher-loader: 1719] Call trace:
[ 2479.386248]I[0:launcher-loader: 1719]  __stack_depot_save+0x464/0x46c
[ 2479.386273]I[0:launcher-loader: 1719]  kasan_save_stack+0x58/0x70
[ 2479.386303]I[0:launcher-loader: 1719]  save_stack_info+0x34/0x138
[ 2479.386331]I[0:launcher-loader: 1719]  kasan_save_free_info+0x18/0x24
[ 2479.386358]I[0:launcher-loader: 1719]  ____kasan_slab_free+0x16c/0x170
[ 2479.386385]I[0:launcher-loader: 1719]  __kasan_slab_free+0x10/0x20
[ 2479.386410]I[0:launcher-loader: 1719]  kmem_cache_free+0x238/0x53c
[ 2479.386435]I[0:launcher-loader: 1719]  mempool_free_slab+0x1c/0x28
[ 2479.386460]I[0:launcher-loader: 1719]  mempool_free+0x7c/0x1a0
[ 2479.386484]I[0:launcher-loader: 1719]  bvec_free+0x34/0x80
[ 2479.386514]I[0:launcher-loader: 1719]  bio_free+0x60/0x98
[ 2479.386540]I[0:launcher-loader: 1719]  bio_put+0x50/0x21c
[ 2479.386567]I[0:launcher-loader: 1719]  f2fs_write_end_io+0x4ac/0x4d0
[ 2479.386594]I[0:launcher-loader: 1719]  bio_endio+0x2dc/0x300
[ 2479.386622]I[0:launcher-loader: 1719]  __dm_io_complete+0x324/0x37c
[ 2479.386650]I[0:launcher-loader: 1719]  dm_io_dec_pending+0x60/0xa4
[ 2479.386676]I[0:launcher-loader: 1719]  clone_endio+0xf8/0x2f0
[ 2479.386700]I[0:launcher-loader: 1719]  bio_endio+0x2dc/0x300
[ 2479.386727]I[0:launcher-loader: 1719]  blk_update_request+0x258/0x63c
[ 2479.386754]I[0:launcher-loader: 1719]  scsi_end_request+0x50/0x304
[ 2479.386782]I[0:launcher-loader: 1719]  scsi_io_completion+0x88/0x160
[ 2479.386808]I[0:launcher-loader: 1719]  scsi_finish_command+0x17c/0x194
[ 2479.386833]I[0:launcher-loader: 1719]  scsi_complete+0xcc/0x158
[ 2479.386859]I[0:launcher-loader: 1719]  blk_mq_complete_request+0x4c/0x5c
[ 2479.386885]I[0:launcher-loader: 1719]  scsi_done_internal+0xf4/0x1e0
[ 2479.386910]I[0:launcher-loader: 1719]  scsi_done+0x14/0x20
[ 2479.386935]I[0:launcher-loader: 1719]  ufshcd_compl_one_cqe+0x578/0x71c
[ 2479.386963]I[0:launcher-loader: 1719]  ufshcd_mcq_poll_cqe_nolock+0xc8/0x150
[ 2479.386991]I[0:launcher-loader: 1719]  ufshcd_intr+0x868/0xc0c
[ 2479.387017]I[0:launcher-loader: 1719]  __handle_irq_event_percpu+0xd0/0x348
[ 2479.387044]I[0:launcher-loader: 1719]  handle_irq_event_percpu+0x24/0x74
[ 2479.387068]I[0:launcher-loader: 1719]  handle_irq_event+0x74/0xe0
[ 2479.387091]I[0:launcher-loader: 1719]  handle_fasteoi_irq+0x174/0x240
[ 2479.387118]I[0:launcher-loader: 1719]  handle_irq_desc+0x7c/0x2c0
[ 2479.387147]I[0:launcher-loader: 1719]  generic_handle_domain_irq+0x1c/0x28
[ 2479.387174]I[0:launcher-loader: 1719]  gic_handle_irq+0x64/0x158
[ 2479.387204]I[0:launcher-loader: 1719]  call_on_irq_stack+0x2c/0x54
[ 2479.387231]I[0:launcher-loader: 1719]  do_interrupt_handler+0x70/0xa0
[ 2479.387258]I[0:launcher-loader: 1719]  el1_interrupt+0x34/0x68
[ 2479.387283]I[0:launcher-loader: 1719]  el1h_64_irq_handler+0x18/0x24
[ 2479.387308]I[0:launcher-loader: 1719]  el1h_64_irq+0x68/0x6c
[ 2479.387332]I[0:launcher-loader: 1719]  blk_attempt_bio_merge+0x8/0x170
[ 2479.387356]I[0:launcher-loader: 1719]  blk_mq_attempt_bio_merge+0x78/0x98
[ 2479.387383]I[0:launcher-loader: 1719]  blk_mq_submit_bio+0x324/0xa40
[ 2479.387409]I[0:launcher-loader: 1719]  __submit_bio+0x104/0x138
[ 2479.387436]I[0:launcher-loader: 1719]  submit_bio_noacct_nocheck+0x1d0/0x4a0
[ 2479.387462]I[0:launcher-loader: 1719]  submit_bio_noacct+0x618/0x804
[ 2479.387487]I[0:launcher-loader: 1719]  submit_bio+0x164/0x180
[ 2479.387511]I[0:launcher-loader: 1719]  f2fs_submit_read_bio+0xe4/0x1c4
[ 2479.387537]I[0:launcher-loader: 1719]  f2fs_mpage_readpages+0x888/0xa4c
[ 2479.387563]I[0:launcher-loader: 1719]  f2fs_readahead+0xd4/0x19c
[ 2479.387587]I[0:launcher-loader: 1719]  read_pages+0xb0/0x4ac
[ 2479.387614]I[0:launcher-loader: 1719]  page_cache_ra_unbounded+0x238/0x288
[ 2479.387642]I[0:launcher-loader: 1719]  do_page_cache_ra+0x60/0x6c
[ 2479.387669]I[0:launcher-loader: 1719]  page_cache_ra_order+0x318/0x364
[ 2479.387695]I[0:launcher-loader: 1719]  ondemand_readahead+0x30c/0x3d8
[ 2479.387722]I[0:launcher-loader: 1719]  page_cache_sync_ra+0xb4/0xc8
[ 2479.387749]I[0:launcher-loader: 1719]  filemap_read+0x268/0xd24
[ 2479.387777]I[0:launcher-loader: 1719]  f2fs_file_read_iter+0x1a0/0x62c
[ 2479.387806]I[0:launcher-loader: 1719]  vfs_read+0x258/0x34c
[ 2479.387831]I[0:launcher-loader: 1719]  ksys_pread64+0x8c/0xd0
[ 2479.387857]I[0:launcher-loader: 1719]  __arm64_sys_pread64+0x48/0x54
[ 2479.387881]I[0:launcher-loader: 1719]  invoke_syscall+0x58/0x158
[ 2479.387909]I[0:launcher-loader: 1719]  el0_svc_common+0xf0/0x134
[ 2479.387935]I[0:launcher-loader: 1719]  do_el0_svc+0x44/0x114
[ 2479.387961]I[0:launcher-loader: 1719]  el0_svc+0x2c/0x80
[ 2479.387985]I[0:launcher-loader: 1719]  el0t_64_sync_handler+0x48/0x114
[ 2479.388010]I[0:launcher-loader: 1719]  el0t_64_sync+0x190/0x194
[ 2479.388038]I[0:launcher-loader: 1719] Kernel panic - not syncing: kernel: panic_on_warn set ...

Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
---
 lib/stackdepot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 2f5aa851834e..f158729598a6 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -43,6 +43,7 @@
 #define DEPOT_MAX_POOLS \
 	(((1LL << (DEPOT_POOL_INDEX_BITS)) < DEPOT_POOLS_CAP) ? \
 	 (1LL << (DEPOT_POOL_INDEX_BITS)) : DEPOT_POOLS_CAP)
+#define DEPO_MAX_DEPTH	25
 
 /* Compact structure that stores a reference to a stack. */
 union handle_parts {
@@ -375,7 +376,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 	 * filter_irq_stacks() to simplify all callers' use of stack depot.
 	 */
 	nr_entries = filter_irq_stacks(entries, nr_entries);
-
+	nr_entries = nr_entries > DEPO_MAX_DEPTH ? DEPO_MAX_DEPTH : nr_entries;
 	if (unlikely(nr_entries == 0) || stack_depot_disabled)
 		goto fast_exit;
 
-- 
2.26.0

