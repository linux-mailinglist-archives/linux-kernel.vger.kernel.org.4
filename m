Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB0B70A13D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjESVIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjESVIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:08:04 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E121B0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:08:03 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-ba71af5f164so5172586276.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684530482; x=1687122482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNAr0eN3BJd6PClx9Trgynq1tOTvA9sGtw9njPJi4AA=;
        b=bJFzqPPi7avVdIui/TRooN20CFKx9KYo8TAzWQ29ywDcMmuR5PcGA0guADaiYjNra+
         OwzR2l3rx31682QPw5fBUNatPj3awLlc3U1rercD9OOS2fxUFHMOEnzAUCgYC/kwy2ts
         X/oxxrX/RhV0s2zByMqo7QsbkBjS7YAAdXAL0ra3jBIXCB9sSshbo9v6PFErb8fDP5JD
         6dRPpEHRsoatyufGev5ITqTmXAL8MY4qUUFV7y3dYg3w8HXCGzCa3h23u96UIkIUMWVr
         GrLMiDfV5xNCvIHDiei26awruRyjpOUaZfz0KaPAYpbPfstpSeDBwlRIXa3cYrGeoO5A
         xXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684530482; x=1687122482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNAr0eN3BJd6PClx9Trgynq1tOTvA9sGtw9njPJi4AA=;
        b=WbfLQ/1uKFbiLdCQ091qBJst8C0N6hQT6xexlhpAlBJC3VhAqPiA9Z2P4qPHHfZ+df
         3vMN41HJ07ejNPv8B+NmOsU7fI1Rv9nr93G7oe30cDebBxOLxPpDleUecrupe/Yevsbv
         i7GD/36IubR/pa+6sdVr3kCD7h0gM/FDsxVXnWYEF2YMNARRPlFb2FrErzaDxppWmMeq
         fGkrk8LNDnfTTGuY5RDAZ0yM52Azln/Fcmt7W2nTQ6Isvpn4a9G/1hJ8e2xNWihonh25
         /SYSVE3AXL9l/8hs3b7X3E3fLP7/jaJxSD7wee4YjUFH+3c+eQsH+hyb5k9PkmJFVhzz
         nq1w==
X-Gm-Message-State: AC+VfDxOql1bdq3JPADDEqJCTAtMUhkGtBaaOD9ApQL0w+Yo5p4OWkBr
        KjHBmiSxcGXoQ473zClbYYmTXHg7h3rhMwW6bgOj
X-Google-Smtp-Source: ACHHUZ6rUZO8aO+ZoLpFa4vGZYtcdoPjtguqDe3esXvg+x5MOcHlbXSr4JeS7AcsSIzX8Kzsg3kr/HozvceYuV5l5P8=
X-Received: by 2002:a25:d24a:0:b0:ba2:bffc:5f8d with SMTP id
 j71-20020a25d24a000000b00ba2bffc5f8dmr2924220ybg.29.1684530482287; Fri, 19
 May 2023 14:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230511123252.723185-1-cgzones@googlemail.com>
In-Reply-To: <20230511123252.723185-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 May 2023 17:07:51 -0400
Message-ID: <CAHC9VhTcso+RTEOkGOCDxyMscznEXrUhp+quDWvATUhEzEOhRQ@mail.gmail.com>
Subject: Re: [PATCH] security: keys: perform capable check only on privileged operations
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 8:33=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> If the current task fails the check for the queried capability via
> `capable(CAP_SYS_ADMIN)` LSMs like SELinux generate a denial message.
> Issuing such denial messages unnecessarily can lead to a policy author
> granting more privileges to a subject than needed to silence them.
>
> Reorder CAP_SYS_ADMIN checks after the check whether the operation is
> actually privileged.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/keys/keyctl.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index d54f73c558f7..19be69fa4d05 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -980,14 +980,19 @@ long keyctl_chown_key(key_serial_t id, uid_t user, =
gid_t group)
>         ret =3D -EACCES;
>         down_write(&key->sem);
>
> -       if (!capable(CAP_SYS_ADMIN)) {
> +       {
> +               bool is_privileged_op =3D false;
> +
>                 /* only the sysadmin can chown a key to some other UID */
>                 if (user !=3D (uid_t) -1 && !uid_eq(key->uid, uid))
> -                       goto error_put;
> +                       is_privileged_op =3D true;
>
>                 /* only the sysadmin can set the key's GID to a group oth=
er
>                  * than one of those that the current process subscribes =
to */
>                 if (group !=3D (gid_t) -1 && !gid_eq(gid, key->gid) && !i=
n_group_p(gid))
> +                       is_privileged_op =3D true;
> +
> +               if (is_privileged_op && !capable(CAP_SYS_ADMIN))
>                         goto error_put;
>         }

Hmm.  Using braces just to create a new scope is a bit hacky; I'll
admit to using it to quickly create new local variables, but I only do
so in debug/test situations, not production code.

What if you move the CAP_SYS_ADMIN check down into the if-conditional
where the code checks to see if CAP_SYS_ADMIN is needed when changing
the UID?  It should be possible to structure the CAP_SYS_ADMIN check
such that it is only executed if needed.  It's a little more
complicated in the GID case, but I believe it should be doable.

--=20
paul-moore.com
