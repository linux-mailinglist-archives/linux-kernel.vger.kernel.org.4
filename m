Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55390643D7D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 08:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiLFHOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 02:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiLFHOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 02:14:47 -0500
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A823915702;
        Mon,  5 Dec 2022 23:14:45 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2B67EEYZ012284;
        Tue, 6 Dec 2022 16:14:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2B67EEYZ012284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1670310855;
        bh=U52gCh8Z/SoLdl6qC1zDSkx5TTz1rxCuOfh1pUNoh1I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uir75WmhM61qWYaSAfEX4eh/3QvB6Hl5x7uUEt4t6txjzK9eHuMyEt2KoUvB8p0f/
         3SeDf4vb5LglQhhBoQ92C1UJS4aFRwwL0K9tu8+AiCoZsONS7j+GOL4Lt7NXYFgKXP
         8oMg887wTAjlSDOd4C69fumOvFX+a9B4/a+iql3BwwYveDlvm+MPBNdQRdDTWtcqEU
         IMfiGGeGxfjjZ15/6zlwucOfsDnIS7BpbFua9Lm4+l9F9Ew1CjtGEVDxv3VkmG0LNn
         4mOPQCK+zwbMgLeZa9pfWnpRYhwxDhaIim9guOQZ/WaR1BJ492RW8dn/dXHH9P4R5N
         ThJSIhNuOSozw==
X-Nifty-SrcIP: [209.85.208.172]
Received: by mail-lj1-f172.google.com with SMTP id x11so16203289ljh.7;
        Mon, 05 Dec 2022 23:14:14 -0800 (PST)
X-Gm-Message-State: ANoB5pmy+Wp/qLrn1omvZdj3jklygDv87vd52EdheKJ/LnaQBw0DS5ao
        DhmEmwuYvYmx+K6bQCgCqTR43fRIn88dfdZzHSQ=
X-Google-Smtp-Source: AA0mqf5uw6qKYikZAQcH398Rzc4rNP9PNyOlQM5FtlXYbzO5X2thuJyKZ5sk3UnpRje0kRiU0nts8llwaN6AMm42LoU=
X-Received: by 2002:a05:651c:10af:b0:277:3046:3d1c with SMTP id
 k15-20020a05651c10af00b0027730463d1cmr25407706ljn.422.1670310853192; Mon, 05
 Dec 2022 23:14:13 -0800 (PST)
MIME-Version: 1.0
References: <d6d5ce3169da8559cd20d20889849546cc69be50.1669042125.git.jtoppins@redhat.com>
 <88901065-469f-0988-f56b-c84d1fabbe8a@redhat.com> <f8c49457-7f7a-b8bf-b212-b607a1ecf346@infradead.org>
In-Reply-To: <f8c49457-7f7a-b8bf-b212-b607a1ecf346@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 6 Dec 2022 16:13:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNASyvQKkOmCfshfW7uuFtfSR7hSv7g4-_Vi1QoOL6VUFWw@mail.gmail.com>
Message-ID: <CAK7LNASyvQKkOmCfshfW7uuFtfSR7hSv7g4-_Vi1QoOL6VUFWw@mail.gmail.com>
Subject: Re: [PATCH next v2] kbuild: add ability to make source rpm buildable
 using koji
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Toppins <jtoppins@redhat.com>,
        linux-kbuild@vger.kernel.org, dzickus@redhat.com,
        ihuguet@redhat.com, ivecera@redhat.com, jtornosm@redhat.com,
        kheib@redhat.com, linux-kernel@vger.kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 2:44 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi,
>
> On 12/5/22 21:37, Jonathan Toppins wrote:
> > On 11/21/22 09:48, Jonathan Toppins wrote:
> >> From: Ivan Vecera <ivecera@redhat.com>
> >>
> >> Changes:
> >> - added new target 'srcrpm-pkg' to generate source rpm
> >> - added required build tools to spec file
> >> - removed locally compiled host tools to force their re-compile
> >>
> >> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> >> Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
> >> Acked-by: =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>
> >> Tested-by: Ivan Vecera <ivecera@redhat.com>
> >> ---
> >>
> >> Notes:
> >>      v2:
> >>       * updated UTS_MACHINE to be $(UTS_MACHINE)-linux
> >>         suggested by Masahiro Yamada
> >
> > Quick ping, wanted to make sure I didn't miss any requests. Looking at =
patchwork there appear to be no replies to this version. Would it be reason=
able to assume this version will be accepted and make it into the next kern=
el?
>
> I have a request:
> Tell us what "koji" is. I'm surprised that that word is not in the
> patch description at all.
>
> Thanks.




I applied this patch, but somehow I replied to v1
https://lore.kernel.org/linux-kbuild/CAK7LNATPZkMCabD5aGNamp-gH3aZvFPr2_Yq=
=3DN=3DrM_ht2i3p6g@mail.gmail.com/



I have never used it, but I guess koji is a build engine
that generates binary packages from a source package.

That's why they want to create only a source package.


This patch is not related to koji
(and I suggested them to drop it from the subject)

I just tested it by using 'rpmbuild' on my local machine.












> >>
> >>   scripts/Makefile.package | 10 ++++++++++
> >>   scripts/package/mkspec   |  7 +++++++
> >>   2 files changed, 17 insertions(+)
> >>
> >> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> >> index 8bbcced67c22..1290f1c631fb 100644
> >> --- a/scripts/Makefile.package
> >> +++ b/scripts/Makefile.package
> >> @@ -62,6 +62,16 @@ rpm-pkg:
> >>       +rpmbuild $(RPMOPTS) --target $(UTS_MACHINE)-linux -ta $(KERNELP=
ATH).tar.gz \
> >>       --define=3D'_smp_mflags %{nil}'
> >>   +# srcrpm-pkg
> >> +# -------------------------------------------------------------------=
--------
> >> +PHONY +=3D srcrpm-pkg
> >> +srcrpm-pkg:
> >> +    $(MAKE) clean
> >> +    $(CONFIG_SHELL) $(MKSPEC) >$(objtree)/kernel.spec
> >> +    $(call cmd,src_tar,$(KERNELPATH),kernel.spec)
> >> +    +rpmbuild $(RPMOPTS) --target $(UTS_MACHINE)-linux -ts $(KERNELPA=
TH).tar.gz \
> >> +    --define=3D'_smp_mflags %{nil}' --define=3D'_srcrpmdir $(srctree)=
'
> >> +
> >>   # binrpm-pkg
> >>   # ------------------------------------------------------------------=
---------
> >>   PHONY +=3D binrpm-pkg
> >> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> >> index 70392fd2fd29..dda00a948a01 100755
> >> --- a/scripts/package/mkspec
> >> +++ b/scripts/package/mkspec
> >> @@ -33,6 +33,8 @@ EXCLUDES=3D"$RCS_TAR_IGNORE --exclude=3D*vmlinux* --=
exclude=3D*.mod \
> >>   --exclude=3D*.o --exclude=3D*.ko --exclude=3D*.cmd --exclude=3DDocum=
entation \
> >>   --exclude=3D.config.old --exclude=3D.missing-syscalls.d --exclude=3D=
*.s"
> >>   +test -n "$LOCALVERSION" && MAKE=3D"$MAKE LOCALVERSION=3D$LOCALVERSI=
ON"
> >> +
> >>   # We can label the here-doc lines for conditional output to the spec=
 file
> >>   #
> >>   # Labels:
> >> @@ -49,6 +51,9 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
> >>       URL: https://www.kernel.org
> >>   $S    Source: kernel-$__KERNELRELEASE.tar.gz
> >>       Provides: $PROVIDES
> >> +$S    BuildRequires: bc binutils bison dwarves elfutils-libelf-devel =
flex
> >> +$S    BuildRequires: gcc make openssl openssl-devel perl python3 rsyn=
c
> >> +
> >>       # $UTS_MACHINE as a fallback of _arch in case
> >>       # /usr/lib/rpm/platform/*/macros was not included.
> >>       %define _arch %{?_arch:$UTS_MACHINE}
> >> @@ -80,6 +85,8 @@ $S$M    against the $__KERNELRELEASE kernel package.
> >>   $S$M
> >>   $S    %prep
> >>   $S    %setup -q
> >> +$S    rm -f scripts/basic/fixdep scripts/kconfig/conf
> >> +$S    rm -f tools/objtool/{fixdep,objtool}
> >>   $S
> >>   $S    %build
> >>   $S    $MAKE %{?_smp_mflags} KBUILD_BUILD_VERSION=3D%{release}
> >
>
> --
> ~Randy



--=20
Best Regards
Masahiro Yamada
