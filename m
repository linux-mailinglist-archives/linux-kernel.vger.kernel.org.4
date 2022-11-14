Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F01F628323
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbiKNOrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbiKNOrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:47:15 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99348E;
        Mon, 14 Nov 2022 06:47:13 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id j12so10252298plj.5;
        Mon, 14 Nov 2022 06:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RAVDiAC6zB9a2VA9cAkzTKrj8UeLfO95holBArk2auY=;
        b=Ka6kGiT2ih/iWtCkXiSIg98dy3rf/kc4NpdyyEEbP8ONVZ/lg3ijoLiNp7Khx/vcbW
         3hTRDokhrwSFGY98NXKEpI1pRZhEa1Wr5Vj9wgrbwkkdRrTSJ6Hx8jr744wyWU2oUovU
         YVEkJh4B90VxOfeLyFQXZ+7obOJYv/sLhf6Z51AWlrj8npnPcszoVuAlf1Avc/hII4Pj
         J7tXzxCzt8d8R8Tx9KKZ4Jpl6hRMaaHM7u/T2jNPFeuZ1ofeOUSziW2WczK8mU8/CWQt
         A+eS3flkkjjUSDwxNkFJHI1WYlVWRU/8YumfqkP6qkOLSJ81yjJjxCc8/zYXvvebVbm2
         Ngdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAVDiAC6zB9a2VA9cAkzTKrj8UeLfO95holBArk2auY=;
        b=Im3rRtL5Hrc/Nsbftzd5X7drfTLx5cYCUru9kpeeaDyIarDbq8MD3LB9Ph9BHArVMk
         zlfd8ewH6iXPI6sT8bKRLsU1+umThabR7CEbKqvNmrKGnY4eIcqOa4UFjfo70nCnCV3R
         U8A4jiiQx7Ars7bnSxl10+J2dTfFxzlMqOwNFpio8wcWHMX33zJu6y6JN5VAaFtBI0/z
         5/xVXqPJEtlQAzq1/mVWGn/UtLrsZYBnaTKyKUh6o6LHvajxibfi76FKyTwDbn3e1E03
         V2OWFcg8ybT6ATVMRxWzKgKw4ZvAdp5QdNeZN0PgzX6CKVsSODlFZ17Xu91g/NpthrHJ
         S4qw==
X-Gm-Message-State: ANoB5ploV/Lg5AVottQBO7Xcj2f8bubM1oWErZOxEBWs0GeyIpLkyapS
        ejP0t0UuI6ew5wWwiuiBK90=
X-Google-Smtp-Source: AA0mqf7ZApoBFRJRPpdJdq81DvnXbtoMGmsjoAxn3Xthb1AblAdoyrTq9IJxqXo/qMAtFQ41XL/7Kw==
X-Received: by 2002:a17:90a:4f4e:b0:212:ffd2:440a with SMTP id w14-20020a17090a4f4e00b00212ffd2440amr14297465pjl.7.1668437233159;
        Mon, 14 Nov 2022 06:47:13 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id c14-20020a62f84e000000b0052d4cb47339sm6750816pfm.151.2022.11.14.06.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 06:47:12 -0800 (PST)
Date:   Mon, 14 Nov 2022 23:47:01 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Conor Dooley <conor@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <Y3JU5cfyid1rBoOy@hyeyoo>
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
 <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
 <c1caa5ce-eeaf-8038-2dea-051c98aade45@suse.cz>
 <Y260tkNHc2vFITJ3@spud>
 <a5bba3ca-da19-293c-c01b-a28291533466@opensource.wdc.com>
 <93079aba-362e-5d1e-e9b4-dfe3a84da750@opensource.wdc.com>
 <44da078c-b630-a249-bf50-67df83cd8347@suse.cz>
 <35650fd4-3152-56db-7c27-b9997e31cfc7@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35650fd4-3152-56db-7c27-b9997e31cfc7@opensource.wdc.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 08:35:31PM +0900, Damien Le Moal wrote:
> On 11/14/22 18:36, Vlastimil Babka wrote:
> > On 11/14/22 06:48, Damien Le Moal wrote:
> >> On 11/14/22 10:55, Damien Le Moal wrote:
> >>> On 11/12/22 05:46, Conor Dooley wrote:
> >>>> On Fri, Nov 11, 2022 at 11:33:30AM +0100, Vlastimil Babka wrote:
> >>>>> On 11/8/22 22:44, Pasha Tatashin wrote:
> >>>>>> On Tue, Nov 8, 2022 at 10:55 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >>>>>>>
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> as we all know, we currently have three slab allocators. As we discussed
> >>>>>>> at LPC [1], it is my hope that one of these allocators has a future, and
> >>>>>>> two of them do not.
> >>>>>>>
> >>>>>>> The unsurprising reasons include code maintenance burden, other features
> >>>>>>> compatible with only a subset of allocators (or more effort spent on the
> >>>>>>> features), blocking API improvements (more on that below), and my
> >>>>>>> inability to pronounce SLAB and SLUB in a properly distinguishable way,
> >>>>>>> without resorting to spelling out the letters.
> >>>>>>>
> >>>>>>> I think (but may be proven wrong) that SLOB is the easier target of the
> >>>>>>> two to be removed, so I'd like to focus on it first.
> >>>>>>>
> >>>>>>> I believe SLOB can be removed because:
> >>>>>>>
> >>>>>>> - AFAIK nobody really uses it? It strives for minimal memory footprint
> >>>>>>> by putting all objects together, which has its CPU performance costs
> >>>>>>> (locking, lack of percpu caching, searching for free space...). I'm not
> >>>>>>> aware of any "tiny linux" deployment that opts for this. For example,
> >>>>>>> OpenWRT seems to use SLUB and the devices these days have e.g. 128MB
> >>>>>>> RAM, not up to 16 MB anymore. I've heard anecdotes that the performance
> >>>>>>> SLOB impact is too much for those who tried. Googling for
> >>>>>>> "CONFIG_SLOB=y" yielded nothing useful.
> >>>>>>
> >>>>>> I am all for removing SLOB.
> >>>>>>
> >>>>>> There are some devices with configs where SLOB is enabled by default.
> >>>>>> Perhaps, the owners/maintainers of those devices/configs should be
> >>>>>> included into this thread:
> >>>>>>
> >>>>>> tatashin@soleen:~/x/linux$ git grep SLOB=y
> >>>>
> >>>>>> arch/riscv/configs/nommu_k210_defconfig:CONFIG_SLOB=y
> >>>>>> arch/riscv/configs/nommu_k210_sdcard_defconfig:CONFIG_SLOB=y
> >>>>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_SLOB=y
> >>>>
> >>>>>
> >>>>> Turns out that since SLOB depends on EXPERT, many of those lack it so
> >>>>> running make defconfig ends up with SLUB anyway, unless I miss something.
> >>>>> Only a subset has both SLOB and EXPERT:
> >>>>>
> >>>>>> git grep CONFIG_EXPERT `git grep -l "CONFIG_SLOB=y"`
> >>>>
> >>>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_EXPERT=y
> >>>>
> >>>> I suppose there's not really a concern with the virt defconfig, but I
> >>>> did check the output of `make nommu_k210_defconfig" and despite not
> >>>> having expert it seems to end up CONFIG_SLOB=y in the generated .config.
> >>>>
> >>>> I do have a board with a k210 so I checked with s/SLOB/SLUB and it still
> >>>> boots etc, but I have no workloads or w/e to run on it.
> >>>
> >>> I sent a patch to change the k210 defconfig to using SLUB. However...
> > 
> > Thanks!
> > 
> >>> The current default config using SLOB gives about 630 free memory pages
> >>> after boot (cat /proc/vmstat). Switching to SLUB, this is down to about
> >>> 400 free memory pages (CONFIG_SLUB_CPU_PARTIAL is off).
> > 
> > Thanks for the testing! How much RAM does the system have btw? I found 8MB
> > somewhere, is that correct?
> 
> Yep, 8MB, that's it.
> 
> > So 230 pages that's a ~920 kB difference. Last time we saw less  dramatic
> > difference [1]. But that was looking at Slab pages, not free pages. The
> > extra overhead could be also in percpu allocations, code etc.
> > 
> >>> This is with a buildroot kernel 5.19 build including a shell and sd-card
> >>> boot. With SLUB, I get clean boots and a shell prompt as expected. But I
> >>> definitely see more errors with shell commands failing due to allocation
> >>> failures for the shell process fork. So as far as the K210 is concerned,
> >>> switching to SLUB is not ideal.
> >>>
> >>> I would not want to hold on kernel mm improvements because of this toy
> >>> k210 though, so I am not going to prevent SLOB deprecation. I just wish
> >>> SLUB itself used less memory :)
> >>
> >> Did further tests with kernel 6.0.1:
> >> * SLOB: 630 free pages after boot, shell working (occasional shell fork
> >> failure happen though)
> >> * SLAB: getting memory allocation for order 7 failures on boot already
> >> (init process). Shell barely working (high frequency of shell command fork
> >> failures)
> 
> I forgot to add here that the system was down to about 500 free pages
> after boot (again from the shell with "cat /proc/vmstat").
> 
> >> * SLUB: getting memory allocation for order 7 failures on boot. I do get a
> >> shell prompt but cannot run any shell command that involves forking a new
> >> process.
> 
> For both slab and slub, I had cpu partial off, debug off and slab merge
> on, as I suspected that would lead to less memory overhead.
> I suspected memory fragmentation may be an issue but doing
> 
> echo 3 > /proc/sys/vm/drop_caches
> 
> before trying a shell command did not help much at all (it usually does on
> that board with SLOB). Note that this is all with buildroot, so this echo
> & redirect always works as it does not cause a shell fork.
> 
> >>
> >> So if we want to keep the k210 support functional with a shell, we need
> >> slob. If we reduce that board support to only one application started as
> >> the init process, then I guess anything is OK.
> > 
> > In [1] it was possible to save some more memory with more tuning. Some of
> > that required boot parameters and other code changes. In another reply [2] I
> > considered adding something like SLUB_TINY to take care of all that, so
> > looks like it would make sense to proceed with that.
> 
> If you want me to test something, let me know.

Would you try this please?

diff --git a/mm/slub.c b/mm/slub.c
index a24b71041b26..1c36c4b9aaa0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4367,9 +4367,7 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 	 * The larger the object size is, the more slabs we want on the partial
 	 * list to avoid pounding the page allocator excessively.
 	 */
-	s->min_partial = min_t(unsigned long, MAX_PARTIAL, ilog2(s->size) / 2);
-	s->min_partial = max_t(unsigned long, MIN_PARTIAL, s->min_partial);
-
+	s->min_partial = 0;
 	set_cpu_partial(s);
 
 #ifdef CONFIG_NUMA


and booting with and without boot parameter slub_max_order=0?

Thanks,
Hyeonggon

> 
> > 
> > [1]
> > https://lore.kernel.org/all/Yg9xSWEaTZLA+hYt@ip-172-31-19-208.ap-northeast-1.compute.internal/
> > [2] https://lore.kernel.org/all/eebc9dc8-6a45-c099-61da-230d06cb3157@suse.cz/
> 
> -- 
> Damien Le Moal
> Western Digital Research
