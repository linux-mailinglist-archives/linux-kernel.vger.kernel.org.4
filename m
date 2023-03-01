Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9606A64F7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjCABtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCABtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:49:31 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5882DEB48
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 17:49:30 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-536cd8f6034so326266867b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 17:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677635369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAu0VY4pG5lMmayDlpyajBcn4svB3LfzCeO1dyYvFcM=;
        b=Ab6GA6qPithzXQRnd8yinlWyVvOV9spWEWMRYdNDQgxJvdgJqykgfhy8Jai7ztaQ09
         HDf+2cmdKeONrf+4KpcPfHOxWmp4wmYJ3BwxrEV6oGtwgZgolD0nLnnjScV6w+3MEblI
         8AYNpMXJoeWoJqmlZZw8kF+3SWNcz3QOQpprZDvNy3AVOyyyRxlTFFpuT2voN57o5wwi
         KJvq/55aKxYW9gkwaXLVYKJslTRPL9GBds9yNmAWrQBdtAHSQS+RXIsNOhQDg9n+yvsC
         vo9xO4z/bk6rpniBqxIc+vfp0SY1kMAMk3ZU69uQL0zvnxOYF1Cw+Kc+v8/qPjl3hyRB
         sCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677635369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAu0VY4pG5lMmayDlpyajBcn4svB3LfzCeO1dyYvFcM=;
        b=eapRqM+oyBgNXVp5hIPrtoYfO5dK/D5ZMeWnmi8nazqEzW8sL2WbVB9L4agrAYwQaj
         Nby0Q1N8jWs35WZFKM4FH5/Ka8Mc5k71F5q4tH3m1vaiBtd509cYMEpzFS6VY3htmtkV
         lN/N/eZu5jX+a5t1d4dN8D7P3DFvM/6gnfSQze6IRgts22jSm+2QRNnjM3BLZtCYJk3f
         waFVsQvJNCa/Xra6KAcWwI+/DVQKzLR7uRJloWvE/UdVOy8jMCs5eQfnKEumO1qzz7pb
         QtWHqW7OdzZZM6l0KET3zJt/bJWheTytFYTpl1lXGzA2WlA5EeoPGKqs40dKIHXD0+p9
         +csw==
X-Gm-Message-State: AO0yUKWsgCg62SgohOY0WgcsyXqAXNKTS9X0lBA32r2Eq0z/eGi5FEgJ
        XrmY07tws8rqkuMNMw7W/UG+0eMSwe56gyFE1FLqug==
X-Google-Smtp-Source: AK7set+dFJSx78dk4VGv7wMamuwmK+ZqCmseIbFZi0QMwuE3BCrIawoUa/thhs72KuS9XQADzu8byCOGIewo885wKNU=
X-Received: by 2002:a25:9704:0:b0:a30:38fb:a2e4 with SMTP id
 d4-20020a259704000000b00a3038fba2e4mr2102666ybo.6.1677635369232; Tue, 28 Feb
 2023 17:49:29 -0800 (PST)
MIME-Version: 1.0
References: <15cd8816-b474-0535-d854-41982d3bbe5c@quicinc.com>
 <CAJuCfpHihLgHCcsAqMJ_o2u7Ux9B5HFGsV2y_L2_5GXYAGYLnw@mail.gmail.com>
 <82406da2-799e-f0b4-bce0-7d47486030d4@quicinc.com> <CAJuCfpHrhO7_fMwNuu2hdQob=MPjZTW8eaJpNhEhPmDMqz2qTA@mail.gmail.com>
 <Y/ix53x8i/ViuBXf@dhcp22.suse.cz> <CAJuCfpG1c5v6qOotPV6t-o1T1p7EbOLs90eFnoEBjts+gafovA@mail.gmail.com>
 <Y/yxSqhpQh9yR7L4@dhcp22.suse.cz> <CAJuCfpHXwbtjdhH_K9r28-LUYtzC6+NaZ+RrKCtiNBk8PfXhLw@mail.gmail.com>
 <Y/0ASztGOwfM6bNK@dhcp22.suse.cz> <CAJuCfpHYMR6O_uJvaeq1f+ZvgW9oN6zTRG=UvTXyLJLSFOV3jw@mail.gmail.com>
 <Y/4GvIMtjVoEozWE@dhcp22.suse.cz> <CAJuCfpEn-W5ffO7sEJPpu3TXeqK-XE1+TTVNnWcTcDBuoNUhGA@mail.gmail.com>
In-Reply-To: <CAJuCfpEn-W5ffO7sEJPpu3TXeqK-XE1+TTVNnWcTcDBuoNUhGA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 28 Feb 2023 17:49:18 -0800
Message-ID: <CAJuCfpE604=5QtPBFFhhgNf43iXJvobE3uvaN_yFFHS-n4fKZw@mail.gmail.com>
Subject: Re: [PATCH] psi: reduce min window size to 50ms
To:     Michal Hocko <mhocko@suse.com>
Cc:     Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        mark.rutland@arm.com, will@kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Patrick Daly <quic_pdaly@quicinc.com>, johunt@akamai.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 10:18=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Tue, Feb 28, 2023 at 5:50 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 27-02-23 11:50:48, Suren Baghdasaryan wrote:
> > > On Mon, Feb 27, 2023 at 11:11 AM Michal Hocko <mhocko@suse.com> wrote=
:
> > > >
> > > > On Mon 27-02-23 09:49:59, Suren Baghdasaryan wrote:
> > > > > On Mon, Feb 27, 2023 at 5:34 AM Michal Hocko <mhocko@suse.com> wr=
ote:
> > > > > >
> > > > > > On Fri 24-02-23 13:07:57, Suren Baghdasaryan wrote:
> > > > > > > On Fri, Feb 24, 2023 at 4:47 AM Michal Hocko <mhocko@suse.com=
> wrote:
> > > > [...]
> > > > > > > > Btw. it seems that there is is only a limit on a single tri=
gger per fd
> > > > > > > > but no limits per user so it doesn't sound too hard to end =
up with too
> > > > > > > > much polling even with a larger timeouts. To me it seems li=
ke we need to
> > > > > > > > contain the polling thread to be bound by the cpu controlle=
r.
> > > > > > >
> > > > > > > Hmm. We have one "psimon" thread per cgroup (+1 system-level =
one) and
> > > > > > > poll_min_period for each thread is chosen as the min() of pol=
ling
> > > > > > > periods between triggers created in that group. So, a bad tri=
gger that
> > > > > > > causes overly aggressive polling and polling thread being thr=
ottled,
> > > > > > > might affect other triggers in that cgroup.
> > > > > >
> > > > > > Yes, and why that would be a problem?
> > > > >
> > > > > If unprivileged processes are allowed to add new triggers then a
> > > > > malicious process can add a bad trigger and affect other legit
> > > > > processes. That sounds like a problem to me.
> > > >
> > > > Hmm, I am not sure we are on the same page. My argument was that th=
e
> > > > monitoring kernel thread should be bound by the same cpu controller=
 so
> > > > even if it was excessive it would be bound to the cgroup constrains=
.
> > >
> > > Right. But if cgroup constraints are violated then the psimon thread'=
s
> > > activity will be impacted by throttling. In such cases won't that
> > > affect other "good" triggers served by that thread even if they are
> > > using higher polling periods?
> >
> > That is no different from any other part of the workload running within
> > the same cpu bound cgroup running overboard with the cpu consumption. I
> > do not see why psimon or anything else should be any different.
> >
> > Actually the only difference here is that the psi monitoring is
> > outsourced to a kernel thread which is running ourside of any constrain=
s.
> > I am not sure where do we stand with kernel thread cpu cgroup accountin=
g
> > and I suspect this is not a trivial thing to do ATM. Hence longer term
> > plan.
>
> Yeah, that sounds right.
> In the meantime I think the prudent thing to do is to add
> CAP_SYS_RESOURCE check for cgroup interface for consistency with
> system-wide one. After that we can change the min period to be
> anything more than 0 and let userspace privileged services implement
> policies to limit trigger cpu consumption (might be via cpu
> controller, limiting the number of triggers/their periods, etc).
> Sudarshan, I'll post the CAP_SYS_RESOURCE change shortly and you can
> follow up with the change to the min trigger period.

Patch to require CAP_SYS_RESOURCE for writing per-cgroup psi files is
posted at https://lore.kernel.org/all/20230301014651.1370939-1-surenb@googl=
e.com/

> Thanks for the input folks!
>
> > --
> > Michal Hocko
> > SUSE Labs
