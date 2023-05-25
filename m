Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA16B7103FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjEYES7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbjEYESb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:18:31 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321E910D5
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 21:17:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-510d6e1f1abso3744486a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 21:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684988231; x=1687580231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+04EpAmaPYUlluScEVT9VyZq4eY4+rPpOkbaWKqEJI=;
        b=gIGtcI+IJtZFHHjG0HDdbS2a4uGc/jQ9c++puEfDR5mFq1ju2+l0JKO/lfAM5bO9Rb
         mZ86JQgBOdGNxDSBuf7o44ur3nq47gN4RwtZazxhR9HqpbCwVv7cN8tnHZB8H8rWxQ97
         jkzgWitDl1pUP7LInQeRzxWdGdXXWxJlcusyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684988231; x=1687580231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+04EpAmaPYUlluScEVT9VyZq4eY4+rPpOkbaWKqEJI=;
        b=Ge8q5lU8HM+/WGNyUJsm2J7Qh13TcoKVSxzbcnPWCi1dpA0W44jMDUvoT7DymCNKLP
         7OaTlfzw9d8Z6FNOFcsVRbn7EMeqirhkYDU8iDLyCNnbO7G7D9hEA7rmtn5cFJZvDA5m
         H3FnJ22gi4LV4eqWA9exSf9cPO38AzWKmLBTCWtey1eZIAuFRG0ZnrLk5ap5a0n5TZ2x
         6a1iTuqoXIZlny6A/OisdIVkIaAmgXxuZuVtkJzmchN5hrjbq7dAACXZOnm4qVo6u7I4
         gBWeRZrVZamkreEO7RAW8Sp/kmXIJXFSWlu9PezT6RZIaG2MjZWOjgkOu5nzEwr4sSN1
         6KSw==
X-Gm-Message-State: AC+VfDzvJNUi3zs5lloN22lsPlaGPQx8ZJci09cGueU0OHc+i8vulV73
        UsBF8z81+zdLiorRoIQWI1ManTRwedEE50D6mkMjYQ==
X-Google-Smtp-Source: ACHHUZ6OVFX4L9Yo7wQXxDCYXRFsLZTNhjDP0+R+DyWC8IiqH1Ry0QQ5CiT6HW4ZSVMqwdxce8aVeQ==
X-Received: by 2002:aa7:d1c6:0:b0:50b:c72a:2b1b with SMTP id g6-20020aa7d1c6000000b0050bc72a2b1bmr3845188edp.19.1684988231372;
        Wed, 24 May 2023 21:17:11 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id bc16-20020a056402205000b0050bc37ff74asm123615edb.44.2023.05.24.21.17.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 21:17:09 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f6094cb2ebso607405e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 21:17:09 -0700 (PDT)
X-Received: by 2002:a7b:c84c:0:b0:3f6:a81:eb52 with SMTP id
 c12-20020a7bc84c000000b003f60a81eb52mr1531455wml.21.1684988229048; Wed, 24
 May 2023 21:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230522234154.2924052-1-yinghsu@chromium.org>
 <ZGyPt1GYGV2C2RQZ@corigine.com> <CABBYNZ+by-OQH2aPEMHpQ5cOLoKNpR7k111rJj6iOd2PGLx3gg@mail.gmail.com>
 <CAAa9mD3A+3uJzFK0EbTrn5hX42EOgeixehmxgkwdhp1KetxjVQ@mail.gmail.com> <CABBYNZKPv_0AaJJm2_c0F+4qX_vKXQ9BnVgR-kPy40YsDDqSRQ@mail.gmail.com>
In-Reply-To: <CABBYNZKPv_0AaJJm2_c0F+4qX_vKXQ9BnVgR-kPy40YsDDqSRQ@mail.gmail.com>
From:   Ying Hsu <yinghsu@chromium.org>
Date:   Thu, 25 May 2023 12:16:32 +0800
X-Gmail-Original-Message-ID: <CAAa9mD2e-WkuHshXf7ifOHcGEsgHb68xkRdaq5MRMeY7_jzkMg@mail.gmail.com>
Message-ID: <CAAa9mD2e-WkuHshXf7ifOHcGEsgHb68xkRdaq5MRMeY7_jzkMg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Fix l2cap_disconnect_req deadlock
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Simon Horman <simon.horman@corigine.com>,
        linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luiz,

The proposal solves the deadlock but might introduce other problems as
it breaks the order of l2cap_chan_del.
There are another way to resolve the deadlock:
```
@@ -4663,7 +4663,9 @@ static inline int l2cap_disconnect_req(struct
l2cap_conn *conn,

        chan->ops->set_shutdown(chan);

+       l2cap_chan_unlock(chan);
        mutex_lock(&conn->chan_lock);
+       l2cap_chan_lock(chan);
        l2cap_chan_del(chan, ECONNRESET);
        mutex_unlock(&conn->chan_lock);
 ```

If you're okay with it, I'll do some verification and post a full patch.

Best regards,
Ying

On Thu, May 25, 2023 at 2:56=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Ying,
>
> On Wed, May 24, 2023 at 3:54=E2=80=AFAM Ying Hsu <yinghsu@chromium.org> w=
rote:
> >
> > Hi Simon,
> >
> > I understand your concern about the repeated code.
> > However, simply hiding the locking logic in another function
> > introduces hidden assumptions.
> > For this patch, I would like to fix the deadlock in a simple and easy
> > to understand way.
> > We can always refactor the l2cap_chan utility functions later.
> >
> > Hi Luis,
> >
> > I'll add a fixes tag in the next version.
>
> And how about doing this:
>
> https://gist.github.com/Vudentz/e513859ecb31e79c947dfcb4b5c60453
>
> > Best regards,
> > Ying
> >
> >
> > On Wed, May 24, 2023 at 3:06=E2=80=AFAM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Simon, Ying,
> > >
> > > On Tue, May 23, 2023 at 3:04=E2=80=AFAM Simon Horman <simon.horman@co=
rigine.com> wrote:
> > > >
> > > > On Mon, May 22, 2023 at 11:41:51PM +0000, Ying Hsu wrote:
> > > > > L2CAP assumes that the locks conn->chan_lock and chan->lock are
> > > > > acquired in the order conn->chan_lock, chan->lock to avoid
> > > > > potential deadlock.
> > > > > For example, l2sock_shutdown acquires these locks in the order:
> > > > >   mutex_lock(&conn->chan_lock)
> > > > >   l2cap_chan_lock(chan)
> > > > >
> > > > > However, l2cap_disconnect_req acquires chan->lock in
> > > > > l2cap_get_chan_by_scid first and then acquires conn->chan_lock
> > > > > before calling l2cap_chan_del. This means that these locks are
> > > > > acquired in unexpected order, which leads to potential deadlock:
> > > > >   l2cap_chan_lock(c)
> > > > >   mutex_lock(&conn->chan_lock)
> > > > >
> > > > > This patch uses __l2cap_get_chan_by_scid to replace
> > > > > l2cap_get_chan_by_scid and adjusts the locking order to avoid the
> > > > > potential deadlock.
> > >
> > > This needs the fixes tag so we can backport it properly.
> > >
> > > > > Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> > > > > ---
> > > > > This commit has been tested on a Chromebook device.
> > > > >
> > > > > Changes in v2:
> > > > > - Adding the prefix "Bluetooth:" to subject line.
> > > > >
> > > > >  net/bluetooth/l2cap_core.c | 26 ++++++++++++++++++++------
> > > > >  1 file changed, 20 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_cor=
e.c
> > > > > index 376b523c7b26..8f08192b8fb1 100644
> > > > > --- a/net/bluetooth/l2cap_core.c
> > > > > +++ b/net/bluetooth/l2cap_core.c
> > > > > @@ -4651,8 +4651,16 @@ static inline int l2cap_disconnect_req(str=
uct l2cap_conn *conn,
> > > > >
> > > > >       BT_DBG("scid 0x%4.4x dcid 0x%4.4x", scid, dcid);
> > > > >
> > > > > -     chan =3D l2cap_get_chan_by_scid(conn, dcid);
> > > > > +     mutex_lock(&conn->chan_lock);
> > > > > +     chan =3D __l2cap_get_chan_by_scid(conn, dcid);
> > > > > +     if (chan) {
> > > > > +             chan =3D l2cap_chan_hold_unless_zero(chan);
> > > > > +             if (chan)
> > > > > +                     l2cap_chan_lock(chan);
> > > > > +     }
> > > > > +
> > > > >       if (!chan) {
> > > > > +             mutex_unlock(&conn->chan_lock);
> > > > >               cmd_reject_invalid_cid(conn, cmd->ident, dcid, scid=
);
> > > > >               return 0;
> > > > >       }
> > > >
> > > > Hi Ying,
> > > >
> > > > The conditional setting of chan and calling l2cap_chan_lock()
> > > > is both non-trivial and repeated. It seems that it ought to be
> > > > in a helper.
> > > >
> > > > Something like this (I'm sure a better function name can be chosen)=
:
> > > >
> > > >         chan =3D __l2cap_get_and_lock_chan_by_scid(conn, dcid);
> > > >         if (!chan) {
> > > >                 ...
> > > >         }
> > > >
> > > >         ...
> > >
> > > Or perhaps we could do something like l2cap_del_chan_by_scid:
> > >
> > > https://gist.github.com/Vudentz/e513859ecb31e79c947dfcb4b5c60453
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
