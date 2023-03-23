Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAFE6C6E00
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCWQo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjCWQo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:44:27 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3627AAA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:43:28 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5419d4c340aso404806427b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679589807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldo2RokR4wInMOWHcOTdim2u8OCMcv2/RvElM6MdqRk=;
        b=D/67LzhTjCYQ0oeLm/kc9K60110rOyD3KPQjh87wjjqeRK8xINyVqc19r2/PBzi350
         kjENaPDKvQ37bWU8cd2fX2Is13oQHfVzdp4WNMClEWR2MfCVDGeUhKuYgPoWJkefoqEx
         01Mlk9fcipqI+lRXf2eUH8pP5tHMN7s6t7h4t0EZa2omquOMxk8QG7dGo5kE9D05u3Mp
         t1dDo22BVTOFxTJyNSQHUfqV/wFgSMXu/ZnqlreuL+c6EhOLnjXYjfptdJ7jATHPqUGn
         e9XYlLepIN28i+qeMdFHPcKrKziP8q3rNlO/g6gr7wugRLi38ihLsI9qLzDErsj9LATe
         NUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679589807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldo2RokR4wInMOWHcOTdim2u8OCMcv2/RvElM6MdqRk=;
        b=ByLGoRI5uk1GT+4OqMh/DayHbliehsDlxiFs7+sYHhhXBwg4j4YpdaEX0XbraiMLYT
         VxQq2W7p4F3vMU1G9HX62jytrzMsjlA2X9dq4eeFrB+tb4owmVVJd1QR93gGF4Jqo4vd
         hmmzTLfRPqkpdrZDq4wZQYF5LE22UfbJ1p7v4/vbA43uyop06tgMq9rDfR0DKS0XFr34
         QKoIOkLmFRL0C7sngVIMxGuadRsebY+qcVSMaHa0YRnlEn1LhB2WoaRKQt2ilkCDh/5G
         KhFFQdGB3PbPSn7DqA1r/cKnI65QiRucgzVcHQNewpP4T/brCB6JAgBnNetDe0Vg0u18
         IVJg==
X-Gm-Message-State: AAQBX9e33XVB0HeRaf5NlPdQmY72CllVFhpr+VVv4vEVLnWwsxYSLAV1
        DhG56p0ckZXp7wEu3AOD9wXjbwPAMTbFpC+1WhiAHw==
X-Google-Smtp-Source: AKy350YN36CelNOZUo16Zb1WldpiNA/ELOeLHcpRSHjj/5mswGQyl94kxhFDhi234MrMZkzpC1XobQobhg5WJITbVPY=
X-Received: by 2002:a81:b2c7:0:b0:545:5b21:c667 with SMTP id
 q190-20020a81b2c7000000b005455b21c667mr2006131ywh.1.1679589807456; Thu, 23
 Mar 2023 09:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230323103350.40569-1-cerasuolodomenico@gmail.com>
 <20230323103350.40569-4-cerasuolodomenico@gmail.com> <20230323150939.GA737760@cmpxchg.org>
In-Reply-To: <20230323150939.GA737760@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 23 Mar 2023 09:43:16 -0700
Message-ID: <CAJuCfpG7SeTd7ki90-SHqRGUF9kGYEEUynjQpwjb7E2-3pM54g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] sched/psi: allow unprivileged polling of N*2s period
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        brauner@kernel.org, chris@chrisdown.name
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

On Thu, Mar 23, 2023 at 8:09=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Mar 23, 2023 at 11:33:50AM +0100, Domenico Cerasuolo wrote:
> > @@ -151,6 +151,14 @@ struct psi_trigger {
> >
> >       /* Deferred event(s) from previous ratelimit window */
> >       bool pending_event;
> > +
> > +     /* Used to differentiate destruction action*/
> > +     enum psi_aggregators aggregator;
> > +};
> > +
> > +struct trigger_info {
> > +     struct list_head triggers;
> > +     u32 nr_triggers[NR_PSI_STATES - 1];
> >  };
> >
> >  struct psi_group {
> > @@ -186,8 +194,7 @@ struct psi_group {
> >       struct mutex trigger_lock;
> >
> >       /* Configured polling triggers */
> > -     struct list_head triggers;
> > -     u32 nr_triggers[NR_PSI_STATES - 1];
> > +     struct trigger_info trig_info[NR_PSI_AGGREGATORS];
> >       u32 poll_states;
> >       u64 poll_min_period;
>
> Thanks for trying out this variant, but I think this is grouping up
> unrelated things, and that makes the code more difficult to understand
> and maintan.
>
> The *only* thing that's shared between those two is the
> update_triggers() part. trig_info[PSI_AVGS] doesn't use trigger_lock.
> It also doesn't use poll_task, poll_wait, poll_wakeup, poll_scheduled,
> poll_min_period, polling_next_update and polling_until. All these
> things are specific to the rt polling thread.
>
> The rename in the previous version is a bit churny, but it's justified
> in order to keep unrelated things separate / make it obvious which
> parts belong together, and who is reading and writing which fields.
>
> So my vote would be on the previous version.

Hmm. Ok, but then I would suggest keeping RT trigger naming as is and
calling the new triggers based on averages as
avg_triggers/avg_nr_triggers/etc. This would limit the churn and since
we already have polling_total and avg_total, this naming would be
appropriate IMO. If we want to be even stricter, we could rename the
polling variables to poll_triggers/poll_nr_triggers/etc.  Some more
churn but then the names are very distinct.
