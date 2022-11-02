Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18213615CA5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiKBHFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiKBHF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:05:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1444B193FB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667372672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/TQR2krq2hI7mqrGIodPZiDZMOmKhzS6eWOT8rnNY8=;
        b=Fk33WrAXhRK2md6AADaSh5+iAF1WbvwistCtlC4DL7IDM8k/pxYM7C9Jl/5uLW7BEYzqxd
        +yhDB8+xh2jt7u5wKqGSapV/bwyHU0a8F/1h+gItuk4yvkUmXj9D0nuNar6KZmb+HoYEc9
        xpRU0MOgYWivwqzpBMWLrH/jFTLE9pM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-618-tsdEpVY4N7SVKvWa3T-b2Q-1; Wed, 02 Nov 2022 03:04:30 -0400
X-MC-Unique: tsdEpVY4N7SVKvWa3T-b2Q-1
Received: by mail-pj1-f72.google.com with SMTP id pa16-20020a17090b265000b0020a71040b4cso6907240pjb.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 00:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/TQR2krq2hI7mqrGIodPZiDZMOmKhzS6eWOT8rnNY8=;
        b=yBZ0hFLzMJFe6xqxBlwtXBmw7bnlDajxXCRYJCvKA2BSmZUPzIyEQIBvqsc5v7Hk6m
         994eqsRslG2HtD+GH9tciR4NeGk5yOeZlIM+ST/OpUxwyBvvN7bJCrhGP/ELmGNFd4d7
         XAoCy9Y3DBsb5dmOPHbKEG5kh6WjDqDj2bwMeIXtKaniwgWaVt90k2z7WN99uPXeTQwr
         1clU13m+BqRaQ3+VJqF4WYhdMq3xsmMb28HLJPJwXU9EC52Y3wj/E6rtGYj4v6yBxS+N
         uNrPwCr96yF/iZDF5jdL0XWqjsapuLi1dTjXmBLEe9U9UlU6ljlVbEHEGfDG3TNEfNja
         3e8A==
X-Gm-Message-State: ACrzQf0n5fBK0gV1bVeuFtIyEA4oNcZQqLFe6ZwpQxGZmewpNze3M54w
        wNqt1/oWVD1VGIvuuxNba9J6UKmAxP4467sTI0boToIGf/Mw9NdYR2oPOeypficgFOW5c7QqTjZ
        nltR6ZfOFCvyduCFxjbETqBajfpv2fJyWQi4zc38k
X-Received: by 2002:a63:5853:0:b0:46f:fdfc:a651 with SMTP id i19-20020a635853000000b0046ffdfca651mr3916562pgm.385.1667372669901;
        Wed, 02 Nov 2022 00:04:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5pRa8jWlzFQTwcYQaQd/gQgUl+wBqlB+a7IDhPYhPNbH+iwQ6JHevUxI8gk7pGiK+qSbU26yFtJsKI9btL0jw=
X-Received: by 2002:a63:5853:0:b0:46f:fdfc:a651 with SMTP id
 i19-20020a635853000000b0046ffdfca651mr3916545pgm.385.1667372669608; Wed, 02
 Nov 2022 00:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <5b59fdb7db34f5292b1d138939c6b70b2b2039dd.1666703850.git.jtoppins@redhat.com>
In-Reply-To: <5b59fdb7db34f5292b1d138939c6b70b2b2039dd.1666703850.git.jtoppins@redhat.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Wed, 2 Nov 2022 08:04:18 +0100
Message-ID: <CACT4oufdDqABBG3BekwaPxFpoNbc3H2QMGWkYFgsdsZKmEbaYQ@mail.gmail.com>
Subject: Re: [PATCH next] kbuild: add ability to make source rpm buildable
 using koji
To:     Jonathan Toppins <jtoppins@redhat.com>
Cc:     linux-kbuild@vger.kernel.org, dzickus@redhat.com, kheib@redhat.com,
        jtornosm@redhat.com, Ivan Vecera <ivecera@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 3:17 PM Jonathan Toppins <jtoppins@redhat.com> wrot=
e:
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

Acked-by: =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>

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
>         +rpmbuild $(RPMOPTS) --target $(UTS_MACHINE)-linux -ta $(KERNELPA=
TH).tar.gz \
>         --define=3D'_smp_mflags %{nil}'
>
> +# srcrpm-pkg
> +# ----------------------------------------------------------------------=
-----
> +PHONY +=3D srcrpm-pkg
> +srcrpm-pkg:
> +       $(MAKE) clean
> +       $(CONFIG_SHELL) $(MKSPEC) >$(objtree)/kernel.spec
> +       $(call cmd,src_tar,$(KERNELPATH),kernel.spec)
> +       +rpmbuild $(RPMOPTS) --target $(UTS_MACHINE) -ts $(KERNELPATH).ta=
r.gz \
> +       --define=3D'_smp_mflags %{nil}' --define=3D'_srcrpmdir $(srctree)=
'
> +
>  # binrpm-pkg
>  # ----------------------------------------------------------------------=
-----
>  PHONY +=3D binrpm-pkg
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index 70392fd2fd29..dda00a948a01 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -33,6 +33,8 @@ EXCLUDES=3D"$RCS_TAR_IGNORE --exclude=3D*vmlinux* --exc=
lude=3D*.mod \
>  --exclude=3D*.o --exclude=3D*.ko --exclude=3D*.cmd --exclude=3DDocumenta=
tion \
>  --exclude=3D.config.old --exclude=3D.missing-syscalls.d --exclude=3D*.s"
>
> +test -n "$LOCALVERSION" && MAKE=3D"$MAKE LOCALVERSION=3D$LOCALVERSION"
> +
>  # We can label the here-doc lines for conditional output to the spec fil=
e
>  #
>  # Labels:
> @@ -49,6 +51,9 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
>         URL: https://www.kernel.org
>  $S     Source: kernel-$__KERNELRELEASE.tar.gz
>         Provides: $PROVIDES
> +$S     BuildRequires: bc binutils bison dwarves elfutils-libelf-devel fl=
ex
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
>  $S     $MAKE %{?_smp_mflags} KBUILD_BUILD_VERSION=3D%{release}
> --
> 2.31.1
>


--=20
=C3=8D=C3=B1igo Huguet

