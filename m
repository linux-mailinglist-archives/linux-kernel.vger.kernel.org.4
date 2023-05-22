Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B2C70C148
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjEVOkP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 May 2023 10:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjEVOkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:40:14 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2431099;
        Mon, 22 May 2023 07:40:13 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-96f44435d92so70905366b.0;
        Mon, 22 May 2023 07:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684766411; x=1687358411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLmyLsCzwbc8OCmJXXEKpfMdXpfNHdxWW2uiYbc6z0w=;
        b=GQzN/dP23Z8axTMRl/QnFJ+kq8me2mv+Zt93a9aKViVLiVU4zjSZMqifItsgA8dTbv
         KXOraaCVpXEpW6L1aK7Rs//xn/WMrQKYgUUztoK9jYsKnbvpz1sVArcsoAsbEnGjc5ty
         3WIfFtp7+U1G1vz2GVhaVEhXlLJ4gxTeHiAMCsVZmcXKaGLIOpied9VtMJj8v1GSlORa
         4Wghfbc9OFcbs+xCnBtXZb5ZM0MHzAHjYp0paxme9KeAtrqarUcxg7kkmtMhFr+SLqRn
         90KmiK00+BtlSgwPdyhFEuBptrAQMRXGj1sQ6qXDbVldVhtjdgVklAt9L4XJgrLLYKvF
         SjsQ==
X-Gm-Message-State: AC+VfDxkJLZssE+qIPMZCiuG7Mph8XVi7vxZPS4dDA/r/wuGUo6luciN
        R/fHQKP7XsFdQ9FOh7lQeUTcyjLvoGKtOX99fNA=
X-Google-Smtp-Source: ACHHUZ68Du/PCOq69mfBJjbyvh2dZ/sSlOvz8nhaPkAs7sKLKR9uYX4wODd97mYW3pDmKs/3w+rBM0MQPg863WlDnb0=
X-Received: by 2002:a17:906:d3:b0:94f:66af:b1f7 with SMTP id
 19-20020a17090600d300b0094f66afb1f7mr9491479eji.1.1684766411370; Mon, 22 May
 2023 07:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230509122246.1702397-1-lukasz.luba@arm.com> <88fcd266-301a-f6e1-cf1c-69c20e74ef35@arm.com>
In-Reply-To: <88fcd266-301a-f6e1-cf1c-69c20e74ef35@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 May 2023 16:40:00 +0200
Message-ID: <CAJZ5v0juOwCHNoCo8gX+NopuzK18d+v3QV0qkGcg1BvDVcPpKQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add basic tracing for uclamp and schedutil
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, rostedt@goodmis.org,
        mhiramat@kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, delyank@fb.com,
        qyousef@google.com, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Mon, May 22, 2023 at 3:38 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Rafael,
>
>
>
> On 5/9/23 13:22, Lukasz Luba wrote:
> > Hi all,
> >
> > The task scheduler feature: Uclamp, begins to take off. To better understand
> > the dynamics in the task scheduler and CPU frequency requests we need some
> > better tracing.
> > In schedutil (cpufreq governor) we allow to enter the scheduler
> > and make the frequency change. Although, there is some limit in regards to how
> > often this can happen. That min period is provided by the cpufreq driver.
> > Thus, some of the cpufreq requests might be filter out and the frequency won't
> > be changed (hopefuly will be set a bit later). We would like to know about
> > those situations, especially in context of the user-space hints made via
> > Uclamp for particular tasks.
> > This patch set aims to add base for our toolkits and post-processing trace
> > analyzes.
>
> > Changelog:
> > v2:
> > - solved the issue from CI build warning, dropped schedutil.h and re-used
> >    the sched.h which is available in build_utility.c where cpufreq_schedutil.c
> >    is included
> > - added tag for the last patch 3/3 for the CI robot helping hend
> > - re-based on top of v6.4-rc1
> > v1:
> > - implementation can be found here [1]
> >
>
> I was going to gently ping you, while I've realized that you
> are not on CC list :( I don't know what happened, my apologies.

No worries.

> Shell I resend this patch set so you can have it in a proper way
> in your mailbox?

Well, for schedutil you should also CC linux-pm (done now), so please resend it.

> Could you have a look at this, please?

I could, but if I'm to reply, it will be much more convenient for me
if it is there in my inbox.

> This is getting more attention, since in Android we have a
> daemon which can now communicate with the kernel and send
> those Uclamp values on behalf of an unprivileged app.
