Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3396DC682
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 14:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjDJMEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 08:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjDJMEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 08:04:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E1559FD;
        Mon, 10 Apr 2023 05:04:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50B8C60D33;
        Mon, 10 Apr 2023 12:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA703C4339B;
        Mon, 10 Apr 2023 12:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681128278;
        bh=D1NIR8ELVoVun1aBrnYEjKGI62TAPM47XdsV52WM1QM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J5eG+3GHXAVVRSmglbMMwi7rqvne2pyE03LV6dljGlTOnerba1537RnlFjZTVlG1E
         ySNaHYEvZ45CQHp7j6XCCWaw3owvm0N+hdT4KSMy+B3wkouIZfEbELX0DzgiA2HSoJ
         sNuDkCTbho3MYK5oEvcIPu9SddPL/qxnmO2P7YmGMN1c3ryszuIkE8Me/J08ldTe5y
         ehkhSLMWDXRYFncmaPKYQqdEjrI1+x35KsUAaSVRQuZF/Vvua2Zi1WY6xc1hnis7aM
         Q+NdUsR8ddSF6Gx+XPpnUEHgH71vMKlPx596moyVhHP0AVRn5pEjroV3iiP8vmi6ao
         L9DrUP5ejX+HQ==
Received: by mail-oo1-f41.google.com with SMTP id i10-20020a4ad68a000000b0053b8aa32089so656676oot.5;
        Mon, 10 Apr 2023 05:04:38 -0700 (PDT)
X-Gm-Message-State: AAQBX9el34167M3U8rIpQVMOm53Fs1zqOBymmJLoq+iBa0iacE/ca5kx
        o1OC1cORkj3hcTZNrU9W5qT9p6q/dN/lDnnYcfQ=
X-Google-Smtp-Source: AKy350Z005OPlVCFO6e8Xg3dn3taw9HHRUi8VY6GZMCPn/WOvVP4KE91jVxhZl+N0A00xZtOmSa6kmO3nnn6eKCG7iE=
X-Received: by 2002:a4a:b10b:0:b0:53e:97e0:967d with SMTP id
 a11-20020a4ab10b000000b0053e97e0967dmr3007864ooo.1.1681128277930; Mon, 10 Apr
 2023 05:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230404021758.1194687-1-masahiroy@kernel.org> <ZCvaQRT26GbLr9N2@fjasle.eu>
In-Reply-To: <ZCvaQRT26GbLr9N2@fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 10 Apr 2023 21:04:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ3oaUnCiapforuvsFyOk9p67m+gdxsGsOm-UnmRNUzDw@mail.gmail.com>
Message-ID: <CAK7LNAQ3oaUnCiapforuvsFyOk9p67m+gdxsGsOm-UnmRNUzDw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: give up untracked files for source package builds
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 5:05=E2=80=AFPM Nicolas Schier <nicolas@fjasle.eu> w=
rote:
> >
> >  debian: FORCE
> >       $(call cmd,debianize)
> > @@ -103,6 +103,7 @@ PHONY +=3D debian-orig
> >  debian-orig: private source =3D $(shell dpkg-parsechangelog -S Source)
> >  debian-orig: private version =3D $(shell dpkg-parsechangelog -S Versio=
n | sed 's/-[^-]*$$//')
> >  debian-orig: private orig-name =3D $(source)_$(version).orig.tar.gz
> > +debian-orig: mkdebian-opts =3D --need-source
> >  debian-orig: linux.tar.gz debian
> >       $(Q)if [ "$(df  --output=3Dtarget .. 2>/dev/null)" =3D "$(df --ou=
tput=3Dtarget $< 2>/dev/null)" ]; then \
> >               ln -f $< ../$(orig-name); \
> > diff --git a/scripts/package/gen-diff-patch b/scripts/package/gen-diff-=
patch
> > index f842ab50a780..a180ff94f655 100755
> > --- a/scripts/package/gen-diff-patch
> > +++ b/scripts/package/gen-diff-patch
> > @@ -2,43 +2,36 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >
> >  diff_patch=3D"${1}"
> > -untracked_patch=3D"${2}"
> >  srctree=3D$(dirname $0)/../..
> >
> > -rm -f ${diff_patch} ${untracked_patch}
> > -
> > -if ! ${srctree}/scripts/check-git; then
> > -     exit
> > -fi
> > -
> > -mkdir -p "$(dirname ${diff_patch})" "$(dirname ${untracked_patch})"
> > +mkdir -p "$(dirname ${diff_patch})"
>
> shellcheck complains about missing quotes around "${diff_patch}".


I will fix it.


>
> >
> >  git -C "${srctree}" diff HEAD > "${diff_patch}"
> >
> > -if [ ! -s "${diff_patch}" ]; then
> > -     rm -f "${diff_patch}"
> > +if [ ! -s "${diff_patch}" ] ||
> > +   [ -z "$(git -C "${srctree}" ls-files --other --exclude-standard | h=
ead -n1)" ]; then
>
> Did you leave out the 'rm -f "${diff_patch}"' to have a more static mkspe=
c
> output?


Yes.

I noticed it is ok to leave an empty patch file.

The 'patch' command exists with 0
when the input diff is empty.


$ patch -p1 < /dev/null
$ echo $?
0

However, dpkg-source warns of an empty patch file.
So, mkdebian should remove it when it gets empty.



> > +# The source tarball, which is generated by 'git archive', contains ev=
erything
> > +# you committed in the repository. If you have local diff ('git diff H=
EAD'),
> > +# it will go into ${diff_patch}. If untracked files are remaining, the=
 resulting
> > +# source package may not be correct.
> > +#
> > +# Examples:
> > +#  - You modified a source file to add #include <linux/new-header.h>
> > +#    but forgot to add include/linux/new-header.h
> > +#  - You modified a Makefile to add 'obj-$(CONFIG_FOO) +=3D new-dirver=
.o'
> > +#    but you forgot to add new-driver.c
> > +#
> > +# You need to commit them, or at least stage them by 'git add'.
>
> making the file(s) known to git by 'git add -N' would be sufficient; but =
that's
> probably too much detail here.  Nevertheless, I think the explanation is
> valueable!


Yeah, it is up to users how to remember to do 'git add'.
'git add -N' is a minute.



> > +
> > +     # Add .config as a patch
> > +     mkdir -p debian/patches
> > +     {
> > +             echo "Subject: Add .config"
> > +             echo "Author: ${maintainer}"
> > +             echo
> > +             echo "--- /dev/null"
> > +             echo "+++ linux/.config"
> > +             diff -u /dev/null "${KCONFIG_CONFIG}" | tail -n +3
> > +     } > debian/patches/config
> > +     echo config > debian/patches/series
>
> I'd named it config.patch, but actually it is just a config, so this make=
s
> sense to me as well.


I agree.
I will rename it in v2.


>
> > +
> > +     $(dirname $0)/gen-diff-patch debian/patches/diff.patch
>
> "${0%/*}" instead of $(dirname $0) would also be possible.
>
> > +     if [ -s debian/patches/diff.patch ]; then
> > +             echo diff.patch >> debian/patches/series
> > +     else
> > +             rm -f debian/patches/diff.patch
> > +     fi
> > +}
> > +
> >  rm -rf debian
> > +mkdir debian
> > +
> > +if [ "$1" =3D --need-source ]; then
> > +     gen_source
> > +     shift
>
> Might you want to remove the 'shift'?  It looks like mkdebian handles mor=
e
> command line arguments but it doesn't, as far as I can see.  And in case =
it
> will do in some future, argument handling had to be revised nevertheless.


OK. I will remove it.



> >  echo $debarch > debian/arch
> >  extra_build_depends=3D", $(if_enabled_echo CONFIG_UNWINDER_ORC libelf-=
dev:native)"
> >  extra_build_depends=3D"$extra_build_depends, $(if_enabled_echo CONFIG_=
SYSTEM_TRUSTED_KEYRING libssl-dev:native)"
> > diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> > index b7d1dc28a5d6..b45020d64218 100755
> > --- a/scripts/package/mkspec
> > +++ b/scripts/package/mkspec
> > @@ -19,8 +19,7 @@ else
> >       mkdir -p rpmbuild/SOURCES
> >       cp linux.tar.gz rpmbuild/SOURCES
> >       cp "${KCONFIG_CONFIG}" rpmbuild/SOURCES/config
> > -     $(dirname $0)/gen-diff-patch rpmbuild/SOURCES/diff.patch rpmbuild=
/SOURCES/untracked.patch
> > -     touch rpmbuild/SOURCES/diff.patch rpmbuild/SOURCES/untracked.patc=
h
> > +     $(dirname $0)/gen-diff-patch rpmbuild/SOURCES/diff.patch
>
> Possibly change to "${0%/*}/gen-diff-patch", cp. above?


dirname forks a process.

I will change it to ${srctree}/scripts/package/gen-diff-patch
so it works only with a variable expansion.







--=20
Best Regards
Masahiro Yamada
