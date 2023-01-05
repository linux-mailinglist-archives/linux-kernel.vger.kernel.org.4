Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9621165E899
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjAEKEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjAEKDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:03:46 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F776D6E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:03:43 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id jo4so88943368ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAx4sB8dmTRbcnxQDj1pOnj4ZyZCrQxhPS8VSinr3uw=;
        b=ZT0sRSyyIJdlzxV0+bCYBKAk6pxMF5n0JRPazf8QA+sgb+iBYpyhPS0Io9YuLjMSlf
         3qctE9rfcCIg598Crt15Jo4JO86mTIXaLGyu2PEa4ORWMGwYOmHrbSa11HkgJKNLVLR4
         5KAh6H+x82PTreIIwxK7V3m1dqKa39Ay3+lhX/uwFkd8/uXpqdSsqB82zdHYILLc1w+H
         ivEc37Mv5T/LupEahS/6yaxnT9/g3Ov0X7n0QB/HLO5kp3/1Rgw/Q08H6R5V+7Zn3Bjv
         81G0MU2HZoiHyJw08HrIILLZO/vG2lIsG4XYJS3IA81osd3778tz0K6JcTJZ0qNfp1pK
         JlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAx4sB8dmTRbcnxQDj1pOnj4ZyZCrQxhPS8VSinr3uw=;
        b=SHEbR70MUHf1HuT6w+vShgLuvcRYCqAc7WZ3CpsRjxs9uxDcdvWDyBA4wA0CteWJqY
         NluWSzuzHGU0szzQLNdXG9AIhb4ni6viRtps4dHEGQfYmPtgh53+2OVH2xkGpE8PXl0l
         plWfB/cHAof4VUidXyUyUs3Rrts95PE0dLtCfsuDnT6QJwQylSqWGtXZAmyiXw9fFVxj
         nojkE8OoSj4e5uDJe4HIz52SoIXyHHEMcTfa9zOvIpwKBJHShi/Q1rjxsfKwJzHSxeZi
         Xpci5EIM4qmc6jD0l78t7UDWNLUOrgI0xJgKTChEf2/6f6Sehyt+35cbJ4qH7Jqtc6/i
         1GhQ==
X-Gm-Message-State: AFqh2krwhhe4Y5LBcyW7QB61jffITs84Bb8LtJIzq3xN2nKGV608qcOf
        QU+MK8TU3Y3+8Y2uWQ/c110=
X-Google-Smtp-Source: AMrXdXsGvLivzR5oNfqPEbJnu/3d9CJjI/HC1D0T15yjwj0xlBBbbXqr40u8ODXGOakRFwMIn8qCCQ==
X-Received: by 2002:a17:907:a4c5:b0:84c:f9b0:b54a with SMTP id vq5-20020a170907a4c500b0084cf9b0b54amr3638243ejc.58.1672913022071;
        Thu, 05 Jan 2023 02:03:42 -0800 (PST)
Received: from gmail.com (1F2EF380.nat.pool.telekom.hu. [31.46.243.128])
        by smtp.gmail.com with ESMTPSA id r4-20020a17090638c400b007c16f120aacsm16191561ejd.121.2023.01.05.02.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 02:03:41 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 5 Jan 2023 11:03:37 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] locking/qspinlock: Optimize pending state waiting for
 unlock
Message-ID: <Y7agecsIPC0r/OXB@gmail.com>
References: <20221224120545.262989-1-guoren@kernel.org>
 <08ce1ab6-4678-74ce-43cc-2d3f04d1525d@redhat.com>
 <CAJF2gTS52jBm7_3c=9i1uPjmV90=42xs4dOs6woA4NnHf4RHgQ@mail.gmail.com>
 <b01060ba-6069-d33e-5151-22a7d9577f13@redhat.com>
 <e30f671d-8e74-d5b9-cdba-472d7297f257@redhat.com>
 <CAJF2gTTkLY+mUoG0oqw0mmJH0hK5bXYvrmYcLL1-zwNbzOb9TQ@mail.gmail.com>
 <Y7XfYPnQhLTcNZSh@gmail.com>
 <CAJF2gTT4yaH1i7zmKNwzt8OK1frFvre09wwNGABBo_3gC0pjBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTT4yaH1i7zmKNwzt8OK1frFvre09wwNGABBo_3gC0pjBw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Guo Ren <guoren@kernel.org> wrote:

> On Thu, Jan 5, 2023 at 4:19 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Guo Ren <guoren@kernel.org> wrote:
> >
> > > > >> The situation is the SMT scenarios in the same core. Not an entering
> > > > >> low-power state situation. Of course, the granularity between cores is
> > > > >> "cacheline", but the granularity between SMT hw threads of the same
> > > > >> core could be "byte" which internal LSU handles. For example, when a
> > > > >> hw-thread yields the resources of the core to other hw-threads, this
> > > > >> patch could help the hw-thread stay in the sleep state and prevent it
> > > > >> from being woken up by other hw-threads xchg_tail.
> > > > >>
> > > > >> Finally, from the software semantic view, does the patch make it more
> > > > >> accurate? (We don't care about the tail here.)
> > > > >
> > > > > Thanks for the clarification.
> > > > >
> > > > > I am not arguing for the simplification part. I just want to clarify
> > > > > my limited understanding of how the CPU hardware are actually dealing
> > > > > with these conditions.
> > > > >
> > > > > With that, I am fine with this patch. It would be nice if you can
> > > > > elaborate a bit more in your commit log.
> > > > >
> > > > > Acked-by: Waiman Long <longman@redhat.com>
> > > > >
> > > > BTW, have you actually observe any performance improvement with this patch?
> > > Not yet. I'm researching how the hardware could satisfy qspinlock
> > > better. Here are three points I concluded:
> > >  1. Atomic forward progress guarantee: Prevent unnecessary LL/SC
> > > retry, which may cause expensive bus transactions when crossing the
> > > NUMA nodes.
> > >  2. Sub-word atomic primitive: Enable freedom from interference
> > > between locked, pending, and tail.
> > >  3. Load-cond primitive: Prevent processor from wasting loop
> > > operations for detection.
> >
> > As to this patch, please send a -v2 version of this patch that has this
> > discussion & explanation included in the changelog, as requested by Waiman.
> Done
> 
> https://lore.kernel.org/lkml/20230105021952.3090070-1-guoren@kernel.org/

Applied to tip:locking/core for a v6.3 merge, thanks!

	Ingo
