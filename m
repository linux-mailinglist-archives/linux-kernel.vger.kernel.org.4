Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845376FAC6A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbjEHLYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbjEHLYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:24:11 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3058B3A5E6
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:24:06 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b983027d0faso5840871276.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1683545045; x=1686137045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ac1PyFGzSyD65jA/7/m9p7M+ymxiLTtNuhIFAnIl/Q=;
        b=bFHVtn+8TSgWbaTqjdMEHaw/Cts+pAWZReNo6J9oJlZrDogaUC9uBnx/tWcop2CcZh
         sciKWd8+cAZAMz6JHDqmL2RsO+cgfCW8lKFBtxOSb0s9Ssn107siHJgvuWweWo6V8xdD
         KxBVxmi14mEWj+U9ncrYh0Dy6wLoplMdMVVF6Ad0Ap9gSoCBwdz2dg89aKS9o6wjpD9V
         t7ar9Whk4tOS9XymljI3XRT+bqIAI1bh+MHddx30oKobQV0aJGOOP3LQHCs8gq/rFI6B
         uxX9CgXtSBf+VslUlrHiI67GeRX9Z2fERLRk/O75uLnneHGv5XZqniQmq0CEFotCQNLo
         g8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683545045; x=1686137045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ac1PyFGzSyD65jA/7/m9p7M+ymxiLTtNuhIFAnIl/Q=;
        b=dTscG+Tjmi4ZUSp64fdwpUeSLC5eFT1qq7KAnAM2y1Dt+LsCtaYRHPZMtTxYhY4sqy
         wQmK85+KFyNqiMB9e6YU8s5rrc8zS0XNy2lhAFe9/LweFPekP11BNiiiGzZaFNGPOuUy
         V4mmEPnx3GnP5TMCUbO2P+xgP2hp/yAiYfBi2i9Nsim3PzjJQY9lOxIfKasQAiU4qEwJ
         N6Rjn/f26zmJS7B2TT3tnSv6QgRxhPkeAYywVBD5bhLfvrJBl/FEdU90ZUkhbAl2iGRu
         04NCdLsy5nzvtuxIG+WT2AuJBQMKuni1t9Z9sRxgLUjfpSrSnWRaK+IYwbOdGIu9fE3E
         uNCQ==
X-Gm-Message-State: AC+VfDxfIEmi0ZZXDdQEx7sCNkx8//jTLlm1vd5jRP0tMF9fO7L7OUVO
        Q0igJqhzDfelNJ3CsIHjN5rGg/Uzjm4ZKnyp/g/M7A==
X-Google-Smtp-Source: ACHHUZ6swGwpcIcljJbBeeQFb9wi9+9cgXqIi4GtHt4LIzfHLTWYoO8TSXechchwqMGqtMAhT0B9B9dHUJG2123dLaI=
X-Received: by 2002:a25:2554:0:b0:b9e:6309:9412 with SMTP id
 l81-20020a252554000000b00b9e63099412mr11554200ybl.60.1683545045368; Mon, 08
 May 2023 04:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683326865.git.peilin.ye@bytedance.com> <9969180f9219ed18656d8f3c92e717f6eb398aa1.1683326865.git.peilin.ye@bytedance.com>
In-Reply-To: <9969180f9219ed18656d8f3c92e717f6eb398aa1.1683326865.git.peilin.ye@bytedance.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Mon, 8 May 2023 07:23:54 -0400
Message-ID: <CAM0EoMnZGmRh87bwcRxgB3ZZChWmhHniA7M-ptXt7AKXtuY-Bg@mail.gmail.com>
Subject: Re: [PATCH net 3/6] net/sched: Reserve TC_H_INGRESS (TC_H_CLSACT) for
 ingress (clsact) Qdiscs
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Peilin Ye <peilin.ye@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.r.fastabend@intel.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 5, 2023 at 8:14=E2=80=AFPM Peilin Ye <yepeilin.cs@gmail.com> wr=
ote:
>
> Currently it is possible to add e.g. an HTB Qdisc under ffff:fff1
> (TC_H_INGRESS, TC_H_CLSACT):
>
>   $ ip link add name ifb0 type ifb
>   $ tc qdisc add dev ifb0 parent ffff:fff1 htb
>   $ tc qdisc add dev ifb0 clsact
>   Error: Exclusivity flag on, cannot modify.
>   $ drgn
>   ...
>   >>> ifb0 =3D netdev_get_by_name(prog, "ifb0")
>   >>> qdisc =3D ifb0.ingress_queue.qdisc_sleeping
>   >>> print(qdisc.ops.id.string_().decode())
>   htb
>   >>> qdisc.flags.value_() # TCQ_F_INGRESS
>   2
>
> Only allow ingress and clsact Qdiscs under ffff:fff1.  Return -EINVAL
> for everything else.  Make TCQ_F_INGRESS a static flag of ingress and
> clsact Qdiscs.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 1f211a1b929c ("net, sched: add clsact qdisc")
> Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>


cheers,
jamal

> ---
>  net/sched/sch_api.c     | 7 ++++++-
>  net/sched/sch_ingress.c | 4 ++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index fdb8f429333d..383195955b7d 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1252,7 +1252,12 @@ static struct Qdisc *qdisc_create(struct net_devic=
e *dev,
>         sch->parent =3D parent;
>
>         if (handle =3D=3D TC_H_INGRESS) {
> -               sch->flags |=3D TCQ_F_INGRESS;
> +               if (!(sch->flags & TCQ_F_INGRESS)) {
> +                       NL_SET_ERR_MSG(extack,
> +                                      "Specified parent ID is reserved f=
or ingress and clsact Qdiscs");
> +                       err =3D -EINVAL;
> +                       goto err_out3;
> +               }
>                 handle =3D TC_H_MAKE(TC_H_INGRESS, 0);
>         } else {
>                 if (handle =3D=3D 0) {
> diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
> index 13218a1fe4a5..caea51e0d4e9 100644
> --- a/net/sched/sch_ingress.c
> +++ b/net/sched/sch_ingress.c
> @@ -137,7 +137,7 @@ static struct Qdisc_ops ingress_qdisc_ops __read_most=
ly =3D {
>         .cl_ops                 =3D       &ingress_class_ops,
>         .id                     =3D       "ingress",
>         .priv_size              =3D       sizeof(struct ingress_sched_dat=
a),
> -       .static_flags           =3D       TCQ_F_CPUSTATS,
> +       .static_flags           =3D       TCQ_F_INGRESS | TCQ_F_CPUSTATS,
>         .init                   =3D       ingress_init,
>         .destroy                =3D       ingress_destroy,
>         .dump                   =3D       ingress_dump,
> @@ -275,7 +275,7 @@ static struct Qdisc_ops clsact_qdisc_ops __read_mostl=
y =3D {
>         .cl_ops                 =3D       &clsact_class_ops,
>         .id                     =3D       "clsact",
>         .priv_size              =3D       sizeof(struct clsact_sched_data=
),
> -       .static_flags           =3D       TCQ_F_CPUSTATS,
> +       .static_flags           =3D       TCQ_F_INGRESS | TCQ_F_CPUSTATS,
>         .init                   =3D       clsact_init,
>         .destroy                =3D       clsact_destroy,
>         .dump                   =3D       ingress_dump,
> --
> 2.20.1
>
