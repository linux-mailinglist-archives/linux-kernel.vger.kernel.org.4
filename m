Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D551722ABA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbjFEPSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjFEPR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:17:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2EEE8;
        Mon,  5 Jun 2023 08:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bw8IEae0nViz9T5/tm415WaEBsWa8uqIyLDMVx+BHcE=; b=hK7WwFpKh6iUwrWyy3yi1W86AE
        FegZ7KAO2JuYf8UhX04OiHpjgUdbWMmX4zr1mLJAk3TLam+w/DABXf1fShloTPiia7YN3ytZVrOqQ
        jEdc+h88JsV/3odb7gARrcIn9L9x/Oyq6+YEe6zNMgL15dZ8YHpKPYpf3aSNyhIOd+uEFRrTPl2TS
        hLRIBnmH17Gp16ad2fYUgJ1q678ZIufiRJ+1fPPSuIuA6xS7nXTPxSB24Zl2d9aUWHcm63cIxYKLv
        e4Q1/IX3yaYwvZjNKCt4xR/OeS74DiiveqQqgHXGfhmVvY8rmdgW8WQH3CdQokE9dUmOGQukjFyFe
        8L0zSSmA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6Bxm-00FvjV-1c;
        Mon, 05 Jun 2023 15:17:42 +0000
Date:   Mon, 5 Jun 2023 08:17:42 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Hildenbrand <david@redhat.com>, song@kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johan Hovold <johan@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
Message-ID: <ZH38lpTHZ/RISC1v@bombadil.infradead.org>
References: <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
 <ZHSeOUpKtyc8VKx5@hovoldconsulting.com>
 <ZHTCK2_1pF61yWIr@hovoldconsulting.com>
 <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
 <ZHYitt7P7W+8ZlSB@bombadil.infradead.org>
 <499e30cc-d015-8353-1364-50d17da58f47@redhat.com>
 <ZHd8bLPY4OQCb/Z5@bombadil.infradead.org>
 <ba60bca6-b682-4c27-3c54-2512b6f16151@redhat.com>
 <ZHoTFDkPIgglW0sU@bombadil.infradead.org>
 <fa3f1a1f-edc6-f13b-cc84-f3264b03b0b1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa3f1a1f-edc6-f13b-cc84-f3264b03b0b1@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 01:26:00PM +0200, David Hildenbrand wrote:
> I only did a single run on each kernel, should be good enough for the purpose here.
> 
> 
> 1) !debug config (not enabling KASAN)
> 
> a) master
> 
> # cat /sys/kernel/debug/modules/stats
>  Virtual mem wasted bytes       20358550424
18 GiB

>          Average mod size       217908
212 KiB

>     Average mod text size       63570
62 KiB

> b) patched
> 
> # cat /sys/kernel/debug/modules/stats
>  Virtual mem wasted bytes       0

> 2) debug config (enabling KASAN)
> 
> a) master
> 
> # cat /sys/kernel/debug/modules/stats
>  Virtual mem wasted bytes       6453862040
6 GiB

>          Average mod size       430517
420 KiB, so ballpark kasan pretty much doubles module size.

>     Average mod text size       197592
192 KiB, and is reflected on module .text too, in fact .text more than doubles.

It would have otherwise been difficult to get some of these stats, so
thanks! I make note of .text just because of the recent development work
going on for a new module_alloc(). About 14 MiB required to house a big
iron kasan enabled module .text, whereas about half is required for !kasan.

> b) patched
> 
> # cat /sys/kernel/debug/modules/stats
>  Virtual mem wasted bytes       6441296

We've gone down from ~6 GiB to ~6 MiB.

> So, with these (helpful) stats,

Extremely useful, yes thanks.

> the improvement is obvious (and explains the ~1s
> improvement I saw staring at the startup times of the udev services).
> 
> There are still some failed module loads with the debug config (only in the
> becoming state), I did not dive deeply into the actual code changes (-EBUSY),

That's fine, Linus' patch does not keep the lock for the entire life
of the module, it releases it right away after we're done with the
kernel_read(), and because of this, there is a small race in between
a thread the kernel_read() finishing and the module then being processed
into the modules linked list. During that time, if a new module with the
same name comes in, we'll have to allow it since the lock was released.
Those extra modules end up lingering to wait for the first one that made
it to the modules linked list.

I don't think we need to worry about 6 MiB, this patch alone should
suffice for a long time until userspace gets its act together and fixes
this properly. Fixing userspace should reduce some latencies as well on
bootup so someone who cares about bootup speeds on high end systems
could likely be encouraged to fix that.

> just spelling it out so we can decide if this is to be expected or some corner
> case that shouldn't be happening.

It is expected, in fact the fact that the heuristic works so well,
without keeping the lock forever, and therefore keeping the code changes
to a minimum is quite an amazing.

  Luis
