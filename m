Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D9A74FE32
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 06:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjGLEaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 00:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGLEan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 00:30:43 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDA71726;
        Tue, 11 Jul 2023 21:30:42 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b698937f85so106449941fa.2;
        Tue, 11 Jul 2023 21:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689136240; x=1691728240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FEG/oH6gh544Z3hupFRjyPw2jcIZbPPkJZIsg/itb0=;
        b=mGbit/QZhR5zf5HHGqic70EOrefPwZyYsBYoUr1mMVgh5v7Qbr7zEhj2GoCeJqxgPl
         Qb4UEyX5X059JCyQ6NJeoxIkqvMTZGePS8sW5CcPoELai4x+2XvU9jp1bDVpBMS/tEhO
         gccopfMxyVSXXqXO59N+wtSmFooWumUnHOTtN/j/FvDtgRrXR49WRLrAweqEGUL94z3y
         uK8KxwShzNK32Em0GlE51szEsnfNw+2pwMgeHP/zJteEJ3I45pKjDMMEiz8Zt1wKUKG9
         fz6J/AyU2j3lsmJplI9gpp48fiB98Ib75zpyTMN1ldMyQ6MJBhjNk3hMfIfTJSQNM59t
         fqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689136240; x=1691728240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FEG/oH6gh544Z3hupFRjyPw2jcIZbPPkJZIsg/itb0=;
        b=OFaB+mkRZL9atWqL9dysaTXXthj73ekkoJPIOfg0PAPMRiaLtHnrvHZLXhKVDQFQY4
         GQSjc3Pzf62FltMmjQbuKhyiNdPA7lVHJP+7f+YUaoXWJJf9VeJZQtDM0ZesiRUqb+BY
         NCmwAk/au4Suqf9X/AlkxNT71ZnqH15gFJEp6Z7FzgPqAl9qJv4jzatyBnV7shZQX/e7
         2CG7d9yO7tlWrstd6bYQXrCvmRIDa0VhZr8NosoLqJ0c9SQtwa6wgX3/sEnxjy5oycbm
         /G+Mhi05+fu9LvKilTbdfdVf+VvKHDNO79dvULEwCcN8ok5yMU0ptmiUls9B4Z1QCg9V
         upqg==
X-Gm-Message-State: ABy/qLbykYMjrL3WTwBDzl5/Yj0js6OK0U936DFFAlOaujGzRNwPtSEb
        27xnqqv74bo6/uYsSkR54uUrelHGgoRu0O0cVcg=
X-Google-Smtp-Source: APBJJlE40OEhJ2PYH91T4HIq5pcd6q70yeow9XhxzdrP/Z+spXJCkguhiExdfD1Jt8YBmYRMzz3wtEuVM4cmaQLivS8=
X-Received: by 2002:a2e:99d4:0:b0:2b4:765b:f6ee with SMTP id
 l20-20020a2e99d4000000b002b4765bf6eemr14552766ljj.41.1689136240040; Tue, 11
 Jul 2023 21:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <ZK3h3+dHBGONHt+S@work>
In-Reply-To: <ZK3h3+dHBGONHt+S@work>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 11 Jul 2023 23:30:28 -0500
Message-ID: <CAH2r5msw8i2Bx4NxWPWei6WGjusAHPSgm4s7c-haTtD+O9z4mQ@mail.gmail.com>
Subject: Re: [PATCH] smb: client: Fix -Wstringop-overflow issues
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tentatively merged into cifs-2.6.git for-next pending testing

On Tue, Jul 11, 2023 at 6:20=E2=80=AFPM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> pSMB->hdr.Protocol is an array of size 4 bytes, hence when the compiler
> analyzes this line of code
>
>         parm_data =3D ((char *) &pSMB->hdr.Protocol) + offset;
>
> it legitimately complains about the fact that offset points outside the
> bounds of the array. Notice that the compiler gives priority to the objec=
t
> as an array, rather than merely the address of one more byte in a structu=
re
> to wich offset should be added (which seems to be the actual intention of
> the original implementation).
>
> Fix this by explicitly instructing the compiler to treat the code as a
> sequence of bytes in struct smb_com_transaction2_spi_req, and not as an
> array accessed through pointer notation.
>
> Notice that ((char *)pSMB) + sizeof(pSMB->hdr.smb_buf_length) points to
> the same address as ((char *) &pSMB->hdr.Protocol), therefore this result=
s
> in no differences in binary output.
>
> Fixes the following -Wstringop-overflow warnings when built s390
> architecture with defconfig (GCC 13):
>   CC [M]  fs/smb/client/cifssmb.o
> In function 'cifs_init_ace',
>     inlined from 'posix_acl_to_cifs' at fs/smb/client/cifssmb.c:3046:3,
>     inlined from 'cifs_do_set_acl' at fs/smb/client/cifssmb.c:3191:15:
> fs/smb/client/cifssmb.c:2987:31: warning: writing 1 byte into a region of=
 size 0 [-Wstringop-overflow=3D]
>  2987 |         cifs_ace->cifs_e_perm =3D local_ace->e_perm;
>       |         ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> In file included from fs/smb/client/cifssmb.c:27:
> fs/smb/client/cifspdu.h: In function 'cifs_do_set_acl':
> fs/smb/client/cifspdu.h:384:14: note: at offset [7, 11] into destination =
object 'Protocol' of size 4
>   384 |         __u8 Protocol[4];
>       |              ^~~~~~~~
> In function 'cifs_init_ace',
>     inlined from 'posix_acl_to_cifs' at fs/smb/client/cifssmb.c:3046:3,
>     inlined from 'cifs_do_set_acl' at fs/smb/client/cifssmb.c:3191:15:
> fs/smb/client/cifssmb.c:2988:30: warning: writing 1 byte into a region of=
 size 0 [-Wstringop-overflow=3D]
>  2988 |         cifs_ace->cifs_e_tag =3D  local_ace->e_tag;
>       |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> fs/smb/client/cifspdu.h: In function 'cifs_do_set_acl':
> fs/smb/client/cifspdu.h:384:14: note: at offset [6, 10] into destination =
object 'Protocol' of size 4
>   384 |         __u8 Protocol[4];
>       |              ^~~~~~~~
>
> This helps with the ongoing efforts to globally enable
> -Wstringop-overflow.
>
> Link: https://github.com/KSPP/linux/issues/310
> Fixes: dc1af4c4b472 ("cifs: implement set acl method")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/smb/client/cifssmb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
> index 19f7385abeec..9dee267f1893 100644
> --- a/fs/smb/client/cifssmb.c
> +++ b/fs/smb/client/cifssmb.c
> @@ -3184,7 +3184,7 @@ int cifs_do_set_acl(const unsigned int xid, struct =
cifs_tcon *tcon,
>         param_offset =3D offsetof(struct smb_com_transaction2_spi_req,
>                                 InformationLevel) - 4;
>         offset =3D param_offset + params;
> -       parm_data =3D ((char *) &pSMB->hdr.Protocol) + offset;
> +       parm_data =3D ((char *)pSMB) + sizeof(pSMB->hdr.smb_buf_length) +=
 offset;
>         pSMB->ParameterOffset =3D cpu_to_le16(param_offset);
>
>         /* convert to on the wire format for POSIX ACL */
> --
> 2.34.1
>


--=20
Thanks,

Steve
