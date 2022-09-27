Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4845ECC38
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 20:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiI0SlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 14:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiI0SlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 14:41:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAD3F185A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 11:41:04 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id iw17so9907551plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 11:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=e7R+mDLju2JroAcNFMiEg35mWzGVebbcux9nnUdL0+s=;
        b=XP3ei/YY35BS6LARIxHchz6xoHvIGGmZNaPaqubd/9AtflMvF6FPymZ23lgOvUUlX9
         fq2g0GoJgzf55NsbkZ1ITvHY3yZW0lBZgRmpmhyDYqu0+Ww8kXYgc0kcf8ND0KfCFdu8
         q6xmnfVySqteH9LyV2p4GPqh3RYh2csuyU7HY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=e7R+mDLju2JroAcNFMiEg35mWzGVebbcux9nnUdL0+s=;
        b=HmVhXDr+Xy3uFAi08I422FI17caaJzAtqFzPHmK8oE4XtfHzA7fOQ4HukXGpoqv9v9
         lPkbEXIcqsyoqTzd9XwOrTa/BkLnjHes1St5pjY4W+rPV1X3+SmQdvTOC09ZeCsovmTV
         HV93YShwXnk0QbOqAGVKFabBF10//qPQSq0/7TPkNu0vfYwe118KLV7sF5k7ra8BzrL4
         Xs5X5rey1vpXseTfHaayWPW0R9OK7yutQuNTS0Ljosf2jIEQfzgIG0dryANPbfitgDgG
         CMymzVAaD7m3NC8j9DJSYhbY24Py2cHzMJKHHujU4uLNZlsvnDp7ajHVAmMd1XI4DMl6
         IpbQ==
X-Gm-Message-State: ACrzQf2DFBsbDarf8UQbbjSV9T8JDSX+zx24wCK/QpaBmkjvI1LH488B
        SigQlacMU+TIoz8U38TppRkQ3A==
X-Google-Smtp-Source: AMsMyM6mgGHLlGWhcrVcjuLvxN36jGAc0ixW3+4jzpS7y1F8Pj0NInwGA78MT8xniWkhPWHkmePT2w==
X-Received: by 2002:a17:90b:380d:b0:202:56b2:4ef8 with SMTP id mq13-20020a17090b380d00b0020256b24ef8mr6134704pjb.2.1664304064224;
        Tue, 27 Sep 2022 11:41:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902f70f00b00173411a4385sm1912789plo.43.2022.09.27.11.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 11:41:03 -0700 (PDT)
Date:   Tue, 27 Sep 2022 11:41:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        llvm@lists.linux.dev, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] x86, mem: move memmove to out of line assembler
Message-ID: <202209271126.605B4FF@keescook>
References: <CAKwvOd=a+0VNP-d=mHnbM4ujdtPrujru4dxHtfDo+EEM+b6deg@mail.gmail.com>
 <20220927172839.3708280-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927172839.3708280-1-ndesaulniers@google.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 10:28:39AM -0700, Nick Desaulniers wrote:
> When building ARCH=i386 with CONFIG_LTO_CLANG_FULL=y, it's possible
> (depending on additional configs which I have not been able to isolate)
> to observe a failure during register allocation:
>
>   error: inline assembly requires more registers than available
>
> when memmove is inlined into tcp_v4_fill_cb() or tcp_v6_fill_cb().
>
> memmove is quite large and probably shouldn't be inlined due to size
> alone. A noinline function attribute would be the simplest fix, but
> there's a few things that stand out with the current definition:
>
> In addition to having complex constraints that can't always be resolved,
> the clobber list seems to be missing %bx and %dx, and possibly %cl. By
> using numbered operands rather than symbolic operands, the constraints
> are quite obnoxious to refactor.
>
> Having a large function be 99% inline asm is a code smell that this
> function should simply be written in stand-alone out-of-line assembler.
> That gives the opportunity for other cleanups like fixing the
> inconsistent use of tabs vs spaces and instruction suffixes, and the
> label 3 appearing twice.  Symbolic operands and local labels would
> provide this code with a fresh coat of paint.
>
> Moving this to out of line assembler guarantees that the compiler cannot
> inline calls to memmove.
>
> This has been done previously for 64b:
> commit 9599ec0471de ("x86-64, mem: Convert memmove() to assembly file
> and fix return value bug")
>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Unfortunately, it seems something has gone wrong with this
implementation. Before the patch:

$ ./tools/testing/kunit/kunit.py run --arch=i386 memcpy
...
[11:26:24] [PASSED] memmove_test
...

After the patch:

$ ./tools/testing/kunit/kunit.py run --arch=i386 memcpy
...
[11:25:59] # memmove_test: ok: memmove() static initializers
[11:25:59] # memmove_test: ok: memmove() direct assignment
[11:25:59] # memmove_test: ok: memmove() complete overwrite
[11:25:59] # memmove_test: ok: memmove() middle overwrite
[11:25:59] # memmove_test: EXPECTATION FAILED at lib/memcpy_kunit.c:176
[11:25:59] Expected dest.data[i] == five.data[i], but
[11:25:59] dest.data[i] == 136
[11:25:59] five.data[i] == 0
[11:25:59] line 176: dest.data[10] (0x88) != five.data[10] (0x00)
[11:25:59] # memmove_test: ok: memmove() argument side-effects
[11:25:59] # memmove_test: ok: memmove() overlapping wr\xf0te
[11:25:59] not ok 3 - memmove_test
[11:25:59] [FAILED] memmove_test
...

data[10] starts set as 0x99, and in theory gets 0x0 written to it, but
the self-test sees 0x88 there. (?!) It seems the macro side-effect test
caught something else entirely?

-Kees

--
Kees Cook
