Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C550C6E34DC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 06:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjDPEHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 00:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDPEHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 00:07:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BE62103;
        Sat, 15 Apr 2023 21:07:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39DDF60BAF;
        Sun, 16 Apr 2023 04:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9486CC4339B;
        Sun, 16 Apr 2023 04:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681618033;
        bh=PnZee4ox3MN3wDRCOgcUawCEXDLiUISLzgnloY07THY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RdSJrKtJVHsXZ7GotEqMxSNZj+oohUOyTIhUs1FshyuiAwM2VsHoExNbaf/o0M96+
         PMBy7tZooX6jekPLD+Y9a68fR0pVQXiHfi118vHPEzTfCmSyMNo4xtG7HWh6+6zIPv
         LmEjD28/iru2wBEEX7qlHun0J4sM9NDP7L946MZX2tgGbtiqckm/uB8jzrW7uGIdix
         b7mNqbefdpv03RvrKaUuAbXnb/pubeDXU/OKxaf2s14QkglGX0i12W2fNl8SmEB+qz
         yv4Fruq+/XLaTykNm72dwMSL0ulMaBBnxjC0JI1gEfi2KdDnYX0VgMlC314nBddkmT
         PsMvcG91UO3/A==
Received: by mail-oi1-f173.google.com with SMTP id be20so685687oib.4;
        Sat, 15 Apr 2023 21:07:13 -0700 (PDT)
X-Gm-Message-State: AAQBX9dX3bicB9cPdt6RorxjTXB//Ii3U5BFc6fcJ1cEe0SjyfBpTXMh
        h0Le6L+tI2Csp3O1ZGhlOAauY70AKjUQe61okR0=
X-Google-Smtp-Source: AKy350YBI8d2ttMFXHqS85NoLj8ZZ1npjgQElgKAnQ9Sei6c44WhVKj5yko+6aKtmr2PoeRtxtZ0iXWJ3etOJ+wzePE=
X-Received: by 2002:aca:a84b:0:b0:38c:b261:33e2 with SMTP id
 r72-20020acaa84b000000b0038cb26133e2mr591742oie.11.1681618032878; Sat, 15 Apr
 2023 21:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230320040839.660475-1-bgray@linux.ibm.com> <20230320040839.660475-2-bgray@linux.ibm.com>
In-Reply-To: <20230320040839.660475-2-bgray@linux.ibm.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 16 Apr 2023 13:06:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNASxnyFmM1JhuDatQfb4WMy616LzAqS3JzmNxb3wJGA52g@mail.gmail.com>
Message-ID: <CAK7LNASxnyFmM1JhuDatQfb4WMy616LzAqS3JzmNxb3wJGA52g@mail.gmail.com>
Subject: Re: [PATCH 2/2] initramfs: Encode dependency on KBUILD_BUILD_TIMESTAMP
To:     Benjamin Gray <bgray@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
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

On Mon, Mar 20, 2023 at 1:09=E2=80=AFPM Benjamin Gray <bgray@linux.ibm.com>=
 wrote:
>
> gen_initramfs.sh has an internal dependency on KBUILD_BUILD_TIMESTAMP
> for generating file mtimes that is not exposed to make, so changing
> KBUILD_BUILD_TIMESTAMP will not trigger a rebuild of the archive.
>
> Declare the mtime date as a new parameter to gen_initramfs.sh to encode
> KBUILD_BUILD_TIMESTAMP in the shell command, thereby making make aware
> of the dependency.
>
> It will rebuild if KBUILD_BUILD_TIMESTAMP changes or is newly set/unset.
> It will _not_ rebuild if KBUILD_BUILD_TIMESTAMP is unset before and
> after. This should be fine for anyone who doesn't care about setting
> specific build times in the first place.
>
> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
>
> ---
>
> Ran into this while debugging the issue in the first patch. Made for a
> very perplexing debug session before we worked out the state wasn't
> being rebuilt.
> ---
>  usr/Makefile         |  2 ++
>  usr/gen_initramfs.sh | 16 +++++++++-------
>  2 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/usr/Makefile b/usr/Makefile
> index 59d9e8b07a01..2aa386cf48d6 100644
> --- a/usr/Makefile
> +++ b/usr/Makefile
> @@ -64,6 +64,7 @@ quiet_cmd_initfs =3D GEN     $@
>         $(CONFIG_SHELL) $< -o $@ -l $(obj)/.initramfs_data.cpio.d \
>         $(if $(CONFIG_INITRAMFS_ROOT_UID), -u $(CONFIG_INITRAMFS_ROOT_UID=
)) \
>         $(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID=
)) \
> +       $(if $(KBUILD_BUILD_TIMESTAMP), -d $(KBUILD_BUILD_TIMESTAMP)) \
>         $(ramfs-input)



If I apply this patch, I see a build error.


$ make -j16 KBUILD_BUILD_TIMESTAMP=3D"$(date)"
[snip]
  GEN     usr/initramfs_data.cpio
  usr/gen_initramfs.sh: Cannot open 'Apr'
make[2]: *** [usr/Makefile:76: usr/initramfs_data.cpio] Error 1
make[1]: *** [scripts/Makefile.build:494: usr] Error 2
make[1]: *** Waiting for unfinished jobs....




Because KBUILD_BUILD_TIMESTAMP may contain spaces
depending on the format, init/Makefile and
kernel/gen_kheaders.sh surround the date with
double-quotes.


Double-quoting it in the same way fixes the issue.

$(if $(KBUILD_BUILD_TIMESTAMP), -d "$(KBUILD_BUILD_TIMESTAMP)") \







>  # We rebuild initramfs_data.cpio if:
> @@ -71,6 +72,7 @@ quiet_cmd_initfs =3D GEN     $@
>  # 2) There are changes in which files are included (added or deleted)
>  # 3) If gen_init_cpio are newer than initramfs_data.cpio
>  # 4) Arguments to gen_initramfs.sh changes
> +# 5) KBUILD_BUILD_TIMESTAMP is changed


This is unneeded because the change of KBUILD_BUILD_TIMESTAMP
is contained in

  4) Arguments to gen_initramfs.sh changes







>  $(obj)/initramfs_data.cpio: $(src)/gen_initramfs.sh $(obj)/gen_init_cpio=
 $(deps_initramfs) FORCE
>         $(call if_changed,initfs)
>
> diff --git a/usr/gen_initramfs.sh b/usr/gen_initramfs.sh
> index 63476bb70b41..14b5782f961a 100755
> --- a/usr/gen_initramfs.sh
> +++ b/usr/gen_initramfs.sh
> @@ -23,6 +23,7 @@ $0 [-o <file>] [-l <dep_list>] [-u <uid>] [-g <gid>] {-=
d | <cpio_source>} ...
>         -g <gid>       Group ID to map to group ID 0 (root).
>                        <gid> is only meaningful if <cpio_source> is a
>                        directory.  "squash" forces all files to gid 0.
> +       -d <date>      Use date for all file mtime values
>         <cpio_source>  File list or directory for cpio archive.
>                        If <cpio_source> is a .cpio file it will be used
>                        as direct input to initramfs.
> @@ -190,6 +191,7 @@ prog=3D$0
>  root_uid=3D0
>  root_gid=3D0
>  dep_list=3D
> +timestamp=3D
>  cpio_list=3D$(mktemp ${TMPDIR:-/tmp}/cpiolist.XXXXXX)
>  output=3D"/dev/stdout"
>
> @@ -218,6 +220,13 @@ while [ $# -gt 0 ]; do
>                         [ "$root_gid" =3D "-1" ] && root_gid=3D$(id -g ||=
 echo 0)
>                         shift
>                         ;;
> +               "-d")   # date for file mtimes
> +                       timestamp=3D"$(date -d"$1" +%s || :)"
> +                       if test -n "$timestamp"; then
> +                               timestamp=3D"-t $timestamp"
> +                       fi
> +                       shift
> +                       ;;
>                 "-h")
>                         usage
>                         exit 0
> @@ -237,11 +246,4 @@ done
>
>  # If output_file is set we will generate cpio archive
>  # we are careful to delete tmp files
> -timestamp=3D
> -if test -n "$KBUILD_BUILD_TIMESTAMP"; then
> -       timestamp=3D"$(date -d"$KBUILD_BUILD_TIMESTAMP" +%s || :)"
> -       if test -n "$timestamp"; then
> -               timestamp=3D"-t $timestamp"
> -       fi
> -fi
>  usr/gen_init_cpio $timestamp $cpio_list > $output
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada
