Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A276C6F81
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjCWRlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjCWRlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:41:02 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170B431BE4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:40:55 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id o44so11669335qvo.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1679593254;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Y3s4NslPbVa9CgDudDcI6zUApY+ckicM+Uc4hYlRjQ=;
        b=cWHGd6qzEtImZZbDg+a5Y/P1Pufk7JMjmoHHmJBJgBRYPFjwpwpfYsJYoofXWheD8X
         wuDyv5MhlDkRy3YGtJttk5O6dXI2K+Jmrp8nMbgT38dfi6jqqMxfS2zrNayXhkA1dwcq
         uqz1winULzQ0nPMv1drtNKMqTn4pO/WomyQjzlDT3PwZpcZtFLdvKDQRWWJQH3PBl7xF
         xRxjehD1Tn7YLs3IyChW+sU0IyfSUVc3Vn+GJuMnJe4sWgr9VQAHEJw5y3Eu5RczVR4T
         th3vZQAUvwnXKKFAmk7Ar/mnnViByqaUqhtBmNAcct5SzqF0IZxuQVjlqQGHLM4Z169a
         ElDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679593254;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Y3s4NslPbVa9CgDudDcI6zUApY+ckicM+Uc4hYlRjQ=;
        b=jgHSHGF610QrjnY8GHTWInzaJv8b4u5rJSpcjHI+8PqC2kJPMq3yLAr+xzPbnZhuon
         M/vn0j00UE46B5EhsuJt+IYSO868bqRSRCLuq5u/yLm2JzH7o/Jcvu+9G4jko49G2Fcg
         QNZYTWT1yid0ow3+6BkhYJdLtrq53zW/Zlv8jCIzCT3tjZwfW1G8/GC7KrFIlmbtMUbW
         UhEfNL8INCrAXAbm2Waksg5Se4jfZOGcRAmZjR3BUh19YpWQGnLGe/KmLT6YmoBELXmX
         RKlI4xj4Gqmy9UtLc/Copty5eeDBDay4s5GenScTv5pUgmhZGME7T46Ic2M9W1Q9O6DO
         mc6Q==
X-Gm-Message-State: AO0yUKUzZBTHpJoGuV2LLmn2BFvQC3YLYjTVc8PAhLDTit3LXAunNrhm
        RQFvdEWxiMyhDvgxtpDX3oW5ig==
X-Google-Smtp-Source: AK7set9uQ1A/DPH8rXQlRtbRSke56UvgQuKHexcXoNqcolHWiPutbxosYbvqXV9PD7bpmroxF9nH4A==
X-Received: by 2002:ad4:5bc8:0:b0:5ba:168d:d406 with SMTP id t8-20020ad45bc8000000b005ba168dd406mr12297580qvt.38.1679593253961;
        Thu, 23 Mar 2023 10:40:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:62db])
        by smtp.gmail.com with ESMTPSA id m9-20020a0cbf09000000b005dd8b9345eesm1551qvi.134.2023.03.23.10.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 10:40:53 -0700 (PDT)
Date:   Thu, 23 Mar 2023 13:40:52 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        brauner@kernel.org, chris@chrisdown.name
Subject: Re: [PATCH v2 3/3] sched/psi: allow unprivileged polling of N*2s
 period
Message-ID: <20230323174052.GG739026@cmpxchg.org>
References: <20230323103350.40569-1-cerasuolodomenico@gmail.com>
 <20230323103350.40569-4-cerasuolodomenico@gmail.com>
 <20230323150939.GA737760@cmpxchg.org>
 <CAJuCfpG7SeTd7ki90-SHqRGUF9kGYEEUynjQpwjb7E2-3pM54g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpG7SeTd7ki90-SHqRGUF9kGYEEUynjQpwjb7E2-3pM54g@mail.gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 09:43:16AM -0700, Suren Baghdasaryan wrote:
> On Thu, Mar 23, 2023 at 8:09 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Thu, Mar 23, 2023 at 11:33:50AM +0100, Domenico Cerasuolo wrote:
> > > @@ -151,6 +151,14 @@ struct psi_trigger {
> > >
> > >       /* Deferred event(s) from previous ratelimit window */
> > >       bool pending_event;
> > > +
> > > +     /* Used to differentiate destruction action*/
> > > +     enum psi_aggregators aggregator;
> > > +};
> > > +
> > > +struct trigger_info {
> > > +     struct list_head triggers;
> > > +     u32 nr_triggers[NR_PSI_STATES - 1];
> > >  };
> > >
> > >  struct psi_group {
> > > @@ -186,8 +194,7 @@ struct psi_group {
> > >       struct mutex trigger_lock;
> > >
> > >       /* Configured polling triggers */
> > > -     struct list_head triggers;
> > > -     u32 nr_triggers[NR_PSI_STATES - 1];
> > > +     struct trigger_info trig_info[NR_PSI_AGGREGATORS];
> > >       u32 poll_states;
> > >       u64 poll_min_period;
> >
> > Thanks for trying out this variant, but I think this is grouping up
> > unrelated things, and that makes the code more difficult to understand
> > and maintan.
> >
> > The *only* thing that's shared between those two is the
> > update_triggers() part. trig_info[PSI_AVGS] doesn't use trigger_lock.
> > It also doesn't use poll_task, poll_wait, poll_wakeup, poll_scheduled,
> > poll_min_period, polling_next_update and polling_until. All these
> > things are specific to the rt polling thread.
> >
> > The rename in the previous version is a bit churny, but it's justified
> > in order to keep unrelated things separate / make it obvious which
> > parts belong together, and who is reading and writing which fields.
> >
> > So my vote would be on the previous version.
> 
> Hmm. Ok, but then I would suggest keeping RT trigger naming as is and
> calling the new triggers based on averages as
> avg_triggers/avg_nr_triggers/etc. This would limit the churn and since
> we already have polling_total and avg_total, this naming would be
> appropriate IMO. If we want to be even stricter, we could rename the
> polling variables to poll_triggers/poll_nr_triggers/etc.  Some more
> churn but then the names are very distinct.

IIRC Domenico had that in an earlier internal version. That was still
confusing because both sets of members are used for polling, not just
the rt-thread bits. I suggested to rename them all to make it clear
which poll bits are for the rt thread and which ones are from the
aggregator thread.

IMO code clarity trumps churn avoidance here.
