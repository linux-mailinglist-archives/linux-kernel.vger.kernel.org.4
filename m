Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80895EBB79
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiI0HaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiI0HaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:30:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776DD20BEC;
        Tue, 27 Sep 2022 00:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tls49PLjZOzAeRxCnxqtOV072QtfY6ihsqweRWOv07c=; b=bJWcivEsmM2FcxwzWZpWJxbPSh
        8f/Vx3JR1uW7SRoOH1n+ALAE7l/EAofilHwoZUZkVO9rVAHbrRXEic7AmZaaub+Qxth90vNV2XkOs
        EOrIS4oTZt2XIEqhE0YHAWB0XYYm6YYulqSY6q18Lglwkm6d3UP8Kx64koPk/md3ZzGG5YvP3OM12
        hmfuylbAjgYQQGnHucDxXAGc04Yaxg8XPEHw28DE1s0n6f1UhGzwkuxWSVzr7dBujRBNt/vqhU2Cu
        SmbPFQdQIs8nuZ1TFxNtHVKa6aPX01t4Z31J+KgoB/4KoiiJWcqkbWCf0ioHcMd9WUZ45P4JohRTl
        7mLiCVOw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1od52L-00BEXq-Bw; Tue, 27 Sep 2022 07:29:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96ABF3001D6;
        Tue, 27 Sep 2022 09:29:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5ACE22022F86A; Tue, 27 Sep 2022 09:29:44 +0200 (CEST)
Date:   Tue, 27 Sep 2022 09:29:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH v5 00/22] KCFI support
Message-ID: <YzKmaCczYFk6k8S/@hirez.programming.kicks-ass.net>
References: <20220908215504.3686827-1-samitolvanen@google.com>
 <YzGdeYzoZ1uC1CO/@hirez.programming.kicks-ass.net>
 <CAMe9rOrHe9XD2D+pZJrKo1DxkLMQggDOFXQJfTgEO+xp0dybdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMe9rOrHe9XD2D+pZJrKo1DxkLMQggDOFXQJfTgEO+xp0dybdw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 01:16:04PM -0700, H.J. Lu wrote:
> On Mon, Sep 26, 2022 at 5:39 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Sep 08, 2022 at 02:54:42PM -0700, Sami Tolvanen wrote:
> > > KCFI is a forward-edge control-flow integrity scheme in the upcoming
> > > Clang 16 release, which is more suitable for kernel use than the
> > > existing CFI scheme used by CONFIG_CFI_CLANG. KCFI doesn't require
> > > LTO, doesn't alter function references to point to a jump table, and
> > > won't break function address equality.
> > >
> > > This series replaces the current arm64 CFI implementation with KCFI
> > > and adds support for x86_64.
> > >
> > > KCFI requires assembly functions that are indirectly called from C
> > > code to be annotated with type identifiers. As type information is
> > > only available in C, the compiler emits expected type identifiers
> > > into the symbol table, so they can be referenced from assembly
> > > without having to hardcode type hashes. Patch 6 adds helper macros
> > > for annotating functions, and patches 9 and 20 add annotations.
> > >
> > > In case of a type mismatch, KCFI always traps. To support error
> > > handling, the compiler generates a .kcfi_traps section for x86_64,
> > > which contains the locations of each trap, and for arm64, encodes
> > > the necessary register information to the ESR. Patches 10 and 22 add
> > > arch-specific error handlers.
> > >
> > > To test this series, you'll need a ToT Clang toolchain. The series
> > > is also available pn GitHub:
> > >
> > >   https://github.com/samitolvanen/linux/commits/kcfi-v5
> >
> > As mentioned at plumbers, my only concern is somewhat excessive use of
> > CFI_CLANG as oposed to something more compiler neutral. But I suppose
> > that's something we can cleanup/fix when GCC grows support for this.
> >
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >
> > (as in I ran kCFI + call-depth-tracking + FineIBT on a bunch of
> > hardware)
> >
> > HJL, can you look at adding kCFI support to GCC ?
> 
> Adding -fsanitize=kcfi to GCC is a big effort.  Please open a
> GCC bug:
> 
> https://gcc.gnu.org/bugzilla/enter_bug.cgi?product=gcc

Here goes:

  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107048
