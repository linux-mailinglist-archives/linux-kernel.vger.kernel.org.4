Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525E86A3EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjB0JzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjB0JzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:55:21 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5521ACE5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:55:17 -0800 (PST)
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 54D063F59E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677491716;
        bh=tg5JUGrzf9zAyKPvBm2SxqJ3gGjUcKX+UWSCeqq+tvk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=mrM1y/QNHfhJYcIQYqi8e/PVqZTqImJEzgdE24d1S9eSwv49ihercnJNj3s6xkaHR
         3TqFXlF6LzkYno1fB/kjVQn47z1Ovr8hY2GoQO7fgGX2InyslEVxyU0MmJYlQ9iO8G
         dEdiXO4hxFdRrTNL7VOtZ2JJ7AQNl+yM8BxAnPKKi4gsqcszwB2LRPLH3GOeTqPfzP
         FFX/8nfsoea7wMvVht8evm/iMSrvjI1MdE0F7/c9zKYnN58fGpOwc5gejzcRnf1shB
         XVipyQNvKMOlYz51Si0ADHqbGZA/6usEyT6/Q9HGgp7qOcXNPB1t46Xv9E8AFwwy2b
         a16A7D3av7PQw==
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-536c6ce8d74so128267547b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tg5JUGrzf9zAyKPvBm2SxqJ3gGjUcKX+UWSCeqq+tvk=;
        b=6shUnk8OSDIScG7x+HU0s9IN8CprNrfuucpj+9esC+3cfPS82DJYh4Sg4YJTF1EMSn
         v8qjhgaTZAwtuCozM6ytfrZ9MGSb92tn1dDrt0eFMC8NaecB3/bx2EkCCwS+9AwrXgWG
         +ExqTJVRxYRaSsOVtVN+FSTOVveiNd+t2C/bGIkz+M6xENLqs8bVlQNylwtdYvpMaGF4
         V5OAtCYH6l3BGnuHjJjm13+qoOEs+oHm/a4NNIU7QXG0T2/HXm8gKXPHVhoqwiDgwVSI
         c1OOuvGirqr/TDiMJbacXn0ZTjVjn9viazP8PV36GelHoUIwD1vyDHqB8DNlBqw+tDTF
         Wh9Q==
X-Gm-Message-State: AO0yUKU023syWQRTIzZiac8qZn8mMoxLXNZkvWs40rHXG0a2AqYxI7cQ
        Od42OU3ns5GxTBaftqMoR8IgYPZiI+nVgw90VQzSXgg+W4XWqC0SGoQSflbKUeYHRwS0rNIaLXB
        oMewuTjnM4SnHoFxI28RiaIznxe86y8KttsbTe69I2OIv/2MfuaNTMoYSKg==
X-Received: by 2002:a5b:ecb:0:b0:a03:da3f:3e68 with SMTP id a11-20020a5b0ecb000000b00a03da3f3e68mr8668939ybs.12.1677491715355;
        Mon, 27 Feb 2023 01:55:15 -0800 (PST)
X-Google-Smtp-Source: AK7set8WlubDkM1Faogvy9cX8bjJidGkXf+S6l1wxuHu2gKvS1jpHhjUX5yhJ76wvykGnTzky2R/5XHH8FkhD6NkQ+o=
X-Received: by 2002:a5b:ecb:0:b0:a03:da3f:3e68 with SMTP id
 a11-20020a5b0ecb000000b00a03da3f3e68mr8668935ybs.12.1677491715165; Mon, 27
 Feb 2023 01:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20230226201730.515449-1-aleksandr.mikhalitsyn@canonical.com> <Y/x8H4qCNsj4mEkA@unreal>
In-Reply-To: <Y/x8H4qCNsj4mEkA@unreal>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Mon, 27 Feb 2023 10:55:04 +0100
Message-ID: <CAEivzxeorZoiE4VmJ45CoF4ZRoW3B+rkT0ufX7y1bxn510yzPQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 10:47=E2=80=AFAM Leon Romanovsky <leon@kernel.org> =
wrote:
>
> On Sun, Feb 26, 2023 at 09:17:30PM +0100, Alexander Mikhalitsyn wrote:
> > Currently, we set MSG_CTRUNC flag is we have no
> > msg_control buffer provided and SO_PASSCRED is set
> > or if we have pending SCM_RIGHTS.
> >
> > For some reason we have no corresponding check for
> > SO_PASSSEC.
> >
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >  include/net/scm.h | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
>
> Is it a bugfix? If yes, it needs Fixes line.

It's from 1da177e4c3 ("Linux-2.6.12-rc2") times :)
I wasn't sure that it's correct to put the "Fixes" tag on such an old
and big commit. Will do. Thanks!

>
> >
> > diff --git a/include/net/scm.h b/include/net/scm.h
> > index 1ce365f4c256..585adc1346bd 100644
> > --- a/include/net/scm.h
> > +++ b/include/net/scm.h
> > @@ -105,16 +105,27 @@ static inline void scm_passec(struct socket *sock=
, struct msghdr *msg, struct sc
> >               }
> >       }
> >  }
> > +
> > +static inline bool scm_has_secdata(struct socket *sock)
> > +{
> > +     return test_bit(SOCK_PASSSEC, &sock->flags);
> > +}
> >  #else
> >  static inline void scm_passec(struct socket *sock, struct msghdr *msg,=
 struct scm_cookie *scm)
> >  { }
> > +
> > +static inline bool scm_has_secdata(struct socket *sock)
> > +{
> > +     return false;
> > +}
> >  #endif /* CONFIG_SECURITY_NETWORK */
>
> There is no need in this ifdef, just test bit directly.

The problem is that even if the kernel is compiled without
CONFIG_SECURITY_NETWORK
userspace can still set the SO_PASSSEC option. IMHO it's better not to
set MSG_CTRUNC
if CONFIG_SECURITY_NETWORK is disabled, msg_control is not set but
SO_PASSSEC is enabled.
Because in this case SCM_SECURITY will never be sent. Please correct
me if I'm wrong.

Kind regards,
Alex

>
> >
> >  static __inline__ void scm_recv(struct socket *sock, struct msghdr *ms=
g,
> >                               struct scm_cookie *scm, int flags)
> >  {
> >       if (!msg->msg_control) {
> > -             if (test_bit(SOCK_PASSCRED, &sock->flags) || scm->fp)
> > +             if (test_bit(SOCK_PASSCRED, &sock->flags) || scm->fp ||
> > +                 scm_has_secdata(sock))
> >                       msg->msg_flags |=3D MSG_CTRUNC;
> >               scm_destroy(scm);
> >               return;
> > --
> > 2.34.1
> >
