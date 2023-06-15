Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CAB731688
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbjFOLaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjFOLaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:30:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3168E268C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686828571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QFlPmFfAOqp72zyhedgHZsoz7QZtp5RVXytEtFvsgys=;
        b=bIM7oWw4crGYcT4tKkprJ3da5+WNPuMm6r8gRoOu52TyA/a4tdeBL145xX79tRQZeU/iBy
        sEAlb+3LRl0OAdBXgBzcadrPQM+YZXB0Fk0W28owNiNH6EU9dSD9L3gQREsX+kgYzMsBcA
        b5GNxVEDeNVMys0E/X1pYv0N51IhKd0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-63xw-c6FOiuT_PmiYoj_3Q-1; Thu, 15 Jun 2023 07:29:25 -0400
X-MC-Unique: 63xw-c6FOiuT_PmiYoj_3Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64CA185A5B5;
        Thu, 15 Jun 2023 11:29:25 +0000 (UTC)
Received: from localhost (unknown [10.39.192.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15DD240C20F4;
        Thu, 15 Jun 2023 11:29:24 +0000 (UTC)
Date:   Thu, 15 Jun 2023 12:29:19 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     YiFei Zhu <zhuyifei@google.com>
Cc:     dev@aaront.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        zhuyifei1999@gmail.com
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <20230615112919.GM7636@redhat.com>
References: <20230614112625.GN7912@redhat.com>
 <20230615110429.2839058-1-zhuyifei@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615110429.2839058-1-zhuyifei@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 11:04:29AM +0000, YiFei Zhu wrote:
> > FWIW attached is a test program that runs the qemu instances in
> > parallel (up to 8 threads), which seems to be a quicker way to hit the
> > problem for me.  Even on Intel, with this test I can hit the bug in a
> > few hundred iteration.
> 
> A friend sent me here so I took a look.
> 
> I was unable to reproduce with this script after 10000 iterations,
> on a AMD Gentoo Linux host:
> 
> Host kernel:  6.3.3 vanilla
> Guest kernel: git commit f31dcb152a3d0816e2f1deab4e64572336da197d
> Guest config: Provided full-fat Fedora config + CONFIG_GDB_SCRIPTS
> QEMU:         8.0.2 (with kvm_amd)
> Hardware:     AMD Ryzen 7 PRO 5850U
> 
> I wonder if anything on the host side affects this, or could be some
> sort of race condition.

We've had multiple independent reports of reproducing the bug, since
this story (unfortunately) hit Hacker News.  Your configuration above
should work, so I still don't know what the factor is.

[...]

> If you can reproduce the original bug (without the msleep or busy wait
> patch), could you check if you can reproduce that with idle=poll? If so,
> can you run "p show_state_filter(0)" so we get a stack trace of kernel_init,
> assuming it hit a similar issue as if msleep was added. If idle=poll does
> not work, or you can't call functions from within gdb (some old qemu versions
> did not support this), see if you can send a alt-sysrq-w to show stacks of
> blocked tasks.

(1) Adding idle=poll to the guest kernel

=> Bug still occurs, with about the same frequency as before.

(2) Connect with gdb to qemu's gdb-stub:

Trying to evaluate show_state_filter(0) didn't work for reasons I
don't understand:

(gdb) target remote localhost:1234
Remote debugging using localhost:1234
warning: Remote gdbserver does not support determining executable automatically.
RHEL <=6.8 and <=7.2 versions of gdbserver do not support such automatic execut.
The following versions of gdbserver support it:
- Upstream version of gdbserver (unsupported) 7.10 or later
- Red Hat Developer Toolset (DTS) version of gdbserver from DTS 4.0 or later (o)
- RHEL-7.3 versions of gdbserver (on any architecture)
arch_static_branch (branch=false, key=<optimized out>)
    at ./arch/x86/include/asm/jump_label.h:27
27     asm_volatile_goto("1:"
(gdb) bt
#0  arch_static_branch (branch=false, key=<optimized out>)
    at ./arch/x86/include/asm/jump_label.h:27
#1  static_key_false (key=<optimized out>) at ./include/linux/jump_label.h:207
#2  native_write_msr (high=222, low=719927812, msr=1760)
    at ./arch/x86/include/asm/msr.h:147
#3  wrmsrl (val=954202667524, msr=1760) at ./arch/x86/include/asm/msr.h:262
#4  lapic_next_deadline (delta=474, evt=0xffff88804e81bf40)
    at arch/x86/kernel/apic/apic.c:491
#5  0xffffffff81143667 in clockevents_program_event (dev=0xffff88804e81bf40, 
    expires=<optimized out>, force=<optimized out>)
    at kernel/time/clockevents.c:334
#6  0xffffffff81143c0b in tick_handle_periodic (dev=0xffff88804e81bf40)
    at kernel/time/tick-common.c:133
#7  0xffffffff8105d01c in local_apic_timer_interrupt ()
    at arch/x86/kernel/apic/apic.c:1095
#8  __sysvec_apic_timer_interrupt (regs=regs@entry=0xffffc90000003ee8)
    at arch/x86/kernel/apic/apic.c:1112
#9  0xffffffff81e61a91 in sysvec_apic_timer_interrupt (regs=0xffffc90000003ee8)
    at arch/x86/kernel/apic/apic.c:1106
#10 0xffffffff8200144a in asm_sysvec_apic_timer_interrupt ()
    at ./arch/x86/include/asm/idtentry.h:645
#11 0x0000000000000000 in ?? ()
(gdb) p show_state_filter(0)
[Inferior 1 (process 1) exited normally]
The program being debugged exited while in a function called from GDB.
Evaluation of the expression containing the function
(show_state_filter) will be abandoned.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top

