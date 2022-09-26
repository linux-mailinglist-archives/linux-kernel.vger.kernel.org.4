Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9235EAEEE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiIZR77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiIZR72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:59:28 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5EE18E38;
        Mon, 26 Sep 2022 10:39:42 -0700 (PDT)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 28QHdOcb007145;
        Tue, 27 Sep 2022 02:39:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 28QHdOcb007145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664213965;
        bh=NUXkh+ReKtVXbxDHPOxGNjBIp9MG0B2ir380jnriUR4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JVgH9BQNVlC0KZIVuq9zZZN0mtFEiZ9XyFCYsx+7r+EA8CrbIHCAoktr+oJjfrU76
         suJqMGl7D5O7yyzq7Lioklqd6cBuph7n99H+a2cniPQXZKaCI/zGSUyMRMUodc76B5
         sHDbyx09hLbiS3w3Sb31rdKRhxA4WACZlGSNRXfJ2y+o3OykLxvPb23GWSVetWN2jx
         iWxhYVdlr2vZgAevkvMGeQukH646CiAjgJ18BpDu8PoJFJF6C+aYrGLQf5OlZW5HtK
         lbZxXLh0EjKCEidOykYTyc40Bk/XYd68Y+3DTLC/yCPiGsRK/gKG2TdqHY3b7i5b1j
         MucgjSrqWoAlA==
X-Nifty-SrcIP: [209.85.167.178]
Received: by mail-oi1-f178.google.com with SMTP id q10so1564763oib.5;
        Mon, 26 Sep 2022 10:39:25 -0700 (PDT)
X-Gm-Message-State: ACrzQf3DtUrEjDCmLL16fSrXRYY9mnLfDJepBVHmRXlUYsnnOMlTWELm
        TGeAabCMBIO1woHf6TJeiTdGFhRO/9vGRsEPH5s=
X-Google-Smtp-Source: AMsMyM6FI4csgjZx2tF7mvFhP490u//OkYNu0xENfDLkI/JjUo8UkQaFkURoFvCNNHuyK19mZPnGu1GLeQvvN+8w0B4=
X-Received: by 2002:a05:6808:1b85:b0:34d:8ce1:d5b0 with SMTP id
 cj5-20020a0568081b8500b0034d8ce1d5b0mr15342309oib.194.1664213964111; Mon, 26
 Sep 2022 10:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220922184525.3021522-1-zack@kde.org>
In-Reply-To: <20220922184525.3021522-1-zack@kde.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 27 Sep 2022 02:38:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNARRUbcZLNUOY-is=EVC7Ov8-0SHS=207=XbQkkjS59g4Q@mail.gmail.com>
Message-ID: <CAK7LNARRUbcZLNUOY-is=EVC7Ov8-0SHS=207=XbQkkjS59g4Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Add an option to skip vmlinux.bz2 in the rpm's
To:     Zack Rusin <zackr@vmware.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 3:45 AM Zack Rusin <zack@kde.org> wrote:
>
> From: Zack Rusin <zackr@vmware.com>
>
> The debug vmlinux takes up the vast majority of space in the built
> rpm's. While having it enabled by default is a good idea because it
> makes debugging easier, having an option to skip it is highly valuable
> for CI/CD systems where small packages are a lot easier to deal with
> e.g. kernel rpm built using binrpm-pkg on Fedora 36 default 5.19.8 kernel
> config and localmodconfig goes from 255MB to 65MB which is an almost
> 4x difference.
>
> To skip adding vmlinux.bz2 to the built rpm add SKIP_RPM_VMLINUX
> environment variable which when set to "y", e.g. via
> "SKIP_RPM_VMLINUX=y make binrpm-pkg" won't include vmlinux.bz2 in the
> built rpm.
>
> Signed-off-by: Zack Rusin <zackr@vmware.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  scripts/package/mkspec | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index 7c477ca7dc98..5a71fc0852b0 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -23,6 +23,12 @@ else
>         M=DEL
>  fi
>
> +if [ "$RPM_SKIP_VMLINUX" = y ]; then
> +       D=DEL
> +else
> +       D=
> +fi
> +
>  if grep -q CONFIG_DRM=y .config; then
>         PROVIDES=kernel-drm
>  fi
> @@ -94,8 +100,8 @@ $M   $MAKE %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} modules_install
>         $MAKE %{?_smp_mflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
>         cp System.map %{buildroot}/boot/System.map-$KERNELRELEASE
>         cp .config %{buildroot}/boot/config-$KERNELRELEASE
> -       bzip2 -9 --keep vmlinux
> -       mv vmlinux.bz2 %{buildroot}/boot/vmlinux-$KERNELRELEASE.bz2
> +$D     bzip2 -9 --keep vmlinux
> +$D     mv vmlinux.bz2 %{buildroot}/boot/vmlinux-$KERNELRELEASE.bz2
>  $S$M   rm -f %{buildroot}/lib/modules/$KERNELRELEASE/build
>  $S$M   rm -f %{buildroot}/lib/modules/$KERNELRELEASE/source
>  $S$M   mkdir -p %{buildroot}/usr/src/kernels/$KERNELRELEASE
> --
> 2.34.1
>




This came from fc370ecfdb37b853bd8e2118c7ad9f99fa9ac5cd
I do not know how useful or annoying it is.
Presumably, it was a cheesy work, and rather annoying than useful.


In debian (scripts/package/mkdebian), this kind of stuff is
a separate debug package, and only built when CONFIG_DEBUG_INFO=y.


Take more time in case somebody may come up with a better idea.



--
Best Regards
Masahiro Yamada
