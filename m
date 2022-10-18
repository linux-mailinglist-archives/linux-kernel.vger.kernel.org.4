Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8422C6030EB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJRQoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJRQoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:44:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CC9EA362
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:44:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B4E1B82042
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 16:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044F4C433C1;
        Tue, 18 Oct 2022 16:44:10 +0000 (UTC)
Date:   Tue, 18 Oct 2022 12:44:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 4/7] mm/vmalloc: Use a trace_alloc_vmap_area event
Message-ID: <20221018124412.3beca846@gandalf.local.home>
In-Reply-To: <Y07Rsz5R1ufZu6Od@pc636>
References: <20221017160233.16582-7-urezki@gmail.com>
        <202210180250.V8hzNH8X-lkp@intel.com>
        <Y07Rsz5R1ufZu6Od@pc636>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 18:17:55 +0200
Uladzislau Rezki <urezki@gmail.com> wrote:

> Hello, Steven.
> 
> > 
> > [auto build test ERROR on akpm-mm/mm-everything]
> > [also build test ERROR on linus/master v6.1-rc1 next-20221017]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Uladzislau-Rezki-Sony/Add-basic-trace-events-for-vmap-vmalloc/20221018-000544
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> > patch link:    https://lore.kernel.org/r/20221017160233.16582-7-urezki%40gmail.com
> > patch subject: [PATCH 4/7] mm/vmalloc: Use a trace_alloc_vmap_area event
> > config: um-i386_defconfig
> > compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> > reproduce (this is a W=1 build):
> >         # https://github.com/intel-lab-lkp/linux/commit/fbc853c689b29d3bb9fe250b2653fd2dd8046fc7
> >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review Uladzislau-Rezki-Sony/Add-basic-trace-events-for-vmap-vmalloc/20221018-000544
> >         git checkout fbc853c689b29d3bb9fe250b2653fd2dd8046fc7
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    In file included from include/trace/events/vmap.h:123,
> >                     from mm/vmalloc.c:47:  
> > >> include/trace/define_trace.h:84:34: fatal error: trace/events/kernel_vmap.h: No such file or directory  
> >       84 | # define __TRACE_INCLUDE(system) <trace/events/system.h>
> >          |                                  ^
> >    compilation terminated.
> >  
> I can reproduce it. It seems it happens so far only on the ARCH=um case.
> For regular arm/x86 i do not see such build error.
> 
> If i rename the TRACE_SYSTEM macro to something different then "vmap"
> it compiles fine. In case of:
> 
> #define TRACE_SYSTEM vmap
> 
> the prefix "kernel_" is added, thus the header name becomes as kernel_vmap.h
> 
> Steven can you give some indications? Or any thoughts about it?
> 
> Thank you in advance!

It comes from this:

   arch/um/Makefile:# -Dvmap=kernel_vmap prevents anything from referencing the libpcap.o symbol so
   arch/um/Makefile:       $(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap      \


It defines "vmap" to "kernel_vmap" which will change the above
TRACE_SYSTEM Define to:

  #define TRACE_SYSTEM kernel_vmap

and that will confuse everything else.

-- Steve


> 
> --
> Uladzislau Rezki

