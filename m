Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F4D7479BB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 23:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjGDV4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 17:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjGDV4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 17:56:09 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 813DC127;
        Tue,  4 Jul 2023 14:56:08 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 364Lu0D0022282;
        Tue, 4 Jul 2023 23:56:00 +0200
Date:   Tue, 4 Jul 2023 23:56:00 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Overly aggressive .gitignore file?
Message-ID: <20230704215600.GA22271@1wt.eu>
References: <CAHk-=wiJHMje8cpiTajqrLrM23wZK0SWetuK1Bd67c0OGM_BzQ@mail.gmail.com>
 <20230704211509.GA21834@1wt.eu>
 <CAHk-=wjH4O6v_EwVB=t_6Haky2jOiejHbCkCTvgNQWo1ghy8-w@mail.gmail.com>
 <20230704213415.GA21872@1wt.eu>
 <CAHk-=wjPEjrB7eCukREhWu-0qfjbFD-K8sk1TYYRgeHzYr1tuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjPEjrB7eCukREhWu-0qfjbFD-K8sk1TYYRgeHzYr1tuQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 02:44:47PM -0700, Linus Torvalds wrote:
> On Tue, 4 Jul 2023 at 14:34, Willy Tarreau <w@1wt.eu> wrote:
> >
> > But the git am completion rules should actually *not* rely on
> > git status output. At least in my opinion.
> 
> Christ, Willy.
> 
> Where did I talk about git am completion rules?
> 
> b4 am DOES THE RIGHT THING.
> 
> Completion DOES THE RIGHT THING.
> 
> THOSE STUPID HISTORICAL TURDS IS THE PROBLEM.
> 
> And the reason those turds exist? Because I don't notice, BECAUSE GIT
> STATUS DOESN'T TELL ME!
> 
> > Here I pressed [Tab] after "2023" and it automatically completed.
> 
> Go back and READ THE EMAIL ALREADY.

I did again and again. You said:

  So this keeps happening to me - I go to apply a patch I just
  downloaded with 'b4', and I do my regular
 
       git am -s --whitespace 2023<tab>
 
  and the dang thing doesn't autocomplete.,

So for me what this means is that when you press <tab>, nothing happens.

When I do press tab, in the exact same situation, I'm presented with the
list of matching files.

> Let me quote the relevant part again:
> 
> ** The reason it doesn't auto-complete ends up being that my kernel tree
> ** contains some other random stale mbx file from the _previous_ time I
> ** did that, because they effectively get hidden from "git status" etc by
> ** our .gitignore file.
> 
> so go and create an OLD STALE TURD that *ALSO* has that 2023-xyz name,
> and now try again.
> 
> Notice how auto-completion doesn't work, because there are now
> *multiple* files beginning with the same filename.

Then maybe we don't have the same definition for "auto-completion".
For me auto-completion presents me with a list of matches that I can
pick from, and when it doesn't work, I press <tab> and am presented
with nothing, typically something which happens when programmable
completion is involve and doesn't find any match.

> Auto-completion isn't smart enough to know "oh, he already committed
> that old mbox file and I should ignore it".
> 
> And _I_ didn't notice until auto-complete failed, because our
> ".gitignore" file told all the infrastructure to - wait for it -
> ignore that file.
> 
> So "git status" at no point gave me that helpful

This point I perfectly understand, but there's also this "ls" command
that lists file names starting with 2023-* if required. I mean, there's
even nothing that requires that the mbox files are whithin the git repo
itself, they could very well come from /tmp and you wouldn't use git
status there.

The value I'm seeing in what you're looking for is to quickly detect
that there remain these old turds in the directory (and possibly
remove them all at once). But that should not be relevant to the
auto-completion if we have the same definition of it.

>    Untracked files:
>      (use "git add <file>..." to include in what will be committed)
>    2023xyzzy.mbx
> 
> output to let me know that "Oh, btw, you have that old turd in your tree".
> 
> Please. Read the email.

I did, for the 3rd time. I understood that you have a collection of
old ".mbx" files in your directory and that when you start typing
"git am 2023-<tab>" it proposes nothing, and that you say it's due
to the .gitignore that ignores .mbx files. And I maintain that if
it's the case the .gitignore should not be related to *this*, but
only to the fact that they're not listed to you in "git status".

Willy
