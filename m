Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39746B6D77
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 03:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjCMC2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 22:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCMC2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 22:28:51 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A5226C36
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 19:28:49 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x11so11333487pln.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 19:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112; t=1678674529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzEtyZe8cfSruCxVh4SzOlIiO5IZeBTIyw11BQoI6Zc=;
        b=g/ZGfti1OMCjGj7x3aTswk+NiO+LMxs/4jpxSJWPtA9p2XF2fYV7h6TPhndHyb8nS/
         gj4B0sAJgElBuEPvY2kGQAEpVfDQgM2TF+e7CzyRKujmX/3GbCiCbspt85dLGYFaMagJ
         eXGENXSzMsdZWARSyj7C1n816jFDAzbJ2r6T/QT9kEfYb0FvRs3MxlEoNxISjN4rhCef
         G1nmrt/WrwKjQ5QldOmsP6U/gyan2EL0zzXEPNos1rxhKn1mqWv3pZeI5X9ksjdJFJNh
         3lth18wZRzYj/2JGTpX/wV2H5sOSRC293qXOEWRm15YirQPA5Rxofqe/X0UuAEsbnECZ
         4EjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678674529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzEtyZe8cfSruCxVh4SzOlIiO5IZeBTIyw11BQoI6Zc=;
        b=BbuAyaTWsLf3P5ju9fGWoLnl05jIDLyxhhy/5wCEy46gQToNHzTP4X6q1lWiyh3MVi
         ZMk3TYoZvWcyb3IOGVW3WEkmZMCC5OX7YKaWQcNgjgFl1RXK0jaZSEhu5GbEwBktIGWQ
         MznI8cnq405owp83g2krtlU9YbOI2SnU+5/VSBT8CAJXd1m/Y2yjHjxTFZIyvg01sBv0
         nuexEeCMu5xm+QA2/CMTV4qVG4dSe2rQMm8kAqCUw0zCnagKDqbCXxPZyhKi4yi9isoN
         VzFl0+4jxVfhvN9a3zazPThhzExpnL+qFWsHJp0qFZHJFbGUrQTGhplzeI0yPyngUxuQ
         68ow==
X-Gm-Message-State: AO0yUKX2Y9LxBBwhq8G/OdKpegFMJ96aZm07Y3gPXnXjfUwYfVDAhohs
        R78GxBwyLhrWdS5BCz7jqR2Zog==
X-Google-Smtp-Source: AK7set/eeFue3ZwKpAdrsbUIZiu+DTunT3d06etZrkRSeAzJcjdEEmPo/oHXhEiihN/Pb5ERJTpAYw==
X-Received: by 2002:a17:902:ec85:b0:19f:2e2b:3577 with SMTP id x5-20020a170902ec8500b0019f2e2b3577mr6600673plg.41.1678674529198;
        Sun, 12 Mar 2023 19:28:49 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id ks13-20020a170903084d00b0019cb534a824sm3468726plb.172.2023.03.12.19.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 19:28:49 -0700 (PDT)
Date:   Sun, 12 Mar 2023 19:28:47 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Jason Xing <kerneljasonxing@gmail.com>
Cc:     Simon Horman <simon.horman@corigine.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next] net-sysfs: display two backlog queue len
 separately
Message-ID: <20230312192847.0d58155e@hermes.local>
In-Reply-To: <CAL+tcoDi5fVWjyTX6wjJGKrszqL6JWkEgDBajhZchYSW7kyhGQ@mail.gmail.com>
References: <20230311151756.83302-1-kerneljasonxing@gmail.com>
        <ZA4huzYKK/tdT3Ep@corigine.com>
        <CAL+tcoDi5fVWjyTX6wjJGKrszqL6JWkEgDBajhZchYSW7kyhGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023 09:55:37 +0800
Jason Xing <kerneljasonxing@gmail.com> wrote:

> On Mon, Mar 13, 2023 at 3:02=E2=80=AFAM Simon Horman <simon.horman@corigi=
ne.com> wrote:
> >
> > On Sat, Mar 11, 2023 at 11:17:56PM +0800, Jason Xing wrote: =20
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Sometimes we need to know which one of backlog queue can be exactly
> > > long enough to cause some latency when debugging this part is needed.
> > > Thus, we can then separate the display of both.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  net/core/net-procfs.c | 17 ++++++++++++-----
> > >  1 file changed, 12 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
> > > index 1ec23bf8b05c..97a304e1957a 100644
> > > --- a/net/core/net-procfs.c
> > > +++ b/net/core/net-procfs.c
> > > @@ -115,10 +115,14 @@ static int dev_seq_show(struct seq_file *seq, v=
oid *v)
> > >       return 0;
> > >  }
> > >
> > > -static u32 softnet_backlog_len(struct softnet_data *sd)
> > > +static u32 softnet_input_pkt_queue_len(struct softnet_data *sd)
> > >  {
> > > -     return skb_queue_len_lockless(&sd->input_pkt_queue) +
> > > -            skb_queue_len_lockless(&sd->process_queue);
> > > +     return skb_queue_len_lockless(&sd->input_pkt_queue);
> > > +}
> > > +
> > > +static u32 softnet_process_queue_len(struct softnet_data *sd)
> > > +{
> > > +     return skb_queue_len_lockless(&sd->process_queue);
> > >  }
> > >
> > >  static struct softnet_data *softnet_get_online(loff_t *pos)
> > > @@ -169,12 +173,15 @@ static int softnet_seq_show(struct seq_file *se=
q, void *v)
> > >        * mapping the data a specific CPU
> > >        */
> > >       seq_printf(seq,
> > > -                "%08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %=
08x %08x %08x\n",
> > > +                "%08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %=
08x %08x %08x "
> > > +                "%08x %08x\n",
> > >                  sd->processed, sd->dropped, sd->time_squeeze, 0,
> > >                  0, 0, 0, 0, /* was fastroute */
> > >                  0,   /* was cpu_collision */
> > >                  sd->received_rps, flow_limit_count,
> > > -                softnet_backlog_len(sd), (int)seq->index);
> > > +                0,   /* was len of two backlog queues */
> > > +                (int)seq->index, =20
> >
> > nit: I think you could avoid this cast by using %llx as the format spec=
ifier. =20
>=20
> I'm not sure if I should change this format since the above line is
> introduced in commit 7d58e6555870d ('net-sysfs: add backlog len and
> CPU id to softnet data').
> The seq->index here manifests which cpu it uses, so it can be
> displayed in 'int' format. Meanwhile, using %8x to output is much
> cleaner if the user executes 'cat /proc/net/softnet_stat'.
>=20
> What do you think about this?
>=20
> Thanks,
> Jason

I consider sofnet_data a legacy API (ie don't change).
Why not add to real sysfs for network device with the one value per file?
