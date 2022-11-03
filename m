Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B72617B6E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiKCLTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKCLTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:19:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FC8CE39
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 04:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hy3vS+2ditbsS3Mm+JaviChR3PX6CrD9PjMpbxfhzKw=; b=b0NSnWv3NFvikrWqpnsogGD7LG
        thYHDDiOkzPbCw3YfB8jDdmCbljkQRqvSyb+VepL7xJfoPxQkcGKksBjRXmzARf1u7o7C7Sp9Vxo3
        yJ5AuviNzUExDAf3MOBBoJ/JFdS2gwOiOuY1yKld7MVh4qa9R+l3tYtQoQNTU3/O0Me+4xXjFAhT8
        jakrRivL42x4E0Qyy1wp368NkygA1N1CzZXX4euuVe9jHBLjPC2qXSNWpKMWJqRt9XUdz5Dm6ko53
        /21DFbzF/w26EQEnLKHaIuLBvNSu8edEXFKF2duPMg+nkEZVFFQK+zEXej1MVz6LGQRxo/Ed3EvLI
        E4mgohOw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqYF9-008fOB-RI; Thu, 03 Nov 2022 11:18:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B3E9230026A;
        Thu,  3 Nov 2022 12:18:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A409120B250A8; Thu,  3 Nov 2022 12:18:41 +0100 (CET)
Date:   Thu, 3 Nov 2022 12:18:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: Re: [PATCH 5/5] x86/traps: avoid KMSAN bugs originating from
 handle_bug()
Message-ID: <Y2OjkZTOoDa+mQrS@hirez.programming.kicks-ass.net>
References: <20221102110611.1085175-1-glider@google.com>
 <20221102110611.1085175-5-glider@google.com>
 <Y2JnsG5QZoO4iazD@hirez.programming.kicks-ass.net>
 <CAG_fn=X_92f1w9=Xuj6eYcF9Za3rbpeGe+P79fJ8mkgEQO1XYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=X_92f1w9=Xuj6eYcF9Za3rbpeGe+P79fJ8mkgEQO1XYA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 02:37:19PM +0100, Alexander Potapenko wrote:
> On Wed, Nov 2, 2022 at 1:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Nov 02, 2022 at 12:06:11PM +0100, Alexander Potapenko wrote:
> > > There is a case in exc_invalid_op handler that is executed outside the
> > > irqentry_enter()/irqentry_exit() region when an UD2 instruction is used
> > > to encode a call to __warn().
> > >
> > > In that case the `struct pt_regs` passed to the interrupt handler is
> > > never unpoisoned by KMSAN (this is normally done in irqentry_enter()),
> > > which leads to false positives inside handle_bug().
> > >
> > > Use kmsan_unpoison_entry_regs() to explicitly unpoison those registers
> > > before using them.
> >
> > As does poke_int3_handler(); does that need fixing up too? OTOH look
> > *very very* carefully at the contraints there.
> 
> Fortunately poke_int3_handler() is a noinstr function, so KMSAN
> doesn't add any checks to it.
> It also does not pass regs to other instrumented functions, at least
> for now, so we're good.

Ah indeed; because it is fully noinstr, nothing will trigger the lack of
annotation.
