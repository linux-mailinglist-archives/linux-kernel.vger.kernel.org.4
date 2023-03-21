Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DFB6C37B3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCURFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjCURFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:05:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D5E17CE9;
        Tue, 21 Mar 2023 10:05:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D59D261D3D;
        Tue, 21 Mar 2023 17:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB75C433EF;
        Tue, 21 Mar 2023 17:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679418327;
        bh=jlgHU9SCJxg4qa7O1zwTnf+v78Uv+aUw7L56oscbVn4=;
        h=From:To:Cc:Subject:Date:From;
        b=SR//Z3es/uwPV/FylYLKutrPpcqB+cPpuUl7i4+EYeHAiWOyzte/q5CE0uFzEMCc6
         Tl8W6Mm6EGyewcT/4H3YaBKW3fFGERVvWHB9EjlgGFrXEhOkY1Ro91rC3TcA/kP8hf
         5el/RQT0rmijOmgowXMYvlaZCDhd/nTZ+RD4hDdGwEIC1ILNlv2BYzQP/InXBBv4tW
         3lQUHYg74e+GwNYXAq18WY0Vq7lEpNJYq9u4M3TFXj5+giR1Zwd9gOM3Qc91FqHq9V
         5kz/HmxIbxrWgOhuL4XVyusBy/sWOl+5Ki2yioS0PR23DdRYCYzaKKpv3L2MQtNooJ
         chpznnjMxOTJw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Doug Berger <opendmb@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 00/14] mm: move core MM initialization to mm/mm_init.c
Date:   Tue, 21 Mar 2023 19:04:59 +0200
Message-Id: <20230321170513.2401534-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Also in git:
https://git.kernel.org/rppt/h/mm-init/v2

v2:
* move init_cma_reserved_pageblock() from cma.c to mm_init.c
* rename init_mem_debugging_and_hardening() to
  mem_debugging_and_hardening_init()
* inline pgtable_init() into mem_core_init()
* add Acked and Reviewed tags (thanks David, hopefully I've picked them
  right)

v1: https://lore.kernel.org/all/20230319220008.2138576-1-rppt@kernel.org
This set moves most of the core MM initialization to mm/mm_init.c.

This largely includes free_area_init() and its helpers, functions used at
boot time, mm_init() from init/main.c and some of the functions it calls.

Aside from gaining some more space before mm/page_alloc.c hits 10k lines,
this makes mm/page_alloc.c to be mostly about buddy allocator and moves the
init code out of the way, which IMO improves maintainability.

Besides, this allows to move a couple of declarations out of include/linux
and make them private to mm/.

And as an added bonus there a slight decrease in vmlinux size.
For tinyconfig and defconfig on x86 I've got

tinyconfig:
   text	   data	    bss	    dec	    hex	filename
 853206	 289376	1200128	2342710	 23bf36	a/vmlinux
 853198	 289344	1200128	2342670	 23bf0e	b/vmlinux

defconfig:
    text   	   data	    bss	    dec	    	    hex	filename
26152959	9730634	2170884	38054477	244aa4d	a/vmlinux
26152945	9730602	2170884	38054431	244aa1f	b/vmlinux


Mike Rapoport (IBM) (14):
  mips: fix comment about pgtable_init()
  mm/page_alloc: add helper for checking if check_pages_enabled
  mm: move most of core MM initialization to mm/mm_init.c
  mm: handle hashdist initialization in mm/mm_init.c
  mm/page_alloc: rename page_alloc_init() to page_alloc_init_cpuhp()
  init: fold build_all_zonelists() and page_alloc_init_cpuhp() to mm_init()
  init,mm: move mm_init() to mm/mm_init.c and rename it to mm_core_init()
  mm: call {ptlock,pgtable}_cache_init() directly from mm_core_init()
  mm: move init_mem_debugging_and_hardening() to mm/mm_init.c
  init,mm: fold late call to page_ext_init() to page_alloc_init_late()
  mm: move mem_init_print_info() to mm_init.c
  mm: move kmem_cache_init() declaration to mm/slab.h
  mm: move vmalloc_init() declaration to mm/internal.h
  MAINTAINERS: extend memblock entry to include MM initialization

 MAINTAINERS                    |    3 +-
 arch/mips/include/asm/fixmap.h |    2 +-
 include/linux/gfp.h            |    7 +-
 include/linux/mm.h             |    9 +-
 include/linux/page_ext.h       |    2 -
 include/linux/slab.h           |    1 -
 include/linux/vmalloc.h        |    4 -
 init/main.c                    |   74 +-
 mm/cma.c                       |    1 +
 mm/internal.h                  |   52 +-
 mm/mm_init.c                   | 2547 +++++++++++++++++++++++++++
 mm/page_alloc.c                | 2981 +++-----------------------------
 mm/slab.h                      |    1 +
 13 files changed, 2856 insertions(+), 2828 deletions(-)


base-commit: 4018ab1f7cec061b8425737328edefebdc0ab832
-- 
2.35.1

