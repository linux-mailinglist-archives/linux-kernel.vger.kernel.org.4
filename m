Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AE863C4C6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbiK2QKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbiK2QKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:10:12 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43C4391FA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:10:03 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id w129so14131861pfb.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6jA6BGzp2fBwDfYHiMcOLCiQBDlfugyrAMxfoc15nBY=;
        b=coRgLe+CyXrki0XAaxESNTUm/Scg/kXUwwqmGJ/cAl0QNYnx56XGTKCaT3L3wBCpbM
         sbdV/oDNhf6TYT9Gr2h7pePrwEPpmr0L30qe/ii3jqq/tiZsxxfzTG3NbuhfNhmnerHC
         K+268JjJEYnO2sR8D1w+sxt0ZamjfVJ5CwvaglRz2mobK6yQ97aMTJRr1SmO3JwSFTy1
         ovpVwJfXkS77fsGzfbprSbUJ1BHApg7hyGYs9Qf7mzjbCX1ZoVa48dkZdldWkJ+g8Z/3
         x1TnSu7xoxO/jCKw4d5RmOv9nxrS6CIiqrSikcaO8zGPLhQE4gwyvCdoouTe0Wq1IZXB
         PW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jA6BGzp2fBwDfYHiMcOLCiQBDlfugyrAMxfoc15nBY=;
        b=SS3RrwpOR8ZoI8949/uRqtnwjzkd0Ixr3V+0Jy25op2QYp1/Q93b46y4rHe8IUu1Tt
         u/btPVYTi1RC9OIK1w+z7sQmuGrP2tYufDOxNQEpAhmjsYbFuAng6hMJU/VDTBBBhdnG
         dXdQwF/zKEdbCNyP7O6GrbmEtAc2Qz17OFZTjv2w80YRCONef1JaaihKdznmRI2RDSFO
         I9413NcJ1FpgkOy8tualjOAniPGCmg8ufbcT0P/DmmC+TBPPyspQZMLsaHeKhbHzYJ4d
         f3lUSf5AU3Dd3GH7JDbEAn6zBmb1+GCtVhFznblWg23pDHADB+GNsrlEYqYCSBV0JdOR
         Zi8g==
X-Gm-Message-State: ANoB5pkV/p/Enofh9KTWoERFlasaQhhpQzPgG3pHDHOKUV0aTV4WLm7A
        6D60XuD5MVfLFy3v6kqj9yElp0N1RjRmuGTGyQQ=
X-Google-Smtp-Source: AA0mqf7ubkDvl/R3Z11RlbOVMvPRUwtuXElrTjd8RpwlAFMh1F7kVnQ5+UqEU3z0eUapGa+RQAcLrXVd7mE3KESi8y8=
X-Received: by 2002:a62:be08:0:b0:574:26df:aac2 with SMTP id
 l8-20020a62be08000000b0057426dfaac2mr35002711pff.46.1669738203217; Tue, 29
 Nov 2022 08:10:03 -0800 (PST)
MIME-Version: 1.0
References: <20220819032706.695212-1-xiehuan09@gmail.com> <20221017154057.78babf40@gandalf.local.home>
In-Reply-To: <20221017154057.78babf40@gandalf.local.home>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Wed, 30 Nov 2022 00:09:51 +0800
Message-ID: <CAEr6+ECqn7rABE0cJP_oPr6g37B1kXu2xpge7Pg67hxywqyO0g@mail.gmail.com>
Subject: Re: [PATCH v15 0/4] trace: Introduce objtrace trigger to trace the
 kernel object
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, chensong_2000@189.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Tue, Oct 18, 2022 at 3:40 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 19 Aug 2022 11:27:02 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> So on my way home from London, I tried to update it to use the fetch
> instruction logic of kprobes (which will work), but I also ended up pretty
> much rewriting most of it, which then I realized, I'm going much further
> than I wanted to.
>
> But know I have a much better idea of how this should work, and I'll try to
> go through what I learned here and throughout the patches.
>
>
> > Introduce a method based on function tracer to trace any object and get
> > the value of the object dynamically. the object can be obtained from the
> > dynamic event (kprobe_event/uprobe_event) or the static event(tracepoint).
>
> Note, I can see the value of tracing only the value of the object, but that
> to me would be "objfollow" not "objtrace". That is, to find out what
> functions are calling the object. I guess that may have been your original
> objective, but it was articulated more about knowing how the value changed
> and not where the value is going (and the code was written more like that).
>
> Having a objfollow may be nice, but reading the arguments of a function is
> really a "best attempt" at most, and you can't really trust the arguments
> are what you are tracing. I would hold off on that until we have a good BTF
> tracing infrastructure in the function tracer.
>
> So I'm going to continue with "objtrace" which is about tracing the
> object's value throughout time.
>
> >
> > Usage:
> > When using the kprobe event, only need to set the objtrace(a new trigger),
> > we can get the value of the object. The object is from the setting of the
> > kprobe event.
> >
> > For example:
> > For the function bio_add_page():
> >
> > int bio_add_page(struct bio *bio, struct page *page,
> >       unsigned int len, unsigned int offset)
> >
> > Firstly, we can set the base of the object, thus the first string "arg1"
> > stands for the value of the first parameter of this function bio_add_gage(),
> >
> > # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> >
> > Secondly, we can get the value dynamically based on above object.
> >
> > find the offset of the bi_size in struct bio:
> > $ gdb vmlinux
> > (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
> > $1 = (unsigned int *) 0x28
> >
> > # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
> >       p_bio_add_page_0/trigger
> >
> > # cd /sys/kernel/debug/tracing/
> > # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> > # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
>
> So I was working to change the above to:
>
>   echo 'objtrace:add:+0x28($arg1):u32:1 if comm == "cat"'
>
>
>
> >
> > # du -sh /test.txt
> > 12.0K   /test.txt
> >
> > # cat  /test.txt > /dev/null
> > # cat ./trace
> > # tracer: nop
> > #
> > # entries-in-buffer/entries-written: 128/128   #P:4
> > #
> > #                                _-----=> irqs-off/BH-disabled
> > #                               / _----=> need-resched
> > #                              | / _---=> hardirq/softirq
> > #                              || / _--=> preempt-depth
> > #                              ||| / _-=> migrate-disable
> > #                              |||| /     delay
> > #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > #              | |         |   |||||     |         |
> >              cat-117     [002] ...1.     1.602243: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x0
> >              cat-117     [002] ...1.     1.602244: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x0
> >              cat-117     [002] ...2.     1.602244: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x1000
> >              cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
> >              cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
>
> Now instead of searching the function arguments for "obj", we should just
> read the obj value at every function and report when it changed, as well as
> the last function it was still the same. The report will be like the
> "func_repeats" entry. And instead we can print when the object changes,
> something like this:
>
>               cat-117     [002] ...2.     1.602245: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x2000 (last value:0x1000 at [002] __bio_add_page <-bio_add_page ts: 1.602245)


I'm just curious if we'll see this rewritten version in the next merge
window  ;-)


> This will tell us when a value changed.
>
> It would need to store the CPU, ip and pip and timestamp of the last time
> it was the same. And when it changes, it would then report it.
>
> -- Steve



-- 
Thanks,
JeffXie
