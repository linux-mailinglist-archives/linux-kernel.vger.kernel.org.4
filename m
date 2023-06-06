Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9669672361B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 06:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjFFEPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 00:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjFFEPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 00:15:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4993019C;
        Mon,  5 Jun 2023 21:15:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0ED660F86;
        Tue,  6 Jun 2023 04:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386EFC433D2;
        Tue,  6 Jun 2023 04:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686024906;
        bh=Od/bHhg0mh5/O3YymVaYAnl0Fy8AHuUbXq38QM7b+UQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bzCCU41b2lTlziqim5NhE1r5uGjcWm6z5ZyLGf0vnpZ27sye6llix+EVKPpO9ztQH
         JEZLtDmUwO4YiFIy9i0nBUtE+I31FZxezMnDrwvOL6HRgLsifd4S6ONMGAND5tjUOT
         WiBycObL7NulmD9aNphW7ikkErYQeY4HI//BvHKUsGnKwtIqR68h5CdXZwcURuRDO+
         kFzXuCmwZ3xSZ0X1Z8AYiT6f4qpyLZ/chUWhBtha+PZORYGMV2a4f6+4LWMbuSPI1x
         7ll8NJbEENfXaHN5XmgNc8aJW4kbkc0AlsN8KEdUMCdkjjUtmQ4nVhrr4GnVak1p/2
         tuTQi1+689TMw==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-558c8a109bdso1216019eaf.1;
        Mon, 05 Jun 2023 21:15:06 -0700 (PDT)
X-Gm-Message-State: AC+VfDxWdpv21Utcuw//W4YE9ACn1C6bcY8wvr+AIGRiecxNz6s3YBNR
        O5Zm36JjCUElCNZfeHcP/84X9Y8x1+tcTGAYN6U=
X-Google-Smtp-Source: ACHHUZ5OipTD4V2c6pTFhL/mAmtr5LfBHiYiTJFqWcB+mmJ4Z/LzUxduihDM4YhZCufQjCANCzqumTqAV31H6Poixvg=
X-Received: by 2002:aca:f102:0:b0:38e:e5b5:493e with SMTP id
 p2-20020acaf102000000b0038ee5b5493emr5092385oih.11.1686024905406; Mon, 05 Jun
 2023 21:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230320040839.660475-1-bgray@linux.ibm.com> <20230320040839.660475-2-bgray@linux.ibm.com>
 <CAK7LNASxnyFmM1JhuDatQfb4WMy616LzAqS3JzmNxb3wJGA52g@mail.gmail.com>
In-Reply-To: <CAK7LNASxnyFmM1JhuDatQfb4WMy616LzAqS3JzmNxb3wJGA52g@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 6 Jun 2023 13:14:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT=kuXeKDiPLgVwxZAW3OHXwjreU9-o+fGK3Phgks+-PA@mail.gmail.com>
Message-ID: <CAK7LNAT=kuXeKDiPLgVwxZAW3OHXwjreU9-o+fGK3Phgks+-PA@mail.gmail.com>
Subject: Re: [PATCH 2/2] initramfs: Encode dependency on KBUILD_BUILD_TIMESTAMP
To:     Benjamin Gray <bgray@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,


I like this patch.

Will you send v2 with fixes I pointed out?
(add double-quotes and remove the unneeded comment)


On Sun, Apr 16, 2023 at 1:06=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Mon, Mar 20, 2023 at 1:09=E2=80=AFPM Benjamin Gray <bgray@linux.ibm.co=
m> wrote:
> >
> > gen_initramfs.sh has an internal dependency on KBUILD_BUILD_TIMESTAMP
> > for generating file mtimes that is not exposed to make, so changing
> > KBUILD_BUILD_TIMESTAMP will not trigger a rebuild of the archive.
> >
> > Declare the mtime date as a new parameter to gen_initramfs.sh to encode
> > KBUILD_BUILD_TIMESTAMP in the shell command, thereby making make aware
> > of the dependency.
> >
> > It will rebuild if KBUILD_BUILD_TIMESTAMP changes or is newly set/unset=
.
> > It will _not_ rebuild if KBUILD_BUILD_TIMESTAMP is unset before and
> > after. This should be fine for anyone who doesn't care about setting
> > specific build times in the first place.
> >
> > Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
> >
> > ---
> >
> > Ran into this while debugging the issue in the first patch. Made for a
> > very perplexing debug session before we worked out the state wasn't
> > being rebuilt.
> > ---
> >  usr/Makefile         |  2 ++
> >  usr/gen_initramfs.sh | 16 +++++++++-------
> >  2 files changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/usr/Makefile b/usr/Makefile
> > index 59d9e8b07a01..2aa386cf48d6 100644
> > --- a/usr/Makefile
> > +++ b/usr/Makefile
> > @@ -64,6 +64,7 @@ quiet_cmd_initfs =3D GEN     $@
> >         $(CONFIG_SHELL) $< -o $@ -l $(obj)/.initramfs_data.cpio.d \
> >         $(if $(CONFIG_INITRAMFS_ROOT_UID), -u $(CONFIG_INITRAMFS_ROOT_U=
ID)) \
> >         $(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_G=
ID)) \
> > +       $(if $(KBUILD_BUILD_TIMESTAMP), -d $(KBUILD_BUILD_TIMESTAMP)) \
> >         $(ramfs-input)
>
>
>
> If I apply this patch, I see a build error.
>
>
> $ make -j16 KBUILD_BUILD_TIMESTAMP=3D"$(date)"
> [snip]
>   GEN     usr/initramfs_data.cpio
>   usr/gen_initramfs.sh: Cannot open 'Apr'
> make[2]: *** [usr/Makefile:76: usr/initramfs_data.cpio] Error 1
> make[1]: *** [scripts/Makefile.build:494: usr] Error 2
> make[1]: *** Waiting for unfinished jobs....
>
>
>
>
> Because KBUILD_BUILD_TIMESTAMP may contain spaces
> depending on the format, init/Makefile and
> kernel/gen_kheaders.sh surround the date with
> double-quotes.
>
>
> Double-quoting it in the same way fixes the issue.
>
> $(if $(KBUILD_BUILD_TIMESTAMP), -d "$(KBUILD_BUILD_TIMESTAMP)") \
>
>
>
>
>
>
>
> >  # We rebuild initramfs_data.cpio if:
> > @@ -71,6 +72,7 @@ quiet_cmd_initfs =3D GEN     $@
> >  # 2) There are changes in which files are included (added or deleted)
> >  # 3) If gen_init_cpio are newer than initramfs_data.cpio
> >  # 4) Arguments to gen_initramfs.sh changes
> > +# 5) KBUILD_BUILD_TIMESTAMP is changed
>
>
> This is unneeded because the change of KBUILD_BUILD_TIMESTAMP
> is contained in
>
>   4) Arguments to gen_initramfs.sh changes
>
>
>
>
>
>
>
> >  $(obj)/initramfs_data.cpio: $(src)/gen_initramfs.sh $(obj)/gen_init_cp=
io $(deps_initramfs) FORCE
> >         $(call if_changed,initfs)
> >
> > diff --git a/usr/gen_initramfs.sh b/usr/gen_initramfs.sh
> > index 63476bb70b41..14b5782f961a 100755
> > --- a/usr/gen_initramfs.sh
> > +++ b/usr/gen_initramfs.sh
> > @@ -23,6 +23,7 @@ $0 [-o <file>] [-l <dep_list>] [-u <uid>] [-g <gid>] =
{-d | <cpio_source>} ...
> >         -g <gid>       Group ID to map to group ID 0 (root).
> >                        <gid> is only meaningful if <cpio_source> is a
> >                        directory.  "squash" forces all files to gid 0.
> > +       -d <date>      Use date for all file mtime values
> >         <cpio_source>  File list or directory for cpio archive.
> >                        If <cpio_source> is a .cpio file it will be used
> >                        as direct input to initramfs.
> > @@ -190,6 +191,7 @@ prog=3D$0
> >  root_uid=3D0
> >  root_gid=3D0
> >  dep_list=3D
> > +timestamp=3D
> >  cpio_list=3D$(mktemp ${TMPDIR:-/tmp}/cpiolist.XXXXXX)
> >  output=3D"/dev/stdout"
> >
> > @@ -218,6 +220,13 @@ while [ $# -gt 0 ]; do
> >                         [ "$root_gid" =3D "-1" ] && root_gid=3D$(id -g =
|| echo 0)
> >                         shift
> >                         ;;
> > +               "-d")   # date for file mtimes
> > +                       timestamp=3D"$(date -d"$1" +%s || :)"
> > +                       if test -n "$timestamp"; then
> > +                               timestamp=3D"-t $timestamp"
> > +                       fi
> > +                       shift
> > +                       ;;
> >                 "-h")
> >                         usage
> >                         exit 0
> > @@ -237,11 +246,4 @@ done
> >
> >  # If output_file is set we will generate cpio archive
> >  # we are careful to delete tmp files
> > -timestamp=3D
> > -if test -n "$KBUILD_BUILD_TIMESTAMP"; then
> > -       timestamp=3D"$(date -d"$KBUILD_BUILD_TIMESTAMP" +%s || :)"
> > -       if test -n "$timestamp"; then
> > -               timestamp=3D"-t $timestamp"
> > -       fi
> > -fi
> >  usr/gen_init_cpio $timestamp $cpio_list > $output
> > --
> > 2.39.2
> >
>
>
> --
> Best Regards
> Masahiro Yamada



--
Best Regards
Masahiro Yamada
