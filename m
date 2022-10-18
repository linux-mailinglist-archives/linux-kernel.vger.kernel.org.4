Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC76D6024E7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJRHCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJRHCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:02:11 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0ED4B0DA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:02:09 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f193so12576230pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+nVvhxkclvBh7jijvZoxqeBRD1ch68LIrE3T6tQXwcA=;
        b=Y2OI2k0M6Ppy5IrQdu3OxcyqK0E6FMj0RbKdfVt/AXycghkatIodlK2LKFkKsnA0WT
         NHKcBCqS45b2/2WN6/2MIZ3g/kB9oeik4IK/tK5RpF34gZSbyiKML9o1HzbiuxytlHIm
         gQrT+zI6QlQoaNfmBoJPZiFVOERHzDXqPMXkzw+xnO3WKbwxtq7gRbuHTFKhmNIIRIw/
         RTE/4eHnL8CbfC+J7vC2XVTG5g1sWKgWHHr7RmR5CUCsmfEmu0FXMNurav64QJ5WOkvT
         HjL6LF0xpk6+VBXJOzDU0TGts4oA9CdajfD1MaJN31G+3mQBA9rYdS/2Pqjf7PdEciW0
         al1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nVvhxkclvBh7jijvZoxqeBRD1ch68LIrE3T6tQXwcA=;
        b=rH1KQ8BcDjUh85YthyxqVfFDgHEt6b0//xq55yfxH+7Zz5zdGfwpN9CgFurpRE0074
         e9nY9Fb7fcs13gNHTFkxal8TpkeP33YABjTqpzkhg9uCuR78JxMYacfYTLKc07fQ8XTV
         IGjov/oN2ccTo2q5Me2M3IasROkRGpBG2fOZLkjWjkbOG5FenbhQ62a3wpYhQqPWss3h
         IJRZhq8eE/GdzvDp97B2a32ZDcz2BtqlA5/ZTFX7YbxLht3swT8tLLeqU5+wLcv11vxA
         XIzyn6eZSC9ti7Tq6rryGJL/iipMm5lQRjKvwVm2mW6ZDPXGNUNXApOLMPAh/lyc/Mzd
         Fu6w==
X-Gm-Message-State: ACrzQf17R9NmvJ4d32LGrzdKBAo1vyqsYZMUnKjUWU+8XHYSDwvWaY2r
        GZZcjJKd+X8h6hotJxMHTv6nodGlSRU5HKlH/1NfgBWsjRE=
X-Google-Smtp-Source: AMsMyM49UEfiusGAREFepzmkjlHJNy6ewtCu1meAQqMQVMFe4C9Y3KaAKXHbvpwDhoZCzgaEYfRUZRdXSRjygk1lfF4=
X-Received: by 2002:a05:6a00:16c8:b0:53b:3b9f:7283 with SMTP id
 l8-20020a056a0016c800b0053b3b9f7283mr1537420pfc.46.1666076529394; Tue, 18 Oct
 2022 00:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220819032706.695212-1-xiehuan09@gmail.com> <20221017154057.78babf40@gandalf.local.home>
In-Reply-To: <20221017154057.78babf40@gandalf.local.home>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Tue, 18 Oct 2022 15:01:57 +0800
Message-ID: <CAEr6+EAEvZiU14H2bGW9iGOwJjshAw5sQk7uneFuyK23YMm-Sw@mail.gmail.com>
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

On Tue, Oct 18, 2022 at 3:40 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 19 Aug 2022 11:27:02 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> So on my way home from London, I tried to update it to use the fetch
> instruction logic of kprobes (which will work), but I also ended up pretty
> much rewriting most of it, which then I realized, I'm going much further
> than I wanted to.

Very excited  to hear it will work. Thank you for your hard work.

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

Yes, It actually was my original objective -;)  and I also really love
your idea of getting its value.

> and not where the value is going (and the code was written more like that).
> Having a objfollow may be nice, but reading the arguments of a function is
> really a "best attempt" at most, and you can't really trust the arguments
> are what you are tracing.

It's true, you spoke to my heart ;-)

>I would hold off on that until we have a good BTF
> tracing infrastructure in the function tracer.
>
> So I'm going to continue with "objtrace" which is about tracing the
> object's value throughout time.

Thanks.

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

It seems easier to use, I like it.

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

This output is better than I expected.

>
> This will tell us when a value changed.
>
> It would need to store the CPU, ip and pip and timestamp of the last time
> it was the same. And when it changes, it would then report it.
>
> -- Steve

-- 
Thanks,
JeffXie
