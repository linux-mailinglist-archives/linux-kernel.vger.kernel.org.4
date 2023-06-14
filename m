Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF7872FB54
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbjFNKlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjFNKkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:40:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A48F19A7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686739198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VdQRhZdiHtCtPuk3jcY9yeSSGCLFQVBToLeZ7VJRZG8=;
        b=eAvxLHzG0F17dl02ncZGg0Y11IOI2NY+uYjh1kWBz6lkykwJTwWDg4PF7qUdosUbUw8aLd
        GmvFzWRdI5epoHTul6/JuTK+X3GHeTpuEU7jl5ExSUDVppxRqO+3GL6NunbGtbValxuenT
        ZGRHg1/MKtrLb3DRo7vu1uhYNZp8DXY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-1WU7cfJUNAq9qhml-yjJ3Q-1; Wed, 14 Jun 2023 06:39:55 -0400
X-MC-Unique: 1WU7cfJUNAq9qhml-yjJ3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A128D38123A0;
        Wed, 14 Jun 2023 10:39:54 +0000 (UTC)
Received: from localhost (unknown [10.39.192.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66A749E9C;
        Wed, 14 Jun 2023 10:39:54 +0000 (UTC)
Date:   Wed, 14 Jun 2023 11:39:53 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Aaron Thompson <dev@aaront.org>, linux-kernel@vger.kernel.org
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <20230614103953.GM7912@redhat.com>
References: <20230613134105.GA10301@redhat.com>
 <20230614092158.GF1639749@hirez.programming.kicks-ass.net>
 <20230614094522.GA7636@redhat.com>
 <20230614103011.GL7912@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614103011.GL7912@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got it!

#0  arch_static_branch (branch=false, key=<optimized out>)
    at ./arch/x86/include/asm/jump_label.h:27
#1  static_key_false (key=<optimized out>) at ./include/linux/jump_label.h:207
#2  native_write_msr (msr=1760, low=1876580734, high=106)
    at ./arch/x86/include/asm/msr.h:147
#3  0xffffffff8107997c in paravirt_write_msr (high=<optimized out>, 
    low=1876580734, msr=1760) at ./arch/x86/include/asm/paravirt.h:196
#4  wrmsrl (val=<optimized out>, msr=1760)
    at ./arch/x86/include/asm/paravirt.h:229
#5  lapic_next_deadline (delta=<optimized out>, evt=<optimized out>)
    at arch/x86/kernel/apic/apic.c:491
#6  0xffffffff811f7b1d in clockevents_program_event (dev=0xffff88804e820dc0, 
    expires=<optimized out>, force=<optimized out>)
    at kernel/time/clockevents.c:334
#7  0xffffffff811f81b0 in tick_handle_periodic (dev=0xffff88804e820dc0)
    at kernel/time/tick-common.c:133
#8  0xffffffff810796c1 in local_apic_timer_interrupt ()
    at arch/x86/kernel/apic/apic.c:1095
#9  __sysvec_apic_timer_interrupt (regs=regs@entry=0xffffc90000003ee8)
    at arch/x86/kernel/apic/apic.c:1112
#10 0xffffffff81f9cf09 in sysvec_apic_timer_interrupt (regs=0xffffc90000003ee8)
    at arch/x86/kernel/apic/apic.c:1106
#11 0xffffffff820015ca in asm_sysvec_apic_timer_interrupt ()
    at ./arch/x86/include/asm/idtentry.h:645
#12 0x0000000000000000 in ?? ()

There's only 1 vCPU in the VM.  However earlier I did try
with -smp 2 and that also has the same issue.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

