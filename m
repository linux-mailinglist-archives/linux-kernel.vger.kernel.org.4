Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1955872FF22
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244758AbjFNMxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbjFNMxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:53:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAAE10F6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jj4LvNCBj8pMCeH7vLNRCnUOS/52EdZ9HcpTu/f/Gao=; b=XdoYgxHR1CG2KgZ8gV+EyqR2e4
        DDajKtHEfxNyxfcIiFo8ubBHdTwOPO754xQQeoTomUvVTa4TmjrV6y6g6bJaqabgsu+ZXfhCgus8M
        kzoLnMHToTSB4kOjju4sPliRAmTA4wM04PJinTcxi+7IG30a6R1wXvEo6yRT7ppODRyBW8vqDNsYf
        qsxsF1Dc1N3cyipxPPAHDTufrrd4l8MZF+/XdicYXpV4dhJIE9xiEOIPMCXQuEIn0IXacEysW9XTj
        92pPyaIG4WeyYWAu1/vQNa89ET/M4abh/Cc/v7S7bHmlY8W76Wg4j4L0UPRFKzt/2HEZitvMupY9g
        uIaMHXfw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9Q02-006JbT-HB; Wed, 14 Jun 2023 12:53:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3CBD7300188;
        Wed, 14 Jun 2023 14:53:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D77B245CC9AA; Wed, 14 Jun 2023 14:53:20 +0200 (CEST)
Date:   Wed, 14 Jun 2023 14:53:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     Aaron Thompson <dev@aaront.org>, linux-kernel@vger.kernel.org
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <20230614125320.GA1640563@hirez.programming.kicks-ass.net>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
> 
> I've got that plain qemu thing running on:
> 
>   defconfig + kvm_guest.config + CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> 
> and have added "nokaslr" to the -append string. Lets see if it wants to
> go wobbly for me.


Ooooh, what qemu version do you have? There were some really dodgy
reports all around self modifying code, all reported on 7.2, that seems
to have gone away with 8.

Now, all of them were using TCG, and I think you're using KVM.

I've at least 36000 cycles and still nothing :-(, let me go try your
.config.


