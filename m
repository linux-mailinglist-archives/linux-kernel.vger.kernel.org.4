Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502B8674A9A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjATE3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjATE2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:28:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BEEB2785;
        Thu, 19 Jan 2023 20:28:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DD56B82700;
        Thu, 19 Jan 2023 20:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8AFC433D2;
        Thu, 19 Jan 2023 20:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674159027;
        bh=6pI7VGk0RST41E36DICzXK1xkaSuvgEZMnucSogAPIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qELc81M9x3AT5xwYio2YwsEIdabx7a/RsGRLnewTUBtlQBQX5DJ2Wn1d8NTWfzSy3
         7O7+jw9rKFK+vTnD1s+M+BSL1gnqYeUP96mxdtkDD7LGqmqB/pqpb9bWf2x4WXHaVn
         pB/d3AD40al2Fe1/4PZgMNv3PW5HgiqtJ5FL1EORBynHYwEz7iQfJ8kA6FzHihj5vT
         uPsSy4lzM8Cf9Y02ulODxiKmkBlMzG3PJaBdy0sA7JuxRntP8u8AUdtGTvCZqaNyp1
         GC+c/+zsH5UqLG4znkwe/YZrH7smHJlLlqgAJiSxH9Ozb4rnnMJ7EXQqJD2/fx2dYj
         FScBezWCGZwBw==
From:   SeongJae Park <sj@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>, Luis Chamberlain <mcgrof@kernel.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        David Gow <davidgow@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/6] exit: Put an upper limit on how often we can oops
Date:   Thu, 19 Jan 2023 20:10:23 +0000
Message-Id: <20230119201023.4003-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117234328.594699-2-keescook@chromium.org>
References: 
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

Hello,

On Thu, 17 Nov 2022 15:43:22 -0800 Kees Cook <keescook@chromium.org> wrote:

> From: Jann Horn <jannh@google.com>
> 
> Many Linux systems are configured to not panic on oops; but allowing an
> attacker to oops the system **really** often can make even bugs that look
> completely unexploitable exploitable (like NULL dereferences and such) if
> each crash elevates a refcount by one or a lock is taken in read mode, and
> this causes a counter to eventually overflow.
> 
> The most interesting counters for this are 32 bits wide (like open-coded
> refcounts that don't use refcount_t). (The ldsem reader count on 32-bit
> platforms is just 16 bits, but probably nobody cares about 32-bit platforms
> that much nowadays.)
> 
> So let's panic the system if the kernel is constantly oopsing.
> 
> The speed of oopsing 2^32 times probably depends on several factors, like
> how long the stack trace is and which unwinder you're using; an empirically
> important one is whether your console is showing a graphical environment or
> a text console that oopses will be printed to.
> In a quick single-threaded benchmark, it looks like oopsing in a vfork()
> child with a very short stack trace only takes ~510 microseconds per run
> when a graphical console is active; but switching to a text console that
> oopses are printed to slows it down around 87x, to ~45 milliseconds per
> run.
> (Adding more threads makes this faster, but the actual oops printing
> happens under &die_lock on x86, so you can maybe speed this up by a factor
> of around 2 and then any further improvement gets eaten up by lock
> contention.)
> 
> It looks like it would take around 8-12 days to overflow a 32-bit counter
> with repeated oopsing on a multi-core X86 system running a graphical
> environment; both me (in an X86 VM) and Seth (with a distro kernel on
> normal hardware in a standard configuration) got numbers in that ballpark.
> 
> 12 days aren't *that* short on a desktop system, and you'd likely need much
> longer on a typical server system (assuming that people don't run graphical
> desktop environments on their servers), and this is a *very* noisy and
> violent approach to exploiting the kernel; and it also seems to take orders
> of magnitude longer on some machines, probably because stuff like EFI
> pstore will slow it down a ton if that's active.

I found a blog article[1] recommending LTS kernels to backport this as below.

    While this patch is already upstream, it is important that distributed
    kernels also inherit this oops limit and backport it to LTS releases if we
    want to avoid treating such null-dereference bugs as full-fledged security
    issues in the future.

Do you have a plan to backport this into upstream LTS kernels?

[1] https://googleprojectzero.blogspot.com/2023/01/exploiting-null-dereferences-in-linux.html


Thanks,
SJ

> 
> Signed-off-by: Jann Horn <jannh@google.com>
> Link: https://lore.kernel.org/r/20221107201317.324457-1-jannh@google.com
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
