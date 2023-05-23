Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAAF70E4BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237927AbjEWSdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjEWSdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:33:35 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C3D11D;
        Tue, 23 May 2023 11:33:34 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-437e4f09268so3516235137.2;
        Tue, 23 May 2023 11:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684866813; x=1687458813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiyNEH3rrNmb0uCq25edqFrYB/PmZzAkhlex9L2Z4jY=;
        b=EVWCMpFN2b7hkabCE5vXnwnAeIW2N9QqWx9n+7hKxi8lkzwTaBsSqucICIROLLWp9M
         We5RucK6RoPuMbasunYsKEZP4Jl51nQvt0SnZfQsLGzPjs9i1pffeg2nzMxX9qY8wAAF
         FxZH4BGPWWZIM8dvoBuaQi+RrKb5kfI/JQRHCQmc1LunSnk81TS7qb43LTebrWGGYryb
         DCfar+h6bJ8mlWtwBiFDbQ5HWnkkQ7oog36PiJmjS9RXjhhfqXA5Z3ckowMaXfZSHYjU
         SKyf6NClV90umizeFgYJx0wR43OeVS0/AEfi/3UOvGhi8lYEeCgnv/e7/aii6dgJPPrV
         IsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684866813; x=1687458813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiyNEH3rrNmb0uCq25edqFrYB/PmZzAkhlex9L2Z4jY=;
        b=fXaV8MTIudpq+rdSntUZ7oUWeq7akoeafIWnKT8Samn4TkkmhDpX6N39EU3YdScRie
         mgt/NHEGnfkLeLNJjM+9Q9a9Eq43L3vymq6Mdd6OfcxG7dYgZsaBkPSSUHub6kU00GSI
         1aCw5sfvb5qFWJsfOrUjQTfFY0Bd/q/DvUXPRTcmD1mdlikQmniIXdzSxogG0jL+UGWu
         Teh38MMVCYrKU4jnM8yRXdSS7cLtfuqbaSER4Mwt1l0tyeazsre5YyPK1rBbKkHnplOe
         IMzSD4mUO7jWJefYOMuLPHggVF98KNEuJkGersRTJRJpgsgBsFxigdbSbl/Y52jSpvho
         7cnQ==
X-Gm-Message-State: AC+VfDyby/NyqOHKk/CAxkFEOIWDP+klXjS6GGZo/pIkZNbY21aQDr6h
        tgjMjxHADYa3iuWf8QWq7DKxL5+Nx/cx05xxmWs=
X-Google-Smtp-Source: ACHHUZ4kW1y4PMLPAdDQFxZ+ImH0yD6CzvT8cKI5ePE850dHnObWYOy8X0YX39SUL0y6H0cY6GM2rNGtaOn89NP7Q+E=
X-Received: by 2002:a67:f1d7:0:b0:439:4112:814 with SMTP id
 v23-20020a67f1d7000000b0043941120814mr3215406vsm.2.1684866813198; Tue, 23 May
 2023 11:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230511123252.723185-1-cgzones@googlemail.com> <CAHC9VhTcso+RTEOkGOCDxyMscznEXrUhp+quDWvATUhEzEOhRQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTcso+RTEOkGOCDxyMscznEXrUhp+quDWvATUhEzEOhRQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 23 May 2023 20:33:22 +0200
Message-ID: <CAJ2a_DfRGq+Cg_U7+Rsie9Bywxquu9CuMwYUGNv3+Sg9=wt9Og@mail.gmail.com>
Subject: Re: [PATCH] security: keys: perform capable check only on privileged operations
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023 at 23:08, Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, May 11, 2023 at 8:33=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > If the current task fails the check for the queried capability via
> > `capable(CAP_SYS_ADMIN)` LSMs like SELinux generate a denial message.
> > Issuing such denial messages unnecessarily can lead to a policy author
> > granting more privileges to a subject than needed to silence them.
> >
> > Reorder CAP_SYS_ADMIN checks after the check whether the operation is
> > actually privileged.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  security/keys/keyctl.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> > index d54f73c558f7..19be69fa4d05 100644
> > --- a/security/keys/keyctl.c
> > +++ b/security/keys/keyctl.c
> > @@ -980,14 +980,19 @@ long keyctl_chown_key(key_serial_t id, uid_t user=
, gid_t group)
> >         ret =3D -EACCES;
> >         down_write(&key->sem);
> >
> > -       if (!capable(CAP_SYS_ADMIN)) {
> > +       {
> > +               bool is_privileged_op =3D false;
> > +
> >                 /* only the sysadmin can chown a key to some other UID =
*/
> >                 if (user !=3D (uid_t) -1 && !uid_eq(key->uid, uid))
> > -                       goto error_put;
> > +                       is_privileged_op =3D true;
> >
> >                 /* only the sysadmin can set the key's GID to a group o=
ther
> >                  * than one of those that the current process subscribe=
s to */
> >                 if (group !=3D (gid_t) -1 && !gid_eq(gid, key->gid) && =
!in_group_p(gid))
> > +                       is_privileged_op =3D true;
> > +
> > +               if (is_privileged_op && !capable(CAP_SYS_ADMIN))
> >                         goto error_put;
> >         }
>
> Hmm.  Using braces just to create a new scope is a bit hacky; I'll
> admit to using it to quickly create new local variables, but I only do
> so in debug/test situations, not production code.
>
> What if you move the CAP_SYS_ADMIN check down into the if-conditional
> where the code checks to see if CAP_SYS_ADMIN is needed when changing
> the UID?  It should be possible to structure the CAP_SYS_ADMIN check
> such that it is only executed if needed.  It's a little more
> complicated in the GID case, but I believe it should be doable.

This complication I exactly wanted to avoid.  For me the inner scope
encapsulates the all the logic around the capability check just fine
and is quite readable.  An alternative would be to create a new
function performing the checks and call it via

    if (!chown_key_capable(key, user, uid, group, gid))
        got error_put;

A minor inconvenience is the number of needed arguments (and the
actual code after inlining should be the same to the inner scope in
the end).

>
> --
> paul-moore.com
