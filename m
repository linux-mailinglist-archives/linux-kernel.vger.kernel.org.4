Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797AC750A91
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbjGLOPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbjGLOPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:15:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE561995;
        Wed, 12 Jul 2023 07:15:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4C95617E5;
        Wed, 12 Jul 2023 14:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564E3C433CC;
        Wed, 12 Jul 2023 14:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689171310;
        bh=by9pgSs091khOfV5UGPr4u/YkRYsIghGJCqG/Dm2vrU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r4SsVzTITyewNYb8iF71bwHYlSJ1zjHEbUWtlSbzqTJmXbSkA1NM9ZzV6yIYDVH5j
         W5qTGQ44E6vLu/E0CbnMQAv9kb7fIjXjUjGsME+bCgF99NbM0oXcKLbGF83fcig63C
         t5RI6I3APWoDsRznA+AFEYZvtXqGNplFCD7yFmbOlP1B5sb2jv5x2E0TIsJcb+LxRh
         HXLln6oTb6zqN789pXnhmKwZZw1L+tYUtuib32FuYqxK4JdDGEJD5zH6I0XsHMSQgS
         e5aYTFx5rFXIFSa3NIcH/8+ToWEdoUzVkEPJYlVeC0HM/Y4kVYaqz+I5UYwZR9J6vS
         abPfNss5BAa4g==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1b730eb017bso2603073fac.1;
        Wed, 12 Jul 2023 07:15:10 -0700 (PDT)
X-Gm-Message-State: ABy/qLbwd6eWrn+8dA6UGkGmNZlr1zhetYfnKBb6mRg2IAW/xPA91um2
        5Uc+Xgl+bhK5LIgxdRIspOCkWWWeEGW9Q3ewMuE=
X-Google-Smtp-Source: APBJJlHqSuREpplzuUnq/e0Cwp3ptkilbznNXoHaJD9YLmWY5rVy+KcNBAlzSuPTI0zvei6I6nzzkIEy8Oqpzj+AxCQ=
X-Received: by 2002:a05:6870:fba7:b0:1b0:3075:2f9d with SMTP id
 kv39-20020a056870fba700b001b030752f9dmr19101840oab.34.1689171309578; Wed, 12
 Jul 2023 07:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <da2fdd15-fae1-2bf6-04e7-568c715372ce@kernel.org> <20230712134533.4419-1-msuchanek@suse.de>
In-Reply-To: <20230712134533.4419-1-msuchanek@suse.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 12 Jul 2023 23:14:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNATRikmr5bO9WvWAvqHFmkv1sqAPY_WouXb4+6HCTj56MQ@mail.gmail.com>
Message-ID: <CAK7LNATRikmr5bO9WvWAvqHFmkv1sqAPY_WouXb4+6HCTj56MQ@mail.gmail.com>
Subject: Re: [PATCH v2--to=linux-modules@vger.kernel.org] depmod: Handle
 installing modules under a prefix
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 10:45=E2=80=AFPM Michal Suchanek <msuchanek@suse.de=
> wrote:
>
> Some distributions aim at not shipping any files in / ustside of usr.
>
> The path under which kernel modules are instaleld is hardcoded to /lib
> which conflicts with this goal.
>
> When kmod provides the config command use it to determine the correct
> module installation prefix.
>
> On kmod that does not provide the command / is used as before.
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v2: Avoid error on systems with kmod that does not support config
> command
> ---
>  Makefile          | 4 +++-
>  scripts/depmod.sh | 8 ++++----
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 47690c28456a..b1fea135bdec 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1165,7 +1165,9 @@ export INSTALL_DTBS_PATH ?=3D $(INSTALL_PATH)/dtbs/=
$(KERNELRELEASE)
>  # makefile but the argument can be passed to make if needed.
>  #
>
> -MODLIB =3D $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> +export KERNEL_MODULE_PREFIX :=3D $(shell kmod config &> /dev/null && kmo=
d config | jq -r .module_prefix)
> +
> +MODLIB =3D $(INSTALL_MOD_PATH)$(KERNEL_MODULE_PREFIX)/lib/modules/$(KERN=
ELRELEASE)



You can do "make modules_install INSTALL_MOD_PATH=3D/usr/what/ever/prefix"


This patch is unneeded.












>  export MODLIB
>
>  PHONY +=3D prepare0
> diff --git a/scripts/depmod.sh b/scripts/depmod.sh
> index 3643b4f896ed..88ac79056153 100755
> --- a/scripts/depmod.sh
> +++ b/scripts/depmod.sh
> @@ -27,16 +27,16 @@ fi
>  # numbers, so we cheat with a symlink here
>  depmod_hack_needed=3Dtrue
>  tmp_dir=3D$(mktemp -d ${TMPDIR:-/tmp}/depmod.XXXXXX)
> -mkdir -p "$tmp_dir/lib/modules/$KERNELRELEASE"
> +mkdir -p "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE"
>  if "$DEPMOD" -b "$tmp_dir" $KERNELRELEASE 2>/dev/null; then
> -       if test -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep" -o \
> -               -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep.bin";=
 then
> +       if test -e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELE=
ASE/modules.dep" -o \
> +               -e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELE=
ASE/modules.dep.bin"; then
>                 depmod_hack_needed=3Dfalse
>         fi
>  fi
>  rm -rf "$tmp_dir"
>  if $depmod_hack_needed; then
> -       symlink=3D"$INSTALL_MOD_PATH/lib/modules/99.98.$KERNELRELEASE"
> +       symlink=3D"$INSTALL_MOD_PATH$KERNEL_MODULE_PREFIX/lib/modules/99.=
98.$KERNELRELEASE"
>         ln -s "$KERNELRELEASE" "$symlink"
>         KERNELRELEASE=3D99.98.$KERNELRELEASE
>  fi
> --
> 2.41.0
>


--=20
Best Regards
Masahiro Yamada
