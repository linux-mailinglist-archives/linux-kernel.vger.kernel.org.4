Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBA662B463
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbiKPH6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiKPH63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:58:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CD424F00;
        Tue, 15 Nov 2022 23:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GIDdGR9NVpGZvPLCxr6Lt5iCaPSKMyIMMAkRo9Z5H0U=; b=GjO5nedtvQbFTSqVOHRhbXy9R8
        wVqBzTfrNIv7JpJlixcjrIFsfztRINtv8hTfXP2xdXEzm1cusHr/wBzkJXgfC1yhvBcEie3kT73/O
        01LQ4kQ1f6HUsl8HrvglXy/FRBy9LtDRvVeVVUpFuiLU2bM1O526Y4aH4dTvRXBW0GPumyvly0J8g
        j8A65L4jHZ6Xw5pRJSKwaDU4OJKbnsY+aJWT+IdlxO59woGeC73lkhcvx1HU3HmkmDQlDcMZG1atN
        c3mMvdJgqYg3ThnwdQQzL544qHjEtDzguypzVWJunrU6ZXYfGQHiHRXlUFVNS4So63yUHmxiRrkDX
        H//I7SVQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovDIx-00HA6L-AC; Wed, 16 Nov 2022 07:57:55 +0000
Date:   Wed, 16 Nov 2022 07:57:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Conor Dooley <conor@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rustam Kovhaev <rkovhaev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Shiyan <shc_work@mail.ru>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor.Dooley@microchip.com, Paul Cercueil <paul@crapouillou.net>
Subject: Re: Deprecating and removing SLOB
Message-ID: <Y3SYA31zobR6/qbj@casper.infradead.org>
References: <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
 <c1caa5ce-eeaf-8038-2dea-051c98aade45@suse.cz>
 <Y260tkNHc2vFITJ3@spud>
 <a5bba3ca-da19-293c-c01b-a28291533466@opensource.wdc.com>
 <93079aba-362e-5d1e-e9b4-dfe3a84da750@opensource.wdc.com>
 <44da078c-b630-a249-bf50-67df83cd8347@suse.cz>
 <35650fd4-3152-56db-7c27-b9997e31cfc7@opensource.wdc.com>
 <Y3JU5cfyid1rBoOy@hyeyoo>
 <97c0735c-3127-83d5-30ff-8e57c6634f6e@opensource.wdc.com>
 <0e45a2f2-6dd5-5a43-c1a0-7520c1ed2675@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e45a2f2-6dd5-5a43-c1a0-7520c1ed2675@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 01:28:14PM +0900, Damien Le Moal wrote:
> On 11/15/22 13:24, Damien Le Moal wrote:
> > 6.1-rc5, SLOB:
> >     - 623 free pages
> >     - 629 free pages
> >     - 629 free pages
> > 6.1-rc5, SLUB:
> >     - 448 free pages
> >     - 448 free pages
> >     - 429 free pages
> > 6.1-rc5, SLUB + slub_max_order=0:
> >     - Init error, shell prompt but no shell command working
> >     - Init error, no shell prompt
> >     - 508 free pages
> >     - Init error, shell prompt but no shell command working
> > 6.1-rc5, SLUB + patch:
> >     - Init error, shell prompt but no shell command working
> >     - 433 free pages
> >     - 448 free pages
> >     - 423 free pages
> > 6.1-rc5, SLUB + slub_max_order=0 + patch:
> >     - Init error, no shell prompt
> >     - Init error, shell prompt, 499 free pages
> >     - Init error, shell prompt but no shell command working
> >     - Init error, no shell prompt
> > 
> > No changes for SLOB results, expected.
> > 
> > For default SLUB, I did get all clean boots this time and could run the
> > cat command. But I do see shell fork failures if I keep running commands.
> > 
> > For SLUB + slub_max_order=0, I only got one clean boot with 508 free
> > pages. Remaining runs failed to give a shell prompt or allow running cat
> > command. For the clean boot, I do see higher number of free pages.
> > 
> > SLUB with the patch was nearly identical to SLUB without the patch.
> > 
> > And SLUB+patch+slub_max_order=0 gave again a lot of errors/bad boot. I
> > could run the cat command only once, giving 499 free pages, so better than
> > regular SLUB. But it seems that the memory is more fragmented as
> > allocations fail more often.
> 
> Note about the last case (SLUB+patch+slub_max_order=0). Here are the
> messages I got when the init shell process fork failed:
> 
> [    1.217998] nommu: Allocation of length 491520 from process 1 (sh) failed
> [    1.224098] active_anon:0 inactive_anon:0 isolated_anon:0
> [    1.224098]  active_file:5 inactive_file:12 isolated_file:0
> [    1.224098]  unevictable:0 dirty:0 writeback:0
> [    1.224098]  slab_reclaimable:38 slab_unreclaimable:459
> [    1.224098]  mapped:0 shmem:0 pagetables:0
> [    1.224098]  sec_pagetables:0 bounce:0
> [    1.224098]  kernel_misc_reclaimable:0
> [    1.224098]  free:859 free_pcp:0 free_cma:0
> [    1.260419] Node 0 active_anon:0kB inactive_anon:0kB active_file:20kB
> inactive_file:48kB unevictable:0kB isolated(anon):0kB isolated(file):0kB
> mapped:0kB dirty:0kB writeback:0kB shmem:0kB writeback_tmp:0kB
> kernel_stack:576kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
> [    1.285147] DMA32 free:3436kB boost:0kB min:312kB low:388kB high:464kB
> reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB
> inactive_file:28kB unevictable:0kB writepending:0kB present:8192kB
> managed:6240kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [    1.310654] lowmem_reserve[]: 0 0 0
> [    1.314089] DMA32: 17*4kB (U) 10*8kB (U) 7*16kB (U) 6*32kB (U) 11*64kB
> (U) 6*128kB (U) 6*256kB (U) 0*512kB 0*1024kB 0*2048kB 0*4096kB = 3460kB
> [    1.326883] 33 total pagecache pages
> [    1.330420] binfmt_flat: Unable to allocate RAM for process text/data,
> errno -12

What you're seeing here is memory fragmentation.  There's more than 512kB
of memory available, but nommu requires it to be contiguous, and it's
not.  This is pretty bad, really.  We didn't even finish starting up
and already we've managed to allocate at least one page from each of
the 16 512kB chunks which existed.  Commit df48a5f7a3bb was supposed
to improve matters by making exact allocations reassemble once they
were freed.  Maybe the problem is entirely different.
