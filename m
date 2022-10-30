Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB88612739
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 04:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJ3DqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 23:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJ3DqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 23:46:20 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537C315730
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 20:46:19 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id o4so13003011ljp.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 20:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sp8bHwLrWZSds5lmdel+BN8d5LhT4/IKfgXdbYjTqiw=;
        b=p4ETo3RUzobyXcJAcDaDMlL+/p3HOtKhTQczWzLPW+blfMMmGT9JQkcUY/xRPucg6/
         8NjxSPaLazDNHMxN2oUTiM7R1LXJ2X+HjXvAgC7ZQWFv5zusfl/1//bGyrPQUDoDNI98
         GH3V6oGNxWOGajeS8bIUIB79UsSyQBZdDVd+M7YCsS0m/k1n0K9w53CAbgsCRHNeK387
         VXm+GJfq0JxHDyu2OjTuwQzxmwxdmae8D8/wq60VoBLfAJ5A20KbWH+UVhoIRYqlg1D/
         MF7Dz46eSNCceqAUAJk9Z5HM18cl2s9u615WLeoPRv1cwwdtiLwvbBYMKSQEQbMHXqb3
         fkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sp8bHwLrWZSds5lmdel+BN8d5LhT4/IKfgXdbYjTqiw=;
        b=ifPRdN3SI91S5hMfuK+IGexQ20oHCu+tM1XTIZ8Kol3tr5ju0RdU6DG15hdIzmX/VC
         xm26P8jQ13/wXWOPJ3bqWq4YlZazgzX1naX925EjHYW2LMiaNnxtdOL7HHj26Rf4SNbt
         //ZNOuzBCjH9taWw0E44+tDrf1wtgm/BQPYbKWPeh4nhFulFLr7YpTVFRomJ8jBe/X5S
         aUdFUa1R9939tv5OsZQkLkUViYs5u8+o9MLzOIUcPtIb0DSGhbdz55hfoif5RZuZsivN
         01+sS68q0kXY0zpsT2d7Q3YiTY3022E0R1RZ7TO+UXPOeZwrza+wm707UC3ii0s+VOjr
         jMvQ==
X-Gm-Message-State: ACrzQf2ysK7teuOpL+kgMJwiIFXKNzNYYLq5gKJD58uE0+pLwDVtD9W8
        7UyS/OLiVLfhqBJwzpValW0uf9hXTU2nsZdRyzM=
X-Google-Smtp-Source: AMsMyM4wCkIgCP6CqWFIBmoZE0sUvRhnWNcEQYez7TIHd1Lo4Ue9fdRALgDvAY3ng+vt+hdGraCeX84wx2Qoz6P7aTI=
X-Received: by 2002:a2e:b16b:0:b0:277:3946:7611 with SMTP id
 a11-20020a2eb16b000000b0027739467611mr2877585ljm.392.1667101577318; Sat, 29
 Oct 2022 20:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <1667101354-4669-1-git-send-email-zhaoyang.huang@unisoc.com>
In-Reply-To: <1667101354-4669-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Sun, 30 Oct 2022 11:45:48 +0800
Message-ID: <CAGWkznEEhWh-RK1Uif3z-bG759u-0OiNXoBY=j+F-X8BwWUeNA@mail.gmail.com>
Subject: Re: [PATCHv3] mm: use stack_depot for recording kmemleak's backtrace
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes bellowing lkp report by having
CONFIG_DEBUG_KMEMLEAK select CONFIG_STACK_DEPOT by default and remove
unused function.

tree:   https://github.com/ammarfaizi2/linux-block akpm/mm/mm-unstable
head:   eecc1f68b7ae1e677dd01b728e58de61a2f8ae71
commit: a3ed421a1d5f0bea0bcd91a0d001428b2c42ecbe [216/244] mm: use
stack_depot for recording kmemleak's backtrace
config: s390-randconfig-r021-20221030
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project
791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
-O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/a3ed421a1d5f0bea0bcd91a0d001428b2c42ecbe
        git remote add ammarfaizi2-block
https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block akpm/mm/mm-unstable
        git checkout a3ed421a1d5f0bea0bcd91a0d001428b2c42ecbe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1
O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390x-linux-ld: DWARF error: could not find abbrev number 13221
   mm/kmemleak.o: in function `__create_object':
>> kmemleak.c:(.text+0x40a): undefined reference to `stack_depot_print'
   s390x-linux-ld: mm/kmemleak.o: in function `paint_ptr':
   kmemleak.c:(.text+0xaf8): undefined reference to `stack_depot_print'
   s390x-linux-ld: mm/kmemleak.o: in function `kmemleak_scan':
>> kmemleak.c:(.text+0x19ee): undefined reference to `stack_depot_fetch'
   s390x-linux-ld: mm/kmemleak.o: in function `dump_str_object_info':
   kmemleak.c:(.text+0x1bac): undefined reference to `stack_depot_print'
>> s390x-linux-ld: kmemleak.c:(.text+0x1c40): undefined reference to `stack_depot_print'
   s390x-linux-ld: mm/kmemleak.o: in function `scan_block':
   kmemleak.c:(.text+0x249a): undefined reference to `stack_depot_print'
   s390x-linux-ld: mm/kmemleak.o: in function `kmemleak_seq_show':
   kmemleak.c:(.text+0x2f28): undefined reference to `stack_depot_fetch'
   s390x-linux-ld: mm/kmemleak.o: in function `kmemleak_vmalloc':
>> kmemleak.c:(.ref.text+0x290): undefined reference to `stack_depot_print'
   s390x-linux-ld: mm/kmemleak.o: in function `kmemleak_free':
   kmemleak.c:(.ref.text+0x66c): undefined reference to `stack_depot_print'
   s390x-linux-ld: mm/kmemleak.o: in function `kmemleak_free_percpu':
   kmemleak.c:(.ref.text+0xb44): undefined reference to `stack_depot_print'
   s390x-linux-ld: mm/kmemleak.o: in function `kmemleak_scan_area':
   kmemleak.c:(.ref.text+0x1248): undefined reference to `stack_depot_print'
   s390x-linux-ld: mm/kmemleak.o: in function `kmemleak_no_scan':
   kmemleak.c:(.ref.text+0x1622): undefined reference to `stack_depot_print'

On Sun, Oct 30, 2022 at 11:43 AM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Using stack_depot to record kmemleak's backtrace which has been implemented
> on slub for reducing redundant information.
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: ke.wang <ke.wang@unisoc.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> changes of v2: fix bugs of stack_depot_init related issue
> changes of v3: have DEBUG_KMEMLEAK select STACK_DEPOT by default
>                remove unuse functions
> ---
> ---
>  lib/Kconfig.debug |  1 +
>  mm/kmemleak.c     | 48 +++++++++++++++++++++++++++++-------------------
>  2 files changed, 30 insertions(+), 19 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index bcbe60d..0def8e0 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -717,6 +717,7 @@ config DEBUG_KMEMLEAK
>         select STACKTRACE if STACKTRACE_SUPPORT
>         select KALLSYMS
>         select CRC32
> +       select STACKDEPOT
>         help
>           Say Y here if you want to enable the memory leak
>           detector. The memory allocation/freeing is traced in a way
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 1eddc01..cedc6f3 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -79,6 +79,7 @@
>  #include <linux/mutex.h>
>  #include <linux/rcupdate.h>
>  #include <linux/stacktrace.h>
> +#include <linux/stackdepot.h>
>  #include <linux/cache.h>
>  #include <linux/percpu.h>
>  #include <linux/memblock.h>
> @@ -159,8 +160,7 @@ struct kmemleak_object {
>         u32 checksum;
>         /* memory ranges to be scanned inside an object (empty for all) */
>         struct hlist_head area_list;
> -       unsigned long trace[MAX_TRACE];
> -       unsigned int trace_len;
> +       depot_stack_handle_t trace_handle;
>         unsigned long jiffies;          /* creation timestamp */
>         pid_t pid;                      /* pid of the current task */
>         char comm[TASK_COMM_LEN];       /* executable name */
> @@ -343,21 +343,24 @@ static bool unreferenced_object(struct kmemleak_object *object)
>   * print_unreferenced function must be called with the object->lock held.
>   */
>  static void print_unreferenced(struct seq_file *seq,
> -                              struct kmemleak_object *object)
> +               struct kmemleak_object *object)
>  {
>         int i;
> +       unsigned long *entries;
> +       unsigned int nr_entries;
>         unsigned int msecs_age = jiffies_to_msecs(jiffies - object->jiffies);
>
> +       nr_entries = stack_depot_fetch(object->trace_handle, &entries);
>         warn_or_seq_printf(seq, "unreferenced object 0x%08lx (size %zu):\n",
> -                  object->pointer, object->size);
> +                       object->pointer, object->size);
>         warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu (age %d.%03ds)\n",
> -                  object->comm, object->pid, object->jiffies,
> -                  msecs_age / 1000, msecs_age % 1000);
> +                       object->comm, object->pid, object->jiffies,
> +                       msecs_age / 1000, msecs_age % 1000);
>         hex_dump_object(seq, object);
>         warn_or_seq_printf(seq, "  backtrace:\n");
>
> -       for (i = 0; i < object->trace_len; i++) {
> -               void *ptr = (void *)object->trace[i];
> +       for (i = 0; i < nr_entries; i++) {
> +               void *ptr = (void *)entries[i];
>                 warn_or_seq_printf(seq, "    [<%p>] %pS\n", ptr, ptr);
>         }
>  }
> @@ -370,15 +373,16 @@ static void print_unreferenced(struct seq_file *seq,
>  static void dump_object_info(struct kmemleak_object *object)
>  {
>         pr_notice("Object 0x%08lx (size %zu):\n",
> -                 object->pointer, object->size);
> +                       object->pointer, object->size);
>         pr_notice("  comm \"%s\", pid %d, jiffies %lu\n",
> -                 object->comm, object->pid, object->jiffies);
> +                       object->comm, object->pid, object->jiffies);
>         pr_notice("  min_count = %d\n", object->min_count);
>         pr_notice("  count = %d\n", object->count);
>         pr_notice("  flags = 0x%x\n", object->flags);
>         pr_notice("  checksum = %u\n", object->checksum);
>         pr_notice("  backtrace:\n");
> -       stack_trace_print(object->trace, object->trace_len, 4);
> +       if (object->trace_handle)
> +               stack_depot_print(object->trace_handle);
>  }
>
>  /*
> @@ -591,12 +595,18 @@ static struct kmemleak_object *find_and_remove_object(unsigned long ptr, int ali
>         return object;
>  }
>
> -/*
> - * Save stack trace to the given array of MAX_TRACE size.
> - */
> -static int __save_stack_trace(unsigned long *trace)
> +static noinline depot_stack_handle_t set_track_prepare(void)
>  {
> -       return stack_trace_save(trace, MAX_TRACE, 2);
> +       depot_stack_handle_t trace_handle;
> +       unsigned long entries[MAX_TRACE];
> +       unsigned int nr_entries;
> +
> +       if (!kmemleak_initialized)
> +               return 0;
> +       nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
> +       trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
> +
> +       return trace_handle;
>  }
>
>  /*
> @@ -654,7 +664,7 @@ static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
>         }
>
>         /* kernel backtrace */
> -       object->trace_len = __save_stack_trace(object->trace);
> +       object->trace_handle = set_track_prepare();
>
>         raw_spin_lock_irqsave(&kmemleak_lock, flags);
>
> @@ -694,7 +704,6 @@ static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
>         rb_link_node(&object->rb_node, rb_parent, link);
>         rb_insert_color(&object->rb_node, is_phys ? &object_phys_tree_root :
>                                           &object_tree_root);
> -
>         list_add_tail_rcu(&object->object_list, &object_list);
>  out:
>         raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
> @@ -1094,7 +1103,7 @@ void __ref kmemleak_update_trace(const void *ptr)
>         }
>
>         raw_spin_lock_irqsave(&object->lock, flags);
> -       object->trace_len = __save_stack_trace(object->trace);
> +       object->trace_handle = set_track_prepare();
>         raw_spin_unlock_irqrestore(&object->lock, flags);
>
>         put_object(object);
> @@ -2064,6 +2073,7 @@ void __init kmemleak_init(void)
>         if (kmemleak_error)
>                 return;
>
> +       stack_depot_init();
>         jiffies_min_age = msecs_to_jiffies(MSECS_MIN_AGE);
>         jiffies_scan_wait = msecs_to_jiffies(SECS_SCAN_WAIT * 1000);
>
> --
> 1.9.1
>
