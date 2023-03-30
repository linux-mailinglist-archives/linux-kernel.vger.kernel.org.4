Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4196CFF3B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjC3IyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjC3IyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:54:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C417ABC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:54:16 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t10so73465058edd.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680166455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oX0gvaOyZOPHIQS/lmv/Ti0/aOErAsGb3zG7Z5OZO2o=;
        b=WXf5DP/SnSUFzsV29yQgNbT+UqQSF6+RPsReWZbLSzwsLGnGrCZ7mGJ+Kg/l3LT/Sa
         YlwaRxHHQ4V8lQ2ngT1wVPQMpGUNmakTZ5x8ceTg9l7uyxQYfBn3BhwcdUe8BUgFVqDb
         bVOJOTc+pwvM4OZmgIb2vZRKpL47bO6euuKgv9L3ClENMySR3LjJxL78id+QyVP+9Fvz
         FdJKYDAKkbtWpALArnt1W7TxIvNZmYl4ltnlCbMCIDvEu2F6DuajYEYUnNpe7RwlEMuh
         u94GrNUK8lYFRnnkcYCsxCIMmfShfaZNaHwS6ESlMLL2PYDi7KIj59BTIU269tYBDwan
         IPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680166455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oX0gvaOyZOPHIQS/lmv/Ti0/aOErAsGb3zG7Z5OZO2o=;
        b=16iSytZC1Zltm8MTgvABi3jkh9PB4yUR3IxcxhfSk+rx1ipnl8wHcIffRnhH058DD3
         qeq1ufbCD8hVxrPoDalpZxeKX0mnffY5VxGGLXRDtewlZPZbLc0WO6i8vUi0D6LuAvqB
         gsJW74tuxGkhFPfLxTcjUVN4/sxY/4oZlQRtoBm4h/qxN1BY48d1eK5c65MEFbkxbNhJ
         5rzQ5yKULJu2H5imGngOMRWcQ3j9IE9i18ki7ljJVKd0g9ZrU+ZcQJwQgypSJyTBCPzE
         3kjVGa8NeFK5jC0mCtexzA79cRe7f4PWS7oZYEqQDeSelMz9bjgnCcZWKor8TlpvuRQP
         U4Pw==
X-Gm-Message-State: AAQBX9emyqtrPvmWSo0opLiNoVM5hS31OwtDa5Glug7z0ar92H5pR25J
        5f3Y6U5qHRVSfyvoE3+EeaGECcyZdEWdC/drDRhArQ==
X-Google-Smtp-Source: AKy350btdGZhlD0t6aAdY2/xVPLOK3+T5zqWbUhN/U7pPLdepDUEnYUTLCVTQkMwL0EVkjpbPAKrleuZnpRzmCBaJRE=
X-Received: by 2002:a50:d756:0:b0:4fc:e5c:902 with SMTP id i22-20020a50d756000000b004fc0e5c0902mr11090294edj.8.1680166454625;
 Thu, 30 Mar 2023 01:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230328221644.803272-5-yosryahmed@google.com>
 <ZCQfZJFufkJ10o01@dhcp22.suse.cz> <CAJD7tkb-UpKm2QbjYzB=B=oGk6Hyj9cbUviZUPC+7VsvBecH7g@mail.gmail.com>
 <20230329192059.2nlme5ubshzdbpg6@google.com> <ZCU1Bp+5bKNJzWIu@dhcp22.suse.cz>
 <CAJD7tka0CmRvcvB0k8DZuid1vC9OK_mFriHHbXNTUkVE7OjaTA@mail.gmail.com>
 <ZCU+8lSi+e4WgT3F@dhcp22.suse.cz> <CAJD7tkaKd9Bcb2-e83Q-kzF7G+crr1U+7uqUPBARXWq-LpyKvw@mail.gmail.com>
 <ZCVFA78lDj2/Uy0C@dhcp22.suse.cz> <CAJD7tkbjmBaXghQ+14Hy28r2LoWSim+LEjOPxaamYeA_kr2uVw@mail.gmail.com>
 <ZCVKqN2nDkkQFvO0@dhcp22.suse.cz>
In-Reply-To: <ZCVKqN2nDkkQFvO0@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 30 Mar 2023 01:53:38 -0700
Message-ID: <CAJD7tkYEOVRcXs-Ag3mWn69EwE4rjFt9j5MAcTGCNE8BuhTd+A@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cgroup: rstat: add WARN_ON_ONCE() if flushing
 outside task context
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 1:39=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 30-03-23 01:19:29, Yosry Ahmed wrote:
> > On Thu, Mar 30, 2023 at 1:15=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Thu 30-03-23 01:06:26, Yosry Ahmed wrote:
> > > [...]
> > > > If we achieve that, do you think it makes sense to add
> > > > WARN_ON_ONCE(irqs_disabled()) instead to prevent future users from
> > > > flushing while disabling irqs or in irq context?
> > >
> > > WARN_ON (similar to BUG_ON) will not prevent anybody from doing bad
> > > things. We already have means to shout about sleepable code being
> > > invoked from an atomic context and there is no reason to duplicate th=
at.
> > > As I've said earlier WARN_ON might panic the system in some
> > > configurations (and yes they are used also in production systems - do
> > > not ask me why...). So please be careful about that and use that only
> > > when something really bad (yet recoverable) is going on.
> >
> > Thanks for the information (I was about to ask why about production
> > systems, but okay..). I will avoid WARN_ON completely. For the
> > purposes of this series I will drop this patch anyway.
>
> Thanks! People do strange things sometimes...
>
> > Any idea how to shout about "hey this may take too long, why are you
> > doing it with irqs disabled?!"?
>
> Well we have a hard lockup detector. It hits at a much higher stall by
> default but if you care about IRQ latencies in general then you likely
> want to lower. Another thing would be IRQ tracing. In any case this code
> path shouldn't be any special. Sure it can take long on large systems
> but I bet there are more of those.

We did see hard lockups in extreme cases, and we do have setups with
"nmi_watchdog=3Dpanic" that will panic when this happens, so we would
rather catch the code paths that can lead to that before it actually
happens.

Maybe we can add a primitive like might_sleep() for this, just food for tho=
ught.

> --
> Michal Hocko
> SUSE Labs
