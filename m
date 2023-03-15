Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA2B6BBC8A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjCOSmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjCOSml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:42:41 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5DDA5C8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:42:06 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id u32so13737397ybi.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678905682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlB2KQDsP1gLO1ErSJAxJa5TqI7N+c4BH5rJJ+jykys=;
        b=tpoBd1xE4sUpcExz6a3C8oJKYUVrMZNO/iN3ff73ZKIQPZ18lLqhNd831ZPb4gy+Zq
         UbZ+2PWMrZRdjZtxcm15eCwJ+O0qMiB8nFoVBMddpnlLXDPIJ+WPbc0zP6MUyYrVXAMz
         3A7LrszgMrq/g5CJqG605uTNdpYWd55zrJ8MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678905682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlB2KQDsP1gLO1ErSJAxJa5TqI7N+c4BH5rJJ+jykys=;
        b=m4jqTd/3Ds2scB+yynKxSrY++OrN9OF9rcYx3xXoVCk9irjgCy+VKAOsWGo9iwADmr
         QuD6xxjjNWpVGgO1HjBIs8POP0MFi2o0mL1tL2fMNWtIoUxijWGoXEmNyECe+9gcyccl
         6ku4AQaQ6B7OgxLxbWUy4ZGaxIUy2YlYFTYyWGZtjtON/xoSjGQvsawO8dODeCp9EDg9
         +3o8SkSDTGKtpgp8TT1C/YMRAxPOshXHRgNf6wXr9GcYHY8sKOyQqJF1TxKQ6Bh2Gtth
         v3U7/xR5nZ8KNRruzVsRiZmJtAs++dOKQ/K11bTR6tShCfwXGYui5XWmruQdGJh/Tih2
         JOzw==
X-Gm-Message-State: AO0yUKUtrIuBZEWbTspCSPok7oeWFjpn4lRi0gOCiZfgUkb1XVEZh0ob
        D3rPWDHxuR3dV/0WqKzYi3PArU7eSebgRFwk6WB+IA==
X-Google-Smtp-Source: AK7set9cv9Akmlc9FoZEe+UOJsWnsarxm/HAMLaGhJxsFQNLdwrdvVJOr1HqrLRIZPtiHGv5O7+2oPNd9eNzvQfuUGE=
X-Received: by 2002:a5b:24c:0:b0:b3b:a48c:b23e with SMTP id
 g12-20020a5b024c000000b00b3ba48cb23emr8172611ybp.2.1678905682253; Wed, 15 Mar
 2023 11:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230315181902.4177819-1-joel@joelfernandes.org>
 <20230315181902.4177819-13-joel@joelfernandes.org> <e704127e-1bfe-f351-db95-bfea6916e8f9@gmail.com>
In-Reply-To: <e704127e-1bfe-f351-db95-bfea6916e8f9@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 15 Mar 2023 14:41:11 -0400
Message-ID: <CAEXW_YTB+LBG+oL02c0JfmAzoGSkZDM=QW1EXKbO3f-g0i4ddA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 2:38=E2=80=AFPM Bob Pearson <rpearsonhpe@gmail.com>=
 wrote:
>
> On 3/15/23 13:19, Joel Fernandes (Google) wrote:
> > The k[v]free_rcu() macro's single-argument form is deprecated.
> > Therefore switch to the new k[v]free_rcu_mightsleep() variant. The goal
> > is to avoid accidental use of the single-argument forms, which can
> > introduce functionality bugs in atomic contexts and latency bugs in
> > non-atomic contexts.
> >
> > There is no functionality change with this patch.
> >
> > Link: https://lore.kernel.org/rcu/20230201150815.409582-1-urezki@gmail.=
com
> > Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> > Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > Fixes: 72a03627443d ("RDMA/rxe: Remove rxe_alloc()")
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  drivers/infiniband/sw/rxe/rxe_mr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw=
/rxe/rxe_mr.c
> > index b10aa1580a64..ae3a100e18fb 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> > @@ -731,7 +731,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udat=
a *udata)
> >               return -EINVAL;
> >
> >       rxe_cleanup(mr);
> > -     kfree_rcu(mr);
> > +     kfree_rcu_mightsleep(mr);
> >       return 0;
> >  }
> >
> Please replace kfree_rcu_mightsleep() by kfree(). There is no need to del=
ay the kfree(mr).

I thought you said either was Ok, but yeah that's fine with me. I was
trying to play it safe ;-). An extra GP may not hurt, but not having
one when it is needed might. I will update it to just be kfree.

<quote>
>   rxe_cleanup(mr);
> - kfree_rcu(mr);
> + kfree_rcu_mightsleep(mr);
>   return 0;
>  }
>

I would prefer just
- kfree_rcu(mr);
+ kfree(mr);

but either one will work.
Bob
</quote>

 - Joel
