Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4509615525
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiKAWh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiKAWgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:36:47 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1C31EC5A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:36:25 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f9so14683959pgj.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 15:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2cwGjp62AuRZ4ErOGQPCTEHZe72CYawrStjsHhz7giw=;
        b=hAAEPFf4J5fodOBH0LmSyrz38aQxWjUdrG6jYhbXewAGk3aOLj1pNDqpa956tKah8m
         RKQOlzYTMEtKDUsYmHP6R3U/zkJs+JfgIkwgb2tkgc9NEKr1pPioAnd/uCmzRSWV970l
         Zzym2tS+iKfutBSNeGiFbIojVYjBySIgyFVQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cwGjp62AuRZ4ErOGQPCTEHZe72CYawrStjsHhz7giw=;
        b=Wq8W08TttkURfcWInXH6qmIEtVZ084YJYclju8rzb1m/4rQ8x5zP/DEmRWt4bkOkkX
         vN4a7rA69NbTH2uDFr+JaNA2H1EZKQVhut1YUenS3/SmiiPd9S7XQKb53QYmfl1+FvJN
         zv6iKYr+gsfYAvgnatUtlla/VQz787v5Eh6kWv/Azf+kcU5xijfI4aJMbAJw+K5v8WNO
         EqIO7L0lIXUU1TQyZJdqv3ZaDRZX7WOgzHBUuHRGAk9ftl6YPUOu9xJ0tk0WMjswmbRj
         JoGqoattHvJnMDBIk9s90zpGunTTXRmv1OfOHsqkApEgWvx7jXHOas7LYwWKg7rqe77M
         po5w==
X-Gm-Message-State: ACrzQf3Kgr9/AqQ8m5JpKz3NLfw1HMKooSXLFJiSkeM8rgVEe+K99OJv
        BDobxTnDX5yPNSTKjH5SPcIXfA==
X-Google-Smtp-Source: AMsMyM4kT+kkRBSFjTOn045KLLXKB9sbYcsB3D9L4w9+wzGQHQ3EJJ+9ptAxFYvDPVxf1wNTjc9Jcg==
X-Received: by 2002:a63:595:0:b0:470:8b7:255a with SMTP id 143-20020a630595000000b0047008b7255amr317560pgf.329.1667342184656;
        Tue, 01 Nov 2022 15:36:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n6-20020a654cc6000000b004608b721dfesm6344856pgt.38.2022.11.01.15.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:36:24 -0700 (PDT)
Date:   Tue, 1 Nov 2022 15:36:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     bp@alien8.de, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        dave.hansen@linux.intel.com, David.Laight@aculab.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, llvm@lists.linux.dev, luto@kernel.org,
        mingo@redhat.com, torvalds@linux-foundation.org, x86@kernel.org
Subject: Re: [RESEND PATCH v5] x86, mem: move memmove to out of line assembler
Message-ID: <202211011534.C31FC5ED6@keescook>
References: <20221018172155.287409-1-ndesaulniers@google.com>
 <Y08NJohEeoYX2aIf@thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y08NJohEeoYX2aIf@thelio-3990X>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 01:31:34PM -0700, Nathan Chancellor wrote:
> On Tue, Oct 18, 2022 at 10:21:55AM -0700, Nick Desaulniers wrote:
> > When building ARCH=i386 with CONFIG_LTO_CLANG_FULL=y, it's possible
> > (depending on additional configs which I have not been able to isolate)
> > to observe a failure during register allocation:
> > 
> >   error: inline assembly requires more registers than available
> > 
> > when memmove is inlined into tcp_v4_fill_cb() or tcp_v6_fill_cb().
> > 
> > memmove is quite large and probably shouldn't be inlined due to size
> > alone. A noinline function attribute would be the simplest fix, but
> > there's a few things that stand out with the current definition:
> > 
> > In addition to having complex constraints that can't always be resolved,
> > the clobber list seems to be missing %bx. By using numbered operands
> > rather than symbolic operands, the constraints are quite obnoxious to
> > refactor.
> > 
> > Having a large function be 99% inline asm is a code smell that this
> > function should simply be written in stand-alone out-of-line assembler.
> > 
> > Moving this to out of line assembler guarantees that the
> > compiler cannot inline calls to memmove.
> > 
> > This has been done previously for 64b:
> > commit 9599ec0471de ("x86-64, mem: Convert memmove() to assembly file
> > and fix return value bug")
> > 
> > That gives the opportunity for other cleanups like fixing the
> > inconsistent use of tabs vs spaces and instruction suffixes, and the
> > label 3 appearing twice.  Symbolic operands, local labels, and
> > additional comments would provide this code with a fresh coat of paint.
> > 
> > Finally, add a test that tickles the `rep movsl` implementation to test
> > it for correctness, since it has implicit operands.
> > 
> > Suggested-by: Ingo Molnar <mingo@kernel.org>
> > Suggested-by: David Laight <David.Laight@aculab.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Tested-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> I ran
> 
> $ tools/testing/kunit/kunit.py run --arch i386 --cross_compile x86_64-linux- memcpy
> 
> with GCC 6 through 12 from
> https://mirrors.edge.kernel.org/pub/tools/crosstool/ (my GCC 5 container
> is based on Ubuntu Xenial, which does not have a new enough Python for
> kunit.py) and
> 
> $ tools/testing/kunit/kunit.py run --arch i386 --make_options LLVM=1 memcpy
> 
> with LLVM 11 through 16 from Debian with this change on top of Kees's
> expanding of the memcpy() KUnit tests [1] and everything passed.
> 
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Can an x86 maintainer please pick this up for -tip?

Thanks!

-Kees

-- 
Kees Cook
