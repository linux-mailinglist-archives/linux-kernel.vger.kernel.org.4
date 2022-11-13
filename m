Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4847E626FC1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 14:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbiKMNec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 08:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbiKMNea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 08:34:30 -0500
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4899FCF3;
        Sun, 13 Nov 2022 05:34:29 -0800 (PST)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2ADDXrKE031534;
        Sun, 13 Nov 2022 22:33:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2ADDXrKE031534
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1668346434;
        bh=sLV0JxP70ugmDXDDr3ma22c15gfH+4uTlg/CM2GS6x8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C60KnePxTYXwgiPk9GuLg6rKsWtFaH4bKciY+kRBWENYisS0Clx9Um9WhWY0IGSC1
         cRRpAjVjCYPRAW3LubugRmjfSahjZ06J8FyiJeqfdGZu4h7CTePZSmnT1zzeikhn9P
         5XTo0vE58IPivwFiXrQjW4esOqkNKOVWFe6k0sDDUBQT52txoBizJwIFgrk5lksrhf
         WTOjzXC3dZaWRqQmL0DqGc7tMEa7KUQQVMGVkdO7daXIdFBF7OQ2JA94ZynxfcZIxh
         LnK2s70FMZfLNPLB6jae+xkmlLGDhAtZCk/o5mGoVrM6HVIPpstQ4/5PCFgUXoQjzL
         Ow1/v4IR5zEWQ==
X-Nifty-SrcIP: [209.85.167.175]
Received: by mail-oi1-f175.google.com with SMTP id m204so9100959oib.6;
        Sun, 13 Nov 2022 05:33:53 -0800 (PST)
X-Gm-Message-State: ANoB5pmj5MomKsgFr9h3K/lbQ0nzvMS6FxK6QR6RMmKSC+TIppf4WHZS
        6YZSWinCcD52dzFVpCGPndyx0yYohJB9eHM+6rw=
X-Google-Smtp-Source: AA0mqf701XlITsq/mZ8+04NUD4rjccuYddLw/E8U/C50wVFCQ3kE5YlUfeGcRxzE9lrKYmbLtJUhvWm2Yzhx46xpfeU=
X-Received: by 2002:a05:6808:208c:b0:354:94a6:a721 with SMTP id
 s12-20020a056808208c00b0035494a6a721mr4122333oiw.194.1668346432541; Sun, 13
 Nov 2022 05:33:52 -0800 (PST)
MIME-Version: 1.0
References: <5b59fdb7db34f5292b1d138939c6b70b2b2039dd.1666703850.git.jtoppins@redhat.com>
In-Reply-To: <5b59fdb7db34f5292b1d138939c6b70b2b2039dd.1666703850.git.jtoppins@redhat.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 13 Nov 2022 22:33:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQNTDpKRDdi5JXV1ofC=s9ttJBk4yCivczZ1+KK7G2j5A@mail.gmail.com>
Message-ID: <CAK7LNAQNTDpKRDdi5JXV1ofC=s9ttJBk4yCivczZ1+KK7G2j5A@mail.gmail.com>
Subject: Re: [PATCH next] kbuild: add ability to make source rpm buildable
 using koji
To:     Jonathan Toppins <jtoppins@redhat.com>
Cc:     linux-kbuild@vger.kernel.org, dzickus@redhat.com, kheib@redhat.com,
        jtornosm@redhat.com, ihuguet@redhat.com,
        Ivan Vecera <ivecera@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 10:17 PM Jonathan Toppins <jtoppins@redhat.com> wrote:
>
> From: Ivan Vecera <ivecera@redhat.com>
>
> Changes:
> - added new target 'srcrpm-pkg' to generate source rpm
> - added required build tools to spec file
> - removed locally compiled host tools to force their re-compile
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>



I am fine with this patch.

Just minor comments.


I noticed an inconsistency between
"--target $(UTS_MACHINE)-linux" in the rpm-pkg target and
"--target $(UTS_MACHINE)" in the srcrpm-pkg target.


I applied 6105e4f6511d6b383738be89efb99c607e158a29
just a few months ago.
Is it better to make it consistent here?




Actually, I do not know koji, also not sure if it is
important to mention it in the commit subject.
I just tested this patch by using 'rpmbuild' command
on my local machine.







> ---
>  scripts/Makefile.package | 10 ++++++++++
>  scripts/package/mkspec   |  7 +++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index 8bbcced67c22..e0830a870394 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -62,6 +62,16 @@ rpm-pkg:
>         +rpmbuild $(RPMOPTS) --target $(UTS_MACHINE)-linux -ta $(KERNELPATH).tar.gz \
>         --define='_smp_mflags %{nil}'
>
> +# srcrpm-pkg
> +# ---------------------------------------------------------------------------
> +PHONY += srcrpm-pkg
> +srcrpm-pkg:
> +       $(MAKE) clean
> +       $(CONFIG_SHELL) $(MKSPEC) >$(objtree)/kernel.spec
> +       $(call cmd,src_tar,$(KERNELPATH),kernel.spec)
> +       +rpmbuild $(RPMOPTS) --target $(UTS_MACHINE) -ts $(KERNELPATH).tar.gz \
> +       --define='_smp_mflags %{nil}' --define='_srcrpmdir $(srctree)'
> +
>  # binrpm-pkg
>  # ---------------------------------------------------------------------------
>  PHONY += binrpm-pkg
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index 70392fd2fd29..dda00a948a01 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -33,6 +33,8 @@ EXCLUDES="$RCS_TAR_IGNORE --exclude=*vmlinux* --exclude=*.mod \
>  --exclude=*.o --exclude=*.ko --exclude=*.cmd --exclude=Documentation \
>  --exclude=.config.old --exclude=.missing-syscalls.d --exclude=*.s"
>
> +test -n "$LOCALVERSION" && MAKE="$MAKE LOCALVERSION=$LOCALVERSION"
> +
>  # We can label the here-doc lines for conditional output to the spec file
>  #
>  # Labels:
> @@ -49,6 +51,9 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
>         URL: https://www.kernel.org
>  $S     Source: kernel-$__KERNELRELEASE.tar.gz
>         Provides: $PROVIDES
> +$S     BuildRequires: bc binutils bison dwarves elfutils-libelf-devel flex
> +$S     BuildRequires: gcc make openssl openssl-devel perl python3 rsync
> +
>         # $UTS_MACHINE as a fallback of _arch in case
>         # /usr/lib/rpm/platform/*/macros was not included.
>         %define _arch %{?_arch:$UTS_MACHINE}
> @@ -80,6 +85,8 @@ $S$M  against the $__KERNELRELEASE kernel package.
>  $S$M
>  $S     %prep
>  $S     %setup -q
> +$S     rm -f scripts/basic/fixdep scripts/kconfig/conf
> +$S     rm -f tools/objtool/{fixdep,objtool}
>  $S
>  $S     %build
>  $S     $MAKE %{?_smp_mflags} KBUILD_BUILD_VERSION=%{release}
> --
> 2.31.1
>


--
Best Regards
Masahiro Yamada
