Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19615FE8B5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiJNGJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJNGJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:09:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36EF1A81C;
        Thu, 13 Oct 2022 23:09:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 223391F461;
        Fri, 14 Oct 2022 06:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665727784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AxWuERTisS42uO91Wt9T0iy8s6OTDiXNii5dAiOnBhk=;
        b=Nxo/ikEpdH8I7a0SGdrmaAbb4fW+h2hYvKpsXbklzXj9W1DDvPZuCfNALwZdahUzJsDanO
        JszXxBImEQ/x/WJNcyRCosnTa9uIL/2nzvnTyYrAi6JvOoIhMlutytA5UJ1TzwVfnytbnG
        bAtDwirnmkUgE3fY8GgyrHfTDFzuOdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665727784;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AxWuERTisS42uO91Wt9T0iy8s6OTDiXNii5dAiOnBhk=;
        b=JNOjO25PinlIFYvinteDhXuGesZl5wzU9xLRmUSBb+lwYlmqkuU8RapxfddqdKLVg3/OWm
        M/IT+Q6Pf1fG5ZDg==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A8A812C141;
        Fri, 14 Oct 2022 06:09:43 +0000 (UTC)
Date:   Fri, 14 Oct 2022 08:09:43 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     David Hildenbrand <david@redhat.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        Lin Liu <linl@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        petr.pavlu@suse.com
Subject: Re: [PATCH v1] kernel/module: allocate module vmap space after making
 sure the module is unique
In-Reply-To: <20221013180518.217405-1-david@redhat.com>
Message-ID: <alpine.LSU.2.21.2210140806130.17614@pobox.suse.cz>
References: <20221013180518.217405-1-david@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 13 Oct 2022, David Hildenbrand wrote:

> We already make sure to allocate percpu data only after we verified that
> the module we're loading hasn't already been loaded and isn't
> concurrently getting loaded -- that it's unique.
> 
> On big systems (> 400 CPUs and many devices) with KASAN enabled, we're now
> phasing a similar issue with the module vmap space.
> 
> When KASAN_INLINE is enabled (resulting in large module size), plenty
> of devices that udev wants to probe and plenty (> 400) of CPUs that can
> carry out that probing concurrently, we can actually run out of module
> vmap space and trigger vmap allocation errors:
> 
> [  165.818200] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
> [  165.836622] vmap allocation for size 315392 failed: use vmalloc=<size> to increase size
> [  165.837461] vmap allocation for size 315392 failed: use vmalloc=<size> to increase size
> [  165.840573] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
> [  165.841059] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
> [  165.841428] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
> [  165.841819] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
> [  165.842123] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
> [  165.843359] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
> [  165.844894] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
> [  165.847028] CPU: 253 PID: 4995 Comm: systemd-udevd Not tainted 5.19.0 #2
> [  165.935689] Hardware name: Lenovo ThinkSystem SR950 -[7X12ABC1WW]-/-[7X12ABC1WW]-, BIOS -[PSE130O-1.81]- 05/20/2020
> [  165.947343] Call Trace:
> [  165.950075]  <TASK>
> [  165.952425]  dump_stack_lvl+0x57/0x81
> [  165.956532]  warn_alloc.cold+0x95/0x18a
> [  165.960836]  ? zone_watermark_ok_safe+0x240/0x240
> [  165.966100]  ? slab_free_freelist_hook+0x11d/0x1d0
> [  165.971461]  ? __get_vm_area_node+0x2af/0x360
> [  165.976341]  ? __get_vm_area_node+0x2af/0x360
> [  165.981219]  __vmalloc_node_range+0x291/0x560
> [  165.986087]  ? __mutex_unlock_slowpath+0x161/0x5e0
> [  165.991447]  ? move_module+0x4c/0x630
> [  165.995547]  ? vfree_atomic+0xa0/0xa0
> [  165.999647]  ? move_module+0x4c/0x630
> [  166.003741]  module_alloc+0xe7/0x170
> [  166.007747]  ? move_module+0x4c/0x630
> [  166.011840]  move_module+0x4c/0x630
> [  166.015751]  layout_and_allocate+0x32c/0x560
> [  166.020519]  load_module+0x8e0/0x25c0
> [  166.024623]  ? layout_and_allocate+0x560/0x560
> [  166.029586]  ? kernel_read_file+0x286/0x6b0
> [  166.034269]  ? __x64_sys_fspick+0x290/0x290
> [  166.038946]  ? userfaultfd_unmap_prep+0x430/0x430
> [  166.044203]  ? lock_downgrade+0x130/0x130
> [  166.048698]  ? __do_sys_finit_module+0x11a/0x1c0
> [  166.053854]  __do_sys_finit_module+0x11a/0x1c0
> [  166.058818]  ? __ia32_sys_init_module+0xa0/0xa0
> [  166.063882]  ? __seccomp_filter+0x92/0x930
> [  166.068494]  do_syscall_64+0x59/0x90
> [  166.072492]  ? do_syscall_64+0x69/0x90
> [  166.076679]  ? do_syscall_64+0x69/0x90
> [  166.080864]  ? do_syscall_64+0x69/0x90
> [  166.085047]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> [  166.090984]  ? lockdep_hardirqs_on+0x79/0x100
> [  166.095855]  entry_SYSCALL_64_after_hwframe+0x63/0xcd[  165.818200] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
> 
> Interestingly, when reducing the number of CPUs (nosmt), it works as
> expected.
> 
> The underlying issue is that we first allocate memory (including module
> vmap space) in layout_and_allocate(), and then verify whether the module
> is unique in add_unformed_module(). So we end up allocating module vmap
> space even though we might not need it -- which is a problem when modules
> are big and we can have a lot of concurrent probing of the same set of
> modules as on the big system at hand.
> 
> Unfortunately, we cannot simply add the module earlier, because
> move_module() -- that allocates the module vmap space -- essentially
> brings the module to life from a temporary one. Adding the temporary one
> and replacing it is also sub-optimal (because replacing it would require
> to synchronize against RCU) and feels kind of dangerous judging that we
> end up copying it.
> 
> So instead, add a second list (pending_load_infos) that tracks the modules
> (via their load_info) that are unique and are still getting loaded
> ("pending"), but haven't made it to the actual module list yet. This
> shouldn't have a notable runtime overhead when concurrently loading
> modules: the new list is expected to usually either be empty or contain
> very few entries for a short time.
> 
> Thanks to Uladzislau for his help to verify that it's not actually a
> vmap code issue.

this seems to be related to what 
https://lore.kernel.org/all/20220919123233.8538-1-petr.pavlu@suse.com/ 
tries to solve. Just your symptoms are different. Does the patch set fix 
your issue too?

Regards
Miroslav
