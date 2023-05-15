Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E6D703179
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242355AbjEOPX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242210AbjEOPX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:23:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B32EAF;
        Mon, 15 May 2023 08:23:54 -0700 (PDT)
Date:   Mon, 15 May 2023 17:23:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684164232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z0Yfh3NxQgNMgOMFGMNP1V605BZVqvLuCh2pQvBjFFM=;
        b=NAUC94ahcxOjuc2bNlocmLdLRNTvEElhcKs8DE6m8zLU8Dqh7enlo9eZ2omq2eH0+e0PwA
        iMKJpOKqvSaCUR+hjwheDx0ub1YrnjY084OpeWYpMYQuyJ/26PqTLakcZb5Cbzh8gvRnTz
        mX2+Y5DomVS0TLC5+D2XZOYiUqyGX2VN6K/HmpxpimxOZa/vPAWH9gsgs+KIQRswm+EdXF
        MyCwC6dGgy6VCvn+6CqjadnAeqKdcBX4IVvAQt6YG257PAr1UoGOvaMfmLe9Z66Uwn5X8R
        WRgWUlWQ3Dk2UENBOaYevrrGZtEBtjTu1TLaUtthGIoE+MWo7tA2BY9TFuWdtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684164232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z0Yfh3NxQgNMgOMFGMNP1V605BZVqvLuCh2pQvBjFFM=;
        b=wZQt75odboxL5DTQ2eTXyVWuRZ+wtqsFBO7FywTJQiQ8c/wb6+4I0ZJcz++EaUigkwOlFI
        rOHVx2wr0RiO6DAA==
From:   "Ahmed S. Darwish" <darwi@linutronix.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] scripts/tags.sh: Resolve gtags empty index
 generation
Message-ID: <ZGJOht09HwRY7GK+@lx-t490>
References: <20230504201833.202494-1-darwi@linutronix.de>
 <20230509012616.81579-1-darwi@linutronix.de>
 <20230509012616.81579-2-darwi@linutronix.de>
 <CAK7LNARO6HOutPf2VZJMTR2Xmepj_3UiUgH-SLXhH57CNnGfOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARO6HOutPf2VZJMTR2Xmepj_3UiUgH-SLXhH57CNnGfOg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023, Masahiro Yamada wrote:
>
> The code works as claimed, but I am just curious.

Thanks.

> If all the paths are relative, how can you use the tags files located
> in a separate directory?
>
> "make O=foo gtags" creates tags files in foo/.
> I want to use them from emacs.
> emacs cannot find the right file because
> it assumes the path is relative to 'foo' instead of the source tree.
>

Correct.

In theory, since all the indexed linux source tree paths at the gtags
generated files (GPATH/GRTAGS/GTAGS) are relative to the linux source
tree root, opening such files from emacs ggtags-mode, *wherever* these
files are, "should" work.

In practice, ggtags/global (and thus also emacs ggtags-mode) operate
with a model of the world where all indexed files must be under the
source "root directory". So, the GPATH/GRTAGS/GTAGS files are expected
to be under the source tree (except in special GTAGSLIBPATH= cases).

> I set GTAGSROOT to the source tree, but I could not find a way
> to use it in a useful way.

Yes, that won't work, as emacs will search for the G* database files
under that folder instead.

Meanwhile setting GTAGSROOT to the O= directory, or to a build directory
that is different from the kernel source tree, as in:

  cd ~/linux
  O=~/build/build-linux-x86
  make O=$O x86_64_defconfig
  make O=$O gtags
  GTAGSROOT=$O emacs init/main.c

will "mostly" succeed (as you hinted at):

  M-x ggtags-mode

  # emacs finds gtags files under ${GTAGSROOT} and sets ${GTAGSROOT} as
  # the root of the project

  M-x ggtags-find-definition
  Definition: rcu_read_lock

    -*- mode: ggtags-global; default-directory: "~/build/build-linux-x86/" -*-
    Global started at Mon May 15 15:54:01

    global -v --result=grep --color=always --path-style=shorter -- rcu_read_lock
    include/linux/rcupdate.h:769:static __always_inline void rcu_read_lock(void)
    1 object located (using '/home/darwi/build/build-linux-x86/GTAGS').

    Global found 1 definition at Mon May 15 15:54:01

  # Prompt
  Find this match in (default include/linux/rcupdate.h)?: ~/build/build-linux-x86/
  ^^^

But at the Prompt step above, things break.

In a fully working setup, this prompt will not be shown and emacs just
jumps to rcuupdate.h line 769.

What I personally do to mitigate that problem is:

    cd ~/linux
    for f in GTAGS GRTAGS GPATH; do
        ln -vsf ${O}/$f .
    done

and switch these symlinks through minor local shell plumbing whenever
I'm switching kernel projects with different build directories.

It is not ideal, but maybe we can discuss this with the global(1) people
at a later step. At least with this patch series, "make O=xyz/ gtags"
produces a valid index.

>
> > +# gtags(1) refuses to index any file outside of its current working dir.
> > +# If gtags indexing is requested and the build output directory is not
> > +# the kernel source tree, index all files in absolute-path form.
> > +if [ "$1" = "gtags" -a -n "${tree}" ]; then
> > +       tree=$(realpath $tree)/
>
> I decided to run shellcheck for new code.
> Please follow the suggestion from the tool.
>
> In scripts/tags.sh line 40:
> tree=$(realpath $tree)/
>                         ^---^ SC2086 (info): Double quote to prevent
> globbing and word splitting.
>
> Did you mean:
> tree=$(realpath "$tree")/
>
> (You do not need to fix the entire script.
> This is only for new code).
>

Yes, the reason was to following the existing coding pattern at
scripts/tags.sh.  But, sure, will do.

>
> > @@ -131,7 +139,11 @@ docscope()
> >
> >  dogtags()
> >  {
> > -       all_target_sources | gtags -i -f -
> > +       local gtagsoutdir="${PWD}"
> > +       local gtagsroot="${tree}"
> > +
> > +       [ -z "${gtagsroot}" ] && gtagsroot="."
> > +       all_target_sources | gtags -i -C $gtagsroot -f - $gtagsoutdir
> >  }
>
> You can write it in one line.
>
> dogtags()
> {
>     all_target_sources | gtags -i -C "${tree:-.}" -f - "${PWD}"
> }
>

Ditto. The script was almost-fully POSIX style (except the first line),
so I avoided bash features on purpose.

I personlly always prefer using Bash features though, so I'll definitely
update the code.

Thanks a lot for the review. I'll send a v3.

--
Ahmed S. Darwish
Linutronix GmbH
