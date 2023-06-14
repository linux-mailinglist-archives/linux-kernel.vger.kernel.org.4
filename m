Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EBB72FC82
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244044AbjFNLfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244038AbjFNLfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:35:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797B810D5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FDiP6O9gPSQaPWMe9KEpB0x898vzzUW39aeiUbMsRBI=; b=HZm7VJAF8OKEfiMDDqIbvqSi6W
        TxIdm6caIor7s9K353ftlUNiAH1RNWAXsMvYJkFgPGrrMgiFxlfJXeEECzL2aSipZ6cIfnvyYp3EM
        Dbmh/Mubi97EqmmloS8uS25N/Y6bxN8/wpNcL1vh2L68RS2s2m750IEzPnVVoT9mPw/7ubKr9wJhe
        ZWYTI9f/TZj+A4YSAP52SLWtpQXs1KzJo61exn5Xv1MWQhUADRLTG/bpDVau+fdd28FOiY5eRgmXh
        S0ZwyMUVUiPutrxtP8uBFcZkijLbHpt54ghh+J6BbrJtZyEII1nVoHTKqyv7lgl7tLOD6B9AXSQpJ
        6RJbmOsA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9Omm-00Ako9-33;
        Wed, 14 Jun 2023 11:35:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 921133002F0;
        Wed, 14 Jun 2023 13:35:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7957D245CC9AB; Wed, 14 Jun 2023 13:35:36 +0200 (CEST)
Date:   Wed, 14 Jun 2023 13:35:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     Aaron Thompson <dev@aaront.org>, linux-kernel@vger.kernel.org
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <20230614113536.GJ1639749@hirez.programming.kicks-ass.net>
References: <20230613134105.GA10301@redhat.com>
 <20230614092158.GF1639749@hirez.programming.kicks-ass.net>
 <20230614094522.GA7636@redhat.com>
 <20230614103011.GL7912@redhat.com>
 <20230614103953.GM7912@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614103953.GM7912@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 11:39:53AM +0100, Richard W.M. Jones wrote:
> Got it!
> 
> #0  arch_static_branch (branch=false, key=<optimized out>)
>     at ./arch/x86/include/asm/jump_label.h:27
> #1  static_key_false (key=<optimized out>) at ./include/linux/jump_label.h:207
> #2  native_write_msr (msr=1760, low=1876580734, high=106)
>     at ./arch/x86/include/asm/msr.h:147
> #3  0xffffffff8107997c in paravirt_write_msr (high=<optimized out>, 
>     low=1876580734, msr=1760) at ./arch/x86/include/asm/paravirt.h:196
> #4  wrmsrl (val=<optimized out>, msr=1760)
>     at ./arch/x86/include/asm/paravirt.h:229
> #5  lapic_next_deadline (delta=<optimized out>, evt=<optimized out>)
>     at arch/x86/kernel/apic/apic.c:491
> #6  0xffffffff811f7b1d in clockevents_program_event (dev=0xffff88804e820dc0, 
>     expires=<optimized out>, force=<optimized out>)
>     at kernel/time/clockevents.c:334
> #7  0xffffffff811f81b0 in tick_handle_periodic (dev=0xffff88804e820dc0)
>     at kernel/time/tick-common.c:133
> #8  0xffffffff810796c1 in local_apic_timer_interrupt ()
>     at arch/x86/kernel/apic/apic.c:1095
> #9  __sysvec_apic_timer_interrupt (regs=regs@entry=0xffffc90000003ee8)
>     at arch/x86/kernel/apic/apic.c:1112
> #10 0xffffffff81f9cf09 in sysvec_apic_timer_interrupt (regs=0xffffc90000003ee8)
>     at arch/x86/kernel/apic/apic.c:1106
> #11 0xffffffff820015ca in asm_sysvec_apic_timer_interrupt ()
>     at ./arch/x86/include/asm/idtentry.h:645
> #12 0x0000000000000000 in ?? ()

Uuuhh.. something is really fishy here. The thing in common between the
fingered patch and this stacktrace is the jump_label/static_branch
usage, but they're quite different paths.

There is no printk or local_clock() in sight here.

I've got that plain qemu thing running on:

  defconfig + kvm_guest.config + CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y

and have added "nokaslr" to the -append string. Lets see if it wants to
go wobbly for me.


