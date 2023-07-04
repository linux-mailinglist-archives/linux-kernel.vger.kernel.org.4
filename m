Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E3A74799C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 23:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjGDVe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 17:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjGDVeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 17:34:24 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1215FE4F;
        Tue,  4 Jul 2023 14:34:22 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 364LYFqi022233;
        Tue, 4 Jul 2023 23:34:15 +0200
Date:   Tue, 4 Jul 2023 23:34:15 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Overly aggressive .gitignore file?
Message-ID: <20230704213415.GA21872@1wt.eu>
References: <CAHk-=wiJHMje8cpiTajqrLrM23wZK0SWetuK1Bd67c0OGM_BzQ@mail.gmail.com>
 <20230704211509.GA21834@1wt.eu>
 <CAHk-=wjH4O6v_EwVB=t_6Haky2jOiejHbCkCTvgNQWo1ghy8-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjH4O6v_EwVB=t_6Haky2jOiejHbCkCTvgNQWo1ghy8-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 02:20:36PM -0700, Linus Torvalds wrote:
> On Tue, 4 Jul 2023 at 14:15, Willy Tarreau <w@1wt.eu> wrote:
> >
> > I don't understand why your completion on "git am" should rely on
> > *tracked* files.
> 
> It doesn't.
> 
> Read that email again.
> 
> It fails on *untracked* files that are hidden from "git status" and
> friends by our .gitignore pattern:
> 
>    *.mbx
> 
> added by commit 534066a983df (".gitignore: ignore *.cover and *.mbx")
> 
> So when I have those old stale mbx files around, I don't see them,
> because "git status" will happily say
> 
>     nothing to commit, working tree clean
> 
> with no mention of those old turds.

But the git am completion rules should actually *not* rely on
git status output. At least in my opinion.

> Really. Try it.

I did and for me on this machine I don't have the problem:

  willy@pcw:~/linux$ git status
  On branch 20230702-nolibc-series1+2_2
  Your branch is up to date with 'origin/20230702-nolibc-series1+2_2'.
  
  nothing to commit, working tree clean
  willy@pcw:~/linux$ echo blah > 2023-new-patch.mbx 
  willy@pcw:~/linux$ git status
  On branch 20230702-nolibc-series1+2_2
  Your branch is up to date with 'origin/20230702-nolibc-series1+2_2'.
  
=> .mbx is indeed ignored

  nothing to commit, working tree clean
  willy@pcw:~/linux$ git am -s --whitespace 2023-new-patch.mbx
  ^C

Here I pressed [Tab] after "2023" and it automatically completed.
By git completion is certainly quite old, as I really don't change
it often once I have a satisfying one. My git-completion.bash script
has this in case that helps:

  _git_am ()
  {
          __git_find_repo_path
          if [ -d "$__git_repo_path"/rebase-apply ]; then
                  __gitcomp "$__git_am_inprogress_options"
                  return
          fi
          case "$cur" in
          --whitespace=*)
                  __gitcomp "$__git_whitespacelist" "" "${cur##--whitespace=}"
                  return
                  ;;
          --*)
                  __gitcomp_builtin am "--no-utf8" \
                          "$__git_am_inprogress_options"
                  return
          esac
  }

> > From a workflow perspective that makes no sense,
> > as by definition, git am will consume only *untracked* files.
> 
> I don't think you actually read my email.

Yes I did and I neither experience your problem nor figure why it
should happen, because I don't see the relation between gitignore
and anything that git am should be allowed to consume :-/

Willy
