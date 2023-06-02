Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA33720C29
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 01:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbjFBXAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 19:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbjFBXAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 19:00:13 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950A51B8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 16:00:12 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-565ee3d14c2so27554337b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 16:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1685746812; x=1688338812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gu/jJLV8GpS/4k+cydSglYZByXG+Mppg0bGRw+veAQc=;
        b=n+CVYF4Tuyyz/8u1854NGgzFqK5+hUef0fmwxGv2HJN3YW2ncq7KUfOZtLVyt2Efjg
         ZqIH+8nJOy02Yx0oIhY2rAU163b5YoDfMVgkNLj1GxSlBRwAIFKUTm2rDlxmaOJVIVbn
         WVfEVco94qRLBkhImari5ahpts/h9FR2UvMhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685746812; x=1688338812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gu/jJLV8GpS/4k+cydSglYZByXG+Mppg0bGRw+veAQc=;
        b=OSvl6ExJLCGKVl/b5olM4hFao8iNQ0c5zEb7QaYAGNmEUfwpkNGeYf0IQ3HuV9PqLj
         dbccKhr9HhKfmHNZi+Z5w6cgxsbhjJKMGv3xnNKESArFLgAAV7oXOJqHfls82UIZ3PgF
         XpWYeryGag6IMB7GTSOdBkf9EHKx2If4LC8pdGJdq05+WzX9rtlqsFDU+IvYbq9qn8nq
         5FWvfMnSCTr9aojhkjuLWi7TtCiKREufb2Z000Hu5ZYEVPgMohdm1F41EMnhqwyeX5jL
         Y5RA3ViaGv0+it6a6A9GRggbDWJMFXR29S3X/iQ8WKpM3UCNwOTKXQn4647lH98nHTJX
         c3RA==
X-Gm-Message-State: AC+VfDyG84vklG87/2wauxyQyws327YlGfZFYfnq7T0wDXU5VUGmxy/i
        ddPF6Ir1cNnWeroHXelf6e7o00hP8Y+ei6JXkvKonPCHzdQNxF3X
X-Google-Smtp-Source: ACHHUZ7k1w3VVHVPdfiggFFlDnugb+v5ibHwqQOyIcWLvl8GAKysKHCP5O4HvLB/GxwUgYVFDhQSBF3IISry1VPotqc=
X-Received: by 2002:a0d:f405:0:b0:559:fad8:322f with SMTP id
 d5-20020a0df405000000b00559fad8322fmr1677466ywf.24.1685746811742; Fri, 02 Jun
 2023 16:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230531101736.12981-1-frederic@kernel.org> <20230531101736.12981-3-frederic@kernel.org>
In-Reply-To: <20230531101736.12981-3-frederic@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 2 Jun 2023 19:00:00 -0400
Message-ID: <CAEXW_YQhufHtuNc5stZQpBY8JSd99NVWEzqv=-QbeMFOA-vDnQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] rcu: Use rcu_segcblist_segempty() instead of open
 coding it
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 6:17=E2=80=AFAM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> This makes the code more readable.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/rcu_segcblist.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index f71fac422c8f..1693ea22ef1b 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -368,7 +368,7 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rscl=
p,
>         smp_mb(); /* Ensure counts are updated before callback is entrain=
ed. */
>         rhp->next =3D NULL;
>         for (i =3D RCU_NEXT_TAIL; i > RCU_DONE_TAIL; i--)
> -               if (rsclp->tails[i] !=3D rsclp->tails[i - 1])
> +               if (!rcu_segcblist_segempty(rsclp, i))

Hopefully the compiler optimizer will be smart enough to remove this
from the inlined code ;-):
if (seg =3D=3D RCU_DONE_TAIL)
   return &rsclp->head =3D=3D rsclp->tails[RCU_DONE_TAIL];

Otherwise it appears to be no functional change for this and the below
change, and straightforward so for this patch:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


>                         break;
>         rcu_segcblist_inc_seglen(rsclp, i);
>         WRITE_ONCE(*rsclp->tails[i], rhp);
> @@ -551,7 +551,7 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *r=
sclp, unsigned long seq)
>          * as their ->gp_seq[] grace-period completion sequence number.
>          */
>         for (i =3D RCU_NEXT_READY_TAIL; i > RCU_DONE_TAIL; i--)
> -               if (rsclp->tails[i] !=3D rsclp->tails[i - 1] &&
> +               if (!rcu_segcblist_segempty(rsclp, i) &&
>                     ULONG_CMP_LT(rsclp->gp_seq[i], seq))
>                         break;
>
> --
> 2.40.1
>
