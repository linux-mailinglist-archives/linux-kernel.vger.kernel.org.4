Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B29C7154B6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 07:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjE3FIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 01:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjE3FIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 01:08:07 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC4CEC
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 22:08:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5147e40bbbbso5798000a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 22:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685423283; x=1688015283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oENdb/PNBbVjDrw8mDPjI3X3sDQAuL7/2+YTKg1gLI=;
        b=nNJLCB3FtxaV/RTzyPCHNuMIjWkv5BTVxn9XL3QJFc08wvDCKVjKgbij8gjObSOdS+
         /VCSeFsV5FTltlQWUJuEIR13YYB7lFYb+h6EdNmYLnyPuW7nCQybmtv+uKox2YDZEfXa
         Ur4JzdagHpdYjJUKfN/QGIp8UCbs47fhyc+YY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685423283; x=1688015283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oENdb/PNBbVjDrw8mDPjI3X3sDQAuL7/2+YTKg1gLI=;
        b=bPHzdT9JVn63FHK2VS5Syo7QREXymc+P0WhYLpZlnU9ANHxcgCdi3SsF6mj5G5HxG3
         wSMSRQqu1O3FWiAmxw/t8tPMLddfEEruXLNmSxjLfYjMZJYzrbqdDHFlQwHZmrnFXCD7
         fp6Sx0Ll32zR5dGwHfOOGy/EaHb487/PDaZwcPqcdsI5JB15ea5vv1vFxcNVU5eulNSO
         KY7Trftk4O/HcjSnDLh9at5k0c2lmLRUjIgJpT9QSnrx/mCAHDu5NCAVp0DoWyUDRrFU
         GsGssbAaMoxePDKCXUx8YJEm6m/+5/FujBfq5y+S+wVjyX2HosNHvcOWL6yy5ir/Q4vx
         FtZQ==
X-Gm-Message-State: AC+VfDxU21/jrHaXb/XkMbdkAhxb5S8GlZFfX3jZHh/RrcaZV25Hq0Y0
        L2cp8BlsOvw/cgk5pYCTqDTrNL0Aq0AY1lPAYHo=
X-Google-Smtp-Source: ACHHUZ61Uzmtrcer4jRk+9RE8ZCAhydMyta+7QouMzl4IwScWIPHysD3EFh5nwC4Mf6OoF7OXTgANQ==
X-Received: by 2002:a05:6402:205c:b0:509:d476:3a12 with SMTP id bc28-20020a056402205c00b00509d4763a12mr710633edb.34.1685423282730;
        Mon, 29 May 2023 22:08:02 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id n15-20020a05640206cf00b004fbdfbb5acesm3868670edy.89.2023.05.29.22.08.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 22:08:01 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f6094cb2d2so41544675e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 22:08:01 -0700 (PDT)
X-Received: by 2002:adf:dd92:0:b0:30a:b46a:a443 with SMTP id
 x18-20020adfdd92000000b0030ab46aa443mr462543wrl.51.1685423280911; Mon, 29 May
 2023 22:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230522234154.2924052-1-yinghsu@chromium.org>
 <ZGyPt1GYGV2C2RQZ@corigine.com> <CABBYNZ+by-OQH2aPEMHpQ5cOLoKNpR7k111rJj6iOd2PGLx3gg@mail.gmail.com>
 <CAAa9mD3A+3uJzFK0EbTrn5hX42EOgeixehmxgkwdhp1KetxjVQ@mail.gmail.com>
 <CABBYNZKPv_0AaJJm2_c0F+4qX_vKXQ9BnVgR-kPy40YsDDqSRQ@mail.gmail.com> <CAAa9mD2e-WkuHshXf7ifOHcGEsgHb68xkRdaq5MRMeY7_jzkMg@mail.gmail.com>
In-Reply-To: <CAAa9mD2e-WkuHshXf7ifOHcGEsgHb68xkRdaq5MRMeY7_jzkMg@mail.gmail.com>
From:   Ying Hsu <yinghsu@chromium.org>
Date:   Tue, 30 May 2023 13:07:23 +0800
X-Gmail-Original-Message-ID: <CAAa9mD00VriG3utyedjwykuUUXaRU0SvXkr5+VPgmZFpiFokrA@mail.gmail.com>
Message-ID: <CAAa9mD00VriG3utyedjwykuUUXaRU0SvXkr5+VPgmZFpiFokrA@mail.gmail.com>
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
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping, Luiz.


On Thu, May 25, 2023 at 12:16=E2=80=AFPM Ying Hsu <yinghsu@chromium.org> wr=
ote:
>
> Hi Luiz,
>
> The proposal solves the deadlock but might introduce other problems as
> it breaks the order of l2cap_chan_del.
> There are another way to resolve the deadlock:
> ```
> @@ -4663,7 +4663,9 @@ static inline int l2cap_disconnect_req(struct
> l2cap_conn *conn,
>
>         chan->ops->set_shutdown(chan);
>
> +       l2cap_chan_unlock(chan);
>         mutex_lock(&conn->chan_lock);
> +       l2cap_chan_lock(chan);
>         l2cap_chan_del(chan, ECONNRESET);
>         mutex_unlock(&conn->chan_lock);
>  ```
>
> If you're okay with it, I'll do some verification and post a full patch.
>
> Best regards,
> Ying
>
> On Thu, May 25, 2023 at 2:56=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Ying,
> >
> > On Wed, May 24, 2023 at 3:54=E2=80=AFAM Ying Hsu <yinghsu@chromium.org>=
 wrote:
> > >
> > > Hi Simon,
> > >
> > > I understand your concern about the repeated code.
> > > However, simply hiding the locking logic in another function
> > > introduces hidden assumptions.
> > > For this patch, I would like to fix the deadlock in a simple and easy
> > > to understand way.
> > > We can always refactor the l2cap_chan utility functions later.
> > >
> > > Hi Luis,
> > >
> > > I'll add a fixes tag in the next version.
> >
> > And how about doing this:
> >
> > https://gist.github.com/Vudentz/e513859ecb31e79c947dfcb4b5c60453
> >
> > > Best regards,
> > > Ying
> > >
> > >
> > > On Wed, May 24, 2023 at 3:06=E2=80=AFAM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Simon, Ying,
> > > >
> > > > On Tue, May 23, 2023 at 3:04=E2=80=AFAM Simon Horman <simon.horman@=
corigine.com> wrote:
> > > > >
> > > > > On Mon, May 22, 2023 at 11:41:51PM +0000, Ying Hsu wrote:
> > > > > > L2CAP assumes that the locks conn->chan_lock and chan->lock are
> > > > > > acquired in the order conn->chan_lock, chan->lock to avoid
> > > > > > potential deadlock.
> > > > > > For example, l2sock_shutdown acquires these locks in the order:
> > > > > >   mutex_lock(&conn->chan_lock)
> > > > > >   l2cap_chan_lock(chan)
> > > > > >
> > > > > > However, l2cap_disconnect_req acquires chan->lock in
> > > > > > l2cap_get_chan_by_scid first and then acquires conn->chan_lock
> > > > > > before calling l2cap_chan_del. This means that these locks are
> > > > > > acquired in unexpected order, which leads to potential deadlock=
:
> > > > > >   l2cap_chan_lock(c)
> > > > > >   mutex_lock(&conn->chan_lock)
> > > > > >
> > > > > > This patch uses __l2cap_get_chan_by_scid to replace
> > > > > > l2cap_get_chan_by_scid and adjusts the locking order to avoid t=
he
> > > > > > potential deadlock.
> > > >
> > > > This needs the fixes tag so we can backport it properly.
> > > >
> > > > > > Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> > > > > > ---
> > > > > > This commit has been tested on a Chromebook device.
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Adding the prefix "Bluetooth:" to subject line.
> > > > > >
> > > > > >  net/bluetooth/l2cap_core.c | 26 ++++++++++++++++++++------
> > > > > >  1 file changed, 20 insertions(+), 6 deletions(-)
> > > > > >
> > > > > > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_c=
ore.c
> > > > > > index 376b523c7b26..8f08192b8fb1 100644
> > > > > > --- a/net/bluetooth/l2cap_core.c
> > > > > > +++ b/net/bluetooth/l2cap_core.c
> > > > > > @@ -4651,8 +4651,16 @@ static inline int l2cap_disconnect_req(s=
truct l2cap_conn *conn,
> > > > > >
> > > > > >       BT_DBG("scid 0x%4.4x dcid 0x%4.4x", scid, dcid);
> > > > > >
> > > > > > -     chan =3D l2cap_get_chan_by_scid(conn, dcid);
> > > > > > +     mutex_lock(&conn->chan_lock);
> > > > > > +     chan =3D __l2cap_get_chan_by_scid(conn, dcid);
> > > > > > +     if (chan) {
> > > > > > +             chan =3D l2cap_chan_hold_unless_zero(chan);
> > > > > > +             if (chan)
> > > > > > +                     l2cap_chan_lock(chan);
> > > > > > +     }
> > > > > > +
> > > > > >       if (!chan) {
> > > > > > +             mutex_unlock(&conn->chan_lock);
> > > > > >               cmd_reject_invalid_cid(conn, cmd->ident, dcid, sc=
id);
> > > > > >               return 0;
> > > > > >       }
> > > > >
> > > > > Hi Ying,
> > > > >
> > > > > The conditional setting of chan and calling l2cap_chan_lock()
> > > > > is both non-trivial and repeated. It seems that it ought to be
> > > > > in a helper.
> > > > >
> > > > > Something like this (I'm sure a better function name can be chose=
n):
> > > > >
> > > > >         chan =3D __l2cap_get_and_lock_chan_by_scid(conn, dcid);
> > > > >         if (!chan) {
> > > > >                 ...
> > > > >         }
> > > > >
> > > > >         ...
> > > >
> > > > Or perhaps we could do something like l2cap_del_chan_by_scid:
> > > >
> > > > https://gist.github.com/Vudentz/e513859ecb31e79c947dfcb4b5c60453
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
