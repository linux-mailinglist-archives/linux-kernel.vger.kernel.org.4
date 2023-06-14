Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC70372FD40
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244242AbjFNLoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244235AbjFNLoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C2D1FD4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686743008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vuUhVpVX5EdXqPEKFLbivurfx7oNOMChMz10tKoia3U=;
        b=fkh5a3PW+48vbCrX2zEsBVp6E05wo74XxkBhFpVi2RT3/3dV/cetWqraDprfTfA/gO4A41
        v2sm5HXkld1wFrKNz7AsyHVexOUOAzCmew/S6+CmpNd94/eNwUo8lXuwKkcOEpb9FVxmWN
        uL4EZQ7Hr7yBq+Nv2O8RqhoGHol90uM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-aasTHlLTNYaHL0r7tv0PhQ-1; Wed, 14 Jun 2023 07:43:26 -0400
X-MC-Unique: aasTHlLTNYaHL0r7tv0PhQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3325D802898;
        Wed, 14 Jun 2023 11:43:25 +0000 (UTC)
Received: from localhost (unknown [10.39.192.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EBE68492C1B;
        Wed, 14 Jun 2023 11:43:24 +0000 (UTC)
Date:   Wed, 14 Jun 2023 12:43:24 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Aaron Thompson <dev@aaront.org>, linux-kernel@vger.kernel.org
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <20230614114324.GD7636@redhat.com>
References: <20230613134105.GA10301@redhat.com>
 <20230614092158.GF1639749@hirez.programming.kicks-ass.net>
 <20230614094522.GA7636@redhat.com>
 <20230614103011.GL7912@redhat.com>
 <20230614103953.GM7912@redhat.com>
 <20230614113536.GJ1639749@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614113536.GJ1639749@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 01:35:36PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 14, 2023 at 11:39:53AM +0100, Richard W.M. Jones wrote:
> > Got it!
> > 
> > #0  arch_static_branch (branch=false, key=<optimized out>)
> >     at ./arch/x86/include/asm/jump_label.h:27
> > #1  static_key_false (key=<optimized out>) at ./include/linux/jump_label.h:207
> > #2  native_write_msr (msr=1760, low=1876580734, high=106)
> >     at ./arch/x86/include/asm/msr.h:147
> > #3  0xffffffff8107997c in paravirt_write_msr (high=<optimized out>, 
> >     low=1876580734, msr=1760) at ./arch/x86/include/asm/paravirt.h:196
> > #4  wrmsrl (val=<optimized out>, msr=1760)
> >     at ./arch/x86/include/asm/paravirt.h:229
> > #5  lapic_next_deadline (delta=<optimized out>, evt=<optimized out>)
> >     at arch/x86/kernel/apic/apic.c:491
> > #6  0xffffffff811f7b1d in clockevents_program_event (dev=0xffff88804e820dc0, 
> >     expires=<optimized out>, force=<optimized out>)
> >     at kernel/time/clockevents.c:334
> > #7  0xffffffff811f81b0 in tick_handle_periodic (dev=0xffff88804e820dc0)
> >     at kernel/time/tick-common.c:133
> > #8  0xffffffff810796c1 in local_apic_timer_interrupt ()
> >     at arch/x86/kernel/apic/apic.c:1095
> > #9  __sysvec_apic_timer_interrupt (regs=regs@entry=0xffffc90000003ee8)
> >     at arch/x86/kernel/apic/apic.c:1112
> > #10 0xffffffff81f9cf09 in sysvec_apic_timer_interrupt (regs=0xffffc90000003ee8)
> >     at arch/x86/kernel/apic/apic.c:1106
> > #11 0xffffffff820015ca in asm_sysvec_apic_timer_interrupt ()
> >     at ./arch/x86/include/asm/idtentry.h:645
> > #12 0x0000000000000000 in ?? ()
> 
> Uuuhh.. something is really fishy here. The thing in common between the
> fingered patch and this stacktrace is the jump_label/static_branch
> usage, but they're quite different paths.
> 
> There is no printk or local_clock() in sight here.

So I should note that the stack trace is collected by connecting to
qemu after the kernel "hangs" ("hangs" in quotes, because it is
probably still running).

It's difficult to collect a stack trace at the moment of the hang
since I basically have to wait for hundreds of boot iterations until I
see the bug manifest.

I wonder if the KVM tracing features would be a better approach here?

> I've got that plain qemu thing running on:
> 
>   defconfig + kvm_guest.config + CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> 
> and have added "nokaslr" to the -append string. Lets see if it wants to
> go wobbly for me.

Thanks,

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html

