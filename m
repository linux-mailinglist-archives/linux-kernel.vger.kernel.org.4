Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB3B747974
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 23:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjGDVPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 17:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGDVP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 17:15:29 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA5DCE5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 14:15:26 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 364LF9aC021868;
        Tue, 4 Jul 2023 23:15:09 +0200
Date:   Tue, 4 Jul 2023 23:15:09 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Overly aggressive .gitignore file?
Message-ID: <20230704211509.GA21834@1wt.eu>
References: <CAHk-=wiJHMje8cpiTajqrLrM23wZK0SWetuK1Bd67c0OGM_BzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiJHMje8cpiTajqrLrM23wZK0SWetuK1Bd67c0OGM_BzQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 12:49:01PM -0700, Linus Torvalds wrote:
> So this keeps happening to me - I go to apply a patch I just
> downloaded with 'b4', and I do my regular
> 
>      git am -s --whitespace 2023<tab>
> 
> and the dang thing doesn't autocomplete.,
> 
> The reason it doesn't auto-complete ends up being that my kernel tree
> contains some other random stale mbx file from the _previous_ time I
> did that, because they effectively get hidden from "git status" etc by
> our .gitignore file.
> 
> So then those stale files end up staying around much too long and not
> showing up on my radar even though they are just old garbage by the
> time I have actually applied them.
> 
> And I always use auto-complete, because those filenames that 'b4'
> generate are ridiculously long (for good reason).
> 
> And the auto-complete always fails, because b4 just uses a common
> prefix pattern too (again, for a perfectly good reason - I'm not
> complaining about b4 here).
> 
> This has been a slight annoyance for a while, but the last time it
> happened just a moment ago when I applied David Howells' afs patch
> (commit 03275585cabd: "afs: Fix accidental truncation when storing
> data" - not that the particular commit matters, I'm just pointing out
> how it just happened _again_).
> 
> So I'm really inclined to just revert the commit that added this
> pattern: 534066a983df (".gitignore: ignore *.cover and *.mbx"). It's
> actively detrimental to my workflow.

I don't understand why your completion on "git am" should rely on
*tracked* files. From a workflow perspective that makes no sense,
as by definition, git am will consume only *untracked* files. Are
you sure there isn't something wrong elsewhere in your completion
rules, that would make your "git am" complete only with tracked
files ? Most likely it should use a rule very similar to what
"git add" uses.

Just my two cents,
Willy
