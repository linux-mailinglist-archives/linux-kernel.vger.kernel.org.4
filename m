Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACD36C05CC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 23:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjCSWA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 18:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCSWA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 18:00:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0156E14239;
        Sun, 19 Mar 2023 15:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76A7FB80D28;
        Sun, 19 Mar 2023 22:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24974C433D2;
        Sun, 19 Mar 2023 22:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679263222;
        bh=n5dARZfFatcR/h3JAA/9fYzmvZk45a19M/lZTBw1xvI=;
        h=From:To:Cc:Subject:Date:From;
        b=Kk5f+/gwsjcbiOO1/wCvoyl4Anptv1hWH8xJESI5zcw3p2CsjLWtDdmR9QdQM+3LJ
         48ck9Nbm7HCsv1BIhG0z68FKMnc+paUE4nNp8CBGtz2wXTUGG4xufiBddp5daENesA
         FQveh29Cd8GoMFH5KgVOfc/xAYlta53sbHuynvA2gW4zAcVZzL1Q+M2DEKtPvBBV59
         yQHCYCnIbS95lr+op+v93shUF7mcTAU5sabWijpg3+CfGSUEuAmbmMW/Y0uf2fPUD1
         yLw4uhA7DGldAgR2Rjl/gSBJw2t+xBv4/+fuSE7ivbtFZ//GlqgeEG925HAm/9hBOl
         99zYcrRdV3eEg==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 00/15] mm: move core MM initialization to mm/mm_init.c
Date:   Sun, 19 Mar 2023 23:59:53 +0200
Message-Id: <20230319220008.2138576-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Also in git:
https://git.kernel.org/rppt/h/mm-init/v1

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

Mike Rapoport (IBM) (15):
  mips: fix comment about pgtable_init()
  mm/cma: move init_cma_reserved_pages() to cma.c and make it static
  mm/page_alloc: add helper for checking if check_pages_enabled
  mm: move most of core MM initialization to mm/mm_init.c
  mm: handle hashdist initialization in mm/mm_init.c
  mm/page_alloc: rename page_alloc_init() to page_alloc_init_cpuhp()
  init: fold build_all_zonelists() and page_alloc_init_cpuhp() to mm_init()
  init,mm: move mm_init() to mm/mm_init.c and rename it to mm_core_init()
  mm: move pgtable_init() to mm/mm_init.c and make it static
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
 mm/cma.c                       |   21 +
 mm/internal.h                  |   45 +
 mm/mm_init.c                   | 2532 +++++++++++++++++++++++++++
 mm/page_alloc.c                | 2981 +++-----------------------------
 mm/slab.h                      |    1 +
 13 files changed, 2855 insertions(+), 2827 deletions(-)

base-commit: 4018ab1f7cec061b8425737328edefebdc0ab832
-- 
2.35.1

