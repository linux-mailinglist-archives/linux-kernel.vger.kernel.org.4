Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4449570F49C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjEXKyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjEXKyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:54:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E804C5
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:54:10 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96fdc081cb3so109541566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684925648; x=1687517648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/qi+dHgB0OUou2fTatsWKxVpRKt0hH2Bcu1Do/nAuA=;
        b=GftWbWECWQFLbvcv03JoAPeER0zJrtOqVthatc1RpHrmOLrBOX8yVtEf+Dhl2PqNUu
         YdodgmdA/Ge5MR5vz3mUJQsQ9NhIdN3ivxeb87HNRa4MX7baDVrvPaZSmC+smSRKbFx/
         n6BlgiMG2y8MBuWi3oF78vr00bVu6KKuhjYcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684925648; x=1687517648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/qi+dHgB0OUou2fTatsWKxVpRKt0hH2Bcu1Do/nAuA=;
        b=A1TTzyS1nE7HUjtlvKDbkvbqs9T0pk7x/o491AOwHcpmETmBrgPUPsp7PChG0ooOIN
         awBQmefm9wy1w0gcrK8sdW23ka5OW2jq/j6fgmnUq+HTDKX0og2alKlVsP+FJsNcfDAg
         erytZJvOve8la477GzakrdkbcAPZwWeCx+h1l2HkXs/qLpTTSZoDogYCkJoQeDZyTAnq
         pjPX35iQ5c7mhRqfv1dzI5BzBjWENRpv59ydbO9SZ42f+domPa0GLWgNJXe7QoE+TFf5
         lIpIHdOsuIrK9e57ll4hQ/qk8fcnAT6h/xbR1b3CXIKCQKa8GRgAWnx6FUABlaj+JKyz
         dgyQ==
X-Gm-Message-State: AC+VfDxB4bqlehOTurpHQRY0SKJPTR81CxBkjMQ7Iise1gWQcMpg6z4H
        lEi5YU4lhZPexfdeOfluJ+rLmlvXuZZsoeUkh20=
X-Google-Smtp-Source: ACHHUZ7BkN0nAA3yy67CPct7vbs07CKSWI2zVFzyDjxqccld7LwbOysrZE2o/SmY0VwOSAjWcF11/A==
X-Received: by 2002:a17:906:9743:b0:94f:4102:25c8 with SMTP id o3-20020a170906974300b0094f410225c8mr19874853ejy.61.1684925648124;
        Wed, 24 May 2023 03:54:08 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id q19-20020a170906941300b00966293c06e9sm5567113ejx.126.2023.05.24.03.54.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 03:54:07 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-30a95ec7744so627073f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:54:06 -0700 (PDT)
X-Received: by 2002:a5d:5348:0:b0:306:2ef0:d223 with SMTP id
 t8-20020a5d5348000000b003062ef0d223mr11847562wrv.62.1684925646235; Wed, 24
 May 2023 03:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230522234154.2924052-1-yinghsu@chromium.org>
 <ZGyPt1GYGV2C2RQZ@corigine.com> <CABBYNZ+by-OQH2aPEMHpQ5cOLoKNpR7k111rJj6iOd2PGLx3gg@mail.gmail.com>
In-Reply-To: <CABBYNZ+by-OQH2aPEMHpQ5cOLoKNpR7k111rJj6iOd2PGLx3gg@mail.gmail.com>
From:   Ying Hsu <yinghsu@chromium.org>
Date:   Wed, 24 May 2023 18:53:29 +0800
X-Gmail-Original-Message-ID: <CAAa9mD3A+3uJzFK0EbTrn5hX42EOgeixehmxgkwdhp1KetxjVQ@mail.gmail.com>
Message-ID: <CAAa9mD3A+3uJzFK0EbTrn5hX42EOgeixehmxgkwdhp1KetxjVQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

I understand your concern about the repeated code.
However, simply hiding the locking logic in another function
introduces hidden assumptions.
For this patch, I would like to fix the deadlock in a simple and easy
to understand way.
We can always refactor the l2cap_chan utility functions later.

Hi Luis,

I'll add a fixes tag in the next version.

Best regards,
Ying


On Wed, May 24, 2023 at 3:06=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Simon, Ying,
>
> On Tue, May 23, 2023 at 3:04=E2=80=AFAM Simon Horman <simon.horman@corigi=
ne.com> wrote:
> >
> > On Mon, May 22, 2023 at 11:41:51PM +0000, Ying Hsu wrote:
> > > L2CAP assumes that the locks conn->chan_lock and chan->lock are
> > > acquired in the order conn->chan_lock, chan->lock to avoid
> > > potential deadlock.
> > > For example, l2sock_shutdown acquires these locks in the order:
> > >   mutex_lock(&conn->chan_lock)
> > >   l2cap_chan_lock(chan)
> > >
> > > However, l2cap_disconnect_req acquires chan->lock in
> > > l2cap_get_chan_by_scid first and then acquires conn->chan_lock
> > > before calling l2cap_chan_del. This means that these locks are
> > > acquired in unexpected order, which leads to potential deadlock:
> > >   l2cap_chan_lock(c)
> > >   mutex_lock(&conn->chan_lock)
> > >
> > > This patch uses __l2cap_get_chan_by_scid to replace
> > > l2cap_get_chan_by_scid and adjusts the locking order to avoid the
> > > potential deadlock.
>
> This needs the fixes tag so we can backport it properly.
>
> > > Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> > > ---
> > > This commit has been tested on a Chromebook device.
> > >
> > > Changes in v2:
> > > - Adding the prefix "Bluetooth:" to subject line.
> > >
> > >  net/bluetooth/l2cap_core.c | 26 ++++++++++++++++++++------
> > >  1 file changed, 20 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > > index 376b523c7b26..8f08192b8fb1 100644
> > > --- a/net/bluetooth/l2cap_core.c
> > > +++ b/net/bluetooth/l2cap_core.c
> > > @@ -4651,8 +4651,16 @@ static inline int l2cap_disconnect_req(struct =
l2cap_conn *conn,
> > >
> > >       BT_DBG("scid 0x%4.4x dcid 0x%4.4x", scid, dcid);
> > >
> > > -     chan =3D l2cap_get_chan_by_scid(conn, dcid);
> > > +     mutex_lock(&conn->chan_lock);
> > > +     chan =3D __l2cap_get_chan_by_scid(conn, dcid);
> > > +     if (chan) {
> > > +             chan =3D l2cap_chan_hold_unless_zero(chan);
> > > +             if (chan)
> > > +                     l2cap_chan_lock(chan);
> > > +     }
> > > +
> > >       if (!chan) {
> > > +             mutex_unlock(&conn->chan_lock);
> > >               cmd_reject_invalid_cid(conn, cmd->ident, dcid, scid);
> > >               return 0;
> > >       }
> >
> > Hi Ying,
> >
> > The conditional setting of chan and calling l2cap_chan_lock()
> > is both non-trivial and repeated. It seems that it ought to be
> > in a helper.
> >
> > Something like this (I'm sure a better function name can be chosen):
> >
> >         chan =3D __l2cap_get_and_lock_chan_by_scid(conn, dcid);
> >         if (!chan) {
> >                 ...
> >         }
> >
> >         ...
>
> Or perhaps we could do something like l2cap_del_chan_by_scid:
>
> https://gist.github.com/Vudentz/e513859ecb31e79c947dfcb4b5c60453
>
> --
> Luiz Augusto von Dentz
