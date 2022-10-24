Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BCA609D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiJXJA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJXJAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:00:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747DA4D819;
        Mon, 24 Oct 2022 02:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=U2qsyck3+2cZvGphRuro4gkFJ7O7eymLJWgikp+cU+s=; b=U25ri7EwmLT5MxOLEoXBr3iXF9
        //tLMlxGyred958W7o9TvSwbvrSwqZ2rLozMg2tLh7IRrjpux6tQ/UIvKHI1Tgz0770t/WbNVU8XP
        F7scfNrHIjOXlt+pWkT59l8i9MGYhrmX9xk8dqvyWypdXyGkALYA6oHKJlDkY4USmzkepv3YXulbn
        WHIPVrH1Dee5fsWip3LINGnMhr3hYP+jlLV1y8a1bYLaWQ7smWXkjBzGsMs5ZS5rK9eGul7K3Tqpo
        PmzAazNhuRTl8SEF/ksfPF45z7d70kGNRBuPAhzCTj062yNqOioJE7cZxSmwpQG+Vt/n/CVmITwT0
        Q5EA2ASA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omtJD-00FIk8-N9; Mon, 24 Oct 2022 08:59:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3766A300205;
        Mon, 24 Oct 2022 10:59:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 126822C356CB9; Mon, 24 Oct 2022 10:59:40 +0200 (CEST)
Date:   Mon, 24 Oct 2022 10:59:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: linux-next: build warning after merge of the tip tree
Message-ID: <Y1ZT/FdOgMtsiMxk@hirez.programming.kicks-ass.net>
References: <20221024112845.5efaa8c1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221024112845.5efaa8c1@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 11:28:45AM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
>=20
> vmlinux.o: warning: objtool: get_cpu_entry_area+0x4: call to cea_offset()=
 leaves .noinstr.text section
>=20
> Presumably something to do with commit
>=20
>   1248fb6a8201 ("x86/mm: Randomize per-cpu entry area")

Thanks, and yesh Boris said the same late on Friday... all the *SAN
stuff tickled the compiler's stupid bone again.

The below cures it, Dave, do we fold it in or mash on top?


diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index ad1f750517a1..a8f18e613190 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -18,7 +18,7 @@ DEFINE_PER_CPU(struct cea_exception_stacks*, cea_exceptio=
n_stacks);
=20
 static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, _cea_offset);
=20
-static inline unsigned int cea_offset(unsigned int cpu)
+static __always_inline unsigned int cea_offset(unsigned int cpu)
 {
 	return per_cpu(_cea_offset, cpu);
 }
@@ -52,7 +52,7 @@ static __init void init_cea_offsets(void)
 #else /* !X86_64 */
 DECLARE_PER_CPU_PAGE_ALIGNED(struct doublefault_stack, doublefault_stack);
=20
-static inline unsigned int cea_offset(unsigned int cpu)
+static __always_inline unsigned int cea_offset(unsigned int cpu)
 {
 	return cpu;
 }
