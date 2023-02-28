Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CD56A564F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjB1KHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjB1KGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:06:39 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9C92BED3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:06:27 -0800 (PST)
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 899273F11D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677578784;
        bh=y22P12T/3uivssKqi58jTR5H/vm5bFhVhbv1BLNfkj8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=uNLc0QgohGE9NKvkonkRhKxxsMa7lVGli6bHz4LbwSXCnqdzss9ACgG62bOnQMn0W
         lGx1xGef4SDNRVSJVC1b609oKxnyQOgSnc/GuyyOsEMgXR0o+nzODHnrmUf2vM5gBc
         VmnCYK7CI/dkL9R55rE2fGmBGq/mqIbmeAjLUy5XYVUI0L1ED8RaFuOezCICjc5Aow
         VIZRrPotmH5HtH4mQMkCcMxgBomdMtaH6DFTzUHJC0C4LolOsCkQ5sl56PTyI2+rRo
         yNjBNA7ATr5FI1q5E3j+m29YdjH/suUGYlXbHC8bCKrTYV6daJM5QAC9nPhhaDxihq
         lD9Re35eA5iNA==
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-536d63d17dbso202683877b3.22
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:06:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y22P12T/3uivssKqi58jTR5H/vm5bFhVhbv1BLNfkj8=;
        b=zjRLT76+BNaqBldILiQWq+PcrFUffgmmK0XGHjUVXCcN42/iouA/+jsLJGR9CjNYgf
         EG2CwuPzbU5Dh9M/9Ze5Q+JRXasiCZnsoklNG7NbL8PNz7m1U+8iYbSluEyU0g5A/u7h
         fsNIdfev/gA3UfWjLMOmFpB+neBn3s8eg6oyvt6oBus150UcYOOmySzfelC3PXWKXOn4
         lNEXys7C5vkeQGvELlOFpiRJYW5aktlvqmc+Qcx+l/4l/Dtr1dX+GvfqJkW/6VV5Y+Ao
         sHRSslC0etemBQVYotJquYHy7WHgIgyKLxFbpa1GOEL739YPGI4MYwHSSYiKbI30DySJ
         6Dbw==
X-Gm-Message-State: AO0yUKWdi+dQUa9It+AGJpiNApXzzRuT+Fxxmkcpd6kH0Q0zI6J33rpb
        CZLfEN9VEezCfqN7tGsjqk6wQ9epGcmZBIIsVPGXoFed/xffniUi8Z96yPAqjukX7UDhfIfETKT
        XtJ/VYxV/BnETr8RbFbnKrzgMd5OoXNiy/MuohLhnkIeT352EUCWJqu8GtQ==
X-Received: by 2002:a81:451a:0:b0:533:cf4e:9a80 with SMTP id s26-20020a81451a000000b00533cf4e9a80mr1235656ywa.6.1677578783568;
        Tue, 28 Feb 2023 02:06:23 -0800 (PST)
X-Google-Smtp-Source: AK7set9R6Ave+QCwJSbY+D8km3Y1LFdB8YigpvU611NKLdJGVncKINoTh/OUCzDPqvTfD0paJVCrabk1JwzN+1bMX6k=
X-Received: by 2002:a81:451a:0:b0:533:cf4e:9a80 with SMTP id
 s26-20020a81451a000000b00533cf4e9a80mr1235649ywa.6.1677578783371; Tue, 28 Feb
 2023 02:06:23 -0800 (PST)
MIME-Version: 1.0
References: <20230226201730.515449-1-aleksandr.mikhalitsyn@canonical.com>
 <Y/x8H4qCNsj4mEkA@unreal> <CAEivzxeorZoiE4VmJ45CoF4ZRoW3B+rkT0ufX7y1bxn510yzPQ@mail.gmail.com>
 <Y/z3OtIA+25GjjH2@unreal>
In-Reply-To: <Y/z3OtIA+25GjjH2@unreal>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Tue, 28 Feb 2023 11:06:12 +0100
Message-ID: <CAEivzxemz8SDr2_NAvgi6XdzA12d5_3ZOmJ=1FF8VMbaGLdVng@mail.gmail.com>
Subject: Re: [PATCH net-next] scm: fix MSG_CTRUNC setting condition for SO_PASSSEC
To:     Leon Romanovsky <leon@kernel.org>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 7:32=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Mon, Feb 27, 2023 at 10:55:04AM +0100, Aleksandr Mikhalitsyn wrote:
> > On Mon, Feb 27, 2023 at 10:47=E2=80=AFAM Leon Romanovsky <leon@kernel.o=
rg> wrote:
> > >
> > > On Sun, Feb 26, 2023 at 09:17:30PM +0100, Alexander Mikhalitsyn wrote=
:
> > > > Currently, we set MSG_CTRUNC flag is we have no
> > > > msg_control buffer provided and SO_PASSCRED is set
> > > > or if we have pending SCM_RIGHTS.
> > > >
> > > > For some reason we have no corresponding check for
> > > > SO_PASSSEC.
> > > >
> > > > Cc: "David S. Miller" <davem@davemloft.net>
> > > > Cc: Eric Dumazet <edumazet@google.com>
> > > > Cc: Jakub Kicinski <kuba@kernel.org>
> > > > Cc: Paolo Abeni <pabeni@redhat.com>
> > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonic=
al.com>
> > > > ---
> > > >  include/net/scm.h | 13 ++++++++++++-
> > > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > Is it a bugfix? If yes, it needs Fixes line.
> >
> > It's from 1da177e4c3 ("Linux-2.6.12-rc2") times :)
> > I wasn't sure that it's correct to put the "Fixes" tag on such an old
> > and big commit. Will do. Thanks!
> >
> > >
> > > >
> > > > diff --git a/include/net/scm.h b/include/net/scm.h
> > > > index 1ce365f4c256..585adc1346bd 100644
> > > > --- a/include/net/scm.h
> > > > +++ b/include/net/scm.h
> > > > @@ -105,16 +105,27 @@ static inline void scm_passec(struct socket *=
sock, struct msghdr *msg, struct sc
> > > >               }
> > > >       }
> > > >  }
> > > > +
> > > > +static inline bool scm_has_secdata(struct socket *sock)
> > > > +{
> > > > +     return test_bit(SOCK_PASSSEC, &sock->flags);
> > > > +}
> > > >  #else
> > > >  static inline void scm_passec(struct socket *sock, struct msghdr *=
msg, struct scm_cookie *scm)
> > > >  { }
> > > > +
> > > > +static inline bool scm_has_secdata(struct socket *sock)
> > > > +{
> > > > +     return false;
> > > > +}
> > > >  #endif /* CONFIG_SECURITY_NETWORK */
> > >
> > > There is no need in this ifdef, just test bit directly.
> >
> > The problem is that even if the kernel is compiled without
> > CONFIG_SECURITY_NETWORK
> > userspace can still set the SO_PASSSEC option. IMHO it's better not to
> > set MSG_CTRUNC
> > if CONFIG_SECURITY_NETWORK is disabled, msg_control is not set but
> > SO_PASSSEC is enabled.
> > Because in this case SCM_SECURITY will never be sent. Please correct
> > me if I'm wrong.
>
> I don't know enough in this area to say if it is wrong or not.
> My remark was due to the situation where user sets some bit which is
> going to be ignored silently. It will be much cleaner do not set it
> if CONFIG_SECURITY_NETWORK is disabled instead of masking its usage.

Hi Leon,

I agree with you, but IMHO then it looks more correct to return -EOPNOTSUPP=
 on
setsockopt(fd, SO_PASSSEC, ...) if CONFIG_SECURITY_NETWORK is disabled.
But such a change may break things.

Okay, anyway I'll wait until net-next will be opened and present a
patch with a more
detailed description and Fixes tag. Speaking about this problem with
CONFIG_SECURITY_NETWORK
if you insist that it will be more correct then I'm ready to fix it too.

Thanks,
Alex

>
> Thanks
>
> >
> > Kind regards,
> > Alex
> >
> > >
> > > >
> > > >  static __inline__ void scm_recv(struct socket *sock, struct msghdr=
 *msg,
> > > >                               struct scm_cookie *scm, int flags)
> > > >  {
> > > >       if (!msg->msg_control) {
> > > > -             if (test_bit(SOCK_PASSCRED, &sock->flags) || scm->fp)
> > > > +             if (test_bit(SOCK_PASSCRED, &sock->flags) || scm->fp =
||
> > > > +                 scm_has_secdata(sock))
> > > >                       msg->msg_flags |=3D MSG_CTRUNC;
> > > >               scm_destroy(scm);
> > > >               return;
> > > > --
> > > > 2.34.1
> > > >
