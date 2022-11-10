Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB20624894
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiKJRsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKJRsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:48:33 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5C4B7E0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:48:31 -0800 (PST)
Date:   Thu, 10 Nov 2022 17:48:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skothe.de;
        s=protonmail; t=1668102508; x=1668361708;
        bh=jREI8kgsv+Ac+JI7HxX8UFFBUU8DxYtXvRHvFerAf7o=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=H5jzGUa4HQyLu6QpNeuoqlXwRtZhPI6Op0YxmjDEp0m0QXC+CUuZ2BSTFVc9GMTCH
         vL+p0tKEmArLC9N08ioCGN4/xqGjdf8g0Fy8qyfNcCbcRZ75LetG31jX8MaINqntfw
         awav3RCKcm/hmZVp3XENnqHNkIm3LAeMD0aLB/OZADNBDA2NSzCdP4LzC7Z5XZkCO8
         FSEjnszKgMaY+h5LKlSOiwoy6K6CXzOebdWVoT5y+xAMVpt36IHsdVLtLgyBHXWrJU
         meF6vRQl+yJVILkYezM5hxecW7ITpaTCvo6PbVbp6NNmQdegECl4n7p07WcGDNo276
         aDKgEscg8EX7w==
To:     Saravana Kannan <saravanak@google.com>
From:   Steffen Kothe <steffen.kothe@skothe.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: dev-needs.sh: Enforce bash usage
Message-ID: <Y205W3kavB5tIDK3@p50>
In-Reply-To: <CAGETcx9fx3TcgeD+pMyp+LuGfd=hOo5_Weeii2W1Mbd1T2Ua0Q@mail.gmail.com>
References: <20221109170341.36785-1-steffen.kothe@skothe.de> <CAGETcx9fx3TcgeD+pMyp+LuGfd=hOo5_Weeii2W1Mbd1T2Ua0Q@mail.gmail.com>
Feedback-ID: 55345914:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, Nov 09, 2022 at 02:58:15PM -0800 schrieb Saravana Kannan:
> On Wed, Nov 9, 2022 at 9:04 AM Steffen Kothe <steffen.kothe@skothe.de> wr=
ote:
> >
> > Calling the script from a system which does not invoke bash
> > by default causes a return with a syntax error like:
> >
> >         ./dev-needs.sh: 6: Syntax error: "(" unexpected
> >
> > /bin/sh invokes on most distributions a symbolic link to a
> > default shell like dash (Debian) or bash (Ubuntu).
> >
> > Since the script depends on bash syntax, enforce the same by
> > default to prevent syntax errors caused by wrong shell type usage.
>
> I wrote this so that it can run on an Android target that runs toybox.
> Sadly toybox doesn't like have /bin/bash. This will break my use case.
> So I'll have to Nak this.

Ok, I see.

> I'm open to other ideas though as I'd like to this to work in as many
> cases as possible. Should we just add a wrapper that has /bin/bash and
> then sources this file?

I mean, we could leave at least a warning on top above the first
function via a simple echo.

Sth. like:

=09echo "Warning: $0 is only tested for following shell variants
=09      [toybox, bash]. Other shells might be not following the
=09      specific syntax of this script."

=09echo "Shell is: $(readlink /bin/sh)"

I would prevent to add another wrapper to it, because its fairly easy
to cp this file to a target. An embedded system with a pure POSIX compliant
shell will never be compatible to this kind of syntax.

What do you think about a more describing approach of the error instead
of handling it with some weird logic and wrapping?

Cheers,
=09skothe

> Also looks like multiple #! lines aren't supported by bash, so we
> can't add multiple lines either.
>
> -Saravana
>
> >
> > Signed-off-by: Steffen Kothe <steffen.kothe@skothe.de>
> > ---
> >  scripts/dev-needs.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/dev-needs.sh b/scripts/dev-needs.sh
> > index 454cc304fb448..46537859727bc 100755
> > --- a/scripts/dev-needs.sh
> > +++ b/scripts/dev-needs.sh
> > @@ -1,4 +1,4 @@
> > -#! /bin/sh
> > +#! /bin/bash
> >  # SPDX-License-Identifier: GPL-2.0
> >  # Copyright (c) 2020, Google LLC. All rights reserved.
> >  # Author: Saravana Kannan <saravanak@google.com>
> > --
> > 2.30.2
> >
> >

--
Cheers,
=09Steffen

