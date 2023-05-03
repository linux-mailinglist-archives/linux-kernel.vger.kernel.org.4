Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3DD6F5922
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjECNg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjECNg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:36:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6F41FDB
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:36:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3603D62DAF
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 13:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC98C433EF
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 13:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683121012;
        bh=C7TQFOmWvf86tU3U9VfGRcRChZc/Dow4+hbub8rpLoU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b3qQyUO8xfQ3VLwNi9Pl3lQYbscP1MetSpNny0qCb68xsB5CCDNCYbSv5dYxSPA0A
         2PilYBfdNjDa7sNqp5jx82+Sn3j+ZolPBsikZ1UIVC73LemVy16QDgb5cbtUtLbYaM
         0+/i28pyy7KLPHV3d/ejdbd1HsaTbmwHA9x7lp13FdBWIJqyHP8Bk1s59Vt8on9sLI
         Xu0jO6Db4pAwrdinHd5aq6zX4NcZ9upqoo4GzFnHZgs+6MiyDj1Pfs776gtsRZAVSS
         zYxv5hz9wTYikjNRg6hMP5uqOcJ1E//uKmjjxEAFhprXO7gJjHaF8fq3Ht6xtKHPau
         0lfICE23+5VJQ==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-38dfdc1daa9so3046411b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 06:36:52 -0700 (PDT)
X-Gm-Message-State: AC+VfDzDXvS37wx0bIfk8V7JYSaDB8DgzkiJZO89EDxk253PsCgls0+o
        EUd2Mx/XvOscr3y1837HvGPiC+IO6t5hcF+cXwk=
X-Google-Smtp-Source: ACHHUZ7IaCZQohsNbJ/ZLgjelXBJNTahEoRsLp9G4tlF7bCN+Hj1iDvdl/Rj8Hb5NlkmWICJ+3W7j89Q6SitSsrwk04=
X-Received: by 2002:a54:4e0b:0:b0:38d:ec65:aa85 with SMTP id
 a11-20020a544e0b000000b0038dec65aa85mr78484oiy.19.1683121011804; Wed, 03 May
 2023 06:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230420010029.2702543-1-elsk@google.com> <CAK7LNAQxmi7GadEs2b6PA-6R1veRRL0+NW-hmpE1HrhzWKX33g@mail.gmail.com>
 <CAABy=s39CCZ1yx11NtdgpTG95hFj6r7Q-g88qWrpdAak6dA7jw@mail.gmail.com> <CAABy=s17M5Xu_LhfrzP3vton9AK7n30PB9Hm3Z7iAHS+H5WxcA@mail.gmail.com>
In-Reply-To: <CAABy=s17M5Xu_LhfrzP3vton9AK7n30PB9Hm3Z7iAHS+H5WxcA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 3 May 2023 15:36:15 +0200
X-Gmail-Original-Message-ID: <CAK7LNATsKi28KnJkLhw1rYTAi5RRTAeCB-C9G-WYBYaYBgJhXw@mail.gmail.com>
Message-ID: <CAK7LNATsKi28KnJkLhw1rYTAi5RRTAeCB-C9G-WYBYaYBgJhXw@mail.gmail.com>
Subject: Re: [PATCH v2] kheaders: Follow symlinks to source files.
To:     Yifan Hong <elsk@google.com>
Cc:     Nicolas Schier <nicolas@fjasle.eu>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Matthias Maennich <maennich@google.com>,
        Daniel Mentz <danielmentz@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 12:17=E2=80=AFAM Yifan Hong <elsk@google.com> wrote:
>
> On Mon, Apr 24, 2023 at 11:32=E2=80=AFAM Yifan Hong <elsk@google.com> wro=
te:
> >
> > On Sun, Apr 23, 2023 at 4:53=E2=80=AFAM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > >
> > > On Thu, Apr 20, 2023 at 10:01=E2=80=AFAM Yifan Hong <elsk@google.com>=
 wrote:
> > > >
> > > > When the kernel is built inside a sandbox container,
> > > > a forest of symlinks to the source files may be
> > > > created in the container. In this case, the generated
> > > > kheaders.tar.xz should follow these symlinks
> > > > to access the source files, instead of packing
> > > > the symlinks themselves.
> > > >
> > > > Signed-off-by: Yifan Hong <elsk@google.com>
> > > > Reviewed-by: Matthias Maennich <maennich@google.com>
> > >
> > >
> > >
> > > Please teach me how to reproduce your problem.
> >
> > Thanks for your reply. When I say "container", I mean a forest of
> > symlinks that point to the original source files. Here are the steps I
> > do to mimic the sandbox that the container program creates.
> >
> > On an x86 machine, I have a linux tree checkout at /mnt/sdb/linux, and
> > an empty directory at /mnt/sdb/linux2. Then I **created this fake
> > sandbox** in /mnt/sdb/linux2 by doing:
> > ```
> > $ cd /mnt/sdb/linux
> > $ find . -type d -exec mkdir -p /mnt/sdb/linux2/{} \;
> > $ find . -type f -exec ln -sf /mnt/sdb/linux/{} /mnt/sdb/linux2/{} \;
> > ```
> >
> > Then, I cross compile an arm64 kernel with tinyconfig. Here are the
> > steps I take:
> > ```
> > export ARCH=3Darm64
> > export SUBARCH=3Darm
> > export CROSS_COMPILE=3D/home/elsk/toolchains/aarch64--glibc--stable-202=
2.08-1/bin/aarch64-linux-
> > # downloaded from https://toolchains.bootlin.com/
> > make tinyconfig; make menuconfig # then select CONFIG_SYSFS and CONFIG_=
IKHEADERS
> > make -j64
> > ```
> >
> > This will show that kheaders_data.tar.xz contains the symlinks, e.g. in=
 my case:
> > ```
> > $ tar tvf ./kernel/kheaders_data.tar.xz | head
> > [...]
> > lrwxrwxrwx 0/0               0 2023-04-24 11:19
> > ./arch/arm64/include/asm/acenv.h ->
> > /mnt/sdb/linux/./arch/arm64/include/asm/acenv.h
> > ```
> >
> > However, the issue for me is that these symlinks are no longer useful
> > under sysfs when I am booting the kernel on the target arm64 machine,
> > because it is a different machine (arm64) than the machine (x86) where
> > I compiled this kernel.
> >
> > >
> > >
> > >
> > > I built the kernel inside a container,
> > > but I do not see any difference.
> > >
> > >
> > >
> > > We have some symbolic links in include/,
> > > but those reference relative paths.
> > > How building the kernel in a container
> > > makes a difference?
> >
> > Please see above; the container contains a forest of symlinks pointing
> > to the original source tree. Then `make` is executed in that container
> > directory.
> >
> > >
> > >
> > > masahiro@bc5c2c958b53:/tmp/foo$ tar Jxf kheaders_data.tar.xz
> > > masahiro@bc5c2c958b53:/tmp/foo$ find . -type l
> > > ./include/dt-bindings/clock/qcom,dispcc-sm8350.h
> > > ./include/dt-bindings/clock/qcom,dispcc-sm8150.h
> > > ./include/dt-bindings/input/linux-event-codes.h
> > > masahiro@bc5c2c958b53:/tmp/foo$ find . -type l | xargs ls -l
> > > lrwxrwxrwx 1 masahiro masahiro 20 Apr 23 11:47
> > > ./include/dt-bindings/clock/qcom,dispcc-sm8150.h ->
> > > qcom,dispcc-sm8250.h
> > > lrwxrwxrwx 1 masahiro masahiro 20 Apr 23 11:47
> > > ./include/dt-bindings/clock/qcom,dispcc-sm8350.h ->
> > > qcom,dispcc-sm8250.h
> > > lrwxrwxrwx 1 masahiro masahiro 36 Apr 23 11:47
> > > ./include/dt-bindings/input/linux-event-codes.h ->
> > > ../../uapi/linux/input-event-codes.h
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > > > ---
> > > >  kernel/gen_kheaders.sh | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
> > > > index 1ef9a87511f5..70a75a9a7535 100755
> > > > --- a/kernel/gen_kheaders.sh
> > > > +++ b/kernel/gen_kheaders.sh
> > > > @@ -87,7 +87,7 @@ find $cpio_dir -type f -print0 |
> > > >  # pre-sorted, as --sort=3Dname might not be available.
> > > >  find $cpio_dir -printf "./%P\n" | LC_ALL=3DC sort | \
> > > >      tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=3D$KBUILD_BUILD_TIMESTA=
MP}" \
> > > > -    --owner=3D0 --group=3D0 --numeric-owner --no-recursion \
> > > > +    --owner=3D0 --group=3D0 --numeric-owner --no-recursion --deref=
erence \
> > > >      -I $XZ -cf $tarfile -C $cpio_dir/ -T - > /dev/null
> > > >
> > > >  echo $headers_md5 > kernel/kheaders.md5
> > > > --
> > > > 2.40.0.634.g4ca3ef3211-goog
> > > >
> > >
> > >
> > > --
> > > Best Regards
> > > Masahiro Yamada
> > >
> > > --
> > > To unsubscribe from this group and stop receiving emails from it, sen=
d an email to kernel-team+unsubscribe@android.com.
> > >
>
> Gently nagging. Is there anything I need to fix or do to improve this
> patch so it may be accepted? Thank you!




I guess it is better to not apply this.

Presumably, the fix will not end with this single patch.



--=20
Best Regards
Masahiro Yamada
