Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54ED964872A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiLIRCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiLIRCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:02:17 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726767D08A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:02:16 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 1so7986418lfz.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=daikn9VroNivl1YE1yC9cN5gUExcOR7+xVWyWD74Yv8=;
        b=WYraxe+URQxRPVJ0/YGdVKJa+sGrtCkkuC963j7whwGMMFRt6cXQ2OeWkQZc5Kc+0u
         Sq3WkOHg/7X93qG5OH44XDvByNqGTSaJykpqqBFnVkvYGSaeLtw2K1Wxp96uB9qVrusN
         W6yOy9oKfgxkLOlKiShhFlA7ixSJSBmMzWAAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=daikn9VroNivl1YE1yC9cN5gUExcOR7+xVWyWD74Yv8=;
        b=RE1zeebrtH7IVIp1tPF4K+c34l374tCJ+v2jppI0UgwETfvvTPH2QHcizr//awfczk
         YQw1CaUhKwnVcwOrHrB8oDe2G1weQCCqALFQoP/Q36MdOrVxHmafKpo8Vtr/OHTV57bd
         S1oJyA5a6IuuKPjv3Hw0uYtjmCZw7wcZdbsvN/qCTcK26imvsSa/uu4u0kQdYNKX9lq2
         wjsAjfVLcaaeNEo/2dS4ounf0l8WKzOijcZWIi/4Vu9WkDx7Zlem7ve1uBD1FHmo0LRc
         KSVaDv4gNX34B/VYo44+fxscyL+ykI36radG6Wzc/ty6rSEMr9RJZgNtC1DCg8cvKvro
         CVvQ==
X-Gm-Message-State: ANoB5pmO1bSCo8kv56A1nsP9hTN0Fxq5qwWwQ3jVYiv/KG4hk6TBQ1/U
        oStEseH5hM4wQfot3eFZLR47BGFmsN+ZxmbEpN0BFQ==
X-Google-Smtp-Source: AA0mqf6evJw9RZVu9lTsun7hiHcSvTbrjXEOV0BMWsMx11DYGhST83aW7ShOiqXMIAYrFrAgVJIthiBj3mruk+Ks3Pc=
X-Received: by 2002:a05:6512:b26:b0:4b4:f7aa:4e4 with SMTP id
 w38-20020a0565120b2600b004b4f7aa04e4mr20142462lfu.128.1670605334783; Fri, 09
 Dec 2022 09:02:14 -0800 (PST)
MIME-Version: 1.0
References: <20221209022305.321149-1-joel@joelfernandes.org> <20221209163445.jl4wdnbha47si7h7@offworld>
In-Reply-To: <20221209163445.jl4wdnbha47si7h7@offworld>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 9 Dec 2022 17:02:03 +0000
Message-ID: <CAEXW_YRaicORky1dWFVsRq8WFTpRsZRB5WB=GQi4--+cyEXYbA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] locktorture: Allow non-rtmutex lock types to be boosted
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        connoro@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 9, 2022 at 4:59 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> On Fri, 09 Dec 2022, Joel Fernandes (Google) wrote:
>
> >Currently RT boosting is only done for rtmutex_lock, however with proxy
> >execution, we also have the mutex_lock participating in priorities. To
> >exercise the testing better, add RT boosting to other lock testing types
> >as well, using a new knob (rt_boost).
> >
> >Tested with boot parameters:
> >locktorture.torture_type=mutex_lock
> >locktorture.onoff_interval=1
> >locktorture.nwriters_stress=8
> >locktorture.stutter=0
> >locktorture.rt_boost=1
> >locktorture.rt_boost_factor=1
> >locktorture.nlocks=3
> >
> >For the rtmutex test, rt_boost is always enabled even if disabling is
> >requested.
> >
> >Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >---
> > kernel/locking/locktorture.c | 99 ++++++++++++++++++++----------------
> > 1 file changed, 56 insertions(+), 43 deletions(-)
> >
> >diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> >index bc3557677eed..8968fd65a90d 100644
> >--- a/kernel/locking/locktorture.c
> >+++ b/kernel/locking/locktorture.c
> >@@ -46,6 +46,8 @@ torture_param(int, shutdown_secs, 0, "Shutdown time (j), <= zero to disable.");
> > torture_param(int, stat_interval, 60,
> >            "Number of seconds between stats printk()s");
> > torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
> >+torture_param(int, rt_boost, 2,
> >+              "Do periodic rt-boost. 0=Disable, 1=Only for rt_mutex, 2=For all lock types.");
>
> Sorry if this was already discussed, but what would be the intent of option 2 without PE?

Np, Yes it was discussed. I would like to be, in order to exercise
more scheduler paths. It is not an invasive change in any case. We
have had issues with race conditions in the scheduler paths in the
past, that I would prefer to have in the test.

The scheduler has become incredibly complex over time with new
features such as core scheduling and heisenbugs are showing up. I am
still fighting an old 4.19 kernel issue which is likely scheduler
related, for instance.

Thanks.
