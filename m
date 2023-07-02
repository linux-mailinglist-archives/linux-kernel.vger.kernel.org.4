Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEED4744DA4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 14:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjGBMvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 08:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjGBMvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 08:51:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4739C183;
        Sun,  2 Jul 2023 05:51:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAA0560B6A;
        Sun,  2 Jul 2023 12:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24934C433C7;
        Sun,  2 Jul 2023 12:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688302270;
        bh=vPMOmOjUouqHPPioeMBmpzwgLs3gh1wNtLGMbw21RXo=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=tN1tBdS5T1DfNCp1xrsVAyWTrjE+SqiMyxg5FcIzq3r3YM1UdDyDyBW6oznAsdF2Y
         nNZWjlrwqmnD2U3jv3nQMckT32AOudMJ2Bvql8hmU1x4fMmDdq6LK6avltynp//agF
         tjqh0CmxCe++4dw4Nhb1S1BMCl+VetY7QM1xBtbWgcT6YZ9HyjMTxUE57gQG7qnDwK
         R45Y1YcBzU+6rP/RCba/mnmPYIDF3hoH+Gvp4RD9m8rNdDMahNo86kBrm3gnKMOch8
         UlwgAhnB3hcP/mTaSFsTzpOG2fNv2FBsklQO1XVBZTNWGLwGKREbjkl6bK2KlP8k4K
         D0MbiwaBEn79g==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1b03ec2015fso3177077fac.3;
        Sun, 02 Jul 2023 05:51:10 -0700 (PDT)
X-Gm-Message-State: ABy/qLZ5yX79yfogNe6O6pcFAvcIX4zWflJse3juwIJOEvE6PAkd6FNl
        Y+y4iDPcyf9404t1DKaeIJiapU6YuYYpBkw49yA=
X-Google-Smtp-Source: APBJJlGujvbrRsiZCLXSjigW3eUTLW4S6GaUoaxkMwbtniGarqT1lXRijNQJyuMXxJ5wbJDyOV8f867FKTWiyZ/STZU=
X-Received: by 2002:a05:6870:9a26:b0:1b0:83f5:e82a with SMTP id
 fo38-20020a0568709a2600b001b083f5e82amr11244147oab.29.1688302269289; Sun, 02
 Jul 2023 05:51:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:50d:0:b0:4e8:f6ff:2aab with HTTP; Sun, 2 Jul 2023
 05:51:08 -0700 (PDT)
In-Reply-To: <20230701055556.23632-1-machel@vivo.com>
References: <20230701055556.23632-1-machel@vivo.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sun, 2 Jul 2023 21:51:08 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_1MwLxrTRCj3e=p7MO+zyv16-NGKaK1Bjj-AfcYghx7g@mail.gmail.com>
Message-ID: <CAKYAXd_1MwLxrTRCj3e=p7MO+zyv16-NGKaK1Bjj-AfcYghx7g@mail.gmail.com>
Subject: Re: [PATCH v1] fs:smb:Fix unsigned expression compared with zero
To:     Wang Ming <machel@vivo.com>, Lu Hongfei <luhongfei@vivo.com>
Cc:     Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
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

2023-07-01 14:55 GMT+09:00, Wang Ming <machel@vivo.com>:
> The return value of the ksmbd_vfs_getcasexattr() is long.
> However, the return value is being assigned to an unsignef
> long variable 'v_len',so making 'v_len' to long. Also, when
> comparing to zero in the following code, no type conversion
> is required.
>
> silence the warning:
> ./fs/smb/server/vfs.c:WARNING: Unsigned expression compared
> with zero: v_len > 0
>
> Signed-off-by: Wang Ming <machel@vivo.com>
I have previously pointed out that we can not apply your patch.
It still has issues and can't apply. The patch sent by your
colleague(Lu Hongfei) applied without problems. Ask him for help on
what's wrong.

Please check the warnings from checkpatch.pl.

ERROR: patch seems to be corrupt (line wrapped?)
#114: FILE: fs/smb/server/vfs.c:411:
, char *buf, loff_t *pos,

WARNING: please, no spaces at the start of a line
#119: FILE: fs/smb/server/vfs.c:415:
+       size_t size;$

WARNING: please, no spaces at the start of a line
#120: FILE: fs/smb/server/vfs.c:416:
+       ssize_t v_len;$

WARNING: please, no spaces at the start of a line
#130: FILE: fs/smb/server/vfs.c:433:
+       if (v_len < 0) {$

WARNING: suspect code indent for conditional statements (7, 15)
#130: FILE: fs/smb/server/vfs.c:433:
+       if (v_len < 0) {
                pr_err("not found stream in xattr : %zd\n", v_len);

ERROR: code indent should use tabs where possible
#133: FILE: fs/smb/server/vfs.c:435:
+               err =3D3D v_len;$

WARNING: please, no spaces at the start of a line
#133: FILE: fs/smb/server/vfs.c:435:
+               err =3D3D v_len;$

ERROR: spaces required around that '=3D' (ctx:WxV)
#133: FILE: fs/smb/server/vfs.c:435:
+               err =3D3D v_len;
                    ^

total: 3 errors, 5 warnings, 22 lines checked

> ---
>  fs/smb/server/vfs.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index e35914457..e605ee96b 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -412,7 +412,8 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *=
fp,
> char *buf, loff_t *pos,
>  {
>         char *stream_buf =3D NULL, *wbuf;
>         struct mnt_idmap *idmap =3D file_mnt_idmap(fp->filp);
> -       size_t size, v_len;
> +       size_t size;
> +       ssize_t v_len;
>         int err =3D 0;
>
>         ksmbd_debug(VFS, "write stream data pos : %llu, count : %zd\n",
> @@ -429,9 +430,9 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *=
fp,
> char *buf, loff_t *pos,
>                                        fp->stream.name,
>                                        fp->stream.size,
>                                        &stream_buf);
> -       if ((int)v_len < 0) {
> +       if (v_len < 0) {
>                 pr_err("not found stream in xattr : %zd\n", v_len);
> -               err =3D (int)v_len;
> +               err =3D v_len;
>                 goto out;
>         }
>
> --
> 2.25.1
>
>
> ________________________________
> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=86=85=
=E5=AE=B9=E5=8F=AF=E8=83=BD=E5=90=AB=E6=9C=89=E6=9C=BA=E5=AF=86=E5=92=8C/=
=E6=88=96=E9=9A=90=E7=A7=81=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E4=BE=9B=E6=
=8C=87=E5=AE=9A=E4=B8=AA=E4=BA=BA=E6=88=96=E6=9C=BA=E6=9E=84=E4=BD=BF=E7=94=
=A8=E3=80=82=E8=8B=A5=E6=82=A8=E9=9D=9E=E5=8F=91=E4=BB=B6=E4=BA=BA=E6=8C=87=
=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=E6=88=96=E5=85=B6=E4=BB=A3=E7=90=86=E4=
=BA=BA=EF=BC=8C=E8=AF=B7=E5=8B=BF=E4=BD=BF=E7=94=A8=E3=80=81=E4=BC=A0=E6=92=
=AD=E3=80=81=E5=A4=8D=E5=88=B6=E6=88=96=E5=AD=98=E5=82=A8=E6=AD=A4=E9=82=AE=
=E4=BB=B6=E4=B9=8B=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=E6=88=96=E5=85=B6=E9=
=99=84=E4=BB=B6=E3=80=82=E5=A6=82=E6=82=A8=E8=AF=AF=E6=94=B6=E6=9C=AC=E9=82=
=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E5=8D=B3=E4=BB=A5=E5=9B=9E=E5=A4=8D=E6=88=96=
=E7=94=B5=E8=AF=9D=E6=96=B9=E5=BC=8F=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=
=BA=BA=EF=BC=8C=E5=B9=B6=E5=B0=86=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6=E3=80=
=81=E9=99=84=E4=BB=B6=E5=8F=8A=E5=85=B6=E6=89=80=E6=9C=89=E5=A4=8D=E6=9C=AC=
=E5=88=A0=E9=99=A4=E3=80=82=E8=B0=A2=E8=B0=A2=E3=80=82
> The contents of this message and any attachments may contain confidential
> and/or privileged information and are intended exclusively for the
> addressee(s). If you are not the intended recipient of this message or th=
eir
> agent, please note that any use, dissemination, copying, or storage of th=
is
> message or its attachments is not allowed. If you receive this message in
> error, please notify the sender by reply the message or phone and delete
> this message, any attachments and any copies immediately.
> Thank you
>
