Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E426626890
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 10:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiKLJla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 04:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKLJl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 04:41:29 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8648E1CB12
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 01:41:27 -0800 (PST)
Date:   Sat, 12 Nov 2022 09:41:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skothe.de;
        s=protonmail; t=1668246085; x=1668505285;
        bh=GnKW/1y0vIT38DY810j9vefH6BQw73stCXN3unEcMok=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=XaHynQY4K+X+dNMsKhNsVIfSRNvo6VAW63XxgmZXwnfOEUMjI6sPAC37EntEE8ndl
         QTHpXWvZSLi8dKRHDS17ONp0lvimYQewdotu89DFGfH1+akbo8lPPpBB371jBk5soL
         rOqP9u9TReUYCB2JPe+WmKDWR2kexf27a+hrWnPMgQ1yL2rIpQoECzgKCvKzaJi8Ed
         cb0v/uKl3Vyog4KMK7dHtyCNw4bJeucpNe9BCvOVCCgdWQFAd9MfMktzmgnWZsn7eY
         gUqEWQizYOnYzr31Ots0vgaT5tET3ijguZKIgBPXLszWB/oFidNYkXvpW/7cnfxbr+
         LZ9I8+hQ3yQPA==
To:     Saravana Kannan <saravanak@google.com>
From:   Steffen Kothe <steffen.kothe@skothe.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: dev-needs.sh: Enforce bash usage
Message-ID: <Y29qN1fFq4SFXCT2@p50>
In-Reply-To: <CAGETcx9Z2_Oc-L8Y0x+zuPUEgeaDSnFSFUSU+nxcF5Rxtf6FvQ@mail.gmail.com>
References: <20221109170341.36785-1-steffen.kothe@skothe.de> <CAGETcx9fx3TcgeD+pMyp+LuGfd=hOo5_Weeii2W1Mbd1T2Ua0Q@mail.gmail.com> <Y205W3kavB5tIDK3@p50> <CAGETcx9Z2_Oc-L8Y0x+zuPUEgeaDSnFSFUSU+nxcF5Rxtf6FvQ@mail.gmail.com>
Feedback-ID: 55345914:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, Nov 10, 2022 at 11:32:12AM -0800 schrieb Saravana Kannan:
> On Thu, Nov 10, 2022 at 9:48 AM Steffen Kothe <steffen.kothe@skothe.de> w=
rote:
> >
> > Am Wed, Nov 09, 2022 at 02:58:15PM -0800 schrieb Saravana Kannan:
> > > On Wed, Nov 9, 2022 at 9:04 AM Steffen Kothe <steffen.kothe@skothe.de=
> wrote:
> > > >
> > > > Calling the script from a system which does not invoke bash
> > > > by default causes a return with a syntax error like:
> > > >
> > > >         ./dev-needs.sh: 6: Syntax error: "(" unexpected
> > > >
> > > > /bin/sh invokes on most distributions a symbolic link to a
> > > > default shell like dash (Debian) or bash (Ubuntu).
> > > >
> > > > Since the script depends on bash syntax, enforce the same by
> > > > default to prevent syntax errors caused by wrong shell type usage.
> > >
> > > I wrote this so that it can run on an Android target that runs toybox=
.
> > > Sadly toybox doesn't like have /bin/bash. This will break my use case=
.
> > > So I'll have to Nak this.
> >
> > Ok, I see.
> >
> > > I'm open to other ideas though as I'd like to this to work in as many
> > > cases as possible. Should we just add a wrapper that has /bin/bash an=
d
> > > then sources this file?
> >
> > I mean, we could leave at least a warning on top above the first
> > function via a simple echo.
> >
> > Sth. like:
> >
> >         echo "Warning: $0 is only tested for following shell variants
> >               [toybox, bash]. Other shells might be not following the
> >               specific syntax of this script."
> >
> >         echo "Shell is: $(readlink /bin/sh)"
> >
> > I would prevent to add another wrapper to it, because its fairly easy
> > to cp this file to a target. An embedded system with a pure POSIX compl=
iant
> > shell will never be compatible to this kind of syntax.
> >
> > What do you think about a more describing approach of the error instead
> > of handling it with some weird logic and wrapping?
>
> Are you suggesting we check for the shell being toybox/bash and then
> printing this? Always printing it isn't nice because it'll mess up all
> the script that expect the output to be just what it is today.
>
> But if you want to add an error check, I'm okay with that.

What about a re-write of the script in POSIX compliant style? This
should work then in every shell derivate without weird checks.

This would remove for example function declarations, arrays and so on,
targeting to the same printable output but with different logic in the
background.

> -Saravana
>
> >
> > Cheers,
> >         skothe
> >
> > > Also looks like multiple #! lines aren't supported by bash, so we
> > > can't add multiple lines either.
> > >
> > > -Saravana
> > >
> > > >
> > > > Signed-off-by: Steffen Kothe <steffen.kothe@skothe.de>
> > > > ---
> > > >  scripts/dev-needs.sh | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/scripts/dev-needs.sh b/scripts/dev-needs.sh
> > > > index 454cc304fb448..46537859727bc 100755
> > > > --- a/scripts/dev-needs.sh
> > > > +++ b/scripts/dev-needs.sh
> > > > @@ -1,4 +1,4 @@
> > > > -#! /bin/sh
> > > > +#! /bin/bash
> > > >  # SPDX-License-Identifier: GPL-2.0
> > > >  # Copyright (c) 2020, Google LLC. All rights reserved.
> > > >  # Author: Saravana Kannan <saravanak@google.com>
> > > > --
> > > > 2.30.2
> > > >
> > > >
> >
> > --
> > Cheers,
> >         Steffen
> >

--
Cheers,
=09Steffen

