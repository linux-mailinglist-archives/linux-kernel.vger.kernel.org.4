Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF1C62B25F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiKPEe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiKPEey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:34:54 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDD32E690
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 20:34:52 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id g16so7657774vkl.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 20:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FmxnDIRF3z4tVcQHy0ykyvRCfKyX9vqd9nq5zuayq/o=;
        b=EQyJmb5NzuW7Lrmx1UMxwNMSc7k121+UGTlaW+fgEO57T29KUzUO0pmfXzmd8y6CEX
         Jb3QyrZ9WjcPq86aZ8yqUrw5KQDgEPoG8QhlKNlUADgwOfATxqgKrEr6LqoSYsM6st9F
         1YVMfFr3J7Rv1hNFVw7rtRRlXDXgV+gO7KxZyMIEDI6sDa0iQZA9CeGZkVRURnldsycn
         9zWJcqg8TV3Eq/6Y3L/D5LnkBqDr1ilu/BIrAUOpJgd28mtis4ijip0tlVxLeNAe1btT
         jTuwD3azfLPaYk1AtMV8e2lR0u5IFvrMzqMbVXeMNWV2jztW9hZGf3dGowpd6wgudenl
         3RWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmxnDIRF3z4tVcQHy0ykyvRCfKyX9vqd9nq5zuayq/o=;
        b=SV0h7Qe5ILxa4S/UU1Srxs0fF5MlTJbzFn4ecctqGmDibQoRPO5axCoI2NoAGNtIdd
         HYb1BRjo4S4kB8fKNUMRMUAUMh3z9Mlo0NyAMp6QLfUyk1oERoC+4tq6z18bmKsvDI79
         YYpotIh5D8WIo8kf/JVwMx1ZSheI5knlL9V9paOekA4NpBWLo7DYjBLmvLq/tVaDQPax
         MkzagTA8wa7apxTpnNKi7j1xih3dzYKqYGizdMXFmX+0iOPcKDekyeAje36z+vEgSaJl
         RN6OE0iE6KCpcoICootkXaD0st4jWalMgEFJokbdZQfaWiQqym9jYzv5vYUXXhB8Ih/k
         Qnhw==
X-Gm-Message-State: ANoB5pmiYiMlaOUouepLM/Mlaj47qDuGO8q2vtlD754Y+YxtIPGV4Ss+
        iyQpfl57uokL1TFFaJsOZnqu4PmaqqIq8ft3Z8D0cg==
X-Google-Smtp-Source: AA0mqf71S572lwU6nUh1KCBE2iEeZgtF1t/Kg31iPNqx35YME43NQlTnmOzGQHbpzsQxj91vADhe3iC/FCPOG1OhHDc=
X-Received: by 2002:a05:6122:d06:b0:3bb:d1fb:15f2 with SMTP id
 az6-20020a0561220d0600b003bbd1fb15f2mr11898407vkb.37.1668573291838; Tue, 15
 Nov 2022 20:34:51 -0800 (PST)
MIME-Version: 1.0
References: <20221106021657.1145519-1-pedro.falcato@gmail.com> <202211061948.46D3F78@keescook>
In-Reply-To: <202211061948.46D3F78@keescook>
From:   David Gow <davidgow@google.com>
Date:   Wed, 16 Nov 2022 12:34:40 +0800
Message-ID: <CABVgOSm9V37KgiP-eHxfYF4tTT+ZDQKVxEAzh8P0SH3WrECM9A@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf: Fix memsz > filesz handling
To:     Kees Cook <keescook@chromium.org>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, sam@gentoo.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, Rich Felker <dalias@libc.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 11:59 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Sun, Nov 06, 2022 at 02:16:57AM +0000, Pedro Falcato wrote:
> David, has there been any work on adding a way to instantiate
> userspace VMAs in a KUnit test? I tried to write this myself, but I
> couldn't figure out how to make the userspace memory mappings appear.
> Here's my fumbling attempt:
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=devel/kunit/usercopy
>
> I really wish KUnit had userspace mapping support -- I have a bunch of
> unit tests that need to get built up around checking for regressions
> here, etc.

Hi Kees,

Sorry the the delayed response!

Alas, my attempts to get this to work haven't been much more
successful than yours. It's definitely something we'd like to support,
but I confess to not knowing enough about the mm code to know exactly
what would be involved.

The workaround is to load tests as modules, and use something like
Vitor's original patch here:
https://lore.kernel.org/all/20200721174036.71072-1-vitor@massaru.org/

Basically, using the existing mm of the module loader. Adapting those
changes to your branch (and fixing a couple of back-to-front KUnit
assertions) does work for me when built as a module, in an x86_64 vm:

root@slicestar:~# modprobe usercopy_kunit
[   52.986290]     # Subtest: usercopy
[   52.986701]     1..1
[   53.246058]     ok 1 - usercopy_test
[   53.246628] ok 1 - usercopy

But getting it to work with built-in tests hasn't been successful so
far. I wondered if we could just piggy-back on init_mm or similar, but
that doesn't seem to work either.

So, in the short-term, this is only possible for modules. If that's
useful enough, we can get Vitor's support patch (or something similar)
in, and just mark any tests module-only (or have them skip if there's
no mm). Because kunit.py only runs built-in tests, though, it's
definitely less convenient.

Cheers,
-- David
