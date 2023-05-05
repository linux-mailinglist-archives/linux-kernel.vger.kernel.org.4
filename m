Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F576F82AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjEEMKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjEEMKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:10:40 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05D41AEFB
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 05:10:38 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-33164ec77ccso552945ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 05:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683288638; x=1685880638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tidKINGncTA+p8ufXsH97B8VbplL15U4SOqjeLKOv9Y=;
        b=Qa1lnDP3l0k8Xxa+71SWmPWHhAK4xR5nm2JTccTw0ouSLk777GR+fKH3/I/fWY4wCH
         4+5wSsRkFXN8UPLVVNxvBZmDxKMDebkojJbgjT5eeZCZnZ0ChXWwfaC52b7hBuk/63z6
         H+t5gTucE9URBCD0dHYHCOZbIn82h3iPFZWCv3UZqdwBFxEy1NslnVGpd3wFdU2cjsS+
         ZpDBzZmBRPKr6yNgP3bJrLaj+cLxgkqWJiwRRg8uSa8r9np9JKl36uf6vMFAhuhGc+/S
         XM2hCGTp5Zpc9yv025hX/+dEpUNOV6IWCl+df2WLbr11O/ZLp0hMjeGjbMfNAOma6R7S
         4Z0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683288638; x=1685880638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tidKINGncTA+p8ufXsH97B8VbplL15U4SOqjeLKOv9Y=;
        b=BLYsgMnatW/8b35R4qTOVp/mzgADkjJcD7rL1+F7Bk0vUkuzwlO1tgFB6wVnMnKOOn
         0msCy392UOqgeJzyyPB4dfRx/nQz7uBOIIdIGR1FS5w3XajCsxZkqXBh6WBOcRCtQDvt
         r4moBwG3BnSNZRCEauGCrs2JZJNDxQ4aTvHNf8RjrLJj4rYOyienq1vaE7BdMS6xrm9R
         3S7ND8aHFQjbTzo9gDNR+afDX9t/pn7sDU1jrA2Tu4cQaeYUGZ52fT2Po+V6k5yvplZr
         YpE5Om+T33B8So9xfpqEhn1L44CeoHEOVkpVtPm1OvBgiWtXBKFEhj1iCs03tZ84JgdO
         5PMg==
X-Gm-Message-State: AC+VfDzf0c6yAwN+INgqy9sqwVAl4mGhswVdSDUTfLvdKV9q3eA21o5q
        4Ni8jIXqc8S6VWpG9PrYK4AIpcgfupYLG/JE0enbQA==
X-Google-Smtp-Source: ACHHUZ6+Sz9wXGNsJ54naDmeqrAHxiUZczPWVTomwvEYzipZXiygcBekORjvmD8FIQXG1o8L2hCtcBkjM4L0mNtEMX4=
X-Received: by 2002:a05:6e02:1609:b0:329:3f69:539e with SMTP id
 t9-20020a056e02160900b003293f69539emr158778ilu.2.1683288637752; Fri, 05 May
 2023 05:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230505113315.3307723-1-liujian56@huawei.com> <20230505113315.3307723-5-liujian56@huawei.com>
In-Reply-To: <20230505113315.3307723-5-liujian56@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 5 May 2023 14:10:26 +0200
Message-ID: <CANn89iJL3ywLwig8U6JKG6itL7Fr=ab_dv7Pz1YDiDvCiR-Fog@mail.gmail.com>
Subject: Re: [PATCH 4/9] softirq: Allow early break
To:     Liu Jian <liujian56@huawei.com>
Cc:     corbet@lwn.net, paulmck@kernel.org, frederic@kernel.org,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        josh@joshtriplett.org, boqun.feng@gmail.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        qiang1.zhang@intel.com, jstultz@google.com, tglx@linutronix.de,
        sboyd@kernel.org, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, peterz@infradead.org, frankwoo@google.com,
        Rhinewuwu@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 5, 2023 at 1:24=E2=80=AFPM Liu Jian <liujian56@huawei.com> wrot=
e:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> Allow terminating the softirq processing loop without finishing the
> vectors.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
>  kernel/softirq.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 48a81d8ae49a..e2cad5d108c8 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -582,6 +582,9 @@ asmlinkage __visible void __softirq_entry __do_softir=
q(void)
>                                prev_count, preempt_count());
>                         preempt_count_set(prev_count);
>                 }
> +
> +               if (pending && __softirq_needs_break(start))
> +                       break;

This means that some softirq may starve, because

for_each_set_bit(vec_nr, &pending, NR_SOFTIRQS)

Always iterate using the same order (of bits)




>         }
>
>         if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> @@ -590,13 +593,14 @@ asmlinkage __visible void __softirq_entry __do_soft=
irq(void)
>
>         local_irq_disable();
>
> -       pending =3D local_softirq_pending();
> -       if (pending) {
> -               if (!__softirq_needs_break(start) && --max_restart)
> -                       goto restart;
> +       if (pending)
> +               or_softirq_pending(pending);
> +       else if ((pending =3D local_softirq_pending()) &&
> +                !__softirq_needs_break(start) &&
> +                --max_restart)
> +               goto restart;
>
> -               wakeup_softirqd();
> -       }
> +       wakeup_softirqd();
>
>         account_softirq_exit(current);
>         lockdep_softirq_end(in_hardirq);
> --
> 2.34.1
>
