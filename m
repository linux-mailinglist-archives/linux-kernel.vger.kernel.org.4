Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5216398E4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 00:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiKZXLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 18:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKZXLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 18:11:48 -0500
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F39117A83;
        Sat, 26 Nov 2022 15:11:47 -0800 (PST)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 2AQNBOWW021164;
        Sun, 27 Nov 2022 08:11:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 2AQNBOWW021164
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1669504285;
        bh=ZXrddbrSlzc42mKp5xuTGaCpfLZncZ4RzMDXBMJwWvs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QTxigVNs64hacV6yM6sUdv6HbCLDlME6f5lUEwAwWTNS1VQPyYy4BSNrxCP9p0N5m
         kYDDDmh1DLCg3wyrg8UdafdMVjEUmLFhZrDV2o62Z/i4tx1h0ZZBaY6Ac/TY1okyGu
         woJ4+Hv8v/PShZbOJdF6shNq1rlOKljCxk6p9q/Cul14IEpY1VG1S+e93coVOttvMl
         OG2JmT1KOiVIiSGF7k9Iy31HtqqQnSYgJqjaMosa8JICdsuTcVb9G2gXE2ruunR2gk
         qWtdIxGN4XqpYEhV/r8sBRPT5XTRvIGj8m0eJ1K86e06cWEH5xCRVSZnot4q8AtOi5
         PDoxi6ow43qKQ==
X-Nifty-SrcIP: [209.85.160.49]
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1432a5f6468so9061737fac.12;
        Sat, 26 Nov 2022 15:11:25 -0800 (PST)
X-Gm-Message-State: ANoB5pntuNN5rV7yapwY4B0774nXrDdbfy1tPfCodDYSQQO6NO7SaiVP
        gG9uPa9UcxYUGCQcMEASoAN/nuY/CWCB6C0+FT0=
X-Google-Smtp-Source: AA0mqf7jOkCHJxOYdfbDjcYjv1QUtwzXCXXJBSNM3ouGB1lZLBuc56KAP2BkZdHl8a2jZ93t3Vb78oZBvjrAaxx1RSU=
X-Received: by 2002:a05:6870:ea8e:b0:13b:a31f:45fd with SMTP id
 s14-20020a056870ea8e00b0013ba31f45fdmr27866584oap.194.1669504283965; Sat, 26
 Nov 2022 15:11:23 -0800 (PST)
MIME-Version: 1.0
References: <5b59fdb7db34f5292b1d138939c6b70b2b2039dd.1666703850.git.jtoppins@redhat.com>
In-Reply-To: <5b59fdb7db34f5292b1d138939c6b70b2b2039dd.1666703850.git.jtoppins@redhat.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 27 Nov 2022 08:10:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNATPZkMCabD5aGNamp-gH3aZvFPr2_Yq=N=rM_ht2i3p6g@mail.gmail.com>
Message-ID: <CAK7LNATPZkMCabD5aGNamp-gH3aZvFPr2_Yq=N=rM_ht2i3p6g@mail.gmail.com>
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


Applied to linux-kbuild.
Thanks.

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
