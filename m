Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDC462E7C0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241182AbiKQWHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241382AbiKQWHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:07:13 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9192B701B1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:06:56 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so6827908pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t2jCs60kn1VpKqRV5eqfHEnkYPCpSmcc9fFC/BsCBvY=;
        b=YXVt+q2t6CS8/Pz/E+AFY6qXuR2xREw03ymI68D8Wp5S9neLuD8HAsa3mLVc/06RkI
         4jigOI6QzRXZrrgdRMmCaw+Q1TT0RkYx+jDpyyGT4NxExXCflMJX4THIHHJvvTZfBlIh
         ndTTVEkB627rm6vJSferAhCogOm+kukqVocB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2jCs60kn1VpKqRV5eqfHEnkYPCpSmcc9fFC/BsCBvY=;
        b=OUGHDtun1pYtuB/R/WbYb02ZWasVvvN9b6pm6djH9W6KTNGJPGraZ7J+CBL7+fJMGR
         1w0IMyrPOkfbAggqG4dYCwmTayZtnqK55vutFGTiXdzPup5mX1eVVVdhBuMIXGkLs4Ju
         Skw9/BigOwf0NT2ILOFAQxsqLRShUKAoKkvMm/mT1qEIMHpc1ljZjlE4+hkUO76azYfE
         tZizvMTTUe8GFXdCThy+OcPLTDByw0MUoVHWItuom37NggrtQSs6K0DzuBT7+8aI15UU
         b4J+mVpV3O+nuvuRe2yJFTl2pmF00HJ1DUCMqbfc0oynC87PQN4YejBqRGLwHbdQwruK
         4o6Q==
X-Gm-Message-State: ANoB5pkmWQAYTfmUQvhBVTf6S+K9nggKbGfjcJgZ5RtwlYHhY/eA9XZa
        MTZot1YC3UP5ihFMFGioa9nkJA==
X-Google-Smtp-Source: AA0mqf6i68QB542uMSj8JGp5LTdvqzXHyOfwe+Ko1FvCgTDRRoNz6WIBYhEjEASqQscI22Pu3nbxuw==
X-Received: by 2002:a17:902:aa93:b0:17c:892e:7c8e with SMTP id d19-20020a170902aa9300b0017c892e7c8emr4657705plr.92.1668722816081;
        Thu, 17 Nov 2022 14:06:56 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y15-20020aa79aef000000b00565cbad9616sm1659213pfp.6.2022.11.17.14.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:06:55 -0800 (PST)
Date:   Thu, 17 Nov 2022 14:06:54 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc:     Pedro Falcato <pedro.falcato@gmail.com>,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>,
        sam@gentoo.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, Rich Felker <dalias@libc.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Attaching userspace VM to kernel thread (was Re: [PATCH]
 fs/binfmt_elf: Fix memsz > filesz handling)
Message-ID: <202211171402.95121B3FD4@keescook>
References: <20221106021657.1145519-1-pedro.falcato@gmail.com>
 <202211061948.46D3F78@keescook>
 <CABVgOSm9V37KgiP-eHxfYF4tTT+ZDQKVxEAzh8P0SH3WrECM9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSm9V37KgiP-eHxfYF4tTT+ZDQKVxEAzh8P0SH3WrECM9A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This has diverged from the original topic a bit, so I've changed the
Subject to hopefully gain visibility. :)

For KUnit, it would be REALLY nice to have a way to attach a userspace
VM to a kernel thread so we can do userspace memory mapping
manipulation, etc. Neither David nor I have been able to figure out the
right set of steps to make this happen. What are we missing?

Details below...

On Wed, Nov 16, 2022 at 12:34:40PM +0800, David Gow wrote:
> On Mon, Nov 7, 2022 at 11:59 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Sun, Nov 06, 2022 at 02:16:57AM +0000, Pedro Falcato wrote:
> > David, has there been any work on adding a way to instantiate
> > userspace VMAs in a KUnit test? I tried to write this myself, but I
> > couldn't figure out how to make the userspace memory mappings appear.
> > Here's my fumbling attempt:
> > https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=devel/kunit/usercopy
> >
> > I really wish KUnit had userspace mapping support -- I have a bunch of
> > unit tests that need to get built up around checking for regressions
> > here, etc.
> 
> Hi Kees,
> 
> Sorry the the delayed response!
> 
> Alas, my attempts to get this to work haven't been much more
> successful than yours. It's definitely something we'd like to support,
> but I confess to not knowing enough about the mm code to know exactly
> what would be involved.
> 
> The workaround is to load tests as modules, and use something like
> Vitor's original patch here:
> https://lore.kernel.org/all/20200721174036.71072-1-vitor@massaru.org/
> 
> Basically, using the existing mm of the module loader. Adapting those
> changes to your branch (and fixing a couple of back-to-front KUnit
> assertions) does work for me when built as a module, in an x86_64 vm:
> 
> root@slicestar:~# modprobe usercopy_kunit
> [   52.986290]     # Subtest: usercopy
> [   52.986701]     1..1
> [   53.246058]     ok 1 - usercopy_test
> [   53.246628] ok 1 - usercopy
> 
> But getting it to work with built-in tests hasn't been successful so
> far. I wondered if we could just piggy-back on init_mm or similar, but
> that doesn't seem to work either.
> 
> So, in the short-term, this is only possible for modules. If that's
> useful enough, we can get Vitor's support patch (or something similar)
> in, and just mark any tests module-only (or have them skip if there's
> no mm). Because kunit.py only runs built-in tests, though, it's
> definitely less convenient.

Thanks for any pointers! :)

-Kees

-- 
Kees Cook
