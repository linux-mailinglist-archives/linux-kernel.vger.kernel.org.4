Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECA1667892
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbjALPGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240151AbjALPGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:06:01 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644346147C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:54:40 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id s5so12169770qtx.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dT0ykU70TtL3YPQYLpqbW6lCkoFtNucTYqrJdjbf/MQ=;
        b=w9jMuuWxlRO8/5Q+i//ZqW872iSURFz0Q9hMydq6vN7JIprkLCZcbt4Ge0VEM8V/8s
         4J6WCMcI8d7nGyjL9KzZ3Z2EujK9aqteocXhgrBOZ1XwqziTm1+ctiQBfT+A2UOa3/hP
         V8s54JleXW2P+uTp7qem6UCiHV+ZjoUaoXmic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dT0ykU70TtL3YPQYLpqbW6lCkoFtNucTYqrJdjbf/MQ=;
        b=eZKrIjKVixJgZalbSkkhJWTdWBFhF3hF5KtXXsNNOjzDo68iIC9cGEt9Pk+cFNiwXu
         IVIlioU/vgxOx37oIS1PNspi7urL723YYwcuQE7v1LmevFKu5dNlVyWY6OBUbMsOxwDJ
         1yJJwIRc16mI8uOctbVvQ5FZAdaDKpiUH0OT9hTC0x1hbJmWcvZHvxI3nfEcztiScjKq
         3wKm0JaQG5HI5FdJtspFRG5L6/NGXiCZB7TwBi/1Pw7s+8jk0ijGatiFc5LjfQIDRlFT
         K200c912thhn+xG+hx0+Q9svG71DpYfYP9aN8p99+pDWDcyi1GJzPDJyi4OGDE2TwoPr
         kRXQ==
X-Gm-Message-State: AFqh2kp7kXC/JcE3yhSydmgdUvCV97sI0TYk6Ee5TghE6q43e53qZ7jY
        wnLDCaLOCHtBSKTz6Dy3kJ8U9zWfq02DoBrg
X-Google-Smtp-Source: AMrXdXvo8p/7hsbVuJxPx9MiUNwCabZ7q9GTkh+gU/CfUZBjgofLKwofPt3EP0rO6Amn19hbayVFbg==
X-Received: by 2002:a05:622a:244e:b0:3a5:17f0:e718 with SMTP id bl14-20020a05622a244e00b003a517f0e718mr104818998qtb.14.1673535279317;
        Thu, 12 Jan 2023 06:54:39 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id l17-20020ac848d1000000b003ab43dabfb1sm9206133qtr.55.2023.01.12.06.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 06:54:38 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] rcu: Fix the start_poll_synchronize_rcu_expedited() be invoked very early
Date:   Thu, 12 Jan 2023 09:54:26 -0500
Message-Id: <13E7FFFD-9F91-4221-B52C-E6CB1EFBC2AB@joelfernandes.org>
References: <20230112075629.1661429-1-qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230112075629.1661429-1-qiang1.zhang@intel.com>
To:     Zqiang <qiang1.zhang@intel.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jan 12, 2023, at 2:51 AM, Zqiang <qiang1.zhang@intel.com> wrote:
>=20
> =EF=BB=BFCurrently, the start_poll_synchronize_rcu_expedited() can be invo=
ked
> very early. before rcu_init(), the rcu_data structure's->mynode is not
> initialized, if invoke start_poll_synchronize_rcu_expedited() before
> rcu_init(), will trigger a null rcu_node structure's->exp_seq_poll access.=

>=20
> This commit add boot_exp_seq_poll_rq member to rcu_state structure to
> store seq number return by invoke start_poll_synchronize_rcu_expedited()
> very early.
>=20
> Fixes: d96c52fe4907 ("rcu: Add polled expedited grace-period primitives")
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks.



> ---
> kernel/rcu/tree.c     | 3 ++-
> kernel/rcu/tree.h     | 1 +
> kernel/rcu/tree_exp.h | 6 ++++--
> 3 files changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 63545d79da51..12f0891ce7f4 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -92,6 +92,7 @@ static struct rcu_state rcu_state =3D {
>    .exp_mutex =3D __MUTEX_INITIALIZER(rcu_state.exp_mutex),
>    .exp_wake_mutex =3D __MUTEX_INITIALIZER(rcu_state.exp_wake_mutex),
>    .ofl_lock =3D __ARCH_SPIN_LOCK_UNLOCKED,
> +    .boot_exp_seq_poll_rq =3D RCU_GET_STATE_COMPLETED,
> };
>=20
> /* Dump rcu_node combining tree at boot to verify correct setup. */
> @@ -4938,7 +4939,7 @@ void __init rcu_init(void)
>        qovld_calc =3D qovld;
>=20
>    // Kick-start any polled grace periods that started early.
> -    if (!(per_cpu_ptr(&rcu_data, cpu)->mynode->exp_seq_poll_rq & 0x1))
> +    if (!(rcu_state.boot_exp_seq_poll_rq & 0x1))
>        (void)start_poll_synchronize_rcu_expedited();
>=20
>    rcu_test_sync_prims();
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 192536916f9a..ae50ca6853ad 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -397,6 +397,7 @@ struct rcu_state {
>                        /* Synchronize offline with */
>                        /*  GP pre-initialization. */
>    int nocb_is_setup;            /* nocb is setup from boot */
> +    unsigned long boot_exp_seq_poll_rq;
> };
>=20
> /* Values for rcu_state structure's gp_flags field. */
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 956cd459ba7f..1b35a1e233d9 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -1068,9 +1068,11 @@ unsigned long start_poll_synchronize_rcu_expedited(=
void)
>    if (rcu_init_invoked())
>        raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
>    if (!poll_state_synchronize_rcu(s)) {
> -        rnp->exp_seq_poll_rq =3D s;
> -        if (rcu_init_invoked())
> +        if (rcu_init_invoked()) {
> +            rnp->exp_seq_poll_rq =3D s;
>            queue_work(rcu_gp_wq, &rnp->exp_poll_wq);
> +        } else
> +            rcu_state.boot_exp_seq_poll_rq =3D s;
>    }
>    if (rcu_init_invoked())
>        raw_spin_unlock_irqrestore(&rnp->exp_poll_lock, flags);
> --=20
> 2.25.1
>=20
