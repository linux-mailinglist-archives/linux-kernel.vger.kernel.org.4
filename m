Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290B65E9810
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 04:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiIZCr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 22:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiIZCry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 22:47:54 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E4226577;
        Sun, 25 Sep 2022 19:47:52 -0700 (PDT)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 28Q2lTeD025985;
        Mon, 26 Sep 2022 11:47:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 28Q2lTeD025985
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664160450;
        bh=xf9YyPqS/WeTd7w3lQS4SQg40kn5xkUipLRnEdNHX9E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pa329+GvZ6PTFniS+s1A9lPZ7Tafb3t8mjHWTDJYPc4zUllFvmfATK3K14IHao9WJ
         qfPS9uJDsbCjZjJM9D57BfM78+C+iDhQDgOJ85i8PSvLtYTAkVIWnF+EK6Pjd1SAmZ
         jKfKTLtDYgn+/dcXWsALLE6qcFBbqTMPiF+3pepi3yJhzpBSc6lm4StMmfu04TEwct
         4BGG8nTaAWjieFyYUjWFqj0EDhudMWICGQHHOM4O1eF7dBHUZgsV0xP4VvH72YGEme
         ULw++hBv5smUngiSEOWyG5KmI2Bh4VGh9eI0KgcfvomlPJ8k7K2Q+yrgsW9ALFPHeq
         /JN9Vsd/xjN5A==
X-Nifty-SrcIP: [209.85.210.47]
Received: by mail-ot1-f47.google.com with SMTP id h9-20020a9d5549000000b0063727299bb4so3635681oti.9;
        Sun, 25 Sep 2022 19:47:29 -0700 (PDT)
X-Gm-Message-State: ACrzQf03jEdr5+o5B/AQwnr8EgfyXYO6DbL//dQpx9QEzBVgmos1cklM
        miBdjOpy9grRYqKtWr7WElzytzC1wL6vqWdMhIM=
X-Google-Smtp-Source: AMsMyM6PRyp3qwcTl3epvzqjVqNAjZo6u3sYmN+OOEaTnRflQ/FOXUYuC6xmWBlI5Q/EdWDzXjXIBYqqDR1vlqLqtxk=
X-Received: by 2002:a05:6830:3115:b0:658:ea61:249c with SMTP id
 b21-20020a056830311500b00658ea61249cmr9172929ots.225.1664160448984; Sun, 25
 Sep 2022 19:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220916124112.1175522-1-scgl@linux.ibm.com>
In-Reply-To: <20220916124112.1175522-1-scgl@linux.ibm.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 26 Sep 2022 11:46:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQQmcz96rxpUmnctZidOTTvcSo51Z=iBme_Q9bvA5Fasw@mail.gmail.com>
Message-ID: <CAK7LNAQQmcz96rxpUmnctZidOTTvcSo51Z=iBme_Q9bvA5Fasw@mail.gmail.com>
Subject: Re: [RFC PATCH] kbuild: rpm-pkg: fix breakage when V=1 is used
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Sep 16, 2022 at 9:41 PM Janis Schoetterl-Glausch
<scgl@linux.ibm.com> wrote:
>
> Doing make V=3D1 binrpm-pkg results in:
>
>  Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.EgV6qJ
>  + umask 022
>  + cd .
>  + /bin/rm -rf /home/scgl/rpmbuild/BUILDROOT/kernel-6.0.0_rc5+-1.s390x
>  + /bin/mkdir -p /home/scgl/rpmbuild/BUILDROOT
>  + /bin/mkdir /home/scgl/rpmbuild/BUILDROOT/kernel-6.0.0_rc5+-1.s390x
>  + mkdir -p /home/scgl/rpmbuild/BUILDROOT/kernel-6.0.0_rc5+-1.s390x/boot
>  + make -f ./Makefile image_name
>  + cp test -e include/generated/autoconf.h -a -e include/config/auto.conf=
 || ( \ echo >&2; \ echo >&2 " ERROR: Kernel configuration is invalid."; \ =
echo >&2 " include/generated/autoconf.h or include/config/auto.conf are mis=
sing.";\ echo >&2 " Run 'make oldconfig && make prepare' on kernel src to f=
ix it."; \ echo >&2 ; \ /bin/false) arch/s390/boot/bzImage /home/scgl/rpmbu=
ild/BUILDROOT/kernel-6.0.0_rc5+-1.s390x/boot/vmlinuz-6.0.0-rc5+
>  cp: invalid option -- 'e'
>  Try 'cp --help' for more information.
>  error: Bad exit status from /var/tmp/rpm-tmp.EgV6qJ (%install)
>
> Because the make call to get the image name is verbose and prints
> additional information.
>
> Fixes: 21b42eb46834 ("kbuild: rpm-pkg: fix binrpm-pkg breakage when O=3D =
is used")


This Fixes tag is wrong.



I replaced it with:

  Fixes: 993bdde94547 ("kbuild: add image_name to no-sync-config-targets")



Applied to linux-kbuild. Thanks.











> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>
>
> I don't know much about Kbuild so there may be better ways to fix this.
>
>
>  scripts/package/mkspec | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index 8fa7c5b8a1a1..c920c1b18e7a 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -88,10 +88,10 @@ $S
>         mkdir -p %{buildroot}/boot
>         %ifarch ia64
>         mkdir -p %{buildroot}/boot/efi
> -       cp \$($MAKE image_name) %{buildroot}/boot/efi/vmlinuz-$KERNELRELE=
ASE
> +       cp \$($MAKE -s image_name) %{buildroot}/boot/efi/vmlinuz-$KERNELR=
ELEASE
>         ln -s efi/vmlinuz-$KERNELRELEASE %{buildroot}/boot/
>         %else
> -       cp \$($MAKE image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
> +       cp \$($MAKE -s image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEA=
SE
>         %endif
>  $M     $MAKE %{?_smp_mflags} INSTALL_MOD_PATH=3D%{buildroot} modules_ins=
tall
>         $MAKE %{?_smp_mflags} INSTALL_HDR_PATH=3D%{buildroot}/usr headers=
_install
> --
> 2.34.1
>


--=20
Best Regards
Masahiro Yamada
