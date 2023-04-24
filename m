Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502CA6ED479
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjDXSdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjDXSdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:33:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D230C11A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:33:37 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-4af3773448fso31353a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682361216; x=1684953216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lh3jgTRgIGWqKM2IdktrZIeojJqwq3KhxD//V3mGwh8=;
        b=gkAPM+jhkSD8Z1RR8AnR45VmJkXw3cKMmJTIdiGo6o7Refy3pksA25hezvONpr+eNb
         kQ/EZ6pNCzzXNmP8FS/6ZbJHg7bvh1X5t95vPf5/0Uygq9fX94HgIABlUrG2r9HoiEq6
         9XiPCMCakG1F75YcVVSq/nZNq6iCgCAn+lGQ3jlCWOARm6+4bmbvo6+VM3eqFzrqzf02
         Ac9DA+8VODyxVdCC+ZrNeVVZIaCZ77d4I6TXGKqOLkaik5yBHo0db0aFSkbFoaSC2Rt9
         BMf5Jb/0bmUz1iYzKBqQObAiCewKNs8d8s0/+HYuoO7hsOkz7+LPk8miShQq8ZtSCpOk
         W3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682361216; x=1684953216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lh3jgTRgIGWqKM2IdktrZIeojJqwq3KhxD//V3mGwh8=;
        b=K4pAcgGz4qUAQy6pO8EvgCy0WkfvM9/GpgshMGmspIyYbxiPAyYcrT3NghRItS59F9
         L+QSvW4dqmosa3Nt12c0E3OwHBPx7PjgOXYh263qjSZv8w8M7DUcIl+18l4w0zSkLfTz
         ejHHMheTlHVyntD3BWcIafhoVmM+ntiEfm5DLniFDY2vlgcx7siT21riAxP/IicFlPGW
         cfiRH8TqPgVXfDbNpydQVdtuTdFaHs0Dj+9SEjrgEB+/K1JD48y1i0MBCedjN1kekNpJ
         ibQ8KKLp7C/055N/cFdzgCyKVkqsXN8O/JlU5DV/xEUjwrn/H7bpKXLW1eQuUkHxsVdv
         zLSQ==
X-Gm-Message-State: AC+VfDzQrp/3m4EWXy/Tfo8WtkEJFWs/du1/Ka+E5WyAD55x1y9+/5x9
        DgfvHQ1MhUZAjXK+9+jspz6VObYWAwBHWSQABu29hQ==
X-Google-Smtp-Source: ACHHUZ4OiRgiLof0f2kt65pB5NYAtK+ylGb1JgUO9awGKnVPn8BKsFvtsTwrDsGFRLDtGpp3GNi3vzkjdvk25eFkuuk=
X-Received: by 2002:a05:6402:1cd0:b0:506:77ec:5c3f with SMTP id
 ds16-20020a0564021cd000b0050677ec5c3fmr9896edb.2.1682361215807; Mon, 24 Apr
 2023 11:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230420010029.2702543-1-elsk@google.com> <CAK7LNAQxmi7GadEs2b6PA-6R1veRRL0+NW-hmpE1HrhzWKX33g@mail.gmail.com>
In-Reply-To: <CAK7LNAQxmi7GadEs2b6PA-6R1veRRL0+NW-hmpE1HrhzWKX33g@mail.gmail.com>
From:   Yifan Hong <elsk@google.com>
Date:   Mon, 24 Apr 2023 11:32:59 -0700
Message-ID: <CAABy=s39CCZ1yx11NtdgpTG95hFj6r7Q-g88qWrpdAak6dA7jw@mail.gmail.com>
Subject: Re: [PATCH v2] kheaders: Follow symlinks to source files.
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nicolas Schier <nicolas@fjasle.eu>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Matthias Maennich <maennich@google.com>,
        Daniel Mentz <danielmentz@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 4:53=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Thu, Apr 20, 2023 at 10:01=E2=80=AFAM Yifan Hong <elsk@google.com> wro=
te:
> >
> > When the kernel is built inside a sandbox container,
> > a forest of symlinks to the source files may be
> > created in the container. In this case, the generated
> > kheaders.tar.xz should follow these symlinks
> > to access the source files, instead of packing
> > the symlinks themselves.
> >
> > Signed-off-by: Yifan Hong <elsk@google.com>
> > Reviewed-by: Matthias Maennich <maennich@google.com>
>
>
>
> Please teach me how to reproduce your problem.

Thanks for your reply. When I say "container", I mean a forest of
symlinks that point to the original source files. Here are the steps I
do to mimic the sandbox that the container program creates.

On an x86 machine, I have a linux tree checkout at /mnt/sdb/linux, and
an empty directory at /mnt/sdb/linux2. Then I **created this fake
sandbox** in /mnt/sdb/linux2 by doing:
```
$ cd /mnt/sdb/linux
$ find . -type d -exec mkdir -p /mnt/sdb/linux2/{} \;
$ find . -type f -exec ln -sf /mnt/sdb/linux/{} /mnt/sdb/linux2/{} \;
```

Then, I cross compile an arm64 kernel with tinyconfig. Here are the
steps I take:
```
export ARCH=3Darm64
export SUBARCH=3Darm
export CROSS_COMPILE=3D/home/elsk/toolchains/aarch64--glibc--stable-2022.08=
-1/bin/aarch64-linux-
# downloaded from https://toolchains.bootlin.com/
make tinyconfig; make menuconfig # then select CONFIG_SYSFS and CONFIG_IKHE=
ADERS
make -j64
```

This will show that kheaders_data.tar.xz contains the symlinks, e.g. in my =
case:
```
$ tar tvf ./kernel/kheaders_data.tar.xz | head
[...]
lrwxrwxrwx 0/0               0 2023-04-24 11:19
./arch/arm64/include/asm/acenv.h ->
/mnt/sdb/linux/./arch/arm64/include/asm/acenv.h
```

However, the issue for me is that these symlinks are no longer useful
under sysfs when I am booting the kernel on the target arm64 machine,
because it is a different machine (arm64) than the machine (x86) where
I compiled this kernel.

>
>
>
> I built the kernel inside a container,
> but I do not see any difference.
>
>
>
> We have some symbolic links in include/,
> but those reference relative paths.
> How building the kernel in a container
> makes a difference?

Please see above; the container contains a forest of symlinks pointing
to the original source tree. Then `make` is executed in that container
directory.

>
>
> masahiro@bc5c2c958b53:/tmp/foo$ tar Jxf kheaders_data.tar.xz
> masahiro@bc5c2c958b53:/tmp/foo$ find . -type l
> ./include/dt-bindings/clock/qcom,dispcc-sm8350.h
> ./include/dt-bindings/clock/qcom,dispcc-sm8150.h
> ./include/dt-bindings/input/linux-event-codes.h
> masahiro@bc5c2c958b53:/tmp/foo$ find . -type l | xargs ls -l
> lrwxrwxrwx 1 masahiro masahiro 20 Apr 23 11:47
> ./include/dt-bindings/clock/qcom,dispcc-sm8150.h ->
> qcom,dispcc-sm8250.h
> lrwxrwxrwx 1 masahiro masahiro 20 Apr 23 11:47
> ./include/dt-bindings/clock/qcom,dispcc-sm8350.h ->
> qcom,dispcc-sm8250.h
> lrwxrwxrwx 1 masahiro masahiro 36 Apr 23 11:47
> ./include/dt-bindings/input/linux-event-codes.h ->
> ../../uapi/linux/input-event-codes.h
>
>
>
>
>
>
>
>
>
>
>
>
> > ---
> >  kernel/gen_kheaders.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
> > index 1ef9a87511f5..70a75a9a7535 100755
> > --- a/kernel/gen_kheaders.sh
> > +++ b/kernel/gen_kheaders.sh
> > @@ -87,7 +87,7 @@ find $cpio_dir -type f -print0 |
> >  # pre-sorted, as --sort=3Dname might not be available.
> >  find $cpio_dir -printf "./%P\n" | LC_ALL=3DC sort | \
> >      tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=3D$KBUILD_BUILD_TIMESTAMP}"=
 \
> > -    --owner=3D0 --group=3D0 --numeric-owner --no-recursion \
> > +    --owner=3D0 --group=3D0 --numeric-owner --no-recursion --dereferen=
ce \
> >      -I $XZ -cf $tarfile -C $cpio_dir/ -T - > /dev/null
> >
> >  echo $headers_md5 > kernel/kheaders.md5
> > --
> > 2.40.0.634.g4ca3ef3211-goog
> >
>
>
> --
> Best Regards
> Masahiro Yamada
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
