Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E2E7413C4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjF1OVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:21:46 -0400
Received: from mail.avm.de ([212.42.244.120]:57488 "EHLO mail.avm.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231929AbjF1OU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:20:27 -0400
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Wed, 28 Jun 2023 16:20:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1687962025; bh=bPDxZSX5AGRWE//qyJ05XWKBdUJXjjjaprO229FFQE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X1xMyfo0ASe/oBNmPwaajR3/PUBuBdKuHuN7p10YbZQAudOlDJg+MH4WFE4Z9uyr9
         MQDVx1TyUQVwvclTmkQnd+sPkN0VIO8IFAfp9b32hTN2D6uDazwic757HGgt81pFa6
         pegcpxY6Gs+e1LDc3THwpYIJF1g5HFS5/tTbjw4k=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id 4FF3B80AC0;
        Wed, 28 Jun 2023 16:20:25 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 45038181EF4; Wed, 28 Jun 2023 16:20:25 +0200 (CEST)
Date:   Wed, 28 Jun 2023 16:20:25 +0200
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v4 3/3] kbuild: respect GNU Make -w flag
Message-ID: <ZJxBqYdSxWknb/+v@buildd.core.avm.de>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20230626233014.66549-1-masahiroy@kernel.org>
 <20230626233014.66549-3-masahiroy@kernel.org>
 <CAK7LNATtUBZo0bczb=bQyQ6UrXbK7V4Bp058+wzZQp3QREfniQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATtUBZo0bczb=bQyQ6UrXbK7V4Bp058+wzZQp3QREfniQ@mail.gmail.com>
X-purgate-ID: 149429::1687962024-5C6A3FC0-470BA280/0/0
X-purgate-type: clean
X-purgate-size: 2939
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 04:09:44PM +0900, Masahiro Yamada wrote:
> On Tue, Jun 27, 2023 at 8:30 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Currently, -w (--print-directory) option is ignored, but it is better
> > to respect the user's choice.
> >
> > This commit changes the behavior of "Entering directory ..." logging.
> >
> > If -w (or --print-directory) is given via the command line or the
> > MAKEFLAGS environment variable, print "Entering directory ..." for every
> > sub make.
> >
> > If --no-print-directory is given via the command line or the MAKEFLAGS
> > environment variable, suppress "Entering directory ..." completely.
> >
> > If none of them is given, print "Entering directory ..." when Kbuild
> > changes the working directory at the start of building. (default)
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > Tested-by: Nicolas Schier <n.schier@avm.de>
> > ---
> 
> 
> As it turns out, this patch does not work for GNU Make <= 4.3

Ups, I'm sorry.  I was pretty sure I tested it with make-4.3, but
obviously not...

Kind regards,
Nicolas



> I will drop (and give up) this patch.
> 
> 
> 
> 
> 
> 
> >
> > (no changes since v2)
> >
> > Changes in v2:
> >   - new patch
> >
> >  Makefile | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 7edb00603b7e..c9864f83a3d2 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -38,6 +38,12 @@ __all:
> >  # descending is started. They are now explicitly listed as the
> >  # prepare rule.
> >
> > +ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> > +short-opts := $(firstword -$(MAKEFLAGS))
> > +else
> > +short-opts := $(filter-out --%,$(MAKEFLAGS))
> > +endif
> > +
> >  this-makefile := $(lastword $(MAKEFILE_LIST))
> >  export abs_srctree := $(realpath $(dir $(this-makefile)))
> >  export abs_objtree := $(CURDIR)
> > @@ -95,12 +101,6 @@ endif
> >  # commands
> >  # make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
> >
> > -ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> > -short-opts := $(firstword -$(MAKEFLAGS))
> > -else
> > -short-opts := $(filter-out --%,$(MAKEFLAGS))
> > -endif
> > -
> >  ifneq ($(findstring s,$(short-opts)),)
> >  quiet=silent_
> >  override KBUILD_VERBOSE :=
> > @@ -215,12 +215,16 @@ else
> >  need-sub-make := 1
> >  endif
> >
> > +ifeq ($(findstring w, $(short-opts)),)
> >  ifeq ($(filter --no-print-directory, $(MAKEFLAGS)),)
> >  # If --no-print-directory is unset, recurse once again to set it.
> >  # You may end up recursing into __sub-make twice. This is needed due to the
> >  # behavior change in GNU Make 4.4.1.
> >  need-sub-make := 1
> >  endif
> > +else
> > +no-print-directory :=
> > +endif
> >
> >  ifeq ($(need-sub-make),1)
> >
> > --
> > 2.39.2
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
