Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30CD61156E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJ1PFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJ1PFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:05:03 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40592528F;
        Fri, 28 Oct 2022 08:05:00 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id d13so3586469qko.5;
        Fri, 28 Oct 2022 08:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qdhDbctiiApnLTLWGH9oZuXOT2uma5fefrG214/GCHQ=;
        b=RD0Nf+7mtjbCdAD9KfJHF6CDvdZB9t0jiRvPUiKPohvTXELkekNKl5PyGKUtg1fJSL
         RewWZWu/RsZwXIVYnx+XsvIexC7WpwdQbe41sgBC4B2G8Y9WkzgNThwwtFQs/xpsymxu
         rH/18bNEkqOTtUC/xeXmyt/Lzf2VW4eVwAR4Is84kA85OCJPJA3P1F1d/bdC63Q2Jm0V
         Np6c9PlRD8OppKrqmg6Nkv67prJegttVIomsmX0g3AzBdGz6+HHxzg2E3dlWQmL4mIxS
         EfjXtzVIhzQbkJEEt0MAanZT3NOxiJ2cs+Id3Eg86JYTuHktRiw3eA3yv0ZsSVBmMhm6
         +4MQ==
X-Gm-Message-State: ACrzQf3B+mVy7XxwuDQjTn7kppnx7u3JvohxK7Wxs6yUXexNeGt8ORFk
        x4sH4YkhjZ3xL8SpOXOvDIQqFbtbUmpOwDqQQb0=
X-Google-Smtp-Source: AMsMyM4W57Pn2fvC+bC7MICO3T3rJ1mUxOLVoofWyqWewWMRTxv1Y55RZ7woEiKXQJbfEV5Kc9otoblu8ZD18d+eBfE=
X-Received: by 2002:a05:620a:4547:b0:6ee:dc16:d67a with SMTP id
 u7-20020a05620a454700b006eedc16d67amr39255160qkp.23.1666969499908; Fri, 28
 Oct 2022 08:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221003144914.160547-1-kajetan.puchalski@arm.com>
 <CAJZ5v0hoe=8nY9vR=+Bjvexrg+E6fcO-S=W+PDkfD=Li6Uy__g@mail.gmail.com>
 <Y0fymW5LOoIHstE2@e126311.manchester.arm.com> <CAJZ5v0gvAtpzdQo0Tj13ZGFcop8fdNht7e_Nc_UNYCgbU1zZLA@mail.gmail.com>
 <Y1vum4BECMf2BXQW@e126311.manchester.arm.com>
In-Reply-To: <Y1vum4BECMf2BXQW@e126311.manchester.arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 17:04:48 +0200
Message-ID: <CAJZ5v0hZbw18BuG64046DiG2_dWOFk9gcg0bD+X3rQknwp0xsA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/1] cpuidle: teo: Introduce optional util-awareness
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org,
        lukasz.luba@arm.com, Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 5:01 PM Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
>
> On Fri, Oct 28, 2022 at 03:12:43PM +0200, Rafael J. Wysocki wrote:
>
> > > The result being that this util-aware TEO variant while using much less
> > > C1 and decreasing the percentage of too deep sleeps from ~24% to ~3% in
> > > PCMark Web Browsing also uses almost 2% less power. Clearly the power is
> > > being wasted on not hitting C1 residency over and over.
> >
> > Hmm.  The PCMark Web Browsing table in your cover letter doesn't indicate that.
> >
> > The "gmean power usage" there for "teo + util-aware" is 205, whereas
> > for "teo" alone it is 187.8.  This is still arguably balanced by the
> > latency difference (~100 us vs ~185 us, respectively), but this looks
> > like trading energy for performance.
>
> In this case yes, I meant 2% less compared to menu but you're right of
> course.
>
> [...]
>
> > Definitely it should not be changed if the previous state is a polling
> > one which can be checked right away.  That would take care of the
> > "Intel case" automatically.
>
> Makes sense, I already used the polling flag to implement this in this other
> governor I mentioned.
>
> >
> > > Should make it much less intense for Intel systems.
> >
> > So I think that this adjustment only makes sense if the current
> > candidate state is state 1 and state 0 is not polling.  In the other
> > cases the cost of missing an opportunity to save energy would be too
> > high for the observed performance gain.
>
> Interesting, but only applying it to C1 and only when C0 isn't polling would
> make it effectively not do anything on Intel systems, right?

Indeed.

> From what I've seen on Doug's plots even C1 is hardly ever used on his platform, most
> sleeps end up in the deepest possible state.

That depends a lot on the workload.  There are workloads in which C1
is mostly used and the deeper idle states aren't.

> Checking for the polling flag is a good idea regardless so I can send a
> v3 with that. If you'd like me to also restrict the entire mechanism to
> only working on C1 as you suggested then I'm okay with including that in
> the v3 as well. What do you think?

It would be good to do that and see if there are any significant
differences in the results.

> Thanks a lot for all your time & input,

No problem at all.
