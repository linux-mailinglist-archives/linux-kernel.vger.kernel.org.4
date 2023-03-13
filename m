Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF836B7CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjCMP71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCMP7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:59:24 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CDA38010
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:59:23 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-540cb2fb5b9so145823007b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678723163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Zdhf2j3ifN+HyChC7K9MVN3E0kNiC4oD9+37ixavMI=;
        b=WxniqZ7r6+Fq+6KtyFyddLlF39+Qf66EoMvxGxo67oRbd3sTfu7c8PEIuvN1clFCBc
         rxHjCIgwdTt+eAV8WTBDgMCRfHkE5KgQL5FzOpKbTgX6GyZ9EsjgtWZuSalyPpn1cyZD
         uOmMRgIsSsKbYiiPjdvyCsPcB9Y+uz230prcRd0RHU4E9Uq1lDW1TDVTL75IwpLAoA5s
         7nnYI03pnOLfMeWSsfqeIRw2zURaFyhr6IULiUty/Oo/Podj/gwuGK2+HcoX6Ik1l1JQ
         eSkclDVNdzOkIL1ZZs4nTX2F5u7qbEKPvbbkL0ip75AXZKrbFp85HUmt0DbeN4s3F9dR
         HFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678723163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Zdhf2j3ifN+HyChC7K9MVN3E0kNiC4oD9+37ixavMI=;
        b=26GSfQDQaOgAMA49B03GjZt1mhBfltomRj4xRdXcNINeWTnOy67iTYFnGnEBtivY07
         7JQHZOuBsnuvj8JIUE58B/vOxwXmJY69Klu9qcG82xkx4wa2uuIwaD5pf5ylr3vF7hbZ
         rm8uMcEtHpXAUlq/ANhntqGEuOUjPkmFN/5Zx3Dhd6w4QdZy9gqFbJthjEuuSH8Qd5BE
         5v2208q/UAG9C2225lf1i4yBQpRX58McvjdBcuH7y4MaIxyeSqxatk47VHLMk0iG1EA5
         vK3lXxGOhZmPa56tRqqyGE6p4V6JNt7uQGI54DxrjYKsf3PPZJVtHDrq+Fe/Ttba6r6W
         gz+g==
X-Gm-Message-State: AO0yUKUxzWDaSqUkFiPaKF4oWjM9MghaNKfsB01R3MmSlS8vMfCBsiOA
        ChnkGsWkveBvfGoNo9uabSEFtB84X8PlUvQC4VJrxg==
X-Google-Smtp-Source: AK7set8uWEwFexE23WqXCSKgc2c/o2SpZRSUsuWrr9x1YTwk0vBVFfsoE8eZb9SK4x56ymdPsRaZLeUdcanEsjWZmSo=
X-Received: by 2002:a81:c74b:0:b0:541:7237:6e6b with SMTP id
 i11-20020a81c74b000000b0054172376e6bmr4623180ywl.0.1678723162501; Mon, 13 Mar
 2023 08:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230311151756.83302-1-kerneljasonxing@gmail.com>
 <CANn89iKWewG7JZXQ=bmab9rSXUs_P5fX-BQ792QjYuH151DV-g@mail.gmail.com> <CAL+tcoAchbTk9ibrAVH-bZ-0KHJ8g3XnsQHFWiBosyNgYJtymA@mail.gmail.com>
In-Reply-To: <CAL+tcoAchbTk9ibrAVH-bZ-0KHJ8g3XnsQHFWiBosyNgYJtymA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 13 Mar 2023 08:59:11 -0700
Message-ID: <CANn89i+uS7-mA227g6yJfTK4ugdA82z+PLV9_74f1dBMo_OhEg@mail.gmail.com>
Subject: Re: [PATCH net-next] net-sysfs: display two backlog queue len separately
To:     Jason Xing <kerneljasonxing@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 6:16=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Mon, Mar 13, 2023 at 8:34=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Sat, Mar 11, 2023 at 7:18=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
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
> > >         return 0;
> > >  }
> > >
> > > -static u32 softnet_backlog_len(struct softnet_data *sd)
> > > +static u32 softnet_input_pkt_queue_len(struct softnet_data *sd)
> > >  {
> > > -       return skb_queue_len_lockless(&sd->input_pkt_queue) +
> > > -              skb_queue_len_lockless(&sd->process_queue);
> > > +       return skb_queue_len_lockless(&sd->input_pkt_queue);
> > > +}
> > > +
> > > +static u32 softnet_process_queue_len(struct softnet_data *sd)
> > > +{
> > > +       return skb_queue_len_lockless(&sd->process_queue);
> > >  }
> > >
> > >  static struct softnet_data *softnet_get_online(loff_t *pos)
> > > @@ -169,12 +173,15 @@ static int softnet_seq_show(struct seq_file *se=
q, void *v)
> > >          * mapping the data a specific CPU
> > >          */
> > >         seq_printf(seq,
> > > -                  "%08x %08x %08x %08x %08x %08x %08x %08x %08x %08x=
 %08x %08x %08x\n",
> > > +                  "%08x %08x %08x %08x %08x %08x %08x %08x %08x %08x=
 %08x %08x %08x "
> > > +                  "%08x %08x\n",
> > >                    sd->processed, sd->dropped, sd->time_squeeze, 0,
> > >                    0, 0, 0, 0, /* was fastroute */
> > >                    0,   /* was cpu_collision */
> > >                    sd->received_rps, flow_limit_count,
> > > -                  softnet_backlog_len(sd), (int)seq->index);
> > > +                  0,   /* was len of two backlog queues */
> >
> > You can not pretend the sum is zero, some user space tools out there
> > would be fooled.
> >
> > > +                  (int)seq->index,
> > > +                  softnet_input_pkt_queue_len(sd), softnet_process_q=
ueue_len(sd));
> > >         return 0;
> > >  }
> > >
> > > --
> > > 2.37.3
> > >
> >
> > In general I would prefer we no longer change this file.
>
> Fine. Since now, let this legacy file be one part of history.
>
> >
> > Perhaps add a tracepoint instead ?
>
> Thanks, Eric. It's one good idea. It seems acceptable if we only need
> to trace two separate backlog queues where it can probably hit the
> limit, say, in the enqueue_to_backlog().


Note that enqueue_to_backlog() already uses a specific kfree_skb_reason() r=
eason
(SKB_DROP_REASON_CPU_BACKLOG) so existing infrastructure should work just f=
ine.


>
> Similarly I decide to write another two tracepoints of time_squeeze
> and budget_squeeze which I introduced to distinguish from time_squeeze
> as the below link shows:
> https://lore.kernel.org/lkml/CAL+tcoAwodpnE2NjMLPhBbmHUvmKMgSykqx0EQ4YZaQ=
Hjrx0Hw@mail.gmail.com/.
> For that change, any suggestions are deeply welcome :)
>

For your workloads to hit these limits enough for you to be worried,
it looks like you are not using any scaling stuff documented
in Documentation/networking/scaling.rst
