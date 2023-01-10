Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A88664D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjAJUi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjAJUiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:38:25 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F47485BE
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:38:23 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id bj3so10429111pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=adAxM/tdxethfCc9kWsVP4uZeaLxTRj54+QnNFBkUNY=;
        b=q6L5OgUTT+UTRnL01un1afM9agRNUadY7z3gcTMkTail3+Qhky05OYeoYhqXQYg/2V
         oNM0bJF76X8c1a11DiRZwcxUUHYL3WCdBjquE+qsCek2XUUM0gXKs5jgYWAsvJKFOq3s
         2lnuRusHfIRnNbb9jdGjYhKOTOw50LK1/BLu87Zi/Mpo+hASVtgSMMzyjjmxYUTFskob
         p27WyREJ+flNoKcGO2HMB4eNUNOHlrLrKCJ+wJHvQBcRyydwzjIxEbXRXn1ARZZEyQGa
         CjT+HPcFde0Kq8RXE0OBr1Oysi/okt8jgq4il6jxujPqUwEvyhWt1lPGGK2sbFlYhhn8
         ZxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=adAxM/tdxethfCc9kWsVP4uZeaLxTRj54+QnNFBkUNY=;
        b=rMq9c+p8c7RjcURioH69BA8k8/mk9XBKTbUEyaLMvskQRrVbqiynQkirrIHN0ATTzk
         PtRtoIsENsmx8HMZSuyneGiSEzUYs/qGkYq551rJmsXjOP77/SRbeHWeUXaTKxGfHyqO
         wEPGPCCma02pAVp/Hm8p2xBzDCoXTzYOczLbEll2iE40Q/5PRVqja7aPVRG30rRh94iG
         EJR32IMx/f99cJAYWecTmH1Wtj30amQA+Iasv9jzbK+dRKxjLVcbhrU5rw8JqeFDLY96
         E7pylT8p0bT0gpLnr75uyJcUWFEWSxe0x6nRjQUXfo2ivsKG2A8dEDycdJmC6BAi+A+8
         dLXg==
X-Gm-Message-State: AFqh2kqXy9gdzrEn8rzKZ6l1dB3OtOL6H++ChmeFau02reI5y/meCI+g
        dAvoErJ5ym7ek8sSLaDKtM9OJPVPMstrTXHXgdn7+Q==
X-Google-Smtp-Source: AMrXdXsEsCNJ48Atas4Y6eD6ioPdCdz81nx9K6hMDwJwBy/FjZKLO3qICbX1P4jlmpWAughD783FHgYsDQpRu2d1nFw=
X-Received: by 2002:a17:90b:4b4c:b0:219:6be1:7ff2 with SMTP id
 mi12-20020a17090b4b4c00b002196be17ff2mr6404270pjb.79.1673383103232; Tue, 10
 Jan 2023 12:38:23 -0800 (PST)
MIME-Version: 1.0
References: <20230107040203.never.112-kees@kernel.org> <CAMuHMdURtDNzzaoBM4DpEHKiDsgnA-7Yc9QO=5gsmwz9PHWK5w@mail.gmail.com>
 <ae952aa5-f113-8786-6fe4-60e5fa0ced2b@suse.cz>
In-Reply-To: <ae952aa5-f113-8786-6fe4-60e5fa0ced2b@suse.cz>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 10 Jan 2023 12:38:11 -0800
Message-ID: <CAGS_qxrOVhXQaxqKknS2CJpHeCWHaMshvdJNdzeN6+KxQmY_uA@mail.gmail.com>
Subject: Re: [PATCH] kunit: memcpy: Split slow memcpy tests into MEMCPY_SLOW_KUNIT_TEST
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org, David Gow <davidgow@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
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

On Mon, Jan 9, 2023 at 11:51 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> +Cc rest of kunit from MAINTAINERS
>
> On 1/7/23 11:55, Geert Uytterhoeven wrote:
> > Hi Kees,
> >
> > On Sat, Jan 7, 2023 at 5:02 AM Kees Cook <keescook@chromium.org> wrote:
> >> Since the long memcpy tests may stall a system for tens of seconds
> >> in virtualized architecture environments, split those tests off under
> >> CONFIG_MEMCPY_SLOW_KUNIT_TEST so they can be separately disabled.

<snip>

> >>
> >> -static void init_large(struct kunit *test)
> >> +static int init_large(struct kunit *test)
> >>  {
> >> +       if (!IS_ENABLED(CONFIG_MEMCPY_SLOW_KUNIT_TEST)) {
> >> +               kunit_skip(test, "Slow test skipped. Enable with CONFIG_MEMCPY_SLOW_KUNIT_TEST=y");
> >
> > So I can't make the slower tests available for when I need them,
> > but not run them by default?
>
> Indeed it seems weird to tie this to a config option without runtime override.
>
> > I guess that's why you made MEMCPY_SLOW_KUNIT_TEST tristate originally,
> > to have a separate module with the slow tests?
>
> On the other hand I can imagine requiring a separate module for slow tests
> would lead to more churn - IIUC there would need to be two files instead of
> memcpy_kunit.c, possibly a duplicated boilerplate code (or another shared .c
> file).
>
> So the idea is to have a generic way to mark some tests as slow and a way to
> opt-in/opt-out for those when running the tests. Maybe KUnit folks already
> have such mechanism or have an idea how to implement that.

There is no mechanism atm, and we'd still need to figure it out so
it'll be a while.
So I think a patch like this makes sense in the short-term.

This is definitely something we've always thought would be useful eventually.
See this TODO which has been there since day 1 ;)
https://elixir.bootlin.com/linux/latest/source/lib/kunit/try-catch.c#L36

It just felt like it would be premature to come up with something when
basically all the tests up until now ran ~instantly.

Throwing out some rough implementation ideas:
I was thinking the granularity for these timeout annotations would be
at the suite-level.
If we go with that, then I guess the intended flow is to group slow
tests into their own suite and mark them as such.

Then maybe we'd have some runtime way of disabling/enabling "long"
tests, like a cmdline opt.
E.g. you'd pass `kunit.max_test_size=30` to exclude tests longer than
30 seconds.

Daniel
