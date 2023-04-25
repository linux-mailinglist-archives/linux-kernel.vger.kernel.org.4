Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E5A6EE432
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjDYOrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbjDYOr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:47:29 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE0510FB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:47:27 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3ef34c49cb9so124461cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682434046; x=1685026046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8D4v18sNHWljGTZiD6H+K+hxsItjerFP14Gx+pEDFE=;
        b=EHKyisgmDwZLRRF5KVNxF1Lb/INxJUVSaCOr9EKPLPM+l+AnYvQFjvMICF+ZVsuAdm
         P3FMtDM7eIjG+ib85d7EZrGOptwbcAEShezcxQjLzJuYL9qA4DNKr2wtwYDrguflis0E
         qSDk7tcbRRXYwVmUyX0pHWFpm6uCEPqyR5Eo3NVejoos0mMzX3y5sU9SDrf+H8/799pf
         ikzwuOysZmLvfUxIhCNgKeoqoCQQyhyzH53zFhQRhcRpWZeRPQOnzcuwSlJuexinyOmN
         7A1J0mVraBfXQvg1+uevDdbMsFmDyqHT5ty7BCJlwcTlnE6kEdaaLcEZiWplwP+Ezq8f
         50jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682434046; x=1685026046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8D4v18sNHWljGTZiD6H+K+hxsItjerFP14Gx+pEDFE=;
        b=LVUdoRQYdZr2B67jcBm4olk0I3jlomxRRLw2g3PEvyyZjW+adSq6QW7axNID9ZgVci
         7mhGv/nI13IbCfX/fCeXNe/yqglTgTj+PiX/HFddynTvKSYpUb3Y+8b5wQtYCK2BQC3g
         fGKg+YPW9iR5aOHFIVQuYcozQK21kY+alpRwwYnfhRU5SFOrbZabZ330eeSHv/HM49Lq
         h6Sc5/7X4Y84QvqTIBXYHLuflyZRQcrgiqHtIF9bgXIFfpRw+6REhtEkLABWCItH35EX
         mvnyOX2rhth25PRFd8/qiUSY5GobrDafVdi1oHMqn3k3T6wIoyiJGw2a9e50KfGuDrdk
         oKTw==
X-Gm-Message-State: AAQBX9e5u7ELthO9MKddgmvBrO9K6w2ZDQSkYU+3C7jVWwPNsF23E7ir
        RyKxhsrumFJnqnXMpZKxlCS15QJoihnpxyf1AJUf
X-Google-Smtp-Source: AKy350aNaKKPhR5vt5BUrlj3Zf5sTY9IbjFXe9bgH2TRX+pc7tmPdEVpOMOmeoYc3W2FCa7Tng39yDjtHBFfyul8l7I=
X-Received: by 2002:a05:622a:15ce:b0:3ef:3083:a437 with SMTP id
 d14-20020a05622a15ce00b003ef3083a437mr367056qty.18.1682434046495; Tue, 25 Apr
 2023 07:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230411042511.1606592-1-jstultz@google.com> <20230411042511.1606592-9-jstultz@google.com>
 <20230422104205.GF1214746@hirez.programming.kicks-ass.net>
In-Reply-To: <20230422104205.GF1214746@hirez.programming.kicks-ass.net>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 25 Apr 2023 15:47:14 +0100
Message-ID: <CANDhNCp1AikQrFUpvXgNoJFEEBcq_6F5y0vhqe0m8fi2CBdJEg@mail.gmail.com>
Subject: Re: [PATCH v3 08/14] sched: Replace rq->curr access w/ rq_curr(rq)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 11:42=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Tue, Apr 11, 2023 at 04:25:05AM +0000, John Stultz wrote:
> > +static inline struct task_struct *rq_curr(struct rq *rq)
> > +{
> > +     return rq->curr_exec;
> > +}
> > +
> > +static inline struct task_struct *rq_curr_rcu(struct rq *rq)
> > +{
> > +     return rcu_dereference(rq->curr_exec);
> > +}
> > +
> > +static inline struct task_struct *rq_curr_once(struct rq *rq)
> > +{
> > +     return READ_ONCE(rq->curr_exec);
> > +}
> > +
> > +static inline void rq_set_curr(struct rq *rq, struct task_struct *task=
)
> > +{
> > +     rcu_assign_pointer(rq->curr_exec, task);
> > +}
> > +
> > +/*
> > + *  XXX jstultz: seems like rcu_assign_pointer above would also
> > + *               work for this, but trying to match usage.
> > + */
> > +static inline void rq_set_curr_rcu_init(struct rq *rq, struct task_str=
uct *task)
> > +{
> > +     RCU_INIT_POINTER(rq->curr_exec, task);
> > +}
>
> > +static inline struct task_struct *rq_selected(struct rq *rq)
> > +{
> > +       return rq->curr_sched;
> > +}
> > +
> > +static inline struct task_struct *rq_selected_rcu(struct rq *rq)
> > +{
> > +       return rcu_dereference(rq->curr_sched);
> > +}
> > +
> > +static inline struct task_struct *rq_selected_once(struct rq *rq)
> > +{
> > +       return READ_ONCE(rq->curr_sched);
> > +}
> > +
> > +static inline void rq_set_selected(struct rq *rq, struct task_struct *=
t)
> > +{
> > +       rcu_assign_pointer(rq->curr_sched, t);
> > +}
>
> How is any of that helping? That's just making it harder to read.

Heh. So the main reason I added these was so the !CONFIG_PROXY_EXEC
case would be able to collapse down cleanly.

> Can we please just keep it rq->curr and rq->proxy and stop this wrapper
> fettish.

So, I could go back and set the rq_curr() back to rq->curr, but it
seems like we'd still want the rq_selected()  [whatever its named]
wrapper to avoid the extra pointer in the task struct when proxy-exec
isn't used. Or do you have a different suggestion for this?

thanks
-john
