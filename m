Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACA25BE40B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiITLCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiITLCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:02:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8CF6C753
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m7J8TcFCe/3IrKyoUbv8nRLU7ejKg/hYnQKxirV/su0=; b=UhIOaSq1GKZ+umUqUQqLxQeXyb
        gfoWFwlw1+tKTZe0YggLmGLq/bYMhtjNJYAMMv1hlvtIoP/3fDZ0X/BRH+v+Dj5PXkudlUv1rmWqN
        MBWfGQ+JJ27t/3hNxif2bFCKuwLcaZnkrO27lIP5A0w3ayFDmnKDro2LpqeN6CsqAhFSy8C7Q8ET+
        spCC3Qewu3yg6rkk42+w4DOGE3jrYZHdNZwLomWaxSoG/gGK4KLP3fbrIOv6Nipx2P2UE3959YyJb
        aQEKsvGgiEh3JR3jYX6M21DUU6a2VT1OHZZr8ppJyyzIPT2fnB/6As8YQPLCM+od81mZr5Zlk2rsy
        PKYRK9Sw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oab13-00EKM7-2b; Tue, 20 Sep 2022 11:02:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EC9B3300202;
        Tue, 20 Sep 2022 13:02:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB1F82BB47D18; Tue, 20 Sep 2022 13:02:11 +0200 (CEST)
Date:   Tue, 20 Sep 2022 13:02:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] x86/syscalls: allow tracing of __do_sys_[syscall]
 functions
Message-ID: <Yymds595qthVSnt0@hirez.programming.kicks-ass.net>
References: <20220913135213.720368-1-namit@vmware.com>
 <2D09BBFE-45F3-4B9C-8734-D002CA99FD94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2D09BBFE-45F3-4B9C-8734-D002CA99FD94@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 07:35:42PM -0700, Nadav Amit wrote:

> 1. What is the reason that inline functions are marked with notrace?

IIRC the concern is that a notrace function using an inline function;
GCC deciding to not inline and then still hitting tracing.

For noinstr we've mandated __always_inline to avoid this problem. The
direct advantage is that those inlined into instrumented code get, well,
instrumented.

> 2. Is probing function that is called from do_idle() supposed to work, or
>    should the kernel prevent it?

Should work for some :-) Specifically it doesn't work for those that
disable RCU, and that's (largely) being fixed here:

  https://lore.kernel.org/all/20220919095939.761690562@infradead.org/T/#u

Although looking at it just now, I think I missed a spot.. lemme go fix
;-)

I'm failing to find this callchain; where is
tick_nohz_get_sleep_length() calling to elfcorehdr_read() ?!?

> [ 2381.892478]  elfcorehdr_read+0x40/0x40
> [ 2381.896681]  tick_nohz_get_sleep_length+0x9d/0xc0
> [ 2381.901955]  menu_select+0x4bb/0x630
> [ 2381.905965]  cpuidle_select+0x16/0x20
> [ 2381.910069]  do_idle+0x1d2/0x270
> [ 2381.913689]  cpu_startup_entry+0x20/0x30
> [ 2381.918086]  start_secondary+0x118/0x150
> [ 2381.922484]  secondary_startup_64_no_verify+0xc3/0xcb
> [ 2381.928147]  </TASK>
> [ 2381.931535] Modules linked in: zram
> [ 2381.936365] CR2: ffffc90077cb6e4b
> [ 2381.940998] ---[ end trace 0000000000000000 ]---
> 
