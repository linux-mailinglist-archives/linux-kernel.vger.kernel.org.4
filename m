Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647A86EBF2C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 13:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjDWLx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 07:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjDWLxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 07:53:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F5A10FB
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 04:53:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8827A60F5B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 11:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CBEC4339B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 11:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682250801;
        bh=X+sbObsU1oDdS5e7sEldotkYUCOqXo/AJ1qRTLl9jn0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GzeHyBNvLHYkPO30vwA50t1CB02as2ijYaSb89KZ36QahsSuXz3gCLV76eaAE9M0k
         9DZArwQ4PQkqZODuprWF10iVuzDy/eSlbrSjVXrP6HO0ckRPprKUxVB6XNUqhFHi7s
         MshdTHaernjE3jr0Yzro/kRX600Aj+qADIm7aS4ZfqwfkdHvj5J8pCtDX/hCMmWDZJ
         7P3G01729Tvdnv0s7kZoW5hEhZ4NIjQ9TFumQ1hjymXAIsshfkIk5PA3ONSnIJ9ydS
         ECuEclXk2hrVBZpkhDRbdbl1qYTzxgQA68/y+ab0Gj/jq9czfGlhgq6THJeOcOxZ0J
         6lBcGtjw9hYKQ==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-38e0a003abdso1774941b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 04:53:21 -0700 (PDT)
X-Gm-Message-State: AAQBX9ek9mUO3H/EswVBLf+ZzAYZb2neXfqY7igp5br4ac03ARxsbVBA
        cwuEUb9tsmn3jnp/iVDRABlz9pv95bZ3cvmZDQk=
X-Google-Smtp-Source: AKy350ZdqAk/bagzKltw9INzza/cprntJFAOypUK7gsb5ygRExYQevVKeL7xa6D1048ux0RNU/K3mEUuLvsdSccTfD4=
X-Received: by 2002:a54:4e0e:0:b0:38e:126:1334 with SMTP id
 a14-20020a544e0e000000b0038e01261334mr4778152oiy.22.1682250801208; Sun, 23
 Apr 2023 04:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230420010029.2702543-1-elsk@google.com>
In-Reply-To: <20230420010029.2702543-1-elsk@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 23 Apr 2023 20:52:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQxmi7GadEs2b6PA-6R1veRRL0+NW-hmpE1HrhzWKX33g@mail.gmail.com>
Message-ID: <CAK7LNAQxmi7GadEs2b6PA-6R1veRRL0+NW-hmpE1HrhzWKX33g@mail.gmail.com>
Subject: Re: [PATCH v2] kheaders: Follow symlinks to source files.
To:     Yifan Hong <elsk@google.com>
Cc:     Nicolas Schier <nicolas@fjasle.eu>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Matthias Maennich <maennich@google.com>,
        Daniel Mentz <danielmentz@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 10:01=E2=80=AFAM Yifan Hong <elsk@google.com> wrote=
:
>
> When the kernel is built inside a sandbox container,
> a forest of symlinks to the source files may be
> created in the container. In this case, the generated
> kheaders.tar.xz should follow these symlinks
> to access the source files, instead of packing
> the symlinks themselves.
>
> Signed-off-by: Yifan Hong <elsk@google.com>
> Reviewed-by: Matthias Maennich <maennich@google.com>



Please teach me how to reproduce your problem.



I built the kernel inside a container,
but I do not see any difference.



We have some symbolic links in include/,
but those reference relative paths.
How building the kernel in a container
makes a difference?


masahiro@bc5c2c958b53:/tmp/foo$ tar Jxf kheaders_data.tar.xz
masahiro@bc5c2c958b53:/tmp/foo$ find . -type l
./include/dt-bindings/clock/qcom,dispcc-sm8350.h
./include/dt-bindings/clock/qcom,dispcc-sm8150.h
./include/dt-bindings/input/linux-event-codes.h
masahiro@bc5c2c958b53:/tmp/foo$ find . -type l | xargs ls -l
lrwxrwxrwx 1 masahiro masahiro 20 Apr 23 11:47
./include/dt-bindings/clock/qcom,dispcc-sm8150.h ->
qcom,dispcc-sm8250.h
lrwxrwxrwx 1 masahiro masahiro 20 Apr 23 11:47
./include/dt-bindings/clock/qcom,dispcc-sm8350.h ->
qcom,dispcc-sm8250.h
lrwxrwxrwx 1 masahiro masahiro 36 Apr 23 11:47
./include/dt-bindings/input/linux-event-codes.h ->
../../uapi/linux/input-event-codes.h












> ---
>  kernel/gen_kheaders.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
> index 1ef9a87511f5..70a75a9a7535 100755
> --- a/kernel/gen_kheaders.sh
> +++ b/kernel/gen_kheaders.sh
> @@ -87,7 +87,7 @@ find $cpio_dir -type f -print0 |
>  # pre-sorted, as --sort=3Dname might not be available.
>  find $cpio_dir -printf "./%P\n" | LC_ALL=3DC sort | \
>      tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=3D$KBUILD_BUILD_TIMESTAMP}" \
> -    --owner=3D0 --group=3D0 --numeric-owner --no-recursion \
> +    --owner=3D0 --group=3D0 --numeric-owner --no-recursion --dereference=
 \
>      -I $XZ -cf $tarfile -C $cpio_dir/ -T - > /dev/null
>
>  echo $headers_md5 > kernel/kheaders.md5
> --
> 2.40.0.634.g4ca3ef3211-goog
>


--=20
Best Regards
Masahiro Yamada
