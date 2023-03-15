Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4616B6BBDB7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 21:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjCOUAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 16:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjCOUAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 16:00:07 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5A41E5CF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:00:06 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id t4so20694137ybg.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678910405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNGceMWW/BgGzvQkNd/emK2zZpaL6kfYNAd7PoCsYkQ=;
        b=W8ie2q+Den9rVV9kczBpMMruKkqj8Mw6/LGEtm+eOaGOcpS5ybZh6n/VVJJYNeH3Vt
         TgvYIFmxb+XQW8n2gtHon6a00S/jDJnURAutKZy1UifcEOsLILI1Ihpiuc4bUvFyodqX
         xMstWp1Exku5uztV3DAEtcOFNqnB2RjHjjcxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678910405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNGceMWW/BgGzvQkNd/emK2zZpaL6kfYNAd7PoCsYkQ=;
        b=xMVCCb4Ffgc2FeJRL0fdwt3cix/KY9SilkupZJFbZo5LNE4Q5gQ7K0ACoX2I8DauAc
         ij4nB3cJr0SSsmOlb1Zvc0tiyGxtgduLlYD7Kfb9wn++rTjFnEsJ1/4paZh+GKxGddCR
         xihRKIy1Pl4r+Q9nkmCSP8y9r83/5PqsrBcf8L/g8pga9tk1+GRZvhTYfvvujut5Osz/
         XznKTKJSyj4MiZ3av5vOTIoVmTf5xbcdqFx6Ea2Q00XkIO7AWETvZDNGw95GNvaUK42y
         vPY+8qNGqRe/LKZD7GnozAnPzgxcWQFpoxr+yXndh9BAAOfe6UDIbe8lf1+a8GL67NK7
         RdoQ==
X-Gm-Message-State: AO0yUKV8t6FG7P36DUzyTRcDnOZtwxCWrTPZ8Gq5O8ZWHca1qKNef+l5
        OWRqpqkU21O1hoYonPYrOS9YSWbTjF3vracMT45dhQ==
X-Google-Smtp-Source: AK7set+2tUXDfPvmvYr/By9ZQT9k+JvUXivZ4P6yW8Z2Qx6eisfDeMiM2f+0CvXJo5TxIUs652iktgv0It+zLL/A5pY=
X-Received: by 2002:a05:6902:188c:b0:b51:c4b2:3d73 with SMTP id
 cj12-20020a056902188c00b00b51c4b23d73mr1811688ybb.2.1678910405283; Wed, 15
 Mar 2023 13:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230315181902.4177819-1-joel@joelfernandes.org>
 <20230315181902.4177819-13-joel@joelfernandes.org> <e704127e-1bfe-f351-db95-bfea6916e8f9@gmail.com>
 <CAEXW_YTB+LBG+oL02c0JfmAzoGSkZDM=QW1EXKbO3f-g0i4ddA@mail.gmail.com> <7a0dfc9f-6d21-fce4-4b83-72bb171454d3@gmail.com>
In-Reply-To: <7a0dfc9f-6d21-fce4-4b83-72bb171454d3@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 15 Mar 2023 15:59:54 -0400
Message-ID: <CAEXW_YTOC4KcnjP+oZEmUwhxT2RTRJUGZcK-bC2dZHNxQaWc5w@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] RDMA/rxe: Rename kfree_rcu() to kvfree_rcu_mightsleep()
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Devesh Sharma <devesh.s.sharma@oracle.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Mar 15, 2023 at 3:05=E2=80=AFPM Bob Pearson <rpearsonhpe@gmail.com>=
 wrote:
>
> On 3/15/23 13:41, Joel Fernandes wrote:
> > On Wed, Mar 15, 2023 at 2:38=E2=80=AFPM Bob Pearson <rpearsonhpe@gmail.=
com> wrote:
> >>
> >> On 3/15/23 13:19, Joel Fernandes (Google) wrote:
> >>> The k[v]free_rcu() macro's single-argument form is deprecated.
> >>> Therefore switch to the new k[v]free_rcu_mightsleep() variant. The go=
al
> >>> is to avoid accidental use of the single-argument forms, which can
> >>> introduce functionality bugs in atomic contexts and latency bugs in
> >>> non-atomic contexts.
> >>>
> >>> There is no functionality change with this patch.
> >>>
> >>> Link: https://lore.kernel.org/rcu/20230201150815.409582-1-urezki@gmai=
l.com
> >>> Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> >>> Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
> >>> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> >>> Fixes: 72a03627443d ("RDMA/rxe: Remove rxe_alloc()")
> >>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >>> ---
> >>>  drivers/infiniband/sw/rxe/rxe_mr.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/=
sw/rxe/rxe_mr.c
> >>> index b10aa1580a64..ae3a100e18fb 100644
> >>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> >>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> >>> @@ -731,7 +731,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_ud=
ata *udata)
> >>>               return -EINVAL;
> >>>
> >>>       rxe_cleanup(mr);
> >>> -     kfree_rcu(mr);
> >>> +     kfree_rcu_mightsleep(mr);
> >>>       return 0;
> >>>  }
> >>>
> >> Please replace kfree_rcu_mightsleep() by kfree(). There is no need to =
delay the kfree(mr).
> >
> > I thought you said either was Ok, but yeah that's fine with me. I was
> > trying to play it safe ;-). An extra GP may not hurt, but not having
> > one when it is needed might. I will update it to just be kfree.
>
> Thanks. The reason to not add the pause is that it really isn't required =
and will just make
> people think that it is. With the current state of the driver the mr clea=
nup code will disable
> looking up the mr from its rkey or lkey and then wait until all the refer=
ences to the mr are dropped
> before calling kfree. This will always work (unless a new bug is introduc=
ed) so no reason to
> add the rcu delay.
>

Sounds good! I updated it in my queue, and I will repost it in the
future pending test results and other comments.

thanks,

 - Joel
