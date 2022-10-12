Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CF25FCAF9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJLSvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiJLSu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:50:57 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73B1F88D1;
        Wed, 12 Oct 2022 11:50:52 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id g11so6137147qts.1;
        Wed, 12 Oct 2022 11:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGZHFunaDCc4OmApV98nqeiEP+JU02Ta3xWx4ULymgA=;
        b=fnQbzrzhi5d+kND+Yz1eGXTAaDVNTvq1VsupKGLqFCBLT07S3F6wnIsAdxCcO971qX
         VJKkDeGrzyd3x2E6v+NadhcdaEcBEpdFgu55UvCCvgHXsf3wjWRqwh1jKH/ojRuwNQkM
         zrpd46cmKgweC6J2mhseMDXRQst+PXTBnyfkx0s48GSO0wKZxDe+5YnsLu2c9Rh7iHkM
         hQZ3ya6v1STxkkW8UPDni0YqNAqeAoMABTw83Ojq0Qzfx04KhK4fC/avhLDzvZdORYus
         eWoepyGfYSQC0z05IfJuL+YRDzzCLiJ0F4x8r4mZK3Z8euXPqdw80BMRyNEjk0tPeOny
         a/sQ==
X-Gm-Message-State: ACrzQf1COa9UGftuCLpThyofBKmxy6gVtO1Hdyom3yBKRXyegyDV8aJ6
        3Kh2itK4SWAekWirbjlUodsqCveHtYavnEWwEh4=
X-Google-Smtp-Source: AMsMyM7JTxLnzULH6yBwgyKywXyHU+882Dhvq06cPGoYXBylZ7IQtwakuvguFyvm8dQXs5WngC6brB8ahrAHTtxzkaI=
X-Received: by 2002:a05:622a:413:b0:39c:c23f:2388 with SMTP id
 n19-20020a05622a041300b0039cc23f2388mr3103964qtx.605.1665600651111; Wed, 12
 Oct 2022 11:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221003144914.160547-1-kajetan.puchalski@arm.com>
In-Reply-To: <20221003144914.160547-1-kajetan.puchalski@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Oct 2022 20:50:39 +0200
Message-ID: <CAJZ5v0hoe=8nY9vR=+Bjvexrg+E6fcO-S=W+PDkfD=Li6Uy__g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/1] cpuidle: teo: Introduce optional util-awareness
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 3, 2022 at 4:50 PM Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
>
> Hi,
>
> At the moment, all the available idle governors operate mainly based on their own past performance

Not true, at least for the menu and teo governors that use the
information on the distribution of CPU wakeups that is available to
them and try to predict the next idle duration with the help of it.
This has a little to do with their performance.

> without taking into account any scheduling information. Especially on interactive systems, this
> results in them frequently selecting a deeper idle state and then waking up before its target
> residency is hit, thus leading to increased wakeup latency and lower performance with no power
> saving. For 'menu' while web browsing on Android for instance, those types of wakeups ('too deep')
> account for over 24% of all wakeups.

How is this measured?

> At the same time, on some platforms C0 can be power efficient enough to warrant wanting to prefer
> it over C1.

Well, energy-efficiency is relative, so strictly speaking it is
invalid to say "power efficient enough".

Also, as far as idle CPUs are concerned, we are talking about the
situation in which no useful work is done at all, so the state drawing
less power is always more energy-efficient than the one drawing more
power.

You may argue that predicting idle durations that are too long too
often leads to both excessive task wakeup latency and excessive energy
usage at the same time, but this may very well mean that the target
residency value for C1 is too low.

> Sleeps that happened in C0 while they could have used C1 ('too shallow') only save
> less power than they otherwise could have. Too deep sleeps, on the other hand, harm performance
> and nullify the potential power saving from using C1 in the first place. While taking this into
> account, it is clear that on balance it is preferable for an idle governor to have more too shallow
> sleeps instead of more too deep sleeps on those kinds of platforms.

True.

> Currently the best available governor under this metric is TEO which on average results in less than
> half the percentage of too deep sleeps compared to 'menu', getting much better wakeup latencies and
> increased performance in the process.

Well, good to hear that, but some numbers in support of that claim
would be nice to have too.

> This proposed optional extension to TEO would specifically tune it for minimising too deep
> sleeps and minimising latency to achieve better performance. To this end, before selecting the next
> idle state it uses the avg_util signal of a CPU's runqueue in order to determine to what extent the
> CPU is being utilized.

Which has no bearing on what the CPU idle time governors have to do
which is (1) to predict the next idle duration as precisely as
reasonably possible and (2) to minimise the cost in terms of task
wakeup latencies associated with using deep idle states.

The avg_util value tells us nothing about how much the CPU is going to
be idle this time and it also tells us nothing about the
latency-sensitivity of the workload.

Yes, it tells us how much idle time there was on the given CPU in the
past, on the average, but there is zero information about the
distribution of that idle time in it.

So in the first place please tell me why it fundamentally makes sense
to use avg_util in CPU idle time management at all.
