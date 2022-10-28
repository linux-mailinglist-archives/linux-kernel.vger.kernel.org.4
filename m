Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4246112BD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiJ1N32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiJ1N3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:29:20 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC422792E6;
        Fri, 28 Oct 2022 06:29:19 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id c8so4026874qvn.10;
        Fri, 28 Oct 2022 06:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ewf1/0yS/MPVhCM+bumhxUWSJIhluAl1yOgoepsPDa4=;
        b=vq51oE0CjsKMLZlgeai7ShOdfS53y13/NgTUZZMTPJ7+bp86Om0jTXHgq5YC5qFAb/
         KaQTQ5tIPcEQtnbAgAGSVJs/CRfg1vikWn+psTDZenzPymU/X3R+0f4DLvfKpUnSoOYX
         PxPZSBKv+YzvUxiQ2ukVGvWRfsj+EpWkdM6HewN9Dl5a06coshTviaFgqi7q1G/8aVDX
         vi3OnEZrMaxWvDtzqXiTsenIUII3G2aWsW3sSYIpE7uAb/gTnt8UWjIotT8N0qZ2PGVK
         0HrGg/OgNS0i+EMQOQ3f9VhWx/+iiPiB62SOyFf6aEcjqgrhJLbSkUarq5sgJA5pD1GG
         6RgQ==
X-Gm-Message-State: ACrzQf0nO9uTmoFXd1+poUpxHNYksuW/5onZ2fEQxRyjsvSfiiwJe5eQ
        eBPV4ai2TRUCUSO/qi9jCS+YiZJT52alluvNAlY=
X-Google-Smtp-Source: AMsMyM69tjCqCgwdNnpekRVLWiO5RijjEAo0SO6mteLZEeWi6P7gklOz9rvsahUQ70s1DEaFcXaJMxjlrR1TlHlbLww=
X-Received: by 2002:ad4:596b:0:b0:4b1:ee66:1cb8 with SMTP id
 eq11-20020ad4596b000000b004b1ee661cb8mr45829729qvb.3.1666963758929; Fri, 28
 Oct 2022 06:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221003144914.160547-1-kajetan.puchalski@arm.com>
 <CAJZ5v0hoe=8nY9vR=+Bjvexrg+E6fcO-S=W+PDkfD=Li6Uy__g@mail.gmail.com>
 <Y0fymW5LOoIHstE2@e126311.manchester.arm.com> <CAAYoRsW+5xbW_Zd7Mtbo4VMi4RZFXRr7mf4NAU=Le7GhQzNJvg@mail.gmail.com>
 <c6e6d338-60e5-4401-1cf4-faaee3cc447f@arm.com>
In-Reply-To: <c6e6d338-60e5-4401-1cf4-faaee3cc447f@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 15:29:07 +0200
Message-ID: <CAJZ5v0iwr1rAFuxn3H0XEyr1wEjRtTXKXPo5ZzhBp8Fg2fonnw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/1] cpuidle: teo: Introduce optional util-awareness
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Doug Smythies <dsmythies@telus.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, yu.chen.surf@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
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

On Thu, Oct 27, 2022 at 9:56 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Doug,
>
> Thank you for your effort in testing these patches and different
> governors. We really appreciate that, since this helped us to
> better understand the platform that you are using. It is different
> to what we have and our workloads. That's why I have some comments.
>
> It would be hard to combine these two worlds and requirements.
> I have some concerns to the tests, the setup and the platform.
> I can see a reason why this patch has to prove the
> strengths on this platform and environment.
> Please see my comments below.
>
> On 10/13/22 23:12, Doug Smythies wrote:
> > Hi All,
> >
> > On Thu, Oct 13, 2022 at 4:12 AM Kajetan Puchalski
> > <kajetan.puchalski@arm.com> wrote:
> >> On Wed, Oct 12, 2022 at 08:50:39PM +0200, Rafael J. Wysocki wrote:
> >>> On Mon, Oct 3, 2022 at 4:50 PM Kajetan Puchalski
> >>> <kajetan.puchalski@arm.com> wrote:
> > ...
> >
> >> On the Intel & power usage angle you might have seen in the discussion,
> >> Doug sent me some interesting data privately. As far as I can tell the
> >> main issue there is that C0 on Intel doesn't actually do power saving so
> >> moving the state selection down to it is a pretty bad idea because C1
> >> could be very close in terms of latency and save much more power.
> >>
> >> A potential solution could be altering the v2 to only decrease the state
> >> selection by 1 if it's above 1, ie 2->1 but not 1->0. It's fine for us
> >> because arm systems with 2 states use the early exit path anyway. It'd
> >> just amount to changing this hunk:
> >>
> >> +       if (cpu_data->utilized && idx > 0 && !dev->states_usage[idx-1].disable)
> >> +               idx--;
> >>
> >> to:
> >>
> >> +       if (cpu_data->utilized && idx > 1 && !dev->states_usage[idx-1].disable)
> >> +               idx--;
> >>
> >> What would you think about that? Should make it much less intense for
> >> Intel systems.
> >
> > I tested the above, which you sent me as patch version v2-2.
> >
> > By default, my Intel i5-10600K has 4 idle states:
> >
> > $ grep . /sys/devices/system/cpu/cpu7/cpuidle/state*/name
> > /sys/devices/system/cpu/cpu7/cpuidle/state0/name:POLL
>
> This active polling state type worries me a bit. We don't have
> such on our platforms. Our shallowest idle state is really different.
> We don't have active polling and there is no need for such.

So as I said in a reply to Kajetan, the way to go is to avoid them
when you do this utilization-based optimization.

CPUIDLE_FLAG_POLLING is for that and it is used already in the code.

Moreover, as I said in the other message, IMO the utilization-based
optimization makes the most sense when the current candidate state is
state 1, so it may not make sense to do it on Intel systems at all.
