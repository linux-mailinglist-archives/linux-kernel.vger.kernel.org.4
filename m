Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA606BFFAC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 08:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCSHHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 03:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjCSHHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 03:07:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1492F1DBB7;
        Sun, 19 Mar 2023 00:07:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A680B80AB7;
        Sun, 19 Mar 2023 07:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3039DC433A1;
        Sun, 19 Mar 2023 07:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679209654;
        bh=x2ckgXe/VMFCve+dLKlMZh0Ge0RZ/3dY7M7VjjDQppE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=URTpQwqVogCvV5hSx2uHRW697PUb8o/h/EWJ0VVM7DF+V679H0EmNrV881g7fi813
         wy/tchTuZ85RMID1Qji5oBnePt7d6rJndv1G/8SKY5XVd1kxec5Ka8WxPfUcx3av9q
         MinYJ3IvI5JYWCSvXOMthbujtsH/j7KCFAih+j1DVXh8nK9N8uAhT8kvyLZ4IzKl3L
         WW0iWoQQvozEOqcMGZdJ8OhKQoItyrL7ZY3jxPQOqARhmZQsjCFt6koxmlnKZcqVKc
         K1+679QUVhcn8vUiTTWRxDbRBsCn8FgWNYCKHZ5MU//u1P6MBAM3m3PHM2dzPNDm14
         CpT3mvXPsP2WQ==
Received: by mail-oi1-f169.google.com with SMTP id bf30so155975oib.12;
        Sun, 19 Mar 2023 00:07:34 -0700 (PDT)
X-Gm-Message-State: AO0yUKXXu3+FYE9YRObh9RA00ng/+A0YfN3LHGXu6Pzmzzsbu7i5vrrP
        rJWrNI4H+1bxPYjERme0CknsmQwUrabwNkClTGU=
X-Google-Smtp-Source: AK7set/IW2HwWu4XbpjJXheXD0A+tFuVNATr9Qd/g+ckamdHEFZLqFbDavLn3QZTwo+JKDOIi3ehK9cuTpqpO7wUpzM=
X-Received: by 2002:a05:6808:295:b0:386:bb7a:5c85 with SMTP id
 z21-20020a056808029500b00386bb7a5c85mr3606346oic.11.1679209653393; Sun, 19
 Mar 2023 00:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNATXqPy6F+gB8-1Zqh8hooXh3U_5+3xeMFZDZwYsUi=aeg@mail.gmail.com>
 <20230312200731.599706-1-masahiroy@kernel.org> <20230319011217.147183-1-steev@kali.org>
 <CAK7LNATrzAWiu36=-JXXjSt48O12OAQG4ZAtLABd_PyiE2f_VQ@mail.gmail.com> <CAKXuJqjWORL0GmyOg9_NFUCjUH3Jd7yrNbTYpnQiTk7AptMZMw@mail.gmail.com>
In-Reply-To: <CAKXuJqjWORL0GmyOg9_NFUCjUH3Jd7yrNbTYpnQiTk7AptMZMw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 19 Mar 2023 16:06:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQKV9HD-ZJrqiHq5aGOmZZ=spgqM-Aw+X4hYuGF1Ntriw@mail.gmail.com>
Message-ID: <CAK7LNAQKV9HD-ZJrqiHq5aGOmZZ=spgqM-Aw+X4hYuGF1Ntriw@mail.gmail.com>
Subject: Re: [PATCH 0/6] kbuild: fix some packaging issues, and use
 git-archive for source package
To:     Steev Klimaszewski <steev@kali.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        terrelln@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 12:21=E2=80=AFPM Steev Klimaszewski <steev@kali.org=
> wrote:
>
> Hi Masahiro,
>
> On Sat, Mar 18, 2023 at 9:19=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > On Sun, Mar 19, 2023 at 10:12=E2=80=AFAM Steev Klimaszewski <steev@kali=
.org> wrote:
> > >
> > > Hi Masahiro,
> > >
> > > On Sun, Mar 12, 2023 at 1:07=E2=80=AFPM Masahiro Yamada <masahiroy@ke=
rnel.org> wrote:
> > > >
> > > > This series fixes some bugs, then switch to 'git archive'
> > > > for source package creation as suggested by Linus.
> > >
> > > I apologize if this is a stupid question, but it's not immediately ap=
parent to
> > > me...
> > >
> > > Previously, I was overriding the deb file output name by the setting =
of
> > > LOCALVERSION_AUTO; but with this series applied, that seems to be ign=
ored?
> > >
> > > Now if I pass LOCALVERSION=3D"" I end up with e.g. linux-image-6.3.0-=
rc2_6.3.0-rc2-00575-g46c71cad996d-100_arm64.deb
> > > whereas previously, I would end up with linux-image-6.3.0-rc2_6.3.0-r=
c2-100_arm64.deb
> > >
> > > How would I restore the old naming behaviour?
> > >
> > > -- steev
> >
> > The same string "6.3.0-rc2" is repeated in the file name.
> > The first one is what Debian calls the ABI version, and the
> > second one is the version of the package.
> > They are usually different on real Debian kernels.
> >
> > LOCALVERSION affects the former, and KDEB_PKGVERSION
> > the second.
> >
> >
> > My recommendation is "just let it be"
> > because "linux-upstream_6.3.0-rc2.orig.tar.gz"
> > you would generate is not the real 6.3.0-rc2.
> >
> >
> > If you want to restore what you previously did,
> >
> >  make deb-pkg KDEB_PKGVERSION=3D6.3.0-rc2-100
> >
> > will create such a file name.
> >
> My apologies, my text editor seemed to swallow up half of my previous
> email as what I was trying to say wasn't all in there...
> What I meant to say is that, prior to this patchset, if
> LOCALVERSION_AUTO=3Dy we would end up with
>
> linux-image-6.3.0-rc2_6.3.0-rc2-00575-g46c71cad996d-100_arm64.deb
>
> where
> LOCALVERSION_AUTO=3D"00575-g46c71cad996d"
> NUMBEROFBUILDS=3D"100" (i'm not sure where this number was stored previou=
sly)
>
> Assuming the above 2 are what the current settings are...
>
> And if you turned LOCALVERSION_AUTO off, and had changes on top of the
> git repo, you would end up with
>
> linux-image-6.3.0-rc2_6.3.0-rc2+-100_arm64.deb
>
> Then if you would pass LOCALVERSION=3D"", on top of LOCALVERSION_AUTO
> being unset, you would end up with
>
> linux-image-6.3.0-rc2_6.3.0-rc2-100_arm64.deb
>
> Now with your patchset applied, with LOCALVERSION_AUTO being unset,
> you end up with
>
> linux-image-6.3.0-rc2_6.3.0-rc2-00575-g46c71cad996d-100_arm64.deb
>
> Which means that LOCALVERSION_AUTO goes away?


It did not go away.
LOCALVERSION_AUTO is meant to set kernelrelease,
which will result in 'uname -r' in the installed system.

LOCALVERSION_AUTO should not affect the Debian package version,
which is a different thing.




>  I'm not sure why the
> package version overrides what I'm trying to set in the first place in
> the kernel config?
>
> Your workaround is mostly fine, but that "-100" on the end means I
> have to now personally track how many builds I've done?

"-100" is the build revision, which will go into the .version file
while building the kernel.
It is not so important, you can set whatever number.



If you leave the revision auto-incremented,
this is equivalent to what Kbuild is doing internally.

make KDEB_PKGVERSION=3D$(make kernelversion)-$(init/build-version) bindeb-p=
kg



>
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada



--=20
Best Regards
Masahiro Yamada
