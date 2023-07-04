Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4272747A10
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 00:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjGDWOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 18:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjGDWOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 18:14:32 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4019B10C8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 15:14:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9939fbb7191so16732066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 15:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688508869; x=1691100869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IcGCOea3YEKw3Z0BdC3JX6yVfvpjQ2aXU5gSorSGoSk=;
        b=KkPcn2HAvJTcRtU26+KnV1CBWodWaWyh0/vwH5oFdhFfhAzIhWqwDGo3NFmFU5eW0+
         C8LHUKpZOaB34xjDX+a4TmO3/N7YdgzpaaoOBj0gDv8jsMGbPwPhM/TCAQKANnQfUqMn
         47ZmBJVRctATktYDZoFSloiVwijwjc3BR/GDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688508869; x=1691100869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IcGCOea3YEKw3Z0BdC3JX6yVfvpjQ2aXU5gSorSGoSk=;
        b=iq44ia38mzGv8x7NAzBUyObzCBt0J2x22wejEbBaSvCvMgsH7UbusrsoxNuQzoSX4o
         JVIcpZ8wvokS/brKsZV42D5KkLR+UUzpGsNTafI3vM8jh9XQERU+3s4TjznlKkREMkVN
         PtW8FIhLLhaPW8GyvKNBeAGsfp0J/LH08XotiQShfqRMaC6Vx65coDTaffA7wmreGpZL
         S/QKZxmrx4bjSlQrKcBRUnylLUQFRehmoXZK29p7FR23VTFCvvEnJhm3Ris0ZGupdoDU
         eLNqaFe6U2NtDCF+1rnKBqxpo5Fd8jTI0Pl2aqXW4Mg+V627MHpgbs4bOHVBJV1f7/O7
         t2yg==
X-Gm-Message-State: ABy/qLbXmUYpnZDXJlM3MuVcj4GyAW7SO3M2P5IXfjXpmQJItljuCyYI
        KXd7hMN0c5Uiu5MX0a9U9Uh9l9kd45NQK+NiV0p35j6K
X-Google-Smtp-Source: APBJJlEbvM6pLL2lKLpV09D4WRlwqjMir0enh8OoSACMF4kvoRRe7fhiIO9KLygRLm3kQxASf9yXcg==
X-Received: by 2002:a17:907:86a3:b0:982:a022:a540 with SMTP id qa35-20020a17090786a300b00982a022a540mr493775ejc.11.1688508869662;
        Tue, 04 Jul 2023 15:14:29 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id b7-20020a170906660700b009935aba3a9dsm3932732ejp.48.2023.07.04.15.14.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 15:14:29 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so204961a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 15:14:28 -0700 (PDT)
X-Received: by 2002:a05:6402:2547:b0:51a:4039:b9e with SMTP id
 l7-20020a056402254700b0051a40390b9emr468288edb.9.1688508868151; Tue, 04 Jul
 2023 15:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiJHMje8cpiTajqrLrM23wZK0SWetuK1Bd67c0OGM_BzQ@mail.gmail.com>
 <20230704211509.GA21834@1wt.eu> <CAHk-=wjH4O6v_EwVB=t_6Haky2jOiejHbCkCTvgNQWo1ghy8-w@mail.gmail.com>
 <20230704213415.GA21872@1wt.eu> <CAHk-=wjPEjrB7eCukREhWu-0qfjbFD-K8sk1TYYRgeHzYr1tuQ@mail.gmail.com>
 <20230704215600.GA22271@1wt.eu>
In-Reply-To: <20230704215600.GA22271@1wt.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jul 2023 15:14:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whMytacPBHfKKi8GYdgfadNy5LA-1TDHrTtz22eJr2B1Q@mail.gmail.com>
Message-ID: <CAHk-=whMytacPBHfKKi8GYdgfadNy5LA-1TDHrTtz22eJr2B1Q@mail.gmail.com>
Subject: Re: Overly aggressive .gitignore file?
To:     Willy Tarreau <w@1wt.eu>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 at 14:56, Willy Tarreau <w@1wt.eu> wrote:
>
> This point I perfectly understand, but there's also this "ls" command
> that lists file names starting with 2023-* if required.

You know what? I'm done arguing with you.

Sure. I could also do "echo * | grep 2023" or something.

Or I could just remember every single mbx file I ever used.

Or maybe I could remember to just delete them immediately after using.

Or I could do any number of other things.

But what do you think "git status" is supposed to do?

Here's a theory - it's supposed to tell me about the status of my git tree.

Maybe it's supposed to tell me about extra files that maybe I should
be aware of. Maybe I should delete them. Maybe I should commit them.
Who knows?

Or maybe it's supposed to tell me that I've forgotten to push, or that
I have diffs I haven't committed.

All those things that are specific to having a git tree, that tools
like 'ls' simply don't know to do.

It's a crazy theory, I know. But just go with it, ok.

And  *if* we pretend for a moment that this is what "git status" is
supposed to do, then maybe it should have reminded me about stale
random files in that directory that ACTIVELY BREAK MY WORKFLOW.

Maybe that isn't your workflow.

Maybe you're perfectly fine not getting a unique auto-complete,
because you *want* your git directory filled with irrelevant crap.

Or maybe you just always do "ls" religiously and look for random files
in general, because  you are bored and it fills up that dead time.

But how about you just accept the fact that for some of us, the whole
point of 'git status" is to tell about these kinds of things, ok?

I'm now done. I have reverted that commit in my tree and pushed it
out, because while I was interested in hearing about any possible
other use for that overly aggressive gitignore entry, I'm not in the
least interested in you trying to teach me about esoteric tools like
'ls', or telling me that "unsuccessful auto-complete is still an
auto-complete".

              Linus
