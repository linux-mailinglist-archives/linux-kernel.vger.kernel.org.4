Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894576BBDB1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjCOT5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjCOT5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:57:15 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8673E359F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:57:14 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-544787916d9so61755177b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678910233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWpTabGy6QLogyA9n745re/JJmzh/5d9dyJhDfcEfl4=;
        b=Lpe59DpwZs9pQF/TmsfrmgkvqZ0K3A/XUYL0fNgV07LpOAxVq7cGpuv6SQ83pKBTEm
         MhTTjW8D5MQ3YTn18WGmoozAuGkvGMZPW13GulOi2OoZ4WFj8qWAtwgoKNzDYcIVJh+x
         g+CbMBx+hDRKFCbkDK1KA4mq5olc85IXG0avA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678910233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWpTabGy6QLogyA9n745re/JJmzh/5d9dyJhDfcEfl4=;
        b=aUatxr6l7gDNe5KS+YMBfcxqGkMnTovo0+oM6Ey+HWvjwLoJ/fmzRcbRKJDpHbDb2o
         YaVfHm1p+9XCw49oigfyszNORHJ1n9GWAnEB3mCuw5VJJMvLNXkHZiy1sblcUeDtQi1V
         AxTGzYfG8zebw5b6b07GTvEkG2TYrPxiLb3KN0rJTBtcs3dowa4fQ0d31QOuiBQtMGeB
         3S2vu/x9Apb9u3fMFtFp/ejDezkZm7dd5bMcwiCkE9XZO1bR+71J5GmP1aQP8Eg7NUL1
         zWZuBLvafMOs8XhNQWwwVwGJY1mgxMTedjTxQZQE6fhIgHMRi+R6o1n4rHiAuSkSFuMH
         R5Gg==
X-Gm-Message-State: AO0yUKWdIacBrJrWXMO335d/au0j2Y8l7KpHeH8fz5H68TUtbe/6OLDb
        HNQs1dCwjoeWHoTKWQxtpkfG+j27f5Q5jbYRZT+Puw==
X-Google-Smtp-Source: AK7set+pGKWCyoCQbm2+A59THlc6hWu8pXoM0CYg/D+t+xU3PMcVQu9wwx4y4vZXdfb62v049FzI2x4zlkO63ATF2yA=
X-Received: by 2002:a81:ae5f:0:b0:532:e887:2c23 with SMTP id
 g31-20020a81ae5f000000b00532e8872c23mr695840ywk.9.1678910233685; Wed, 15 Mar
 2023 12:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230201150815.409582-1-urezki@gmail.com> <20230315151415.2534e11c@gandalf.local.home>
 <e5a1815b-65b5-55ca-9773-ec04378d53c0@kernel.dk> <ZBIbloFMm5xRsjfn@pc636> <20230315153448.6914f85b@gandalf.local.home>
In-Reply-To: <20230315153448.6914f85b@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 15 Mar 2023 15:57:02 -0400
Message-ID: <CAEXW_YTLFQ3-LApyCPNNx7Tn2ovFr8YUXL=1WVCm+rE2hRKE8g@mail.gmail.com>
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to k[v]free_rcu_mightsleep()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Steve,

On Wed, Mar 15, 2023 at 3:35=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 15 Mar 2023 20:25:10 +0100
> Uladzislau Rezki <urezki@gmail.com> wrote:
>
> > > This was my main complaint too, kvfree_rcu_mightsleep() is an absolut=
ely
> > > horrible name for an API... But nobody seemed to care about that!
> > >
> > > I like the _synchronize() suggestion, as it matches other RCU naming.
> > >
> > This is basically about what it does. If you renamed it to "_synchroniz=
e()"
> > in reality it would not mean that it always a synchronous call, most of=
 the
> > time it is not whereas the name would point that it is.
>
> No, just comment it.
>
> I was going to suggest "kvfree_rcu_might_synchronize()" but that's just
> getting ridiculous.

No, synchronize() is incorrect. The code really can sleep for other
reasons like memory allocation. It is not that simple of an
implementation as one may imagine. mightsleep is really the correct
wording IMHO.

> Still, I will replace that code back to a kfree() and rcu_synchonize() th=
an
> to let that other name get in.

I think it is too late for that for now, we already have conversions
going into the other subsystems, that means we'll have to redo all
that over again (even if it sounded like a good idea, which it is
not).

I would rather you just did: "#define kvfree_rcu_tracing
#kvfree_rcu_mightsleep", or something like that, if it is really a
problem. ;-)

Also you are really the first person I know of who has a problem with that =
name.

 - Joel
