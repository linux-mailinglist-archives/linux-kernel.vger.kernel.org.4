Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EAE5F85B1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 16:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJHO6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 10:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJHO6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 10:58:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAAC40E02
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 07:58:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4789860522
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 14:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3F2C43470
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 14:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665241124;
        bh=mZREad85GFyRC2zuhjz6HgZ4PomVqyUIdo/Tef4rEYw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jsRh3im9Yy+zKWZsofNNV9RiKaIdInxL/4hhjV3t2cv6w7o4/qmuCBJuf1FWzzB6q
         PvpbrlKB5I0DE0oMtJ7KRhDV1mfVcuSAX8jSBtS+eF2wKGbkRvXGTURCM6nv6v0d2/
         gbYxuYDpseJkDyR2Bi7anLjsp52E2w1M0PTvBLoSxuBFFLC0YyjnQLb/XbqjdmRgHi
         w7eMDrBYpYGojJ8thrvAifGAZBCEhBvytUwv+hrtsKpxpeQi6zfKpP5o9bouZOWJq0
         xtDUQJ5IsUqAET1ziZIKu/k/26ntcjikmBdz5gRJ1dYg8raBIWr71DcLWzve7wEzyY
         xh9bJqbX7QzYw==
Received: by mail-ej1-f54.google.com with SMTP id o21so16749863ejm.11
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 07:58:44 -0700 (PDT)
X-Gm-Message-State: ACrzQf0aO6ACrZ0UDY6imkbs6c/2hveg4bkXk24XKzmBTJ8H+50FXcXZ
        uXZ++6R8rQWvJ3GhGEP+w2c3oW7BfUsKonBuZm8=
X-Google-Smtp-Source: AMsMyM7z83V/I+HAsI/rEZvezI0C+n0zjmsObD3snZ7UspkdC1pQaxLNVe+pPCiltXmNAPk4iDRUwri561fXSYRjN98=
X-Received: by 2002:a17:906:fe45:b0:788:15a5:7495 with SMTP id
 wz5-20020a170906fe4500b0078815a57495mr8087425ejb.633.1665241122838; Sat, 08
 Oct 2022 07:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <1665219579-2501-1-git-send-email-yangtiezhu@loongson.cn>
 <922e6d73-78e5-8852-788b-017d0dbe4df5@xen0n.name> <75f1aa18-2e84-107a-f0b6-3e4b753ab8b1@loongson.cn>
 <b4803250-e66c-0c0e-15c9-35d8fdfb09ea@loongson.cn>
In-Reply-To: <b4803250-e66c-0c0e-15c9-35d8fdfb09ea@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 8 Oct 2022 22:58:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H44XfSrqMHudkra_yup86B6OsTQQa9kQRvd=Xi6jTNy3Q@mail.gmail.com>
Message-ID: <CAAhV-H44XfSrqMHudkra_yup86B6OsTQQa9kQRvd=Xi6jTNy3Q@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Do not create sysfs control file for io master CPUs
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 8, 2022 at 6:44 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>
>
> On 10/08/2022 05:51 PM, Tiezhu Yang wrote:
> >
> >
> > On 10/08/2022 05:27 PM, WANG Xuerui wrote:
> >> On 2022/10/8 16:59, Tiezhu Yang wrote:
> >>> Now io master CPUs are not hotpluggable on LoongArch, in the current
> >>> code,
> >>> only /sys/devices/system/cpu/cpu0/online is not created, let us set the
> >>> hotpluggable field of all the io master CPUs as 0, then prevent to
> >>> create
> >>> sysfs control file for the other io master CPUs which confuses some user
> >>> space tools. This is similar with commit 9cce844abf07 ("MIPS: CPU#0 is
> >>> not
> >>> hotpluggable").
> >>>
> >>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> >>> ---
> >>>   arch/loongarch/kernel/smp.c      |  8 --------
> >>>   arch/loongarch/kernel/topology.c | 12 +++++++++++-
> >>>   2 files changed, 11 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> >>> index b5fab30..ef89292 100644
> >>> --- a/arch/loongarch/kernel/smp.c
> >>> +++ b/arch/loongarch/kernel/smp.c
> >>> @@ -240,19 +240,11 @@ void loongson3_smp_finish(void)
> >>>     #ifdef CONFIG_HOTPLUG_CPU
> >>>   -static bool io_master(int cpu)
> >>> -{
> >>> -    return test_bit(cpu, &loongson_sysconf.cores_io_master);
> >>> -}
> >>> -
> >>>   int loongson3_cpu_disable(void)
> >>>   {
> >>>       unsigned long flags;
> >>>       unsigned int cpu = smp_processor_id();
> >>>   -    if (io_master(cpu))
> >>> -        return -EBUSY;
> >>> -
> >>
> >> Could this get invoked from somewhere other than the sysfs entries that
> >> "confuse user-space tools", e.g. from somewhere else in kernel land? If
> >> so (or if we can't rule out the possibility) keeping the guard here
> >> might prove more prudent.
> >>
>
> takedown_cpu()  kernel/cpu.c
> take_cpu_down()  kernel/cpu.c
> __cpu_disable()  arch/loongarch/include/asm/smp.h
> loongson3_cpu_disable()  arch/loongarch/kernel/smp.c
>
> So I think you are right, keeping the guard here might prove more
> prudent, then it is better move io_master() to a header file that
> can be used in smp.c and topology.c.
Agree, please send V2, thanks.


Huacai
>
> Let us wait for more review comments, thank you.
>
> >
> > If c->hotpluggable is 0, it will not generate a control file in sysfs
> > for this CPU, for example:
> >
> > [root@linux loongson]# cat /sys/devices/system/cpu/cpu0/online
> > cat: /sys/devices/system/cpu/cpu0/online: No such file or directory
> > [root@linux loongson]# echo 0 > /sys/devices/system/cpu/cpu0/online
> > bash: /sys/devices/system/cpu/cpu0/online: Permission denied
> >
> > So no need to check it here, just remove the code.
> >
> > This was done in commit cbab54d9c2b2 ("MIPS: No need to check CPU 0 in
> > {loongson3,bmips,octeon}_cpu_disable()").
> >
> >>>   #ifdef CONFIG_NUMA
> >>>       numa_remove_cpu(cpu);
> >>>   #endif
> >>> diff --git a/arch/loongarch/kernel/topology.c
> >>> b/arch/loongarch/kernel/topology.c
> >>> index ab1a75c..7e7a77f 100644
> >>> --- a/arch/loongarch/kernel/topology.c
> >>> +++ b/arch/loongarch/kernel/topology.c
> >>> @@ -5,6 +5,7 @@
> >>>   #include <linux/node.h>
> >>>   #include <linux/nodemask.h>
> >>>   #include <linux/percpu.h>
> >>> +#include <asm/bootinfo.h>
> >>>     static DEFINE_PER_CPU(struct cpu, cpu_devices);
> >>>   @@ -33,6 +34,11 @@ void arch_unregister_cpu(int cpu)
> >>>   EXPORT_SYMBOL(arch_unregister_cpu);
> >>>   #endif
> >>>   +static bool io_master(int cpu)
> >>> +{
> >>> +    return test_bit(cpu, &loongson_sysconf.cores_io_master);
> >>> +}
> >>> +
> >>>   static int __init topology_init(void)
> >>>   {
> >>>       int i, ret;
> >>> @@ -40,7 +46,11 @@ static int __init topology_init(void)
> >>>       for_each_present_cpu(i) {
> >>>           struct cpu *c = &per_cpu(cpu_devices, i);
> >>>   -        c->hotpluggable = !!i;
> >>> +        if (io_master(i))
> >>> +            c->hotpluggable = 0;
> >>> +        else
> >>> +            c->hotpluggable = 1;
> >>> +
> >>
> >> This is just "c->hotpluggable = !io_master(i);".
> >>
> >
> > Yes, I am OK either way, if it is necessary to send v2,
> > please let me know.
> >
> >>>           ret = register_cpu(c, i);
> >>>           if (ret < 0)
> >>>               pr_warn("topology_init: register_cpu %d failed (%d)\n",
> >>> i, ret);
> >> Other changes should be okay as they are in line with the previous MIPS
> >> change you referenced, but let's see what Huacai thinks.
> >>
> >
> > Thanks,
> > Tiezhu
>
