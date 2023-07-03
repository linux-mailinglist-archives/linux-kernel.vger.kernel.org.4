Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665FC745985
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjGCKBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjGCKAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:00:49 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D38C10EF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:57:35 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so4781275a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 02:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688378254; x=1690970254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M45z07O3hHoHAGcB6lIP4valT6fq8gen3lBb2oN7lCY=;
        b=gmR8vcTKMQ5SYSmqOGiQnOycwHRgw9SBgWT23205ODgFFnQsmAIw3P+J9s6EzqH/EC
         JNlne7MiIBZsn633QhivnEd3zG9Eja5QBnx2sMp/JB62mhdvc2ZOM/akekC1IGFRbolR
         iQDy/X2m40nCISOub6GFvn7qB5F67PS/zVWWPINmxc96tBnUZ69vgPCNDXxIzG3qcVeX
         vgtO/Bdm0yF9M+c+ubOglknHlq4i7wdIWQVkcxgLwbQCspCSThHag6pTMepiq1caED8+
         eca8TWbmlEY1G2Za09PJ6MQL5u7tG2rTfpsZ1Y/xV7DU7PjvQ8lyGmavYiiWa7PmXDUg
         npCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688378254; x=1690970254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M45z07O3hHoHAGcB6lIP4valT6fq8gen3lBb2oN7lCY=;
        b=k3QmE/X619+K4sIGhQ1DGfjCirN8eEc80DGemxaI140KqsE1Z4PcUuckZf2oS7rV/N
         9+NkB1eigfLS2+JPGxZiDIK6cS5STk78B/Q/oj4wUEz46EnTcm78fXBb1DenTTPPGHyG
         RpMZV33Apm7Uf9cM72PkHkIIDa1zXlP1P3ZjQRYA5u1eKJ24Et6USRuzZzXiEM/8VF6E
         NADxYjCzAz3JQ+RPuXEstAQFWjQf7faaolDQA0knLj0W9qo4//tfU3naRyHLLZBwkl99
         OpJgH4WTJv1q46zzoL+S9MjzK8fr3nzS+ovsBLEauqQXyoOo7xiJRTqMdSlXKI+cXsIj
         Z34g==
X-Gm-Message-State: ABy/qLa2qqy1xPXKm3l4scfKkj5o67Sp2WHci9/WCHyag8qjC3CojTDx
        Ui75WR2SuiUxhu8Bcb/51T0RS0fZSsdC18mQ4LoJ6A==
X-Google-Smtp-Source: APBJJlHJK06Lj4XGRl/BmnIuL51u84nWGWAcTxetG3hpLSZLo2p45TqXsSjUJOOMoVIun1qSvw3W6YSWFc18YGtkNnM=
X-Received: by 2002:aa7:d68f:0:b0:51d:e4dc:7176 with SMTP id
 d15-20020aa7d68f000000b0051de4dc7176mr6794062edr.20.1688378253785; Mon, 03
 Jul 2023 02:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230613-so-reuseport-v4-6-4ece76708bba@isovalent.com> <20230628185352.76923-1-kuniyu@amazon.com>
In-Reply-To: <20230628185352.76923-1-kuniyu@amazon.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Mon, 3 Jul 2023 10:57:23 +0100
Message-ID: <CAN+4W8hLXYZuNFG+=J-FWLXWhbwT5TrHjMg5VzjQhv2NBo5VaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 6/7] bpf, net: Support SO_REUSEPORT sockets
 with bpf_sk_assign
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, haoluo@google.com, hemanthmalla@gmail.com,
        joe@cilium.io, joe@wand.net.nz, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        martin.lau@linux.dev, mykolal@fb.com, netdev@vger.kernel.org,
        pabeni@redhat.com, sdf@google.com, shuah@kernel.org,
        song@kernel.org, willemdebruijn.kernel@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 7:54=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:

> > +     reuse_sk =3D inet6_lookup_reuseport(net, sk, skb, doff,
> > +                                       saddr, sport, daddr, ntohs(dpor=
t),
> > +                                       ehashfn);
> > +     if (!reuse_sk || reuse_sk =3D=3D sk)
> > +             return sk;
> > +
> > +     /* We've chosen a new reuseport sock which is never refcounted. T=
his
> > +      * implies that sk also isn't refcounted.
> > +      */
> > +     WARN_ON_ONCE(*refcounted);
>
> One more nit.
>
> WARN_ON_ONCE() should be tested before inet6?_lookup_reuseport() not to
> miss the !reuse_sk case.

I was just pondering that as well, but I came to the opposite
conclusion. In the !reuse_sk case we don't really know anything about
sk, except that it isn't part of a reuseport group. How can we be sure
that it's not refcounted?
