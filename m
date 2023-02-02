Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3092A688B3A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjBBX71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjBBX70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:59:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E437D6E8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:59:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22B5061D10
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 23:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DF6C433EF;
        Thu,  2 Feb 2023 23:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675382364;
        bh=2P9wIQEA+MBCToZWJa8KTdnvh+876H8+qF/zfobU/Sg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GOIMSpOlbLBNwO5nm0rQCYPkPzGmiCvglFwaUhyHAaHSohT6EE/Q8UiuIkVxAW1Fg
         5lu0jOTsMbjS/MIAniIZKt3xMi9nXHVNGqBYPE/eH8nGohLixm7XZxEh6plUAGwHsV
         Ho6Ojjym2kEkBeNbXxW0jXE4ex4C7m/TgXuQpaEEdcNdfbNd9jKpMt4g41vroVq704
         +CFIXdh8O+YKkz35LCRRqsE7cU7xTQciSjqetUb7IoIjxJASf/jW4dPAWjzcFjxLwJ
         9HxjDoDL+/0ORCC5ZvNmsmwNyxENaLnbF0+ur8KXP1JZqI6MeCi4a6Yip4FFs31+V6
         bZjmmIrTfyIMA==
Date:   Fri, 3 Feb 2023 08:59:21 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 0/5] Add kprobe and kretprobe support for LoongArch
Message-Id: <20230203085921.7f8e58c89075d708c266f730@kernel.org>
In-Reply-To: <CAEr6+EBYF2xqZWEuZaz5un5FF3Jb-rSAQp3s3uojsovm9RcUYA@mail.gmail.com>
References: <1674007261-9198-1-git-send-email-yangtiezhu@loongson.cn>
        <CAAhV-H4aTd6_cSy45KKjv-KrLTiwT4iG6+fkb84KfCrL3Y+hpg@mail.gmail.com>
        <CAAhV-H5WN5E=0Z9wpbXDc6VO7Nc+j7PGvnyAAGOmCRMJkdwSYw@mail.gmail.com>
        <CAEr6+ECO-=jfhzHrcdKGx0MsjMBMiN6wsBPCfv7CaXo_amAWWg@mail.gmail.com>
        <02806f85-bc09-d316-f058-3947353cb190@loongson.cn>
        <CAEr6+EBYF2xqZWEuZaz5un5FF3Jb-rSAQp3s3uojsovm9RcUYA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Feb 2023 11:33:23 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> On Thu, Feb 2, 2023 at 10:23 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> >
> >
> > On 02/01/2023 05:40 PM, Jeff Xie wrote:
> > > On Wed, Feb 1, 2023 at 12:56 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> > >>
> > >> Hi, Jeff,
> > >>
> > >> Could you please pay some time to test this series? Thank you.
> > >
> > > Thanks for notifying me about the test.
> > >
> > > I have tested the patchset(based on the
> > > https://github.com/loongson/linux/tree/loongarch-next),
> > > I found that some functions can't  be probed e.g. scheduler_tick() or
> > > uart_write_wakeup()
> > > the two functions have the same point,  they are all run in the hardirq context.
> > >
> > > I don't know if it's related to the hardirq context, I haven't had
> > > time to study this patchset carefully.
> > > and they can be probed in the x86_64 arch.
> > >
> > > root@loongarch modules]# insmod ./kprobe_example.ko symbol=scheduler_tick
> > > insmod: can't insert './kprobe_example.ko': invalid parameter
> > >
> > > dmesg:
> > > [   39.806435] kprobe_init: register_kprobe failed, returned -22
> > >
> >
> > Thanks for your test.
> >
> > On my test environment, I can not reproduce the above issue,
> > here are the test results, it seems no problem.
> >
> > [root@linux loongson]# dmesg -c
> > [root@linux loongson]# uname -m
> > loongarch64
> > [root@linux loongson]# modprobe kprobe_example symbol=scheduler_tick
> > [root@linux loongson]# rmmod kprobe_example
> > [root@linux loongson]# dmesg | tail -2
> > [ 3317.138086] handler_post: <scheduler_tick> p->addr =
> > 0x0000000065d12f66, estat = 0xc0000
> > [ 3317.154086] kprobe_exit: kprobe at 0000000065d12f66 unregistered
> >
> > [root@linux loongson]# dmesg -c
> > [root@linux loongson]# uname -m
> > loongarch64
> > [root@linux loongson]# modprobe kprobe_example symbol=uart_write_wakeup
> > [root@linux loongson]# rmmod kprobe_example
> > [root@linux loongson]# dmesg | tail -2
> > [ 3433.502092] handler_post: <uart_write_wakeup> p->addr =
> > 0x0000000019718061, estat = 0xc0000
> > [ 3433.762085] kprobe_exit: kprobe at 0000000019718061 unregistered
> >
> > Additionally, "register_kprobe failed, returned -22" means the symbol
> > can not be probed, here is the related code:
> >
> > register_kprobe()
> >    check_kprobe_address_safe()
> >
> > static int check_kprobe_address_safe(struct kprobe *p,
> >                                      struct module **probed_mod)
> > {
> >         int ret;
> >
> >         ret = check_ftrace_location(p);
> >         if (ret)
> >                 return ret;
> >         jump_label_lock();
> >         preempt_disable();
> >
> >         /* Ensure it is not in reserved area nor out of text */
> >         if (!(core_kernel_text((unsigned long) p->addr) ||
> >             is_module_text_address((unsigned long) p->addr)) ||
> >             in_gate_area_no_mm((unsigned long) p->addr) ||
> >             within_kprobe_blacklist((unsigned long) p->addr) ||
> >             jump_label_text_reserved(p->addr, p->addr) ||
> >             static_call_text_reserved(p->addr, p->addr) ||
> >             find_bug((unsigned long)p->addr)) {
> >                 ret = -EINVAL;
> >                 goto out;
> >         }
> > ...
> > }
> 
> Today I looked at the code, this has nothing to do with hardirq :-)
> because I enabled this kernel option CONFIG_DYNAMIC_FTRACE, the
> loongarch should not support the option yet.

Until you implement the feature, "HAVE_<FEATURE>" should not be selected
in arch/*/Kconfig. So if the DYNAMIC_FTRACE is not implemented,
please drop "select HAVE_DYNAMIC_FTRACE"...

Thank you,


> 
> #ifdef CONFIG_DYNAMIC_FTRACE
> unsigned long ftrace_location(unsigned long ip);
> 
> #else /* CONFIG_DYNAMIC_FTRACE */
> 
> static inline unsigned long ftrace_location(unsigned long ip)
> {
>         return 0;
> }
> 
> #endif
> 
> 
> static int check_ftrace_location(struct kprobe *p)
> {
>         unsigned long addr = (unsigned long)p->addr;
> 
>         if (ftrace_location(addr) == addr) {
> #ifdef CONFIG_KPROBES_ON_FTRACE
>                 p->flags |= KPROBE_FLAG_FTRACE;
> #else   /* !CONFIG_KPROBES_ON_FTRACE */
>                 return -EINVAL;  // get error from here
> #endif
>         }
>         return 0;
> }
> 
> static int check_kprobe_address_safe(struct kprobe *p,
>                                      struct module **probed_mod)
> {
>         int ret;
> 
>         ret = check_ftrace_location(p);
>         if (ret)
>                 return ret; //  return -EINVAL
> }
> 
> 
> >
> > Thanks,
> > Tiezhu
> >
> 
> 
> -- 
> Thanks,
> JeffXie


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
