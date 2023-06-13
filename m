Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B595972ED22
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbjFMUiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbjFMUiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:38:06 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692B2E0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:38:05 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f9b7de94e7so71621cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686688684; x=1689280684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BrUCOEPHj+KJSOSvkwPnQDjHbdcqCfclmuB+OEMU6A=;
        b=tPbftEADHtzbL8pHewCZOaadBMt3EtqzufnPUKQ7cMVEQQgSLLp5yUS3pvMu2rmGpA
         Mi6fRUFFM0sIsZZE+gc7cL3VI6StwhQMfFITA7mUiEkBo+bXJXvbBtWOSrL3kJjhNf/H
         enEoXUlzxh5buT4VOJqYmMTIryQmZiC02aywygPEGL6PM26oqZJvJ6OGkNZTFMkG7SoJ
         A44bQnZB8YwlTvqAqBQyYSR630yBz3Kwrxrcx7X+I4rkk6TAIu14Cfny6sBjWa2zj4S4
         yzeEGH16bqGbezWDBK7tmU2LmtzR7jDiNLvmiA+nEsfgIsnQSMecLLh9qDnPhb/K4vKC
         Kabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688684; x=1689280684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BrUCOEPHj+KJSOSvkwPnQDjHbdcqCfclmuB+OEMU6A=;
        b=ZRfQTDW5VGlq0pCN/X3cqZE6Iv4QocLmmJQMi8AGo8rv+D0mQlGqEiyOMIcRInECZm
         L2BeUqp8ZeZM+39mGAL9ZtkPULyMgo98wzxxqmEtD7wZ5m4hbNsEjJlwmqAoT1U0fohS
         3kPhRu9Q5oh05pi605xfWrxyeVzyKnFGx0jVXQcQLpV51QPe7Q5Hd2MbU5ydmAm9Rv63
         CiQ2zrXFeQoKxnA8J7/4YLA74PrDRMrh8GOlC+VYBkBFpioJR90uWw2yJtDEyaeE9zJp
         N7t1rjYNzqIF/y5SJwXi48RtKJRG3sUX01wgCJqnbHWeQjJcsNtVzZncJ2p4nEfhkK1B
         XxVg==
X-Gm-Message-State: AC+VfDy5/JyZte3y2H32NhNir+5MoLaa9a7NZLDMbE9JqUv9zuR1O88T
        3/UhQPtUNYWo0msltZ16jBpXLvGrv26OoD+4r3Lx
X-Google-Smtp-Source: ACHHUZ6qvY4tuCzekFd0O+W34XKwmvzz+wTzx+mbpy8z5FP1aIdkN0T2w3UueyN4sbFs7OOJ6Q/Y5fX2C52jCUrz0/A=
X-Received: by 2002:a05:622a:54b:b0:3fd:aaef:3807 with SMTP id
 m11-20020a05622a054b00b003fdaaef3807mr54313qtx.16.1686688684337; Tue, 13 Jun
 2023 13:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230601055846.2349566-1-jstultz@google.com> <20230601055846.2349566-8-jstultz@google.com>
 <fd5d06cd-bda5-0e3e-5f90-d3c5464bfcad@arm.com>
In-Reply-To: <fd5d06cd-bda5-0e3e-5f90-d3c5464bfcad@arm.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 13 Jun 2023 13:37:50 -0700
Message-ID: <CANDhNCpfnQKwaQ5Be+CfBzd4GqBp0A1uKjPQaDbNm=k+Y4BprQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/13] sched: Split scheduler execution context
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        "Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:12=E2=80=AFAM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
> On 01/06/2023 07:58, John Stultz wrote:
> > NOTE: Peter previously mentioned he didn't like the name
> > "rq_selected()", but I've not come up with a better alternative.
> > I'm very open to other name proposals.
> >
> > Question for Peter: Dietmar suggested you'd prefer I drop the
> > conditionalization of the scheduler context pointer on the rq
> > (so rq_selected() would be open coded as rq->curr_sched or
> > whatever we agree on for a name), but I'd think in the
> > !CONFIG_PROXY_EXEC case we'd want to avoid the wasted pointer
> > and its use (since it curr_sched would always be =3D=3D curr)?
> > If I'm wrong I'm fine switching this, but would appreciate
> > clarification.
>
> IMHO, keeping both, rq->curr and rq->proxy (latter for rq->curr_sched)
> would make it easier to navigate through the different versions of this
> patch-set while reviewing.
>
> I do understand that you have issues with the function name proxy() not
> returning the proxy (task blocked on a mutex) but the mutex owner instead=
.
>
> The header of v3 'sched: Add proxy execution'
> https://lkml.kernel.org/r/20230411042511.1606592-12-jstultz@google.com
> mentions:
>
> " ... Potential proxies (i.e., tasks blocked on a mutex) are not
>   dequeued, so, if one of them is actually selected by schedule() as the
>   next task to be put to run on a CPU, proxy() is used to walk the
>   blocked_on relation and find which task (mutex owner) might be able to
>   use the proxy's scheduling context. ..."
>
> But as I can see now, you changed this patch header in v4 to explain the
> PE model slightly differently.

Yeah. (As you know from offline discussions :) I do feel a bit
strongly that using the term proxy for the scheduler context is
unnecessarily confusing and requires some mental contortions to try to
make it fit the metaphor being used.

In my mind, the task chosen by pick_next_task() is what we want to
run, but if it is blocked on a mutex, we let the mutex owner run on
its behalf, with the "authority" (ie: scheduling context) of the
originally chosen task.

This is a direct parallel to proxy voting where a person who needs to
vote cannot attend, so someone else is sent to vote on their behalf,
and does so with the authority of the person who cannot attend.

So, much like the person who votes on behalf of another is the proxy,
with proxy-execution it makes most sense that the task that runs on
the selected task's behalf is the proxy.

Calling the selected scheduler context the proxy makes it very
difficult to use the metaphor to help in understanding what is being
done. I'll grant you can try to twist it around and view it so that
the blocked tasks are sort of proxy-voters left on the runqueue and
sent to the pick_next_task() function to vote on behalf of a mutex
owner, but that would be more like "proxy-scheduling". And it breaks
down further as the blocked tasks actually don't know who they are
voting for until after they are selected and we run proxy() to walk
the blocked_on chain.  It just doesn't fit the metaphor very well
(maybe "puppet candidates " would be better in this model?) and I
think it only adds confusion.

This logic is already subtle and complex enough - we don't need to add
stroop effects[1] to keep it interesting. :)

But I agree the historic usage of the term proxy in the patch series
makes it hard to simply switch it around, which is why I tried instead
to reduce the use of the term proxy where it didn't seem appropriate,
replacing it with "selected" or "donor".

Again, I'm happy to switch to other terms that make sense.

thanks
-john

[1] https://en.wikipedia.org/wiki/Stroop_effect
