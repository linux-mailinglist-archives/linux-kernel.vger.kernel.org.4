Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED546017E4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiJQTkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiJQTkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:40:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E030874E16
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:40:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 856A46121B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328F1C433D6;
        Mon, 17 Oct 2022 19:40:33 +0000 (UTC)
Date:   Mon, 17 Oct 2022 15:40:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, chensong_2000@189.cn
Subject: Re: [PATCH v15 0/4] trace: Introduce objtrace trigger to trace the
 kernel object
Message-ID: <20221017154057.78babf40@gandalf.local.home>
In-Reply-To: <20220819032706.695212-1-xiehuan09@gmail.com>
References: <20220819032706.695212-1-xiehuan09@gmail.com>
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

On Fri, 19 Aug 2022 11:27:02 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

So on my way home from London, I tried to update it to use the fetch
instruction logic of kprobes (which will work), but I also ended up pretty
much rewriting most of it, which then I realized, I'm going much further
than I wanted to.

But know I have a much better idea of how this should work, and I'll try to
go through what I learned here and throughout the patches.


> Introduce a method based on function tracer to trace any object and get
> the value of the object dynamically. the object can be obtained from the
> dynamic event (kprobe_event/uprobe_event) or the static event(tracepoint).

Note, I can see the value of tracing only the value of the object, but that
to me would be "objfollow" not "objtrace". That is, to find out what
functions are calling the object. I guess that may have been your original
objective, but it was articulated more about knowing how the value changed
and not where the value is going (and the code was written more like that).

Having a objfollow may be nice, but reading the arguments of a function is
really a "best attempt" at most, and you can't really trust the arguments
are what you are tracing. I would hold off on that until we have a good BTF
tracing infrastructure in the function tracer.

So I'm going to continue with "objtrace" which is about tracing the
object's value throughout time.

> 
> Usage:
> When using the kprobe event, only need to set the objtrace(a new trigger),
> we can get the value of the object. The object is from the setting of the 
> kprobe event.
> 
> For example:
> For the function bio_add_page():
> 
> int bio_add_page(struct bio *bio, struct page *page,
> 	unsigned int len, unsigned int offset)
> 
> Firstly, we can set the base of the object, thus the first string "arg1"
> stands for the value of the first parameter of this function bio_add_gage(),
> 
> # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> 
> Secondly, we can get the value dynamically based on above object. 
> 
> find the offset of the bi_size in struct bio:
> $ gdb vmlinux
> (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
> $1 = (unsigned int *) 0x28
> 
> # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
> 	p_bio_add_page_0/trigger
> 
> # cd /sys/kernel/debug/tracing/
> # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger

So I was working to change the above to:

  echo 'objtrace:add:+0x28($arg1):u32:1 if comm == "cat"'



> 
> # du -sh /test.txt
> 12.0K   /test.txt
> 
> # cat  /test.txt > /dev/null
> # cat ./trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 128/128   #P:4
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>              cat-117     [002] ...1.     1.602243: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x0
>              cat-117     [002] ...1.     1.602244: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x0
>              cat-117     [002] ...2.     1.602244: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x1000
>              cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
>              cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x1000

Now instead of searching the function arguments for "obj", we should just
read the obj value at every function and report when it changed, as well as
the last function it was still the same. The report will be like the
"func_repeats" entry. And instead we can print when the object changes,
something like this:

              cat-117     [002] ...2.     1.602245: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x2000 (last value:0x1000 at [002] __bio_add_page <-bio_add_page ts: 1.602245)

This will tell us when a value changed.

It would need to store the CPU, ip and pip and timestamp of the last time
it was the same. And when it changes, it would then report it.

-- Steve
