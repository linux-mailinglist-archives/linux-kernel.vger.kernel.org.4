Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73265F6D49
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 19:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiJFR5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 13:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiJFR5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 13:57:01 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2B9AE204
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 10:56:59 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h8-20020a17090a054800b00205ccbae31eso5011247pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 10:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Ew5U/zqlN15J4j3h5hCZA2cjGBGnLv9k5+/aqrXH4Z4=;
        b=pRTmbm0MH/KaCv4CN2mlwOQHH8KkdTrXQ4+icasRMMZjojQKWwyW2hZ5bKHq5UouEn
         ad/1CjPi+CiChlZW8AppPN0is27kUmyRMX7GD2t0wTb+9Zu6OBxbFlQPexrtbx8y5RAA
         k1jNndWDe7cju5EdavxVLasH0BysgPwxLSnyV4DXxhQcGB6pzErnXzMxTcYm35V6PVFV
         UEWLggnHagS8Za1Nh9FMd5UQFg6qjGSstyPDkEFQuXEpQx1ZshOA6qySlqv4yqBnp4WQ
         oWRv5g+ra35HXYY7vzicv7iadRrBGyZ+dQH4aqzup/eBDFEXlTaNBX+dfhwrKiHqq1oI
         ttqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Ew5U/zqlN15J4j3h5hCZA2cjGBGnLv9k5+/aqrXH4Z4=;
        b=RzaUMxL+P9POqUDx8FaiPha+5pMCMlzDABU43//JcHdWQRP2IT2dRlcHjXq9rZPJIK
         5ne3ZFe1RKMdcu7o7xmmxfPHgKztLeJeJF7oUOEQ4ydPhhKxkfWf7toYS+OPP6BRbj8w
         SJd+khDAe5jaPGCtd9Wgb+ulcyustV5r6Pyz/pJxQqsh9qxBrdIx5FZEvTJU09me6sPb
         /V9JsAdQZNb6FKAY9oVYkHFdqXZ8CeQq6EbvJhIzCWoGRKr86LzLC1DB0FjIU44wGUFJ
         NuLngi19dHdyCPLw5+1sTPZfhghHOV7I6kjiazq2HA7Ad8pl7wFH7GsIQioSXn9MlcZJ
         4AAw==
X-Gm-Message-State: ACrzQf3wwcDeZFJILE/lowFu0G0G1v9JyPWhbTN/gYm3ewG4G7P3TYk/
        sDMPIN03qZanZUKXMhfutU+S/07speNt929tX8ovHA==
X-Google-Smtp-Source: AMsMyM7ctjkDNOFrgPQTYEkNHbpezmOk/2ifv3pjFSMHmP963jkMzYypweFyfZqFXzQdmSGDeeb3Xes3Y2eMCchSKFE=
X-Received: by 2002:a17:90b:33c3:b0:20a:ebc3:6514 with SMTP id
 lk3-20020a17090b33c300b0020aebc36514mr10329734pjb.147.1665079018869; Thu, 06
 Oct 2022 10:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220817185410.1174782-1-nathan@kernel.org> <CAKwvOd=0R76r6YqNiOhGNt_XrA_t_ZbuBbNNdNXV4CWpDy0+Bg@mail.gmail.com>
 <Yv3uI/MoJVctmBCh@worktop.programming.kicks-ass.net> <CAKwvOdk09OCeOrmHJBzRhp4XQykH_tkBGi9DY870C=suBzz9YQ@mail.gmail.com>
In-Reply-To: <CAKwvOdk09OCeOrmHJBzRhp4XQykH_tkBGi9DY870C=suBzz9YQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 6 Oct 2022 10:56:47 -0700
Message-ID: <CAKwvOdm-eyK5UEtARz5KW2D38GJkXJbUtbpRUCK5RKcHUAVzrw@mail.gmail.com>
Subject: Re: [PATCH] x86/build: Move '-mindirect-branch-cs-prefix' out of
 GCC-only block
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "Moreira, Joao" <joao.moreira@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 2:27 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Thu, Aug 18, 2022 at 12:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Aug 17, 2022 at 03:08:01PM -0700, Nick Desaulniers wrote:
> > > On Wed, Aug 17, 2022 at 11:56 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > > >
> > > > LLVM 16 will have support for this flag so move it out of the GCC-only
> > > > block to allow LLVM builds to take advantage of it.
> > > >
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/1665
> > > > Link: https://github.com/llvm/llvm-project/commit/6f867f9102838ebe314c1f3661fdf95700386e5a
> > > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > >
> > > Thanks for the patch, I also boot tested this (in virtual guests for
> > > both 64b and 32b).
> > >
> > > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> > >
> > > Peter, is there anything else special about these prefixes needed to
> > > make use of them?
> >
> > The thing to do is boot with (warning, *very* verbose):
> >
> >         "spectre_v2=retpoline,lfence debug-alternative"
>
> ah, debug-alternative also needs loglevel=8. Was wondering why I
> wasn't getting anything new in the output...
>
> No kidding on the verbosity. For a defconfig, booting in QEMU and
> redirecting stdout to a file produced a 95257 line file.
>
> $ grep "SMP alternatives: retpoline" /tmp/log.txt | wc -l
> 18623
> $ du -h /tmp/log.txt
> 11M /tmp/log.txt
> $ grep "SMP alternatives: retpoline" /tmp/log.txt | tr -s ' '
> ...
> [ 56.736261] SMP alternatives: retpoline at:
> pm_check_save_msr+0x30/0x80 (ffffffffaa34b320) len: 6 to:
> __x86_indirect_thunk_r11+0x0/0x20
> $ grep "SMP alternatives: retpoline" /tmp/log.txt | tr -s ' ' | cut -d
> ' ' -f 10 | sort -u
> 5
> 6
> # Curious about the 5, looks like there's only 2 cases:
> $ grep "SMP alternatives: retpoline" /tmp/log.txt | grep 'len: 5'
> [    0.147261] SMP alternatives: retpoline at: ret_from_fork+0x1d/0x30
> (ffffffffa9601dbd) len: 5 to: __x86_indirect_thunk_rbx+0x0/0x20
> [    2.274261] SMP alternatives: retpoline at: __efi_call+0x23/0x30
> (ffffffffa9671663) len: 5 to: __x86_indirect_thunk_rdi+0x0/0x20

For the typical len 6 case:
[    0.710345] SMP alternatives: ffffffffa2b6d1f2: orig: 2e e8 88 5f 09 ff
[    0.711345] SMP alternatives: ffffffffa2b6d1f2: repl: 0f ae e8 41 ff d3
[    0.712345] SMP alternatives: retpoline at: setup_arch+0x4b0/0x58c
(ffffffffa2b6d2ef) len: 6 to: __x86_indirect_thunk_r11+0x0/0x20

2e is the cs prefix, so it looks like this is working.

https://github.com/llvm/llvm-project/issues/58201
:^)

> Is there anything else I can do to help verify Nathan and Joao's
> patches?  If not, would you mind Ack'ing this so the x86 maintainers
> can pick it up?

I see it's already been Acked, so NVM. This is good to go.

> Noting that Joao's patch was applied in my tests.
> https://reviews.llvm.org/D134915
> I plan to land Joao's patch imminently.

Merging.
-- 
Thanks,
~Nick Desaulniers
